Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F83AC4321A
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41E6C64ECE
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhCKRF2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 12:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhCKRFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 12:05:16 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC0AC061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:05:16 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id g24so1662645qts.6
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+Gr9GtCqTJRc1UVgIa/SsSLlVVG77SqMxRQG9i/0Fxc=;
        b=AMltkhTUSjlWM3gMvaj10V3jYSrjqm7v2xO4cUJhAd9NAHeonhCmcO3+v5w0b914vn
         nutt1lVlqUE0EN0vVWbyTuqs5yZSfEQLhLUVftsA1DwNUkzDcrjDiwhFOE4sFMwe2kZK
         83SPISzzC7WxFppgDssB7s6wv9lkKl7CtmqIHpMpyc/vNwl/vmERUwS4Xc3RbSZezEiW
         tjdwBVhM3du6GsflAIRe+5GGuEk3ClxHXrWJg2kolI6dE1GNxDuWF0jpV74nTcbgNFqI
         6XyBlqdxvte1Vr6P7TxKXm3LRkURXG3GBa46g7wyYJffxsdGSxhfxQVhROctKqMrvSiR
         5z1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+Gr9GtCqTJRc1UVgIa/SsSLlVVG77SqMxRQG9i/0Fxc=;
        b=ZeZ7ulw7+742I556D6MmIeO1UX0EJTwTD9EGbt/mAyRF/MVlIIs/NFid60cXTkLkH8
         KgDNFoge7ty1sBla5NXJdBpu/K+gOKj7H+gZ6s9i6dOY8Wq6x3NjKlpYF9+pjvea/iUM
         +vl8Tzua79ioI0y/e4YVY9+6p73w/w0r0j+uE83UIsHXE9TKKdDj+yTDIkAKrlKR7/ON
         HBUSNfJ9oB8MNHBEbZF2uLhgE3GO6H5ps/8DUmLLUhMLYJUYUiJCaIrnwKjPzg68KlPC
         xArFjQQHL8bObPXjDrWoTaNfNrZzH5jpKcdeLPsHrAyrtQ/WZAbKIZmyjLkBWW4CFPKI
         oEcQ==
X-Gm-Message-State: AOAM533j0XlL8L02oo0HbpqWAeW9Iwsm9srS+4jlqj6ND+OdeRbpvsyq
        DhReTgaPHsKNtHS64c9O6h3wvsWvM/kIB0HA
X-Google-Smtp-Source: ABdhPJx5q/Xyaf8RpTaRL1zk+HqSS+iGmCHsmd/HfCnjrbWPJPG333R8UkM5wJyle9tFN1bRzDvd2w==
X-Received: by 2002:a05:622a:183:: with SMTP id s3mr8260303qtw.223.1615482315372;
        Thu, 11 Mar 2021 09:05:15 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f947:1686:6ada:db5b])
        by smtp.gmail.com with ESMTPSA id d128sm2353700qkb.44.2021.03.11.09.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 09:05:14 -0800 (PST)
Date:   Thu, 11 Mar 2021 12:05:12 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com, peff@peff.net
Subject: [PATCH v3 09/16] midx: don't free midx_name early
Message-ID: <5c5aca761a69e245eaece97703366c9f8d06a889.1615482270.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1615482270.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent patch will need to refer back to 'midx_name' later on in
the function. In fact, this variable is already free()'d later on, so
this makes the later free() no longer redundant.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/midx.c b/midx.c
index 46f55ff6cf..e0009d3314 100644
--- a/midx.c
+++ b/midx.c
@@ -966,7 +966,6 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 
 	hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
 	f = hashfd(get_lock_file_fd(&lk), get_lock_file_path(&lk));
-	FREE_AND_NULL(midx_name);
 
 	if (ctx.m)
 		close_midx(ctx.m);
-- 
2.30.0.667.g81c0cbc6fd

