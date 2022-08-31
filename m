Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C918ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 20:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiHaUFx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 16:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiHaUFw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 16:05:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7664949B46
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661976324;
        bh=RdLUWwm7rt+GLd/RMeyk9c4z7hRMbzV26WK66FDtpIQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YRWn+/sCHXK2a5dBMSwJITJLaqnqkSWfLvZHkvnEfr0x7DQX/fLbz/Gnf+VeNAYER
         cDuyENoeEAuXAdgUBuq/s1BSGegvdcXCDZ+S4Uht3fikxpyW82Sttiu362PCngxxm/
         GUurEPeC+FOWi9trkqv/uLlyzCoYUiZSY8cvY3Vk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8ofO-1pVhbu1046-015tEn; Wed, 31
 Aug 2022 22:05:24 +0200
Date:   Wed, 31 Aug 2022 22:05:23 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     phillip.wood@dunelm.org.uk
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 5/5] add -p: ignore dirty submodules
In-Reply-To: <c205f8e2-62f9-d4b2-0ccf-51dcabc12224@gmail.com>
Message-ID: <op19530n-27qo-r35s-r1q7-18s3259ps78o@tzk.qr>
References: <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com> <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com> <cfa6914aee0d3ef84d726b97699f438fd4b254d9.1661785916.git.gitgitgadget@gmail.com> <c205f8e2-62f9-d4b2-0ccf-51dcabc12224@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cFHDjq69W0eW8B7JiXncr2S1zZipA20x7QlOzI1pAnniOp9opUX
 gBiG3JU+68Dx4T3uzoe3J1F+cYtvREmQyMnmYmwDIP2ecy6VIgPCbJvMjRnwdCMA5A9NdkL
 qhr5DDl7ANbwC79m2lR97eprbs8nr5Wbfg3Hv2a5Sz6Phf/+ZeRTzhtg9gbhTqqxVvBRsMw
 +lKM44q1ZbiddXxs5UVdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nFLO7EyxzzE=:TD0xFClkjjGwZ7B0C58zOu
 nFLDh0ylbnwMXpvkrrf79V/Mld6TrPvM6yCnj9SU/JFPqBLz8qxnfooJHpDsxaLrN+1aXsEgB
 s9D+JtYiNvNTRNAYeVHTSt9sAMQ1i50LBh9dkomlP+R/OKwuUl+pTNWCt2nusqGO0hEM7noi7
 4DGE9BF4Kreu3UMqSVha3d9klUl22Uk76Fj544XqimuFEcenDypwbET7XyqzMRyei1TmjYm0W
 6wYFVq/hfDTU97B7rGjTgU62RlyqDyUXVsH2Y/2b8dBvDi+w0VN6HJs92XsDqz3RnCg4t92tk
 /gAVa96/shiNagB0ZCAm4ozdt05PmzJArDOftBXUp5/QLvSYcfKQHCubBO9oaLl5uCB35UqpS
 TuYb/iebGjZ4omYr5TdxZ6zNXvTL5//2kjikxYch3Cx9rNpnO+THA/zqd+tuj1JCTyzv8xlEE
 CK8u2Rsy3WAtT5p/oC2GZ380X/GG+GF0goASoc91WeQX75mAV6c4m2+jbht7Cl9R0/NCrdw7g
 tbAmVBcWINlNjOPIWbQO1WkD4w1qnE5HTlbtznvOr4LkRQIGZI7f2yzzVwNq5gHyM9N3kG38o
 xyJAZMLy6u2c50sC284n00AHcFcgcynDYdUrrm53PROC/E3yDSJNRbs5q56ESTjtr1qDj7JkJ
 N3NH+zKJ03ip2TuNKKJSgSRJGgjO+EFKyxoLfYGyQS4raDNzlmCyPyK+ita+CR6DAY7Em/KDI
 ar1BSInVCafyMOn/ENAGHFX9j6fbli4q7c5nhjDSo8uu0SP1X0XwY35N3vi8P2JRwIUDxjsyw
 +JKDWg+KtW2PwxtlietIHtNzShyvBdTU7R70EsIbuRg1lKrIDvlclh5XnfOBkqAutQW4ZnljT
 /FmgHXSYlgn7qCbI3v384YiUnjbHsO8L29bVEt1OEUzpgRy7f5E13ashnsAFpkYjIHS0zdDap
 Jplf9ZhCbHf/KBrP8tozV+m1849gun+HQ1SC9NHc6ji1+VDxHHZvG33Eay0sAz+DJubmPFuhP
 g63ECx9Xl3C++pvcuae6H2a1QZcL6rMifla8mg/CcntxR0306pbI4TlxyqzvEOJ0MnLPZnCgb
 eN/teReiB+1DTABzwVbNM/wWYufgHkPgEW4RNYDp1jprrtNu4XB0kexwynoVctvrBloky0nKe
 Jo3bvPO/k5xk/38EZf39tCg4Vw
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Tue, 30 Aug 2022, Phillip Wood wrote:

> On 29/08/2022 16:11, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Thanks to alwyas running `diff-index` and `diff-files` with the
> > `--numstat` option (the latter with `--ignore-submodules=3Ddirty`) bef=
ore
> > even generating any real diff to parse, the Perl version of `git add -=
p`
> > simply ignored dirty submodules and does not even offer them up for
> > staging.
>
> I had a bit of a hard time understanding this paragraph. To me the fact =
that
> the perl version is using --numstat is not that important here, what is
> important is that it is using --ignore-submodules=3Ddirty when it genera=
tes its
> list of files to show and that information is consigned to a parenthesiz=
ed
> aside.

Yes, the `--ignore-submodules=3Ddirty` part is important, but so is the
`--numstat` part.

It is important because the Perl script would parse that numstat part and
only offer files up for further processing for which it saw those numbers.
Then it would go ahead and run a full diff on those files, which basically
doubled the work.

And it is that doubling of work that I tried to avoid when implementing
the built-in version. The bug came about because the full diff call wasn't
using the `--ignore-submodules=3Ddirty` option, and that's what I missed.

This is maybe more interesting a story for the cover letter, to be able to
understand how this bug was introduced, and maybe to offer an opportunity
for others (in addition to myself) to learn from my mistake.

> The fix itself looks good.

Thanks!
Dscho
