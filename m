Return-Path: <SRS0=BZy3=CN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F8EC43461
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 20:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 446D2208FE
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 20:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="mro4zUw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgIDUWl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 16:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgIDUWj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 16:22:39 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B794C061244
        for <git@vger.kernel.org>; Fri,  4 Sep 2020 13:22:38 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id o64so7578134qkb.10
        for <git@vger.kernel.org>; Fri, 04 Sep 2020 13:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UAOU+Ho+jKzkumdXOr62LrDTv4mofkzKiKUOmA6QIao=;
        b=mro4zUw8DJSmLC1oaN5ZCv9vvjsKy2ga6V/UoGmKc6sQILYHnWeP1xyP/VImU677Rd
         Zpfq1XqB2NrEOmaSoC962hl6YuriPE1S9bx0YpKlwjREDXMIcNAeo2e1BEkUxcRHU9RY
         MSsgvG06wECqFdSFHGW9SXFAdJ5huszISmHUFX/yD+DAHCW4vM3buDxowJE+/oMBA3p2
         R69hGiYXNfc83roXnd48YBhnHfw1ojv0YrQ2X7wiiBHWt5O7RNiJPYhdo0l7WnRGTmCf
         e0xz1prHI/Ks0mlpWh7fCaDV8bezuO8XwC2sD0u1eYdM4f9OWWv8UkO5+uZW9id1wTU/
         1BZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UAOU+Ho+jKzkumdXOr62LrDTv4mofkzKiKUOmA6QIao=;
        b=DvYoG6954KPaj4JdgZeI1umQTseyqWe5EY0zoUmLhgJ3Pod43CQryXUwzB2Qn8AVvy
         TSvQknTS7/PtGHED8maHQz3ezlRCMoHsUjo1hIYU8gJwI2x+AcGAntQ0B4PDcuHRLltd
         Ry8QKM0XrEc5mC5mLxeYKLCjXMID3VcwFvpFElu/HvFJ4/AMzQ91Y4l81s5ev2XPfTXZ
         XdF7EXaZ5Z+bcGuUdYqQJGVxxgfnZsPe/i4je1TW01sp53gqaYe2id+czJ7hJb3hou1K
         g0AU/a1jkZ/IvdWeZVDTFmGuLsLP0nDVqifWpzHQGBwZ9F1JQWnmvFlXRws1yLHqmT52
         bGZA==
X-Gm-Message-State: AOAM531iONpgyxeRQKbr7YEyzq47hQSUGSNar59hCh4aoT/VEKR1s7n7
        /hVOaFDPyeqxhISyR2lO9imM7g==
X-Google-Smtp-Source: ABdhPJz/hayafOkL72r39+DR8jDzF4Jk7CT7+V83FdKIOpOYWAZ9bo8QbZekAzH96lGXPoL9YoP5oA==
X-Received: by 2002:a05:620a:1274:: with SMTP id b20mr7867965qkl.220.1599250957720;
        Fri, 04 Sep 2020 13:22:37 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:550b:69c5:cc6f:b0f])
        by smtp.gmail.com with ESMTPSA id x198sm5338697qka.37.2020.09.04.13.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 13:22:37 -0700 (PDT)
Date:   Fri, 4 Sep 2020 16:22:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: Re: [PATCH v4 11/14] csum-file.h: introduce 'hashwrite_be64()'
Message-ID: <20200904202226.GA21837@nand.local>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1599172907.git.me@ttaylorr.com>
 <d7cbd4ca1a5dd63fb1d19ef97fac9765daa5ae03.1599172908.git.me@ttaylorr.com>
 <bca1af61-e664-b89c-03f8-9481c670baf8@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bca1af61-e664-b89c-03f8-9481c670baf8@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 04, 2020 at 10:18:38PM +0200, René Scharfe wrote:
> Am 04.09.20 um 00:46 schrieb Taylor Blau:
> "2 * sizeof(uint32_t)" looks slightly out of sync with the hashwrite_be64()
> call now; "sizeof(uint64_t)" would be more fitting.

Yeah, agreed.

> >
> >  		nr_large_offset--;
> >
>
> There's also this potential caller:
>
> midx.c=802=static int write_midx_internal(const char *object_dir, struct multi_pack_index *m,
> midx.c:981:             hashwrite_be32(f, chunk_ids[i]);
> midx.c:982:             hashwrite_be32(f, chunk_offsets[i] >> 32);
> midx.c:983:             hashwrite_be32(f, chunk_offsets[i]);
>
> Not sure it's worth a reroll, though.
>
> (I'd probably leave those conversions for a later series.)

Agreed. If we were earlier on, or there wasn't already a patch that I
had swapped out for a manual fixup after sending this v4, I'd certainly
fold these in, but I think at this point it's easier to apply this
separately on top.

Thanks for pointing them out.

> René

Thanks,
Taylor
