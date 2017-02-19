Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCF82201A9
	for <e@80x24.org>; Sun, 19 Feb 2017 11:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751517AbdBSLL1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 06:11:27 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35533 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751452AbdBSLL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2017 06:11:27 -0500
Received: by mail-wm0-f65.google.com with SMTP id u63so9572408wmu.2
        for <git@vger.kernel.org>; Sun, 19 Feb 2017 03:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MnuLIZBK5944LOHR9lbBjaAL14jlx9++SiemQJn1Qc4=;
        b=vHJDjntMCgS4hOQpTfsRds6s6RaFsTDduhwmVh9KxwSAvowpqpShmGHaEdqA2QBsCF
         QZ/z6D55Ke1WcM6NRZoofsVZEEtKsbSHX9oUqjS1ChsjXpm88NKDv/+0CuK+x9PlT1v2
         GAY9e+7rbNbJS97wLx7zDZTOLktggixFoVaCGkLis/ycmo6JNwWOFCX2zXGtQxPFSyD8
         a/hZsGzbynEoxluJl6GNDRUy6T3wW1GuspSExq2E1fk11MmyNm5vafDabW8nqhNiOX3T
         7rT2ls9YYDS0U1bu5Qe6yFh6rKNnwAqEVlANCq75ofJqDXM3qdvSZHy6Xn7p3+0wx6NG
         tJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MnuLIZBK5944LOHR9lbBjaAL14jlx9++SiemQJn1Qc4=;
        b=pWZBR/5La3JctQsMZCv0ao3vyPYscJcQSmkessVI56ybtACmZfsdHokK6+drPGygE6
         gsaR3RVgFe1Zw2JFB6VLpIJJ7C/Cp94Qhr5tz0nIkzYC+KZWs3kPt5sxbO9aO0sEFN3C
         COwwYy6beVMiHz+p9y6oiyaxeGg5H8YAIb/0o0F4zq8daIvauMXmRt3duIzyiU38r/SH
         Pju1EQOu5Tchm7Bz6ztGn9+xwPSMuQ+A6FdE7HIMFd1gN7fUvDdIwMLJdUvGfIaHSKQi
         0WUx5ent6gcuod1ZMm0yXizlOGI5EPHvv+6CAm6lOdxQMEwBl0MNkuD2LYeLJDzOnAYQ
         5CVQ==
X-Gm-Message-State: AMke39mVcRrdRvnluMT+17+A3mRpUME7+c6Gb//ZZ4Lq2FtwZeXZGSuVci00L9BdMt7jSQ==
X-Received: by 10.28.182.6 with SMTP id g6mr7195206wmf.11.1487502188094;
        Sun, 19 Feb 2017 03:03:08 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id p17sm3144831wrc.3.2017.02.19.03.03.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Feb 2017 03:03:07 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98yvind=20A=2E=20Holm?= <sunny@sunbase.org>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v6 1/6] stash: introduce push verb
Date:   Sun, 19 Feb 2017 11:03:08 +0000
Message-Id: <20170219110313.24070-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.12.0.rc2.399.g0ca89a282
In-Reply-To: <20170219110313.24070-1-t.gummerer@gmail.com>
References: <20170217224141.19183-1-t.gummerer@gmail.com>
 <20170219110313.24070-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a new git stash push verb in addition to git stash save.  The
push verb is used to transition from the current command line arguments
to a more conventional way, in which the message is given as an argument
to the -m option.

This allows us to have pathspecs at the end of the command line
arguments like other Git commands do, so that the user can say which
subset of paths to stash (and leave others behind).

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-stash.txt |  3 +++
 git-stash.sh                | 46 ++++++++++++++++++++++++++++++++++++++++++---
 t/t3903-stash.sh            |  9 +++++++++
 3 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 2e9cef06e6..0f602ea0c8 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -15,6 +15,8 @@ SYNOPSIS
 'git stash' branch <branchname> [<stash>]
 'git stash' [save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
 	     [-u|--include-untracked] [-a|--all] [<message>]]
+'git stash' push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
+	     [-u|--include-untracked] [-a|--all] [-m|--message <message>]]
 'git stash' clear
 'git stash' create [<message>]
 'git stash' store [-m|--message <message>] [-q|--quiet] <commit>
@@ -46,6 +48,7 @@ OPTIONS
 -------
 
 save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
+push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>]::
 
 	Save your local modifications to a new 'stash', and run `git reset
 	--hard` to revert them.  The <message> part is optional and gives
diff --git a/git-stash.sh b/git-stash.sh
index 10c284d1aa..8365ebba2a 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -9,6 +9,8 @@ USAGE="list [<options>]
    or: $dashless branch <branchname> [<stash>]
    or: $dashless [save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
 		       [-u|--include-untracked] [-a|--all] [<message>]]
+   or: $dashless push [--patch] [-k|--[no-]keep-index] [-q|--quiet]
+		      [-u|--include-untracked] [-a|--all] [-m <message>]
    or: $dashless clear"
 
 SUBDIRECTORY_OK=Yes
@@ -189,10 +191,11 @@ store_stash () {
 	return $ret
 }
 
-save_stash () {
+push_stash () {
 	keep_index=
 	patch_mode=
 	untracked=
+	stash_msg=
 	while test $# != 0
 	do
 		case "$1" in
@@ -216,6 +219,11 @@ save_stash () {
 		-a|--all)
 			untracked=all
 			;;
+		-m|--message)
+			shift
+			test -z ${1+x} && usage
+			stash_msg=$1
+			;;
 		--help)
 			show_help
 			;;
@@ -251,8 +259,6 @@ save_stash () {
 		die "$(gettext "Can't use --patch and --include-untracked or --all at the same time")"
 	fi
 
-	stash_msg="$*"
-
 	git update-index -q --refresh
 	if no_changes
 	then
@@ -291,6 +297,36 @@ save_stash () {
 	fi
 }
 
+save_stash () {
+	push_options=
+	while test $# != 0
+	do
+		case "$1" in
+		--)
+			shift
+			break
+			;;
+		-*)
+			# pass all options through to push_stash
+			push_options="$push_options $1"
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done
+
+	stash_msg="$*"
+
+	if test -z "$stash_msg"
+	then
+		push_stash $push_options
+	else
+		push_stash $push_options -m "$stash_msg"
+	fi
+}
+
 have_stash () {
 	git rev-parse --verify --quiet $ref_stash >/dev/null
 }
@@ -617,6 +653,10 @@ save)
 	shift
 	save_stash "$@"
 	;;
+push)
+	shift
+	push_stash "$@"
+	;;
 apply)
 	shift
 	apply_stash "$@"
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 2de3e18ce6..3577115807 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -775,4 +775,13 @@ test_expect_success 'stash is not confused by partial renames' '
 	test_path_is_missing file
 '
 
+test_expect_success 'push -m shows right message' '
+	>foo &&
+	git add foo &&
+	git stash push -m "test message" &&
+	echo "stash@{0}: On master: test message" >expect &&
+	git stash list -1 >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.12.0.rc2.399.g0ca89a282

