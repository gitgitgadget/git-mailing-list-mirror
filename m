Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEC1C433DB
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 18:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 416E023AAC
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 18:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbhAVSky (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 13:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbhAVSRA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 13:17:00 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B051C061788
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 10:16:17 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d16so5281684wro.11
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 10:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Hn5JE2/Bv0hJR7cwXwcovImuk0DZn9N/knwpPf4zykE=;
        b=YBGpcUatOptPRFNzfOxcqQ9j+SAJCilLbmSvanJDTCmJ6Uz4fj0qLpSQQFeMaSTayV
         OgCCn1m3hRdJsGWs4BSQ0ITJHuCj/Q8NpLpw/UqAL9215IdjErvl+FL30pwmFH0h/wqo
         7L6mbm+K76pB4i6RlLoYrSXgwDIS4GPVcTg8rYIXtZQcYQzMlY35gXLxVrkTrHHyJRhJ
         WlbeWpPTH2nKEm1+71B2d/pzicQIoNkXYfUnJqEOL8G1xZH0Z2AFfptJhEyAXP4TMgbs
         xOmWb89MrHEUY0FbU7ya8yLvS7KGRU62dWe141Q2f8mYWjTx3aDdmby7IV+lULVV6ARp
         2w5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Hn5JE2/Bv0hJR7cwXwcovImuk0DZn9N/knwpPf4zykE=;
        b=gMXt2zI+myBUcZNIPq7EVgn9c3LW2XCHbRofmzAETstbQUaBSsv+4R/UCEUP8MFGQ8
         f0opkkDfG3bFGpDHKoV8g3oiPgjWqBQrHlLBZ9FVESEUm7OZ3vU3USiQ0oKrIyeW6r/s
         WRikN/+xUZuY/mtxZ62Dr/X3gedDjRmGTxMeKGtvHnKep3P3TFOwFEjwgSXOe3rAHYcG
         SHirTgZHrOCC/ys1cgRZLy3ReUG0vMNy5ic4b+XCHiR0RzYJnElVHZkbGArCckpy2ZsI
         82bWORyI6zt1Mh2c0Juz3rk14dTlYaeXwv45KR6k9cBhf8q8gXZIAlkUTTeZs1yhB5uJ
         Q2WQ==
X-Gm-Message-State: AOAM532Be2lZVh3bLSFYqxLk7JW94bLDTzkPE+YoEURbhjhCFyo4SZT0
        r0Fqe4DqgvQo/9EL2yBCsKIyKxb6CSg=
X-Google-Smtp-Source: ABdhPJyg90Lfm0DANC0m8u/gxYFH5jFpY8cKE6Q9AHZSnZYxLQyyc2Ew72KevaWnrgNKxSzBNS2tEA==
X-Received: by 2002:a5d:6191:: with SMTP id j17mr5700222wru.281.1611339376147;
        Fri, 22 Jan 2021 10:16:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b4sm544732wrn.12.2021.01.22.10.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 10:16:15 -0800 (PST)
Message-Id: <2c2744333ecf5662d4198bdddeee80ff4adf6acd.1611339373.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.841.v2.git.1611339373.gitgitgadget@gmail.com>
References: <pull.841.git.1611267638.gitgitgadget@gmail.com>
        <pull.841.v2.git.1611339373.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Jan 2021 18:16:11 +0000
Subject: [PATCH v2 2/3] range-diff/format-patch: handle commit ranges other
 than A..B
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Uwe =?UTF-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the `SPECIFYING RANGES` section of gitrevisions[7], two ways are
described to specify commit ranges that `range-diff` does not yet
accept: "<commit>^!" and "<commit>^-<n>".

Let's accept them.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 revision.c            | 22 +++++++++++++++++++++-
 t/t3206-range-diff.sh |  8 ++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 00675f598a3..9ee063a2c03 100644
--- a/revision.c
+++ b/revision.c
@@ -4209,5 +4209,25 @@ void put_revision_mark(const struct rev_info *revs, const struct commit *commit)
 
 int specifies_commit_range(const char *range)
 {
-	return !!strstr(range, "..");
+	size_t i;
+	char c;
+
+	if (strstr(range, ".."))
+		return 1;
+
+	i = strlen(range);
+	c = i > 2 ? range[--i] : 0;
+	if (c == '!')
+		i--; /* might be ...^! */
+	else if (isdigit(c)) {
+		/* handle ...^-<n> */
+		while (i > 2 && isdigit(range[--i]))
+			; /* keep trimming trailing digits */
+		if (i < 2 || range[i--] != '-')
+			return 0;
+	} else
+		return 0;
+
+	/* Before the `!` or the `-<n>`, we expect `<rev>^` */
+	return i > 0 && range[i] == '^';
 }
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 6eb344be031..e217cecac9e 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -150,6 +150,14 @@ test_expect_success 'simple A B C (unmodified)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'A^! and A^-<n> (unmodified)' '
+	git range-diff --no-color topic^! unmodified^-1 >actual &&
+	cat >expect <<-EOF &&
+	1:  $(test_oid t4) = 1:  $(test_oid u4) s/12/B/
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'trivial reordering' '
 	git range-diff --no-color master topic reordered >actual &&
 	cat >expect <<-EOF &&
-- 
gitgitgadget

