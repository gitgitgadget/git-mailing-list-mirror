Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E8B21F453
	for <e@80x24.org>; Tue, 30 Apr 2019 22:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfD3WMl (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 18:12:41 -0400
Received: from mout.gmx.net ([212.227.15.15]:47507 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbfD3WMl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 18:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556662354;
        bh=PpIAa6nDKRTlYwkJFWwdx0Ar+mjTOn2METIpfoEl+74=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RFgUu360GQnCE6PtaL9FDuX+c3mQ7PNgLFOZqktfQz/1lozUlzv6MiBMYM6wk0F+D
         LenmR7Y6nis0p63WIzwcAVb3SKAYesfGGYXDV29CWEvTe4E0XdyaRzj5aIWtT/AT8c
         TXT0yYdPvKpYSkU08lHd3vvHKx/W5KuamDZwji3o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.96.188] ([12.174.135.204]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvsEn-1gWWda3r4J-00szMd; Wed, 01
 May 2019 00:12:34 +0200
Date:   Tue, 30 Apr 2019 18:12:32 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2 19/20] diff --no-index: use parse_options() instead
 of diff_opt_parse()
In-Reply-To: <CACsJy8CUNVWqWff05Lg2xjnOj3L2T7RvVbZh+RZPjvFokvT_-A@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904301811110.45@tvgsbejvaqbjf.bet>
References: <20190320114703.18659-1-pclouds@gmail.com> <20190324082014.2041-1-pclouds@gmail.com> <20190324082014.2041-20-pclouds@gmail.com> <nycvar.QRO.7.76.6.1904292055300.45@tvgsbejvaqbjf.bet>
 <CACsJy8CUNVWqWff05Lg2xjnOj3L2T7RvVbZh+RZPjvFokvT_-A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1248547375-1556662354=:45"
X-Provags-ID: V03:K1:9x/p7fo4uje4h0+yXJQoJZcJD2X1VvOlhaYLjmtMgOkofHv6xvK
 Ue1jXFiOS5jq0KMZGs/a6FIQ720OYi73hiSDAmotsEfP+BhtJlLB7bL7MDRH042Zk7xCcCB
 +fDWvV9Rj4iTPnWnIRAdGVI00axHZjCZaJUVNmjj48CQsO6bV+UNxZ2H8S5RkCOxnkqyckn
 tyzPMQmTc636HPSKab17g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zukP508pFDM=:MJGnqaCLQQdCNndqOkM09B
 hyewc++kWm3vivM/c/TQ6bPfprsMafuxrHMeQAVQBSKt5LR22XNzBNhzwPXDdo01fpmEW4ha0
 9BLGHiYAGpDyWifOIXM+M4u3UPFhwZzDb0TqC+bA9hu6xGq7+nebVNF1MQMAFpVv2fJhgRlGu
 QMyAJrEOabaPtObSKxiCDR8skSolhUbWBM/+ubXIBfwHzUwIyPbI85u3vnK8n7lslHHHxxjHC
 LIeUM/vVNC2qdakV/6P3gD1As1thTUAf+ZyHwQkppAJZVMXW66Y2iVAr8m/PlifRZD6ecWByJ
 Rp8ROi2h4w+DKI5GC1Up35bEfsT/bZBtgjdax3ko3gWAysVq+T24dkOwcqQrEX0izkCc/mwEh
 VK9+pmbKLgVdwlV5pnzDllSjbslqWqGQs3tNpbbalJP+tA1aqNetuC1s2SCBtOrWrCaeb1csd
 mrzwRgdIQrjFngFJ0Ff1U/YjjslCi4M/fh+C25HHXNhJKk4d/BBePXpbeah5asLY4HZUXrmyS
 B8zcyrxLaLwZjXBbcEkuKUL6U5qgRON5kIU5e1fJTahQwOTe+4/ER9dAr32beF4uzPyDuOOLU
 xevWUhfN26HdfSE07H6+dnNu3Ln0QLiaPTu2RH1VlFvebKOJlJJaLol8GTzdnLvQG6rPyfDu+
 SyUlOz78rpKtW1JijfQkTDZdTJl3gNBjznDc7IHBv7XEaE7yybzbACQOdmnqTYsTsE16KaAYT
 CSebIIqD24iMbVEX60q9IJyGSopJQJ1QjDCRoj9wQB6tBKv+Ycyk0zJiaE5OU43Dee81SpdlZ
 ek7AGbPMCDQ/by+LH9KMysSWa5DMUzyzOH6lQ/KBEOx1+4zst58e2YUbS2WpIjT2UfPN+A6Y9
 yjW9TFfCuNIX7si1UBAnAN/4DUk0Hoa54d8y3v4hzrHypxtJg3bVscIKK6w45EhJoWswukvZS
 VzVEPJZLNig==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1248547375-1556662354=:45
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Duy,

On Tue, 30 Apr 2019, Duy Nguyen wrote:

> On Tue, Apr 30, 2019 at 8:02 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > Hi Duy,
> >
> > On Sun, 24 Mar 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> >
> > > While at there, move exit() back to the caller. It's easier to see t=
he
> > > flow that way than burying it in diff-no-index.c
> >
> > I just noticed that this commit message is missing more than just a
> > trailing period. It does not explain the change of behavior: previousl=
y,
> > `GIT_EXTERNAL_DIFF=3Dheya git diff --no-index a b` would silently igno=
re the
> > external diff, it would have required an explicit `--ext-diff` to pick=
 it
> > up.
>
> Because I was not aware of the behavior change.

Well, your patch removes an early return in favor of a later return that
allows plenty of diff options to be configured in a different way than
before.

So while it is obvious (and understandable) that you were not aware of
this behavior change, the real question is what we should do about this,
now that this patch is already in `master` and on its way into v2.22.0.

Ciao,
Johannes

--8323328-1248547375-1556662354=:45--
