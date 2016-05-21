From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] submodule update: add `--init-default-path` switch
Date: Fri, 20 May 2016 17:28:10 -0700
Message-ID: <20160521002811.24656-2-sbeller@google.com>
References: <20160521002811.24656-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Sat May 21 02:28:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3umO-0001EE-7N
	for gcvg-git-2@plane.gmane.org; Sat, 21 May 2016 02:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbcEUA2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 20:28:22 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:32993 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbcEUA2V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 20:28:21 -0400
Received: by mail-pa0-f54.google.com with SMTP id xk12so44068492pac.0
        for <git@vger.kernel.org>; Fri, 20 May 2016 17:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L/Ka6exrV2ZiI0jeX6dUbFNpigbn3Cs3gYOPwZmEeAI=;
        b=ISd7qqTGdkx33KrURFsCRLjXidR3WZDt4M1dGmP3vqq5ViE1VGN66p7BSTs8qjCyc8
         FE3/D4IyR4EIz8YGmuW0iKxZDSCBvgBLD3hdli6x/6QWQzO/NNtZXUngmphx5+CgaMJB
         6/5slDtqXFSJVmX+ByXBTl8rwdcPM68F4yzuMkt41u16O4T1fn8DTLQM9EYffHMwxD2S
         00UPZbCLohfih5TIIsave3cWRf/5DowYsQ4X4WYQZlK7Gjv2DJ9QdtzVcf7UV50bZZD5
         1vOrcK+2PlVQmh00DeCVXQr7x7c0nA3DeCazXoveI8aV+kcYJ6k6F7X2pkNYuJXKnQGe
         9rXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L/Ka6exrV2ZiI0jeX6dUbFNpigbn3Cs3gYOPwZmEeAI=;
        b=YI25OhX81kHz1JTcAAmnMiOdGReyIYlij8RIpT4c7Dg48bfLcXjJoQzbfYWaeyrHMq
         gaEHJXt+rn4n2cW4rxLJNyTXVN/4OYcn3ORKX0AOOxFO+CPaY6XdntPbJM4sOSZdv6cz
         vwIiIY1SmIgN/tedMzwoTD3xQ4ONIqcVOgILpep8GQh/Dg+G/nmvJ6rJbCTCekMN+qCi
         yZ2RkdVWKhH11pA+hErcu4rOKXVLoKbMpMMk+pR6oHAC8Lltt5jTcQN0IbJ2FV8hSWDL
         MSS8zWcT6ynDAKKBFDhhCwBGQoSFzyNeEKXETxgItVAP2nlkEWoUr9u8qTmZvRtSVnYc
         do8A==
X-Gm-Message-State: AOPr4FU+A8arnzu+mJssRLcKTLWfeUF39tEEGxUd/mTR/iO1nU4JKLspPExKi1xl/FuTenH1
X-Received: by 10.66.55.101 with SMTP id r5mr9002247pap.146.1463790499871;
        Fri, 20 May 2016 17:28:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:104:6ffe:257d:9a11])
        by smtp.gmail.com with ESMTPSA id q20sm29679056pfa.90.2016.05.20.17.28.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 20 May 2016 17:28:19 -0700 (PDT)
X-Mailer: git-send-email 2.8.3.396.g3aebe0e
In-Reply-To: <20160521002811.24656-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295223>

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
index e4cd291..121b236 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2786,6 +2786,11 @@ submodule.fetchJobs::
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
index 3570f7b..4173c72 100755
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
+		test_commit test
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
2.8.3.395.ga2acc22.dirty
