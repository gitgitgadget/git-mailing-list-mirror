From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] submodule update: add `--init-default-path` switch
Date: Thu, 26 May 2016 13:47:29 -0700
Message-ID: <20160526204730.20309-2-sbeller@google.com>
References: <20160526204730.20309-1-sbeller@google.com>
Cc: sunshine@sunshineco.com, gitster@pobox.com, pclouds@gmail.com,
	ramsay@ramsayjones.plus.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 22:47:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b62C1-00058y-93
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 22:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755251AbcEZUri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 16:47:38 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:32879 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754441AbcEZUrh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 16:47:37 -0400
Received: by mail-pa0-f46.google.com with SMTP id xk12so32811821pac.0
        for <git@vger.kernel.org>; Thu, 26 May 2016 13:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=45olQk5vMF4ErnPc+7/owTIoiRiciTKEDhBg8k1Y7cY=;
        b=CDcQsD6lxC84/33Hdtb5V7MdogqQuMKXD85QECDT5g5fCGVW7iUZO88NSJmm5ROKTf
         KCMaKo5Hl8jOMNWDTsNxH+8CQeEeOcr39P+ny9F8RxmngXrMDcZ4V6Uy+GPcQswIfSqv
         LC7sxW0RD61aD8FrutLr9SDHIoV/iwsWcQHbnQ44tdpMWSMBRwlpaGxlk3Ehk7AgWBKd
         PrBhqljyp4kTsbBtjDqp+6m0msfdxeMsb4pr4BPAmXAKKrjiicfC3jimn67t5zbqHISq
         exvFm6fbE38EYBg4dldWw2C1nCg378BEHy8RGwqPkyjrF4cQTh65pg+k3MO/m3WFHhBT
         BnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=45olQk5vMF4ErnPc+7/owTIoiRiciTKEDhBg8k1Y7cY=;
        b=TLzNB5jUbNjrwag1/EbZlSCzE8G/9wUR7h2h/D7ACsH0gw8CQhGDpc9EttHo8uZO+a
         vy2d87qDVndtzPgtgu1fi3T1KHo9Hz3bJxPvYEAObVjcrll5T5s65h/IKvQ4U1Dztxzv
         nNsqqC1Vkj3Wci2nKG3Q1PA2vGsONg/U6/nzoxHyapT90jzbHP8jcACQqP8VxnSZvpwK
         AtRnp3XJk0LQhUa4dpn4rMwzayijDEuCayqqqRKgbfrzpaaVCjkBmMXKw1izonYLUr+I
         OsH+r9UMRGt96N3ogJsyg3LKsHaPx4Nt4t/NooqKMOJBu+tJnsqEKx6FZXnq4aYUliZr
         Xnkg==
X-Gm-Message-State: ALyK8tL10ZRPxMZDW4f4IBxyJfH1aZ8k3gV5S4ptj4Nba/AmzKMRwzbMgNUDz1UhmqNfruk7
X-Received: by 10.66.251.2 with SMTP id zg2mr17130225pac.32.1464295655892;
        Thu, 26 May 2016 13:47:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:f5f9:aea3:ef22:58b3])
        by smtp.gmail.com with ESMTPSA id l67sm8172052pfi.10.2016.05.26.13.47.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 26 May 2016 13:47:35 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc0.2.g145fc64
In-Reply-To: <20160526204730.20309-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295691>

The new switch `--init-default-path` initializes the submodules which are
configured in `submodule.defaultUpdatePath` instead of those given as
command line arguments before updating. In the first implementation this
is made incompatible with further command line arguments as it is
unclear what the user means by

    git submodule update --init --init-default-path <paths>

This new switch allows to record more complex patterns as it saves
retyping them whenever you invoke update.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/config.txt        |  5 ++++
 Documentation/git-submodule.txt | 11 ++++++++-
 git-submodule.sh                | 21 +++++++++++++---
 t/t7400-submodule-basic.sh      | 53 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 86 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 53f00db..beb158d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2794,6 +2794,11 @@ submodule.fetchJobs::
 	in parallel. A value of 0 will give some reasonable default.
 	If unset, it defaults to 1.
 
