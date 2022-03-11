Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E976C433EF
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 23:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiCKXFP convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 11 Mar 2022 18:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiCKXFI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 18:05:08 -0500
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CC718C0D3
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 15:03:09 -0800 (PST)
Received: by mail-pj1-f45.google.com with SMTP id mr24-20020a17090b239800b001bf0a375440so12327886pjb.4
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 15:03:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/Ucs2aVqWUKCFo5t19+VPZmIyqmbhfsyqpjSP1G6dKA=;
        b=U8A6Ep5Z4Iu1k4+IzlPl0kxlaM48/8s70AxKSUnuLzvJvBNsxylB6rT98tsiYEBwZC
         /coDJDba8YDMlHSQSvC01aGSENGQ5lZ0VIWe576Lo4MSBqL6Zh3ECzU2ETDiy6RSlY8Q
         /b78wie9fV3ff1VHyx+8XjocAGJvSvgxYyjaCwiX3+jjx7TlzfN20gA6TMiAClVPAAAZ
         0ZP/EFNJAxAg6W7PFg9v+s99xgsHwbklubsbnvemj7R4zKLdqmKb9fibaA7DAp7QNHiN
         4D/3kGVnMPdT6MsvM/ZBr2CRVU9YlzNc8r/7qyAvCUf8z30B9UE2BUjMDB3n5pl5sfKz
         ow2Q==
X-Gm-Message-State: AOAM5327XE2VoyDcNWZG6w/UgmX4IYfst+hHqp2fCgUcJarp+iDwAYUe
        ETkq+tjLGKgwnHoqdPrbfcFbrfG83rVLRSQ3rnAqJF8TDf22qQ==
X-Google-Smtp-Source: ABdhPJwbfHtH2NUZMcqBhFg9nfCN30bn7Vn4o28n6VbRt2I2wJsOJTwRMoxeGA2dLwaEylgaOGIXMIhr0L1jSBzTARY=
X-Received: by 2002:a17:90b:1d0d:b0:1bf:6efa:3fed with SMTP id
 on13-20020a17090b1d0d00b001bf6efa3fedmr23868548pjb.150.1647039788500; Fri, 11
 Mar 2022 15:03:08 -0800 (PST)
MIME-Version: 1.0
References: <20220304133702.26706-1-gitter.spiros@gmail.com>
 <20220308113305.39395-1-carenas@gmail.com> <CAPig+cSNgQ7SEYk9M=L7z0G=hteTdupKS6sHJL8T7zEp=zkLEA@mail.gmail.com>
 <CAPig+cT3TNFBMesYvYoncawfBdLqKL971SoP_J7F9FgnL10Eqw@mail.gmail.com>
 <CAPig+cSUTaPRvALJyJ8AxNB4wMFLyaWBOa8f+_8K6quPbxTT5A@mail.gmail.com> <xmqqv8wnm30q.fsf@gitster.g>
In-Reply-To: <xmqqv8wnm30q.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 11 Mar 2022 18:02:57 -0500
Message-ID: <CAPig+cQT3801Fok9Uvk1TOs5WscdM+hRX7x3sW38izRqAR1N1A@mail.gmail.com>
Subject: Re: [PATCH] test-lib.sh: use awk instead of expr for a POSIX non
 integer check
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Git List <git@vger.kernel.org>,
        Elia Pinto <gitter.spiros@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 9, 2022 at 12:47 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > On Tue, Mar 8, 2022 at 6:58 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> >> > On Tue, Mar 8, 2022 at 6:44 PM Carlo Marcelo Arenas Belón
> >> > <carenas@gmail.com> wrote:
> >> > > +               local _GLIBC_VERSION=$(getconf GNU_LIBC_VERSION 2>/dev/null)
> >> > > +               if echo "$_GLIBC_VERSION" | cut -d. -f1-2 |
> >> > > +                       awk '{ if ($2 - 2.34 < 0) exit 1 }'
> >
> > This seems to work, though it's getting a bit verbose:
> >
> >     awk '/^glibc / { split($2,v,"."); if (sprintf("%s.%s", v[1], v[2])
> > - 2.34 < 0) exit 1 }'
>
> If we are losing "cut" (which I think is a good thing to do), we
> probably can lose the pipe, too and refer to $_GLIBC_VERSION as an
> element in ARGV[] and make the command used as "if" condition to a
> single "awk" script?

Erm, something like this perhaps?

    awk 'BEGIN { split(ARGV[1], v, "[ .]"); if (v[1]=="glibc" &&
sprintf("%s.%s", v[2], v[3]) - 2.34 < 0) exit 1 }'

> In general it is a good discipline to question a pipeline that
> preprocesses input fed to a script written in a language with full
> programming power like awk and perl (and to lessor extent, sed) to
> see if we can come up with a simpler solution without pipeline
> helping to solve what these languages are invented to solve, and I
> very much appreciate your exploration ;-)

Yup, although in this case, the pure-awk solution may not convey the
intent as easily as the original posted by Carlo which had the benefit
of being perhaps easier to digest.
