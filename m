Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32F7520970
	for <e@80x24.org>; Sat,  8 Apr 2017 14:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752145AbdDHOHE (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 10:07:04 -0400
Received: from mout.web.de ([212.227.17.12]:54903 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751841AbdDHOHC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 10:07:02 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MC1fA-1co1J607fM-008utk; Sat, 08
 Apr 2017 16:06:44 +0200
Subject: Re: [PATCH v2] unpack-trees: avoid duplicate ODB lookups during
 checkout
To:     git@jeffhostetler.com, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20170407155306.42375-1-git@jeffhostetler.com>
 <20170407155306.42375-2-git@jeffhostetler.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <23662d7b-84a9-4b71-1aa5-5d3d111f5c3d@web.de>
Date:   Sat, 8 Apr 2017 16:06:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0
MIME-Version: 1.0
In-Reply-To: <20170407155306.42375-2-git@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:CL0J99k1xgelv+MfSJQzaw9rlcRl0nt2iDfSJvaFXapMF6i7V5L
 RGwhgmbXhoW8mEKTf9eAVeNnBihaWcBRpFRQA9icM2QBJaJi17svUkk09Bc6VkpNzKjmZWT
 4sPrZQsqd3Tf5x8ZinGMypmTgAGosVJk/SX4KjMdvx6+waZ6T6Vh42WhzHQ1Du4MSiQleJD
 Vj6Hf/XB0h6Wwcou2MxiQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0iwD+lizzb8=:/+VkQl20frK3SWU328yr/z
 oyoZXfJw+kvDyhg28foogvSRbKi+TOgFrC+754sf6AaD2QWY40A46A1yMgNx++uBNJIxY04r9
 vCRbVG0aH800p915AFZECy4eEQnEW2GN/x1iLJwUcu5kQNfwyTkYd3sICXPgfjDXoLmQUDWyI
 LPMl14HF/SNXpJzkLVVMFPRgvSG//tJRgXA9Ujoo4dmfiy6PH0mQ5Noyj5HPNBj6Hd0+NM3eh
 VVOAnPXrHUMWjAIS60onuNKDOi07et0e8Gwg46m8tscrVCtKxy8ViRzu5fxxLNPnrZabHx+gG
 oicQSbEVx8jMaxx4vRGJSqWhQ8WvIBqGuR/iU3lXmN3fDTvanfI3zH2BSif0K3hRIjWjAYw5k
 NZ0vc31OTX3j4D7G1UajiYsR2DxFXxmi65HfKawlsvuFPHQpq5q3SWANafEoEl7fzUnjiEqjo
 cfxn4N4I17T8djx4E+U/laPXg8C7asP1ktu0vyP/uyqoV9dO/bacc3KaMQp84QaVbmPUtsYkj
 LQafDf3i1pDRsqIKuKokAp9d2n3n0UBMPw4k//6TS6rRDe+MjC6IZGyZ5kvBkq64c1cuQ8+29
 Mbek75Y194J+msPthOmGdeZ7MrIUuIteB3DlXxI/c4Rx1ZfVgNYnbi+XdtqHl1jkT9JoLemLf
 zKIB2Y3xULQOQ1ia7hD207oawhOKOj1UOtvLuFRvDqizV6wqmBOGzfbNABtP5SYiqseGdNrQ8
 3DZw3lo8s2v9Xs7GKQtX9C8IO/gg50c/x7fb2Q4sGTv1fWNeazgQ9iemvP8JkLqYCn3r83k2P
 dF0b3p7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.04.2017 um 17:53 schrieb git@jeffhostetler.com:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Teach traverse_trees_recursive() to not do redundant ODB
> lookups when both directories refer to the same OID.
> 
> In operations such as read-tree, checkout, and merge when
> the differences between the commits are relatively small,
> there will likely be many directories that have the same
> SHA-1.  In these cases we can avoid hitting the ODB multiple
> times for the same SHA-1.
> 
> This patch handles n=2 and n=3 cases and simply copies the
> data rather than repeating the fill_tree_descriptor().
> 
> ================
> On the Windows repo (500K trees, 3.1M files, 450MB index),
> this reduced the overall time by 0.75 seconds when cycling
> between 2 commits with a single file difference.
> 
> (avg) before: 22.699
> (avg) after:  21.955
> ===============
> 
> ================
> Using the p0004-read-tree test (posted earlier this week)
> with 1M files on Linux:
> 
> before:
> $ ./p0004-read-tree.sh
> 0004.5: switch work1 work2 (1003037)       11.99(8.12+3.32)
> 0004.6: switch commit aliases (1003037)    11.95(8.20+3.14)
> 
> after:
> $ ./p0004-read-tree.sh
> 0004.5: switch work1 work2 (1003037)       11.02(7.71+2.78)
> 0004.6: switch commit aliases (1003037)    10.95(7.57+2.82)
> ================
> 
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>   unpack-trees.c | 23 +++++++++++++++++++----
>   1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 3a8ee19..143c5d9 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -531,6 +531,11 @@ static int switch_cache_bottom(struct traverse_info *info)
>   	return ret;
>   }
>   
> +static inline int are_same_oid(struct name_entry *name_j, struct name_entry *name_k)
> +{
> +	return name_j->oid && name_k->oid && !oidcmp(name_j->oid, name_k->oid);
> +}
> +
>   static int traverse_trees_recursive(int n, unsigned long dirmask,
>   				    unsigned long df_conflicts,
>   				    struct name_entry *names,
> @@ -554,10 +559,20 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
>   	newinfo.df_conflicts |= df_conflicts;
>   
>   	for (i = 0; i < n; i++, dirmask >>= 1) {
> -		const unsigned char *sha1 = NULL;
> -		if (dirmask & 1)
> -			sha1 = names[i].oid->hash;
> -		buf[i] = fill_tree_descriptor(t+i, sha1);
> +		if (i > 0 && are_same_oid(&names[i], &names[i-1])) {
> +			/* implicitly borrow buf[i-1] inside tree_desc[i] */
> +			memcpy(&t[i], &t[i-1], sizeof(struct tree_desc));

An assignment would be simpler:

			t[i] = t[i - 1];

> +			buf[i] = NULL;
> +		} else if (i > 1 && are_same_oid(&names[i], &names[i-2])) {
> +			/* implicitly borrow buf[i-2] inside tree_desc[i] */
> +			memcpy(&t[i], &t[i-2], sizeof(struct tree_desc));

Similar case.

> +			buf[i] = NULL;

What makes the previous two entries special, or differently put: Why not 
just check *all* previous entries?  MAX_UNPACK_TREES is 8; the number of 
comparisons would just about double in the worst case and stay the same 
for three trees or less.  The order of four trees or more wouldn't 
matter anymore.

> +		} else {
> +			const unsigned char *sha1 = NULL;
> +			if (dirmask & 1)
> +				sha1 = names[i].oid->hash;
> +			buf[i] = fill_tree_descriptor(t+i, sha1);
> +		}
>   	}
>   
>   	bottom = switch_cache_bottom(&newinfo);
> 
