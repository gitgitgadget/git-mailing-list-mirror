Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9D9C432BE
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4FFF60F4C
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhHXQRB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhHXQQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 12:16:57 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53ADC0612E7
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:16:11 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id r6so21020535ilt.13
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AOplCxr4KKea766qJZRQdDVjvlAF/QreSsz08pLBxoI=;
        b=k5in38ZK3PXh5+rh5Fuqpnq3Ka9Yfuua7EyuSkaJxiolhGQA1iEHDCrhjxfzggzcSk
         G/Cy/MwjATkWmwapHZD7bxsktHbqDVrtGoXE0vnEc7TefzMuOX2JOpwJ05ehgIKW3aeR
         Q+Gh96r0uKEe8km0KKd1X45E2n7/oG9ScZpHCahLOPtVhPml7xqcvpF8WZiJeB37IWPa
         X94G/z0ZDxNA+Calb57sDQfqjmrMGiKPoRwOq4uUwdhwctu0pv9esLyUIIfSQhr7eQxv
         JO2yCahpF+zRtjzrU7SqCj14KGoP6XIIcJXL260ps4myGHyZDkQTbHBcvpbk68YdW3oC
         kd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AOplCxr4KKea766qJZRQdDVjvlAF/QreSsz08pLBxoI=;
        b=Bz+MNICuJft52tjlyPBx+xGKnMzGphTwCXry84wh3hk0XxONc3kj0wT38LGCYlrHZw
         +T+IZDdbo0LqwVLgH4GXLWihts2hYU/me6v46HmXhLz77n9EZ9qW4+296woW9nyOt08I
         pMEgpBT6+b/Z6xKDogEn+FHt+tTlGvtzE2MQzBhLb8ylLTpS9vdFTeH5Pk8zZaCA1GmA
         VwW8MNoX/Z2reQ7YUF0DlvmUknydWOVaJesg9XApWrBIJjUxFK4ue/owgSv/ay+bQTpN
         hYfj5fTJ62w9gMktVXpu8XD3i3Aj9tRriWHVr94aFnAxmPh/eo/mPksXCR6Wz1IM8y9f
         YkXg==
X-Gm-Message-State: AOAM530UhR+px1qn6KkBzcaKXwPyMU22NHubS0wBDKMdf6/2gRnRNHBV
        zFGonKdDG2BSnqq4DbSz4jYzyF0cNpCIYd97
X-Google-Smtp-Source: ABdhPJx3eNZp+LhkphGhUiH4Z2aiDUQ/tgnLhQdD1QavtxYA6PWEHiCvcGJyUcahSCZ8tjRvvK/mBQ==
X-Received: by 2002:a92:440c:: with SMTP id r12mr26945488ila.174.1629821771080;
        Tue, 24 Aug 2021 09:16:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o11sm10090032ilf.86.2021.08.24.09.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 09:16:10 -0700 (PDT)
Date:   Tue, 24 Aug 2021 12:16:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v4 08/25] midx: close linked MIDXs, avoid leaking memory
Message-ID: <aa3bd96d9bba8bbb3f31d91a482234519b668b5d.1629821743.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1629821743.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1629821743.git.me@ttaylorr.com>
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
index e5b17483af..0a515d8711 100644
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
2.31.1.163.ga65ce7f831

