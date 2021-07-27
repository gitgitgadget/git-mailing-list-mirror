Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F54FC4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2313E60F9C
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbhG0VVp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 17:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbhG0VVX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 17:21:23 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2A7C06139E
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:19:55 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id m13so408110iol.7
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o9+qZ2NNd8ITQPR8Xi3EzbT8NJyiS+QVLRIjEZy9Lvo=;
        b=eqrE+2Iz4AlkZJ+nvi277aUkybhvTOhrHlc4a4vuA/RqItMF3T8rQ7DX6YK4jCRd+i
         c0q96leWO7K4Y9E6HntrCS98gR4FIXzrb9eXSoFWtPU00U/KAKAlmOYYf88eBLoY6OkG
         sDQK3uCfeiIgFL+96EDvZfXWpOY+XWCss6suRP09WQhLS+Nzcg0roeRKwzHApMvVqMXa
         9RzA9qD9xnJv2F48g9RY6W5EqAqA3LAiKKaxQeCksUjrBU3RUDlmz1y4qLKwYE+0xnQ+
         dymrsa/8yMh4QdZxgFNpNpqeBHdcigZ0jCq/ZOtmmpsvBa1dxoIW7n24n+jCK/demszt
         wxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o9+qZ2NNd8ITQPR8Xi3EzbT8NJyiS+QVLRIjEZy9Lvo=;
        b=KbSmdKOvS8yOEp/CwEGIeFJLY3afEsNKXZg2cPTtSxaWzCs4ft0/AdReiy9CORMXbj
         pJsIN7hOzBgiaZG+8obCinEBZ7iDk1QMc9ce6m8gBJOjfIHYCwiIUVQO6fCHqEYdHPa4
         hOQllj42JpvjI+7GO2+v6vbykgvk2fS6Qj5M8lgEtLFF8H27AO9tg3Khjdr4A0d3hcGu
         r/XHPlBIjm2bqch9IVwYIazwr6664VlblMa+EYAHhBB/DcVf2Yh+3BZV8XzbvNJ5Cdok
         yWqWqEmTPCufbmt3HZmCPhtdWZhQMfVWce3x9a/0pLvda9+QgeW0DipTGINZ7Kra6CSG
         BkGg==
X-Gm-Message-State: AOAM532LUM5vEdQIV9a+u8Jn5E5t4p/Zd5M7B26Y0gel9RWWFeAUbtIl
        HZHI56WZvChKtbDMNRAzxJBwYNOksfGflnMt
X-Google-Smtp-Source: ABdhPJyXmzM+zsFXCydtRGZzoiYncx1s07knsn/NnfVpok+dr5uLNJXLJyaxzfgLknHmqnUAnfFfqA==
X-Received: by 2002:a6b:f40a:: with SMTP id i10mr11284819iog.139.1627420795371;
        Tue, 27 Jul 2021 14:19:55 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:6813:d625:75e6:4f64])
        by smtp.gmail.com with ESMTPSA id x11sm2572046ilu.3.2021.07.27.14.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:19:55 -0700 (PDT)
Date:   Tue, 27 Jul 2021 17:19:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v3 12/25] pack-bitmap.c: introduce
 'bitmap_is_preferred_refname()'
Message-ID: <743a1a138ef236e876f2c18257e5f4213c3acbc9.1627420428.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1627420428.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1627420428.git.me@ttaylorr.com>
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
index 9d0dd1cde7..6b12c96e32 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1652,3 +1652,19 @@ const struct string_list *bitmap_preferred_tips(struct repository *r)
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

