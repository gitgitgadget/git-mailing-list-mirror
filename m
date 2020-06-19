Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6251CC433E1
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 14:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E98320771
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 14:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLjWWo+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgFSOHR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbgFSOHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 10:07:16 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86599C06174E
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 07:07:16 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id d12so4502920qvn.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 07:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5y7V0eSxaxSGbbwMAEnk0Xkd25YLUAlj9orBBDhO9hE=;
        b=NLjWWo+IqTMhbI9r5PwtDcB6Pdfl+1ypFX0qiFWdul5ksD3sbIi2pDulgHvUFOsa8D
         orDPBbiqBFtBsKM7A+dlpKFmi1j+w/BqOiDFoHoobf3+LwZhzGNNfBjFHfXQPD4MSk0o
         aljz/gVvk8jxy33qLYuox6ZQwJ03+15vONlzzCGXbq+PrTVlwoGBILLANkrws1IZUUoP
         eUglIG9rE3m/j6vz7hHnQvsVvd+PkDApgPUm2LVZkxfR7DZkJvFPNO9iSHTPCgYKS/bm
         4z48dgidbXLR6Yhsw0oNRfE9n4IvYa+4ookwOsMrNvV6fFlM0e+i6rQI365gU8pE3OjF
         wpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5y7V0eSxaxSGbbwMAEnk0Xkd25YLUAlj9orBBDhO9hE=;
        b=pJaBlx0q0iYwunYePmpdD9HH/y0G7d2qOmpeXXuKF1U27EB6HxXDZdrMxmsisZoNzg
         satLkS85agPscYUnw6VN9tbaJ9umaPs0HG14y98ZoGBf3bzrsCzfdJiO2j9NI+9SZ/lq
         W18VKWpig9E2WQYNJaq4MZx8Nf2HbUPXQYw5ODCegHZXRJS/KKuecCgPrdZh7L831pNb
         7VYDPI4NnHJTWmMsBqXC3I3NPsfFSy67O2LyLzZ5/Ky+a5EJ/EjlFycyXrW+nuvU19cX
         RQe5TpNB7gQZ48+jOXijsouWBaOHG5WqPt7OmMZfTiss+01oIlhaOwglCRyrXDCaGuIy
         lGxw==
X-Gm-Message-State: AOAM531Ar8+bjNadq56mE1k+xqUChN4BonWQXSBohpG9y6Kd00SdrllQ
        WQKNpFy9eJ+aOMStRe9A12k=
X-Google-Smtp-Source: ABdhPJz+YU/FlxtP0NpC2zOKes+/Gub4MpSJWcRhQqWqno0/TZaDpfaw3gZOEip+hwFuKsUwZsZLsw==
X-Received: by 2002:a0c:ee41:: with SMTP id m1mr8575153qvs.95.1592575635619;
        Fri, 19 Jun 2020 07:07:15 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id u16sm6276379qkm.107.2020.06.19.07.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 07:07:15 -0700 (PDT)
Subject: Re: [PATCH] commit-reach: plug minor memory leak after using
 is_descendant_of()
To:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <ada13c16-d964-c6ee-80ac-626edbc5f52d@web.de>
 <20200619133159.GB2540897@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a7621cce-b2f9-d4ce-2fca-85e23cf185c0@gmail.com>
Date:   Fri, 19 Jun 2020 10:07:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200619133159.GB2540897@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/19/2020 9:31 AM, Jeff King wrote:
> On Fri, Jun 19, 2020 at 03:13:46PM +0200, René Scharfe wrote:
> 
>> ref_newer() builds a commit_list to pass a single potential ancestor to
>> is_descendant_of().  The latter leaves the list intact.  Release the
>> allocated memory after the call.
> 
> Looks obviously correct.

I concur, thanks!

>> ---
>> We could allocate the commit_list on the stack, which would simplify such
>> glue code quite a bit.  That would be dangerous in case is_descendant_of()
>> or some other function that is handed such a list tries to consume/free()
>> it.  How can we be tell a function is safe to be given a stack-allocated
>> list?  Perhaps by marking its argument as const.  Or by converting all
>> functions to arrays.
> 
> Yeah, if we're not worried about the performance implications of the
> extra allocation, I think it's better to err on the side of safety.
> 
> I do agree that if we consistently passed an array (and length), some of
> these functions would get less awkward. I tried a few years ago to
> convert many of the commit_list uses to arrays, but it was a bit of a
> yak shave, since often they get lists from callers, who get it from
> rev_info, etc. And some of those callers _do_ like having lists, because
> they want to do O(1) splicing, etc.

Yeah, this constant parameter-conversion between the different
methods in commit-reach.c is certainly unfortunate, but persists
due to historical reasons that Peff mentions.

Thanks,
-Stolee

