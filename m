Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D65C4708F
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 05:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D54361359
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 05:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhFDFYB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 01:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhFDFYB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 01:24:01 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4053C06174A
        for <git@vger.kernel.org>; Thu,  3 Jun 2021 22:22:00 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so6780717pjp.4
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 22:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=53aFb97nJwirIEb1UOpG57LP0BpAJ4gUW43LUggGPj0=;
        b=Xj/M38qRzpSX0P02hMoiRVVDJKSpLrTPh45aYSgSGW50jnk99r915oY92ZCCjI47Gf
         /hmhh3tGX6rd9a98reweJVJkzseoMDLV8h/4nc+a2zRgAKthcBM821MXbijWvzb9bj0O
         GPQ/FlJIKOeNpGIJ3RCc9qQCJMN6UO6pohxG+Kwnj8Xn4BhJM9wmzFb9YUVfotw1v6KQ
         DwaYBCOqIG9ZwHxPDjd8pS4M8KZYa4hGEE4KkgP0+twb2n/7sO/K2gVQT8hu208fmkFL
         bchhJA8EDMKs1qiq5TM8tyDEDllE0WYYlGK+gPpcGMdh7ggpeZ01FtYMQM6e2z77hDLC
         G3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=53aFb97nJwirIEb1UOpG57LP0BpAJ4gUW43LUggGPj0=;
        b=BXSGNM760YbiI3sYSobAfXVhozTGUFHdAf7zINJfrxmEpIK9IsEzdV0aHPHQ1mIUOk
         Enhxh3kHxfgR5t0AnSTIN7w/xzhIo0BC0yGOSWBhdhw8ZMXJebYYXr7sbHXF5f8NXvh/
         z/x+PVLESrDjOQHHRLLhGfjuJT9gZGALPWdaFSQe49hkYtjKoPJUo5gJ2oaMBZvIYGGL
         5k9xWmxbVGu+oNfmU8nD9xP4LKJ8KGC1lDn9gntb2SKhXpfI1LlJr1JdQ8Tmb1HLNyBX
         4irJ+YMNjw6AsinGf26a4OZv/3XC2TI7i6otMTOMd/1TEQpbbPJ6OMbC/R/8c5wisAFr
         hCSw==
X-Gm-Message-State: AOAM530skV1eA/X8VohN6Y8Wiq98zgXqF51NSwPA3Fl/ErwmWHa7irHq
        kvQuAyHG6iY0ghJoALvhMl0BTRdMe13Ffw==
X-Google-Smtp-Source: ABdhPJxzm/ZdjblLs4AmcL05GpN+7IUU9faVPeVofyfZ9I7SfxWhgEQRMkAlhEB3j7UcDhPsHlZIQw==
X-Received: by 2002:a17:90a:6285:: with SMTP id d5mr3078541pjj.3.1622784120475;
        Thu, 03 Jun 2021 22:22:00 -0700 (PDT)
Received: from localhost ([2402:800:63b8:97c0:59aa:7727:6cb5:cccf])
        by smtp.gmail.com with ESMTPSA id x20sm394534pfu.205.2021.06.03.22.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 22:22:00 -0700 (PDT)
Date:   Fri, 4 Jun 2021 12:21:58 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Gmail OAuth2 in git send-email
Message-ID: <YLm4dn4INFPhg2OI@danh.dev>
References: <d93a3024-ba8d-3469-2dba-2e0032334232@gmail.com>
 <20210603180851.5tbnuvfb6auxrhvm@nitro.local>
 <CAPig+cT2fJqsptU0YpNQ=nhvU2Tu19zdHXxCin8fUkSkd97m4A@mail.gmail.com>
 <60b928374d90e_39cbe920835@natae.notmuch>
 <CAPig+cS74Ah3OyJPNQhvkdV6f7mkFgFQjHgfrrAE1gZsvN38RA@mail.gmail.com>
 <60b97dd1acd9d_3a18272087b@natae.notmuch>
 <YLmGxcQ3s2gBbfe0@danh.dev>
 <60b98adc7f8cb_3a25c2208c9@natae.notmuch>
 <YLmLyT0XmQ/lOBKg@danh.dev>
 <60b9a1d25b63f_3a3b7e208fd@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60b9a1d25b63f_3a3b7e208fd@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-06-03 22:45:22-0500, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> Đoàn Trần Công Danh wrote:
>> On 2021-06-03 21:07:24-0500, Felipe Contreras <felipe.contreras@gmail.com> wrote:
>> > Đoàn Trần Công Danh wrote:
>> > > On 2021-06-03 20:11:45-0500, Felipe Contreras <felipe.contreras@gmail.com> wrote:
>> > > > All you need to enable 2fa is demonstrate that you can *use* 2fa... So
>> > > > you need an OTP client.
>> > > 
>> > > In the past, when I tried to enable 2FA, Google always asks for my
>> > > Phone Number because of *security* and *safety* reason.
>> > > 
>> > > I tried to create a new Google account to double check my memory,
>> > > Google now requires a phone number in order to *create* new Google
>> > > accounts.
>> > 
>> > Presumably if you don't have a Google account, then don't have a
>> > gmail.com address, and you can't use Gmail.
>> > 
>> > So why would this thread interest you?
>> 
>> The first point ;)
> 
> Which is?

Which is the point I specificly copy-pasted after that comment,
and it's also the point you stripped out.

I guess it's my bad that I wasn't very clear in the original comment.
So, here is the quote:

>> > > In the past, when I tried to enable 2FA, Google always asks for my
>> > > Phone Number because of *security* and *safety* reason.

-- 
Danh
