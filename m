Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC457C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 15:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7275206F0
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 15:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Ax4dTiZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgA3PBn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 10:01:43 -0500
Received: from mout.gmx.net ([212.227.17.22]:38943 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbgA3PBn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 10:01:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580396501;
        bh=TDwNI3mWT5bAYVFtuOB9yEUTaXAZqsakdgoCToR5Yxw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ax4dTiZrXCb1/x05Ec8EIjBmrSmMIR0km3Gu7sT5BHCJC1/6NAiDh2k8Zrd9lzjD4
         sXAbxjTTvuxe2PcHs2x8FA5qeclSW8jewjpTxg+fx29s0nqfOn7Gy4qrKqagdETttB
         YaKoRXcpYIRmp6Ou/N3+MfmqVUTVk+XSifEm+saE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAOJP-1iqGFS1qDz-00Bu9k; Thu, 30
 Jan 2020 16:01:41 +0100
Date:   Thu, 30 Jan 2020 16:01:41 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "Miriam R." <mirucam@gmail.com>
cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH v2 09/11] bisect: libify `check_good_are_ancestors_of_bad`
 and its dependents
In-Reply-To: <CAN7CjDCiP_KVC5Ey6cMuPN17vRNp_s4vy94qsaAKRPG=k3Rj3g@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001301557300.46@tvgsbejvaqbjf.bet>
References: <20200128144026.53128-1-mirucam@gmail.com> <20200128144026.53128-10-mirucam@gmail.com> <nycvar.QRO.7.76.6.2001301341100.46@tvgsbejvaqbjf.bet> <CAN7CjDCiP_KVC5Ey6cMuPN17vRNp_s4vy94qsaAKRPG=k3Rj3g@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-14620863-1580396502=:46"
X-Provags-ID: V03:K1:bkJ+ELWUH/AvRBFZR+8B1SD2GPv8ueZ1hKLusCsHkigit5IH7i/
 bZ5mnGrYYammeJiNQezcNM4Oow1UuBhBRej5MMMlKNaEFYvMmTWrGe0W/RxX7PEyDzZca93
 4NyeFzgil02NMcnYqh1u2ctdsB0O7GEMeuf0RqY9ujth+txKXFqNtdfjG2SxwUJvjDe0Sts
 m683PulaEuK2pKsy711yg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kEUwiaEqH9c=:dOSxRtmgSV5DAar4M4m5Z+
 s75bWnseek3M1kG7Lj3Vx+tP0WR3vDGV+MIRmUAU1co+NvKyJJPY/ItANgxeERwWQlyfiy7YH
 9TmEI37xwjkdQ63FpXRYBlS3sz2k52cArGcn0NwmHCqTF71ktkpDbG0e7m5vaPbRqLoTVCOVY
 ZY6juKX4viTuSEGPnp3GLG+OFCIS/0F1N/VJ8OL4H0TLkvF3Fxt8m58W50FcRUPKhHgWOHv+/
 P9Gg1BJQAUfEMmGZymeCWxj9zcA5x6kTU8V/ZA3BsOC/5iQMAE3QUsFgWjxNzo06WNCtG+6b6
 LMcTB7KYeOWu5THS9E3zvPOf6z4RQf+WJ+g5ACoZ98igBCG53C4+IrasCL7sn20yXJmAe/8I0
 xXrvHJubrA3CiGuIiJ2ElP2L+fYHuUDnL2gPyfdxO0u+7mc2jkEcxAHpckLVDpqw6Shn2Crz8
 GML5kVDgkXNzOOb9nNd8BM47ShqyDxfn+3pdtkFRR8Un/Wf2VoRgLYVj4U2z6Nybfd7oCtRmX
 HvucPmRFUwykqo2l66b4m9bfaFrW+z/bwGQHLgtMgv68uGzrNvtTLmn8lGeZT6TTf/jih0aS8
 DRnKNhcwcbMtQiPf2M7lrE+II25VESpj6BtRmglVaT6OynamueZPhx2s8WDD70TKCzDIgavLY
 3mDs4nDNvMyv8Os2rucn0pTUV1nhBgIy2TSBdrvhJh6LPzVRIaHzros4vyWtosOivDjFGOMWx
 bU8UfKFFoFBU71NzXh4ovhyNY5OQUuvnDXTbyf8pq0pIZbXEvn0iYphmvieXGDBShnxb9wC0G
 f39q7gIUsc6gkKOZcW/XEbYKHav4uIhyDiKPmSWW8OS8g72WMBOOPxPdbkbEk5z3wIKQXSlAV
 BAFq30osp4vUTI6TJy4TwGkjew/k5/VnM5vu2ECv7kyWag3f7POzcGT5j2ZZoS/d7IC8SMoh4
 fZu7FQe89N16yQqFZMuoYhKJfEWNlGgNMlvIcRv41tCqm3iTC43WmBQZjSId9EerSddboJnJv
 mmyN407r/u9eFW7u0he3Ybofdrc4nlMxnl9TI/+wnmsiMQVDjCkVhlNy4Kd/MuPX8THJlRNIV
 uhAwiQNKRL/fJptXH3ZX77kNh89ayQTs4RqMO2jPhJYP9aYjSC2eUMEAbv7RPJGFbt2o1XAdh
 c0hK0YeZWbo5Nn3WmxdKwo7XMj7Pr3ZGjApbfmbInQUZVt0QHutM+hGjMb1h6KLNtGizyjUdF
 dREeXqSowTqQSEWp+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-14620863-1580396502=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Miriam,

On Thu, 30 Jan 2020, Miriam R. wrote:

> El jue., 30 ene. 2020 a las 14:46, Johannes Schindelin
> (<Johannes.Schindelin@gmx.de>) escribi=C3=B3:
> >
> > On Tue, 28 Jan 2020, Miriam Rubio wrote:
> >
> > > +
> > > +     return res < 0 ? -res : res;
> >
> > This is a change in behavior, though: previously we guaranteed that th=
e
> > exit code is either 0 on success or 1 upon failure. I am not quite sur=
e
> > that we want to change that behavior.
>
> I think this is because different error codes might enable a bisecting
> script calling the bisect command that uses this function to do
> different things depending on the exit status of the bisect command.

Oops. I am _totally_ wrong on this.

As you are changing a lot of `exit(<n>)` to `return -<n>` with the
intention to turn the value into an exit code only at the
`cmd_bisect__helper()` level, this is actually required a change.

I am a bit uneasy about this, but I could not see any return values in
`bisect.c` other than 0 and -1, prior to this patch series.

However, I would love to see this refactored into its own commit, more
toward the beginning of the patch series, with a very clean commit message
that describes that intention of being _the_ exit point from `bisect.c`.

Without this change, you simply cannot change the `exit(<n>);` calls in
`bisect.c` for any `<n>` other than 0 or 1.

Sorry that it took me so long to wrap my head around this rather trivial
idea.

Ciao,
Dscho

--8323328-14620863-1580396502=:46--
