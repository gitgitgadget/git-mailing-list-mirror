Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AA8C1B0D8
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 23:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C631923718
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 23:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbgLPXUB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 18:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbgLPXUB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 18:20:01 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3081FC061285
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 15:19:17 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id dk8so26719380edb.1
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 15:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7QTe1j/IaiadkVcSHJQuLM2+K3dB8H05JX9+8yNtP1c=;
        b=OLdVKxsardsc4Q8Ot2dIFUT5ydbG4BWaSVkw+n+u12x0OI9AJEnsOW7D9olwmTGMuM
         ph7s3n+GhrETZRFhFlHIkXmTp4uoPcMo1PcaosXPYshGYTQvBT+HMK1H9UEpUPSy26wZ
         lYLuW1Mr/Xk3cjH5TSqiwHlNY6A4vtB6Xu+84bUkvXPk+ciNnV21+rG/KQ4GIdv/H8j7
         5duQJJw6RII2rVcbzgM/MC3Y8Hyz94xtr1+24yNN+sqm/U5Bubr4R4mM7UDT5xP9fq/3
         B8fGkGVpHUmhdwr8Y1drHASb6+HQhvfXWuG0JTUALnGyruvy3XG/PwApWowP+Prfd24z
         VP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7QTe1j/IaiadkVcSHJQuLM2+K3dB8H05JX9+8yNtP1c=;
        b=kSg0VU3XrNE/a6vqmvto4uLdRYwzdb8oLhN9350BZYN77r9hX/4ZDpLLUWDSwplXPX
         r3rf6EETuNHBKcHfiMB8lPx7Zl+P6XBqqj2xn4jYTvS+G5MghM7QideLBHriDHLxmJey
         o+iYKvV9c50/MVz4JFIg+tczuAaBrshFxralqiBwUIcsqNxXrS3MxVYa61oTRb/3EMTi
         4Yd+O6DaAmkk5LlIfP+rtRo8IeKXyU4tTU3fMdwEuZREUpddokuzEvS1A1RBCMnYYqgV
         IlZQFXCAchd4DYxCuNCUW3Va7xE5w6u0FwrsgRfrO7v7HeW9AGs0fgjuFuRIdr1zelgB
         vWHw==
X-Gm-Message-State: AOAM532FNt6HE3CjP3UOCBFS6oRUWyekryP9Elf3rRTRsduKETSMMPrJ
        xb7h/qJkpzCfBDYx3t7NMaI=
X-Google-Smtp-Source: ABdhPJwHM3R8JLKgAiRR0ahwD3kzd7fkywjgKqXOr/3tgReJe5CAouE+95XMceMT01EKkIix4h7img==
X-Received: by 2002:a50:9ee6:: with SMTP id a93mr36564206edf.174.1608160755899;
        Wed, 16 Dec 2020 15:19:15 -0800 (PST)
Received: from lesale.home (194-166-87-93.adsl.highway.telekom.at. [194.166.87.93])
        by smtp.gmail.com with ESMTPSA id b19sm21907823edx.47.2020.12.16.15.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 15:19:15 -0800 (PST)
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     gitster@pobox.com
Cc:     aclopte@gmail.com, git@vger.kernel.org
Subject: [PATCH] diff: suppress --name-only paths where all hunks are ignored
Date:   Thu, 17 Dec 2020 00:18:40 +0100
Message-Id: <20201216231840.3163806-2-aclopte@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201216231840.3163806-1-aclopte@gmail.com>
References: <xmqqeejsdv7x.fsf@gitster.c.googlers.com>
 <20201216231840.3163806-1-aclopte@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Diff options -w and the new -I<regex> can be used to suppress some hunks. Honor
these ignores in combination with --name-only, --name-stat, and --raw,
to not output files where all hunks are ignored.

Commit f245194f9a made "git diff -w --exit-code" exit with zero if all
changed hunks are whitespace. This uses the diff_from_contents bit.
Set that also when given -I<regex>, for consistent exit codes.

The diff_from_contents bit means that we have to look at content
changes to know if a path has changed - modulo ignored hunks.  Teach
diff.c::flush_one_pair() to do so.  In the caller, reset the found_changes bit
after each file pair, so we can test each file separately for content changes.

