Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38A3C433E6
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F92A64FEB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhCKREv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 12:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhCKREp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 12:04:45 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A39C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:04:44 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id l13so1660780qtu.9
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V4a9UY5s40LlGymKW7WgX8xoLwzSyTJIIO9ypByJRAw=;
        b=PHaAqcdsvji03f2z+lFyZ8uXYsQHIyCKXI3NXRjmrhJt4WCbC8VFsSW+IG01McIrVA
         xn4ygoTuPmoyX1GHYO7FnKtY2WZRgEImAKhYJ7OY4br6O9JHfCAwAD/vjjc6sCS0U6Mq
         2rXGLLlpG+4aoCfUYbDR7kchWQxarSw8LsEdhJ9MkgJtsdXDH2Ejqfgb8kaFR+QeAu9E
         9Dd79jaDJRgZca+E2zDekUEh2P6Zu8WJmOoxRHC5gF1+9rpw5nfLNBfXlESnbb7bSN87
         obCG5HahbBJHSqMzlqwpxOZeHnlVphNTgS575zCb9CsCGk3jdfYjQDj3KnF38SpcHCZv
         OTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V4a9UY5s40LlGymKW7WgX8xoLwzSyTJIIO9ypByJRAw=;
        b=pIltwOOLcSB3zoWwTKHMyruD34fi6uIjD1SAn2uBDT4xix78y+IexKAxQxNPeybldn
         4PW1bVe3rXuvXyfymrBQjKALczUgeHCJDHNU07gBkaLV94V690dmiVOirsGMiFCtg8z0
         DBRxnRfBuo7w0Frjbtf1dGAorL2/zX5GxxgUf3Vy3VYKgF3c8zj6v3CSgPSTxcRStTWn
         wYUJwomTw+/+kQPHGVj22SnfCS1hTQlRWEKvB+ekxBY73uFeXySSG0IHPdj0X6nCWqtj
         e7Zg2GZmkwaRrflYxoczoE6HvNDTT+ZgANCMFCxK5FDCQm0yF23ZsAjv654i6lUrkExY
         2mXA==
X-Gm-Message-State: AOAM531zWEt4449lqWr1X1LcVbogNtkLuDwdtgAqvPlBFjx3Pqgl/NNN
        /R2PtZPnWh7ZTGBZ3nZ9IS5LqzAQ5r4QOyef
X-Google-Smtp-Source: ABdhPJwzgN6xl6wc014xRMHaJpHLci/MU6hvpqCG/IDML4IXFYmTJuy8aCKztRL44oOshyNfyoshBg==
X-Received: by 2002:ac8:7412:: with SMTP id p18mr8215654qtq.41.1615482283313;
        Thu, 11 Mar 2021 09:04:43 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f947:1686:6ada:db5b])
        by smtp.gmail.com with ESMTPSA id i9sm2405117qko.69.2021.03.11.09.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 09:04:42 -0800 (PST)
Date:   Thu, 11 Mar 2021 12:04:40 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com, peff@peff.net
Subject: [PATCH v3 02/16] builtin/multi-pack-index.c: don't handle 'progress'
 separately
Message-ID: <181f11e4c55b364dc7f6a6530f397779171671a9.1615482270.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1615482270.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that there is a shared 'flags' member in the options structure,
there is no need to keep track of whether to force progress or not,
since ultimately the decision of whether or not to show a progress meter
is controlled by a bit in the flags member.

Manipulate that bit directly, and drop the now-unnecessary 'progress'
field while we're at it.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/multi-pack-index.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 4a0ddb06c4..c70f020d8f 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -13,7 +13,6 @@ static char const * const builtin_multi_pack_index_usage[] = {
 static struct opts_multi_pack_index {
 	const char *object_dir;
 	unsigned long batch_size;
-	int progress;
 	unsigned flags;
 } opts;
 
@@ -23,7 +22,7 @@ int cmd_multi_pack_index(int argc, const char **argv,
 	static struct option builtin_multi_pack_index_options[] = {
 		OPT_FILENAME(0, "object-dir", &opts.object_dir,
 		  N_("object directory containing set of packfile and pack-index pairs")),
-		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
+		OPT_BIT(0, "progress", &opts.flags, N_("force progress reporting"), MIDX_PROGRESS),
 		OPT_MAGNITUDE(0, "batch-size", &opts.batch_size,
 		  N_("during repack, collect pack-files of smaller size into a batch that is larger than this size")),
 		OPT_END(),
@@ -31,15 +30,14 @@ int cmd_multi_pack_index(int argc, const char **argv,
 
 	git_config(git_default_config, NULL);
 
-	opts.progress = isatty(2);
+	if (isatty(2))
+		opts.flags |= MIDX_PROGRESS;
 	argc = parse_options(argc, argv, prefix,
 			     builtin_multi_pack_index_options,
 			     builtin_multi_pack_index_usage, 0);
 
 	if (!opts.object_dir)
 		opts.object_dir = get_object_directory();
-	if (opts.progress)
-		opts.flags |= MIDX_PROGRESS;
 
 	if (argc == 0)
 		usage_with_options(builtin_multi_pack_index_usage,
-- 
2.30.0.667.g81c0cbc6fd

