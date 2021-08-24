Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE45C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 10:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 620E761265
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 10:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbhHXKhb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 06:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbhHXKh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 06:37:28 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5465EC061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 03:36:42 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id n11so1734832edv.11
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 03:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=WiyL42byUzGq6G056ULdA+SPrxUopMzkqREinNdH3hs=;
        b=udfcsVFEFdT7wlcrX7WA2/+jtdXaOOFYs3EqsJKiFoVGCkO9DjEqtjCokRAwRw6I5x
         h8ccyJBVCuV4reepqVGCGXekdNYYDlvZsVPk/8yVphxzE1hffQ9q5HLjsX9/auebykJH
         lcxjbPQ1YRr+n3m8aQDE/q7eUVi83JDDf4x0iyqyyUvHg9qStz6SdseZ98zTgqK2E34o
         WoDWwVXlDgHAJM0szOpvF/B3dZW4K/3t6khwzBYvaAYs5hEEz5oYA6V6XeHV5/VNUs0P
         70TUbQey3g5JGHY0swI0k0xe9HkC7mZIW/vJx+S9SXMn6qvGrPpMUXzlZV9VWNV4Emgc
         Unfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=WiyL42byUzGq6G056ULdA+SPrxUopMzkqREinNdH3hs=;
        b=FFBT4goPxqEx1N0mWzZRqg/5W1Atd8esf2luHL3/4CxlikRXUY90IFhPzFibSVg3DA
         CcNNTkqb86gLpDlXV5nnExV8YbMrXsA5zcfsMsDKF/4WGeKdaBrBINZEgWfLA7m6WJ0s
         bzg/SfR3NyRYj/dKzORTAMDYCLIvVkREegmTTGroaRpJbZckkVb9J79WfRDzSp/7j6WR
         PqZmQA3a/LqabS19mu7gS1Oaq/IBV/LvPHrW1DBo1zYS7M/OXu7CaWphjz+OkZhI1ygq
         8FbzqNTPcPgAsiY/VpL2ZZFIr0zTj7BVfgR0VghJTzS+US4yCU+/7xPbsTb+iorQJnqW
         hWWA==
X-Gm-Message-State: AOAM531p8hxiOQyNjHU0gAYniX9OjvhBSYPwtOobSynu0/yJlXlkasGe
        9KjF9env6RhX2FbSsA1NM38ula+ksDjJaw==
X-Google-Smtp-Source: ABdhPJzWaUpmaLmcJ1Ik/rvB10hwGDSgjqPUgXGUT0L+PT8eats0Dn7eD5fA+lApo7gq5ALjOxV6cg==
X-Received: by 2002:a05:6402:1601:: with SMTP id f1mr42238286edv.388.1629801400692;
        Tue, 24 Aug 2021 03:36:40 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bx11sm9057964ejb.107.2021.08.24.03.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 03:36:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [GSoC] The Final Git Dev Blog(s)
Date:   Tue, 24 Aug 2021 12:22:06 +0200
References: <m2lf4wys5o.fsf@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <m2lf4wys5o.fsf@gmail.com>
Message-ID: <875yvvf7t4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 20 2021, Atharva Raykar wrote:

> 2. Reflections on Working With the Git Community:
>    https://atharvaraykar.me/gitnotes/final-reflection
>
>    This is a blog post that I wrote mostly for myself, and other people
>    interested in contributing to Git. It covers my personal experience
>    with my time here with the many ups and downs. I also wanted to thank
>    all the people who helped and collaborated with me in these 14 weeks.

Thanks a lot for the kind words there, I'm glad I could be of help to
you an others.

Just on the comment about 10x developers (on-list regulars) v.s. 0.1x
developers (GSOC students) that you had: I think everyone realizes that
getting students to work on git isn't going to result in developers that
are instantly productive, especially with the inherent time-boxing of
the GSOC project.

On a personal note I think it's very pleasing to work with people who
are smart but just unfamiliar with the project itself, and in many cases
with tooling that some of us "graybeards" have gotten used to. It helps
to get a fresh perspective of things.

I also think that the main value of a program like GSOC is not the
patches anyone comes up with while participating in the project, but to
hopefully give what are usually young people hopefully at the the start
of a long career in software development a good experience in working
with the free software community.

I never participated in GSOC myself (it didn't exist at the time), but
my first real experience with software development was in trying to
participate in public free software projects. I'm really grateful for
the patience and mentoring I got from various people at the time, and
hope I can do my part to pay that forward. To me that outcome is much
more important than the "success" of any given GSOC project, or the
patches that result from it.



