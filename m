Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDABC433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A83FA610C8
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbhDISLz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234647AbhDISLy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:11:54 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05B9C061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:11:40 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id g14so729253qtu.8
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J53tdVoNb6hBZ5473C9fSuiXjh6lbniFFpei3psdk5M=;
        b=MZKhTD3Pmdy1z6/ZqDLdFHlDXnGEwh1o4MWoxnETNvPhZFSviDfRShk6l+HxEh3ihV
         uqM3I7sL1CqW95Gn429l6ETO2Q7+VMuJ/NYKOj1RTh8kSdOxzYXC4gnmNcci69TRFzFS
         HpTqdwdZUx/XpCjNeeXxh45957vVoZwq3NiqF0FYTlKdscihC/N/TqWngeYkwaEz16iY
         4MC4OlwWA51yWqHQIXkD1yW9GNIQg+eaP1h5d0QtW8HPs5wcFindxssoxsW9OAJrcEwL
         EzU+ch8bx0ATUVjHPkt3K6aifZGd6YTgwb4kFIq6IHiUqn8pUhxNn7hF52OnJdHYmueP
         zjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J53tdVoNb6hBZ5473C9fSuiXjh6lbniFFpei3psdk5M=;
        b=eZYuoMqH6xCrmwuMYHIsYPc3mH+PETucTDXAOCx2t/Nb7x0vhIprBjWOEO92olxHxZ
         rpy9CURjxhTLUAHNK4Z/WxvxmCksP7Z7VhSSL5bpNCAGP9GGhH8SREjCmmp2O8aU/gBZ
         GxGBCriFunyAGqbFv/H8xsySysdXE7FEVmRc6UiPYEl31BdVnHyyeRS9GmhnOkxkSIPK
         P+q8UKQ2hsrB4FseoRF0T5L8tdBc6kuWAafWtUSIRuGwzrZFQ+7bLPlfkLFzWcii3A82
         g1IU9tA3F14K2t7y7a21j104Sej0uSx2MmaZKtIreRLZAYjFOywFREZoIskik7Sk/ABh
         6JgA==
X-Gm-Message-State: AOAM532hn/8+8tDnuJpQRgqveg/VN8se5YTYnF08iw4ui4bsRzIMjh2i
        XQ1BinL3VAicA7SMQy49YvyTlPxqcSJ4G3k/
X-Google-Smtp-Source: ABdhPJxYvDSMge5ria+vXLvfO3mL0lpPnFYq2DcIKyuGSpU0fPyK5dNkVwCmMybVuuFe9t+bNzFtOw==
X-Received: by 2002:a05:622a:1c5:: with SMTP id t5mr13318810qtw.49.1617991899816;
        Fri, 09 Apr 2021 11:11:39 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:64f1:fbc0:31eb:386a])
        by smtp.gmail.com with ESMTPSA id t63sm902998qkh.6.2021.04.09.11.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:11:39 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:11:37 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH 11/22] pack-bitmap.c: introduce
 'bitmap_is_preferred_refname()'
Message-ID: <a78f83a1279f51aa8f362fe471a078463cabf21a.1617991824.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617991824.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a recent commit, pack-objects learned support for the
'pack.preferBitmapTips' configuration. This patch prepares the
multi-pack bitmap code to respect this configuration, too.

Since the multi-pack bitmap code already does a traversal of all
references (in order to discover the set of reachable commits in the
multi-pack index), it is more efficient to check whether or not each
reference is a suffix of any value of 'pack.preferBitmapTips' rather
than do an additional traversal.

Implement a function 'bitmap_is_preferred_refname()' which does just
that. The caller will be added in a subsequent patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 16 ++++++++++++++++
 pack-bitmap.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 97ee2d331d..be52570b0f 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1594,3 +1594,19 @@ const struct string_list *bitmap_preferred_tips(struct repository *r)
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
index 988ed3a30d..0bf75ff2a7 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -93,5 +93,6 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 			  uint16_t options);
 
 const struct string_list *bitmap_preferred_tips(struct repository *r);
+int bitmap_is_preferred_refname(struct repository *r, const char *refname);
 
 #endif
-- 
2.31.1.163.ga65ce7f831

