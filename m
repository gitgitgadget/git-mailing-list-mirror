Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABCFC1FA14
	for <e@80x24.org>; Sat, 15 Apr 2017 17:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753746AbdDOR4O (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Apr 2017 13:56:14 -0400
Received: from mout.web.de ([212.227.15.4]:62546 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751616AbdDOR4M (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2017 13:56:12 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MCIYT-1cqxb92Gav-009Blp; Sat, 15
 Apr 2017 19:55:54 +0200
Subject: Re: [PATCH v10 3/3] read-cache: speed up add_index_entry during
 checkout
To:     git@jeffhostetler.com, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20170414191230.52825-1-git@jeffhostetler.com>
 <20170414191230.52825-4-git@jeffhostetler.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d9f1acc8-03e3-abc6-af9d-da55a33218fa@web.de>
Date:   Sat, 15 Apr 2017 19:55:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0
MIME-Version: 1.0
In-Reply-To: <20170414191230.52825-4-git@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:3rayS8u7SjMoqldVHe9mrvIgd5x0zgTti85L4nM+niE7UxgzS8u
 e/vBb4vSr3IKDW6/FTOt0pe6oh5PpV+Pijxx2Qe2H4ZyRm6Yr4ir0YJzIh8DAJV/HWewJCV
 mz+KZtxC1xaeRdTnf2erQ9Izz2MA0TJoGkla5ysYo8UcwMUoY3SsdQPifVxcMAl+QI3+zix
 gR/k/iCkhIFmGerStlUYA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/M6mCEDOEak=:BgxlTcYOOJ1xfNZJaYlx4i
 Gz3jrEAVYoVXa4SU3vOl9orb8R8mHZN+iT/DlAfBEScpRNUBT+0rcnaYfnTMy/JhROzXgMvAM
 YVp+Fz1qBHlrqb4fXebIttgGTYxwdttALE3VTWDAaO2Cazq7aoxD9j4mzyKqc87/0xwFjQTLR
 zHnEu3JMB0t+NECsvRklzITh5a56G1A7/TTpXSrUBP24rjUxcQVrLkz9Fn7mFtj4H4l9+8N2J
 ulO87yoHdQ7T8LPr5iAjSI5uExeUhIRuexfj5ifMRmSIA71K1M61zBEca2r/U6G2WLmfSi6v3
 a33G1MM56hMlx5UHHz8XqSXOoM33k8+3E4QhJgZ7ibW69WD+pkujMKq1YE7cSY/QQK/MV9muA
 rt3yazNXgh1iJ6dRxLYMB8JnlqV6w6+LjoAGWvWdv7HkoGFScSB5fFv50Ez4ja4+Ok7jimZXw
 n9SipBQnwgoFotIkALKI3hyI3720thwrGdEjazNz3DMzi5RQIty0Q75XmF9lA58Z6gv6FoeMs
 uitak93ySg17jc3tF/JRHiyS+KjZQ9pQqt1+/qWU0dIOg0sTl2aTLtu9pDVP1sKMR9Fa5XeUo
 n4Ya3SW6Dky3jBfxkxy/kme7XNK/f8pIl3vKCwL28ugMFjsrM347o7AMKotbbU7rPaGxe1cvu
 kdywP+ECoW47SDcDsWQUwgan7Tw5ANWPD71dKa+gSR4DS07ymeWWyZOe1DdMjRkeFE4GZ9OHH
 7mrd9vcEAZoB5267YqLYf0z/3Bd+3gJ0QRirwjZwoBCpD6rbSWo0p2/OqCIL2Jf6jb45tCqPG
 nZ5E62l
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.04.2017 um 21:12 schrieb git@jeffhostetler.com:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Teach add_index_entry_with_check() and has_dir_name()
> to see if the path of the new item is greater than the
> last path in the index array before attempting to search
> for it.
> 
> During checkout, merge_working_tree() populates the new
> index in sorted order, so this change will save at least 2
> binary lookups per file.  This preserves the original
> behavior but simply checks the last element before starting
> the search.
> 
> This helps performance on very large repositories.
> 
> This can be seen using p0006-read-tree-checkout.sh and the
> artificial repository created by t/perf/repos/many-files.sh
> with parameters (5, 10, 9).   (1M files in index.)
> 
> Test                                                            HEAD^              HEAD
> ----------------------------------------------------------------------------------------------------------
> 0006.2: read-tree br_base br_ballast (1000001)                  4.15(2.72+1.41)    3.21(1.97+1.22) -22.7%
> 0006.3: switch between br_base br_ballast (1000001)             8.11(5.57+2.28)    6.77(4.36+2.14) -16.5%
> 0006.4: switch between br_ballast br_ballast_plus_1 (1000001)   13.52(8.68+4.35)   11.80(7.38+3.96) -12.7%
> 0006.5: switch between aliases (1000001)                        13.59(8.75+4.43)   11.85(7.49+3.87) -12.8%
> 
> On linux.git, results are:
> Test                                                          HEAD^             HEAD
> ------------------------------------------------------------------------------------------------------
> 0006.2: read-tree br_base br_ballast (57994)                  0.24(0.22+0.01)   0.20(0.17+0.02) -16.7%
> 0006.3: switch between br_base br_ballast (57994)             9.91(5.82+2.79)   10.26(5.92+2.77) +3.5%
> 0006.4: switch between br_ballast br_ballast_plus_1 (57994)   0.59(0.44+0.16)   0.50(0.34+0.18) -15.3%
> 0006.5: switch between aliases (57994)                        0.62(0.48+0.16)   0.50(0.35+0.16) -19.4%
> 
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>   read-cache.c | 118 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 116 insertions(+), 2 deletions(-)

Very nice, especially the perf test!  But can we unbundle the different
optimizations into separate patches with their own performance numbers?
Candidates IMHO: The change in add_index_entry_with_check(), the first
hunk in has_dir_name(), the loop shortcuts.  That might also help find
the reason for the slight slowdown of 0006.3 for the kernel repository.

> diff --git a/read-cache.c b/read-cache.c
> index 97f13a1..ba95fbb 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -910,6 +910,9 @@ int strcmp_offset(const char *s1, const char *s2, size_t *first_change)
>   /*
>    * Do we have another file with a pathname that is a proper
>    * subset of the name we're trying to add?
> + *
> + * That is, is there another file in the index with a path
> + * that matches a sub-directory in the given entry?
>    */
>   static int has_dir_name(struct index_state *istate,
>   			const struct cache_entry *ce, int pos, int ok_to_replace)
> @@ -918,9 +921,51 @@ static int has_dir_name(struct index_state *istate,
>   	int stage = ce_stage(ce);
>   	const char *name = ce->name;
>   	const char *slash = name + ce_namelen(ce);
> +	size_t len_eq_last;
> +	int cmp_last = 0;
> +
> +	/*
> +	 * We are frequently called during an iteration on a sorted
> +	 * list of pathnames and while building a new index.  Therefore,
> +	 * there is a high probability that this entry will eventually
> +	 * be appended to the index, rather than inserted in the middle.
> +	 * If we can confirm that, we can avoid binary searches on the
> +	 * components of the pathname.
> +	 *
> +	 * Compare the entry's full path with the last path in the index.
> +	 */
> +	if (istate->cache_nr > 0) {
> +		cmp_last = strcmp_offset(name,
> +			istate->cache[istate->cache_nr - 1]->name,
> +			&len_eq_last);
> +		if (cmp_last > 0) {
> +			if (len_eq_last == 0) {
> +				/*
> +				 * The entry sorts AFTER the last one in the
> +				 * index and their paths have no common prefix,
> +				 * so there cannot be a F/D conflict.
> +				 */
> +				return retval;
> +			} else {
> +				/*
> +				 * The entry sorts AFTER the last one in the
> +				 * index, but has a common prefix.  Fall through
> +				 * to the loop below to disect the entry's path
> +				 * and see where the difference is.
> +				 */
> +			}
> +		} else if (cmp_last == 0) {
> +			/*
> +			 * The entry exactly matches the last one in the
> +			 * index, but because of multiple stage and CE_REMOVE
> +			 * items, we fall through and let the regular search
> +			 * code handle it.
> +			 */
> +		}
> +	}
>   
>   	for (;;) {
> -		int len;
> +		size_t len;
>   
>   		for (;;) {
>   			if (*--slash == '/')
> @@ -930,6 +975,66 @@ static int has_dir_name(struct index_state *istate,
>   		}
>   		len = slash - name;
>   
> +		if (cmp_last > 0) {
> +			/*
> +			 * (len + 1) is a directory boundary (including
> +			 * the trailing slash).  And since the loop is
> +			 * decrementing "slash", the first iteration is
> +			 * the longest directory prefix; subsequent
> +			 * iterations consider parent directories.
> +			 */
> +
> +			if (len + 1 <= len_eq_last) {
> +				/*
> +				 * The directory prefix (including the trailing
> +				 * slash) also appears as a prefix in the last
> +				 * entry, so the remainder cannot collide (because
> +				 * strcmp said the whole path was greater).
> +				 *
> +				 * EQ: last: xxx/A
> +				 *     this: xxx/B
> +				 *
> +				 * LT: last: xxx/file_A
> +				 *     this: xxx/file_B
> +				 */
> +				return retval;
> +			}
> +
> +			if (len > len_eq_last) {
> +				/*
> +				 * This part of the directory prefix (excluding
> +				 * the trailing slash) is longer than the known
> +				 * equal portions, so this sub-directory cannot
> +				 * collide with a file.
> +				 *
> +				 * GT: last: xxxA
> +				 *     this: xxxB/file
> +				 */
> +				return retval;
> +			}
> +

At this point len and len_eq_last are equal -- otherwise one of the two
previous conditions would have triggered.  Silly question: Is this
necessary for the following shortcut to work?  Removing the two checks
above doesn't seem to affect performance very much, and at least the
test suite still passes..

> +			if (ce_namelen(istate->cache[istate->cache_nr - 1]) > len) {
> +				/*
> +				 * The directory prefix lines up with part of
> +				 * a longer file or directory name, but sorts
> +				 * after it, so this sub-directory cannot
> +				 * collide with a file.
> +				 *
> +				 * last: xxx/yy-file (because '-' sorts before '/')
> +				 * this: xxx/yy/abc
> +				 */
> +				return retval;
> +			}

istate->cache_nr can be zero if remove_index_entry_at() had been called
in a previous iteration, resulting in a segfault.  Checking right here
is probably the easiest way out; not sure if exiting early when the
index becomes empty would be better.

> +
> +			/*
> +			 * This is a possible collision. Fall through and
> +			 * let the regular search code handle it.
> +			 *
> +			 * last: xxx
> +			 * this: xxx/file
> +			 */
> +		}
> +
>   		pos = index_name_stage_pos(istate, name, len, stage);
>   		if (pos >= 0) {
>   			/*
> @@ -1021,7 +1126,16 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
>   
>   	if (!(option & ADD_CACHE_KEEP_CACHE_TREE))
>   		cache_tree_invalidate_path(istate, ce->name);
> -	pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce));
> +
> +	/*
> +	 * If this entry's path sorts after the last entry in the index,
> +	 * we can avoid searching for it.
> +	 */
> +	if (istate->cache_nr > 0 &&
> +		strcmp(ce->name, istate->cache[istate->cache_nr - 1]->name) > 0)
> +		pos = -istate->cache_nr - 1;
> +	else
> +		pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce));
>   
>   	/* existing match? Just replace it. */
>   	if (pos >= 0) {
> 
