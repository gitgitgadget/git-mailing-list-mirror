Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27FDC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 10:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8827613A7
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 10:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235931AbhHXKD6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 06:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235808AbhHXKD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 06:03:57 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CDDC061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 03:03:13 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j10-20020a17090a94ca00b00181f17b7ef7so1431799pjw.2
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 03:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Bqy0fN7m9Xn9BhVrbRUJ2YcmOfca2Xa2bJxcx1eLULk=;
        b=PGkki+21Ahdc4EDHG5j95ZBFSKsdA7iyLNYR9LmqFQOaVSkS4rLQ5AtP/HoCJ9Fls6
         OolAlWOci3c0GNLH+j0Ru5vZgVaeDkYEpdbfy8TWOHKe4JNbe7YrR/P0QO/9EyET9Nur
         ZaSlkJcWXUDbToFELBgD3LOa0GzkJ3GFHOojfociWZ98sDaA1uZmkR6lQjl73rXFPqd5
         Qo45ldetPA9AIoQY37asvQ3FwUA4qoX1nrPiSZ3ViaCTLs2mOg25FMgavGcBDnoG6+H4
         1hNUFZmC+zgMYIQW7VkM0ljJfvdNuc8KAsx5xKWcdG9Q3Ef/zuj1//JbXmBdIw57+zwB
         nMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Bqy0fN7m9Xn9BhVrbRUJ2YcmOfca2Xa2bJxcx1eLULk=;
        b=Ex/xpZ/W5VDzBzd6W5NsgtqGJ9B/LOGRGujQ76FI+j+goCharw45rDk0Yc31/ywqI9
         JOd6xy+n/h1ISMlwygNNh13rGrLIVR+3mIimlL8YbTy9+6ppe26E1P+ecRPYVRO3GjRr
         mTzvjx5UxiCspdMmIriEgbO+aHIsUA/jWxe181GT0yxBSUJmIdXacgEaUsOiL9PH28g+
         xN4uQJepZNuXjLF69SCBkc0cNzEvGrDM2hq6IAhpuRn3jqNotTEByDJeAkNi4SnGkfkb
         wjH3xPN6+5xbfnXXxZ0778GdrIO0yyIZ0Xa7inRW0zxLE6crUabtkXFenhHDtrul5lWf
         T6yA==
X-Gm-Message-State: AOAM530/BFT+fk4SxU571jf4GIqkOeW0QnyhTatQMudasjyJ8NeOSJ7C
        p0F0nDPV9leNCIKjctEjt/8=
X-Google-Smtp-Source: ABdhPJwmQzpdX/x1ei+641bPz9nz0VScH1hU/NRnmZ2AfXztFqQ5dw2RylQ/UW/wnwOQPvtSbJTRVg==
X-Received: by 2002:a17:90a:680c:: with SMTP id p12mr1101294pjj.33.1629799393276;
        Tue, 24 Aug 2021 03:03:13 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.210])
        by smtp.gmail.com with ESMTPSA id e11sm1928915pfn.49.2021.08.24.03.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 03:03:13 -0700 (PDT)
References: <m2lf4wys5o.fsf@gmail.com>
 <b6ba6b44-c5f5-63f4-7fd1-19a1acd34770@gmail.com>
User-agent: mu4e 1.6.3; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Shourya Shukla <periperidip@gmail.com>
Subject: Re: [GSoC] The Final Git Dev Blog(s)
Date:   Tue, 24 Aug 2021 15:30:46 +0530
In-reply-to: <b6ba6b44-c5f5-63f4-7fd1-19a1acd34770@gmail.com>
Message-ID: <m2h7ffdusm.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> On 20/08/21 8:05 pm, Atharva Raykar wrote:
>> 2. Reflections on Working With the Git Community:
>>     https://atharvaraykar.me/gitnotes/final-reflection
>>     This is a blog post that I wrote mostly for myself, and other people
>>     interested in contributing to Git. It covers my personal experience
>>     with my time here with the many ups and downs. I also wanted to thank
>>     all the people who helped and collaborated with me in these 14 weeks.
>>
>
> Good idea on trying to separate the reflection part of the blog from the
> actual final report blog. This way, you didn't have to worry about the
> report getting too long due to the reflections ;-)
>
> You could consider linking each of these to the other ones, though. That
> would help tie things up.

Okay, that's a good suggestion.

> Some other thoughts:
>
>> This mild dogfooding went a long way into making my work feel far more
>> enjoyable and meaningful (if working on a project used my millions was
>> already not meaningful enough).
>
> Dogfooding is one of those thing that's surprisingly effective at all tim=
es :-)
>
> BTW, s/my millions/by millions/

Right.

>> CoViD.
>
> Good to know that all are well. I resonate with what Zheing Hu says. Let's
> hope we get through COVID-19 smoothly.
>
>> This blog will continue, with a renewed purpose. I will be writing down
>> important things I learnt in my time and bugs that new contributors
>> could work on. I believe that writing guides and making contributions
>> easier has some of the best effort-to-impact characteristics that
>> I am looking for.
>
> Very true. They are always helpful. I believe MyFirstContribution is
> a testimony for this. It's glad to know you would like to help
> contributors in that way :-)
>
>> This won't be the last time you will see me on the list, of course. I
>> still have patches waiting to make it to the list, and other work
>> undergoing review=E2=80=94the only difference now is that it won't be un=
der the
>> GSoC banner anymore.
>>
>
> Great!
>
>> Have a great weekend!
>>
>
> Thanks and hope you have a good weekend too! Also, thanks for all
> your contributions so far! Hoping to see more patches from you on
> the list :-)

Thanks for the time you set aside to help me as well!
