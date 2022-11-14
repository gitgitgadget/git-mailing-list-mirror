Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8563AC433FE
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 13:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbiKNNr1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 08:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235786AbiKNNrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 08:47:25 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E791C23EBA
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 05:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668433630; bh=w/e9Rvss5z0VP9x1xRD+xklUQuxIIG3YretV0hAzMuA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dS7O1iveGoomJBPm1YEbmlthVDeWSFQGTzRKpiObGBs7BafDFsFIbs4HOWrLSQiA/
         EZRN+6QIdFyRUznmqOKVbGsToBq4Qhy5dzUu1dMXKFE6zifw/N868O8OqM72XO7zv2
         7JZ7y6urRoJyHhAc+g+KyXfJI3MS1tVacse9iDEV+Fzf3rcWXmDQKX299p09vFrGkp
         WTrqzh5sCxw8KGVc8HxjMaM6gH/s5evhhYDC4EqOoFMPrNWPmJ3nx48A7+3ZJykVDP
         ahG2poKogO/p7j941wrlJm4lmhqus2u6NEAr1AE0A+ULow2cLJ0v8SVWzdI8yTv9Sx
         0A15i8VayY/1Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.27.84] ([213.196.213.188]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M26rD-1ox3qB39GT-002XQL; Mon, 14
 Nov 2022 14:47:10 +0100
Date:   Mon, 14 Nov 2022 14:47:09 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     phillip.wood@dunelm.org.uk
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v3 2/2] tests(mingw): avoid very slow `mingw_test_cmp`
In-Reply-To: <8ec8f3f5-0827-25a3-464d-638378b65ddb@dunelm.org.uk>
Message-ID: <998821n6-6sp3-30q9-95s6-p7rp5o8nr5rr@tzk.qr>
References: <pull.1309.v2.git.1662469859.gitgitgadget@gmail.com> <pull.1309.v3.git.1668290855.gitgitgadget@gmail.com> <a7f4265ceb26c6dd9d347ef4cbef2aac7d60bf13.1668290855.git.gitgitgadget@gmail.com> <8ec8f3f5-0827-25a3-464d-638378b65ddb@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bLB3M1AwxDxl0y10y1Z3B3sOnN8CBeoeWCvbPVM/qApDQTSdRp1
 PFRFKrN9xNHaAy1LGDRqTp1R5qnRHm+kdrnVUXV/nJ7llHn8MMIzpPDfDdpf6iUAJOrLkt0
 ojFQOulw/Ybcfrqa2l4wLo09/yv9gIYNX4K2QeXyenkCq8t8UCCRWzXlgoqZCM5hbyNYPLN
 32hnZUQkvs/vAfq3xXN/g==
