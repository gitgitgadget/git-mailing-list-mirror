Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427E8C4320A
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 226A260ED4
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241277AbhHaUxK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241285AbhHaUxE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 16:53:04 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DABC061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:52:08 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id a15so818685iot.2
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R3g4w2GDtR7QylGU3LlZvxoKxtS5Vnhfs+azpWnhjiI=;
        b=Q2kuLAqVi9Khx9h6MF2BAxHBtPUp9uG8aYMnuq7pOLf6TYGyVXu1QmeHt1BWDtHd/N
         3mtefM0GIDVN1OR9GzPob9usZA4zl0OO4Pa1DNWz9ZXJJPKYnkcDriGUsb1FXMzo0dG+
         ecqbaQFGt/ryYiJDOslz6OSwDlffT4HPtDTP+PPahngCGL+kwr+D11aJQ+eSfGp7QicG
         qZ7Qdfvlazo8vbPp8Cwot2eHfFUtGhkOGDyFSOPbqV0xbiKU9ce/QNIJfuatsSaVIjzN
         xGkZhZnhGWO3MtUDYR8WtMvEHlW7Fga/aFiMYxRB0x+IWrC7bYzTL5SLX2G8P6vgNEg4
         qvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R3g4w2GDtR7QylGU3LlZvxoKxtS5Vnhfs+azpWnhjiI=;
        b=e2Q6+9sDvw1rxHV0HLLwsiwrKE/2b+VF+AHPkFjWEuGzmMeVBmLBvWjPuBMurh0Wqb
         VwCXzCq6IJ8m5KrqS3/kLo3uOJHEmhBeYKB0lPu/ukQFlVwO0cuIl8oowT7D+4OAXk8o
         LqTTbe4Lntje8bSlP1l6eM/Hk+oXkv0ZEF0Xtp9ADgx/dflr4Mybvjkvf98ZXmXsrIp4
         Xoh8rR4UIc0cOXQZ+gnFQHZ+xv6fGHy8mb0PgOBo7bIURIwmNgXYWRBVPtaMGDzwQjUY
         EKPbxUiKY2q7h0PCn2DbP59z/yR9KynZhgcWDQo75p83WVh84prDSwZEsB3u2tYQgit+
         2+Jw==
X-Gm-Message-State: AOAM531zKBr+F/ZKSmfxCrdmLX/cOx3Ur/maSpOOff8SB7lJ8UfIqfRX
        hGsL3qkvKyJFIs/obfbsU+1kiPeKleIuHm3R
X-Google-Smtp-Source: ABdhPJysqFPMG5vrjXJWJ7RUQ6xrOuEonDu+2SJ/UWmVX3a8Lag14wX9IqG1/yjepqf4juXiX1YhDg==
X-Received: by 2002:a05:6638:304a:: with SMTP id u10mr4737832jak.62.1630443127972;
        Tue, 31 Aug 2021 13:52:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y10sm10090309ilv.35.2021.08.31.13.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:52:07 -0700 (PDT)
Date:   Tue, 31 Aug 2021 16:52:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v5 10/27] midx: close linked MIDXs, avoid leaking memory
Message-ID: <6f5ca446f3820ae433c9fcbd7439f92a44d0eb2c.1630443072.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1630443072.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1630443072.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a repository has at least one alternate, the MIDX belonging to each
alternate is accessed through the `next` pointer on the main object
store's copy of the MIDX. close_midx() didn't bother to close any
of the linked MIDXs. It likewise didn't free the memory pointed to by
`m`, leaving uninitialized bytes with live pointers to them left around
in the heap.

Clean this up by closing linked MIDXs, and freeing up the memory pointed
to by each of them. When callers call close_midx(), then they can
discard the entire linked list of MIDXs and set their pointer to the
head of that list to NULL.

This isn't strictly required for the upcoming patches, but it makes it
much more difficult (though still possible, for e.g., by calling
`close_midx(m->next)` which leaves `m->next` pointing at uninitialized
bytes) to have pointers to uninitialized memory.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/midx.c b/midx.c
index 67de1dbaeb..e83f22b5ee 100644
--- a/midx.c
+++ b/midx.c
@@ -195,6 +195,8 @@ void close_midx(struct multi_pack_index *m)
 	if (!m)
 		return;
 
+	close_midx(m->next);
+
 	munmap((unsigned char *)m->data, m->data_len);
 
 	for (i = 0; i < m->num_packs; i++) {
@@ -203,6 +205,7 @@ void close_midx(struct multi_pack_index *m)
 	}
 	FREE_AND_NULL(m->packs);
 	FREE_AND_NULL(m->pack_names);
+	free(m);
 }
 
 int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id)
-- 
2.33.0.96.g73915697e6

