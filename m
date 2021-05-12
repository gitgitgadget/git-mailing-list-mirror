Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D616EC433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 00:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B31A61278
	for <git@archiver.kernel.org>; Wed, 12 May 2021 00:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhELAay (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 20:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhELAay (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 20:30:54 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673F0C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 17:29:47 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id gq14-20020a17090b104eb029015be008ab0fso615068pjb.1
        for <git@vger.kernel.org>; Tue, 11 May 2021 17:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fcmGfmHxcB0UVjlgGCiI3a9fP6JPx/aTs7hGFtlTmow=;
        b=NEXv/PrTjy4dO19du6c8ODeuPRRZ2p/j3qwZy38f3C9XkBOduoQOMYR6CjVSEBpI7f
         LBuUXJAbFYidFOM1FNxtnvYn/Eh7U/cD2XRYvhk/mbX3g/8q0yCa2tXkcE2YQwakxHws
         b/dfTcR2mz6So26a7bY5H7fozUvzfhwUn0A83SZpmUrPoqMVgT6561A6AkUD/JlJgyAI
         RNol2pLxd9cR0wZA7QehnmaFEQh4xd1SZEjhY/Ii2W8vVLDVRMHt30fTswiroNbDu547
         8xDfMvCBRLPfHrpf/8NtfjxS2MsZOyT4TnjhoM+EcejFnVr1b7DYXL/H8uHkYe3YJu6s
         tqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fcmGfmHxcB0UVjlgGCiI3a9fP6JPx/aTs7hGFtlTmow=;
        b=a6Cvh+9WrGq+ExjK2QALWM20CTJCtXEBqxD8PpiUNxYAePizyS3iiZUEnbKlb53q8S
         bN60ndCFZQ/qGwp9zlYnytqUENutptkXQ1oAohVuy9Noo+fB5xv9KYaD+xSf7F7RGUDT
         0p13Sf2UmiYHX8wDVrw7km+JG+PK/h55icPCf6ohJk72X5tdrFbEKOVXq7YbIICY4qNn
         NO/4TOWY4X13V7eEfJ6Hg6VZu+RRe1Eij/ihltWGGhTo9/QxziDhdcMIyO2maYfFObOU
         ud1JfRoHMmw8S8s1jBezQSR6ovhqisDG0yCmBgrZPF4iPIDIUwNvMYkqP6R1Fw1IZI/5
         JaPA==
X-Gm-Message-State: AOAM533ebolsNgq7YIO3wRmltEK8UTLCkxCyURtY+tVDzscheT2Ej7hh
        JwNlTH9ZE7pODE9OH8KvgoN1H2c+HvSdpw==
X-Google-Smtp-Source: ABdhPJy2LikagPJ1YLRObAftVAkE4P8as1g8x49VyjtA7Z14qLBClVugO7rIWrEPuc9os06D0bDPMQ==
X-Received: by 2002:a17:90a:af90:: with SMTP id w16mr7772260pjq.97.1620779386951;
        Tue, 11 May 2021 17:29:46 -0700 (PDT)
Received: from localhost ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id i8sm7400133pgt.58.2021.05.11.17.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 17:29:46 -0700 (PDT)
Date:   Wed, 12 May 2021 07:29:44 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 1/1] maintenance: use systemd timers on Linux
Message-ID: <YJsheKt/UBJNtgv1@danh.dev>
References: <20210501145220.2082670-1-lenaic@lhuard.fr>
 <20210509213217.449489-1-lenaic@lhuard.fr>
 <20210509213217.449489-2-lenaic@lhuard.fr>
 <YJiKXRywBhhGXC5Q@danh.dev>
 <CAPig+cQdU_0uPKDkbuz3XqdYePAMNPcF_u+Enx+qfgRGvtiseA@mail.gmail.com>
 <xmqqtunbqf5o.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqtunbqf5o.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-05-10 15:25:07+0900, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> >> I think others have strong opinion on not using "%1$s",
> >> and prefer simple "%s" and using "exec_path" twice instead.
> >
> > I brought it up only because I hadn't seen it in Git sources, and
> > wasn't sure if we'd want to start using it. Aside from Ævar, who
> > seemed reasonably in favor of it, nobody else chimed in, so it could
> > go either way, I suppose.
> 
> If this were a piece of code that _everybody_ would use on _all_ the
> supported platforms, I would suggest declaring that this is a
> weather-balloon to see if some platforms have trouble using it.  But
> unfortunately this is not such a piece of code.  Dependence on
> systemd should strictly be opt-in.

Yes, dependence on systemd should be strictly opt-in.
Although, I don't use systemd-based distro, so it is irrelevant to me.
I think it's none of Git (the project) business to decide which
scheduler should be given higher priority. It's crontab when
maintenance was introduced, it should be crontab, now.

Another point for eternal bikeshedding: why do we limit ourselves in
crontab and systemd, how about other homebrew schedulers? What should
we do if another scheduler raise to be the big star in the scheduler
world?

I guess we should take some templates for running on {,un}register
instead? However, I think such design may open another can of worms.
So, I don't know.


-- 
Danh
