Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2764EC43331
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 03:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC08420DD4
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 03:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbhADDKq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 22:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbhADDKp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jan 2021 22:10:45 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFFCC06179F
        for <git@vger.kernel.org>; Sun,  3 Jan 2021 19:09:28 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q18so30822918wrn.1
        for <git@vger.kernel.org>; Sun, 03 Jan 2021 19:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=2sQ7U1FWgBOX7rWhIg5mwDJ4gGLWmHnYWn6oA+HXRLA=;
        b=ZVIZ7/7gyVBX5Lg2BaogjXv9v2PJXXjcXRRDVPqYD6C9Yg5mox2sMoMT/hrgG2L8Lb
         tz5aC7yrFmWqZvxgO+sa7hSYPOViD/JhCWyGBooDyoAs6Qm44qMJPFXqsK7FgvwdE+j2
         oNFhFpftIctgC/rmsKypDv/yU7+dsTSwYmuCv260xrwpwrZSPEehQQ3Mgb42EWIuOM6K
         qtL1AhC0Qoiv2caETHeUBvXutJbU1Lm32nW5BMIVgR7no3py+Kg4tDJr+jIVcrvtJr6u
         lZ2dSUXsnlpnR2s/fh0elxIt385lFobThLcfFtL8v94tHBzeOdKtivbG2AmrPGL5jkmo
         +6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=2sQ7U1FWgBOX7rWhIg5mwDJ4gGLWmHnYWn6oA+HXRLA=;
        b=nK4plGqDBJI0dgtYKV23ghb7zKNMo/FHVosAogW5E337nmmt7OjD8009AP7eQ8olOT
         8F6ojRR8TjBzuj+Q3neBMWJonuNX2iB01m32WJqbhmfkQDSrBr5FDMzSVGEkk/8wd0SF
         7Iz9gcy5XGQ/JEkeVcnvgL45azEf2RAGxVCflFQzXaDjevU/WlmV+KPwfYH9iqEvA+25
         ReSREvLCLUJ1UGaPDhtfFcg2k2SQp3tWRpZwOAEPIqqcYDLK+ZS8fvNqKEA2b3hjgouX
         MEOl2IjPuh+b3qLeWau5CMPRm39K5FAlHCLM7aGA0DC2l43PF7m8JVY4RKEOeFaUBMO1
         tHXA==
X-Gm-Message-State: AOAM531H5l/KkqeJnz9D+JLHcga7lUrQaAdfh7UaY5K4r8rDjRJBmEru
        zLyOOO/VYO/ljiPnV89sl8TrdNuZ13Y=
X-Google-Smtp-Source: ABdhPJyenWI9erim8yBzAMJSLNtBsdllaDgoPmyn5rwQwRKSzvsIqp60GWvTvhYJ0nfPJ5hULKZsBQ==
X-Received: by 2002:adf:8145:: with SMTP id 63mr75537495wrm.8.1609729766892;
        Sun, 03 Jan 2021 19:09:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h16sm32049910wmb.41.2021.01.03.19.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 19:09:26 -0800 (PST)
Message-Id: <5298694786e2c76fb08a0b37890e3183d788ff10.1609729758.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
        <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Ren=C3=A9=20Scharfe?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 04 Jan 2021 03:09:17 +0000
Subject: [PATCH v2 8/9] cache-tree: use ce_namelen() instead of strlen()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>

Use the name length field of cache entries instead of calculating its
value anew.

Signed-off-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 cache-tree.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 7da59b2aa07..4274de75bac 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -185,10 +185,12 @@ static int verify_cache(struct cache_entry **cache,
 		 * the cache is sorted.  Also path can appear only once,
 		 * which means conflicting one would immediately follow.
 		 */
-		const char *this_name = cache[i]->name;
-		const char *next_name = cache[i+1]->name;
-		int this_len = strlen(this_name);
-		if (this_len < strlen(next_name) &&
+		const struct cache_entry *this_ce = cache[i];
+		const struct cache_entry *next_ce = cache[i + 1];
+		const char *this_name = this_ce->name;
+		const char *next_name = next_ce->name;
+		int this_len = ce_namelen(this_ce);
+		if (this_len < ce_namelen(next_ce) &&
 		    strncmp(this_name, next_name, this_len) == 0 &&
 		    next_name[this_len] == '/') {
 			if (10 < ++funny) {
-- 
gitgitgadget

