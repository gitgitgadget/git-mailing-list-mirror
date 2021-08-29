Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC37C432BE
	for <git@archiver.kernel.org>; Sun, 29 Aug 2021 20:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EA9160524
	for <git@archiver.kernel.org>; Sun, 29 Aug 2021 20:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbhH2UWQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Aug 2021 16:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbhH2UWP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Aug 2021 16:22:15 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265F1C061575
        for <git@vger.kernel.org>; Sun, 29 Aug 2021 13:21:23 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id g9so16800762ioq.11
        for <git@vger.kernel.org>; Sun, 29 Aug 2021 13:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IZIDqGN4BiGwnsfxEFxq07WNs2lCeXkcZolYWe9+MBI=;
        b=DHEqMQVxGDkuEhM03QjB1F5/md4T4U33n7sUHgF0UBXC2/lO0yziTes6XOms7Oo6V3
         Ojghzk5RSsJeV7a8OSjljdOQzHTzeqQawsoMBM501Vto7+dRWPQ9w0RLCBreyn0HVcVk
         PdYCIUHwyneBMEnRWEV8B+Y5xOjOvZiEhcJpT4cuMGu3eEgO/1txgM6p3jFHWc45i4Af
         p8sZy4mKQgk3R8tpn0eKenc7TxEBHScP0/t9AV0kHmGhZsUJPZVMlM5lLtFcnn5/nXFP
         QbXts//cJzSCpsSZeLPYwVD+XFjbQp+lS7GR6HeFdKZCjbmVtrhx8+xNnGLCklJwrHII
         Zr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IZIDqGN4BiGwnsfxEFxq07WNs2lCeXkcZolYWe9+MBI=;
        b=UJcQnytGpzVyYj1uyYIuKuKXipTtPyM9FQTfclEPbOGVZJf+WYia3ZFcOnEUH3disg
         CFWcfHIFD3c3dcpqZtbZlnId4GvRSUJNHP49hiiXfUfNeINvjJfWE1n6QnZVh9noTukP
         hSIoxEkXnj9K/OrFqp7uMVuNYqhBa2R+QU+jDNfiJ9s0qi50DKVcfWCg6cOgnM3pEZEI
         ml0NZusqNYmYUFsZivl3AAF8EpRmPx/5MD2j7PO/ZxW0aa/nqa7qaOl7UkMOd/6C5H43
         lPYF6p73BPPc5uoyQzPx+kMKq6r0RrtmOA3tcpdvsZjPrPSrzUDg3EfI/9VPkh178ErE
         vtJw==
X-Gm-Message-State: AOAM531hZC5at1nU2Df0o0d2bdHwXYCaUo3p6sw8N2xz2WG/ywFNPC/3
        sxIG4LX6uYiJjWMKtTD7AOnFgg==
X-Google-Smtp-Source: ABdhPJypeybXY24OYghAte4QWsAgLqZNeRv2+vPTltUgymlRZcF0igMQRNIx+EibHGxjJ+c+sh+e8A==
X-Received: by 2002:a6b:7519:: with SMTP id l25mr15135090ioh.169.1630268482337;
        Sun, 29 Aug 2021 13:21:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 7sm7266208ilx.16.2021.08.29.13.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 13:21:21 -0700 (PDT)
Date:   Sun, 29 Aug 2021 16:21:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge-recursive: use fspathcmp() in path_hashmap_cmp()
Message-ID: <YSvsQcGNpCMZwS8o@nand.local>
References: <512abaef-d71c-9308-6a62-f37b4de69e60@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <512abaef-d71c-9308-6a62-f37b4de69e60@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi René,

On Sat, Aug 28, 2021 at 11:30:49PM +0200, René Scharfe wrote:
> Call fspathcmp() instead of open-coding it.  This shortens the code and
> makes it less repetitive.
>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  merge-recursive.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 3355d50e8a..840599fd53 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -55,10 +55,7 @@ static int path_hashmap_cmp(const void *cmp_data,
>  	a = container_of(eptr, const struct path_hashmap_entry, e);
>  	b = container_of(entry_or_key, const struct path_hashmap_entry, e);
>
> -	if (ignore_case)
> -		return strcasecmp(a->path, key ? key : b->path);
> -	else
> -		return strcmp(a->path, key ? key : b->path);
> +	return fspathcmp(a->path, key ? key : b->path);
>  }

Looks obviously right to me. I found another spot in
t/helper/test-hashmap.c:test_entry_cmp() that could be cleaned up in the
same way. But this looks fine with or without the following diff:

diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index 36ff07bd4b..ab34bdfecd 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -28,10 +28,7 @@ static int test_entry_cmp(const void *cmp_data,
        e1 = container_of(eptr, const struct test_entry, ent);
        e2 = container_of(entry_or_key, const struct test_entry, ent);

-       if (ignore_case)
-               return strcasecmp(e1->key, key ? key : e2->key);
-       else
-               return strcmp(e1->key, key ? key : e2->key);
+       return fspathcmp(e1->key, key ? key : e2->key);
 }

 static struct test_entry *alloc_test_entry(unsigned int hash,
