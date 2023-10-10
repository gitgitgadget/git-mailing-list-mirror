Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F4ACD80C0
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 12:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjJJMox (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 08:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjJJMov (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 08:44:51 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B638B7
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:44:49 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a6190af24aso974594266b.0
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696941888; x=1697546688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7iZH9Cz+Pxj8KR1PqM5szmLlr8yDmJO62UZyqBXnbQ=;
        b=Vxxt9DhkonNRszE7vuWXzG4tLaQLzK/IGSlvqeun9UbCm7T55P55M1dMvfB6W7+EM0
         UTT6Ch9kV4Tg39iAB2/PiCXJWkwM8Mon2rX9sBLPMLDXW/dmERNhfJcdGdFi6n3WscDC
         p62NbInuUWJn1CGIQCebiIMpZXoOUynTMh2rPwRxDhzmYTwqdPqeWk6NXBsM/ftkiC8n
         GaosEYHfjMzG/K5OlHc9j0I1+0WP0QJiyjIBsZWwfWFgs5UAzf8m9cYJVe+WJSNqXcmm
         OvEQH/uQYMAr3HEIXeIBptilbgwbIDzTFKQCxyr9jmHhsDiDKLNaZE/POwUBhuHA/j4J
         FbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696941888; x=1697546688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7iZH9Cz+Pxj8KR1PqM5szmLlr8yDmJO62UZyqBXnbQ=;
        b=BPq1a0IUxsQUjQ6DeULINrP9AWdLW04L5S+3kWyUmgRDlGPSxM9jtanoSw5nED+r4t
         xtPu2GQdy9uGBtAHDLuojSHKUitrUs5RqjFEfB5mN4mnAjdVwZrtbSyue6xG5Kk/5f7M
         QnQVOM22YEnhscwo18I3uVo9IXVtzOXdYZ4eKJ5CUyhIRpYBta7BtfJlErPUhdlceYtX
         ZOaXFLn4t2qOO1r9KbtQiXncv3e4KeKwG8kd7meHd1XB2wHYC184H1/IaTG19463I2qA
         hLw1jzE9WSvvqH009i7YPUymQQYNb46Sc14vSRefCpXOHYaiu6rvKVTsRckGsgJ7uiis
         Tx2Q==
X-Gm-Message-State: AOJu0YwQuIfJsC/UcQicpl77/uPafgRychOmK/ZNv/8Mmf5gcEWRqYwc
        Ptlm4DGqIckhDj8Q3qVN0UFBAUNqsH23ZwznkZo=
X-Google-Smtp-Source: AGHT+IHCqelNRfBGQkPlzYKqgQboxYCbVZszLrYDrG+EnKnfNrjdbJkPM7aD8JLPpT9E0sNC4mZJa7zKvBv/yMVBRKY=
X-Received: by 2002:a17:906:530b:b0:9a2:1e03:1573 with SMTP id
 h11-20020a170906530b00b009a21e031573mr17721100ejo.65.1696941887911; Tue, 10
 Oct 2023 05:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230509175347.1714141-1-christian.couder@gmail.com>
 <20230602102533.876905-1-christian.couder@gmail.com> <20230602102533.876905-12-christian.couder@gmail.com>
 <87legbsths.fsf@iotcl.com> <CAP8UFD1_67rNke1y-GV7qX46GXQkNJzw7fXfK=kkUjc-jb5S_g@mail.gmail.com>
 <f412f62bf830b38a296b59ac3470099a@manjaro.org>
In-Reply-To: <f412f62bf830b38a296b59ac3470099a@manjaro.org>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 10 Oct 2023 14:44:35 +0200
Message-ID: <CAP8UFD213MwZmBuK0At5r0O8tHYDnxRTkw9AHak9RwDBdVVq_A@mail.gmail.com>
Subject: Re: [PATCH v3 11/15] replay: use standard revision ranges
To:     Dragan Simic <dsimic@manjaro.org>
Cc:     Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 7, 2023 at 11:02=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> On 2023-09-07 10:32, Christian Couder wrote:
> > On Thu, Jun 22, 2023 at 12:03=E2=80=AFPM Toon Claes <toon@iotcl.com> wr=
ote:
> >>
> >> Christian Couder <christian.couder@gmail.com> writes:
> >>
> >> > +DESCRIPTION
> >> > +-----------
> >> > +
> >> > +Takes a range of commits, and replays them onto a new location.  Do=
es
> >> > +not touch the working tree or index, and does not update any
> >> > +references.  However, the output of this command is meant to be use=
d
> >>
> >> Small suggestion here:
> >>
> >> Takes a range of commits, and replays them onto a new location.  Does
> >> neither touch the working tree nor index, and does not update any
> >> references.
> >
> > I am not a native speaker, so I am not sure what's best here. I find
> > your suggestion a bit less clear though, so until a native speaker
> > agrees with it or maybe finds something even better, I prefer to leave
> > it as-is.
>
> I'm also not a native English speaker, but I spent about 2.5 years
> contributing a whole lot to English Wikipedia, so I'd dare to say I've
> honed my English skills rather well.  Thus, here's my take on this:
>
>      Takes a range of commits and replays them onto a new location.
>      Leaves the working tree and the index untouched, and updates no
>      references.  The output of this command is to be used...
>
> This is written in a concise yet slightly imperative way, which should
> be suitable for the purpose.  I hope you agree.

I agree and I like it, so I have changed it to the above in version 5
I just sent.

Thanks!
