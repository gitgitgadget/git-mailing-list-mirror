Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BFBE95A95
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 13:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377589AbjJINp4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 09:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377504AbjJINpj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 09:45:39 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DF0D50
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 06:45:27 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9b29186e20aso780994866b.2
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 06:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696859126; x=1697463926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccXypsxqxbWMvexWGYRJw1PZQ+ev1386HfJsn9F7El8=;
        b=l25fqLLzFpOy93WBbgnmT+ugm7SOwJhOdsvkkqfiGYBTqZa2X4rdx4SPi1VgGf2GaY
         c+seRnRRLdHgJ2btacmR5nQRFlgSSW8bZuuxRim3d4wU1UbX75JYDKCe5qHDj78skOsC
         fDqTwB4OaL4FmwKbMW2tHr3X5PAlPzBjnO45nvn0gekqUyQkh7De2gz84jWvIl0Z/OW3
         m7UsXzy1K8BLizTvuv0IxlcfPk3BbTRuw7HWpwbsii5iq1RZBQ8DH4LRlAGqMgy21CAq
         xUfeiEOFny+MccMB2fVZnAk77bg8xGQuwtXC9a4DgW/q+T2VWOhQULWTJOJGfYrl1SF9
         ZGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696859126; x=1697463926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccXypsxqxbWMvexWGYRJw1PZQ+ev1386HfJsn9F7El8=;
        b=caH63rmX+roieLobKT2kIaziQ5j3vZFVThKKI39bAkNqQBfTo9oD8zVZmFZ73iSlBo
         k1mBHn/aDvCan4mbeHL9B0X5OC784yRrVFbKX3QxUwuaEcOj2n4wMMdzS4zmPRIyk28d
         F3E+D9X75FfG1fPwcKWt32nxyznHZGcP7IjzIeMrs3/2OMZTX1dUDJv+4FLTXWQ7h3L4
         t/eZnPjMFLRRVhNG9Fvguhv3uRXqr/eyT5vLDiB6zH1REb5m0oac9mzZPY6g8vRiqT31
         r1nCbF8SfBE37g0mEWozhPISKgn+ikAv5YTfDNtfuTLrglZsDjs+sVSIngmhBJL6tdsr
         6EKQ==
X-Gm-Message-State: AOJu0Yx0B0MD195zxKzjkWn81jeiiZUaTo38XA1sVAX7vQuozPtIBXeP
        VE4A6vHDpNDmgf2sMMrhgIDIvwc8ztRV9aqFO1Y=
X-Google-Smtp-Source: AGHT+IFMQy2hxF75+kwfWigkum34LoUolbOFceKPw8xACxAcpI6vgSk2zoMyxX1J4Cb8FFzmZe9yWQV/SW466t3vpDw=
X-Received: by 2002:a17:906:3081:b0:9ae:73ca:bbad with SMTP id
 1-20020a170906308100b009ae73cabbadmr13945049ejv.43.1696859125788; Mon, 09 Oct
 2023 06:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <CACS=G2zsJxP+NWuosZyrFGctJptHNYTrULErRo_Ns41KeMuMqA@mail.gmail.com>
 <xmqqr0m75o0b.fsf@gitster.g> <CAP8UFD0PKAGchx5iqyZqCdua-KYJcrmO2FfNf_vt7xs=+7YL4Q@mail.gmail.com>
In-Reply-To: <CAP8UFD0PKAGchx5iqyZqCdua-KYJcrmO2FfNf_vt7xs=+7YL4Q@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 9 Oct 2023 15:45:13 +0200
Message-ID: <CAP8UFD2FNGJJahbZtszB-ao1qbr6kYe4ks=u5E5zM-aQYjSkOw@mail.gmail.com>
Subject: Re: [OUTREACHY] Permission To Work On Tasks
To:     Naomi Ibe <naomi.ibeh69@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 7, 2023 at 9:20=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Sat, Oct 7, 2023 at 1:29=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
> >
> > Naomi Ibe <naomi.ibeh69@gmail.com> writes:

> > > Second issue is this https://github.com/gitgitgadget/git/issues/302 .
> > > Is it still available to be worked on? I notice it was opened in 2019
> >
> > Stepping back a bit, do you agree with what the issue says?
> > Remember, these "issue"s are merely one person's opinion and not
> > endorsed by the community.
> >
> > Before you ask "is it still available", do you know the current
> > status (not the status of the "issue")?  Have you looked at "git
> > commit --help" to find it out yourself to see if "now" is singled
> > out?  Here is what we say in our documentation:
> >
> >     In addition to recognizing all date formats above, the --date
> >     option will also try to make sense of other, more human-centric
> >     date formats, such as relative dates like "yesterday" or "last
> >     Friday at noon".
> >
> > So apparently it is still "available".  It is a different matter how
> > well a patch that adds "now" to the examples listed there will be
> > accepted, though.  During a microproject, one of the things new
> > contributors are expected to learn is to convince others the cause
> > of their patches with the proposed commit log message well.
>
> Yeah, I think this issue, if it is indeed an issue, is not something
> easy to "fix" for a newcomer as it requires to be familiar with our
> documentation and perhaps our code too, or to research them enough to
> understand what a good improvement would be. So you could perhaps do
> it, but it would likely require more work.

Also if it's only a documentation improvement, it might not actually
be a proper microproject as we want them to be "code related".
