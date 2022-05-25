Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B072EC433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 10:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237918AbiEYKIR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 06:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241554AbiEYKII (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 06:08:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2BA7C15B
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653473269;
        bh=PsWXygbXkvRVQSjE7oDa3WNwdMcrQz+eNYBMG3HPzJs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JHvBtVRuniuOctzqCyt2Bxze9syc4MJJ8FSoEQ4jSuig1PaX2T4+n2Z6J72s3Ecyi
         ttN0J+QE7AqnltFQrlMXyrrtMOPqskgzZgWF2vMirG7PDeBLoM5hoq9rvHjD6xyTMI
         L0t1wF76Ws2Hz7+j7NmpaZhmlF31pGFoX0Tiju+I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeU4y-1nJMeH2L9I-00aU3u; Wed, 25
 May 2022 12:07:49 +0200
Date:   Wed, 25 May 2022 12:07:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH] http.c: clear the 'finished' member once we are done
 with it
In-Reply-To: <xmqqleuqefa4.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2205251111300.352@tvgsbejvaqbjf.bet>
References: <cover.1651859773.git.git@grubix.eu> <3f0e462e86625a3c253653e4a4eefabcd8590bf9.1651859773.git.git@grubix.eu> <xmqqtua2jtr0.fsf@gitster.g> <xmqqczgqjr8y.fsf_-_@gitster.g> <nycvar.QRO.7.76.6.2205232248360.352@tvgsbejvaqbjf.bet> <xmqqr14jluu4.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2205240124280.352@tvgsbejvaqbjf.bet> <xmqqa6b7lrw6.fsf@gitster.g> <nycvar.QRO.7.76.6.2205241258510.352@tvgsbejvaqbjf.bet> <xmqqleuqj1gy.fsf@gitster.g> <220524.86r14ivewt.gmgdl@evledraar.gmail.com> <xmqqleuqefa4.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-309445249-1653473269=:352"
X-Provags-ID: V03:K1:p+ZvolB3bzycK8MibXvTnHRIAELxRvpEEgaLHQdKrqksLvTzte6
 WJDcvzi/gCtbqQeZr/0ufy1xqna4QteJsHwtuOAnvZa6uEDaah9AlQcW1jhuy5RoJNkpJlh
 8mEB6rUK9Nk8H2cgEfd986ona4q3zdO0R7qN0nZeSAjJYVbj+R6bOvw79LAHn1JKajF7IeW
 lKkegSuuOuiFPpVrZRd6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:05YSD00GbyA=:a9QDDcs19BKFG33QoFgZ1L
 ba0eVwLrA438ZU0ROYZHjouAgvXRkJfRTLfmXC9VgSvfceMR21fBB8gR54l7PyzCSCy/sVvdu
 W7PuqBAX121+RbrTtdJF4+LbV8owwgVsPZ4dmRHsC5Iyc7Hg1kH03R9V8n2SdmKu3H8cLyocY
 8DKqkwa4Fw9UEKhssKhSh/41uFJaueMYte8pmOSrmGVFrCZ8/CyYnnZ6AqCbEVK+ARyTKwHf/
 HO5o2Zc1KhhT0TN18w9Fl+aIYz5MnM0DxD40zTpuioQyNQ3sqPtG3YpM/w/JQM9xQe2Sh7Bvr
 bftRQybIAX9crlDTqiB5lY4pAm69+8VxDV5gffpgb5e5iYvNy9wYvfKvIFqM15nTFDz5T3UWP
 2sTY2WReGaHMHxYD4AlRdFXYC08j+1rOQvC9TAXN87xNx+sAS/JRIv5q44CKARPwCEcLehhUx
 SdZ4+gYTvrjF11JxFDroOwdcZ71vICUfy0DxNtD8K1/6OOkqYFR0JmSQ8VObJaK0/p2GGyuMQ
 /LR48IZTw7ZWY3agLV4Vfx+8iXSt/s7Tfi6ZLCVJ3UQ500zK6UUjRp+faVdVOh48OIV9gb7yA
 Zi6apDA8TNuBPAdCR2x3sHKm4pw+xWB549i4jy/FUGESX/Hq6+xvhdAJ+gBqU7ecbeW+PDbJM
 dYAboCumxeYoz3QklJuQC2mW6BmlcwbVMiF65OlqkeUCwjTP2rH7wWJ3NQHGqjUyzOjGDTq1F
 f2GeUT6PWgS/LKKCFaxFZH3MRrvN2ZjbpKDxBJVCKhiR1z1UhH2f3BhnOs+JlCiVkWjDNxazC
 XHTsMqd0CCOGz7nI/L5C33eobFDblFEBX0zCFhsIL3XazyG55n7KAViNOAxSILPL0e+2aLET6
 4pbsSvgf0oSekbkSEjJGVCuVRnzjLDP+E2Y+4RoN2rj9tf2FyELbP3YNnvwJI5xaEkkla0vG4
 YwPiKT4nPlmawpfFe2LhPSv/NFr67CyOojjhVknA3QRhMYE44VicmIhCz7t74gWnoAoMQBTK+
 74977VQvqK+IpYxPeVBo25MflW+aGhXdWQDxKsfvGTZkjy8Q1b0td+zmxyXpbHM4V2tqD3Udq
 DN4+Ne2NHcB5njfCeCNhlusQXCmAujGD1+q1bYMDEKDiFCtOdOTxkcCEg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-309445249-1653473269=:352
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Tue, 24 May 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> >> I _think_ we can even get away by not doing anything to
> >> slot->finished at the end of run_active_slot(), as we are not
> >> multi-threaded and the callee only returns to the caller, but if it
> >> helps pleasing the warning compiler, I'd prefer the simplest
> >> workaround, perhaps with an unconditional clearing there?
> >
> > I'll admit I haven't fully looked into this again, but does anything i=
n
> > the subsequent analysis suggest that my original patch wouldn't be a
> > working solution to this, still:
> > https://lore.kernel.org/git/patch-1.1-1cec367e805-20220126T212921Z-ava=
rab@gmail.com/ ?
>
> I traced _one_ code path as a demonstration to show why the current
> "slot->finished =3D &finished" based solution works.
>
> But I think what we need is to demonstrate a code path in the old
> version that shows why the old slot->in_use would not have worked
> and the slot->finished was needed, and demonstrate why it NO LONGER
> is the case in today's code.  Without that, especially with the
> latter, I cannot take the "just revert 16-year old bugfix because a
> new compiler throws a warning related to multi-threaded code to it,
> even though we are strictly single-threaded" as a serious solution.
>
> And because I do not think I've seen anybody has done that necessary
> digging, I would still prefer the "if the compiler somehow cares,
> then let's clear the finished member once we are done with it" much
> better than "we do not know why but we somehow think we can do
> without this bugfix, even though we wouldn't be making noises about
> this piece of code if a new compiler did not start emitting a
> warning".

