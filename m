Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5F7C47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 21:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0970E61057
	for <git@archiver.kernel.org>; Thu, 27 May 2021 21:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbhE0VCM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 17:02:12 -0400
Received: from mout.web.de ([212.227.17.12]:50491 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234131AbhE0VCK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 17:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1622149227;
        bh=ORHzvI8iJ3r4hFBZFBA0lXTaR+L7qhXi17v7nY+8d98=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KVBMFiQuEajfK3rIXtfXMVHYGNpcDQ/jhjwRVpKYjuxnFdFBxyXb5PewctFgBaibb
         bf1/urWgscT0P9dFGBzHiRkV138FlZivbcDKWXMAXFSnlVaPu7Ngk5F2PqdjLP5H39
         UIOO8GLNGjAHW0N4fkZ2UxMSQEPJ64kXSe/6z6Zc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.31.60]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MbyIM-1m5hBV0LKQ-00JLjE; Thu, 27 May 2021 23:00:27 +0200
Subject: Re: [PATCH 1/5] merge-ort: replace string_list_df_name_compare with
 faster alternative
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
References: <pull.962.git.1622104642.gitgitgadget@gmail.com>
 <5055dfce32815c8c8ec250457df389d4cd02ee12.1622104642.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <e0842d32-a11c-91d8-3660-cffdb5639193@web.de>
Date:   Thu, 27 May 2021 23:00:26 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <5055dfce32815c8c8ec250457df389d4cd02ee12.1622104642.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5NV4W39VZJaMQo1ttbJmcs8MJ2YHx/PZ3VNdvYznpbr/2gU4beX
 1w9/RdNyzwgqk+JzYbB9TI0DPmakVWHkI0eAWdwjuAtdM4ZvRiQTfmJy4SJxBKUrr0Z1T49
 n/DuAt9owPu9mv7tZx08POgKs3px7x7o43TVqYIbeQGVcympRN4kcZfT6rMRXGgBsYOQo1i
 WJqDBkDYZUyel99E5QWaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:utZdO8ojg9o=:J6VVPUMuNNUcbdYJkp/nop
 R2l+XHV4uVt1Xoiwi/Ttb3WWmeOwLXY2iGKD3taSxRLLe7zdFFNJ0G8PX/jGuw5JJfzRUuraE
 X/1VZJlk7rAFvFeXQot2peoFV8gV+kkgHyCypOY/Gg9NAdSGPjFRFAJ7QiPU5DVrkt5v67dPe
 I+wzvo8Od8pEwUYxdFu09QmiI8+a3e/8NJBjjQdzAcCAX4S10KnLLsB/7tcwMV1GVwBW+J05d
 IP7+wjopapranGTWY9lRRL6/qoTmHedtRdLzIKySg2zxsi4cgXFbAxUq6Q/uGTsuWCmco0ad+
 RC1kDNvYVcw82e7ebKa7A9prDqvJLzbLP+ptM+QGGO14lUkyU1KTofT5lGvLayQzvEyqOM7iw
 EbxgshnfMJYl0DgM/usX2mofh8CXGsocYuNvO+mhJ9Yb+Fi8Zyf3zvWAmBejdLqah5+sIAL6M
 wF2QQPv44/xfmT9bnCX5ZESXkfaQueva76CBg9JrPIHYKPptuMFhIojXO6e4mSCLGUR65n/Yc
 hcw9+exkjEKpZ8O0SUZfSW9vv59vFQoSUy5fEkLtIK+se9ZsP0kKdDVgD1EwpvIhYfhnsJAhC
 NBaTS7ogZNRwe7nv6h7c2c1Ztx2D3Lo772zjNeYdUFPuQd1nIpomXWB553WIix32Xp/pszNkT
 kOFPWJa8kooWQbbR8xfY8p+h5PzrLA3owC7yqUs5mzG6LxACJFjTNIdMGFwtGe4hTh/oxd49s
 Hh9oHeLHLFoMqAKzkY24WUV5+LQkNCgTMm5e8KG1xWcrwnNw+T1ZKgBj602ndHqwEhPS9Qpw3
 Tlc+aey/rRz68Jr3bwumXAc+CRjZVBHyB6/++da4UtUMJ0mQkec4yFFTue/hB1iRgpu2oDQ/W
 3AzF3L2mIxsDLIfFd0bT9e4WpCSszfrqGS+hOqjTkbnMabiqxNhSf0fMf0AegisSo+6DjBHVB
 122E3ecSKntRG/sVWQ/tIqmudxy92muNNqwX0XtWclJ4lJqodjDwfdYK0V6vhwHEvYJfiE9Ty
 LWwiUW9yDj5+4m3ev2bZy/UIcYP0O5n4p1IUh5thD0LEoTWwl7xPh/QolpXqJ+LL7zFHT48tA
 ZjwCEaK851Voe8RuzPt9zTEo8p+hDp+37RhxS0bqYOjgah752EyJ9u94X78gCJCTmwozA14I0
 qvCqDNm2/OuYpvcGqsfBxReoVsaeg9xTYY2ccvNxxi0m/TcwuQtb/mPeLEZBHCH+e7Wlk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.05.21 um 10:37 schrieb Elijah Newren via GitGitGadget:
