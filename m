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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16D1C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 00:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4D9361211
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 00:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbhIUA4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 20:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbhIUAyp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 20:54:45 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB2BC1030BE
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:57:41 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q11so32119673wrr.9
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LFZ4CtwaX9GfeGr8oWw1CEmhEHwToUBYtMe3B0wkmBo=;
        b=l39AfmMgP6h9xprcFq8wSbOeTQDnwEsFoO7Z4VDc/4GV987ndraBdFUYn2flxzM1dy
         ihTk6eK7cmqayO2uJvq4EUPIWy55oXgbBoxqqmqhIDlZ2Gz5hnMz4oZ+9FrtXR49YtoY
         U2QhY4yZd6Ze++ks6SCdithqkTZoiGwEn+G6U876UkTX2kwn/v6kud3P4Q5FaJzxCYxB
         4K0jjjyPtA7wH1D+bHZhEpjKkUYYdWYw5mwDLyyUrvCp7XVB9bcfU1KZnpSSc5nuDZ8z
         vIlEuJMULJ1WKoVkzcPkQW8yHmnqfnOYNJoic4m4TH4mZp0Mwx6jZyvv4DcPXeOmB/0I
         ioKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LFZ4CtwaX9GfeGr8oWw1CEmhEHwToUBYtMe3B0wkmBo=;
        b=mhHyyKyUzNIzcfli9ZTtueCSlTmuPJT/roXp3Z7DuGnQzVRE+ck5JXvdlWci3RqGf3
         d2WKiPCVWdmqzTiZ5NsthdiREyJ9pj4MGdnJw+ghMX0q6A6D+rOMjwc7dcHlpstNysIC
         2D6jPil+bDjjIjJvhXs7kMUVYG6p54VnZh2wYvv2/6PLfj+pagkIqdt7Vmoj0aqenk10
         rzwIE14xrmSEFYWNaR33Q+LsUAeD0r16S4HrLNqyIRiF1G5Rv87PINHkcfuAsuro8/gU
         KHndu78JyCQTSnCGNdl5nYFLx/Sd/Wg7LAnMYbqwBKkALkAIXgBtEyxMovs6S95rPneR
         nwSw==
X-Gm-Message-State: AOAM531f1J1GxKPkZ4PFocfDwNdzy0n3E85ge+oRkj8UtPsfHAduIz1c
        9hHlH+4xweBp9u6Bd61P247u9GHXZ+o=
X-Google-Smtp-Source: ABdhPJz0Zq1coYNMyOXhQDZNaEvC6lQyphKNDkC0QjAHUgKfJx2XFCU0jWlQ8eykA789iPv10DZoYQ==
X-Received: by 2002:a5d:4212:: with SMTP id n18mr30642720wrq.37.1632160659910;
        Mon, 20 Sep 2021 10:57:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j2sm16666671wrq.35.2021.09.20.10.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 10:57:39 -0700 (PDT)
Message-Id: <d90937b9ac9aaa6170f56d18ddb7a327b2af27d6.1632160658.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1043.git.1632160658.gitgitgadget@gmail.com>
References: <pull.1043.git.1632160658.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 17:57:36 +0000
Subject: [PATCH 1/3] sparse-checkout: fix OOM error with mixed patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, calbabreaker@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Add a test to t1091-sparse-checkout-builtin.sh that would result in an
infinite loop and out-of-memory error before this change. The issue
relies on having non-cone-mode patterns while trying to modify the
patterns in cone-mode.

The fix is simple, allowing us to break from the loop when the input
path does not contain a slash, as the "dir" pattern we added does not.

This is only a fix to the critical out-of-memory error. A better
response to such a strange state will follow in a later change.

Reported-by: Calbabreaker <calbabreaker@gmail.com>
Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          | 2 +-
 t/t1091-sparse-checkout-builtin.sh | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 8ba9f13787b..b45fd97a98b 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -389,7 +389,7 @@ static void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *pat
 		char *oldpattern = e->pattern;
 		size_t newlen;
 
-		if (slash == e->pattern)
+		if (!slash || slash == e->pattern)
 			break;
 
 		newlen = slash - e->pattern;
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 38fc8340f5c..a429d2cc671 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -103,6 +103,14 @@ test_expect_success 'clone --sparse' '
 	check_files clone a
 '
 
+test_expect_success 'switching to cone mode with non-cone mode patterns' '
+	git init bad-patterns &&
+	git -C bad-patterns sparse-checkout init &&
+	git -C bad-patterns sparse-checkout add dir &&
+	git -C bad-patterns config core.sparseCheckoutCone true &&
+	git -C bad-patterns sparse-checkout add dir
+'
+
 test_expect_success 'interaction with clone --no-checkout (unborn index)' '
 	git clone --no-checkout "file://$(pwd)/repo" clone_no_checkout &&
 	git -C clone_no_checkout sparse-checkout init --cone &&
-- 
gitgitgadget

