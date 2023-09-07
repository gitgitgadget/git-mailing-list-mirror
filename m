Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1CDEC873E
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 15:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbjIGPYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 11:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238959AbjIGPYA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 11:24:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265C8135
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 08:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694100234; x=1694705034; i=johannes.schindelin@gmx.de;
 bh=M14AJKlWsf6ZhTo1FQixrBYJergezLRd4E9GPD9Pcq0=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=ZuenzDypCtiMjtc3kGetajztK3VsNa+ZxwX4E2uoG8j802jK2jsWZAv3sw38L7+ehGkd7RD
 66qCexbhIyyzsc1Uoi8adnliS3iPmwsEnS+TvPgemDAPcb4MsrD6b+k1VtVTpy/Py3yDG7j0i
 isNk42VJymXYueemv/FZDrZN2wGxKJIUvSLQzIzt6hhnLfL2OOAZ/m/bWY7ePMS25jJHDpWWo
 aX3aolghgbHLBnDXTB95/n95A/xWtzAO5GnTyt2OM6aksoanzM6+0fmynY3pnBtIhBkz7gv89
 mP6EPa5IElOJVAhyBjtv1IQ7iSYnfwy2mfWYM6oedhMpzX7SRSWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([80.151.253.86]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbRk3-1q2Nv427hJ-00bv6M; Thu, 07
 Sep 2023 13:02:15 +0200
Date:   Thu, 7 Sep 2023 12:23:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Christian Couder <christian.couder@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 06/15] replay: don't simplify history
In-Reply-To: <20230907092521.733746-7-christian.couder@gmail.com>
Message-ID: <58daa706-7efb-51dd-9061-202ef650b96a@gmx.de>
References: <20230602102533.876905-1-christian.couder@gmail.com> <20230907092521.733746-1-christian.couder@gmail.com> <20230907092521.733746-7-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZXB1E5VA2HyC8u0CfNF4fPMdF6JGQdX/kRm8chdy9FlXAyXSri7
 r0ujcHYnpJuwa6hLDfxUY+2JDGqIoy2PN2/moNMVOGodOXMliY3YLufzL7C9fjitABueI0P
 4OeoRAgf3sMczCC3pFQV88f2YUlHkN+uafEslzGFZq4RodttW2bzDeRvDV5DdU0xwmgS651
 bjRNnKi2GKYybiTdTT/lg==
UI-OutboundReport: notjunk:1;M01:P0:BXt5Pu3Mksc=;tc7Lvr3+EZaJNps6bdPXX7o3J8s
 gdZub9D9GiJAxKfBFB0Lep9Gf1s7Tteb0y2EppAYQFrHFLlQMew3FGVjw95xdpPeG5TBowWPz
 IDNf8Gn3ejevW/dv1YHIoTdQX3GaBwh09KUpFJCo+mOyraTc/ZZBXdDCIjfb5Dle28z0XkxtU
 MSuq2DVgxpqOAZhywrLTBYzPD5Zx9tUjX4XmLYwepcfG1/NdtSH7OUla8R7U0IbIEN9FX/zyo
 24q+XJZhaLFzSwQlLW58BeuzWktZ4lq3rCrKbhdH/tDPzdAcekES041znn5iFSHcBbefajMs0
 bl6PIm6iU3Ig+Ru72k7VR7axGIuBh/M1u5RbJyg1hsLiFoWXv14YGydYhYKYEJDzi7ctcKxQt
 wCohQXIxY+DDbb8L8sCwVsUs+g4occe5lnFDxHeXxwKSXkRSaJALabY4IOPp/ogN2xYgGI07Z
 LTrfz28IuAV+flEmNQPYPZgTJem7MceTKkc1IdOkzr4eXzW5IVjiHCxPGPHWXBh0FGhtXESWG
 D9aLPoAd56NMAjo96byVVxSTPcLHr4y9G7+Spk55fJaDd56BCMJpTewQT3AMwBsu/iQQfNerS
 cml3d+7P3dI0TOYi7QSVCNjEHVsK4PNQ1eTjUuU3KWB6rVD8uXAbC5x994dDa0E2FbXnkZsge
 M1bg9tPc7TtR18SdlSdZGWDWRlQXmYdLBG2hfXdAnDAJ6A1SGO2oA6DdgYfqyYEMHuDAOHWWE
 6IKd8zwZs/xK/7FUk2f2S5vC3zA5tFG8GD4DvaPn69xXCt8z0QpTvCSFFPWNW0wBzSKlTu5x5
 58EklC4hQS4z3MGDqi6IVEhJOavw6dJ7KNNthkA7PVTiyQDm+Y8kLc6r3dWCNnGCnNyfKitUv
 1jSNT2XXKALuelrZmX8sNthZWvHSrEHjAfBa9R7uDtU2FG6wCRgfKZdqDcOWnMiaJLIViWx79
 zE2UrPd8ZK1IE6+4X/3zhVu2+eo=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian & Elijah,

On Thu, 7 Sep 2023, Christian Couder wrote:

> From: Elijah Newren <newren@gmail.com>
>
> Let's set the rev walking options we need after calling
> setup_revisions() instead of before. This makes it clearer which options
> we need.

In light of the currently open issue about command-line validation, this
change does more than this paragraph lets on: It hardcodes certain
settings, overriding (silently) any rev-list options the user might have
passed.

Is there any chance that we can avoid this change?

> Also we don't want history simplification, as we want to deal with all
> the commits in the affected range.

This, however, is a good change. It deserves to live in its own commit,
with its own commit message, in particular because it is not obvious from
the attribute names which ones we're talking about (I guess it's `limited`
and `simplify_history`, not just the latter.

Ciao,
Johannes
