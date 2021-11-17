Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC896C433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 23:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C05D661B9F
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 23:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241514AbhKQXRp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 18:17:45 -0500
Received: from mout.gmx.net ([212.227.15.19]:55879 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233853AbhKQXRm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 18:17:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637190873;
        bh=sa9/N9I69VP3mNTDbSmnN96AqaitgiY3qCCct0W+RG0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Jyts4tfd0OlkXBIuMT+p9mXM7l7oOW8I2IOodWecbromUWnJu1OZhkgqxNKF7pGdb
         suk/QULrkQ6uuB1gfa95cgRD35I+wNNCaf+dFzUBlsPaMFVivNuTnMxRaeEKUINGcO
         HO3ctA26sI4f600ySQkJUTVTKEthVTXDnlBRGw6A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.166.205] ([89.1.213.220]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEUzA-1mugCp2Cs6-00G2Wu; Thu, 18
 Nov 2021 00:14:33 +0100
Date:   Thu, 18 Nov 2021 00:14:31 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] Makefile: fix parallel build race
In-Reply-To: <YZR0djZbRUicXcQm@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2111180012470.21127@tvgsbejvaqbjf.bet>
References: <7d82342089a80b19e54ac8997d5765a33951499f.1637112066.git.congdanhqx@gmail.com> <YZR0djZbRUicXcQm@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:W6r4ngkD2fIImkOeWErQXpoxkLPLWDoOl8H7Dy5/1SksKnfj2z3
 hKCxUmLci4oHtaR48ToaO4vwvjQw5m2aewn2T88KU60cJ25JweUy2AUiCfXXtBAyMUMs6/U
 8HLqVnZxMndqh929IVLfE4Bqk79KYv769U4/PbJEpu4ah7TIWQHWyKGg633gjBVuF4aB1A5
 W28yX/rW69BpOQSGBzfDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c+8K//PWYec=:HlDfot1f0mXLLJQluYd2pn
 hdIlXRbug0diAj2v/qFPkMBAipzp/GSC8oVPt6xwHwoB4MdZRou13l6oqwxQixiV4izJhrfEw
 yCdfP8jLJ4pwjAp3ta9W0LrNrpsPrfIZBNA+DmugxQSMtkBwRyraktTVU03x7ZSqS17thaMCR
 5emJoiGWydIfpl0HtaTlH/06IB4HIEpEvtOAQ80b73aKmNEza4KkgKMmRUFuImfH9QAjTXOIV
 +T+RWTDT+PfL50Z2DkFNH9AMbe0WMSFH5BSydMOM0b2r6iiZL+HByLmiYS61hfevCmMeL1OFQ
 wbpq/thxWqZgwI+13m7g/p7hE8aA/KVrvYR8Nf9DyqntS8foEEWWP0lc8RcR9CmbIZJnEzx/J
 ZrnPx0zrHoZL/oelT/4kbTQ5pWU/lV+B3PyslDg6/GSuQP2KyYSITvuuNL2YZWxc1jRCIRSph
 f0B1e0qu6cKcSJqxEjjFZjBpMU+wqz5AhAQ/58hqOJfX5pjSyo3fSc36emii82XuyoKDak4Xd
 gJy50jKXXJrBTiCqhHH4ZkodxXCnO8eRV2L6EgS8i0Fx72EbOCRJmDx3pewW1KCeOJR9la08r
 P5XgFW1oR2t79knDfADnNdKRmz1gyQCrNAq0dJkizaDWYel5yENwPVuvNMa+cW9qDQBSWPE3n
 LWlpqi8AFXVc+PpJEitksWs/uAPfwiR5v23iaYsllrvSPFePmtlYog888ohFqgcEbChfHUVx0
 RC/oL4jwgoeJGyzYIV3IGGETQKE8mX85+8yISMh9AhmTp2u4VO/7Ve9GYyWiog++FEK04WelH
 4dt//82DIHe/k8Z/vfqafWf7RK4S9XdzMdTabSc6kRX21vbryzDiP/UguhsSGElXRvq/GQSCK
 ydJON9vkdPhqppYTtuE448f0Tis28RRbyqZ8ns8Ob3KsDMYRsQCIw4HaPgHWXfGPrrXsOiQLe
 2Rd19pf+IxWCwAY0pv57SwSjD0JdMxQdUd2WwAEZaTRnUqVjmAz+ksb/GBHFX8c48i9THfkVZ
 WOIStrCH3dXkH6pcoII0IzokBBqjON+LifjtF2NC9arvvKlRBUhhHxPuMpOLbuq6IAOlZ1UYh
 Crc5+zv6Jfmprg=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 16 Nov 2021, Jeff King wrote:

> I wondered if contrib/buildsystems/CMakeLists would need a similar
> fixup, but it doesn't have any generated header dependencies at all (not
> for hook-list.h, but not for the existing command-list.h). So I'll
> assume it's fine (as did cfe853e66b).

The strategy we take in our CMake-based configuration is for files like
hook-list.h to be generated at _configure_ time, i.e. before the build
definition file is written, i.e. well before the build. That's why there
is no explicit dependency, it's not necessary.

Ciao,
Dscho
