Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C76CC433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 02:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbiCJCgB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 21:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbiCJCgA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 21:36:00 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAFCD95E8
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 18:35:00 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id p2so2858132ile.2
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 18:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZoJOBmbxnk8+Y2u3dJfJBIq6D9SZZDhGo0ViK4We/FE=;
        b=180zRQf8b3YGy2UFkhDXu+3P46tzPRT5ejkzUCB43RNAcLU1bR+DMyH0FVqKLNVISi
         nQrhBMSWAyuMWLM5MoVr2h56nAlZnR+PVP9IQ+gNsb6puwiSrvKMSCP1tWdmK5O7he6Z
         Y5U/0atSIGOrpsh9puTSGtygArxBWMFNMWLlvfX9Od/DfghBBdLqLEFKRW0ZtS0nu7LX
         bqNLCdftd+egIAijVYoXdmZ/fAp+BLdmDZWm1eSzdx40TPtLr5jss2KPrIEgGoi+ieT1
         TgZIIj1IXWpVgSaEG+MFC1lUcmkkrF522ueBl1MVnPknRycsXx9PEHTswqQHZNdlGUSi
         BmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZoJOBmbxnk8+Y2u3dJfJBIq6D9SZZDhGo0ViK4We/FE=;
        b=YA7UHgaoWlq03Fg0wHDvZ/TAteYoRMPpNVKEJpk2cWCodJrfTHQqgV/zWmoeFeGen3
         rwIuW0BBc/o6A4sdPDhrRq50M0UpXWWQsNTuzIkACQoeQwSZkzk8BPJW4zPqwRM74sR7
         tuV7C8bFkoSmziqiVQEJnvW8zCILRGtw321sdDCpqVXhwO3HR7BnKaVr8QekwE99Pk+U
         6+p0H6b9gLrswkI/Bi8hTZnUFS18uAd3MKPwDI1PHJj6QfGrRVcXHCVXnoUY5xjd+hjs
         xDv/gMp7NmQBMJfbNiyQFiLaA61T6jthQ6iGbmu0maAo0uqpGs4G1IIVeIjrx4cOXYUA
         3uIg==
X-Gm-Message-State: AOAM530pEtdjt35O6GdRlk1cuEPdRNlOJ7gGmVWDISbkshVD0L0jgj0D
        hHZ/Uth9kY/AnLMbXwMbrVccfw==
X-Google-Smtp-Source: ABdhPJwwCQ+xfQr3vK4G9F0FLEX994CHDYHok66xVBBnlLm5IvsQX4/1KtvQLX7448BWp2Dtitlu0g==
X-Received: by 2002:a92:da0f:0:b0:2c6:4d73:31b6 with SMTP id z15-20020a92da0f000000b002c64d7331b6mr1900457ilm.130.1646879699659;
        Wed, 09 Mar 2022 18:34:59 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m5-20020a927105000000b002c60ed6d3afsm1947005ilc.69.2022.03.09.18.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 18:34:59 -0800 (PST)
Date:   Wed, 9 Mar 2022 21:34:58 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] block-sha1: remove use of assembly
Message-ID: <Yilj0qMqk5eC4TKo@nand.local>
References: <20220307232552.2799122-1-sandals@crustytoothpaste.net>
 <20220308022240.2809483-1-sandals@crustytoothpaste.net>
 <220308.864k48y35f.gmgdl@evledraar.gmail.com>
 <Yikl2eGbc8sPsy5G@camp.crustytoothpaste.net>
 <Yikq7POhuxeN1UPQ@nand.local>
 <220310.86cziulls6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220310.86cziulls6.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 10, 2022 at 12:52:31AM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> I suspect it has the same problem.  My inclination is to just remove it,
> >> because my guess is that the compiler has gotten smarter between 2009
> >> and now.
> >
> > Almost certainly. I don't have a machine to test it on, either, but I
> > would be shocked if `make BLK_SHA=YesPlease DEVELOPER=1` worked on
> > master today on an arm machine.
>
> Why is that? The -pedantic error is specifically about
> "gnu-statement-expression", i.e. the bracket syntax, not the inline
> assembly per-se.
>
> The ARM assembly isn't using that, and we have other code __asm__ code
> compiled with -pedantic. E.g. I get the __asm__ in "compat/bswap.h" by
> default, and it passes -pedantic (the code starting around line 38).

You're right, I had this completely mixed up in my mind. In GitHub's
fork there is a spot I have been working near for the past couple of
days where there is inline assembly right below a statement expression.

The statement expression is what causes the -pedantic builds to fail,
not the inline __asm__. Indeed, if you just stick a memory barrier
anywhere in Git's codebase, we'll still compile under the DEVELOPER=1
builds.

> Isn't that __extension__ only needed *if* it warns under -pedantic,
> which AFAICT doesn't apply to all uses of __asm__ (but your compiler
> version etc. may be different...).

Yes, disregard that last suggestion :-).

Thanks,
Taylor
