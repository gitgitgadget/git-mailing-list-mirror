Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BCBC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE79861212
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhHXQRZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbhHXQRM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 12:17:12 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0F0C0612A7
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:16:22 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id b7so27065924iob.4
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GTEp0X4fH1e57QonUX2gkN17NjtRoyvnlbMuzRDXPk8=;
        b=Oifs/hp5znH/4xJn7IFX5nEMuP6qu2ley/N0ZJjZ4bhrmIwYhRRwZTcDO/fQBgZGqP
         EYxvvfzSinWKwjH5X52H/tyZB/ggYX02ynwJp+0J/b3GAwsNmElRbhA4WiIJgH/ignja
         up3jQRPoBNleslKDW+H7oKUXYoNK6VzvLXiYHRdD2NoiEJWizPbz6lniKHNcpzEzSljK
         DMvlJNGY6GWX/fnf9jI2p6cF1Yc6JBpKEqBPrDs8zDHv5o0DLnlhPqv/JtgO/ixozXoU
         3G5Nai9fIJ7AYKw4SdpApsEDNCwGd2RWTlXrEM9dFxAUWKckhrPpXM+TD3TEonxNys+E
         qcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GTEp0X4fH1e57QonUX2gkN17NjtRoyvnlbMuzRDXPk8=;
        b=BMtNuRRPPp4VJIFBVAV8aX7AdSIVHKLepkAe3okRM8cdU9b9CkEKe9B1ONMc/dj1jj
         skhvVJPkPmT+RXTz0XIagJtbKy0+4zx745iOLILM++OgL9bovLjAO2diMjoY4zDUBvP3
         Eygbu/qbUtpldCdikOo3Wx00D2iRgMqNFwGLEb7gKB6hmPVOvbRAg/itzR4yc7qNmEfZ
         jPpExm7ycb5hBdSGMapdeoKVm7blKKMVx78BsMV67d4j9o1w7VuVh/ss2cfbVPpmbzhL
         tHvu1syKYB4Bl1jBXjB3B7hW2tgEvOAJIAYWl53KMUtwQMBaIPU/UBWMLdzOt27226OU
         zAPA==
X-Gm-Message-State: AOAM5330J0f/hy3+7tEGcdYeBbxunYgOKaC/2K0WtQsxJniImW6CrfaP
        fpyml8pjXZ1LweruW+NivCyN9kG/3LC5YygH
X-Google-Smtp-Source: ABdhPJy+xey78M/qcaOecCmaRQ8hY/joUQ2wTKPLHUrLJu7HoSZf2roZh2aKHNU9ifo0OexF/98Z8A==
X-Received: by 2002:a6b:f007:: with SMTP id w7mr31388734ioc.112.1629821781288;
        Tue, 24 Aug 2021 09:16:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c23sm10294430ioi.31.2021.08.24.09.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 09:16:20 -0700 (PDT)
Date:   Tue, 24 Aug 2021 12:16:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v4 12/25] pack-bitmap.c: introduce
 'bitmap_is_preferred_refname()'
Message-ID: <df6844def0afb90b992a203ded5523c88ddf002e.1629821743.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1629821743.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1629821743.git.me@ttaylorr.com>
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
2.31.1.163.ga65ce7f831

