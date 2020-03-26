Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A09C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 14:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D4AF20714
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 14:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="QNUJiq0/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgCZOkv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:40:51 -0400
Received: from mout.gmx.net ([212.227.15.19]:48067 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbgCZOkv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 10:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585233646;
        bh=RF1gJqrKQPtuLiwTgUKgGh+DqZJu918IjT46Tri6mMo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QNUJiq0/wgR/42xBz1phskyMkDrtokl9XVq8OrbOVfpJGXJGIQwW73fFK8W7PSHBV
         7zzBs5A7vvPeB1ckBd0/Hzu23rz8D0DXoD+L0lCg6nggmpmiYr8d9HY7oWXBQP5Ef3
         tqKy7Q7Q2T+JA5cwwt+M3M7oTk/2OfS6S4HLg09E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.212.82]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N95iH-1jLTZZ22Ol-01682W; Thu, 26 Mar 2020 15:40:46 +0100
Date:   Thu, 26 Mar 2020 15:40:47 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Vadim Zeitlin <vz-git@zeitlins.org>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch: allow running as different users in shared
 repositories
In-Reply-To: <E1jHGdD-00079b-06@smtp.tt-solutions.com>
Message-ID: <nycvar.QRO.7.76.6.2003261538170.46@tvgsbejvaqbjf.bet>
References: nycvar.QRO.7.76.6.2003252001560.46@tvgsbejvaqbjf.bet <E1jHGdD-00079b-06@smtp.tt-solutions.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:LsZeFM3BhN+PMCepyh8liVuSjULY0lqu7BXZUe+rOC4sHPq75Ok
 qRQ/2HQ3dHRq3Kiv6hGnG179DwytNcb6c7O01rzA60OOvnG1V8ZzKlvBSTO3SRvr++6ZRyS
 kCDXIq3+cfZXBo0YVw6srpTvEN3V+c7exY4Jfc6KbqrVO4kQ+EC1Qq5YK4VKhG0CItAfDGK
 I2VOgiOyFcNxEbJe83cYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yNylWRMgU68=:03zSkdRA6uF9FCEkKPZ5eA
 /olkHQMbBMnIu1okT1U2f0FuwBKBIoEGVU0rSYJdXqnoR+wInkbhqkMXLYcMMZkIN8SCtMKXH
 dNa/MgEpkAVPzRM6ys3F76EdyDhE6ECpgf6KVvVwosmlguHmTTJERA1HtOi4yC833Pq4s4QuU
 req3NylBnXuzy//ZOdlA9mTSb4YqytSmfhc1wMpqXQ+CqUaoRs6rRTz+hshiIDfw6RarNRj9P
 odJtvFFI2z6S2Vp3wcqVdOsovBYlJ/eVjKANNYhGba/wg52sdewvuNBTwSY3nxk2BZukKB3Y2
 iXl/SIz9+TU2Gpe7ZGa+oBb3qjFS4n1pgzHCeFKbYNeasHoTZ18+8oufmvIbKRGoX29fQmoxx
 WV+I8mKMBwsqx1B4xkEu9fGCSjPEs0cb3qtHRbHSZ399v2YZFZMhjF79xRrQwQINBCL7BzaP7
 jwpNM57xAfMmqnht7T5aiVl4zNRiyxuI3A5629Hawxs4wBP4dSQvPBX9TGNEieh4wUnjYmwSE
 D5BCGr8b83t9cOXGDrRGoCm5Jwg7oWSvH++guw/WSwgUF9PmxND1mcXxy5GBtPgex3pxqcHrr
 lrNPPihQNtiNV475r5zPKiF3oeOfLVChmMSvWZRa8fhUa95lFUNVYKlXP/f7uy6wuhfOLmwvb
 VZbIxSRzPsZQUbO2Lgj5yxdxyrpo4pRPhQ6j3BcxWcHkP2c1yQi7EDwOB52kCnk0CMkTzGV4U
 onen4KLdrBN5Li3VslEc/mevFMmtctskekNiVOrsJoAynWWGK9lN+xJIcXHrsIQr8HMjawhKA
 RpWiHiaeE0ib46T+sFXA4AC/KVNEEkJSsGvARooqO7DCMrUO+4TEqNqOyHf8SW1lXNhwDx8to
 vXGWMpPhzx6CDXQPfNOpd6LRwuOhHuSKxSBt7MdV6I5EkQVsEHwInWbl0n944h5PW0tHZjP0z
 GjJumN5KksC2IR7keQxdYi/rN97YQW4uxJLuWKEcNu9bn/KN4SMqD+max9Olhdn9RulHJIEs5
 aQbP6gvHkYy2ViImtajP96m6b3ZpGN5HG6tXCdANk6IcemmQSOGzGI2KO2BdDw1pk4bt+aL1L
 3bPaqb+fLy8zGZt7d9O0/GxeYqBm+nCUR4FSxvdzo1rAwznDmpINYlugMZz7B/7hdz8TEtcGk
 Uln2vQSSOu9WEHx4cy4t8pF4LwFfKrRgPYSw4iqPi4eJZ7avnHdssydI+CghTdMedax7Cy9IU
 u2UA9B+7Y2yeHwayr
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Vadim,

On Thu, 26 Mar 2020, Vadim Zeitlin wrote:

> On Wed, 25 Mar 2020 20:04:09 +0100 Johannes Schindelin wrote:
>
> JS> Hi Vadim,
>
>  Hello Johannes and thanks for your reply!
>
> JS> On Thu, 19 Mar 2020, Vadim Zeitlin wrote:
> JS>
> JS> > The function fopen_for_writing(), which was added in 79d7582e32 (c=
ommit:
> JS> > allow editing the commit message even in shared repos, 2016-01-06)=
 and
> JS> > used for overwriting FETCH_HEAD since ea56518dfe (Handle more file
> JS> > writes correctly in shared repos, 2016-01-11), didn't do it correc=
tly in
> JS> > shared repositories under Linux.
> JS> >
> JS> > This happened because in this situation the file FETCH_HEAD has mo=
de 644
> JS>
> JS> I wonder why that is. In a shared repository, it should have mode 66=
4, I
> JS> thought.
>
>  This file is created using a simple fopen("w") and so is subject to uma=
sk.
> With the usual default umask value (022) its mode would be 644, regardle=
ss
> of the repository settings.

Maybe we should change that to an `open()` call with the explicit `0666`
mode?

> [...snip my original description...]
> JS> That rationale makes sense to me, as does the patch.
>
>  Sorry for a possibly stupid question, but what is the next thing to do
> now? The instructions in Documentation/SubmittingPatches indicate that I
> should wait until the "list forms consensus that [...] your patch is goo=
d",
> but it's not quite clear what indicates that a consensus has been reache=
d.
> Is your comment above enough or should I wait for something else? And
> if/when it has been reached, do I really I need to resend the patch to
> the maintainer and cc the list as written in that document? I'm a bit
> surprised by this because I don't see (most) patches being resent to thi=
s
> list.

My take is that this was waiting for a review, and I provided it (*not*
asking for any changes), and if there are no further reviews, the patch
should make it into the `pu` branch, then `next` and eventually `master`,
at which point it will be slated for the next official `.0` version.

It might make sense to ask for it to be trickled down into the `maint`
branch, too, in case a `v2.26.1` is released. I would be in favor of that,
but would not do the asking myself ;-)

Ciao,
Johannes

>
>  This is obviously very non-urgent, but I'd just like to understand what=
,
> if anything, is expected from me.
>
>  Thanks in advance for your guidance!
> VZ
>
