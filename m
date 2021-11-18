Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F44C433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 15:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3C10613D3
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 15:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhKRPnX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 10:43:23 -0500
Received: from mout.gmx.net ([212.227.17.22]:53261 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230376AbhKRPnX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 10:43:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637250019;
        bh=LCK+EQvTOi+jxP1AA/2aG69yY/7JxsZ5PaKpExw+URw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AvXh27fVcmrFcxWj7aSu2pKF2SYLjJnNBrakKi47pyCEYZvDlkDPgvXIZ5I9q/1fx
         XQpRcvO7ijx9cOffs/gcSSV8wm9gOdxCsc3elF9f4t/06onKFcW1r88LORCC7L0SOY
         9WnFF6BwpDMvXn/M8LIvIDN381L22XXG+Nx4o4+8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.166.205] ([89.1.213.220]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2O2Q-1moIHt0TAk-003ytR; Thu, 18
 Nov 2021 16:40:19 +0100
Date:   Thu, 18 Nov 2021 16:40:17 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 0/3] xdiff: speedup histogram diff
In-Reply-To: <pull.1079.git.1637148025.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111181636580.11028@tvgsbejvaqbjf.bet>
References: <pull.1079.git.1637148025.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Ywl4QcOb2knGhiBzlnP4CBHwrpJwZEpLSk683twfzA00zj9iexr
 ZWT4AuEjBnsveVK2hI/olj/NmP27Xd6qE5mcHDOderwaXZUxj3fdBcgtbJhkbgbppks0Qob
 yTeNeFWZSzLnuSsU3ZhVT2I2GJKg1iCaLfD377jxi9730XsjGs4DZWRQgN36hFvfIX3uqt5
 +8KHYh6NSLF13jw7lM/vQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JKTw2QrIgZw=:I2MOAMzdSDMuGmvOQljDSm
 2/eJL9gifS3VM+7cswGBL77F2+jXyHf9EEpWQldox8c6P4nfPIGr4V4wA7Qq2m8jL9q6J2/YZ
 Xdin8f8p1bgWY13U+DlL306OpC3m5ps/1XribWBYSFjpjmo7cZC0TTaDcW1LQ3vZ4JSf+Vek6
 ab7HyvXUBgqU0CZTjR0h1HWtiGBZytt3Hdrwcv+hpF4ehznWK3aBPcYoYFJNORrc/lGyNiQzk
 fzFa22yaSTFI21m1pM8Ve/kuVA6talXYj2M6R9jDBrwuFhhw3CZSyz07OEU+YWLV4tHvN4BvR
 +TS/l/RpynBnXfVsFVv/ZUP1ls2gzngbOTh00apY5PtHHPQ4XfJCEawlOi78PwyDePZT+P6yM
 gMGdhSsPTZKIYXRTY747YTaDXW4t1JDEZ/28Rhq6LqXy6IrrZOTkCYZ/ffOiyDSP3L0XGE+RZ
 K9eetZ5DyrPh6mOrSBjYC8HGPNgpG6jrICWsyRQo+g8S7WGa7YjwAc/h0Ap40VfIiZqU4luDQ
 qQBi6AEZCISTufCIiWAvSsBkoEiPnMoQJhGeZlRMNTlE7MWAZ2yLG7koMuTWMPMRylLFnzIH2
 H635MmhT48SjTf+zdi1jeSStqj3LZlHCqCH+cF+P0z0urxzyqTzitRPP4pjYHo3f+LyCRR3vX
 pF9zBiAHyxtn+JRJdhHm7X5SlTd2006Pb/FaQoEFTNJXcphj8fip/zhjPYWKVyfu1TPBHWGHf
 VjFQfkT7qnqUQRDZoBkBufYqk89mfCqPV0kruHyDi4GrInrL1raDzokadJP8xNtPXM5QI/cXI
 r5dfdkPfuJfrPrTK421p8k7J3e6ZVjbwwavDmqLFV33nHSHVio3MIfbh9d4fLcFFkGugHd5Gl
 cwFvidpEyGDC65KFHS2/aSY4EiDpj+MdVoDcD8Gc2XqY9EikIS/+kMk7hol5Ce0DbK1ED2/7G
 A/jz2k79RkhpATHm/1FMXq0bRskLaKo+fiqYQRJP33NrgRuR9HApZ7OjANZKmhNKOCaoEi4Ph
 7hyVEX4TzZwW3FvbASRtT5pG/3p23y++ewf/V9qqSt3oW+An1ox6V7XPJi7kkE2gp/I8jkhJq
 EN7QWuRTW4hr9g=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 17 Nov 2021, Phillip Wood via GitGitGadget wrote:

> Histogram is the only diff algorithm not to call xdl_classify_record().
> Calling xdl_classify_record() means that it is not necessary to use
> xdl_recmatch() when comparing lines, all that is necessary is to compare the
> hash values. This gives a 7% reduction in the runtime of "git log --patch"
> when using the histogram diff algorithm.

Thanks for this! I had a look over the patches (and refreshed my memory of
what `xdl_classify_record()` does), and they look good.

Having said that, I would love to increase my confidence by backing up the
patches with a sort of stress test. Do we have anything like that? I guess
not, a `git grep histogram t/` did not really turn up anything promising,
p4000 does not even validate the output...

Thanks,
Dscho
