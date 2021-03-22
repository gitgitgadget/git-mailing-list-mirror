Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F2DC433DB
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 18:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E61D61874
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 18:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhCVSFp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 14:05:45 -0400
Received: from mout.web.de ([217.72.192.78]:34417 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230053AbhCVSFS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 14:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1616436307;
        bh=yM6RARA0oLmvtpHH/tvJjINxLm6KISRZTQme6057AWA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=YpndKYpwSdhs2D5lvppyiTA3jd8HSg5jX4nXgdfCn8ysgrCiM9I/W9mCDwxVJxWqb
         yOKYUR+Jte0+olVs/0WSAaAiiOd69IstUbx5auQ7Ju20IshEaXkdiUx+uDaIBgTSFy
         qvHbWSVRzQmWRw3hzCmQ3u6tKFhhXRZ2rdkANDwU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.22.17]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MxpiO-1laofd0Vgs-00zYP7; Mon, 22 Mar 2021 19:05:07 +0100
Subject: Re: [PATCH v4 2/4] Makefile/coccicheck: speed up and fix bug with
 duplicate hunks
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>
References: <20210306192525.15197-1-avarab@gmail.com>
 <cover.1616414951.git.avarab@gmail.com>
 <3bca3239cb84488a1638f2bb269392f47f78c6da.1616414951.git.avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe=2e?= <l.s.r@web.de>
Message-ID: <365dd12a-b96e-8daf-ba34-bc7d40f39634@web.de>
Date:   Mon, 22 Mar 2021 19:05:06 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <3bca3239cb84488a1638f2bb269392f47f78c6da.1616414951.git.avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q+JRYSe5NFn9xUY3llaSzCU2LALcGDTyhCw7NKnWkaGCw2TVR54
 3w80hXU2ElnKOUgIjp1Ysb/qxsCLD/5M2zZP5pB1P3CSz7Bp+coHCl2j2V73Ha1/42UWztf
 SLd9nFGqMUmgz6YsTLS4MsaPgt2EXc9DGlgJiHzzrurPS+Dtng5XFFAAWv0jkQkJ5wwKnsQ
 L2XkwmdNjLnOpztxoOmjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eN5515EQCG0=:CI/P5MbvYoYqlY1NHOEtFc
 Nns7SpAEGmpOxp3EFA8kltqFQO5H7TkjcWYwl4eEyKoaj/r6gPP8ag42KAVn+aRTDIUpGbw+U
 /uEfOZK0aA+6y2wFLaNSWHjWEFJLNWExN7cFSTlepbAMLZU9FpK/bVKAI04VvpwCvOhFbOJaE
 3YeEUMPxA++rrhzPavWbRqcvyp/FyWIC+/gsfjreI0GYG/g6SGOlTKlCjpZjPYFZxI7vVFSoe
 6y8g1AWgySjVpYJRbzVHAPJ1/HviB+P1qkSzczrKuVVPdhfzYwhkBwzpof6maNWAf5my0SgzO
 dvMD0f6GuBXhqcqM13V4SwEFqU4tdFjeLCCIL0hAFvRb4k6dIvAAlxYjdNxZgZQxOC8xrLPBM
 Aw8+C1gPeja79PImczFANow64WLzO2oH3wtUAfx8Iav/GBvhekd2X0+XmaZr/M1JvshCkXFV8
 DxyIuWS3r3QUkHeXupeF9+TH6urZsPeRAfBTuYVQvCZf1UBQDsCNbFlcmnJ71xNS+s9mymkrY
 auNhUQfoXwXygwb/yBac1j6floL93AEzR6iNjZ5CpRK5tg5ecZKrrOT/ozBmPopOJBoAQSKxX
 FcXEIRIj2rs9R1Of11VxrT8ydbwklnb3WmbJluaFGj4p76Q2TQIEZ8J90m/1kkDBN3LCjDtkZ
 KRbB68L1Iivj4g7qOGfHlvE/y2/+qeayNnDAQ9tM2sucL8sr5P1ysRZtmt1GyrzghbymcrAyV
 6oyTG7Apy57+4TrEVXkbtoZ5cFpYb3zU4NkghuYD/dXhTiDQjESfSZsGQyC34oeXfZLtEHRFH
 YZtsV1zZaf4BwhQ7/4UNsNPlb0q8UgtlJxitP4hkm1kY8hAaknA9Tvwkaibc8eaPogmwE4eaH
 A30P36XhYU2w7+x11CXg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.03.21 um 13:11 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Change the coccicheck target to run on all of our *.c and *.h files
