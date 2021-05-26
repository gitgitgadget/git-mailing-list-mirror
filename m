Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E1BC47088
	for <git@archiver.kernel.org>; Wed, 26 May 2021 16:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E68A6100B
	for <git@archiver.kernel.org>; Wed, 26 May 2021 16:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbhEZQHJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 12:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbhEZQHD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 12:07:03 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550CCC06175F
        for <git@vger.kernel.org>; Wed, 26 May 2021 09:05:32 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso1497211ote.1
        for <git@vger.kernel.org>; Wed, 26 May 2021 09:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Yl6XmCV3Rlbt1ZQjd76a6Uf5g6/CATsEAO/vbQwH60w=;
        b=eL4U2XqURAwqXz6zbyik2uiuVvAg6jmqu+5NuYSSLsMjNXpgolKlZ51Skp8N36nrqq
         ZLPX4xaNknju/ZpU4hiQyK1H/WZrhVRmgAuIDov3JMNKneWPYUqeWGHTIhCvxih0+V5t
         VK6PbQkkRI/ei7X2EZQNkKiwMKb1bluaaDEi6wuFKn1tuzNpPd3/a0MlV36ryVT9UxaY
         jLh6/EJM7ZhNpzG3Ol3ipjGyqrtEtYr6Ego+B9gIfk2Zj47oixt2aghaG9HqC6Z/Q1LJ
         7ZujOp81gGEo0TYyua7Et7laCi1psKK9VOSXyj9SaQ/iIVWG80+JsMPjs/TwFnIoNDnV
         Q4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Yl6XmCV3Rlbt1ZQjd76a6Uf5g6/CATsEAO/vbQwH60w=;
        b=GjXiTPyVMRoyvCmaHFO7nyWIzWcsNgLrehvpuSnbPNWmrPpaK2GAsCJpJRusGIbNKR
         K+sUDNYXQKphJQzE9lJEB/+bGs8tYBi42LMPH1cic0CyLh3SJdUwD1p40CJ9d/peGB5W
         FfOD/uL/Xzfgk7gRe8/6bDujnLlTG9VtztmJwwoCjTXJUXWHXLBsfxYYMh9iFzg2xEBt
         LTAgr+bot5hS69ttyePlbKkSrMSeqbx6RK/9hGztKg3TKeozlG1DOhoYleVQ+HKYwnEe
         Unw3MNJpwxZARaQINxlwC0cLbVU0hcsVGNoXkziy6Ws2HEeBxmdt279XsWOZJA3N5FgH
         VOmQ==
X-Gm-Message-State: AOAM532oFhg37SnpXUCOa+MdXiSgs26ju7udEEYOw0hO9xhFqbhlnfQy
        Eou7BPrcLXub0TCHXGhI8wlYsm3kVItLQA==
X-Google-Smtp-Source: ABdhPJx09/XvU6XAtcc/7Xcsl/+Rq+UvWh2dN3h64/JF/kDMDfmRl3v3Ar6s7UMowJRUcQaxKFdZ8A==
X-Received: by 2002:a9d:7410:: with SMTP id n16mr2963072otk.262.1622045131732;
        Wed, 26 May 2021 09:05:31 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id o20sm4457041otl.2.2021.05.26.09.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 09:05:29 -0700 (PDT)
Date:   Wed, 26 May 2021 11:05:28 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>
Message-ID: <60ae71c829ca2_31f20812@natae.notmuch>
In-Reply-To: <87mtshn3vj.fsf@evledraar.gmail.com>
References: <20210509213217.449489-1-lenaic@lhuard.fr>
 <20210520221359.75615-1-lenaic@lhuard.fr>
 <20210520221359.75615-5-lenaic@lhuard.fr>
 <715d8115-641b-5c06-d514-36911eb169ef@gmail.com>
 <44d937a0-e876-e185-f409-a4fd61eae580@gmail.com>
 <nycvar.QRO.7.76.6.2105220856320.57@tvgsbejvaqbjf.bet>
 <60aaa09aebce4_454920811@natae.notmuch>
 <YKrk4dEjEm6+48ji@camp.crustytoothpaste.net>
 <87wnrooa17.fsf@evledraar.gmail.com>
 <xmqqim38jfja.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2105250327550.57@tvgsbejvaqbjf.bet>
 <87mtshn3vj.fsf@evledraar.gmail.com>
Subject: RE: CoC, inclusivity etc. (was "Re: [...] systemd timers on Linux")
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Tue, May 25 2021, Johannes Schindelin wrote:

> > _Personally_ I don't care either. Because I am exactly in that group =
of
> > young, Caucasian male developers that are so highly overrepresented i=
n our
> > community already. I will never have a problem thinking that I don't
> > belong here. I never had that problem.
> >
> > And I believe that you, =C3=86var, are very much in the same boat. Yo=
u will
> > never feel as if you don't belong in tech. You're Caucasian, male, an=
d
> > like me, come with an abundance of confidence.
> =

> I don't think it's helpful or in the spirit of our CoC to characterize
> discussion in terms of the genders or nationalities of its participants=
.

Not to mention that it's worryingly close to implying "if you are a strai=
ght
white cis male, your opinion doesn't matter".

I don't think the Git project should be assigning weight to the opinions
of community members based on gender, or race.

-- =

Felipe Contreras=
