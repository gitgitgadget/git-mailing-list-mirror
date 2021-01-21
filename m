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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8A7C433E9
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 22:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79E4C221E5
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 22:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbhAUWWH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 17:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbhAUWVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 17:21:25 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21811C0613ED
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 14:20:43 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id q7so3234352wre.13
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 14:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MlB78MSeD43RpQYwEtmuC1BVv0QVQez8DcE5XaZ6MFQ=;
        b=NYzRsHWfgIO+Mqw/tjqBNLtoZRhY8Z6TLryTVKIV1J9ept1owFwICNgX1difyWCF9c
         0w34EQsnrl9fOHfc8bG/jFSlHk3CHWt/tpT3OKdVT92zgP1FxigVEG5OveoDybMDYAa7
         4Kklcjf4/H97uKk8dtWQK6JFK7usHOFdkyIx6q6B6ECWhnSZdcaEpaq3R5DkduBQyFLH
         sjQSA8DG72uv8wPzFNwZS7eA8pYK8Piz+05JLJaTOsh+ewzEqqVSLHKFpsVayZhYZ+DR
         8OOXHch4f+jOagJFUnj7LpOz5L87JSnLxL8epN/PYDpBUrPLwrjD5RrfAkF8VKSbu4gO
         hXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MlB78MSeD43RpQYwEtmuC1BVv0QVQez8DcE5XaZ6MFQ=;
        b=eP0hKy4DTPd3xCf1qrUpfNpJZ5SYvvWU8SZGQqaMHz9pGJ97iSHYbzEZT7fEdoe4+K
         Qh9Eqt7apog9ArCkgu3OKAN7Dg0rP7lSrIJbIky9+39Gmyt2cCcR1MwtIuglKmZIHBNi
         yiyZEX1aJp9AMddyAho0WwMVUAhB7i52yVkEymtTPIuiq8H3tekDJKIiAxncDQJSINYU
         3mohdTsNe56FHOm4RUtcaldnWoQe7UB8Agim2tvvM8Z2yCyXTQAE1/0rVKmnP4K53sLq
         XavOlDzrXxvg3ekwYvjkAGqM3bM+ut+p+cCKcoWcNtZozw2judFlcH/+4v8VaXTW1eCd
         5Pew==
X-Gm-Message-State: AOAM530a1/mzSTozx+w3u/mgVgyPR37V+jq+06iVehCzIz0HIziaby/o
        G93M12QS+MRhEUDYxuGlppVbvli0/lQ=
X-Google-Smtp-Source: ABdhPJwoS8mMO8BZwTBwEGNkZiFxttTqH35x82Wm/vGQjIiZlUmcWHKY9ejC0a1TyphstJ75RCOa3A==
X-Received: by 2002:adf:ab1d:: with SMTP id q29mr1381735wrc.415.1611267641781;
        Thu, 21 Jan 2021 14:20:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v11sm9640642wrt.25.2021.01.21.14.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 14:20:41 -0800 (PST)
Message-Id: <88c15617b4ba8ae3211b1a01861eb4165f3eda38.1611267638.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.841.git.1611267638.gitgitgadget@gmail.com>
References: <pull.841.git.1611267638.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Jan 2021 22:20:37 +0000
Subject: [PATCH 2/3] range-diff: handle commit ranges other than A..B
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Uwe =?UTF-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
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
 builtin/range-diff.c  | 21 ++++++++++++++++++++-
 t/t3206-range-diff.sh |  8 ++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 551d3e689cb..6097635c432 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -13,7 +13,26 @@ NULL
 
 static int is_range(const char *range)
 {
-	return !!strstr(range, "..");
+	size_t i;
+	char c;
+
+	if (strstr(range, ".."))
+		return 1;
+
+	i = strlen(range);
+	c = i ? range[--i] : 0;
+	if (c == '!')
+		i--; /* might be ...^! or ...^@ */
+	else if (isdigit(c)) {
+		/* handle ...^-<n> */
+		while (i > 2 && isdigit(range[--i]))
+			; /* keep trimming trailing digits */
+		if (i < 2 || range[i--] != '-')
+			return 0;
+	} else
+		return 0;
+
+	return i > 0 && range[i] == '^';
 }
 
 int cmd_range_diff(int argc, const char **argv, const char *prefix)
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

