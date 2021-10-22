Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D1EC433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 22:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEE4B60EB1
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 22:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbhJVWUv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 18:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbhJVWUt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 18:20:49 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45017C061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 15:18:31 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id u13so1704929edy.10
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 15:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=8tNl2k58a7J5I4MTRSJaglL56OcJF5JTu723pUTdHak=;
        b=SG2OnswI0zaRjPMhn2A2h9lWFK9NimvBICgK801g6IZ/aGgSD9uJKOo1DA8pHA0D76
         ZvxATMpJ9ht8KKXXf7CDFew2f/ToVFLJaQuRe7y3/pB3CWttShJEqp74PucTbtZFuf+l
         KdjTd7TetudZ4hnoFS7k2DeU93SDh/j8uEdurojHUYHzcD9aN9qke60kSs8+w0/gVgu1
         VjxINeU2V/Ul1WJFeYzbY/qTn7Ucth9Jf19OjNI/tdHqXFJFic1usGwZbfLdjpMTd39n
         vpPNzvo8Ur8Snr29HN/K+8sF0sHXZFqdP/6lXCW6SoMwDT872Hro2hYtUJkPXamTjidH
         Lkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=8tNl2k58a7J5I4MTRSJaglL56OcJF5JTu723pUTdHak=;
        b=Af/OkwqD8XFUD5EdRnJilcujNjJTcQN7iUgx7EeFoXJYgJJM4LfASkR8dlCGL7B0So
         ANac3WNcVg+C0M0MOtP6P/lHZvm4cbw0KdWRX8y/V/pkLb6cMrgcP40HPLhJDB/RTSAm
         Jb5LKmMOCV3IEm1JocufaOZnxiLjcG4ziRZmTk8/TlE3CGagc1NDhiUMhagtjSSBOmoT
         XUwL3Rkpn7AunmjeBvpEay6/hvFNz2PREdxCVXdt3/yPoYgAMjCBGWnhgU9lRh2OkIWR
         MejrfX9xMTLW11zWbOID+KDdQRbM6avr+loW5qdqeMvjzU+PuUhRs3qfCtUUkGlXt0TL
         KqJw==
X-Gm-Message-State: AOAM5319gqpGSBC7Pfz7R1a1Vyl8eNkbRMoQV2eZksOcD3APvaZMKhAy
        4Zucju3nmiqFo02xq0AklYAR/938U7S+nw==
X-Google-Smtp-Source: ABdhPJx6+R0oPUeVJqyDRDt+yRt1gBS3pbliywmNSmHNUhF02P2YtlL2MWYhGabV1hibv/EQ8vvAug==
X-Received: by 2002:a17:906:368c:: with SMTP id a12mr2756854ejc.143.1634941109080;
        Fri, 22 Oct 2021 15:18:29 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e7sm5661032edz.95.2021.10.22.15.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 15:18:27 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1me2rr-001Nra-4t;
        Sat, 23 Oct 2021 00:18:27 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [Summit topic] Improving reviewer quality of life (patchwork,
 subsystem lists?, etc)
Date:   Sat, 23 Oct 2021 00:06:06 +0200
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2110211150460.56@tvgsbejvaqbjf.bet>
 <20211021134105.ziqmcknnpdsg6cvc@meerkat.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <20211021134105.ziqmcknnpdsg6cvc@meerkat.local>
Message-ID: <211023.861r4ck8jw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 21 2021, Konstantin Ryabitsev wrote:

> On Thu, Oct 21, 2021 at 01:57:11PM +0200, Johannes Schindelin wrote:
>>  2. Dscho said he=E2=80=99s not able to follow everything on the mailing=
 list
>>=20
>>     1. if you have just one patch you send, reply-all works okay
>>=20
>>     2. mailing list works reasonably well if you=E2=80=99re someone like=
 Junio, working
>>        on it full time, has good mail filters, keeps up to date with eve=
rything
>>=20
>>     3. If you=E2=80=99re in-between, does not work well
>
> This is a problem that's not actually unique to mailing lists. If you hav=
e any
> project that is popular enough, at some point it reaches critical mass wh=
ere
> developer/user feedback becomes too much for anyone to keep up. Github
> projects aren't immune to this either, but they do have a benefit of prov=
iding
> an easy interface for someone to apply categorization to issues/discussio=
ns.

I'd like to use this mail as a good jump-off point to link to my "how"
v.s. "what" E-Mail from when this was last discussed. I think I
mentioned it in passing at the recent summit:

https://lore.kernel.org/git/87fszd3xo0.fsf@evledraar.gmail.com/

Especially as...

>>     13. Junio: Not really. The extra tracking conversations are not as
>>         important to me. I think it=E2=80=99s a feature that if someone =
requests a
>>         feature and nothing happens for a while that it no longer produc=
es
>>         overhead for people is a useful feature. That kind of old filter=
ing
>>         feature is sometimes valuable.
>
> I find that if there's no mailing list integration, then bugzilla general=
ly
> rots after the initial person getting the bug reports moves on. Then bugs
> reported via bugzilla just sit there without anyone paying attention. At =
least
> when bug reports get sent to the list, the ensuing discussions get reflec=
ted
> in both the list archives and in bugzilla.

...it makes a passive mention to this "forgetting as a feature" aspect
of not having a bug tracker.

>
>>     16. I=E2=80=99m also happy to work with kernel.org admins to get thi=
s set up for us
>>         if that=E2=80=99s what we want
>
> Consider this part done. :)

And thank you for your contribution to kernel.org infrastructure.
