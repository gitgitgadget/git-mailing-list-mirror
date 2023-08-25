Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6046EC71133
	for <git@archiver.kernel.org>; Fri, 25 Aug 2023 12:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240254AbjHYM6R (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Aug 2023 08:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244994AbjHYM5w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2023 08:57:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695182120
        for <git@vger.kernel.org>; Fri, 25 Aug 2023 05:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692968218; x=1693573018; i=johannes.schindelin@gmx.de;
 bh=CBmeiMTgGp2JqxWWKlN4tFhEO8k7CiZTwHoeLRNHozM=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=RBmvOzUmfCp6ZwP/s3BQz/9JQHzVmuXzfOdk38pf9KpOkNzLxs7qosbdVHPm1g4P5bVPkE8
 5dwph1d5VA5EJxyyGziEJ0gOgssNH+FtzeaUylZ9vOZ4xgq4bsvVwUUksXuWCB469Om7EFYZ3
 FkQbU+apLGbkP0ZJ3ODe3XZpn280qFgTz6rPMeE270Zwew75NpPDzPGNh6Kd1cqiFo+OCzGq9
 SGjpjHj667aNBPnBZfXcAP2i7eUu2KtakCg4yNXrbX2PHQZX1VEWEEKXhe2BAK83iIdSJIQzz
 PLwAcNbdFSRXOQ8saQYSOhXtZu1paJIKu039DP0wD9P/4wYTDG1Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.15]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mk0JW-1ppA4Q2DMm-00kS5x; Fri, 25
 Aug 2023 14:56:58 +0200
Date:   Fri, 25 Aug 2023 14:56:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, rsbecker@nexbridge.com,
        'Jeff King' <peff@peff.net>, 'Taylor Blau' <me@ttaylorr.com>,
        'Andy Koppe' <andy.koppe@gmail.com>
Subject: Re: [PATCH] ci: avoid building from the same commit in parallel
In-Reply-To: <xmqqzg2hg2nv.fsf@gitster.g>
Message-ID: <312f2c2c-1411-53c8-dd5f-24ab9097571a@gmx.de>
References: <20230715103758.3862-1-andy.koppe@gmail.com> <20230715160730.4046-1-andy.koppe@gmail.com> <kl6l351j22dr.fsf@chooglen-macbookpro.roam.corp.google.com> <CAHWeT-ZA8f-TGRwDHixAvi5kddVBbuK8LpVGJ9cjYZMsMk5ODw@mail.gmail.com> <xmqq7cpwjhr1.fsf@gitster.g>
 <006574bd-4d53-495e-8cfe-677ede521908@gmail.com> <xmqq350kjfk8.fsf@gitster.g> <ce5d20db-2220-45dd-8c39-2a52e0f9f816@gmail.com> <ZNv5PQlkn6tbUcH7@nand.local> <20230816022420.GA2248431@coredump.intra.peff.net> <000901d9d045$e780f790$b682e6b0$@nexbridge.com>
 <xmqqo7j5uqza.fsf@gitster.g> <15b89f2e-adb8-ea2b-fd74-2cbe95e20501@gmx.de> <xmqqttssqsj5.fsf@gitster.g> <xmqq1qfvor35.fsf_-_@gitster.g> <xmqqpm3fn16f.fsf@gitster.g> <99e19de6-c17d-e85f-dc58-1019aed1e2b1@gmx.de> <xmqqjztnm6v0.fsf@gitster.g>
 <1da763f3-60bf-a572-2c71-336b1fa5553d@gmx.de> <xmqqzg2hg2nv.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:B9qOtmKdBXm3IEuQ2v/jdu/yP8vCp44JLj9orUd5m40ey8fY3K9
 dcxxJilgNkJ62CZR9jQsffigbroEC1mC5pnwQJGPBnWobyQnhDktj2yRGxcmntVGjgj3u/L
 XUv0sVCuFO7zuwm0yn2nWfDhWyizUlq9aqFGGxH9+OdslVszecuGZA1o1xFsx0/OJUbsdM9
 RvTAT7n0jrjGys/w1mz4A==
UI-OutboundReport: notjunk:1;M01:P0:1GdVxDMvoGs=;vAkMuM5A79Rl2444GGstn76/QmV
 DJ5RMxA9rW8HHwZt4s75Drd+HxnFsjFirto1M2TRFHWtWuHeuZRgFsUWPfzgWgAnNjEvWK8lI
 SO29G7ywUcr3u1R5fWQo/zK2vkosrbl8YFY60aA623MjVeu0YvaFg7hPm9GhF/1CKN8sln1nT
 4ZJzsrruNa+kl2auNA230L9rP6YCl2mreHNLe8pqvZ7Q54Lqg34ILXMLM4/tZAh9eI7p4t/P1
 4cpGUJqBNMg/R00RQVMWHbaMIxcZ5DS2cyGxRfKAg6+BN8Lar44QXEomSm40FOefGre640YyB
 LR3kynToeLqGgMqdalSJ+EQzoOcQy2h6So4QIBW78eq4csnky4zRQOD8/Tln5jdsf7xGLN9OT
 A5Ce/jHZk0uzovRgzE+82IYhLUsPxtrRseXCx/bFclI31r7FLlFLpTLmVIoQxBHWl/HjRYuqb
 6PHxrbAj4qgcPkXSokXKVhIUSr6bOdUqfNoRJdAkGuTELFqA66B2C4UPE2HkD6ARPdIYuwzHP
 uv216FI8M0LyJ44zSKa5E0ioNl7rI2qNNwwYviNjDWxmSHHYkSd/gjcqQGVjCL/1zkEhI4dle
 epkvqX8Kv1Q3CVtAlyWqkB7dhfg3aSSYTc7pH0tLNkZZT5/r9Zv2SRC5IquCYYQFBvILmmDkn
 JDKh9j6wdfB4zqWW/YvaUxy/WsOEPtlqaA9FpD8Zp2kRrCX7vq2cSJA2N3BWfx9JW9vwe4tlL
 NGNOHI/hhAC+tvoWvgrUe8E+q4qRxmLGBh5aUNTNSW+qBlowZIsbaMT//mY7NazqNruPKN4fh
 hqRLYT/pzNjzT+MifdW1xGRmflQn+xvv2NlQrcKbjP0sm/TpPGds62AhJcN/Z3Xpo/Z8PoqCh
 A5/YXShrnKJF3PmmM+LlVI5C08E47erIoKEKRnFU6hLz1V2bk0IZf8w5ay5l7WcR4pwF5eHyg
 QWvtTvSvSpzLQrBQyZsbwAk0Er0=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 23 Aug 2023, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Here is the patch:
> >
> > -- snipsnap --
> > From: Junio C Hamano <gitster@pobox.com>
> > Date: Mon, 21 Aug 2023 17:31:26 -0700
> > Subject: [PATCH] ci: avoid building from the same commit in parallel
>
> I forgot to say that I do not think I deserve the credit in the end
> result, as you've done all the hard part.
>
> Mind taking the authorship, while demoting me to "Helped-by" status?

Sure. But I disagree that I did most of the work. You tried all the
avenues that I would have tried, saving me tons of time by spending yours.

Thank you,
Johannes
