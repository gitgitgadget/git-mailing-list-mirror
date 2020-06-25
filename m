Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459E9C433DF
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 07:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F4DF206C3
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 07:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="keqFVGvF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390144AbgFYHZM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 03:25:12 -0400
Received: from mout.web.de ([212.227.17.11]:57289 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390110AbgFYHZM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 03:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593069907;
        bh=RNq85K803iu3B3cw1uK5VzyD7Ynp+6G9+fSKe7hFfuY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=keqFVGvFNiEl8XMHab3YyaL1hlnI+aEfDyP576hghRD0K9JWhb6pQ52NqtXWQ+v62
         IfMOjfxvphAG1qyLOYtaQqYkBKXqk+Vu8hm2sIx1lMXNXRyeh5pKylT1RwgjhbL+fl
         A74k9PIYAUb1ZKuqPOJ32hnPheMvOkm/OztQ7pa4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lnj7L-1jCoub42mN-00hwoA; Thu, 25
 Jun 2020 09:25:07 +0200
Subject: Re: [PATCH v2 03/11] bloom: get_bloom_filter() cleanups
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
 <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
 <492deaf916464abedc7fc2d3de41fe690a558d9b.1592934430.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <2d64707c-a538-118c-d7c3-7a38bf08fa79@web.de>
Date:   Thu, 25 Jun 2020 09:24:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <492deaf916464abedc7fc2d3de41fe690a558d9b.1592934430.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rUySa0tdtH6nET8NIxwMkISrkc7Z8pUPrcHug7/cgczzEwfe5+c
 6eiidh7Iy+UODqGtcWKmyvmWQBGoBZGEVebKdAeNs3mSJqT5VvzEc2PvyMlR82eilYDMhyQ
 tmSK5Xeni3YTtkRr2C5Ok4YEPvb0eCJ30wylOEOCVFu1WngwEOK372tk7lq7vSK2U8eU+PL
 k1nuZaxZ5c0pxKLqeu4vQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZVWKUMUm5Bk=:mTzRSmpvjwnzwbEZLGLHjD
 ki5AEvkq7dGEOkpyg8MPvu2SJ2omr/h7ODF/Tu4sR+NfsW0jjrGn2Rr73crKoahoweVZO66YL
 Ffp68ACzWhyaxn/XnlgTwRLWspVYmJlZDoWekQ3umju2+WSOKbqw3jLP1yMmD4fG+A+7N4fbr
 Os9wbbfj2QqkoS7VLFThURAyEUjbYueRZWEmJnVnaamCgN8CZqdRCNcyi/POAY6wX0Fh4VhpY
 taOSv1FY7k+ZZG7jkY5JfryH5MuzzTbyeTJyDy0froGlrd6kZrBVDIA9x+JWXlABLYFadQ3Pi
 QqtOMOLY7e6gLJ2Q3EfmFffVKsjnwCU5YjXOI+bGkzM3fwR47YbFSS3iP4KI9nScbY7CFwl2h
 FMeUVxtNh2HpJ6GnQMrFc6KGsXE7mL1an4/4mS+N6GCp7YQ2IDSY/sitC1r/HrYe0DFhiNoG5
 qMVGJJn2rQMJwi7LlAv2jjE+oo+9vt5PGlZ7pU3wEP9ufee0WxkZjQPsahSAfBTM0SD35KCl5
 TU4I+5YN6qSeqgOwGmZs2F5RCp1+0J8yFZfrWljxBU2VfURPhD3DudG41EWBHsNNTwlNEIsU2
 DAcxoK+tmbg4ivTjL2Lg/cCKiffxj+p8WqvIkbYXzmL/bZvOKO4YNETKMpFRlS+u1TxEU8YBg
 coiQXPvMwYcgZu6jUcs+z5NOgUPdTr7mlT/ecaysPsBCUifWC2XsVxWIM14sHtQOdESIiZ/TV
 h0ifU8bV0xRl8z8dmTSJRweAbTfKvYdqs2GikUSLO+clBH7TgIf2hITf29UAQmGcLhWamjsmv
 lk8ssCIDvvJPSz7t8AuVwmkRe6VMl9CKb9ukK7o5NgQjuq1pTzGr+5E1TEqgi80RanNyAVcG8
 W1Ax7rA6nioMyR+o2cXusexYx9wYgYrhQUqwNLX9SvtjK5IIBRGHmJSMlGcQxc3MerHE7kfOM
 mliOaVM2BDVpiISAndodnlfyM/nSMHiwArIhWkzXuKvxHmrQh92aYARh2oWW5EBKLGlSjaCgn
 np7/LRRnoBrJesrF/n9x4lwpblIwGuV9yKA5BigpwIdHUGREW0Wfo1LRjh1iJd4tiYWVNES2b
 q2PjfBKSJsKcf+ltW4ZXDoG7XOeoU32phh3hQJdvRoHysJtKLFcz2xki2I6z1jhWpQWOLFYWO
 YryD1hKMJipzIX7PzuDRF3CiJ1iJKxMnMIpMbvHOZGn1j4OkBZGJOM6NGH2PAkubyKO1Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.06.20 um 19:47 schrieb Derrick Stolee via GitGitGadget:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The get_bloom_filter() method is a bit complicated in some parts where
> it does not need to be. In particular, it needs to return a NULL filter
> only when compute_if_not_present is zero AND the filter data cannot be
> loaded from a commit-graph file. This currently happens by accident
> because the commit-graph does not load changed-path Bloom filters from
> an existing commit-graph when writing a new one. This will change in a
> later patch.

So this is actually a logic fix, not just a cleanup as the subject says?

>
> Also clean up some style issues while we are here.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  bloom.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/bloom.c b/bloom.c
> index c38d1cff0c..7291506564 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -186,7 +186,7 @@ struct bloom_filter *get_bloom_filter(struct reposit=
ory *r,
>  	struct diff_options diffopt;
>  	int max_changes =3D 512;
>
> -	if (bloom_filters.slab_size =3D=3D 0)
> +	if (!bloom_filters.slab_size)
>  		return NULL;
>
>  	filter =3D bloom_filter_slab_at(&bloom_filters, c);
> @@ -194,16 +194,15 @@ struct bloom_filter *get_bloom_filter(struct repos=
itory *r,
>  	if (!filter->data) {
>  		load_commit_graph_info(r, c);
>  		if (c->graph_pos !=3D COMMIT_NOT_FROM_GRAPH &&
> -			r->objects->commit_graph->chunk_bloom_indexes) {
> -			if (load_bloom_filter_from_graph(r->objects->commit_graph, filter, c=
))
> -				return filter;
> -			else
> -				return NULL;

... and the fix is that this else branch should not be taken if
compute_if_not_present is set.

> -		}
> +		    r->objects->commit_graph->chunk_bloom_indexes &&
> +		    load_bloom_filter_from_graph(r->objects->commit_graph, filter, c)=
)
> +			return filter;

You could even drop this return as well and have the check below handle th=
e
successful load case.

>  	}
>
> -	if (filter->data || !compute_if_not_present)
> +	if (filter->data)
>  		return filter;
> +	if (!filter->data && !compute_if_not_present)
            ^^^^^^^^^^^^^
The first condition is always true, as the check two lines above makes sur=
e.
Removing it would be cleaner IMHO.

> +		return NULL;
>
>  	repo_diff_setup(r, &diffopt);
>  	diffopt.flags.recursive =3D 1;
>
