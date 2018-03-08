Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD4D81F404
	for <e@80x24.org>; Thu,  8 Mar 2018 17:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933221AbeCHRT4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 12:19:56 -0500
Received: from mout.web.de ([212.227.17.11]:41941 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932148AbeCHRTy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 12:19:54 -0500
Received: from [192.168.178.36] ([79.237.251.165]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MF3nL-1es1Nz1Cjj-00GIBE; Thu, 08
 Mar 2018 18:19:52 +0100
Subject: Re: [PATCH] fetch-pack.c: use oidset to check existence of loose
 object
To:     Takuto Ikuta <tikuta@chromium.org>
References: <20180308120639.109438-1-tikuta@chromium.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org
Message-ID: <c97772f1-dc36-3f2c-b328-6d8bd480ff79@web.de>
Date:   Thu, 8 Mar 2018 18:19:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180308120639.109438-1-tikuta@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:1RQDBFHD9DsOo11h6Lu89uN7Um6rYIn00DNBeIDYKf5EcbGBpCa
 s6rD+PpdoQRwPYJZ7vVs6hpPKhMswpnzn7yLEGM2P7MI4MLsBlDsgJjRHcdEW7//d8xvnzl
 ZgR+vGjcfOCKN8bdD2a+Bj4VH/8kbGSV5UcxYoCQhTi2y2hBBMIriMvSjM44qz8lSx93amL
 x9bsFNhBxwmF9/IUlLlBg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iFTS+P+xVaI=:ysS0/uSd2x25ZPHGdaa5c5
 jIVXAxnzxyw281EiYb8cnbGDUGhBe11Ji/YSsJ6Qs1LYgwufbZxfTXJI2GX1ZiK+QU+B7Ph+V
 UCOMdKaNAwwSKyxXl/MaYkbD0+5p4H/DVR+bfLySqbTlsuAPir3+sNkqQE0KSJe5oy/noZToM
 m2OXlADei5nevsN9x29o7bBQo1UT2p3X62L9En5Eqa1m++u01qlq4Ax/t1JnWpoYQ2IIqjbaU
 /yX5/uYdWi2KY2vqXaxdsPk086vfMeJ2EjHHBUr4Ucd9dyDMRcWDlOrD9ASx5jerR4rK7mZlE
 doLSvt8soa9rBklVGUL8+7bsJPrgnLt/ttltkEyFYQRn/++u2cCJp6F582SK9QcDc60J9FyXw
 TRKb/WIT+TBztk+tbAjmKXMOPpSG6Gc6pKsRkkFXyABFL+2x1u/Hg5yqYoSQ4V9cRVKBTjkQb
 5mHjHSRJ5g5RD55MWOAMX25nOtnN7IlKPXgapdS1QQsqHxMvILOwGMC04spKeRYPe29Vuy9Ox
 DxWpK2jb3aY8PI2SAvleXAX6/T3k6LDjlkKCfylhJznh5M/u/BOFe/rD3zWRK3hc00y0Hu6Ga
 m7APcp8Ew9+VCWSClk9uIDVtVmXL5hKIhaUAOwsb9/iKUWRfVhDrPatv6B2IztaJI3Zu64HJf
 GLdvk8vQZbBzmOa3gF8EVo8umZeE6TR7VlM/VQKToM4EXH55X6I1efq/hXWoRbASw1E3BL2+w
 ZDO/k4SyinUbTSz9xHzuKqsivLW4miy7CaYJRY44/I8gP294TroBuN9E8nwtZlOOPEO+/pzxV
 Z8CpQbpvRH+qdz2Qw+iB9mPrzov7CJded0CBYRDQycIMI1jRiU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.03.2018 um 13:06 schrieb Takuto Ikuta:
> In repository having large number of refs, lstat for non-existing loose
> objects makes `git fetch` slow.
> 
> This patch stores existing loose objects in hashmap beforehand and use
> it to check existence instead of using lstat.
> 
> With this patch, the number of lstat calls in `git fetch` is reduced
> from 411412 to 13794 for chromium repository.
> 
> I took time stat of `git fetch` disabling quickfetch for chromium
> repository 3 time on linux with SSD.
> * with this patch
> 8.105s
> 8.309s
> 7.640s
> avg: 8.018s
> 
> * master
> 12.287s
> 11.175s
> 12.227s
> avg: 11.896s
> 
> On my MacBook Air which has slower lstat.
> * with this patch
> 14.501s
> 
> * master
> 1m16.027s

Nice improvement!

> 
> `git fetch` on slow disk will be improved largely.
> 
> Signed-off-by: Takuto Ikuta <tikuta@chromium.org>
> ---
>   cache.h      |  2 ++
>   fetch-pack.c | 22 +++++++++++++++++++---
>   sha1_file.c  |  3 +++
>   3 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/cache.h b/cache.h
> index d06932ed0..db38db40e 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1773,6 +1773,8 @@ struct object_info {
>   #define OBJECT_INFO_SKIP_CACHED 4
>   /* Do not retry packed storage after checking packed and loose storage */
>   #define OBJECT_INFO_QUICK 8
> +/* Do not check loose object */
> +#define OBJECT_INFO_SKIP_LOOSE 16
>   extern int sha1_object_info_extended(const unsigned char *, struct object_info *, unsigned flags);
>   
>   /*
> diff --git a/fetch-pack.c b/fetch-pack.c
> index d97461296..1658487f7 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -711,6 +711,15 @@ static void mark_alternate_complete(struct object *obj)
>   	mark_complete(&obj->oid);
>   }
>   
> +static int add_loose_objects_to_set(const struct object_id *oid,
> +				    const char *path,
> +				    void *data)
> +{
> +	struct oidset* set = (struct oidset*)(data);

This cast is not needed (unlike in C++).  And the asterisk should be stuck
to the variable, not the type (see Documentation/CodingGuidelines).

> +	oidset_insert(set, oid);

In fact, you could just put "data" in here instead of "set" (without a
cast), with no loss in readability or safety.

> +	return 0;
> +}
> +
>   static int everything_local(struct fetch_pack_args *args,
>   			    struct ref **refs,
>   			    struct ref **sought, int nr_sought)
> @@ -719,16 +728,21 @@ static int everything_local(struct fetch_pack_args *args,
>   	int retval;
>   	int old_save_commit_buffer = save_commit_buffer;
>   	timestamp_t cutoff = 0;
> +	struct oidset loose_oid_set = OIDSET_INIT;
> +
> +	for_each_loose_object(add_loose_objects_to_set, &loose_oid_set, 0);
>   
>   	save_commit_buffer = 0;
>   
>   	for (ref = *refs; ref; ref = ref->next) {
>   		struct object *o;
> +		unsigned int flag = OBJECT_INFO_QUICK;
>   
> -		if (!has_object_file_with_flags(&ref->old_oid,
> -						OBJECT_INFO_QUICK))
> -			continue;
> +		if (!oidset_contains(&loose_oid_set, &ref->old_oid))
> +			flag |= OBJECT_INFO_SKIP_LOOSE;
>   
> +		if (!has_object_file_with_flags(&ref->old_oid, flag))
> +			continue;
>   		o = parse_object(&ref->old_oid);
>   		if (!o)
>   			continue;
> @@ -744,6 +758,8 @@ static int everything_local(struct fetch_pack_args *args,
>   		}
>   	}
>   
> +	oidset_clear(&loose_oid_set);
> +

This part looks fine to me.  (Except perhaps call the variable "flags"
because you sometimes have two?)

Why not include packed objects as well?  Probably because packs have
indexes which can queried quickly to determine object existence, and
because there are only few loose objects in typical repositories,
right?

A similar cache was introduced by cc817ca3ef (sha1_name: cache
readdir(3) results in find_short_object_filename()) to speed up
finding unambiguous shorts object hashes.  I wonder if it could be
used here as well, but I don't see an easy way.

>   	if (!args->no_dependents) {
>   		if (!args->deepen) {
>   			for_each_ref(mark_complete_oid, NULL);
> diff --git a/sha1_file.c b/sha1_file.c
> index 1b94f39c4..c903cbcec 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1262,6 +1262,9 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
>   		if (find_pack_entry(real, &e))
>   			break;
>   
> +		if (flags & OBJECT_INFO_SKIP_LOOSE)
> +			return -1;
> +
>   		/* Most likely it's a loose object. */
>   		if (!sha1_loose_object_info(real, oi, flags))
>   			return 0;
> 

This early return doesn't just skip checking loose objects.  It
also skips reloading packs and fetching missing objects for
partial clones.  That may not be a problem for fetch-pack, but
it means the flag has a misleading name.  Do you get the same
performance improvement if you make it only skip that
sha1_loose_object_info() call?

René
