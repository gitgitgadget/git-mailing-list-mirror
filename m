Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3F9D1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 18:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752331AbeBISEJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 13:04:09 -0500
Received: from mout.web.de ([212.227.15.3]:53763 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751144AbeBISDx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 13:03:53 -0500
Received: from [192.168.178.36] ([91.20.50.7]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lvk9E-1el6AE3IaK-017TYY; Fri, 09
 Feb 2018 19:03:50 +0100
Subject: Re: [PATCH 2/2] packfile: refactor hash search with fanout table
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     stolee@gmail.com
References: <cover.1517609773.git.jonathantanmy@google.com>
 <007f3a4c84cb1c07255404ad1ea9f797129c5cf0.1517609773.git.jonathantanmy@google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <cfbde137-dbac-8796-f49f-2a543303d33a@web.de>
Date:   Fri, 9 Feb 2018 19:03:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <007f3a4c84cb1c07255404ad1ea9f797129c5cf0.1517609773.git.jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:KqBzUcDsfOrxiWUsI4drp9YfhLMrDK+eBPhyndr+nwvK10F+cID
 sy6I9iyo0zBgUsPpeBK6dRhljDmWnMAQgruK/mAHWpx/JrsXiAFtcxVnITek7Fecun1yr+X
 ytbtJMEznZlgPRFobAWISr3b1bo8+T6fAieZfn74TwUBbms1E8DvFl0o3ODqnN0FcLhfcyK
 YG5b/o5x/rrFi0IS8tWaA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:p2Oiq97FH7U=:S9jmHDSiMa5tgz57HWbfE6
 djtMt+WwvDkzCAhB5L3aV1jFyMludAA5GwRwhuAaOpsQqbgXNq7kPbdaGTI1oXYWEd5slXUjL
 W0oVJm80CG3mXe42Pana48xMuTzGQV7J3e4u5hMECSk1ORQUq2upRUizzPmgUn1P+ONQ9WkWh
 SjW7nfuRXpx3Xv/kUJi6PKsAEDld/AC2TgJIKh2KSMPFKwJuxbxYeDhQjwnlhsDaFTvGiJ7if
 AzF2gRuoIJSOVxY6w3bQBD66fjVRpKkzTzmj8fpWPp7xFNNpAMuKOyyD5aBShaK6gf9czJa3W
 4pNXSKb9FkOacRMVj2M37TsnjkNg5fkMq9Iml6Y2+7o/Vi71A/EGSmyYvBczPwuSxDdnFqo5J
 uAYK+Crfmok4lkPolN8bLoyNMfSoa2/md9qHNhqhotJUdTBuSDvSIY871UNr1Dez6n/oYdty6
 0JPwlb8VQp4eNPYFW24spONs/Jy5Fi/1Aw0Y14QiYAcOyBggAnSWWKjYM/TYe7JAoy2LCxoAN
 60/hhx+BT16VRuA46bSp7M+A3a+QOFDm4nRUhjqJP+YBKqz6Jo/mKq9W+XUBQNtWxVKZ0jdMD
 R65CGyD6LjRQBkEqTTN7DM2zshqxRQ8qoSHN03RotuuMSi1YenJDvGQ0YWYZe0hLOK+3esFZN
 ZQHuqgVIJZmDith0VUYzr6ncyjXZK0h8PwlLaWF/xXR5zF7mIrxoqh+X+h86BucrFhwoF9Czj
 a+UrILuQc7heFDfjbch6J70O1KX4n5PzvDFiVMq6UVTskT23yUOlysbNfkCTuEN7y+E/MAkX2
 vcmHQLdLUpmlthHIrne0eNXh8BCYd5BlZqP7KNFixDZMH4kuHc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.02.2018 um 23:36 schrieb Jonathan Tan:
> Subsequent patches will introduce file formats that make use of a fanout
> array and a sorted table containing hashes, just like packfiles.
> Refactor the hash search in packfile.c into its own function, so that
> those patches can make use of it as well.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>   packfile.c    | 19 +++++--------------
>   sha1-lookup.c | 24 ++++++++++++++++++++++++
>   sha1-lookup.h | 21 +++++++++++++++++++++
>   3 files changed, 50 insertions(+), 14 deletions(-)
> 
> diff --git a/packfile.c b/packfile.c
> index 58bdced3b..29f5dc239 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1712,7 +1712,8 @@ off_t find_pack_entry_one(const unsigned char *sha1,
>   {
>   	const uint32_t *level1_ofs = p->index_data;
>   	const unsigned char *index = p->index_data;
> -	unsigned hi, lo, stride;
> +	unsigned stride;
> +	int ret;
>   
>   	if (!index) {
>   		if (open_pack_index(p))
> @@ -1725,8 +1726,6 @@ off_t find_pack_entry_one(const unsigned char *sha1,
>   		index += 8;
>   	}
>   	index += 4 * 256;
> -	hi = ntohl(level1_ofs[*sha1]);
> -	lo = ((*sha1 == 0x0) ? 0 : ntohl(level1_ofs[*sha1 - 1]));
>   	if (p->index_version > 1) {
>   		stride = 20;
>   	} else {
> @@ -1734,17 +1733,9 @@ off_t find_pack_entry_one(const unsigned char *sha1,
>   		index += 4;
>   	}
>   
> -	while (lo < hi) {
> -		unsigned mi = lo + (hi - lo) / 2;
> -		int cmp = hashcmp(index + mi * stride, sha1);
> -
> -		if (!cmp)
> -			return nth_packed_object_offset(p, mi);
> -		if (cmp > 0)
> -			hi = mi;
> -		else
> -			lo = mi+1;
> -	}
> +	ret = bsearch_hash(sha1, level1_ofs, index, stride);
> +	if (ret >= 0)
> +		return nth_packed_object_offset(p, ret);

Going from unsigned to signed int means the patch breaks support for
more than 2G pack entries, which was put with 326bf39677 (Use uint32_t
for all packed object counts.) in 2007.

>   	return 0;
>   }
>   
> diff --git a/sha1-lookup.c b/sha1-lookup.c
> index 4cf3ebd92..d11c5e526 100644
> --- a/sha1-lookup.c
> +++ b/sha1-lookup.c
> @@ -99,3 +99,27 @@ int sha1_pos(const unsigned char *sha1, void *table, size_t nr,
>   	} while (lo < hi);
>   	return -lo-1;
>   }
> +
> +int bsearch_hash(const unsigned char *sha1, const void *fanout_,
> +		 const void *table_, size_t stride)
> +{
> +	const uint32_t *fanout = fanout_;

Why hide the type?  It doesn't make the function more generic.

> +	const unsigned char *table = table_;
> +	int hi, lo;
> +
> +	hi = ntohl(fanout[*sha1]);
> +	lo = ((*sha1 == 0x0) ? 0 : ntohl(fanout[*sha1 - 1]));
> +
> +	while (lo < hi) {
> +		unsigned mi = lo + (hi - lo) / 2;
> +		int cmp = hashcmp(table + mi * stride, sha1);
> +
> +		if (!cmp)
> +			return mi;
> +		if (cmp > 0)
> +			hi = mi;
> +		else
> +			lo = mi + 1;
> +	}
> +	return -lo - 1;
> +}
> diff --git a/sha1-lookup.h b/sha1-lookup.h
> index cf5314f40..3c59e9cb1 100644
> --- a/sha1-lookup.h
> +++ b/sha1-lookup.h
> @@ -7,4 +7,25 @@ extern int sha1_pos(const unsigned char *sha1,
>   		    void *table,
>   		    size_t nr,
>   		    sha1_access_fn fn);
> +
> +/*
> + * Searches for sha1 in table, using the given fanout table to determine the
> + * interval to search, then using binary search. Returns the element index of
> + * the position found if successful, -i-1 if not (where i is the index of the
> + * least element that is greater than sha1).
> + *
> + * Takes the following parameters:
> + *
> + *  - sha1: the hash to search for
> + *  - fanout: a 256-element array of NETWORK-order 32-bit integers; the integer
> + *    at position i represents the number of elements in table whose first byte
> + *    is less than or equal to i
> + *  - table: a sorted list of hashes with optional extra information in between
> + *  - stride: distance between two consecutive elements in table (should be
> + *    GIT_MAX_RAWSZ or greater)
> + *
> + * This function does not verify the validity of the fanout table.
> + */
> +extern int bsearch_hash(const unsigned char *sha1, const void *fanout,
> +			const void *table, size_t stride);
>   #endif
> 

Why not use sha1_pos()?  I guess because it avoids the overhead of the
accessor function, right?  And I wonder how much of difference it makes.

A binary search function for embedded hashes just needs the key, a
pointer to the first hash in the array, the stride and the number of
elements.  It can then be used with or without a fanout table, making it
more versatile.  Just a thought.

René
