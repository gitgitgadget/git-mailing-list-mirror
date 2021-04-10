Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B16C433B4
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 11:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29EF7610F9
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 11:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbhDJLxl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 07:53:41 -0400
Received: from mout.web.de ([212.227.17.11]:56427 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234431AbhDJLxl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Apr 2021 07:53:41 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Apr 2021 07:53:40 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1618055605;
        bh=Q2N5zd4yRn5eyKTKYgxARJ2ywGU/mJwU7rDlgMmfORE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=NaZVo+v53VNeKlSeB6UyiYHngoV9l89Zyf+o7F4AXoNsQqGXVAFxU47Hvv6/js5IH
         LNS+uOofE4aMYieNHwJ7rDgg60QozCkMjAwcJsxp2D0FqtA/jJL0VEHVko8oRFYr5c
         v2fGCFC4JODk/bsbRlns+3eMN+jo0u67vlqaittw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.31.60]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MNfY9-1lBjZp48QF-00Ow4N; Sat, 10 Apr 2021 13:48:19 +0200
Subject: Re: [PATCH] merge-ort: only do pointer arithmetic for non-empty lists
To:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
References: <pull.930.git.1618043449249.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <1866b90b-fe07-18df-0d60-e2350d935375@web.de>
Date:   Sat, 10 Apr 2021 13:48:18 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <pull.930.git.1618043449249.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dc+J+TLGt/XcJyorSMWeUop8O3xNbnHhisYryXVt2lB/eMJzapg
 ccrbglPkmBSm1H+2OMIQP0RhqPxtDghNdE9dZADJ01Ihzx66122OnSYuU0zV986lISLypNs
 kORlSgoROjMIlOonZfX/VCnnkgWeLIQSeuX4do4cQjf0wMkb7aLxUdsdbcrB8LN1CRV2PRP
 sMAfhSPaGfSq7NzOdjEtQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VPmHK6JBU50=:FDVfun8LSvbxa++n5aiOG4
 IcagSd4+DlNmmyYjyCySG4TCRHIHNx5UcShyaFuIoG+WlbGhL/upFcZyNEKUudE5/kFLIS8iJ
 R/uF25IYN6gzv5wckNa0pZmsN2vpRPg8l2GeHdc7pciLsNdcKz0054e4RSCEakMcwv7iUD5mK
 n8M3mLMEO5svUhx9q8j+pcq+YrgFv3uwEEvRnACr2tW7AJrwy/PZREs4z1xynQzuB7wdCHgIX
 BxOGN8QpP0J7mVRsIj3qmBBfZ6tyEC//1mFU5qac3iAIBwJGDYXaU9gw7WbKhQk3TeDXEYvhh
 +pUnWJq8QvbNk15p/G6eBUegJD0HvbdkCxwNcJksCi/FFLiaBv76DOjHq8QS2hz2+u2bDrLg1
 CQuluqXmBIIW6eGXC1//SJC4YUyP3Rux6JnvdfR7XXd2JIjG6ArP9Cuhzm0IK4ud1bxk4Vkzd
 GCQ6zwCZbfN88V/Kp0dJnd99IZUzE0fd6p5qRHv3PwmdANXZZQb894bcf1xF3eqbHXepBH6bZ
 KOfK0PpnA+WDkHMKhvmkk1GbuFwNVEYvy6L0N66lDWkh08fcDCBjt4u0EW1fIVvDSAYyywJ7t
 wMdz/t1YOzl4KH/QsXAW+9zqqRouFT7aaIj4O5P7TWJvJzaaV1Ew9CIPH601cCTuBxZ4O5wr6
 Y5txuOIHOO6SfoPhxhA54ayGw2+2f85AcZk86Ft5S0h1gIeB8bdS76fTSa5Xyad1tFEaTB+cQ
 k7iZ/ZYCezdn3Kx5exKh2CahtGST421ayMbR7glrq2FeRWiqn0V4sh5zjKZ9bc89qjYTF5G40
 1TZnODPpQWmD8j1Z6pvyFycvYXLEuF4wtUCSa+O66UtSD5bPsKkD/UWPeVowGDQIkO4CE5Vxb
 EkB1odsvAj+/ToHke0e7ofSyQpa2s4dcdXVLR/4uIGXpuiVIAqjT59BJti1YJXYU4l6wTwRml
 QAvFJJ16cWo5RuYCE2fe+fRqShFj3+KKkwo+VwNeVIPCly6DEE7QFvTZolInresxNYW4Ylz4S
 fRE1IZ4VSs5Yy3mrlO2yvPGCpP8LQBrMBDM9eFQGfq7PXkzY3H8Ft1a1HFdvGEy4CjTkh2QJk
 CzuQTfHLhbMnh0c26/Bzs3t8s1TEsFWuExc3/gQepldKdK8kJsdFBEKt+hP9lVSe2icdrljEI
 0Kw7o6td/G6k5G9XOs0TFCfMJEvEKl2/if4AaSZ2l1b1IpD5/545oaijsnTN9KCzo8SrQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.04.21 um 10:30 schrieb Andrzej Hunt via GitGitGadget:
