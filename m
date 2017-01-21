Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76DD21F89C
	for <e@80x24.org>; Sat, 21 Jan 2017 20:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750894AbdAUUIE (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jan 2017 15:08:04 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35081 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbdAUUH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2017 15:07:59 -0500
Received: by mail-wm0-f68.google.com with SMTP id d140so15602420wmd.2
        for <git@vger.kernel.org>; Sat, 21 Jan 2017 12:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uCDotQ/VrpkABgKgCAP4nlU5U56WuMp9aJKCIIk3vbY=;
        b=kNT8xU4aQt8/DSpYY1VWtS5fGWmONLSurZSbvu9NLRtwDCk+ed9631f0plkOWa1GWz
         wW8uW3ox62uTRzllKpB5tGr4cOU0M9bX9zzuKZ7+3l3mgT61VPS6wqrZt2keobLE+nmC
         fAmgiTghbLy6jaM6XXjFNr5iSoyoJ/WxFMMcA0pQ05csKbD2s90Ce6lJEokgCnUWgGzD
         lHJb2PCRyhvWbsSLTVg1eT4mI8tynK5b+l5g1teutiotbJQ3+ZoqbsjTlgPA20VwPORh
         gnAqrPMhNgodo8mGEyYpeFC9iUbgZIISkMx53d1dEbZYjrBhHcunCCTGN8Yy/Fgotl7o
         fA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uCDotQ/VrpkABgKgCAP4nlU5U56WuMp9aJKCIIk3vbY=;
        b=ag5BzP0rnYtlz1Jaf040+Kp8XQbcuQlDXTt/whWTFNRmury3ub4FRf/z5LPYp9jbM7
         9EvZQYM2Y5tE+p4PpuI5tbY7uGKIZFuXcoBH7+emI/zmdziBQt+no0m4OyJkqPUKOrak
         IzPtqdVta9W5R5IB4w5vHppWU/Gfjhw7ntg/ArB0DY+X6L0UA/PILHLjULLGh25iY/Ss
         oTVGTDMbVnXnwrtG4ifugkFE9NEzrYUiLzGcyejmmhKi6ToKMeRuHklfNr1s9i0ux6dw
         OuN6RSlLemhKxNUfYX6kzuQX7Dv7Vf5HQ92q/phnbinHJblwP9UXDeILGpl4ejORK/tv
         92FQ==
X-Gm-Message-State: AIkVDXI82rVGF3lXygASjyiBJI6542kF6GaUiG3wXjkrRhNYrFEzSWlfvRjSV3MWFI4Dng==
X-Received: by 10.223.139.152 with SMTP id o24mr16892256wra.122.1485029277807;
        Sat, 21 Jan 2017 12:07:57 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id y65sm12405003wmb.5.2017.01.21.12.07.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Jan 2017 12:07:57 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Stephan Beyer <s-beyer@gmx.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 2/3] stash: introduce push verb
Date:   Sat, 21 Jan 2017 20:08:03 +0000
Message-Id: <20170121200804.19009-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c
In-Reply-To: <20170121200804.19009-1-t.gummerer@gmail.com>
References: <20170121200804.19009-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a new git stash push verb in addition to git stash save.  The
push verb is used to transition from the current command line arguments
to a more conventional way, in which the message is specified after a -m
parameter instead of being a positional argument.

This allows introducing a new filename argument to stash single files.
Using that as a positional argument is much more consistent with the
rest of git, than using the positional argument for the message.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 git-stash.sh     | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 t/t3903-stash.sh |  9 +++++++
 2 files changed, 87 insertions(+), 3 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 10c284d1aa..d6b4ae3290 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -189,10 +189,11 @@ store_stash () {
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
@@ -216,6 +217,10 @@ save_stash () {
 		-a|--all)
 			untracked=all
 			;;
+		-m|--message)
+			shift
+			stash_msg=$1
+			;;
 		--help)
 			show_help
 			;;
@@ -251,8 +256,6 @@ save_stash () {
 		die "$(gettext "Can't use --patch and --include-untracked or --all at the same time")"
 	fi
 
-	stash_msg="$*"
-
 	git update-index -q --refresh
 	if no_changes
 	then
@@ -291,6 +294,74 @@ save_stash () {
 	fi
 }
 
+save_stash () {
+	push_options=
+	while test $# != 0
+	do
+		case "$1" in
+		-k|--keep-index)
+			push_options="-k $push_options"
+			;;
+		--no-keep-index)
+			push_options="--no-keep-index $push_options"
+			;;
+		-p|--patch)
+			push_options="-p $push_options"
+			;;
+		-q|--quiet)
+			push_options="-q $push_options"
+			;;
+		-u|--include-untracked)
+			push_options="-u $push_options"
+			;;
+		-a|--all)
+			push_options="-a $push_options"
+			;;
+		--help)
+			show_help
+			;;
+		--)
+			shift
+			break
+			;;
+		-*)
+			option="$1"
+			# TRANSLATORS: $option is an invalid option, like
+			# `--blah-blah'. The 7 spaces at the beginning of the
+			# second line correspond to "error: ". So you should line
+			# up the second line with however many characters the
+			# translation of "error: " takes in your language. E.g. in
+			# English this is:
+			#
+			#    $ git stash save --blah-blah 2>&1 | head -n 2
+			#    error: unknown option for 'stash save': --blah-blah
+			#           To provide a message, use git stash save -- '--blah-blah'
+			eval_gettextln "error: unknown option for 'stash save': \$option
+       To provide a message, use git stash save -- '\$option'"
+			usage
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done
+
+	# if test -n "$patch_mode" && test -n "$untracked"
+	# then
+	# 	die "$(gettext "Can't use --patch and --include-untracked or --all at the same time")"
+	# fi
+
+	stash_msg="$*"
+
+	if test -z stash_msg
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
@@ -617,6 +688,10 @@ save)
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
index 2de3e18ce6..0171b824c9 100755
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
+	git stash list | head -n 1 >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.11.0.483.g087da7b7c

