Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D903FC433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 16:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiBXQjD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 11:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiBXQiz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 11:38:55 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0E11201A5
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645720698;
        bh=lq8HJsApRZS4k8jg1eX+XaIUlEI/4h5TTvnpMN0roMs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JbkHrP690sO25Q4LavHBq+RsidNiLClD6pccaPJqUS8wYI+TGVGiMMMISgES6YZR5
         MRkhwXMFlEkzi6/17nqz8NnXA59E2cLQCtWCJ0eSa+gF8x7C80C03Qku3bM/rGRVgW
         Pn86ZaYJqq9m3LW/bIvNeOw449YeG90Fn8L3asAo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mo6ux-1o24Rt2cLT-00pbyL; Thu, 24
 Feb 2022 17:38:18 +0100
Date:   Thu, 24 Feb 2022 17:38:17 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 26/30] fsmonitor--daemon: periodically truncate list
 of modified files
In-Reply-To: <19993c130d22b1f5f7beaee1a23ac2d6b377fec3.1644612979.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202241736560.11118@tvgsbejvaqbjf.bet>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com> <19993c130d22b1f5f7beaee1a23ac2d6b377fec3.1644612979.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GtkTM5ss2fhgGZ+M7iuIMkKeHIS0XXFmRBF+px+pXb3oE/Mfq6F
 B5d50cHOgB2LtyLLOduDlwr1EPqOvpHNdwMnHaGghffffqAhrmlXLiIfWPLHJmP900f4Ig5
 uRx8fSaIcltpPfrFIESn0uR8iYyMeqL/vaQ5KyS6SUcjn79m0LidjoxIzMIbhm8040VnRnm
 EmWCMxf4OpWgVeZEmWRFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hvrPWz0xm7E=:TjljAJ3hETVXdt/TN2w1NW
 Xm2uiu/Cxl+PcfGwBY0R0gIL3iIO515R7AUze6lf5fwUw0Z87nwNa2D4/g1Rzl5MKxqN6jNQU
 FC/+LmmRhWKXSv7XMfBLsJz+oynqmTiGaO7ujVbFBOQpkSMIMyJtyBXLMWSOwQ9a43llYl8Bg
 I1GzVwXwcT3jb5xR2THncSIUwJcrOGlih9VvgcgX8+hvEH8KKPJDrv/ruWjDXI8Lnp6BzLoDD
 lM2S9mZCMprJCocSpkAK+tLvhvv31ZGE4HSPuIfdVMWq4ymUUs1xQJlMpt07npwIGFxs9FJ6G
 c7XtIkVtb/GAsa8Fz5w1xSgOlVXuaV+hOr/7vIK2sDCKvA8ZR7DpqX2fR5tWHgV5A9aBHObFo
 5gtQDv7e7dHWiSGC7rOnpWxTW0cSzU1YErMVt2DQU0Sf3X2KW5aPlO8AMpkQXjJ/LB/PeEYUD
 HpsGZnAO/D2LRQdso7j9aGcBeFV3xmNlN0p/rjK5whAO6E8KxIxCtGLNgUhEvlKscriOuaqpN
 vFtGiYD0uZxVyu8XTGnSYsBfXOusR/MdNaafzmJFVJKUI0Uy+Md1MnH34nSuE7g9YpKTCmH19
 7XMYx1UpmyQ2jY8XJTRY+43rbeFm0qefEjxWEHUgzoEbgvkZ+ggtpZN7+Lhux5vfSOgmrCAoz
 x57SNQrIDAFnjOqARrCjCaLkSe15W0/m2GsC3SvupyQfanGFiMMyfbf20chzmq/d/Z8LiHg7w
 pD+jXUHArx6HNEcFQ8pMKNCuhg5/OXaftOjMX62Wjza/kFNZ01e1+8AdwQSsQGBwswqQn+Nq5
 ppq/gWJT3WzQmSZ1Eub1OUVb4GKHwSTV+ckvMqv4fjgBbuE3rzO3NzbEsSnxL5BkA6tdZAzSR
 8Lf/q+2NwmUzEBKcdCF/1z6Xoz+inoKTOelbbu7jsikPB7NWzAxFm/i/VRiZFirChUccNeGkM
 uG13iWPtyNVyFKmX8fBTy2urLYjqLRdk6mz6U6MX2tJ8gLTRoI+y2v1HHTvZoz95Y/pLg+HtK
 Afv33cNurJqeViTATfCxu90/P5vHTtNXE3y3uEycAHz2z0q0rK8CY8D1xNOUabAv8+hNFIM29
 XEcvpjukKlwXZk=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Fri, 11 Feb 2022, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Teach fsmonitor--daemon to periodically truncate the list of
> modified files to save some memory.
>
> Clients will ask for the set of changes relative to a token that they
> found in the FSMN index extension in the index.  (This token is like a
> point in time, but different).  Clients will then update the index to
> contain the response token (so that subsequent commands will be
> relative to this new token).
>
> Therefore, the daemon can gradually truncate the in-memory list of
> changed paths as they become obsolete (older than the previous token).
> Since we may have multiple clients making concurrent requests with a
> skew of tokens and clients may be racing to the talk to the daemon,
> we lazily truncate the list.
>
> We introduce a 5 minute delay and truncate batches 5 minutes after
> they are considered obsolete.

I tried to poke holes into this strategy for a while, but failed whichever
way I looked. Meaning: I am now convinced that this strategy is sound.

Thanks,
Dscho
