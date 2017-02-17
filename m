Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 255AE201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 22:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964789AbdBQWlK (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 17:41:10 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33234 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935084AbdBQWlI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 17:41:08 -0500
Received: by mail-wm0-f67.google.com with SMTP id v77so4797595wmv.0
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 14:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=67pCPJjxqEva/R+K844Kc6457/1cAW19MowCPsxlKSs=;
        b=BUll7yCJYOI8KV8OW1dGtXOyxkswq2kDD4dT1x361mTYqMJGAx5rr1tVsYjnKRsVKQ
         wMP8EPzueYYdmA/ZygpMp0F9pFCLv1VG5MmrlcYIBsrJ7mpI/6GK1pd8wyEh+IN8kbBk
         9qdloW02DAbmxYf9XjK9nvtaTZKxUh3zfbX3MWGZBjuOQ3xoPq5IQdQk+Pee90Sph3mV
         dEfPfoy2omvbFG1N0+of+eKRCsdi0jmD4K8ulL/uEXtWnRVOiKYmWOe27qeGZRlbvJep
         yJcKV7Xx9luiEz4m0fZKxCvjSp19YPBMpYJLPifV6rrb/bYZKSFFvAorCz4MT+JKvLtP
         rklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=67pCPJjxqEva/R+K844Kc6457/1cAW19MowCPsxlKSs=;
        b=VwR8uzqMrxqc1yBSaBTGOhScryFxB0aQpCd8laYZyQMVXen+a+6DyXJBTP/SCT7tAB
         rP5n2vdFtfoETvYozacp+eOU3XZnx/+wgC2y79Q1Gw/R1+YJ18hZy6OzjZ5uqrHSy/16
         6BOAiec8iNmSyPwtxAkUOr60JbaYtj+4d3dV9u+rNlnCl+bOrBdFyEslAHU/NzFqAd6f
         zq2+M5xV/1do6HumNkJ/zI/Ykxhqb3VdVl1Nk3lFzeNwoMxL4nZHm9e6l3GrCF3hTR8M
         RdwEPG0GXKUnOWptqqvDEKTulroGy7KgXlTiRva9W70D+M0OSCXgNOCjqMcs7e2JtpJz
         EV5A==
X-Gm-Message-State: AMke39l8ZQe4/4TN7asFA0cct4KVb37X6ML5I7vbpHo/Mwp+kZ7FjaiMtgigXaRuKDCHsQ==
X-Received: by 10.28.228.87 with SMTP id b84mr3450414wmh.0.1487371266037;
        Fri, 17 Feb 2017 14:41:06 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id a14sm1264465wrc.66.2017.02.17.14.41.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Feb 2017 14:41:05 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98yvind=20A=20=2E=20Holm?= <sunny@sunbase.org>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v5 1/6] stash: introduce push verb
Date:   Fri, 17 Feb 2017 22:41:36 +0000
Message-Id: <20170217224141.19183-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.11.0.301.g27b9849079.dirty
In-Reply-To: <20170217224141.19183-1-t.gummerer@gmail.com>
References: <20170212215420.16701-1-t.gummerer@gmail.com>
 <20170217224141.19183-1-t.gummerer@gmail.com>
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
 git-stash.sh     | 46 +++++++++++++++++++++++++++++++++++++++++++---
 t/t3903-stash.sh |  9 +++++++++
 2 files changed, 52 insertions(+), 3 deletions(-)

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
2.11.0.301.g27b9849079.dirty