+submodule.defaultUpdatePath::
+	Specifies a set of submodules to initialize when calling
+	`git submodule --init-default-group` by using the pathspec
+	syntax.
+
 tag.forceSignAnnotated::
 	A boolean to specify whether annotated tags created should be GPG signed.
 	If `--annotate` is specified on the command line, it takes
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 9226c43..000231e 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] deinit [-f|--force] (--all|[--] <path>...)
-'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
+'git submodule' [--quiet] update [--init[-default-path]] [--remote] [-N|--no-fetch]
 	      [-f|--force] [--rebase|--merge] [--reference <repository>]
 	      [--depth <depth>] [--recursive] [--jobs <n>] [--] [<path>...]
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
@@ -193,6 +193,10 @@ If the submodule is not yet initialized, and you just want to use the
 setting as stored in .gitmodules, you can automatically initialize the
 submodule with the `--init` option.
 
+You can configure a set of submodules using pathspec syntax in
+submodule.defaultUpdatePath you can use `--init-default-path` to initialize
+those before updating.
+
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and update any nested submodules within.
 --
@@ -360,6 +364,11 @@ the submodule itself.
 	Initialize all submodules for which "git submodule init" has not been
 	called so far before updating.
 
+--init-default-path::
+	This option is only valid for the update command.
+	Initialize all submodules configured in "`submodule.defaultUpdatePath`"
+	that have not been updated before.
+
 --name::
 	This option is only valid for the add command. It sets the submodule's
 	name to the given string instead of defaulting to its path. The name
diff --git a/git-submodule.sh b/git-submodule.sh
index 5a4dec0..3d12145 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -9,7 +9,7 @@ USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <re
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] (--all| [--] <path>...)
-   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--reference <repository>] [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] update [--init[-default-path]] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--reference <repository>] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
@@ -528,7 +528,12 @@ cmd_update()
 			GIT_QUIET=1
 			;;
 		-i|--init)
-			init=1
+			test -z $init || test $init = by_args || die "$(gettext "Only one of --init or --init-default-path may be used.")"
+			init=by_args
+			;;
+		--init-default-path)
+			test -z $init || test $init = by_config || die "$(gettext "Only one of --init or --init-default-path may be used.")"
+			init=by_config
 			;;
 		--remote)
 			remote=1
@@ -591,7 +596,17 @@ cmd_update()
 
 	if test -n "$init"
 	then
-		cmd_init "--" "$@" || return
+		if test "$init" = "by_config"
+		then
+			if test $# -gt 0
+			then
+				die "$(gettext "path arguments are incompatible with --init-default-path")"
+			fi
+			cmd_init "--" $(git config --get-all submodule.defaultUpdatePath) || return
+		else
+			cmd_init "--" "$@" || return
+		fi
+
 	fi
 
 	{
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 3570f7b..112d86a 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1116,5 +1116,58 @@ test_expect_success 'submodule helper list is not confused by common prefixes' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup superproject with submodules' '
+	mkdir sub1 &&
+	(
+		cd sub1 &&
+		git init &&
+		test_commit test &&
+		test_commit test2
+	) &&
+	mkdir multisuper &&
+	(
+		cd multisuper &&
+		git init &&
+		git submodule add ../sub1 sub0 &&
+		git submodule add ../sub1 sub1 &&
+		git submodule add ../sub1 sub2 &&
+		git submodule add ../sub1 sub3 &&
+		git commit -m "add some submodules"
+	)
+'
+
+cat >expect <<-EOF
+-sub0
+ sub1 (test2)
+ sub2 (test2)
+ sub3 (test2)
+EOF
+
+test_expect_success 'submodule update --init with a specification' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	pwd=$(pwd) &&
+	git clone file://"$pwd"/multisuper multisuper_clone &&
+	(
+		cd multisuper_clone &&
+		git submodule update --init . ":(exclude)sub0" &&
+		git submodule status |cut -c 1,43- >../actual
+	) &&
+	test_cmp expect actual
+'
+
+test_expect_success 'submodule update --init-default-path' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	pwd=$(pwd) &&
+	git clone file://"$pwd"/multisuper multisuper_clone &&
+	(
+		cd multisuper_clone &&
+		git config submodule.defaultUpdatePath "." &&
+		git config --add submodule.defaultUpdatePath ":(exclude)sub0" &&
+		git submodule update --init-default-path &&
+		git submodule status |cut -c 1,43- >../actual &&
+		test_must_fail git submodule update --init-default-path sub0
+	) &&
+	test_cmp expect actual
+'
 
 test_done
-- 
2.9.0.rc0.2.g145fc64
