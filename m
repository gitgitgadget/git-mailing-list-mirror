Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B853EB64D8
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 12:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjFUMI6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 08:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjFUMI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 08:08:56 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09C31713
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 05:08:55 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b475b54253so52764041fa.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 05:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687349334; x=1689941334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzksGNjzUQGANwGaLq1mIMePYQ6SrTcBnHil3G8N44I=;
        b=PKFxZioFXZDAW3+jdEq6oxU8NAXewXSAosJmHP1eP1kN659RatICArX5jex7RGEBCO
         Ky5/t+sTWuQXDRxNgQ+qhQ3Vs9h1HRFXEdtTw14C3lBiHwhfRpGEotn0JIIQKayGhrPU
         n8fZxTGb1et9/O9tf6ILEclnXdXlKKWggBdifFFf1uyuAH7vjVydTUbO3TYF8/ppm9P0
         VSgGYLuWugq6We+73WhGaqkFMZz30PYPwQzL6P+AE76mnqBtIfpfQVVk3oHtCosns/0Y
         FzsNPKt4aaFU41uORI2iwn/mIbtNPbCbbFBE047r5nbvM418phtOKiXsMwM7Nk3YT3ak
         54Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687349334; x=1689941334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzksGNjzUQGANwGaLq1mIMePYQ6SrTcBnHil3G8N44I=;
        b=Kj0+y1gkoiQNWD77v6D+2GBExphgVDiJ7ATqF75Sd7GoJuVHMvrYNwReBojMeWKXhY
         kARXMYc5BqtNPJwJC03bAurkS7sDViPs0LumlarTMaibpkSmhydlngutBG0hbqLSklLD
         Rlvbo818623uZRBdVo2Hm4UNpBWQsMUMFOCdak4p3JRWGA/Lgkd652gwh74qXdiPXmbV
         D096aUvdeSKLn7nLBHUsjgR8rie5U2PvkOLuuldXIvoGg3LhAWilv6CCQLDV8DnyD9ny
         /J8FhAvAT+L+OFuiDJjdq/JdrBfFpmgeTiglirqT7YJkAM+22T6F9GziWNRscFeCwlMV
         6HWg==
X-Gm-Message-State: AC+VfDxrPYjyZVljfETra7mn5MM15tPLFwt7jCgLqShiT2lJFDyzkMCL
        5sX5UQYusBhsW5HZsP/SmXL88Dvsop4GQJkFP9w=
X-Google-Smtp-Source: ACHHUZ7U4GVxCcy4wIvJzIiaUTe2INqNDV/XaMdbl+ELIIqOSSIaEUmy0gpjs0qrtkUTjnPtKli1epkhBpp2n5mOyCQ=
X-Received: by 2002:a2e:8ed7:0:b0:2b5:800e:3f14 with SMTP id
 e23-20020a2e8ed7000000b002b5800e3f14mr2802577ljl.40.1687349333839; Wed, 21
 Jun 2023 05:08:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230614192541.1599256-9-christian.couder@gmail.com> <ZJLjvhnh0lSRCVzG@nand.local>
In-Reply-To: <ZJLjvhnh0lSRCVzG@nand.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 21 Jun 2023 14:08:38 +0200
Message-ID: <CAP8UFD388DOTqueok7fRF+=-+s_PNria1oB18AEed3gjdRrqJA@mail.gmail.com>
Subject: Re: [PATCH 8/9] repack: implement `--filter-to` for storing filtered
 out objects
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2023 at 1:49=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Wed, Jun 14, 2023 at 09:25:40PM +0200, Christian Couder wrote:

> > +--filter-to=3D<dir>::
> > +     Write the pack containing filtered out objects to the
> > +     directory `<dir>`. This can be used for putting the pack on a
> > +     separate object directory that is accessed through the Git
> > +     alternates mechanism. Only useful with `--filter`.
>
> Here you say "only useful with --filter", but...
>
> > @@ -1073,8 +1077,11 @@ int cmd_repack(int argc, const char **argv, cons=
t char *prefix)
> >               strvec_push(&cmd.args, "--incremental");
> >       }
> >
> > -     if (po_args.filter)
> > -             prepare_pack_filtered_cmd(&pack_filtered_cmd, &po_args, p=
acktmp);
> > +     if (po_args.filter) {
> > +             if (!filter_to)
> > +                     filter_to =3D packtmp;
> > +             prepare_pack_filtered_cmd(&pack_filtered_cmd, &po_args, f=
ilter_to);
> > +     }
>
> Would you want an "} else if (filter_to)" here to die and show the usage
> message, since --filter-to needs --filter? Or maybe it should imply
> --filter-to.

In the doc for --expire-to=3D<dir> there is "Only useful with `--cruft
-d`" and I don't think there is a check to see if --cruft and -d have
been passed when --expire-to is passed. So I am not sure if it's
better to be consistent with --expire-to or not.
