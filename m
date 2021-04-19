Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879C8C433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 08:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 564E06113C
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 08:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237873AbhDSIkB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 04:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237757AbhDSIj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 04:39:59 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E79C06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 01:39:29 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z13so37631856lfd.9
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 01:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x8Vj/yh148/4rycqOtmRu/aXtIVtjFBb/+XMlAcC3i4=;
        b=i+wpzO1KS/RhUIyJKqUatvs/YaAbPWG2NT4K27XQmbWQOq0lESvNrfhx+2QZFkgVF4
         vg+SfrRNYX+Tzqzvbe0urzNXOvraGeYd1ler+2/AhqcNT/XrlIxSxP/c6qJHCR0Mp2c3
         apeWE0TtoF15sBRMUkUcvvCMVDARryA8dqOnAslEH0d79tB8TzzGLVtMH1AkmPWdX3Rq
         XzX124uuELa7dTjPLAnC17X7c5SeJBinti56RzhYIdZgDml2OR36LJK8N3ZlpLm+LW/S
         5z6QPG/TJV6c+fT3C4xXn80Kugn51OnxOuXGIps2pmFFK0raYLnCmUc+6rUhVPknDSIP
         d7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x8Vj/yh148/4rycqOtmRu/aXtIVtjFBb/+XMlAcC3i4=;
        b=b8MF/ZefFGuvUfnNDKvWTPEsZq2oTTIRrUyx6QTJ3g2VYD8akzFxguvFs9Qz84+sb7
         0NlOPgGaYJ513ZgQepzQaUuGPC4iuR82rQPvKahyeiDwGA74hvy9h1z8b4RIBAZNSSEz
         AXPl8byQ6IOoYIHfkv9yD1x6ZLOArR/9k6rb4HW//MKnRhTwFTNokP2wHfQkY29W/oKt
         s3fv9IpFNNnRx3ijlQbBvc9aopLqx2va73pmY0eVqAtFLnedsbjTs9FFQQnwandpp9p3
         llEm9EXFY8Q8Q+2r0BoNhQPJy2D8VctdkKjSlhX8RbWErdf+bT6IVCrt8DwLoDr1FR/7
         0r3A==
X-Gm-Message-State: AOAM531MYnuOF7ncESV/C1zXzYVUgXgpgRqR2F5k2zadC/TZ0IH806ah
        +cHrL+wC05o9HRCJWGA7OsM=
X-Google-Smtp-Source: ABdhPJwYDsncEB3cDnom6mcCpx9Mug4oMZ78MaonOtGOIo574e4x65o0MNS1qY9cvILmRsehxAD/Fg==
X-Received: by 2002:a19:ca0c:: with SMTP id a12mr10128894lfg.74.1618821568264;
        Mon, 19 Apr 2021 01:39:28 -0700 (PDT)
Received: from aaberge.net (kramer.samfundet.no. [2001:67c:29f4::72])
        by smtp.gmail.com with ESMTPSA id f39sm16920lfv.44.2021.04.19.01.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 01:39:27 -0700 (PDT)
Date:   Mon, 19 Apr 2021 10:39:26 +0200
From:   Trygve Aaberge <trygveaa@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git Users <git@vger.kernel.org>, Miriam Rubio <mirucam@gmail.com>,
        Jeff King <peff@peff.net>,
        Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: Using --term-* with bisect breaks skip
Message-ID: <20210419083926.GD10839@aaberge.net>
References: <20210418151459.GC10839@aaberge.net>
 <c29ef929-4744-a498-540d-1b7df0afa0a0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c29ef929-4744-a498-540d-1b7df0afa0a0@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 19, 2021 at 13:58:20 +0700, Bagas Sanjaya wrote:
> The issue still persists without --term-* options on my computer.
> 
> To reproduce in git.git:
>   1. git bisect start
>   2. git bisect new v2.31.0
>   3. git bisect old v2.30.0
>   4. git bisect skip

Right, the issue persists with those commands here too. So it apparently
happens as long as you don't use good/bad, but with good/bad it works as
expected.

-- 
Trygve Aaberge
