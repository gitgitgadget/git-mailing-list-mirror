Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F103C2BB41
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 10:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbiHPKnV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 06:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbiHPKmy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 06:42:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAB1EEF08
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 03:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660644010;
        bh=WR40s5quqoMnKj5u1ll3udqvIt6r0ZhstdhvNbCfctY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jmo3MGbtLxXHWaEJPOiCuGmzOtEElR52U52qi1EtgWtOgbjWGMb09JpP42BC1luRm
         wZk+bffOagYOhwi59jWYf4PU1VZdMDKtDMkr2lOS+Fb0c/h8UOFFpq6Yca6aRXgHR6
         uoohiHX9l5mnsdPqkGIAzDtOHzBgq9vzaRU75duA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.214.151]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0XCw-1nTsyM1EqC-00wYs2; Tue, 16
 Aug 2022 12:00:10 +0200
Date:   Tue, 16 Aug 2022 12:00:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     phillip.wood@dunelm.org.uk
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/5] add -p: avoid ambiguous signed/unsigned comparison
In-Reply-To: <ec8204d5-9d0d-9850-f930-6fc1a8efacc5@gmail.com>
Message-ID: <p1nn7o5q-9r34-n27o-s8r6-50277p3rp604@tzk.qr>
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com> <4d24a4345ba66031d2ccf7ce472ed93ace82e9d6.1660143750.git.gitgitgadget@gmail.com> <ec8204d5-9d0d-9850-f930-6fc1a8efacc5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZHradS1BjMZ7bYk2wRK4uuozQBWnPphnLe031Xv9jwVxBOk2xy9
 OvBOxa9TQRXZ98OrCe7hEP2T+Nxq4DO4jq1wauqVMIQmRq0qqzXxZ8gSN8JoCZgt5/nqjci
 /RFRDLw9eeCC5yAqmEsluC5bfO7QuoTWYhorIqQEkR3D4NTifvlvprISfhUxrET4SRTy9Zu
 e9uCIltkN4RRIBWyJYViA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Icuf1wnSOyY=:EUz0Vco7baPZ1PO8blOytD
 bJ2YkeoFdenrheFOhdWxEjtONpqz8POWpGYlKTU0h9pwsGpqxEeIsm23R6fthgbl5MrAsmsR4
 NQzz9WjS+n7CEcB/B1+sSZbXcHb3sNuKHNCirdQ9biaUAQ1wv6Fikptgx2xMBafHpWchZ98H/
 EfqUtrK1sbqm/niYMNq/rM2xFXqnqpmhBBhtHbLS1zldMDE3qOi4VYWQ+aHfBQEIkGuXmoaXg
 1R3bNW6MN6WUQ3a3GucdCgMmajdfXong13Y1PIocPyjV0aVjYlnjQEHRCaz5b+8Oet9j625/C
 pXOxZls55168jofL6vz5GFv7PCkI0vqFQfYehZEKwn8Yk5+CIc0jLiFhQmVn0kIp5jDm9rho5
 ImOdHfuGhJeXhL7wjKUyrn6PNRNQO9vZxtWEGHmCzTjeb5yCFocNoA1QXPyEBRsruIV0v0H7s
 dIYsNeRNQ3Rvl4q1wLa6+6Fkhxc2Sy/wgpMlnRtlHm3c30vNiuas03HRwrRCo/JONKXKnGb32
 wWstJZ+XGvJr1+rA1SFh8OC6DEwSTe0cvjcmX09xy9t0N4EG1HicoSLD8ObJhfRc8LfUjAeF+
 iCIP35oSEVvAtu1fPtjNwecQ4gGHSGS+0JNWhs27VP2j0MJueK5YtP2AMZwJdFhJtthKCkDrr
 fk543oeRpgZnK6RtVjwYeXPlixSQdaAoBVtzberEvVYJUOsvi3xdbwg86nf22miI0XQ7mMH9u
 rnHyDc8/WOSrx+sWi+LXo4TAXnlgOYjoFiHW2kr0fbFC4HrrrZYW/RvcQpSyueq5MYRWwEcdP
 kwKhIpxNkWUgMBeBvAV0ns5Muz3dxwLqoRGkmzAEXuHalgf7rgxRBSpYzgD4M27VMdevnFaHE
 9k2NCANkzbWWzKPcRLq/tc/Lctm1fYtUwHFdIlyjpPZthrZ4cyVyjTpOJjN56zL3a/wZZ7JLr
 +H8AnAVUMj8tffldBJj5vF6FS6q1bo3Y3n967LGWZaokyzJ8xUa5zDlUMF2fcNkyMc6iIEyvu
 eGhfobKp1YweCchKlT9O9GE/RNxWHJvqPHyWPU20jddMsXlI797smD059VdNq/J9m79mAVu1i
 ei92EhDsanHd4FX+mM/1astuYoI2axy60wU5S/v/MAwCCps+HqMnBFrjQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, 11 Aug 2022, Phillip Wood wrote:

> On 10/08/2022 16:02, Johannes Schindelin via GitGitGadget wrote:
>
> > diff --git a/add-patch.c b/add-patch.c
> > index 509ca04456b..3524555e2b0 100644
> > --- a/add-patch.c
> > +++ b/add-patch.c
> > @@ -1547,7 +1547,7 @@ soft_increment:
> >      strbuf_remove(&s->answer, 0, 1);
> >      strbuf_trim(&s->answer);
>
> Unrelated to this change but why don't we just call strbuf_reset() here?

This part of the code is used when the `g` command (to "go to hunk") was
issued by the user. And that `g` command allows for a number to be
specified, e.g. `g1` to go to the first hunk.

The `strbuf_remove(&s->answer, 0, 1)` removes the `g` from the command.

The `strbuf_trim(&s->answer)` allows for whitespace between the `g` and
the number, e.g. `g 1` should also go to the first hunk.

If we called `strbuf_reset()` here, we would remove the number completely.

Ciao,
Dscho
