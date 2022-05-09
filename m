Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1BFC433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 15:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238342AbiEIPoO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 11:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiEIPoK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 11:44:10 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A5A2B4962
        for <git@vger.kernel.org>; Mon,  9 May 2022 08:40:15 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y41so7739627pfw.12
        for <git@vger.kernel.org>; Mon, 09 May 2022 08:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Sh2eqPNfntCLolKnMh6vWPH7wt76n/4fwllprXqfmi0=;
        b=OXM5m6GwofCocgiJqJEixVUV+jrjhi3jZobK9j2wrj9BLK5pK27kEqzV7cvtkeJE8f
         KMNS0bQoTAcWsXoQgUt3eG2k2GdMrgI7vvEHJ7Gmt02nlw/SMTqWalw2Sj+Y6z7+OKrm
         5JYqs4XxhYacPoVCCc3CCM+s5uvE6WoTeueqCPTzCgFsPB72IRjI3QLJym+Lygoyt5my
         fSerfBmJ5JswtzJLDyqBafNw3SDm4Hu4sdpBt+2slgkIZZiOJ5njY5bwNUXD9/ogeS0f
         KdWTnbQug5BwNQ9BjjZtaY03aitueHAa/6ZSJH7IzC36Zj7qpe0hhtX24irSUbeydc4a
         /lgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Sh2eqPNfntCLolKnMh6vWPH7wt76n/4fwllprXqfmi0=;
        b=GzdWMgG8QgdizW82z1Xc3o1f4tJp5GEPelVxbmPorYeNr2VzcfKOOolAbGhXmR8DZS
         lgXqB/ulIHNELrC3kLvM995aTeSPXJz8jl6GOAmTZP0ol9yXvHvSSUI08MxJon1v8QfH
         6BhXaRzxsVTfnJdy/q/Bq5IbZkfd0qt87y5ZhCetNvx+3kK2SK3FkVN+XZth1OGwUyRN
         9NEJD7kaXb2rbVY291YsEcFgkEwi1sggBE9xJjrovg/GIF826z2pr+b/AKk8gABpUbGW
         iyb71X9qngYFbs/TvtDaU7wnfAKKxilx1E6T2BiQSP8uguoo3f23u2eFlpHMIlO3fuBT
         Ggvg==
X-Gm-Message-State: AOAM530H0FLm5MLt/TfdiAQbAOcPaFBM4IjWD0a3iLSZqICmHnQXpE2d
        Zn4MyEp9BfcN2AirziRO5shuAWzxaMUHrJMDLjQ=
X-Google-Smtp-Source: ABdhPJzeE15pF6RUMMwy3R7mRXKVpJehIr6RmhPDQuAhsOrhgSMworIvry1iYMkB/66iPK0QjQElKgL+YVNLLzcKOhU=
X-Received: by 2002:aa7:8888:0:b0:510:8516:cfd0 with SMTP id
 z8-20020aa78888000000b005108516cfd0mr14712592pfe.36.1652110815123; Mon, 09
 May 2022 08:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220502083639.610279-1-chriscool@tuxfamily.org>
 <xmqqfslrycvp.fsf@gitster.g> <CAP8UFD0hWUudP6pZVGS5yOVCjbBCm1LdK_EbrsQp9KiVPPMCyA@mail.gmail.com>
 <xmqqzgjxnz73.fsf@gitster.g> <CAP8UFD0V6scSD8LuUiRQ0BWmG2mFATVFNQ2DgwaWFp6bigBkZw@mail.gmail.com>
 <20220505111608.o63obxrifoqz6j5w@carlos-mbp.lan>
In-Reply-To: <20220505111608.o63obxrifoqz6j5w@carlos-mbp.lan>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 9 May 2022 17:40:03 +0200
Message-ID: <CAP8UFD2BTmeYuVsq2AJg32qEjPXXB5oGtU1i8KK=xjZrS39eZA@mail.gmail.com>
Subject: Re: [PATCH] http: add custom hostname to IP address resolves
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Jacob Vosmaer <jacob@gitlab.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 5, 2022 at 1:16 PM Carlo Marcelo Arenas Bel=C3=B3n
<carenas@gmail.com> wrote:
> On Thu, May 05, 2022 at 12:48:50PM +0200, Christian Couder wrote:

> > Ok with renaming and implementing it only in transport commands. I
> > don't want, and I don't think it should be necessary, to invent a way
> > to do the same for non cURL transports though. I think it should be Ok
> > with the doc saying that the option has only been implemented for
> > HTTP(S) yet and will have no effect when other transports are used.
>
> I think it will be better if git aborts with an error if it is used for
> a transport that it doesn't support, instead of relying in the documentat=
ion,
> though.

This has drawbacks, as this is likely to be called through scripts or
apps and the calling code would have to be a bit more complex as
passing the option couldn't be done independently of the transport/URL
used.

Anyway until others complain, I prefer to leave it as an obscure
configuration called "http.curloptResolve" and meant to help server
operators as Junio says. This avoids wondering about such issues.

> > If there is a simple way to do the same thing for ssh, then I might
> > take a look at it later. For "file" or bundle transports, I don't
> > think it makes sense, and the "git" transport is not used much in big
> > hosting services where this feature is likely to be used.
>
> This seems definitely useful also for ssh which is also used in big
> hosting services.

I am not sure it is as useful for ssh. And maybe someone will take a
look at implementing it if that's the case.

> Ironically, I think would be even more useful for the "git" transport
> specially because it doesn't have other protections to rely on that
> would help prevent spoofing (like TLS), which might be also why it is
> not that widely used anymore.

Yeah, more secure alternatives have taken over for good.
