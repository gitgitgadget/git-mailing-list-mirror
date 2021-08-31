Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DF9C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1840461026
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241317AbhHaUxd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241312AbhHaUxV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 16:53:21 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53053C061292
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:52:18 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id n24so752756ion.10
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8NYgMRF3jBTzW2/0/2YVZB3StET0438Dob1HTkgbmY8=;
        b=Zz765yJPpVUdPbDQJSzrY2H+3s3L73YkbwJ8h4TKjPFatTi50wPtfDn4y1y7lAI1UA
         SuU9u4yQJVQTGhFXKPgZMRm/1AfRF1iIFDC2uqT8//r60pe8yfvVcGcWPEA5yuUBTNbo
         DpXB80OkxV/yyU5GL7y3IRa5i1df92lNfubb0/f5e9FF07xLX/3Qwp0ht5ONCAYhNTfM
         gDWziymo8K6sRQHD5e+dqt5GXWKiZDQafgE2rsmYOd0q1XjFiJM3etSVgEWFqvshCNQ8
         8RQOVwUZ6Ciz7f9hzMdMmXkIO7jH8vYoTzUFFI+W/+VR1m6UMB4TFeUZ6zQ2HJVkGRLM
         yjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8NYgMRF3jBTzW2/0/2YVZB3StET0438Dob1HTkgbmY8=;
        b=XImtIRbb4RW4LpvmICyYLJP+M1g417c631brM/W09O3LBafUpKZYSurxpNV2QVqbSD
         8hX9V2Lu5JIfJZXOfc0pnnMIW1BhS29uABcfVYf9aDG346z0OrwBclKP3Gs2+NavwTyH
         v8jypjOMkyf/CStB/eS/oY6xHbThkjg8AufhK47gIiD7VHSl0uSPGwGOORhszdt9g8KJ
         PVEoJk8RLz/SHxVr1rtFdJXI5G1nyJc3eaOJOJ8pRJ19aOhSP3wD2RfDe+iU84pzD2Px
         W5k9i8tEw2NS+tm+fTBojiYeXwJOXSukk6mBgvN7p3giSnsSdFuk4AEr5uwY173Po9cl
         w+cw==
X-Gm-Message-State: AOAM5302Kwp68M8XyJN5nPJdKaOOJTXa2Lf8YtN1X1pDD73cWbNX4nQA
        vxSJzBPuhZpbrkp2EpPege0yIzlznrGKM3Qc
X-Google-Smtp-Source: ABdhPJyfyLriTzL1Db9tZ7LVymJlRvD36pXFuq/tn0MSVSXAH0U5fEYFJz++AEJyFq9SR908UfOnKA==
X-Received: by 2002:a05:6602:2436:: with SMTP id g22mr24683053iob.109.1630443137647;
        Tue, 31 Aug 2021 13:52:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b12sm10938978ios.0.2021.08.31.13.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:52:17 -0700 (PDT)
Date:   Tue, 31 Aug 2021 16:52:16 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v5 14/27] pack-bitmap.c: introduce
 'bitmap_is_preferred_refname()'
Message-ID: <ba5fd71fb3f4bb51b3cc086cbfe470e244b8e914.1630443072.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1630443072.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1630443072.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a recent commit, pack-objects learned support for the
'pack.preferBitmapTips' configuration. This patch prepares the
multi-pack bitmap code to respect this configuration, too.

The yet-to-be implemented code will find that it is more efficient to
check whether each reference contains a prefix found in the configured
set of values rather than doing an additional traversal.

Implement a function 'bitmap_is_preferred_refname()' which will perform
that check. Its caller will be added in a subsequent patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 16 ++++++++++++++++
 pack-bitmap.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 612f62da97..d5296750eb 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1658,3 +1658,19 @@ const struct string_list *bitmap_preferred_tips(struct repository *r)
 {
 	return repo_config_get_value_multi(r, "pack.preferbitmaptips");
 }
+
+int bitmap_is_preferred_refname(struct repository *r, const char *refname)
+{
+	const struct string_list *preferred_tips = bitmap_preferred_tips(r);
+	struct string_list_item *item;
+
+	if (!preferred_tips)
+		return 0;
+
+	for_each_string_list_item(item, preferred_tips) {
+		if (starts_with(refname, item->string))
+			return 1;
+	}
+
+	return 0;
+}
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 020cd8d868..52ea10de51 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -94,5 +94,6 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 			  uint16_t options);
 
 const struct string_list *bitmap_preferred_tips(struct repository *r);
+int bitmap_is_preferred_refname(struct repository *r, const char *refname);
 
 #endif
-- 
2.33.0.96.g73915697e6

