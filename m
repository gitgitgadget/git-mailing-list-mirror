Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E21C2B9F7
	for <git@archiver.kernel.org>; Mon, 24 May 2021 17:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5487F61402
	for <git@archiver.kernel.org>; Mon, 24 May 2021 17:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbhEXRyd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 13:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbhEXRyc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 13:54:32 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136ADC061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 10:53:03 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id j75so27753077oih.10
        for <git@vger.kernel.org>; Mon, 24 May 2021 10:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=dApbjF/ciK4ofLqBzys4ufFQ1WdRRMJBJ+2D/HTNM10=;
        b=sgZrkCPwx4jjVVLMCCApyGaA5sCd56wOQQKaLLenymv+QeUz5IReXJxuyajL7gzuDe
         ZjQuGbsXS8YxCo/YmCBsO4FlXRGmEpPns5nZD0SYICj0ht7ezsptwnfe+ujtXEFk3Ipx
         U9Y1+SqilOH3iQMAIFwJIGNGdYHNRRYVuz4XycYIFvVAmVkQ1VryOuul4NWmJPQGK8OL
         +52ER6ifk1qFc4/Ve/tOsAH3yhOQo9XGZ0F5MLvESbb+VSbNS+4KGXPB09pF7s4xfDMF
         fNzRhN77l+SzZdVh5hpPX98qMRM8uoYnlq6BERnjFXmF+fKBl6wHxPFnKrjI5mZFiLMD
         yrxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=dApbjF/ciK4ofLqBzys4ufFQ1WdRRMJBJ+2D/HTNM10=;
        b=BfshjNlZtCzO5Sl+H1THt3ZtsAHsXheIxNUzcRiZD7ViOeza1+zBf97DtVwP0l2cR1
         OtJAB7+NXQ1KwQdISbca7HNukNFAcbQp9hPCMQqFw1IQVf/9Gksdt9a8yM6x49WqA15g
         JGrpuhOs1A7pZpxAowTMu8vz90YKS9FsLKC0Eup5d0UohPQgwkIJiTwWMQTGfyQW4i7K
         sFd6xBP7wiHqX5eAVl3B5qRr1+8TIhCDk0rRSwnKUaJ9AElhbhNNQld7THnhQe6Bzbus
         Dpsac4frO1yvhRkeQk3fJx81RpLykiHsfpsB9BHO/X9ZoMSUsB7gnHiazeIcT+5aFAyX
         BWFQ==
X-Gm-Message-State: AOAM531xtecZ4tuo3T7+bRxG9ZwI2nzCMfiGhaHBFAkYIoWhiqLHTSVx
        +dXtBTYU5OsxrcRtltDYDD4=
X-Google-Smtp-Source: ABdhPJxEWsQ79jb9obHP7LiMdhDPh0hVSstTgn5EGXZdw3T9OjPYnTVFofaAKc4HdLaHdvZfCw8t3A==
X-Received: by 2002:a05:6808:7c1:: with SMTP id f1mr11272327oij.142.1621878781906;
        Mon, 24 May 2021 10:53:01 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id 73sm2726750oty.40.2021.05.24.10.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 10:53:01 -0700 (PDT)
Date:   Mon, 24 May 2021 12:52:59 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>
Message-ID: <60abe7fbde461_1b20920897@natae.notmuch>
In-Reply-To: <87wnrooa17.fsf@evledraar.gmail.com>
References: <20210509213217.449489-1-lenaic@lhuard.fr>
 <20210520221359.75615-1-lenaic@lhuard.fr>
 <20210520221359.75615-5-lenaic@lhuard.fr>
 <715d8115-641b-5c06-d514-36911eb169ef@gmail.com>
 <44d937a0-e876-e185-f409-a4fd61eae580@gmail.com>
 <nycvar.QRO.7.76.6.2105220856320.57@tvgsbejvaqbjf.bet>
 <60aaa09aebce4_454920811@natae.notmuch>
 <YKrk4dEjEm6+48ji@camp.crustytoothpaste.net>
 <87wnrooa17.fsf@evledraar.gmail.com>
Subject: Re: [PATCH v3 4/4] maintenance: optionally use systemd timers on
 Linux
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> I would like to encourage people in this thread who are calling for a
> change in wording here to consider whether this sort of discussion is a=

> good use of the ML's time, and the chilling effect of being overly pick=
y
> when many contributors are working in their second, third etc. language=
.

I completely agree. However, there's a difference between calling for a
change, and expressing one's personal taste. The later can be useful
feedback, the former tramples the progress of a patch series.

> Personally I don't care whether someone submits a patch where their
> commit message discusses an example of "he", "she", "they", "it" or
> whatever. It's just meant as an example, and not some statement about
> what the gender (or lack thereof) of such a user *should* be.

Agreed. My only concern is readability, nonetheless a poorly readable
commit message is not a road-blocker.


What should not be debatable is that this is a software project, it
should not concern itself with linguistic debates. The proper use of
language is a matter for others to decide.

If a member of the community expresses her/his personal taste that Y is a=

better word than X, that's fine. But to *demand* a word change is
something else.

Cheers.

-- =

Felipe Contreras=
