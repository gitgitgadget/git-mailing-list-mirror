From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/3] submodule update: add `--init-default-path` switch
Date: Fri, 10 Jun 2016 16:07:51 -0700
Message-ID: <20160610230753.11641-2-sbeller@google.com>
References: <20160610230753.11641-1-sbeller@google.com>
Cc: pclouds@gmail.com, sunshine@sunshineco.com,
	ramsay@ramsayjones.plus.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jun 11 01:08:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBVXU-0008Tx-5z
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jun 2016 01:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbcFJXIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 19:08:21 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36163 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbcFJXIT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 19:08:19 -0400
Received: by mail-pf0-f177.google.com with SMTP id t190so27321867pfb.3
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 16:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d5tSdUG+T3jBai5rZ5QUZiKlmiqITmBptQ2ckaysdZg=;
        b=jmg/eGl1aquI+jkc/EGSOrTeJ8e3pX2ZjDJ3S+pW3R7IU8lmQe6ZNCI5rppVmdCee3
         aIQ8vIB2TzXD4cNec82tf35qsn5mNsoTwJpBH+yAipzsLkCyEGiNFa33SOOxs1fZ5qDU
         cpr4kkX7sH4OiUud8yQj6Y2JjBs7hFuF5Ei7RM2iooiCBMjhn0LztatMaQ1SWlD77qzP
         oJ3NQJAYaODfVpxr3hjT3eBKFWS3Xm3jHtLy7jIiboHSWQyqhCroXdZ8r4SWVFLZdjvK
         lfZ/LQNxEwsvtrDSo64IKznfogj76EbD2I0qNOGpk0n1FQLsH4Oak/Yl+5xaX2Q+w6Zk
         WyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d5tSdUG+T3jBai5rZ5QUZiKlmiqITmBptQ2ckaysdZg=;
        b=UvMdTsSue2J8Q1disUvt0MVP56sdAsLvMv6QXrp9mGhYVuot89MLqkAUdtOcqipIYK
         mM65laRUVg5G+b/KrPCsCiahdnxwa8j5CfJZ9RjGEZdsNLAgF1/wtGdO3o68JqvJ0u4P
         l/L5R8kb1mmzj+1KKnv2Bkfr3Lh1IN6liF40mXPR+Uua6f9TA3HMp0G8a6e/llm3rncy
         b7ENc61tfnFBlCwt0Udunj6IQp1VtK1Bwtcsli+9MEBvy+Wk/civw2yf1cK56lA2E6Ov
         JOJJEu2+yYQAKUWSVtPedaf/+91ikbhEKJ1V3dt+HKxhpSLciF+IUi+B2JOQChEyZ9B8
         nFlQ==
X-Gm-Message-State: ALyK8tKIM63VmxFqXeeniVoiewdi0xmPbySbQ3UIOu+xSnLnIVsPfSoqHVjd+ESzaCiihuK5
X-Received: by 10.98.18.9 with SMTP id a9mr4886373pfj.14.1465600098216;
        Fri, 10 Jun 2016 16:08:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:2099:4ff:ce85:68a])
        by smtp.gmail.com with ESMTPSA id e20sm12675849pfk.1.2016.06.10.16.08.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 16:08:17 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.141.g4e46f88
In-Reply-To: <20160610230753.11641-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297083>

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
 Documentation/git-submodule.txt | 13 ++++++++--
 git-submodule.sh                | 23 ++++++++++++++----
 t/t7400-submodule-basic.sh      | 53 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 59d7046..1bc50af 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2735,6 +2735,11 @@ submodule.fetchJobs::
 	in parallel. A value of 0 will give some reasonable default.
 	If unset, it defaults to 1.
 
+submodule.defaultUpdatePath::
+	Specifies a set of submodules to initialize when calling
+	`git submodule --init-default-group` by using the pathspec
+	syntax.
+
 tag.sort::
 	This variable controls the sort ordering of tags when displayed by
 	linkgit:git-tag[1]. Without the "--sort=<value>" option provided, the
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 13adebf..66f1de0 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -13,8 +13,8 @@ SYNOPSIS
 	      [--reference <repository>] [--depth <depth>] [--] <repository> [<path>]
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
-'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
-'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
+'git submodule' [--quiet] deinit [-f|--force] (--all|[--] <path>...)
+'git submodule' [--quiet] update [--init[-default-path]] [--remote] [-N|--no-fetch]
 	      [-f|--force] [--rebase|--merge] [--reference <repository>]
 	      [--depth <depth>] [--recursive] [--jobs <n>] [--] [<path>...]
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
@@ -190,6 +190,10 @@ If the submodule is not yet initialized, and you just want to use the
 setting as stored in .gitmodules, you can automatically initialize the
 submodule with the `--init` option.
 
+You can configure a set of submodules using pathspec syntax in
+submodule.defaultUpdatePath you can use `--init-default-path` to initialize
+those before updating.
+
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and update any nested submodules within.
 --
@@ -353,6 +357,11 @@ the submodule itself.
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
index 07290d0..22984b5 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -8,8 +8,8 @@ dashless=$(basename "$0" | sed -e 's/-/ /')
 USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
-   or: $dashless [--quiet] deinit [-f|--force] [--] <path>...
-   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--reference <repository>] [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] deinit [-f|--force] (--all| [--] <path>...)
+   or: $dashless [--quiet] update [--init[-default-path]] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--reference <repository>] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
@@ -624,7 +624,12 @@ cmd_update()
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
@@ -687,7 +692,17 @@ cmd_update()
 
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
index f99f674..f126fcc 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1078,5 +1078,58 @@ test_expect_success 'submodule helper list is not confused by common prefixes' '
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
2.8.2.141.g4e46f88
