Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C738C47096
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 01:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 140AD613E9
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 01:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhFDBv4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 21:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFDBv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 21:51:56 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D476C06174A
        for <git@vger.kernel.org>; Thu,  3 Jun 2021 18:50:00 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id i5so6623779pgm.0
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 18:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1CAurXSHToAHkJ4D9KcwtbWpRHSNlG/ZW1zEMgO7EHU=;
        b=CcFgd7c+o0wItEVaASfsmm4N/lL0qmQQesCszq/ApLAxCAUGdTv9D+T2VLzrfCqtDD
         R9QxyZHHFYiwIFi3dMy60k4wkfHRf23uV5lhXtTGp/0431EV0rJrvugTQTMd/quhlyge
         Gj2zDFNkdrxKlDHTc4DkwflXaLfGx6kuYLLG0OaFRM4G1DyIsm8+cWIYQPEFqrwsDNUY
         EgGG4bCC38i8GMYvMQA2qtKabR6IC2Do8Vn8uIK1pNWGF/mvD4GbkEbd44UglSHJM4+8
         Rd394ROl+fq3ACbf5cipGLeqiqf3UKSIQdKKtJs9aVNRCaqQW2ok11RpyocOz0yNuJwm
         RkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1CAurXSHToAHkJ4D9KcwtbWpRHSNlG/ZW1zEMgO7EHU=;
        b=CgbGwZ4Gd0ur973O8fSU3zHO2icELkt5WcEMssMr0d+TZaQxTZATf3EPlmd+MP9qwR
         BEJVMw7YwA+D/A2h+oyyAQDlQFnhSWiGTWRKULDTmcmCE+7CuBS59ifdfFuIPec0odYp
         lyb9wnMVJo3UTj4ZhKh4EKM6xQsKsFr9T1/w1pdbxNNu41HKlir7e9hFXeP+F52D4gEV
         s9PgHpoEv2GFK/W6xXUkkvdgdgniYMV2LLLmO98jUXGFRhx+Y98swmBA9nrgfOCB0WDn
         gWaLJWnHbsCqQupNu4uk5t13k8Kw1s1BNVpJulZZyBHoF01RZPqmMwk11sfyADXQudJB
         WXqw==
X-Gm-Message-State: AOAM533EPUeyUE+MeNoQ78AjO7lNK0+NBJEgAYRG30St3MDnXLSjfuSc
        IJ4urhZdSvCey3n7BhjGTqc=
X-Google-Smtp-Source: ABdhPJyr5/qcN7wrM3DyJ/nUKCJX33iJ4z/uPbMfhcyqnj49gunlsq0FTsTZ2bNNkqBbGplgh4QjVQ==
X-Received: by 2002:a63:5f46:: with SMTP id t67mr2423346pgb.37.1622771399909;
        Thu, 03 Jun 2021 18:49:59 -0700 (PDT)
Received: from localhost ([2402:800:63b8:97c0:59aa:7727:6cb5:cccf])
        by smtp.gmail.com with ESMTPSA id f6sm274928pfb.28.2021.06.03.18.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 18:49:59 -0700 (PDT)
Date:   Fri, 4 Jun 2021 08:49:57 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Gmail OAuth2 in git send-email
Message-ID: <YLmGxcQ3s2gBbfe0@danh.dev>
References: <d93a3024-ba8d-3469-2dba-2e0032334232@gmail.com>
 <20210603180851.5tbnuvfb6auxrhvm@nitro.local>
 <CAPig+cT2fJqsptU0YpNQ=nhvU2Tu19zdHXxCin8fUkSkd97m4A@mail.gmail.com>
 <60b928374d90e_39cbe920835@natae.notmuch>
 <CAPig+cS74Ah3OyJPNQhvkdV6f7mkFgFQjHgfrrAE1gZsvN38RA@mail.gmail.com>
 <60b97dd1acd9d_3a18272087b@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60b97dd1acd9d_3a18272087b@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-06-03 20:11:45-0500, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> Eric Sunshine wrote:
> > Google requires 2fa to be enabled in order to create app passwords,
> 
> That doesn't make sense.
> 
> It's like complaining that you need to lose a limb in order to use
> prostetics...
> 
> App passwords are a suboptimal solution in case you cannot use 2fa for a
> certain application.
> 
> If you cannot use 2fa for any application, then don't enable 2fa, and
> then you don't need an app password. Just use your regular password.
> 
> > > And of course you don't need them for the second step authentication
> > > either, you can use any OTP client:
> > >
> > >   https://github.com/paolostivanin/OTPClient
> > 
> > Thanks, that's an interesting bit of information, though if a person
> > can't enable 2fa in the first place, then... (intentionally left
> > blank)
> 
> All you need to enable 2fa is demonstrate that you can *use* 2fa... So
> you need an OTP client.

In the past, when I tried to enable 2FA, Google always asks for my
Phone Number because of *security* and *safety* reason.

I tried to create a new Google account to double check my memory,
Google now requires a phone number in order to *create* new Google
accounts.

-- 
Danh
