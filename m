Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67787C43603
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B536235F8
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbhANCJv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 21:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729207AbhAMWZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 17:25:25 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A741EC0617A4
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:23:55 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id 186so4451004qkj.3
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eOAfwdgszWE6+IKgpnVgHm09fwsqu7Q3acsEhFfnltQ=;
        b=QbYuIw+k2+8DM4CaOLUnh5rBCFSJxvyZYTikWKVVchFpr+TrlhwYDnkvWLNwUNuMTE
         YGXrDevu+wMg5MBCL6UjziknmrcZTjsqtWi4E9Uk6YY56+B9qHM4I6LHM1QAg3Wjq/VH
         Mevzv7JoFlq508g3qRw5feYRQSBSachGL7HNyVXi2uW8ZgZ/w7qkCh7EH3HvGTCLXa0x
         0XJCgvGqqI9CdtQ/7lR1kqi35N8d041lzSEPu7ExafwD1AkM8rM3warFoxdniR4cSgew
         B1DS0oBx04nUommbKyY3tQz0z8+yqw3tB0H7c0m5p4puiOkGCUYVVhdjacPGMLG6ysQY
         Ot1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eOAfwdgszWE6+IKgpnVgHm09fwsqu7Q3acsEhFfnltQ=;
        b=hrvjH+NAct9cMHFi4tnXuFjgdXroGzlmoCqZMSpN4EkowduAXBbLtGUtnhtJ5CKjHE
         xxkgdZafndHMxD6FnMnyfSibtpOjuOkNvKnWO9kuAgiHEztUzxaRCVM8iR2pVtGmcTa7
         gANl89PKuR0fJ5iF9tqGh4s2rJldOnIqq/BP8orqsZ528Lcuql+gG3/RzeXcq92nDZSJ
         IFzTKWaUt1L29F4w4jTQhfy8wTrwPdt8+aKcFsVMf63PhZv4dsXI6oWiIMyi5QtqSuD8
         vHK1Yy/CxGUYvcl4vvySSDGk8EGH/VcdXJhdleAxEzn0Tu+IJTSVugo0NAZpIdgBteKy
         BokA==
X-Gm-Message-State: AOAM5324BQLpoQnfAaG5LeyVRzp2kiihvlzy83HWkOfx6gqmtPCDBfBv
        7PzOdCqqdie9OkBZccnHEkelf4pccpyRUQ==
X-Google-Smtp-Source: ABdhPJykKNXck0n3GZhUJBjaSLIm3YmLD5qKME6jWGc2U0sMpTuBssXdPjlYymS858ruq5NW5xEIcw==
X-Received: by 2002:a37:9b95:: with SMTP id d143mr4232046qke.215.1610576634711;
        Wed, 13 Jan 2021 14:23:54 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id e19sm1796589qtc.61.2021.01.13.14.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:23:54 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:23:52 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v2 06/20] bitmap_position_packfile(): convert to new revindex
 API
Message-ID: <084bbf2145735ef1affb0bc051b09dcff8f306ce.1610576604.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
 <cover.1610576604.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610576604.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace find_revindex_position() with its counterpart in the new API,
offset_to_pack_pos().

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index d88745fb02..d6861ddd4d 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -407,11 +407,14 @@ static inline int bitmap_position_extended(struct bitmap_index *bitmap_git,
 static inline int bitmap_position_packfile(struct bitmap_index *bitmap_git,
 					   const struct object_id *oid)
 {
+	uint32_t pos;
 	off_t offset = find_pack_entry_one(oid->hash, bitmap_git->pack);
 	if (!offset)
 		return -1;
 
-	return find_revindex_position(bitmap_git->pack, offset);
+	if (offset_to_pack_pos(bitmap_git->pack, offset, &pos) < 0)
+		return -1;
+	return pos;
 }
 
 static int bitmap_position(struct bitmap_index *bitmap_git,
-- 
2.30.0.138.g6d7191ea01

