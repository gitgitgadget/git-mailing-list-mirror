Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E490CC433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 02:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5D3661936
	for <git@archiver.kernel.org>; Wed, 12 May 2021 02:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhELCrO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 22:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhELCrM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 22:47:12 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF06C061763
        for <git@vger.kernel.org>; Tue, 11 May 2021 19:46:04 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id c8-20020a9d78480000b0290289e9d1b7bcso19351785otm.4
        for <git@vger.kernel.org>; Tue, 11 May 2021 19:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=AzEF46zn5SqpvOckCtgpdZakgxAHe+5BS7JAPyUo2RA=;
        b=k42umCsDuc8AnDMAExBCPeM3gBueECPMvRii4EwLwM+/wMQJUf3u8G47uCMaWVyJZt
         TcJ8AZIM3kaZtvwPpRsTqg1YDWEZwgmLLP3wDP9EjNUVMCBRw8JAFxDO85/Q1rDlWkc0
         7d6OYrym/sTt+dCeacT6K82j44MY8ako7d2H6vpoBEKoSypRqknOkjH49saX6Dn6m92j
         j2cn5UDzFPvwQMVrd5Sko6tLMShdj2EMS62iKXbEe8VBAb6uXSrabxAOnX4DXkXqQA3p
         04rQV6/8bodNej05WfEd0RriuwypalMsWD7MB/izkKjvOdpORoYJRKSYIQIK4bm8+xiZ
         9gyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=AzEF46zn5SqpvOckCtgpdZakgxAHe+5BS7JAPyUo2RA=;
        b=BvS8oylU/uvsCHC/E4JWxH9Ik2DpryBusDeB0Ixzj2EKtoH0oa36SMAV60iqUfMIjN
         IOOHVEOEnCAY+UcwuSp1iXUIRpyDbAOZb2+hvfk7YN1DdBonrRSlA4/ym9FbpUmVZD1Q
         Dmm9xUbuU7Ghx+XoJA/W7O/RpCCVgSvNFncjpS+tE2XyWmcPZFMuf9ZpaXlJKkw4kGqS
         CfId0mDGrkI944DQPisJf1JpkyxKuVIpZ6388GoiEdAQHW/ozd4wnYb0wevC6cdQston
         OwutqE7r6PRq9O+QfEpekZ7xDfQdRLzT/PMp4tHs3Lxc3q+EegBP+4+ix4S0xd8BJdwO
         QCLg==
X-Gm-Message-State: AOAM530MloWqeY3+yjHqhebflgM7fwgKrAC0IUL4SE7z4uVuyv7fZuw4
        X9tpodZssWw6GD/2MCdgsbSmxmMAuFie7w==
X-Google-Smtp-Source: ABdhPJxcmPbH/sJN8ljanMoqG1dMehbZ9hO3lPHGcEq9csijcISBE+Fetn9Aqsk87hRdFF4nE0drFg==
X-Received: by 2002:a9d:6951:: with SMTP id p17mr28578637oto.222.1620786909621;
        Tue, 11 May 2021 19:35:09 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id w66sm3709323ooa.37.2021.05.11.19.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 19:35:09 -0700 (PDT)
Date:   Tue, 11 May 2021 21:34:57 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>,
        Varun Varada <varuncvarada@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Message-ID: <609b3ed1c280c_678ff2088a@natae.notmuch>
In-Reply-To: <20210428085838.GN6564@kitsune.suse.cz>
References: <CAD2i4DBj6fNvq=Lc3KiXJj5uBpteyKfEKp7ATOWrTE36KUeRww@mail.gmail.com>
 <20210406092440.GZ6564@kitsune.suse.cz>
 <CAD2i4DDr3Ftk6RE8cA74iSsJTpC9nEb=Cqvr79pF51BpcWEnsA@mail.gmail.com>
 <YGzoX9OeWMKXpqtf@coredump.intra.peff.net>
 <CAD2i4DDNZ+oOgtp8dcgqwUjtwaTYnNmg2E0oC88ZDW3LYMBiRw@mail.gmail.com>
 <CAD2i4DCtqxziTy5TPjG+U8EGC+8daJGXjpVgxoJwp8__t8fqxQ@mail.gmail.com>
 <20210428085838.GN6564@kitsune.suse.cz>
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Such=C3=A1nek wrote:
> On Tue, Apr 27, 2021 at 07:39:57PM -0500, Varun Varada wrote:
> > Here's the updated diff:
> =

> As already said multiple general purpose dictionaries recognize '(have)=

> strong effect' as the meaning of 'impact', in some cases even the most
> common meaning.

Having a strong effect is not the same as having an effect.

> In case you have some issue with the word 'jargon' Merriam-Webster give=
s
> this definition:

...
> 2: obscure and often pretentious language marked by circumlocutions and=
 long words
...

> which the word 'impact' does not fulfill.

That's a value judgement.

The word "impact" as it's used in the git documentation can certainly be
considered "obsucre language".

> Further, you would rarely discuss and document an effect that is
> negligible so in vast majority of cases '(have) strong effect' (ie
> 'impact') is synonymous to 'affect' and 'affect', respectively.

Nobody is saying the effect is negligible.

An effect can be noticeable, yet not especial in any way.

-- =

Felipe Contreras=