Signed-off-by: Johannes Altmanninger <aclopte@gmail.com>
---
 diff.c                     | 36 +++++++++++++++++++++++++++++++-----
 t/t4013-diff-various.sh    | 13 +++++++++++++
 t/t4015-diff-whitespace.sh |  9 +++++++++
 3 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 643f4f3f6d..560f2d5fad 100644
--- a/diff.c
+++ b/diff.c
@@ -4630,11 +4630,10 @@ void diff_setup_done(struct diff_options *options)
 	/*
 	 * Most of the time we can say "there are changes"
 	 * only by checking if there are changed paths, but
-	 * --ignore-whitespace* options force us to look
-	 * inside contents.
+	 * --ignore-* options force us to look inside contents.
 	 */
 
-	if ((options->xdl_opts & XDF_WHITESPACE_FLAGS))
+	if ((options->xdl_opts & XDF_WHITESPACE_FLAGS) || options->ignore_regex)
 		options->flags.diff_from_contents = 1;
 	else
 		options->flags.diff_from_contents = 0;
@@ -5967,6 +5966,26 @@ static void flush_one_pair(struct diff_filepair *p, struct diff_options *opt)
 {
 	int fmt = opt->output_format;
 
+	if (opt->flags.diff_from_contents &&
+	    (fmt & (DIFF_FORMAT_RAW | DIFF_FORMAT_NAME | DIFF_FORMAT_NAME_STATUS))) {
+		static FILE *devnull;
+		FILE *diff_file;
+
+		if (!devnull)
+			devnull = xfopen("/dev/null", "w");
+
+		diff_file = opt->file;
+		opt->file = devnull;
+		opt->color_moved = 0;
+
+		if (check_pair_status(p))
+			diff_flush_patch(p, opt);
+
+		opt->file = diff_file;
+		if (!opt->found_changes)
+			return;
+	}
+
 	if (fmt & DIFF_FORMAT_CHECKDIFF)
 		diff_flush_checkdiff(p, opt);
 	else if (fmt & (DIFF_FORMAT_RAW | DIFF_FORMAT_NAME_STATUS))
@@ -6350,11 +6369,18 @@ void diff_flush(struct diff_options *options)
 			     DIFF_FORMAT_NAME |
 			     DIFF_FORMAT_NAME_STATUS |
 			     DIFF_FORMAT_CHECKDIFF)) {
+		int found_changes = 0;
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
-			if (check_pair_status(p))
-				flush_one_pair(p, options);
+			if (!check_pair_status(p))
+				continue;
+			flush_one_pair(p, options);
+			if (options->found_changes) {
+				found_changes = 1;
+				options->found_changes = 0;
+			}
 		}
+		options->found_changes = found_changes;
 		separator++;
 	}
 
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index f72d456d3b..7cfd3a22d1 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -509,6 +509,19 @@ test_expect_success 'diff -I<regex> --stat' '
 	test_cmp expect actual
 '
 
+test_expect_success 'diff -I<regex> --name-only' '
+	git diff -I "" >actual --exit-code &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'diff -I<regex> --name-status' '
+	! git diff -I"[0-9]" --name-status  --exit-code >actual &&
+	cat >expect <<-\EOF &&
+	M	file0
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'diff -I<regex>: detect malformed regex' '
 	test_expect_code 129 git diff --ignore-matching-lines="^[124-9" 2>error &&
 	test_i18ngrep "invalid regex given to -I: " error
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 47f0e2889d..3c4941cf96 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -805,6 +805,15 @@ test_expect_success 'whitespace-only changes not reported (diffstat)' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'whitespace-only changes not reported (name-only)' '
+	# reuse state from previous test
+	! git diff --name-only >actual --exit-code &&
+	git diff --name-only -b >actual --exit-code &&
+	git diff --name-status -b >>actual &&
+	git diff --raw -b >>actual &&
+	test_must_be_empty actual
+'
+
 test_expect_success 'whitespace changes with modification reported (diffstat)' '
 	git reset --hard &&
 	echo >x "hello  world" &&
-- 
2.29.2

