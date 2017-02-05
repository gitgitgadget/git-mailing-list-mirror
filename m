Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0064D1FAF4
	for <e@80x24.org>; Sun,  5 Feb 2017 20:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753530AbdBEU0X (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Feb 2017 15:26:23 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35912 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752279AbdBEU0V (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2017 15:26:21 -0500
Received: by mail-wm0-f67.google.com with SMTP id r18so17899115wmd.3
        for <git@vger.kernel.org>; Sun, 05 Feb 2017 12:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iSlKADuSQnz/LQA6xoVd2CIGkkdY6A0XWt1SVUG3sO0=;
        b=mTtXGUEyY3lHKm4PK3X4bM7d9kYmQbw9VEVu/G2TZ8Kji7ZJLIfYEEa70iDrnln/B6
         j9FY8gX3ek6ocmj/ffsZpJHMM7Fjn8S1Fiok1raCpfJT58rGe1QK01P9MwF7Joi20dAu
         Clts0vbdeTKycP6CGirQwgSK+dhERoEy3JLGu7oJtNE5EWpmFkd8yCwvP4beqO+inRG+
         F0MM63fSPEv3iSLhT8+6J2FzLX8Hl0FLF5MURlkHozA9T9ARj4uxljmcRepUH1w+Z0gM
         jeDU2Qkn3VI5GOB5LsxvrPbU2LlPcXl9RcFNRMI1JEnT2W/bbfLRfCwgFl0HmRvKjAf5
         3rpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iSlKADuSQnz/LQA6xoVd2CIGkkdY6A0XWt1SVUG3sO0=;
        b=HJoUTU0ljaMiRD4oESDWd1Mf7RKjnrE5qIQbzBpt2jolUO5kHcrwoQMrY/Ufebjmq6
         LIK6gICEBo5YHtzdvfOHvVFLbPdrqO68LyHOweVbb/Ow78wZWY0HpOBBsJI32X9nMk8F
         ZXHqIqdKdVT3lh8+PM8tvmRU8QufjDJqrhJph66vpIG0xlYg9/QHBzC8yVyac00e6FWM
         0/raUf9LEoKZnG4v76+jLAsKVeSjNwEXnO1LccWkvXrOgYh9XSH5k2QGJo+CoA+b4Ekj
         W/okL5IEcbvdRnafBEhP5tcpDm08dntJbQ0Yb7DVmppCGBx6xNOGSABBdAyvV3dawq5a
         rx6g==
X-Gm-Message-State: AMke39mthoF9vcZiBwxagLE+P2AbhsSSwOyaJ58I2UDAn4+Jdh3dlLgm8pM+fvcf11psmA==
X-Received: by 10.28.86.214 with SMTP id k205mr5483069wmb.26.1486326380016;
        Sun, 05 Feb 2017 12:26:20 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id y30sm56617692wrc.23.2017.02.05.12.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Feb 2017 12:26:19 -0800 (PST)
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
Subject: [PATCH v3 2/5] stash: introduce push verb
Date:   Sun,  5 Feb 2017 20:26:39 +0000
Message-Id: <20170205202642.14216-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.12.0.rc0.208.g81c5d00b20.dirty
In-Reply-To: <20170205202642.14216-1-t.gummerer@gmail.com>
References: <20170129201604.30445-1-t.gummerer@gmail.com>
 <20170205202642.14216-1-t.gummerer@gmail.com>
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
index 10c284d1aa..bf7863a846 100755
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
+			stash_msg=${1?"-m needs an argument"}
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
@@ -291,6 +294,39 @@ save_stash () {
 	fi
 }
 
+save_stash () {
+	push_options=
+	while test $# != 0
+	do
+		case "$1" in
+		--help)
+			show_help
+			;;
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
2.12.0.rc0.208.g81c5d00b20.dirty