UI-OutboundReport: notjunk:1;M01:P0:GWqr7mzuGKc=;d0b3X0QetXzygpJHarIQij1QlVp
 RJgRDTpuHomagv7TCo0EWTr3RdPEnUoR17y8I62/rHCtnJXr327/6GPn2/+E+F0wukxDO6Swm
 kSWyH54p7NFXVszqzLrS/POF+mGmMm9L3Dy5ue6cHbXEzErAtBvUuFO2IeK/3QCgYXfYojtU8
 dL/a+hBMAmGVLbhsyFvfivhu5gKpFrBID1Q1mTVj/+QIEeAVUeScRVyBOox/wzuOtvZ+zxDic
 hI+k6SILFXtTq3cpnR0nc0RaxblHLxJR9yHHrrr3oL7QRsm8R2STBnvhmAF6DJU7ko37kb/z4
 DNAXmSI7WN3o7iGL6RC2P+PrhS9rpoTmuSVcPvPr0MhxGRBQD2gq7WVH9w5OLT+S+I5rgjFkq
 PLL19W51jDdOeRy8whD/q3Vaq1WUfEmBZSRq1IsX+AWM1+uLSI6RS5BDEsAYQ9jn7CB+pAkvv
 VNPkKZFtHucA0jpH3UiI0zBYbHpLudYGXf4xFG2ijh87SPHhbMbTpDPqZGubLBXbp0BDBFGdb
 tGBrKZPRNgIUZfMQCYb18cHTqZ+HJ75GQT2se40xD9YXZFnxGY1Ofld5Q5pqXJ9KHgnPXoyzQ
 +3dQI6GifWTRKdc94uioyoR49xTD6z7SrCfFp2R1ykN3GjSgSsr+VXkAmW5mi40ASN76RytXx
 NiQL79IPL0YUlmLQR6VsOORpfMc2rd23Z/smnBIQxbzhqav+R+CKPlvl4jqn4YhCMQ3UQFCtV
 /CQlFDej9qazzbP4unSpgGgKs6zOUIHpqieETZoY0iRC2vSwId4Z3l1gNvMYohhi6ejBFQWEZ
 OaGO94NlyLN34Bp+eE3XOyj/Nhv3BP2H2GRfULxyaHps/IjnGm1DPANVlYbuxj3GKCvPbMiEs
 kHv9I1cuffCXBce52o/EXSsoSF63509NBa6tN0D+/3HajRLedHyNIcgV6N7J5/CreeF+xmbQg
 UqLjRw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 14 Nov 2022, Phillip Wood wrote:

> On 12/11/2022 22:07, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > It is more performant to run `git diff --no-index` than running the
> > `mingw_test_cmp` code with MSYS2's Bash, i.e. the Bash that Git for
> > Windows uses. And a lot more readable.
>
> This makes me wonder about the implications for our diff tests. We have
> ~200 calls to `test_cmp` in t*-diff-*.sh. I had a look at
> t4053-diff-no-index.sh and non of the tests that use `test_cmp` look cri=
tical
> for functionality that is used by `test_cmp` and there are tests for the=
 exit
> code. I suspect that if `diff --no-index` breaks we'll end up with confu=
sing
> test failures rather than misleading passes.

I was surprised how little of a dent the overhead makes (it was not even
measurable within the noise) when I tested this a couple of weeks ago (but
then ran out of time and motivation to send a new iteration).

It would probably still be better to use less complex code, but Junio made
his preference abundantly clear, and if we wanted to save on CI time,
there are much bigger construction sites that we have to open. Point in
case: our CI runtime goes up, up, up, with no real restraint going on. A
randomly picked run from 6 weeks ago took 7h14m of build time
(https://github.com/git/git/actions/runs/3175983767/usage), the current
`seen` run took 8h48m
(https://github.com/git/git/actions/runs/3448435246/usage). If there is
considerate use of resources going on then please help me because I cannot
see it.

> A side effect of this change is that on windows `test_cmp` will now exce=
pt
> directories as well as files but I don't think that matters.

Indeed, I would believe that the non-Windows test jobs would catch that
failure, so we do not need any extra code to check specifically for that.

> > Note: Earlier attempts at fixing this involved a test helper that avoi=
ds
> > the overhead of the diff machinery, in favor of implementing a behavio=
r
> > that is more in line with what `mingw_test_cmp` does now, but that
> > attempt saw a lot of backlash and distractions during review and was
> > therefore abandoned.
>
> Hopefully most of the files we feed into `test_cmp` are small enough tha=
t the
> absolute difference in run-time is not too big. There is an optimization=
 for
> -U0 that trims the common tail from the files before calling xdl_diff() =
but
> that does not help here because we need to use --ignore-cr-at-eol (other=
wise
> `git diff --no-index -U0 || git diff --no-index` might speed up the comm=
on
> case of matching files).

There is similar code in xdiff to "shrink the box" to avoid unnecessary
work, i.e. skipping identical lines at both ends of the line range:
https://github.com/git/git/blob/v2.38.1/xdiff/xdiffi.c#L261-L265

I share your concern, but my current concern is to cut the loss of time
spent on this patch series on my part, and that concern is currently even
bigger.

Ciao,
Dscho
