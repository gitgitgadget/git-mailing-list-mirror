Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E614C433DF
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 12:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7A6520801
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 12:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="P6t0t30k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgFLMH7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 08:07:59 -0400
Received: from mout.gmx.net ([212.227.15.15]:46677 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbgFLMH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 08:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591963663;
        bh=f39qwd6pWfk/27wI3qVvqS/l3o+kvNwuLi9Ez+pXF/c=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=P6t0t30k3KQcr5royj/ldE7pR+8KVYZlAN5ZqRTm/ttHUC3hzEGwG3ne/+G7tmX69
         UCzEYq2i2J/qGQyBRfu9oikVTJtll/jMUIaWwwh0sGhVqvraQ5eSv+qvtAgy8BMZBr
         53V511yhiMUN6PIgoJKEAmKJKTMK+P54rW/HHRsM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.173.52] ([89.1.214.156]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2f5Z-1jmCuG2iEB-004FWt; Fri, 12
 Jun 2020 14:07:43 +0200
Date:   Fri, 12 Jun 2020 14:07:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        don@goodman-wilson.com, stolee@gmail.com,
        Jeff King <peff@peff.net>, sandals@crustytoothpaste.net
Subject: Re: [PATCH 8/9] fast-export: respect the possibly-overridden default
 branch name
In-Reply-To: <xmqqeeqljwht.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006121407310.56@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <1efe848f2b029e572cea61cadcfe36b9d3797836.1591823971.git.gitgitgadget@gmail.com> <CAOjrSZvm9QNUttUNVBEUMPJ8zgYEoAnSPN5_6N5uwpiM1sVrcQ@mail.gmail.com> <nycvar.QRO.7.76.6.2006111556090.56@tvgsbejvaqbjf.bet>
 <xmqqeeqljwht.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:84Ns6KYZQgr35EqgZXtmmR6wV+HODr6eKXTzccH1hC3JAJ1gI8f
 A2CtJeEGusFvJurolOloqU9f2kmHK9k4+jNUbCRfgSpoHej2Dh0vgcXOvIyIu9DOh0CasVN
 By4qy5CLhPOF3Izi1qNos0rj37qrfkqSqrToOoJBHgp5oUnfGU4mqqNDAfhGH2sfIgufOlX
 K9Lf3kgHdlCuD9tGGWV7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DCupwBjprVc=:TisjN8TNJBxV61YXi8wFVS
 no/3YHgvnyb1F6HMV2AIJyjp/K9N+7lfu+8UTCUq6WtBcUKLDnxLqPxkF8fZ58pEt1GMmVBAL
 nBox2CxnHZMdP5eGJtpVHs9kQZV7tWAAUcTTfYlf9g0ywAKS2ZSZYj++kkYDrWlC8QertDXBl
 tx7KJlqFtZhpXEOqeRYcVWvszLlUqzemK6X/HU7yqIQTsAGFs8+aT8InjH9oi3yw7aVBE0z77
 HyORv4u62ijjlpIFDcOwKxZGWOUFEz5BrQ7o0wk1Nw+x2Zpkk4JSX3Fzj9/zXAfM4dOoktr8U
 E7bePoL2AtMHfDLDVP2+ir/FPRXTkjsJA06BTNv8uSstM7NoAlr2ysysm1lBf4jcdeQKL7U2g
 z2CYxPuDedBRyzKK7HDD3Arropd7TUYtffZjVrNL6XGrXkkH+ca1i511i/Ko3+w3NMRNKA9mo
 jthq8KzEex9ektKT4AIoMDY8m/OwCa3C69TKuYP1n4qJxZEIe4W6t4s/8NvNJK3VFGFr7RK5P
 olLNdUMo8Knc5WWkWd4iqwZhfADL1Nk6JrNQs5Z90uLqRIHn/DKI9NH2LedkKv0nCVe+Vkh7o
 K70PtpEKxHU3Iu5YgA95HL23V4Yjt08RtXrPVpNx9hGTLGEsZzBAWM+OO6KjPbJIb7tHlxKlS
 lbk6LP1JizMjtnJxGelRGCCxYzNqfzJMKBEbulMrHpJtT8Ce9+fvXngyWWjL9Tr1Xd850Mefz
 gXz3uowJxlQ7nDc6QMq52JkRPiVzsuXstyVVTStULO+F/cvesArm41OKuyy2GwQ6UDmQT+ICd
 gefl6A0iD1UIYzu9NiazNiW10P4MZWNqVigMRjcTrDR68zbmZXLrHbAjiZPcp3/dj7/eL7eOK
 fVwHJA87SZ1Ozxriue4WFnEgkbbzaMG1VITVKiR+kobn0XFa1517pXfwgLcjFIfOQXNVhKkET
 ajPTTKWGYeSEvFwWp+MOOvI+Y5Y1UzEmS32LcP6JfCZ+2Y/f2FS8CsI/+CtPbNPPhAN1ve0Sl
 KF4r2WUhZ9z+a4qYTx/w9pll9M5g0tmduezOcTEzGfWnEurM1qPpzDd1qEse4aJEwbPv1AkpY
 +zvyQh0wsLtLFDbD1pspxLITGH45iHonxsViUyabyaRpAYULiz4lOj8WNQEoWgSPcSBiG0ZO5
 j1bG0yvY/uuO7hw2fipkHQzeQRXc1HmK+RSXEF74s3oKR9ZBweuXVCllJYeJUJER7Wa1Csato
 oqFxb+uQLqYtsN7nj
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 11 Jun 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Hi Matt,
> >
> > On Wed, 10 Jun 2020, Matt Rogers wrote:
> >
> >> > -        * We also leave "master" as a special case, since it does =
not reveal
> >> > -        * anything interesting.
> >> > +        * We also leave the default branch name as a special case,=
 since it
> >> > +        * does not reveal anything interesting.
> >> >          */
> >> I feel this is a weird thing to do, since you're trying to anonymize =
the branch
> >> name,and now the default branch is identifiable with your config file=
.  For
> >> example, if the default branch contains the name of my project/repo t=
hen this
> >> sounds like a recipe for accidentally sharing it. I feel a better
> >> alternative would
> >> be to exclude nothing from the anonymization or the proposed default =
default
> >> branch name
> >
> > I don't think that the name of the main branch should be subject to
> > anonymizing, whether it be `master` or anything else.
>
> "Here is why" is missing ;-)  I think you realized that it needs to
> be, after you wrote the "ah, we need two, the default for new ones
> and the name of the primary branch in a particular repository", as
> we are dealing with the latter here.

Yep, absolutely.

Thanks,
Dscho
