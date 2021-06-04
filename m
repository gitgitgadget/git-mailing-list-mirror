Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455DDC47083
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 06:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2939761405
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 06:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhFDG0F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 02:26:05 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:47057 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhFDG0E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 02:26:04 -0400
Received: by mail-pg1-f175.google.com with SMTP id n12so7008754pgs.13
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 23:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VCPwnMQhVt+oaDBMuR1dOD/d2VU9spHYlXNwmPhM4xY=;
        b=ngVn22ZzhQcZYsR8EBrQcqhVUfBWOP3FNZYoc3wclVk7ka4Oi/1WXzS2HTv9+9WSM+
         nlKgqja2xUJHOPfggiMOPdYZ/avqZGlOWAurLg4IvC73uUAMAOsvM805/RsESf0oMq/5
         JmDo8sfRKbv2b5jw85qnEdOSu2jCsyXD5Sin4QXV86mBYseeriY5ogrB7lOfw8Zi5gFT
         MCjc8h3iHdUM95BOG7PSRSyq6GcqvAxj3i/pJexZ7etQa+GODnZujSOU8BkLXjryIur+
         fbS7BD7BUkOLdyIkya96ENsUhXPAiNpjHSl/uHSJnfamkhDmr5wyC9hFgTotNdgdBrh2
         Nbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VCPwnMQhVt+oaDBMuR1dOD/d2VU9spHYlXNwmPhM4xY=;
        b=kCEpl2sy1taQOxnnIc1nLi32/k+M8W7dKNapx6chR6uY6Os1oTgA6wAem1N/Ii9h+T
         d6jb0ZqSnL7SiMDr69coxw2vCPs5CtkQJ2mhCwVVbkv/Yfo7J27OMFZvLVQiQKQz+ZhH
         2y6Ef1OGmtiLA5nrwt+Ou178Mj2f7F8tkMWvdqMb6CrNmLe2hfX+BvM2HqzLq9ObnBBb
         t1TUVtHfj/zlRoWu1eS/wdgjwk7WFdSq2OMETASXqQz+zyu54x22Zp1GwXU54izfrvyL
         8WCDHdAWZn76tKiL4Ttvo4S8K4qjZ+nkgtDUS7JL2tc6RLvr2xnohk7rrqDzNBJl7qx+
         0MJA==
X-Gm-Message-State: AOAM530ruRr6aDNAC209U11ToJlondRL2QAxKgxlqY25nS0uwNJJCqAJ
        dSXmLCEcNAsnsCOQvGWkEtY=
X-Google-Smtp-Source: ABdhPJyMX3Vp7tjn8W+SCU04KX3s+kPz1mORKq1wXIliSHmtOyKrSt0xuPtgi1vLTVoxxs7SuKRqpQ==
X-Received: by 2002:aa7:8507:0:b029:2ea:559:da5 with SMTP id v7-20020aa785070000b02902ea05590da5mr3025149pfn.45.1622787799051;
        Thu, 03 Jun 2021 23:23:19 -0700 (PDT)
Received: from localhost ([2402:800:63b8:97c0:59aa:7727:6cb5:cccf])
        by smtp.gmail.com with ESMTPSA id x3sm1021789pgx.8.2021.06.03.23.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 23:23:18 -0700 (PDT)
Date:   Fri, 4 Jun 2021 13:23:16 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Gmail OAuth2 in git send-email
Message-ID: <YLnG1Npa9rMYyWJJ@danh.dev>
References: <CAPig+cT2fJqsptU0YpNQ=nhvU2Tu19zdHXxCin8fUkSkd97m4A@mail.gmail.com>
 <60b928374d90e_39cbe920835@natae.notmuch>
 <CAPig+cS74Ah3OyJPNQhvkdV6f7mkFgFQjHgfrrAE1gZsvN38RA@mail.gmail.com>
 <60b97dd1acd9d_3a18272087b@natae.notmuch>
 <YLmGxcQ3s2gBbfe0@danh.dev>
 <60b98adc7f8cb_3a25c2208c9@natae.notmuch>
 <YLmLyT0XmQ/lOBKg@danh.dev>
 <60b9a1d25b63f_3a3b7e208fd@natae.notmuch>
 <YLm4dn4INFPhg2OI@danh.dev>
 <60b9c17ae2306_3bd68520833@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60b9c17ae2306_3bd68520833@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-06-04 01:00:26-0500, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> Đoàn Trần Công Danh wrote:
> > >> > > In the past, when I tried to enable 2FA, Google always asks for my
> > >> > > Phone Number because of *security* and *safety* reason.
> 
> I still don't see what is your point.
> 
> If you don't have a Gmail account, then why do you care about particular
> ways to authenticate into a Gmail account?

I have a GMail account, and I have 2 FA enabled already.

I was talking about my experience when I first enabled 2FA,

Google required me to provide me a phone number, which I hadn't
provided prior to that point.

So, someone else, who haven't enable 2FA and haven't provided Google
phone number, may hesitate to enable 2FA.

The second point is me trying to validate my (usually bad) memory.

-- 
Danh
