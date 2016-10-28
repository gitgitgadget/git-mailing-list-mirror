Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F35962035F
	for <e@80x24.org>; Fri, 28 Oct 2016 18:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034376AbcJ1S4g (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:56:36 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35451 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034294AbcJ1S42 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 14:56:28 -0400
Received: by mail-pf0-f182.google.com with SMTP id s8so41516951pfj.2
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 11:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r/LwWzl2jbskqp2RtwoEsP8keltcsKPqp3WdtKqzZjs=;
        b=UBCFrI8LaPBEN27fHonHoW2LJvcyzkPFkjtPPpNRtZ03emqktFUsV0XvNiaRrDdXia
         hDXDGD4E2fGlAuf04URekpnlFgJCm35Qiceuy6OdRFYO1J2AMVjx3WHktHGIvHK8MYSY
         QV8kqb7SuKlckpKE6iNDaRvZ78eTlfcTV7pj8JVFej3PG8FqSYWCxcrKLhh0+eIcIF2O
         wzHiI62MT/AFeixAmIzV6FIBRCiepqcrKLuKFwlc4HeLqpsRwvMugWMjqKEVEqTsqPPJ
         aOg4FvXOusfUF4PvNh0QRQYbcHjJ+QNLc8/a3195y9x2xYuOtzGQTDLJmk39nbVB/0CE
         4Jjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r/LwWzl2jbskqp2RtwoEsP8keltcsKPqp3WdtKqzZjs=;
        b=gaQgsKbHP9xUsAEZLYhvFpOlfNqau+8m1qiZxat03Oz2di5ah2rCPBifUv0T1U+s4b
         xFFJrV6iSzmU1ItpYlKqEndMr1Fuq0Dp5m5LBUjWI9ahevo+pueixJiZCPfmSEO64fQp
         R0NB4AJeJ4L4lsuI0aw2lpWcuLJZXStylVIdOu3iSVDCf8z4zrooGcF0I2maZUBVpmnE
         7b36XiYI3NNhV5hONbrnplCVmPcwhcm6RR+KpzEVM6uH+FoMvDz4Tpdge1Uo47I6bNPX
         zjYJV1OtZP5bAGvqR/Qwyc3/HI4ROC2CDbnoTaS09BEQhO3i+WOrp1sgitrWkIZHRuPu
         CvIw==
X-Gm-Message-State: ABUngvcWHixO0bq5RT4Y8RLV/U+P6SDmzinBLbqiKPLGltIgXkheulZV9Ti2VSem4fhmD/so
X-Received: by 10.99.171.3 with SMTP id p3mr22695854pgf.119.1477680987746;
        Fri, 28 Oct 2016 11:56:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:91ed:bb99:5319:17e9])
        by smtp.gmail.com with ESMTPSA id xs10sm20613171pac.24.2016.10.28.11.56.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 11:56:27 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 34/36] submodule update: add `--init-default-path` switch
Date:   Fri, 28 Oct 2016 11:55:00 -0700
Message-Id: <20161028185502.8789-35-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.714.ge3da0db
In-Reply-To: <20161028185502.8789-1-sbeller@google.com>
References: <20161028185502.8789-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new switch `--init-default-path` initializes the submodules which are
configured in `submodule.defaultUpdatePath` instead of those given as
command line arguments before updating. In the first implementation this
is made incompatible with further command line arguments as it is
unclear what the user means by

    git submodule update --init --init-default-path <paths>

This new switch allows to record more complex patterns as it saves
retyping them whenever you invoke update.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt        |  5 ++++
 Documentation/git-submodule.txt | 17 +++++++++----
 git-submodule.sh                | 21 +++++++++++++---
 t/t7400-submodule-basic.sh      | 53 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 27069ac032..72901ef90e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2886,6 +2886,11 @@ submodule.alternateErrorStrategy
 	as computed via `submodule.alternateLocation`. Possible values are
 	`ignore`, `info`, `die`. Default is `die`.
 
+submodule.defaultUpdatePath::
+	Specifies a set of submodules to initialize when calling
+	`git submodule --init-default-group` by using the pathspec
+	syntax.
+
 tag.forceSignAnnotated::
 	A boolean to specify whether annotated tags created should be GPG signed.
 	If `--annotate` is specified on the command line, it takes
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index d841573475..98a6d36c78 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -14,10 +14,10 @@ SYNOPSIS
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] deinit [-f|--force] (--all|[--] <path>...)
-'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
-	      [--[no-]recommend-shallow] [-f|--force] [--rebase|--merge]
-	      [--reference <repository>] [--depth <depth>] [--recursive]
-	      [--jobs <n>] [--] [<path>...]
+'git submodule' [--quiet] update [--init[-default-path]] [--remote] [-N|--no-fetch]
+	      [--[no-]recommend-shallow]
+	      [-f|--force] [--rebase|--merge] [--reference <repository>]
+	      [--depth <depth>] [--recursive] [--jobs <n>] [--] [<path>...]
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
 	      [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
@@ -194,6 +194,10 @@ If the submodule is not yet initialized, and you just want to use the
 setting as stored in .gitmodules, you can automatically initialize the
 submodule with the `--init` option.
 
+You can configure a set of submodules using pathspec syntax in
+submodule.defaultUpdatePath you can use `--init-default-path` to initialize
+those before updating.
+
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and update any nested submodules within.
 --
@@ -363,6 +367,11 @@ the submodule itself.
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
index a024a135d6..334cecc62d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -9,7 +9,7 @@ USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <re
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] (--all| [--] <path>...)
-   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] update [--init[-default-path]] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
@@ -503,7 +503,12 @@ cmd_update()
 			progress="--progress"
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
@@ -572,7 +577,17 @@ cmd_update()
 
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
index b77cce8e40..4699b1c532 100755
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
2.10.1.714.ge3da0db

