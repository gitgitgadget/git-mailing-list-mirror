Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF9AC05027
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 13:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjBJNZY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 08:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjBJNZW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 08:25:22 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DEE55E79
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 05:25:21 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id p26so15756082ejx.13
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 05:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8IDtU3EqPtmoD19ybWRlgpxB/ybYCP3FK+W5frHYqoE=;
        b=EIBdgXgbWvLPvQL8j3jBksxV1UEhy2NlPokOmmRknHrjXk8v1KTsK9FSSpp8rvFlfO
         nCkY4xEquCXh4jWg94qQy1+Zt2zqnQ9dN9SWfCe2PLuOYCTzrirPrqgffmqa+CFO2emA
         0i5p8ucXiKLm0W6XXvNrLAXGfOrfvIPh+w2q1uu3CHwFK4wjsnI+Gpt7TMR63RoPWKzl
         ZveqoIH2CP8N7BgdvOg+74MO8G8/D5NvSWguXQDhDcdvNlXP1cT63FUHhooq2bjefeHr
         woV5qMtFnLXWK4W05y42qdPCiAT/nyrkk4zYo5Z0EyiOnvBKd2RxJe5S1LlibqopZnpD
         jhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IDtU3EqPtmoD19ybWRlgpxB/ybYCP3FK+W5frHYqoE=;
        b=InVj/j99wT4DltYYEhU3wHyame1rN2PToDqLGeO609CaQW6N9D/WGbrMwrR3Dmjnk5
         hG0EJm8NjJacZhT3IKA3CpE+4LqB/L7BXxfQQzrPudLFR4BdsL09hEmIHbMf94NbQHHi
         a+B19BRppH9iksu9YksTTUiDe0X2wqA3DtI30c9YEDX1QR2IsdE+Bdc9/3VaA4mYpoGm
         yolXG5KBUjiAYOVoug7ddj3dT2CMweWoX0KMeeMC+uNIu+55SZglbauNEkJ9BMn4lj3S
         ogBF3dEWTDWlH5Grd4elWcjGiyAVsAYeUFczmTjd2OqECqlohArSM7BDVwrpLoZuhsFp
         vhyw==
X-Gm-Message-State: AO0yUKWHZ4X6HwxGy2Z57olc+zuimF/fxnQ31ixcYUg6JhC8Wo5JlYGO
        kw1ZvNL7xZGkAXPkhN+qaGo9JhXPlLFO3wuj
X-Google-Smtp-Source: AK7set94bye2/tZdbE7XIBaDUyiFSQMiHyGCCrUkUJzA4G6EKAgX8nRdAQuYDkzmfTkczu4CtNFhyw==
X-Received: by 2002:a17:906:942:b0:888:7ac8:c0f4 with SMTP id j2-20020a170906094200b008887ac8c0f4mr16371765ejd.25.1676035520490;
        Fri, 10 Feb 2023 05:25:20 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id la12-20020a170907780c00b008a7936de7b4sm2340319ejc.119.2023.02.10.05.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 05:25:19 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pQTOx-001vyR-0v;
        Fri, 10 Feb 2023 14:25:19 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        chooglen@google.com, newren@gmail.com, jonathantanmy@google.com,
        phillip.wood123@gmail.com
Subject: Re: [PATCH v8 0/6] submodule: parallelize diff
Date:   Fri, 10 Feb 2023 14:24:33 +0100
References: <20230207181706.363453-1-calvinwan@google.com>
 <20230209000212.1892457-1-calvinwan@google.com>
 <xmqqwn4qmxds.fsf@gitster.g>
 <CAFySSZAy=k+hgvg9r2NmroUs=BviZjS_KMW_+yO2nPs1dUsc-A@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <CAFySSZAy=k+hgvg9r2NmroUs=BviZjS_KMW_+yO2nPs1dUsc-A@mail.gmail.com>
Message-ID: <230210.86sffdveio.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 09 2023, Calvin Wan wrote:

>> By the way, how are you driving send-email when sending a
>> multi-patch series with a cover letter?  It seems that all
>> messages in this series including its cover are marked as if they
>> are replies to the cover letter of the previous round, which is a
>> bit harder to follow than making only [v8 0/6] as a reply to [v7 0/X]
>> and all [v8 n/6] (n > 0) to be replies to [v8 0/6].
>
> I'll do that from now on -- didn't realize that make it harder to follow

Welcome to the club :)

This came up before when I'd been sending mails like this for years,
without realizing the difference:
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2103191540330.57@tvgsbejvaqbjf.bet/
& https://lore.kernel.org/git/xmqqr1k9k2w7.fsf@gitster.g/
