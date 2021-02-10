Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CE8C433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 23:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E332A64ED3
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 23:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbhBJXDo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 18:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbhBJXDc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 18:03:32 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7A0C061786
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 15:02:52 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id v19so1734753qvl.7
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 15:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EYhNG6uDl36Fk636pecOvD3mGyFobqJeCJlYOUVp89E=;
        b=GOlgDXNRViXoA1wZh5TNOMLl2UD49X+Ea9v3vRfJ4poWQzzX3tfKV1jCBz0n423+UM
         VJMdFUURefVTJKJcjF8b0RDrxVMFrFjCuzWycAzTyxxsrclGda4QNkAWfKS5aWYKuGhx
         fPixMs/dIu2Bmd+zaxF88CXzJ2pyXFtaYt/oT8Jyfyc10ucF9iX8XHXiUfyOASbkdILP
         S86MLbzXIF6KJk63ygHL+bLsCO5i2EOBr7LIwx/kVqKYJDZ3Pr4dDaZOGuxZXmMBfCp4
         VnciYENSVovSarcdYlk+pK/I/JAnBVif5lWamgdhGnbCQIzLOSKlBFRXjFxNCUL1/HHK
         E2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EYhNG6uDl36Fk636pecOvD3mGyFobqJeCJlYOUVp89E=;
        b=EoegGuSdkuuX9vcMKLP2opnwuZBZQCX/YutlGnnBptU6k81BJq7cl3fII2lFAyx1Pb
         +bhZq2XL6/JLyODn6jWr0jfw+TXM7jkDsWlQ1o8NnU8w8JNU73P4bX0ULbpYT52m+1nK
         Gy92hOdIqCWQd2dJSgSybGeqsMq6w7/7UBDULGXMT/z71qWbQtvDO9RPGmVwXhIzvTtU
         IoNZXW6j3wu6k6hB1iZegt3tssjbcaTk8aQMasH6YUNxZnVDHHCQ1Q015Kg8/Ung0Gsw
         GQVVSmkLB52jNVbk3kQDZ4K4PC7xW0lc2yo5nwqBgE/1juKDwWbUgMk/O7vPPBGEMAwp
         ToOg==
X-Gm-Message-State: AOAM530UeY0ITeEV5npqdsV1DryUuUAlM+pHkH1Z343LHvvoevlO/3SO
        9oNbJ/PvoV4jyk25JAR+OiU4Z4uwNXQ5mhu5
X-Google-Smtp-Source: ABdhPJxHxNMtiUVZeeNRy2QwGWInUbQqqBdJEbzbIqb6ZuA/36TcHW+G8SDZenJgONz2r9SXelobxA==
X-Received: by 2002:ad4:542b:: with SMTP id g11mr5222048qvt.47.1612998171050;
        Wed, 10 Feb 2021 15:02:51 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:2c3d:3179:bfad:c65])
        by smtp.gmail.com with ESMTPSA id f9sm1384475qkm.28.2021.02.10.15.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 15:02:50 -0800 (PST)
Date:   Wed, 10 Feb 2021 18:02:48 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH 3/9] midx: don't free midx_name early
Message-ID: <218474158a56d3638290989cfda3db92dd2ca606.1612998106.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1612998106.git.me@ttaylorr.com>
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
index 064670c0c0..34fb9de3f3 100644
--- a/midx.c
+++ b/midx.c
@@ -995,7 +995,6 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 
 	hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
 	f = hashfd(get_lock_file_fd(&lk), get_lock_file_path(&lk));
-	FREE_AND_NULL(midx_name);
 
 	if (packs.m)
 		close_midx(packs.m);
-- 
2.30.0.667.g81c0cbc6fd

