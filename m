Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4910FC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 18:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A45461374
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 18:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhHXTAc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 15:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbhHXTAa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 15:00:30 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF658C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 11:59:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id me10so18033040ejb.11
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 11:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GiRKFudxIJXfdUsyy0z4YExnsFzEWMstZMKSn1zdn/o=;
        b=LXDKCY2p1mU8a/K1D9qrFjKAn5WXeKy9FIjLO8b3rajOT8E+sGMpmrrizGT9Ve/WMm
         qHslpcbnCi/sXnyvWoCvIbiDrszBcSXr9kdIT81SPhPiSQZZj4VcHTDlNzLTKbuz5eVJ
         lQtzV1UxxL9QiJQxVYfSyvhSdnTtO6zkKsnfRA/+8RU5leb50N4fTF5/11Wo6qU3qnGc
         VhiRx/9hRrfxgqOB/FOWb54lxPoFDj+6pW1l39r89LpAiX6JjqU5c0CxLAHh/RhoYaA8
         jtF98hCAr7ZnsM21oWsiGEHrcVlkPwG+WuFxoPMwpxJHlk1y/LzipOlLkUJXyeVtykax
         97nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GiRKFudxIJXfdUsyy0z4YExnsFzEWMstZMKSn1zdn/o=;
        b=rF1j1dogMWRBKuJpJyvKuXdZ9aWFXxkgaXyqiQqACfQglEDctA5fNXBLe72EK/I5aj
         xfRI/Ii9/ZO+C5yO7TDbo75Lpi0BhzEpacxrwEepI11tNMjfemzZFuZtX/VJEh2aJktN
         n5Ml3tdrxES1Sf2SYGF3We3P/bFqOB3FhZaquesQChtYKddQE4HExfFjQKxHU1+8NkW+
         Z59H2NX3OcH9rDQ0ESQrsLfy4OwJQ3e/wQsZuinONYfNHGFa1XVYeVtm6V2gAU/dzDDJ
         VMldAmun8yp1rI8kgDpCblZKd5+7JpzUUQTU2k5uagQwAT2TJS9AuD4t1/yWZSqL1e0O
         hiSw==
X-Gm-Message-State: AOAM530fhgsMBnHQue6/rcoW3Vb7kmzD321KbVAnsJGW9szxhby/wrgk
        Gd7n244LGqiJZFctvaeIEB8=
X-Google-Smtp-Source: ABdhPJw6vkhXTYlFoGDpz8BXVEU0fiG85JORxuiqIAtjxFnRkzDNVroa9LlUSJ++aobYKRAAmQ9c+g==
X-Received: by 2002:a17:907:d09:: with SMTP id gn9mr42835460ejc.447.1629831584409;
        Tue, 24 Aug 2021 11:59:44 -0700 (PDT)
Received: from szeder.dev (78-131-17-181.pool.digikabel.hu. [78.131.17.181])
        by smtp.gmail.com with ESMTPSA id p23sm12112390edt.71.2021.08.24.11.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 11:59:43 -0700 (PDT)
Date:   Tue, 24 Aug 2021 20:59:42 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Mickey Endito <mickey.endito.2323@protonmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] t5582: remove spurious 'cd "$D"' line
Message-ID: <20210824185942.GE2257957@szeder.dev>
References: <tV8xl8isDPhmGxCNmN06tTwhJTve0PsrkakKwLMcFQJybDZO2SGHHbDLZFrcLp1Yda1_KRygSm7-lVDSZSaG-antdalcPnhSqYqcK5Fpifk=@protonmail.com>
 <xmqq8s0rpwiw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8s0rpwiw.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 23, 2021 at 04:32:39PM -0700, Junio C Hamano wrote:
> Mickey Endito <mickey.endito.2323@protonmail.com> writes:
> 
> > The variable D is never defined in test t5582, more severely the test
> > fails if D is defined by something outside the test suite, so remove
> > this spurious line.
> 
> Wow.  Well spotted.
> 
> When D is left unset, we end up executing
> 
> 	cd "" && ...
> 
> and it explains why nobody noticed the breakage for nearly a year
> since c0192df6 (refspec: add support for negative refspecs,
> 2020-09-30) was written.
> 
> 
> Unlike the apparent
> copy-and-paste source, this is a more modern script that limits the
> chdir inside subshells to avoid moving around in the main flow of
> the test, and the fix proposed here looks the most sensible.  

'grep " cd $" test-results/*.out' shows that there is a similar case
in 't5323-pack-redundant.sh' as well, in test 'master: pack-redundant
works with no packfile'.

> > Signed-off-by: Mickey Endito <mickey.endito.2323@protonmail.com>
> > ---
> > To reproduce a failure do
> > D=/some/path/which/does/not/exist t/t5582-fetch-negative-refspec.sh
> >
> > Note: The variable D seems to be a reminiscent similar to t/t5510-fetch.sh,
> > which defines "D=$(pwd)". If you want to adopt that way, then you have
> > to code a fix yourself. ;-)
> >
> >  t/t5582-fetch-negative-refspec.sh | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/t/t5582-fetch-negative-refspec.sh b/t/t5582-fetch-negative-refspec.sh
> > index e5d2e79ad3..7a80e47c2b 100755
> > --- a/t/t5582-fetch-negative-refspec.sh
> > +++ b/t/t5582-fetch-negative-refspec.sh
> > @@ -105,7 +105,6 @@ test_expect_success "fetch with negative pattern refspec does not expand prefix"
> >  '
> >
> >  test_expect_success "fetch with negative refspec avoids duplicate conflict" '
> > -	cd "$D" &&
> >  	(
> >  		cd one &&
> >  		git branch dups/a &&
> > --
> > 2.30.2
