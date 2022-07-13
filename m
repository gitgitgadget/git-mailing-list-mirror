Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C93C433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 13:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbiGMNAb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbiGMNA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 09:00:29 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D80C61
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:00:28 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id a9so18921401lfk.11
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Yb0Vqb2HCHOucZSUzQ6R11Ijh0cbM80txB01v7MSHg4=;
        b=g+OG88wdVwZEkqXxfzg3YIsoPZaq69tPPqo3PHL5W8N/kZi4HIQOaquk/lVxYN2LNX
         49BHRj4tlopS2P9VjgGbamopgePcKOOsC9UgzejE3t0QZrAegNs+eZIPud6ccZkkF8kn
         wNuLSS7qUDkQXFf1NP/J3/OOHtnwSHFfRVHAHBxu5ImXrbuFB4js0rdkdVE/Y9ioTCXU
         DhmPLcyxsKim42tN5aWoO5S0Lab2X8XpnaqoFlYs66dN+g+inqIycnicsFwrdV4zH01/
         L6gp+n9Mw8t0wkg+KdOieJyi2sWboLRz1mQL07j/Ksbndkidq673eXmVPPVcamUjOL0c
         z4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Yb0Vqb2HCHOucZSUzQ6R11Ijh0cbM80txB01v7MSHg4=;
        b=4196IF1QaRL6JYeB9YvAQVYDNBiSqsXWcOyu9zaEWxa1w/xi+/EjqDWKdxdZSOp9Xr
         02I0aNrF3weas/Izrlj2sTYrA9BeAvJ/TCD7lXa9GUHC81C6HoydqKMYRGLdJCgPSI6H
         drRBhfE5HSP3ADVXzPUWrvZUaZm0M1LX7ahTD+3VYSRgEyu2C1KgT9K95O4A6vtTBfLA
         JFfe2e1O6naLZTQi1UiM5djg19wl8vh6jNDycGt84s1tRnR3vfOMJJaDDlHshfNYRFbu
         AhT8Z6++QRQT9eKIebLLTv2o9hb06aNUVbidMQUImoTi7GjOo1cv07D0DcEiDQYcnosH
         PUzA==
X-Gm-Message-State: AJIora9Q4Vinyb6qRbGmEB6hiLZG0ViVQPQT1+ICXFb5iUrQqZpg9oeZ
        VR7nG+EIQUsAsGqO/ibB0RIdZYb89FDmYH4ShAJV8gG65ZA=
X-Google-Smtp-Source: AGRyM1vEf+M2dcFeAbAoOlJIXb6xumzGDDH+L1ANkMYgKTOYm++h00RR4Lm9wQYt7AumyNtyURXXV6Y8hqWeAAKrOTg=
X-Received: by 2002:a05:6512:1318:b0:482:ae30:fc77 with SMTP id
 x24-20020a056512131800b00482ae30fc77mr1954038lfu.279.1657717225803; Wed, 13
 Jul 2022 06:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657685948.git.matheus.bernardino@usp.br>
 <8da18a0a8c34a1c10d55bcdda725817db586f763.1657685948.git.matheus.bernardino@usp.br>
 <220713.86a69d461f.gmgdl@evledraar.gmail.com> <CAHd-oW6AeOGv=zQ=9Udtzwau=5XbQkhuctVDa0=4PoMTSU20HQ@mail.gmail.com>
In-Reply-To: <CAHd-oW6AeOGv=zQ=9Udtzwau=5XbQkhuctVDa0=4PoMTSU20HQ@mail.gmail.com>
From:   Matheus Tavares <matheus.bernardino@usp.br>
Date:   Wed, 13 Jul 2022 10:00:13 -0300
Message-ID: <CAHd-oW4rBe5db8RFZa0S4OJd1RT3sXyBEW_QX8QqL8SJtWTm8g@mail.gmail.com>
Subject: Re: [PATCH 2/3] checkout: show bug about failed entries being
 included in final report
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 13, 2022 at 8:15 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Wed, Jul 13 2022, Matheus Tavares wrote:
> >
> > +             a_blob=3D"$(git rev-parse :parallel-ineligible.a)" &&
> > +             dir=3D"$(echo "$a_blob" | cut -c 1-2)" &&
> > +             file=3D"$(echo "$a_blob" | cut -c 3-)" &&
>
> Can't this use test_oid_to_path?
[...]
> > +             test "$(ls *.b | wc -l)" -eq 3 &&
> > +             test "$(ls *.a | wc -l)" -eq 0
>
> And this test_stdout_line_count?

Sure! Thanks for pointing that out. Will change.
