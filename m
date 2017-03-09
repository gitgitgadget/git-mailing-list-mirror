Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA07D20135
	for <e@80x24.org>; Thu,  9 Mar 2017 01:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932125AbdCIBd0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 20:33:26 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34737 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754781AbdCIBdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 20:33:25 -0500
Received: by mail-pf0-f170.google.com with SMTP id v190so21860102pfb.1
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 17:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0gTknGKPlGFB/yL1VZVccwIGWKXX77v52gEsTb65Lq4=;
        b=XsRsamcltpWnIKqAcn03UJCfg6NDWpNCC4luzrjsMzOnsZnbZW7kaDr1THtp6WJ0Je
         GVz/I9xUeLwkhYtgZb02qmrR+IChwM0D23/AKlSoU0y5LVn0qLdsAQ8n3Lzi7a5x+P+p
         s740vdVyQwEIjwA9kA5rQzHAowO5l0r88+xwN5g6Ic3ZXcG8FoKFZ0Q/9lz5FNf0OQyf
         yw33mc+Vsj+jI76TMgWWE7RHUbXo+TKCT8wz7Gi2n/RA9eAnf1+jLMhLPPTe/Q5ckdek
         No5cZvMRe/Mi39nqwCXWX62+evZEPB2FK+ma/uymjwu+xeAPvZuGN6SUBKEvcTJhywdS
         J/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0gTknGKPlGFB/yL1VZVccwIGWKXX77v52gEsTb65Lq4=;
        b=GGlx60ClKy9Gut6Zd+C6foMwdjXye91iSi9340ME5ughP5m2hQ8fXr5me0M7563GqM
         gTwtUyxH5V6pcnDDmDQi4cWsyH4v8sKdNqsTFpujgINqb+U4wgZLbIgvCmOr2LtRLGCz
         EswUoO+ojaoWdSWlcuPM7gM3SqSb/mExMXloc6W0YjeDXUdWI5AS7swyHVi1+mxG5qjM
         4PYdhOQwlxCu9WE/LdTkNk9U6aIgblCwKA5/yI/MaMX5K6gsGxVTUUQrSbVC7aJPayG8
         JaKifxiNsYq4T8rcEbPSv+x0WjBAIyLVUVd2vpveMgL6Oey1A2HbAmSMjHI8cQ6UT5TM
         zFQA==
X-Gm-Message-State: AMke39kQKxvQr/zfsVMNwW7I1zllq5jxzzSVPPw5s+9ssXIewb3nCxRoB0xjCihO4kfa6ZP+
X-Received: by 10.99.8.133 with SMTP id 127mr10441003pgi.117.1489022644154;
        Wed, 08 Mar 2017 17:24:04 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id l71sm8479948pga.7.2017.03.08.17.24.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Mar 2017 17:24:03 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v2 07/11] submodule update: add `--init-active` switch
Date:   Wed,  8 Mar 2017 17:23:41 -0800
Message-Id: <20170309012345.180702-8-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.246.ga2ecc84866-goog
In-Reply-To: <20170309012345.180702-1-bmwill@google.com>
References: <20170223234728.164111-1-bmwill@google.com>
 <20170309012345.180702-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new switch `--init-active` initializes the submodules which are
configured in `submodule.active` instead of those given as
command line arguments before updating. In the first implementation this
is made incompatible with further command line arguments as it is
unclear what the user means by

    git submodule update --init --init-active <paths>

This new switch allows users to record more complex patterns as it saves
retyping them whenever you invoke update.

Based on a patch by Stefan Beller <sbeller@google.com>

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/git-submodule.txt | 11 ++++++++++-
 git-submodule.sh                | 21 ++++++++++++++++++---
 t/t7400-submodule-basic.sh      | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 918bd1d1b..626b9760a 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] deinit [-f|--force] (--all|[--] <path>...)
-'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
+'git submodule' [--quiet] update [--init[-active]] [--remote] [-N|--no-fetch]
 	      [--[no-]recommend-shallow] [-f|--force] [--rebase|--merge]
 	      [--reference <repository>] [--depth <depth>] [--recursive]
 	      [--jobs <n>] [--] [<path>...]
@@ -195,6 +195,10 @@ If the submodule is not yet initialized, and you just want to use the
 setting as stored in .gitmodules, you can automatically initialize the
 submodule with the `--init` option.
 
+You can configure a set of submodules using pathspec syntax in
+submodule.active you can use `--init-active` to initialize
+those before updating.
+
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and update any nested submodules within.
 --
@@ -378,6 +382,11 @@ the submodule itself.
 	Initialize all submodules for which "git submodule init" has not been
 	called so far before updating.
 
+--init-active::
+	This option is only valid for the update command.
+	Initialize all submodules configured in "`submodule.active`"
+	that have not been updated before.
+
 --name::
 	This option is only valid for the add command. It sets the submodule's
 	name to the given string instead of defaulting to its path. The name
diff --git a/git-submodule.sh b/git-submodule.sh
index 7ed1aaba3..43a393d7e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -9,7 +9,7 @@ USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <re
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] (--all| [--] <path>...)
-   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] update [--init[-active]] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
@@ -499,7 +499,12 @@ cmd_update()
 			progress="--progress"
 			;;
 		-i|--init)
-			init=1
+			test -z $init || test $init = by_args || die "$(gettext "Only one of --init or --init-active may be used.")"
+			init=by_args
+			;;
+		--init-active)
+			test -z $init || test $init = by_config || die "$(gettext "Only one of --init or --init-active may be used.")"
+			init=by_config
 			;;
 		--remote)
 			remote=1
@@ -568,7 +573,17 @@ cmd_update()
 
 	if test -n "$init"
 	then
-		cmd_init "--" "$@" || return
+		if test "$init" = "by_config"
+		then
+			if test $# -gt 0
+			then
+				die "$(gettext "path arguments are incompatible with --init-active")"
+			fi
+			cmd_init "--" $(git config --get-all submodule.active) || return
+		else
+			cmd_init "--" "$@" || return
+		fi
+
 	fi
 
 	{
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index b77cce8e4..f5df0a5b4 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1116,5 +1116,44 @@ test_expect_success 'submodule helper list is not confused by common prefixes' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup superproject with submodules' '
+	git init sub1 &&
+	test_commit -C sub1 test &&
+	test_commit -C sub1 test2 &&
+	git init multisuper &&
+	git -C multisuper submodule add ../sub1 sub0 &&
+	git -C multisuper submodule add ../sub1 sub1 &&
+	git -C multisuper submodule add ../sub1 sub2 &&
+	git -C multisuper submodule add ../sub1 sub3 &&
+	git -C multisuper commit -m "add some submodules"
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
+	git -C multisuper_clone submodule update --init . ":(exclude)sub0" &&
+	git -C multisuper_clone submodule status |cut -c 1,43- >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'submodule update --init-active' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	pwd=$(pwd) &&
+	git clone file://"$pwd"/multisuper multisuper_clone &&
+	git -C multisuper_clone config submodule.active "." &&
+	git -C multisuper_clone config --add submodule.active ":(exclude)sub0" &&
+	git -C multisuper_clone submodule update --init-active &&
+	git -C multisuper_clone submodule status |cut -c 1,43- >actual &&
+	test_must_fail git -C multisuper_clone submodule update --init-active sub0 &&
+	test_cmp expect actual
+'
 
 test_done
-- 
2.12.0.246.ga2ecc84866-goog

