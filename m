Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EADCC2BD0F
	for <git@archiver.kernel.org>; Wed, 12 May 2021 16:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BD5E6121E
	for <git@archiver.kernel.org>; Wed, 12 May 2021 16:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbhELQqI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 12:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbhELQIU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 12:08:20 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D475C03460E
        for <git@vger.kernel.org>; Wed, 12 May 2021 08:41:49 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id k15so5700505pgb.10
        for <git@vger.kernel.org>; Wed, 12 May 2021 08:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pCmAhXu7LgFdklzTKis2avgQBkG8Zji1OGF3iHTIqRw=;
        b=s5WQ21JNEhu8OUPqKdt4FY4jxo3g8uvt3PTstX98ELI8s+x/ryqRQNlgDTCyBdSY2e
         wkQTTbZ1i0DFOS5zs+en32X5Ntk1SGWnFeNiNw9JDUygiEJJDmAfMPADAuQnnd5frAD1
         sYbxeNXGsUK+gAadv6Tiyzev4KDuoQQDxLpr/PW1VVCx+Tkpte6EbRJiR5T8XEadTjjw
         aIFaUpWmMO0W8pUEVvRyJoyOvdor9atpDM2NntkYKNEi45rAZ94u5gW0QE8l3nz8+F6o
         hscfeKFupaIa1TOpnoc+lAuOsHV+Lbn9ozOT7UNRT3sZGxRSHDUZn1h7V8vrU1ZELrWQ
         IyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pCmAhXu7LgFdklzTKis2avgQBkG8Zji1OGF3iHTIqRw=;
        b=cBpgwy5dP8xkE3JzoZaBV8dndI6CktXVwolH/C8ICJO1CtjRoD59ZnDkRkaPsYn/B2
         +NpAMKmWwjUuNQyZTMVDKP235enkfe3ptn1eNb6h4+IDW6SevtiaXojzXgU0fkgOEBTM
         Rk/WoRM4qv6eknFwmLES0taACdUMH+uztx53m47kkfoKn6OCHYpSRwXDR7TAFO6MVV0x
         nhBMmcSXZ0LeGrAza4zsHaU+gNJRVmpNLrfxb8rAO4x/FPDPbY1Iuia+FJ0B5NpV+Eer
         EwPAhGWcFhsqVKQqpvpsIfRkezc0F5E8plZ+077qRP3j4RDfWpcJ2ZHDSgroy9nOglEb
         cv0w==
X-Gm-Message-State: AOAM530X78zVbJnEKv77kFj4YJTywyytRZypsE2mUcVsKlwdCZSgcp+D
        LrtBApzMPzHoiuYGBOfjtr3eKwjc1dLgkb/h
X-Google-Smtp-Source: ABdhPJxmNKysHEC3beVgs3Phzh1tSNcY0ptZe9eY9HGuVLMuS0l6rcKUcuOFQefHtpiflicSep7tEA==
X-Received: by 2002:a05:6a00:84f:b029:2be:3b80:e9eb with SMTP id q15-20020a056a00084fb02902be3b80e9ebmr17017553pfk.39.1620834108681;
        Wed, 12 May 2021 08:41:48 -0700 (PDT)
Received: from localhost ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id b1sm233946pgf.84.2021.05.12.08.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 08:41:48 -0700 (PDT)
Date:   Wed, 12 May 2021 22:41:46 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 1/1] maintenance: use systemd timers on Linux
Message-ID: <YJv3Ojt+4ZElN6JG@danh.dev>
References: <20210501145220.2082670-1-lenaic@lhuard.fr>
 <20210509213217.449489-1-lenaic@lhuard.fr>
 <20210509213217.449489-2-lenaic@lhuard.fr>
 <YJiKXRywBhhGXC5Q@danh.dev>
 <CAPig+cQdU_0uPKDkbuz3XqdYePAMNPcF_u+Enx+qfgRGvtiseA@mail.gmail.com>
 <xmqqtunbqf5o.fsf@gitster.g>
 <YJsheKt/UBJNtgv1@danh.dev>
 <fbfd503b-d822-e9df-f766-cc70941fdec1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbfd503b-d822-e9df-f766-cc70941fdec1@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-05-12 14:38:26+0100, Phillip Wood <phillip.wood123@gmail.com> wrote:
> > Yes, dependence on systemd should be strictly opt-in.
> > Although, I don't use systemd-based distro, so it is irrelevant to me.
> > I think it's none of Git (the project) business to decide which
> > scheduler should be given higher priority. It's crontab when
> > maintenance was introduced, it should be crontab, now.
> 
> You seem to be simultaneously arguing that git should be neutral on the
> choice of scheduler while saying it should prioritize crontab.

Yes, I'm arguing for git should be neutral on the choice of scheduler.

No, I'm not arguing for git should be prioritize crontab, I'm arguing
for "princible of least surprise" for no known break-through advantage.

FWIW, whatever default scheduler chosen won't affect me, since I don't
have systemd-timers to begin with. So ...

In addition, I was one of those people pointed out that beside
crontab, Linux users nowaday employed different schedulers [1],
and the consensus, some how, settled on crontab.

I think  we shouldn't switch away from crontab if we don't have any
compelling reasons.

> The commit
> message and cover letter list a number of difficulties with the strategy of
> prioritizing crontab over systemd when both are installed. I think we should
> aim for the solution that has the most chance of working without user
> intervention.

The solution that has the most chance of working without user
intervention is the solution that is the status quo. Promoting
systemd-timers to higher priority is a solution requires either
user intervention or our supports (which will be carried over our
lifetime).

> > Another point for eternal bikeshedding: why do we limit ourselves in
> > crontab and systemd, how about other homebrew schedulers? What should
> > we do if another scheduler raise to be the big star in the scheduler
> > world?
> 
> We should support the default scheduler on each platform - that was the rod
> we made for our own back when we decided to use the platform's scheduler
> rather than having a cross platform git maintenance daemon. It just happens
> that there are two possible default schedulers on linux so we need to
> support both of them.

As noted in [1], some home-brew solutions are very popular solutions
among those some community.
I'm not arguing that crontab or systemd-timers aren't popular.
In fact, I think they're *very* popular, I listed systemd-timers as
*first* alternative in the linked email.
I'm not against supporting both of them, I was arguing about a generic
solution.

1: https://lore.kernel.org/git/20200407005828.GC2568@danh.dev/

-- 
Danh
