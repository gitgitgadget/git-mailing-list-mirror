Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA3FC433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 11:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiGKLHM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 07:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiGKLG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 07:06:59 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C356710FE72
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 03:13:13 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id o8so2745888wms.2
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 03:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oE73mWyi9lDXNdsL8ZB8NXXkwb8OpaUYeNjHZfKDsPo=;
        b=G0WXETldpnmen+9uflhhqV1zvJFItwoIRHSqPc4tcHU8fGyTZdw9lGyBDQ0bTk7t2v
         GNR9LornLNV6welFqhKhLQeeWcecp7AI2lYfDmrNaCwM3fiPYJDQWS2GHCxNyiXZ7h8W
         wAQZdXm/zOxOJLlLOVw6+BDJcC8BW9TLCs8z6kaqjduKOUwjoyoHQ3edJD4SD/MGgpDW
         c9fINPiPhvFubSg6ge8Ao+5F34nTfGoCRIEzpbtcGDlw17dxD3MNfR4Sv6bKxWDl/LkG
         zi0kBxaUbxiFJVZ1vS6evvSviRSfDPoSJe6gBBvC9+kgZElwgoFQPP914x8LVM4XnDXT
         j2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oE73mWyi9lDXNdsL8ZB8NXXkwb8OpaUYeNjHZfKDsPo=;
        b=Ad2UJPO2cahw/8LM7JaPPq/L5phq1kl8eXc3cFmstd21UKNmNFbR4qgYX+WbaIpx7v
         CSiFRfEA+aSp7xh1mt+x4IRi1ThUbecD7mKRyr0TQnxtNbzj4Y0aMgzrCzf6QVjDXLrO
         uqih3mafBoxUxBkCIxYeHNOCcNsG+/gJzEXwGQZQwBizCoUGRWZ7uXMXzUgUk+RLkVmI
         EpZfYzrXBbdAG80nFKNa4ID+saMXulz0M9EenKyz18ECl9wjBpAsYqvmmQQZqvDZuNNv
         CG+/d+v0M69jdaVhig61qJeD0JaG9vJxCHplnrJfaA22NjVJxLSek3e/c3DlcbRaLaI9
         pJVQ==
X-Gm-Message-State: AJIora9VUEwATNupIJNL6QZ6+BZIc+D/8KQBIdnBl4fQlGqcG3oWB8p8
        gqbTKiKazXvi/5lzzlP0eFY=
X-Google-Smtp-Source: AGRyM1u+x9qG9LbgzJeTxguVRN7i84QcBtK+PwpxWqtZ4UqfZpgKrpR3yXP8+KZ4YBg7mDHciinp1Q==
X-Received: by 2002:a05:600c:4eca:b0:3a1:9c39:ac20 with SMTP id g10-20020a05600c4eca00b003a19c39ac20mr15174135wmq.61.1657534387604;
        Mon, 11 Jul 2022 03:13:07 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id f11-20020adfe90b000000b0021d7b41255esm5362007wrm.98.2022.07.11.03.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 03:13:07 -0700 (PDT)
Message-ID: <c2bc5c79-e71b-f9dc-ba97-261d3454e150@gmail.com>
Date:   Mon, 11 Jul 2022 11:13:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 5/7] xdiff: use GALLOC_GROW(), not XDL_ALLOC_GROW()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <b34dcb93-df73-f5de-3c7c-7ab6c3250afe@gmail.com>
 <cover-0.7-00000000000-20220708T140354Z-avarab@gmail.com>
 <patch-5.7-3665576576f-20220708T140354Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <patch-5.7-3665576576f-20220708T140354Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 08/07/2022 15:20, Ævar Arnfjörð Bjarmason wrote:
> Replace the recently introduced XDL_ALLOC_GROW() with invocations of
> the GALLOC_GROW() from git-shared-util.h.
> 
> As this change shows the macro + function indirection of
> XDL_ALLOC_GROW() is something we needed only because the two callsites
> we used it in wanted to use it as an expression, and we thus had to
> pass the "sizeof" down.
> 
> Let's just check the value afterwards instead, which allows us to use
> the shared macro, we can also remove xdl_reallo(), this was its last
> user.

I don't think this expression->statement change is an improvement. This 
change also removes the overflow checks that are present in 
XDL_ALLOC_GROW() and fails to free the old allocation when realloc() 
fails. It is not a like for like replacement.

Best Wishes

Phillip

> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   xdiff/xdiff.h    |  1 -
>   xdiff/xmacros.h  | 11 -----------
>   xdiff/xprepare.c |  8 +++++---
>   xdiff/xutils.c   | 17 -----------------
>   xdiff/xutils.h   |  2 --
>   5 files changed, 5 insertions(+), 34 deletions(-)
> 
> diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
> index 72e25a9ffa5..832cf9d977e 100644
> --- a/xdiff/xdiff.h
> +++ b/xdiff/xdiff.h
> @@ -121,7 +121,6 @@ typedef struct s_bdiffparam {
>   
>   #define xdl_malloc(x) xmalloc(x)
>   #define xdl_free(ptr) free(ptr)
> -#define xdl_realloc(ptr,x) xrealloc(ptr,x)
>   
>   void *xdl_mmfile_first(mmfile_t *mmf, long *size);
>   long xdl_mmfile_size(mmfile_t *mmf);
> diff --git a/xdiff/xmacros.h b/xdiff/xmacros.h
> index 75506bdf17e..6a6b3057375 100644
> --- a/xdiff/xmacros.h
> +++ b/xdiff/xmacros.h
> @@ -48,15 +48,4 @@ do { \
>   	(v) = (unsigned long) __p[0] | ((unsigned long) __p[1]) << 8 | \
>   		((unsigned long) __p[2]) << 16 | ((unsigned long) __p[3]) << 24; \
>   } while (0)
> -
> -/*
> - * Ensure array p can accommodate at least nr elements, growing the
> - * array and updating alloc (which is the number of allocated
> - * elements) as necessary. Frees p and returns -1 on failure, returns
> - * 0 on success
> - */
> -#define XDL_ALLOC_GROW(p, nr, alloc)	\
> -	(-!((nr) <= (alloc) ||		\
> -	    ((p) = xdl_alloc_grow_helper((p), (nr), &(alloc), sizeof(*(p))))))
> -
>   #endif /* #if !defined(XMACROS_H) */
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index d6cbee32a2a..4182d9e1c0a 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -128,8 +128,9 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
>   			return -1;
>   		}
>   		rcrec->idx = cf->count++;
> -		if (XDL_ALLOC_GROW(cf->rcrecs, cf->count, cf->alloc))
> -				return -1;
> +		GALLOC_GROW(cf->rcrecs, cf->count, cf->alloc);
> +		if (!cf->rcrecs)
> +			return -1;
>   		cf->rcrecs[rcrec->idx] = rcrec;
>   		rcrec->line = line;
>   		rcrec->size = rec->size;
> @@ -187,7 +188,8 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
>   		for (top = blk + bsize; cur < top; ) {
>   			prev = cur;
>   			hav = xdl_hash_record(&cur, top, xpp->flags);
> -			if (XDL_ALLOC_GROW(recs, nrec + 1, narec))
> +			GALLOC_GROW(recs, nrec + 1, narec);
> +			if (!recs)
>   				goto abort;
>   			if (!(crec = xdl_cha_alloc(&xdf->rcha)))
>   				goto abort;
> diff --git a/xdiff/xutils.c b/xdiff/xutils.c
> index a6f10353cff..c0cd5338c4e 100644
> --- a/xdiff/xutils.c
> +++ b/xdiff/xutils.c
> @@ -436,20 +436,3 @@ int xdl_fall_back_diff(xdfenv_t *diff_env, xpparam_t const *xpp,
>   
>   	return status;
>   }
> -
> -void* xdl_alloc_grow_helper(void *p, long nr, long *alloc, size_t size)
> -{
> -	void *tmp = NULL;
> -	size_t n = ((LONG_MAX - 16) / 2 >= *alloc) ? 2 * *alloc + 16 : LONG_MAX;
> -	if (nr > n)
> -		n = nr;
> -	if (SIZE_MAX / size >= n)
> -		tmp = xdl_realloc(p, n * size);
> -	if (tmp) {
> -		*alloc = n;
> -	} else {
> -		xdl_free(p);
> -		*alloc = 0;
> -	}
> -	return tmp;
> -}
> diff --git a/xdiff/xutils.h b/xdiff/xutils.h
> index fd0bba94e8b..7ae3f897bef 100644
> --- a/xdiff/xutils.h
> +++ b/xdiff/xutils.h
> @@ -42,7 +42,5 @@ int xdl_emit_hunk_hdr(long s1, long c1, long s2, long c2,
>   int xdl_fall_back_diff(xdfenv_t *diff_env, xpparam_t const *xpp,
>   		       int line1, int count1, int line2, int count2);
>   
> -/* Do not call this function, use XDL_ALLOC_GROW instead */
> -void* xdl_alloc_grow_helper(void* p, long nr, long* alloc, size_t size);
>   
>   #endif /* #if !defined(XUTILS_H) */

