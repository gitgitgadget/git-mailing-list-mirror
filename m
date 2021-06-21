Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B938FC48BC2
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2D12611CE
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbhFUW1s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 18:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbhFUW1r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 18:27:47 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BC1C061768
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:31 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id k11so4448386ioa.5
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RA82XER+UaVGp5h/ADQVWTL4DtiRmaqY4gy56FPe/Bc=;
        b=b9b9lfXeenW7UqvPbJAJC68zVgIJsySgptTKs2i45g2oR6OWEO/+GjAldT7Kp+98vY
         qYjpP8lta4Ugf97Kn7R6Pyz6SXSHMcqiRotRX1igieuki2sYMgy/f/grJaLsBr5NIOgj
         eQyF1V8FJhMdi+E1Tr5H+kHKe/G6g9DGPGEHOkHwzT4aNnhv2//y+MjSilYrurWy113p
         7ZrgWCWXSd4lJDUciYNV5t8zPVzdRf6PHPA1TRvZRaF17Gprl8Enu2cg4TbNlDqPfH/b
         HuiVV/lewVrmxL9bio8InUe9gytZU1OV0FY66w2LZN0E5muN+jgrnft3DorII8d75mCp
         DFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RA82XER+UaVGp5h/ADQVWTL4DtiRmaqY4gy56FPe/Bc=;
        b=uPugJxqhWNBWR4QpU4k0fy6LlCI3c306ZSRMUnWxU3L9H3WG2FtlLDwiVKPGBe4o4H
         FkD4qYkahbdBJk2z3y3FrDif7EWWyLPHRJMFQQXTdALXjLvJugGvgWs2LL63BXeNKz7J
         0hlpo3Yqvji901euvnhuQKnaiF8nAqNrcHngXhIMNEeGYsFYY8HEBsUJWgpJqW3zfMys
         vG7qW/Jsyk2++c7UjemIl2lS3xL84u3pFIszLQ38uz7tlGdsdYQMyhPdnf5tYt0kbn7H
         70FHz+OyPSoLXIT2A1R8aWR1fAIsf6gPNN1D7uS4vMrQr06w14OwQGhlmWRgUYWtGd6Y
         FxWw==
X-Gm-Message-State: AOAM5311UPFoiFiZmPX76YcsEwJOOanbYHnGOW5Z6nPtgDbLGmLgO6hK
        FZxGXE+zfNmI7/C+Agmg9vg9NTmqqRf6eb3A
X-Google-Smtp-Source: ABdhPJwoxOnsLTfRaGIF7sVKFFc3ZeOxQO7wcMXI7bSUsmnG9mvsJuVJMMTJznreyKYuGOHumgm6Pg==
X-Received: by 2002:a6b:6b10:: with SMTP id g16mr211069ioc.187.1624314330308;
        Mon, 21 Jun 2021 15:25:30 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:f6bb:34fc:22a7:6a3])
        by smtp.gmail.com with ESMTPSA id u14sm6995051ilk.78.2021.06.21.15.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 15:25:29 -0700 (PDT)
Date:   Mon, 21 Jun 2021 18:25:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v2 12/24] pack-bitmap.c: introduce
 'bitmap_is_preferred_refname()'
Message-ID: <c474d2eda5b0b4393616109915626134429085d5.1624314293.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1624314293.git.me@ttaylorr.com>
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
index 9757cd0fbb..d882bf7ce1 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1632,3 +1632,19 @@ const struct string_list *bitmap_preferred_tips(struct repository *r)
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

