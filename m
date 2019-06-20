Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCADA1F461
	for <e@80x24.org>; Thu, 20 Jun 2019 17:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfFTRlz (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 13:41:55 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52392 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfFTRly (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 13:41:54 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B7D0D616B8;
        Thu, 20 Jun 2019 13:41:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zh0RYDemkxJR0B0m3cydo3e56XM=; b=VeQDNk
        QzyGFVpJk6CzHTuf1F6N//OpN9VGx06o1Kz+y35nC1M/2GWrWvBSVdy0jkIeDykd
        yUVFfAO7wv7XInxvl/R7RywhErItrh9YFNAV+4XKER155bzmvAhej85HBns94Bjq
        /R4mrA56lQRM+PUOy23OmN1Pyle1ObyOztLrM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SHLpe4+afHJFdcfeeBA2TRhixl0bDj5k
        tDqDBK2u9R8ZYlc9r7ebzWXLRJjtrxVFs6+o6XnLCoPNmarU6JRFwXRrfMwX3okC
        iiXvc7TBxsJGnEM/uEM2EqVr2ww1WxOp8pu/UuRXOBn+J3izo7V5kBRpDRpcziAl
        sVTS/h/2jx0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AEBE1616B5;
        Thu, 20 Jun 2019 13:41:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D09E1616B4;
        Thu, 20 Jun 2019 13:41:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 16/17] hash.h: move object_id definition from cache.h
References: <20190620073952.GA1539@sigill.intra.peff.net>
        <20190620074145.GP3713@sigill.intra.peff.net>
Date:   Thu, 20 Jun 2019 10:41:47 -0700
In-Reply-To: <20190620074145.GP3713@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 20 Jun 2019 03:41:45 -0400")
Message-ID: <xmqq1rzop31g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AEC4EECE-9382-11E9-AB96-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Our hashmap.h helpfully defines a sha1hash() function. But it cannot
> define a similar oidhash() without including all of cache.h, which
> itself wants to include hashmap.h! Let's break this circular dependency
> by moving the definition to hash.h, along with the remaining RAWSZ
> macros, etc. That will put them with the existing git_hash_algo
> definition.
>
> One alternative would be to move oidhash() into cache.h, but it's
> already quite bloated. We're better off moving things out than in.

Makes sense.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  cache.h | 24 ------------------------
>  hash.h  | 24 ++++++++++++++++++++++++
>  2 files changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index bf20337ef4..37e0b82064 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -43,30 +43,6 @@ int git_deflate_end_gently(git_zstream *);
>  int git_deflate(git_zstream *, int flush);
>  unsigned long git_deflate_bound(git_zstream *, unsigned long);
>  
> -/* The length in bytes and in hex digits of an object name (SHA-1 value). */
> -#define GIT_SHA1_RAWSZ 20
> -#define GIT_SHA1_HEXSZ (2 * GIT_SHA1_RAWSZ)
> -/* The block size of SHA-1. */
> -#define GIT_SHA1_BLKSZ 64
> -
> -/* The length in bytes and in hex digits of an object name (SHA-256 value). */
> -#define GIT_SHA256_RAWSZ 32
> -#define GIT_SHA256_HEXSZ (2 * GIT_SHA256_RAWSZ)
> -/* The block size of SHA-256. */
> -#define GIT_SHA256_BLKSZ 64
> -
> -/* The length in byte and in hex digits of the largest possible hash value. */
> -#define GIT_MAX_RAWSZ GIT_SHA256_RAWSZ
> -#define GIT_MAX_HEXSZ GIT_SHA256_HEXSZ
> -/* The largest possible block size for any supported hash. */
> -#define GIT_MAX_BLKSZ GIT_SHA256_BLKSZ
> -
> -struct object_id {
> -	unsigned char hash[GIT_MAX_RAWSZ];
> -};
> -
> -#define the_hash_algo the_repository->hash_algo
> -
>  #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
>  #define DTYPE(de)	((de)->d_type)
>  #else
> diff --git a/hash.h b/hash.h
> index 661c9f2281..52a4f1a3f4 100644
> --- a/hash.h
> +++ b/hash.h
> @@ -139,4 +139,28 @@ static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
>  	return p - hash_algos;
>  }
>  
> +/* The length in bytes and in hex digits of an object name (SHA-1 value). */
> +#define GIT_SHA1_RAWSZ 20
> +#define GIT_SHA1_HEXSZ (2 * GIT_SHA1_RAWSZ)
> +/* The block size of SHA-1. */
> +#define GIT_SHA1_BLKSZ 64
> +
> +/* The length in bytes and in hex digits of an object name (SHA-256 value). */
> +#define GIT_SHA256_RAWSZ 32
> +#define GIT_SHA256_HEXSZ (2 * GIT_SHA256_RAWSZ)
> +/* The block size of SHA-256. */
> +#define GIT_SHA256_BLKSZ 64
> +
> +/* The length in byte and in hex digits of the largest possible hash value. */
> +#define GIT_MAX_RAWSZ GIT_SHA256_RAWSZ
> +#define GIT_MAX_HEXSZ GIT_SHA256_HEXSZ
> +/* The largest possible block size for any supported hash. */
> +#define GIT_MAX_BLKSZ GIT_SHA256_BLKSZ
> +
> +struct object_id {
> +	unsigned char hash[GIT_MAX_RAWSZ];
> +};
> +
> +#define the_hash_algo the_repository->hash_algo
> +
>  #endif