> From: Andrzej Hunt <ajrhunt@google.com>
>
> versions could be an empty string_list. In that case, versions->items is
> NULL, and we shouldn't be trying to perform pointer arithmetic with it (=
as
> that results in undefined behaviour).
>
> This issue has probably existed since:
>   ee4012dcf9 (merge-ort: step 2 of tree writing -- function to create tr=
ee object, 2020-12-13)
> But it only started occurring during tests since tests started using
> merge-ort:
>   f3b964a07e (Add testing with merge-ort merge strategy, 2021-03-20)
>
> For reference - here's the original UBSAN commit that implemented this
> check, it sounds like this behaviour isn't actually likely to cause any
> issues (but we might as well fix it regardless):
> https://reviews.llvm.org/D67122
>
> UBSAN output from t3404 or t5601:
>
> merge-ort.c:2669:43: runtime error: applying zero offset to null pointer
>     #0 0x78bb53 in write_tree merge-ort.c:2669:43
>     #1 0x7856c9 in process_entries merge-ort.c:3303:2
>     #2 0x782317 in merge_ort_nonrecursive_internal merge-ort.c:3744:2
>     #3 0x77feef in merge_incore_nonrecursive merge-ort.c:3853:2
>     #4 0x6f6a5c in do_recursive_merge sequencer.c:640:3
>     #5 0x6f6a5c in do_pick_commit sequencer.c:2221:9
>     #6 0x6ef055 in single_pick sequencer.c:4814:9
>     #7 0x6ef055 in sequencer_pick_revisions sequencer.c:4867:10
>     #8 0x4fb392 in run_sequencer revert.c:225:9
>     #9 0x4fa5b0 in cmd_revert revert.c:235:8
>     #10 0x42abd7 in run_builtin git.c:453:11
>     #11 0x429531 in handle_builtin git.c:704:3
>     #12 0x4282fb in run_argv git.c:771:4
>     #13 0x4282fb in cmd_main git.c:902:19
>     #14 0x524b63 in main common-main.c:52:11
>     #15 0x7fc2ca340349 in __libc_start_main (/lib64/libc.so.6+0x24349)
>     #16 0x4072b9 in _start start.S:120
>
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior merge-ort.c:2669=
:43 in
>
> Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
> ---
>     merge-ort: only do pointer arithmetic for non-empty lists
>
>     Here's a small and inconsequential UBSAN issue that started happenin=
g
>     when running tests on next since yesterday (since the merge of
>     en/ort-readiness).
>
>     It can be reproduced with something like this (t3404 also triggers t=
he
>     same issue):
>
>     make SANITIZE=3Dundefined COPTS=3D"-Og -g" T=3D"$(wildcard t5601-*.s=
h)"
>     GIT_TEST_OPTS=3D"-v" UBSAN_OPTIONS=3Dprint_stacktrace=3D1 test
>
>     ATB, Andrzej
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-930%2F=
ahunt%2Fmerge-ort-ubsan-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-930/ahunt=
/merge-ort-ubsan-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/930
>
>  merge-ort.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 5e118a85ee04..4da4b4688336 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -2504,8 +2504,10 @@ static void write_tree(struct object_id *result_o=
id,
>  	 * We won't use relevant_entries again and will let it just pop off th=
e
>  	 * stack, so there won't be allocation worries or anything.
>  	 */
> -	relevant_entries.items =3D versions->items + offset;
> -	relevant_entries.nr =3D versions->nr - offset;
> +	if (versions->nr) {
> +		relevant_entries.items =3D versions->items + offset;
> +		relevant_entries.nr =3D versions->nr - offset;
> +	}
>  	QSORT(relevant_entries.items, relevant_entries.nr, tree_entry_order);

Reading the diff I was wondering if QSORT now gets handed uninitialized
values if version-nr is 0.  The answer is no -- relevant_entries is
initialized at declaration.  Otherwise the compiler would have probably
warned, but sometimes it gets confused.

I wonder why relevant_entries is introduced at all, though.  It's not
referenced later.  So how about this instead?

	if (versions->nr)
		QSORT(versions->items + offset, nr, tree_entry_order);

The intent to sort the last versions->nr-offset entries of versions,
but only if it's not empty, is easier to see like this, I think.

>
>  	/* Pre-allocate some space in buf */
>
> base-commit: 89b43f80a514aee58b662ad606e6352e03eaeee4
>

