Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCA5C433E9
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 17:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6042D64E97
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 17:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhBAR5U (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 12:57:20 -0500
Received: from mout.web.de ([212.227.17.12]:44713 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232563AbhBAR5D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 12:57:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1612202104;
        bh=GhgLt0+EECIIrNYU5xZZ+ZJYEc56jql+pF8VrGPVIAE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=e6X0E888/SqPE1dskdG/Po/7TgaFBCayp9/DrDRBjG32jz0IMA+CZy68BzvtGWIm7
         em4Y0y4TRYXQ9UuDWCoVuG4qhAwvypbXl9DHwRnWZIE2dKkH9e7+UH7N85ZF8+AIF8
         E4RlNjb4d709xgZw+YwjU3xvDDR98/H5Q2TP/lvQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.159.90]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MRW2R-1lLA7h0xxV-00NNao; Mon, 01 Feb 2021 18:55:04 +0100
Subject: Re: [PATCH v2] alloc.h|c: migrate alloc_states to mem-pool
To:     =?UTF-8?B?6Zi/5b6354OIIHZpYSBHaXRHaXRHYWRnZXQ=?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?6Zi/5b6354OI?= <adlternative@gmail.com>
References: <pull.857.git.1612011569489.gitgitgadget@gmail.com>
 <pull.857.v2.git.1612175966786.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <7a9e78d0-732d-a990-0cb5-6bd8cf940a88@web.de>
Date:   Mon, 1 Feb 2021 18:55:03 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <pull.857.v2.git.1612175966786.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nFIkyPN9KdF7DsvVA67A26QXJiDSG7btzZLyLGGFKwjx4IIbhyd
 FzyhVr9MKyWWYYoWjvdLBq2X9JPMya75N/TAQSGb0uJa/KCql6z0OYdeGvcsUF9361uNMme
 yuO8JcMKnH538kY9rut2LIqqIBNGPX/wAVWR9sAgl/ZxE9mkb9faKnzR9OY1lP2+NJwlJrm
 GYjlEgVcpOlSlrEcrQEqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MAwd30/1Cqw=:eZDF/P2ToeZ9g6mpFp2FvO
 x46/q6l92pCx4WhPE6XaryWX/RYk0KsG8OGcoe6dzW7GVKtiCreYqgEiCki+uUvjbs5fr1E2i
 AVK7h5BiEsatcJoSd3PEAj6BjV5CDnqpALEjxBI2i+pCW21vynRgVHLLc2NOXPtDT4SaLOzwC
 M8W53ZIA8MOxUMh7jqEmStTRLh42sWbKB+UCxan2fostjJE3okT08pbkCdZAak//sNJrToIyY
 EyPwirph6jRDHJ2UtnlAxn0OktD5WeI5wIhtf6wNgIrE6IC/fIQRVFmwjY8P9O109T5Vpxu7X
 98j6VPGp+V2Ps6r6bFb7j5ojHCC1rdxSZxrybR+AXzaAKbvE8ayWkQYDPfSkkCj3MF09+TYt6
 rXk8DPpCvG5gEqh5EFSmg30Tp17NaWF4Vz/1kfVi+wq2Gc3uzkyiPLx4qa9dSae1GMn9m/dWe
 upFloT2m6yCaQ1zvaKdi96ihzSvX4loVQ8+8/FzF+NnvccB+OIr8CFeAnocqlHTNWSXAfS4Ie
 LEehGcBvMNIxymRu6xDp6Vqq3p1YoiwMWnB62P0FDdKc4TQjSWeDSC8Cjn9VUsxPtx3PFgDt6
 ypoHkj77O75ggk01lX2N9rg/VHb2K2y0xTpq87We+HWWzrY+98lE9+CfDEmOGSTVll7sPcoJT
 YFF12sgqd9aTAdoFu4NOhSybkzDoklCAMPkdlfcxZyWo28WopfpFEfDsnvITVEir2+rBsOiYJ
 SC3jv9T4P5XQ1LjH6hZEts+9j3/6maDZlGEhsv2HRqhn5X+RPvIBkodpRnUyQ6vAoOTSAu5ON
 Laprzb8bBhmpJ66jlNiHZ/Olydk5RI0ToJb0cOeYjB3g/mphpoQa9ptfVDy/5vGZ/ws2BlwHf
 yS45ZPgJIZaVNJHO3Lhg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.02.21 um 11:39 schrieb =E9=98=BF=E5=BE=B7=E7=83=88 via GitGitGadget:
> From: ZheNing Hu <adlternative@gmail.com>
>
> "alloc_state" may have similar effects with "mem_pool".
> Using the new memory pool API may be more beneficial
> to our memory management in the future.

Replacing the custom object allocator with mem-pool would allow reducing
the code size.  What other effects might it have?  Do you expect changes
in memory use and/or performance with the current code and your patch?

> functions "alloc_*_node" now change to "mem_pool_alloc_*_node".

Why rename these functions?  Do callers need to care about the
underlying allocator?  The function signatures stay the same.  In any
case, this renaming would be easier to review if it was moved to a
separate patch.

> At the same time ,I add the member `alloc_count` of
> struct mem_pool ,so that we can effective track
> node alloc count,and adapt to the original interface `alloc_report`.

This function has no callers.  Why not remove it (in a separate patch)?

> diff --git a/alloc.c b/alloc.c
> index 957a0af3626..951ef3e4ed7 100644
> --- a/alloc.c
> +++ b/alloc.c
> @@ -71,30 +71,30 @@ static inline void *alloc_node(struct alloc_state *s=
, size_t node_size)
>  	return ret;
>  }

This keeps the now unused function alloc_node(), which breaks the build
with -Werror.

allocate_alloc_state() and clear_alloc_state() become unused as well,
but the compiler doesn't complain because those functions are
exported.  Nevertheless this patch should remove them, no?

> diff --git a/object.h b/object.h
> index 59daadce214..43031d8dc04 100644
> --- a/object.h
> +++ b/object.h
> @@ -10,11 +10,11 @@ struct parsed_object_pool {
>  	int nr_objs, obj_hash_size;
>
>  	/* TODO: migrate alloc_states to mem-pool? */

This comment becomes stale with this patch and should be removed at
the same time.

> -	struct alloc_state *blob_state;
> -	struct alloc_state *tree_state;
> -	struct alloc_state *commit_state;
> -	struct alloc_state *tag_state;
> -	struct alloc_state *object_state;
> +	struct mem_pool *blob_pool;
> +	struct mem_pool *tree_pool;
> +	struct mem_pool *commit_pool;
> +	struct mem_pool *tag_pool;
> +	struct mem_pool *object_pool;

Why have pointers here instead of the structs themselves?  It's not like
a struct parsed_object_pool is of much use without them, right?

The same question applies to the original code as well, of course.

Ren=C3=A9
