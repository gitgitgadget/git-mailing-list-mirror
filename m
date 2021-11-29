Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF334C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 21:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhK2VSk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 16:18:40 -0500
Received: from mout.gmx.net ([212.227.15.19]:35339 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232664AbhK2VQM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 16:16:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638220366;
        bh=NQ1zsUArbvSziHRBwGK89d9+r9ik5Wvob6shbv67dUo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Yz+3iEvG4C3u9M2RJdPFJP7RFRFXlMkai1WYUtOQiIIDj7Rhclk8Ys/d+W7TK70kX
         31e9ZH6+VYUojlGkgbM28VWzpzafrtvX/niPERpv/LbayRF2qUIh2E2SPbJZdj3OQD
         HUDd0Yjs5W5wFJw23FJAAQP/I+D013yl5lvy5OAE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUGe1-1n0qMP1ryF-00RH5B; Mon, 29
 Nov 2021 22:12:46 +0100
Date:   Mon, 29 Nov 2021 22:12:44 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org,
        phillip.wood123@gmail.com, thomas.wolf@paranor.ch,
        Alexander Veit <alexander.veit@gmx.net>
Subject: Re: [PATCH] editor: only save (and restore) the terminal if using
 a tty
In-Reply-To: <xmqqwnkx1h5y.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2111292208180.63@tvgsbejvaqbjf.bet>
References: <04ab7301-ea34-476c-eae4-4044fef74b91@gmail.com>        <20211122222850.674-1-carenas@gmail.com> <xmqqa6hvbxob.fsf@gitster.g>        <CAPUEspgDafXHHPvzNijTsPsna76yE8W=JH-78LX3jyaieSmp0A@mail.gmail.com>        <xmqqtug293ml.fsf@gitster.g>       
 <nycvar.QRO.7.76.6.2111241428190.63@tvgsbejvaqbjf.bet> <xmqqwnkx1h5y.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Ik1u+FFgZV40H96RwQs7jnLElmYR6xy7+mzIY/9dEYtPRFoo1Y8
 y7PquhVbFQfU/8cOU1A1Sz/VneUvvBY2WDdxh1c8pqkA68AapVKG1EPXgG9/WW2Waq/ZEcC
 C1Zlv92zdxjyFVWI4Rm6vIi+o10ijC7wro5ByXQoUF/q/Cjl0Gx5cTtP5mW2IvzB32A7dIY
 poK8XX0JTxqpA30Mf019A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W2Y9iBZGsaY=:z+vyQyWwIE6Mbu6bV8cXiO
 5SGe8boMhYHJ8KQoqMBznZslCt8q6MIv38Qrg8ppYX241e3eImt/epsw7PTlHnKfbXToqAhI2
 0jkW+qsZ0jpfPgQiwm15V6843fbNi+TN79Z20qqxTSJWb60ddXX7fNdRthZL7LCFLN7KQKwBG
 5OOBEhLxNxVXn3maMprxXtRtHObrwj0fQiNZIpFERKx8W+8ex9F2Lgc4qPicIGTrObvACq8hO
 t117fUVMtyeuRrI/T29Rp32CODAq4bjcejN9dQkZobmnVgw3/GDiZyU1Z1kbo3Mr/BphbrHbr
 LkkmEyYLCHY0n4AQ2wWxcMgYrODlVGp+Eg4nEb5DjTjnz4TXYSQC/CW0MD+kFkyJdigxxqHR8
 0o4itaD1l0WZmlc+yYAuxOtuYvPVMc6bx+FYx9NzIwj2L9c6p7sHSdwEo8JKnqmuVFKgmrLa1
 aMHWaSyOnPneIC97gUEvbKjUGIl/lPbcyyRaCVV0sadUWYF/v65zN9O3966nPv45ath4POMiJ
 IQWD6jAwMTMyjRULQHUQTQ01MP1QdZM+Ooi7aHvMI+b3vedZVMTInwzbxozdbvROQcBQPBl24
 i0mAKRGN/aXT2LsisIjhSAGhP1/hsnqFMKV00RYagrRcmHv3ThKrNtEtrtTASP4Ugfz1aGYxv
 M9wdm0JDBLyEJPNkpRVw0jwGgcP180G+jnqwGFbnCnoEa5ketb+3c5Lbn9I5CDJpWyyXWSrSw
 p3qOpsKGI/v0E0IyahFLWvbbrCMJhBaZXkh4FI3WQsqHSRBbpDjTiXMSpn9VMc61BacdqES+O
 BXd3Z68E0FCwGsGt3ZwD22LPlo8W7D6Fcp2pekJ9uaP/jyla2f7Or/O0jHEGQ+BaL5Rrg8LC0
 GHGV4vgWSaN+1t9gpz6ZW+pspElbU2k51RIjTBif/uYT9Wh6SR/dfJ6wnSf6RDSB2hZyo19u5
 uvQfF/+F3nAwLqVNyM/cCaZzfwmzM6B45E7VKBCRLd3USj5iNy1BfzvhAN8hfZXEHGQKPNExo
 DB7aRI4HQ18BY64ecq7WrltxcFw3Xf/oskH8XBRcAhs9vRcJ6aRuE4jE5EVtjipZI9JxhE/86
 9rdbLZZ0KM5C/g=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 24 Nov 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Maybe a better approach would be to hide the `save_term()` dance behin=
d a
> > new config option, and then have it turned on automatically if the
> > `editor` _happens_ to be `vi` or `vim`.
>
> Why 'vi' and 'vim' are so special?

Git's default editor is `vi`. That's what makes it special.

> Is this an attempt to paper over a bug in 'vim' on the caller side?

While this works around a concrete bug reported at
https://github.com/microsoft/terminal/issues/9359, the mere fact that this
bug was possible indicates that Git needs to be able to deal with such
bugs, whether the bug is in the editor, in a POSIX emulation layer, in the
used shell or in the terminal. It is all the more important to have such a
knob because there are so many potential sources for buggy behavior that
users are unlikely to have the expertise to even identify which component
is at fault.

Ciao,
Dscho