The commit in question is baa7b67d091 (HTTP slot reuse fixes, 2006-03-10),
and I did look around in the Git mailing list archives for mails that were
sent around the same date, but did not see much that would help understand
the context, except that the patch series clearly talks about `http-push`:
https://lore.kernel.org/git/20060311041749.GB3997@reactrix.com/

The thing about `http-push` is that it adds a "fill function" that is
executed in `fill_active_slots()`, which is called in turn by
`step_active_slots()`, which, as you will recall, is called within that
busy loop in `run_active_slot()`.

And that "fill function" is where it starts to get interesting.

It's called `fill_active_slot()`:
https://github.com/git/git/blob/v2.36.1/http-push.c#L604-L625

This function starts requests, such as fetching loose objects, starting a
PUT or a MKCOL. Notably, though, `fill_active_slot()` does not wait for
the request to finish. In other words, it will potentially reuse the
current slot if it was _just_ marked as no longer in use, and then the
code flow will eventually return to that loop in `run_active_slot()`, with
any reused slot still being marked as `in_use`.

So yes, reverting that commit would reintroduce the regression, and I am
very happy that we now have a grip on this Chesterton's Fence.

This same analysis, of course, also puts a nail into the coffin of the
`reserved_for_use` idea because while it would fix the reuse bug, it would
unnecessarily squat on slots that might well be needed.

Ciao,
Dscho

--8323328-309445249-1653473269=:352--
