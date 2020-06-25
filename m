Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC7AC433E2
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 07:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B477D206C3
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 07:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="XPGLHxd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390210AbgFYHZY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 03:25:24 -0400
Received: from mout.web.de ([212.227.17.12]:35167 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390110AbgFYHZX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 03:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593069918;
        bh=DWkj0Evl8LgUtrq+U/f9GDvUb5cQPSg6NoESbBfj5D4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XPGLHxd+itFHzZw+H/sWbFD8yWo4m5rfxU5AoqdqLtA3C1cEcvyatEoluWMB9gqCC
         3v+OX8ZXCD8fY3AyRE1P7qe2LOn3Ki+Jk3Tw7dczYnFX1CD5jRCD3nUkLFwA6k5avB
         WbiQ/Y1mIkqYFHa3XttCoqjEP7vBcTCIAb7VNPK8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M9ons-1jhnks1Z2e-00B0gn; Thu, 25
 Jun 2020 09:25:18 +0200
Subject: Re: [PATCH v2 10/11] commit-graph: check all leading directories in
 changed path Bloom filters
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
 <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
 <9c2076b4ce46918fce8f05e609b057611ec56e13.1592934430.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <8d8b1763-bbf3-682e-0649-f5a0885399e6@web.de>
Date:   Thu, 25 Jun 2020 09:25:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <9c2076b4ce46918fce8f05e609b057611ec56e13.1592934430.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uK4VuIeasKo8Da5gOyqr0IieKcWbV24nZREOPAwxiphF1sB765i
 1/TkWhMZrWpBc2o8WYKYWc923NObzfhJ9Do1lwDrkSKREq2BJFXga2vqpp5q+Si0r8FkEBg
 fb8Jk1GSEpaY3ZhjKInmFe1oHSKe5boEWSnYjFoLaKTabg8Qqg1EfDRlp17j/sao8W2L+d+
 6LqHyoB/HmzgsutWhMWmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:orJLD8DL6e8=:hGcxpswnRWpn7o3Gn0Wyjk
 i2oXCeREU3vEIPK2T8Ngc5tmfAHOjnRvekewXD2y0vIW0LJZEmyCAehqgFI/ma2eCiuo7LDZY
 kCA0kEpUcnOkkvyQtM23XOAOvdO+lCyP03CTbYeUeYMRu78eI7eOkRHC6Guf/9s2Wov+6D+A0
 UNj6wjrkKDaGz4MiqxAVGH+8b1euVij4J6ZILpRsMcaXK9AQ/XHRQhQs6HMxgwd1ExTn4Tysw
 f1VwqY2YBsWS6lc2WNpamSYD0E+lV2+LnJDLrjqlxEuk0GRdKGdFZKWPDifu1I4hnoI5XzJCD
 ehOKbnWU9Q7kk+2/tOpwb8nA4jSKwoV+BtGz32vt0Auql1HNA3gwJ5ZgNJsqKEAR/+b4eOlok
 cMMmePtmty1KPJTW7ZJN61+f03v4OOLOPTadi8Z0IHTlrAHBscq2dofIRyewkPI6bFHydfDXX
 k3PTHnx8R/fis2qhkxK0EfuVoWSDaLvqc35w+ifCLwouYUaQZTvz9Z8lIAT0DC9Du/+k05jcN
 hL8Sag120gps2bRsyJ8XUVKuAVJOibwALInnDTOG+MWJkQR3H+UuRVfRjR6Et/IwNYKPxUfBE
 7JK7AV1E2WwuGo0YOFMIDIPbmbZDmkJbq61TRxRTR/UzKnJesSeOextncRhOB1Hd7AIxtv0FW
 BlXmb4Bh/cRn4qRG6ClCxLTb/8fwrf2PK1mANGfTR2b0xdgeGstYBUHim85+bbubyK0s7y47c
 Nt/LOA75tDzoDlClLBH9rKSVqvwHRBVNdiJ/34ef0lpyTBX1XxoSv6L1rdCu9Xpo/XkDaIoK0
 UNj2lHbCGDG4IIYILy2vpNUyEQXdEy6vWwPBK73MJS/0fdcO7pV8UQEFJfGXK6PPfnI9DuT/r
 9lVSIswIJEz8QWL2XVw1cvVQg2aHW9GLJ4HlPdHo256RGM/vdnNtkoQ5QisXgy9gHn/1yCfyV
 vDyX5px8WQhDZPAJ3O60EnW80LD3mvWohNCabmLEjjlkI7VS+81ToVeYm0jnluVVybbKKdEbi
 pfAQkItD0gpDJjIFdVNUzSJmkQ7CRE2S6qWY9Cf02DwzZCSO0ierZPKqrIn/+MHarnMRfEqOJ
 OuwD9cpmGAAnkVEuaXzrwPw5KJuhhF/sw4RyIggX4fyCbVBsy4aEytsKijHR6KfRgUOTfMIc1
 3O6+GI4hClgb6GuJNqQFqutF/vm98j3w4/F/CcYFpP3863QRpVmYbvK/vJPL1ut0d86tA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.06.20 um 19:47 schrieb SZEDER G=C3=A1bor via GitGitGadget:
> From: =3D?UTF-8?q?SZEDER=3D20G=3DC3=3DA1bor?=3D <szeder.dev@gmail.com>
>
> The file 'dir/subdir/file' can only be modified if its leading
> directories 'dir' and 'dir/subdir' are modified as well.
>
> So when checking modified path Bloom filters looking for commits
> modifying a path with multiple path components, then check not only
> the full path in the Bloom filters, but all its leading directories as
> well.  Take care to check these paths in "deepest first" order,
> because it's the full path that is least likely to be modified, and
> the Bloom filter queries can short circuit sooner.
>
> This can significantly reduce the average false positive rate, by
> about an order of magnitude or three(!), and can further speed up
> pathspec-limited revision walks.  The table below compares the average
> false positive rate and runtime of
>
>   git rev-list HEAD -- "$path"
>
> before and after this change for 5000+ randomly* selected paths from
> each repository:
>
>                     Average false           Average        Average
>                     positive rate           runtime        runtime
>                   before     after     before     after   difference
>   ------------------------------------------------------------------
>   git             3.220%   0.7853%     0.0558s   0.0387s   -30.6%
>   linux           2.453%   0.0296%     0.1046s   0.0766s   -26.8%
>   tensorflow      2.536%   0.6977%     0.0594s   0.0420s   -29.2%
>
> *Path selection was done with the following pipeline:
>
> 	git ls-tree -r --name-only HEAD | sort -R | head -n 5000
>
> The improvements in runtime are much smaller than the improvements in
> average false positive rate, as we are clearly reaching diminishing
> returns here.  However, all these timings depend on that accessing
> tree objects is reasonably fast (warm caches).  If we had a partial
> clone and the tree objects had to be fetched from a promisor remote,
> e.g.:
>
>   $ git clone --filter=3Dtree:0 --bare file://.../webkit.git webkit.notr=
ees.git
>   $ git -C webkit.git -c core.modifiedPathBloomFilters=3D1 \
>         commit-graph write --reachable
>   $ cp webkit.git/objects/info/commit-graph webkit.notrees.git/objects/i=
nfo/
>   $ git -C webkit.notrees.git -c core.modifiedPathBloomFilters=3D1 \
>         rev-list HEAD -- "$path"
>
> then checking all leading path component can reduce the runtime from
> over an hour to a few seconds (and this is with the clone and the
> promisor on the same machine).
>
> This adjusts the tracing values in t4216-log-bloom.sh, which provides a
> concrete way to notice the improvement.
>
> Helped-by: Taylor Blau <me@ttaylorr.com>
> Helped-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  revision.c           | 41 ++++++++++++++++++++++++++++++++---------
>  revision.h           |  6 ++++--
>  t/t4216-log-bloom.sh |  2 +-
>  3 files changed, 37 insertions(+), 12 deletions(-)
>
> diff --git a/revision.c b/revision.c
> index b53377cd52..077888ee51 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -670,9 +670,10 @@ static void prepare_to_use_bloom_filter(struct rev_=
info *revs)
>  {
>  	struct pathspec_item *pi;
>  	char *path_alloc =3D NULL;
> -	const char *path;
> +	const char *path, *p;
>  	int last_index;
> -	int len;
> +	size_t len;
> +	int path_component_nr =3D 1;
>
>  	if (!revs->commits)
>  		return;
> @@ -709,8 +710,28 @@ static void prepare_to_use_bloom_filter(struct rev_=
info *revs)
>  		return;
>  	}
>
> -	revs->bloom_key =3D xmalloc(sizeof(struct bloom_key));
> -	fill_bloom_key(path, len, revs->bloom_key, revs->bloom_filter_settings=
);
> +	p =3D path;
> +	while (*p) {
> +		if (is_dir_sep(*p))
> +			path_component_nr++;
> +		p++;
> +	}
> +
> +	revs->bloom_keys_nr =3D path_component_nr;
> +	ALLOC_ARRAY(revs->bloom_keys, revs->bloom_keys_nr);
> +
> +	fill_bloom_key(path, len, &revs->bloom_keys[0],
> +		       revs->bloom_filter_settings);
> +	path_component_nr =3D 1;
> +
> +	p =3D path + len - 1;

len cannot be 0 at this point, as patch 9 made sure, so this is safe.
Good.

> +	while (p > path) {
> +		if (is_dir_sep(*p))
> +			fill_bloom_key(path, p - path,
> +				       &revs->bloom_keys[path_component_nr++],
> +				       revs->bloom_filter_settings);
> +		p--;
> +	}

This walks the directory hierarchy upwards and adds bloom filters for
shorter and shorter paths, ("deepest first").  Good.

And it supports all directory separators.  On Windows that would be
slash (/) and backslash (\).  I assume paths are normalized to use
only slashes when bloom filters are written, correct?  Then the lookup
side needs to normalize a given path to only use slashes as well,
otherwise paths with backslashes cannot be found.  This part seems to
be missing.

>
>  	if (trace2_is_enabled() && !bloom_filter_atexit_registered) {
>  		atexit(trace2_bloom_filter_statistics_atexit);
> @@ -724,7 +745,7 @@ static int check_maybe_different_in_bloom_filter(str=
uct rev_info *revs,
>  						 struct commit *commit)
>  {
>  	struct bloom_filter *filter;
> -	int result;
> +	int result =3D 1, j;
>
>  	if (!revs->repo->objects->commit_graph)
>  		return -1;
> @@ -744,9 +765,11 @@ static int check_maybe_different_in_bloom_filter(st=
ruct rev_info *revs,
>  		return -1;
>  	}
>
> -	result =3D bloom_filter_contains(filter,
> -				       revs->bloom_key,
> -				       revs->bloom_filter_settings);
> +	for (j =3D 0; result && j < revs->bloom_keys_nr; j++) {
> +		result =3D bloom_filter_contains(filter,
> +					       &revs->bloom_keys[j],
> +					       revs->bloom_filter_settings);
> +	}
>
>  	if (result)
>  		count_bloom_filter_maybe++;
> @@ -786,7 +809,7 @@ static int rev_compare_tree(struct rev_info *revs,
>  			return REV_TREE_SAME;
>  	}
>
> -	if (revs->bloom_key && !nth_parent) {
> +	if (revs->bloom_keys_nr && !nth_parent) {
>  		bloom_ret =3D check_maybe_different_in_bloom_filter(revs, commit);
>
>  		if (bloom_ret =3D=3D 0)
> diff --git a/revision.h b/revision.h
> index 7c026fe41f..abbfb4ab59 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -295,8 +295,10 @@ struct rev_info {
>  	struct topo_walk_info *topo_walk_info;
>
>  	/* Commit graph bloom filter fields */
> -	/* The bloom filter key for the pathspec */
> -	struct bloom_key *bloom_key;
> +	/* The bloom filter key(s) for the pathspec */
> +	struct bloom_key *bloom_keys;
> +	int bloom_keys_nr;
> +
>  	/*
>  	 * The bloom filter settings used to generate the key.
>  	 * This is loaded from the commit-graph being used.
> diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
> index f890cc4737..84f95972ca 100755
> --- a/t/t4216-log-bloom.sh
> +++ b/t/t4216-log-bloom.sh
> @@ -146,7 +146,7 @@ test_expect_success 'setup - add commit-graph to the=
 chain with Bloom filters' '
>
>  test_bloom_filters_used_when_some_filters_are_missing () {
>  	log_args=3D$1
> -	bloom_trace_prefix=3D"statistics:{\"filter_not_present\":3,\"zero_leng=
th_filter\":0,\"maybe\":8,\"definitely_not\":6"
> +	bloom_trace_prefix=3D"statistics:{\"filter_not_present\":3,\"zero_leng=
th_filter\":0,\"maybe\":6,\"definitely_not\":8"
>  	setup "$log_args" &&
>  	grep -q "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.perf" &&
>  	test_cmp log_wo_bloom log_w_bloom
>