> with --include-headers-for-types, instead of trusting it to find *.h
> files and other includes to modify from its recursive walking of
> includes as it has been doing with only --all-includes.
>
> The --all-includes option introduced in a9a884aea57 (coccicheck: use
> --all-includes by default, 2016-09-30) is needed because we have rules
> that e.g. use the "type T" construct that wouldn't match unless we
> scoured our headers for the definition of the relevant type.
>
> But combining --all-includes it with processing N files at a time with
> xargs as we've done since 960154b9c17 (coccicheck: optionally batch
> spatch invocations, 2019-05-06) introduced a subtle bug with duplicate
> hunks being written to the generated *.patch files. I did not dig down
> to the root cause of that, but I think it's due to spatch doing (and
> failing to do) some magical locking/racy mtime checking to decide if
> it emits a hunk. See [1] for a way to reproduce the issue, and a
> discussion of it.
>
> This change speeds up the runtime of "make -j8 coccicheck" from ~1m50s
> to ~1m20s for me. See [2] for more timings.

Without this patch, /usr/bin/time -l reports:

       95.08 real       598.29 user        32.62 sys
           103727104  maximum resident set size

With --include-headers-for-types, I get this:

       76.37 real       483.83 user        26.77 sys
            97107968  maximum resident set size

This is similar to your numbers.  And adding that option to the demo
script in your [1] gives consistent results for all xargs -n values,
so that option alone fixes the subtle bug you refer to above, right?

However, with the second part of this patch also applied (adding %.h
to FOUND_C_SOURCES), I get this:

       90.38 real       558.38 user        38.32 sys
           100073472  maximum resident set size

Is this still necessary?

>
> We could also use --no-includes for a runtime of ~55s, but that would
> produce broken patches (we miss some hunks) in cases where we need the
> type or other definitions from included files.
>
> If anyone cares there's probably an optimization opportunity here to
> e.g. detect that the whole file doesn't need to consider includes,
> since the rules would be unambiguous without considering them.
>
> Note on portability: The --include-headers-for-types option is not in
> my "man spatch", but it's been part of spatch since 2014. See its
> fe3a327a (include headers for types option, 2014-07-27), it was first
> released with version 1.0.0 of spatch, released in April 2015. The
> spatch developers are just inconsistent about updating their TeX docs
> and manpages at the same time.
>
> 1. https://lore.kernel.org/git/20210305170724.23859-3-avarab@gmail.com/
> 2. https://lore.kernel.org/git/20210306192525.15197-1-avarab@gmail.com/
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  Makefile | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index eef99b4705d..e43a9618df5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1199,7 +1199,8 @@ SPARSE_FLAGS ?=3D
>  SP_EXTRA_FLAGS =3D -Wno-universal-initializer
>
>  # For the 'coccicheck' target
> -SPATCH_FLAGS =3D --all-includes --patch .
> +SPATCH_FLAGS =3D --all-includes --include-headers-for-types --patch .
> +
>  # For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
>  # usually result in less CPU usage at the cost of higher peak memory.
>  # Setting it to 0 will feed all files in a single spatch invocation.
> @@ -2860,7 +2861,7 @@ check: config-list.h command-list.h
>  		exit 1; \
>  	fi
>
> -FOUND_C_SOURCES =3D $(filter %.c,$(shell $(FIND_SOURCE_FILES)))
> +FOUND_C_SOURCES =3D $(filter %.c %.h,$(shell $(FIND_SOURCE_FILES)))
>  COCCI_SOURCES =3D $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES=
))
>
>  %.cocci.patch: %.cocci $(COCCI_SOURCES)
>