> From: Elijah Newren <newren@gmail.com>
>
> Gathering accumulated times from trace2 output on the mega-renames
> testcase, I saw the following timings (where I'm only showing a few
> lines to highlight the portions of interest):
>
>     10.120 : label:incore_nonrecursive
>         4.462 : ..label:process_entries
>            3.143 : ....label:process_entries setup
>               2.988 : ......label:plist special sort
>            1.305 : ....label:processing
>         2.604 : ..label:collect_merge_info
>         2.018 : ..label:merge_start
>         1.018 : ..label:renames
>
> In the above output, note that the 4.462 seconds for process_entries was
> split as 3.143 seconds for "process_entries setup" and 1.305 seconds for
> "processing" (and a little time for other stuff removed from the
> highlight).  Most of the "process_entries setup" time was spent on
> "plist special sort" which corresponds to the following code:
>
>     trace2_region_enter("merge", "plist special sort", opt->repo);
>     plist.cmp =3D string_list_df_name_compare;
>     string_list_sort(&plist);
>     trace2_region_leave("merge", "plist special sort", opt->repo);
>
> In other words, in a merge strategy that would be invoked by passing
> "-sort" to either rebase or merge, sorting an array takes more time than
> anything else.  Serves me right for naming my merge strategy this way.
>
> Rewrite the comparison function and remove as many levels of indirection
> as possible (e.g. the old code had
>     cmp_items() ->
>       string_list_df_name_compare() ->
>         df_name_compare()
> now we just have sort_dirs_next_to_their_children()), and tweak it to be
> as optimized as possible for our specific case.  These changes reduced
> the time spent in "plist special sort" by ~25% in the mega-renames case.
>
> For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
> performance work; instrument with trace2_region_* calls", 2020-10-28),
> this change improves the performance as follows:
>
>                             Before                  After
>     no-renames:        5.622 s =C2=B1  0.059 s     5.235 s =C2=B1  0.042=
 s
>     mega-renames:     10.127 s =C2=B1  0.073 s     9.419 s =C2=B1  0.107=
 s
>     just-one-mega:   500.3  ms =C2=B1  3.8  ms   480.1  ms =C2=B1  3.9  =
ms

Interesting.

>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c | 64 ++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 41 insertions(+), 23 deletions(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 142d44d74d63..367aec4b7def 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -2746,31 +2746,50 @@ static int detect_and_process_renames(struct mer=
ge_options *opt,
>
>  /*** Function Grouping: functions related to process_entries() ***/
>
> -static int string_list_df_name_compare(const char *one, const char *two=
)
> +static int sort_dirs_next_to_their_children(const void *a, const void *=
b)
>  {
> -	int onelen =3D strlen(one);
> -	int twolen =3D strlen(two);

The old code scans both strings fully, while the new one stops when it
reaches a difference and doesn't look at any further characters.  How
much does that contribute to the speedup?  (I suspect a lot.)

>  	/*
> -	 * Here we only care that entries for D/F conflicts are
> -	 * adjacent, in particular with the file of the D/F conflict
> -	 * appearing before files below the corresponding directory.
> -	 * The order of the rest of the list is irrelevant for us.
> +	 * Here we only care that entries for directories appear adjacent
> +	 * to and before files underneath the directory.  In other words,
> +	 * we do not want the natural sorting of
> +	 *     foo
> +	 *     foo.txt
> +	 *     foo/bar
> +	 * Instead, we want "foo" to sort as though it were "foo/", so that
> +	 * we instead get
> +	 *     foo.txt
> +	 *     foo
> +	 *     foo/bar
> +	 * To achieve this, we basically implement our own strcmp, except that
> +	 * if we get to the end of either string instead of comparing NUL to
> +	 * another character, we compare '/' to it.
>  	 *
> -	 * To achieve this, we sort with df_name_compare and provide
> -	 * the mode S_IFDIR so that D/F conflicts will sort correctly.
> -	 * We use the mode S_IFDIR for everything else for simplicity,
> -	 * since in other cases any changes in their order due to
> -	 * sorting cause no problems for us.
> +	 * The reason to not use df_name_compare directly was that it was
> +	 * just too expensive, so I had to reimplement it.
>  	 */
> -	int cmp =3D df_name_compare(one, onelen, S_IFDIR,
> -				  two, twolen, S_IFDIR);
> -	/*
> -	 * Now that 'foo' and 'foo/bar' compare equal, we have to make sure
> -	 * that 'foo' comes before 'foo/bar'.
> -	 */
> -	if (cmp)
> -		return cmp;
> -	return onelen - twolen;
> +	const char *one =3D ((struct string_list_item *)a)->string;
> +	const char *two =3D ((struct string_list_item *)b)->string;

Casting away const, hmm. :-/  Harmless because no actual write is
attempted, but still looks needlessly scary to me.

> +	unsigned char c1, c2;
> +
> +	while (*one && (*one =3D=3D *two)) {
> +		one++;
> +		two++;
> +	}
> +
> +	c1 =3D *one;
> +	if (!c1)
> +		c1 =3D '/';
> +
> +	c2 =3D *two;
> +	if (!c2)
> +		c2 =3D '/';
> +
> +	if (c1 =3D=3D c2) {
> +		/* Getting here means one is a leading directory of the other */
> +		return (*one) ? 1 : -1;
> +	}
> +	else
> +		return c1-c2;
>  }
>
>  static int read_oid_strbuf(struct merge_options *opt,
> @@ -3481,8 +3500,7 @@ static void process_entries(struct merge_options *=
opt,
>  	trace2_region_leave("merge", "plist copy", opt->repo);
>
>  	trace2_region_enter("merge", "plist special sort", opt->repo);
> -	plist.cmp =3D string_list_df_name_compare;
> -	string_list_sort(&plist);
> +	QSORT(plist.items, plist.nr, sort_dirs_next_to_their_children);

How much does the direct use of QSORT instead of string_list_sort()
contribute to the speedup?  (I suspect only a bit.)

>  	trace2_region_leave("merge", "plist special sort", opt->repo);
>
>  	trace2_region_leave("merge", "process_entries setup", opt->repo);
>

