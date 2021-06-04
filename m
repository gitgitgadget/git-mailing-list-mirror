Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A65DC47096
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 02:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58786613DE
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 02:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhFDCNX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 22:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhFDCNX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 22:13:23 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB4CC06174A
        for <git@vger.kernel.org>; Thu,  3 Jun 2021 19:11:24 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id q25so6345109pfh.7
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 19:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8JWA55Iw2q8Fo/60CINEb4NCkq1K1+etzSCslLJlIdU=;
        b=ToNPMeBz/rHZMU7pHDXO3Zf2xHVwjRSIfhUyeaEM5fpgHTQ40fXOubKsVIHoxM9S1c
         rdaiaP1Rl1PmxCgo1RdPNi3xXQPJBJV07j14C96KsT7Y6yNETfQ+vxddT0hr3jaGeLYs
         2uFMQ3/9/w5kk6IW5ERDvHlFEMgCvlSmM4J3UXc0YCF+iLHtcBp335JrPWEXP9qE/qK9
         OT9bXZF2FihqikrtS9MhvYMjwTJDHxrsYcOyXT2ew7KpK/3YDjSOrRaVomoneTBNYJOW
         O9YvntmeR/f+CzeoMCJn+5eEES1LwEmuXqhbcSM3tnJ0azi3V6QELU6g/GSLEp0ZvdTy
         AFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8JWA55Iw2q8Fo/60CINEb4NCkq1K1+etzSCslLJlIdU=;
        b=QOfl4eXB5Ix1lSQJb/iW3mX/O0B/6OC9qC9bIgK6c+hBLzSVd4tlT4o9YDTgpXxYJB
         jxYFqm2qi/UEv3YVr7n1Y3jT3WEycsKrK42noXwka5cbtgLkz/PuhK8T8TTKeVkONryF
         3fZBuXnL/TEDQvMtYWmJrOx8GDMvpP6EuVADVkoDksk3FV47zmX4fCQJPNsOTe+iRi9C
         n0I6XgfUnIiG/7vuUH6RxBIT1dGVnQ71OrklugxkJKvIKvz76GZhGGAkI9W8wV2mC71M
         xS/qPn1VmO3TBtHlynrEyPqhTvbFqoBfZE7jQ3WsFp953KKfHu8Zz4j34QsZFVBZqtzT
         d6AA==
X-Gm-Message-State: AOAM532QUJCUIRVP8D2oJwq+kPZwCyKbNmjGHKNiaqjHByCDo+f/sJUG
        K2uu8fuYFhRYA3P9gaNwEMTUP9ZUrvhbbg==
X-Google-Smtp-Source: ABdhPJwTiNbC9QM9e3B30nOSRfbnYbaZJwwj2UdhslyFlAzqUQbmAbp65bWrcrQxRFJmOBGra6FcRA==
X-Received: by 2002:a65:4109:: with SMTP id w9mr2478511pgp.24.1622772683975;
        Thu, 03 Jun 2021 19:11:23 -0700 (PDT)
Received: from localhost ([2402:800:63b8:97c0:59aa:7727:6cb5:cccf])
        by smtp.gmail.com with ESMTPSA id j16sm309251pfi.92.2021.06.03.19.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 19:11:23 -0700 (PDT)
Date:   Fri, 4 Jun 2021 09:11:21 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Gmail OAuth2 in git send-email
Message-ID: <YLmLyT0XmQ/lOBKg@danh.dev>
References: <d93a3024-ba8d-3469-2dba-2e0032334232@gmail.com>
 <20210603180851.5tbnuvfb6auxrhvm@nitro.local>
 <CAPig+cT2fJqsptU0YpNQ=nhvU2Tu19zdHXxCin8fUkSkd97m4A@mail.gmail.com>
 <60b928374d90e_39cbe920835@natae.notmuch>
 <CAPig+cS74Ah3OyJPNQhvkdV6f7mkFgFQjHgfrrAE1gZsvN38RA@mail.gmail.com>
 <60b97dd1acd9d_3a18272087b@natae.notmuch>
 <YLmGxcQ3s2gBbfe0@danh.dev>
 <60b98adc7f8cb_3a25c2208c9@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60b98adc7f8cb_3a25c2208c9@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-06-03 21:07:24-0500, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> Đoàn Trần Công Danh wrote:
> > On 2021-06-03 20:11:45-0500, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> > > All you need to enable 2fa is demonstrate that you can *use* 2fa... So
> > > you need an OTP client.
> > 
> > In the past, when I tried to enable 2FA, Google always asks for my
> > Phone Number because of *security* and *safety* reason.
> > 
> > I tried to create a new Google account to double check my memory,
> > Google now requires a phone number in order to *create* new Google
> > accounts.
> 
> Presumably if you don't have a Google account, then don't have a
> gmail.com address, and you can't use Gmail.
> 
> So why would this thread interest you?

The first point ;)

> > In the past, when I tried to enable 2FA, Google always asks for my
> > Phone Number because of *security* and *safety* reason.

-- 
Danh
