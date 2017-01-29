Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D3191FAD5
	for <e@80x24.org>; Sun, 29 Jan 2017 20:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752157AbdA2UZG (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jan 2017 15:25:06 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36539 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751636AbdA2UYs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jan 2017 15:24:48 -0500
Received: by mail-wm0-f65.google.com with SMTP id r18so1321447wmd.3
        for <git@vger.kernel.org>; Sun, 29 Jan 2017 12:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7o8YahjBJTfW1hthUK5x2JEgwAQOq0Su4sHrMH3LP68=;
        b=kuHzJ264vM8XKaI1K4CG45lV21nA06y+Hk43vR+1QtJELh0HotZLTi/isuMK+9BtOj
         ztwh9UOqkgdR/WlrW+wVp6SmhLivLJULF6ayU95RdmdqNrU/POALNoTcR3DAC5v9RaqK
         yrEwVhG1Gr2dinvhT3beB5n7hE2cYUMc7llS/y2yQTZ2kEcrgQ3BD8d/YqHuD5k8ebuM
         Vx0weGdlCe/61glb8oqQ98qngZ3zZmO3d9X/LGJ6M4C4sHF3QtuDDBLwoIuBrK5Q4fyT
         Cc/B8rYmBpo7QkdXg51KmrT9rfdbhmreFWM4DgO3mRmuBo5P85Fq50ZVhlt0PClhcukP
         /LUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7o8YahjBJTfW1hthUK5x2JEgwAQOq0Su4sHrMH3LP68=;
        b=Ri/ewrkwoj1UKZP/GA39gOvFfaNKEDVW3MrtUyp0RnKsgM1JIiKdDiTKabkAL6EaO+
         uqs/xLzAjqVnVzIGBH1mvB5aRsTa1SvAh1w19d8/mqiQSLREKp4oXozk9YqsKvfeQ7ZW
         y0rLbebIB3rY4245bn/BYrGumUkZuoKURqDaMi930VUliWS53XIl1SyB1DJhxo2nmCy1
         Ke27RGe7rXgV5nsJgLYoTaI+PYqU33YwIA70Y5jEgZPwHtDiqfGaZPaBoRjhTHMpvdBP
         vgwCJ041+ypVtzZF3zYCbpWlAn1gqvem7INTGSB3+ciI3e2ASjnZSDHuF1BcMrIlkess
         SCrQ==
X-Gm-Message-State: AIkVDXJrWy6hziKkjAN0hLzhCejlBcLiWV88Pci5FcYN1q1dtH7Q+7koEh4gzIPi+I0nRw==
X-Received: by 10.223.154.132 with SMTP id a4mr15608448wrc.188.1485720952605;
        Sun, 29 Jan 2017 12:15:52 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id t123sm15258978wmt.8.2017.01.29.12.15.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jan 2017 12:15:52 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Stephan Beyer <s-beyer@gmx.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98yvind=20A=20=2E=20Holm?= <sunny@sunbase.org>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 2/4] stash: introduce push verb
Date:   Sun, 29 Jan 2017 20:16:02 +0000
Message-Id: <20170129201604.30445-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.11.0.297.g9a2118ac0b.dirty
In-Reply-To: <20170129201604.30445-1-t.gummerer@gmail.com>
References: <20170121200804.19009-1-t.gummerer@gmail.com>
 <20170129201604.30445-1-t.gummerer@gmail.com>
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
 git-stash.sh     | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 t/t3903-stash.sh |  9 +++++++
 2 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 10c284d1aa..8528708f61 100755
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
@@ -291,6 +294,69 @@ save_stash () {
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
@@ -617,6 +683,10 @@ save)
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
2.11.0.297.g9a2118ac0b.dirty

