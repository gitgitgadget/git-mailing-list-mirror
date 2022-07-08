Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B880BC43334
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 17:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238935AbiGHRvs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 13:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238866AbiGHRvr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 13:51:47 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5222A1FCCE
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 10:51:46 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id n10so6204210wrc.4
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 10:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pE41+Y8lDmm3KSjRzUsS73Kha3w0VUUIKNwEDnSU7bk=;
        b=d6qWluXYSs4pvxLnnPMHrPkzWWLFXQYkuem5teKmJ7fwnd5hj7p1iazUIxn5viAkNR
         0UaHC+Kfe3Een6/Y00886WlVl6KAdx2XBmuoeMOreMPzbTfnXupDcrqMh4NHD/0wvsoE
         uZGmfAaIbDIaBK/dFljfvqpoBuRZGiZ5lD/f18HWJV8lzVYrQAtf+CWLVZNeQzexMgcj
         m0jc2RMvG2fVSEU7zwzThYNqc2VWcdbK5b2n47eBH6rLHvGnBu9Gq19CmVox5XLPXSah
         DS2QrflCQ6waM528N8Cm/cl639Yer2rlbewmYTjK6RWnbeJ6RcfBhcuBacI/wzZE654D
         Hwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pE41+Y8lDmm3KSjRzUsS73Kha3w0VUUIKNwEDnSU7bk=;
        b=32YlsKc7I19oRuaq4Hf2a4Fr7AN9yEG8PUcCreM4JbRkvp3zsNURcEyws96FwzsfwT
         pGIeY90VxC3rajCAwPw8vJ5UwiswXOXDzF5bac47SZJ5jRHoAnEryBsCMopzCwV5Q/es
         dNTfueZXIyClX3+IXWsjYh2BTz3QFP8tVgQCFPpTE9ot6HiCc3/M1hi+tJGop+oLmbOa
         PkJYoPBpp5Ogxg7GwuiEz/0W4sW6vN6RMS8jc1LfDVQ1tMMeXw+6YuWHDLqJVzjGsDER
         vjJkrceGeMCsqslQmEKbHMlI3guxLilOY/Fj6Zf2xMfZZOzbrSyqRcN496ElYANP06hb
         T0uA==
X-Gm-Message-State: AJIora+xLf7kg93Fx2AmlbeJc60oHuIqVy9J3b/a3D3vhBynvWGYMNWh
        UUgsckshydwf5pqtiXZv1Ek=
X-Google-Smtp-Source: AGRyM1s/+BcW6u3XapuYHXMium/7XpnDr5YsestdStOCbRZODE6qrLaETi72sIL+7v89Jg9uBz4KLg==
X-Received: by 2002:a05:6000:901:b0:21a:a576:23cc with SMTP id bz1-20020a056000090100b0021aa57623ccmr4427838wrb.489.1657302704794;
        Fri, 08 Jul 2022 10:51:44 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id l1-20020a7bc441000000b003a2cf1535aasm2856653wmi.17.2022.07.08.10.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 10:51:44 -0700 (PDT)
Message-ID: <6b8fc0e8-c446-1275-12f3-e6520de9584d@gmail.com>
Date:   Fri, 8 Jul 2022 18:51:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 7/7] xdiff: remove xdl_free(), use free() instead
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <b34dcb93-df73-f5de-3c7c-7ab6c3250afe@gmail.com>
 <cover-0.7-00000000000-20220708T140354Z-avarab@gmail.com>
 <patch-7.7-a1bf9a94f0a-20220708T140354Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <patch-7.7-a1bf9a94f0a-20220708T140354Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 08/07/2022 15:20, Ævar Arnfjörð Bjarmason wrote:
> Remove the xdl_free() wrapper macro in favor of using free()
> directly. The wrapper macro was brought in with the initial import of
> xdiff/ in 3443546f6ef (Use a *real* built-in diff generator,
> 2006-03-24).
> 
> As subsequent discussions on the topic[1] have made clear there's no
> reason to use this wrapper.

That link is to a message where you assert that there is no reason for 
the wrapper, you seem to be the only person in that thread making that 
argument. The libgit2 maintainer and others are arguing that it is worth 
keeping to make it easy to swap the allocator.

> Both git itself as well as any external
> users such as libgit2 compile the xdiff/* code as part of their own
> compilation, and can thus find the right malloc() and free() at
> link-time.

I'm struggling to see how that is simpler than the current situation 
with xdl_malloc(). Perhaps you could show how you think libgit2 could 
easily make xdiff use git__malloc() instead of malloc() without changing 
the malloc() calls (the message you linked to essentially suggests they 
do a search and replace). If people cannot swap in another allocator 
without changing the code then you are imposing a barrier to them 
contributing patches back to git's xdiff.

Best Wishes

Phillip

> When compiling git we already find a custom malloc() and free()
> e.g. if compiled with USE_NED_ALLOCATOR=YesPlease.
> 
> 1. https://lore.kernel.org/git/220415.867d7qbaad.gmgdl@evledraar.gmail.com/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   xdiff/xdiff.h      |  3 ---
>   xdiff/xdiffi.c     |  4 ++--
>   xdiff/xhistogram.c |  6 +++---
>   xdiff/xpatience.c  |  8 ++++----
>   xdiff/xprepare.c   | 28 ++++++++++++++--------------
>   xdiff/xutils.c     |  2 +-
>   6 files changed, 24 insertions(+), 27 deletions(-)
> 
> diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
> index df048e0099b..a37d89fcdaf 100644
> --- a/xdiff/xdiff.h
> +++ b/xdiff/xdiff.h
> @@ -118,9 +118,6 @@ typedef struct s_bdiffparam {
>   	long bsize;
>   } bdiffparam_t;
>   
> -
> -#define xdl_free(ptr) free(ptr)
> -
>   void *xdl_mmfile_first(mmfile_t *mmf, long *size);
>   long xdl_mmfile_size(mmfile_t *mmf);
>   
> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index 6590811634f..375bb81a8aa 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -359,7 +359,7 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
>   	res = xdl_recs_cmp(&dd1, 0, dd1.nrec, &dd2, 0, dd2.nrec,
>   			   kvdf, kvdb, (xpp->flags & XDF_NEED_MINIMAL) != 0,
>   			   &xenv);
> -	xdl_free(kvd);
> +	free(kvd);
>   
>   	return res;
>   }
> @@ -960,7 +960,7 @@ void xdl_free_script(xdchange_t *xscr) {
>   
>   	while ((xch = xscr) != NULL) {
>   		xscr = xscr->next;
> -		xdl_free(xch);
> +		free(xch);
>   	}
>   }
>   
> diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
> index f20592bfbdd..be35d9c9697 100644
> --- a/xdiff/xhistogram.c
> +++ b/xdiff/xhistogram.c
> @@ -240,9 +240,9 @@ static int fall_back_to_classic_diff(xpparam_t const *xpp, xdfenv_t *env,
>   
>   static inline void free_index(struct histindex *index)
>   {
> -	xdl_free(index->records);
> -	xdl_free(index->line_map);
> -	xdl_free(index->next_ptrs);
> +	free(index->records);
> +	free(index->line_map);
> +	free(index->next_ptrs);
>   	xdl_cha_free(&index->rcha);
>   }
>   
> diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
> index bb328d9f852..8fffd2b8297 100644
> --- a/xdiff/xpatience.c
> +++ b/xdiff/xpatience.c
> @@ -233,7 +233,7 @@ static int find_longest_common_sequence(struct hashmap *map, struct entry **res)
>   	/* No common unique lines were found */
>   	if (!longest) {
>   		*res = NULL;
> -		xdl_free(sequence);
> +		free(sequence);
>   		return 0;
>   	}
>   
> @@ -245,7 +245,7 @@ static int find_longest_common_sequence(struct hashmap *map, struct entry **res)
>   		entry = entry->previous;
>   	}
>   	*res = entry;
> -	xdl_free(sequence);
> +	free(sequence);
>   	return 0;
>   }
>   
> @@ -358,7 +358,7 @@ static int patience_diff(mmfile_t *file1, mmfile_t *file2,
>   			env->xdf1.rchg[line1++ - 1] = 1;
>   		while(count2--)
>   			env->xdf2.rchg[line2++ - 1] = 1;
> -		xdl_free(map.entries);
> +		free(map.entries);
>   		return 0;
>   	}
>   
> @@ -372,7 +372,7 @@ static int patience_diff(mmfile_t *file1, mmfile_t *file2,
>   		result = fall_back_to_classic_diff(&map,
>   			line1, count1, line2, count2);
>    out:
> -	xdl_free(map.entries);
> +	free(map.entries);
>   	return result;
>   }
>   
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index 4182d9e1c0a..169629761c0 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -89,7 +89,7 @@ static int xdl_init_classifier(xdlclassifier_t *cf, long size, long flags) {
>   
>   	GALLOC_ARRAY(cf->rcrecs, cf->alloc);
>   	if (!cf->rcrecs) {
> -		xdl_free(cf->rchash);
> +		free(cf->rchash);
>   		xdl_cha_free(&cf->ncha);
>   		return -1;
>   	}
> @@ -102,8 +102,8 @@ static int xdl_init_classifier(xdlclassifier_t *cf, long size, long flags) {
>   
>   static void xdl_free_classifier(xdlclassifier_t *cf) {
>   
> -	xdl_free(cf->rcrecs);
> -	xdl_free(cf->rchash);
> +	free(cf->rcrecs);
> +	free(cf->rchash);
>   	xdl_cha_free(&cf->ncha);
>   }
>   
> @@ -230,11 +230,11 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
>   	return 0;
>   
>   abort:
> -	xdl_free(ha);
> -	xdl_free(rindex);
> -	xdl_free(rchg);
> -	xdl_free(rhash);
> -	xdl_free(recs);
> +	free(ha);
> +	free(rindex);
> +	free(rchg);
> +	free(rhash);
> +	free(recs);
>   	xdl_cha_free(&xdf->rcha);
>   	return -1;
>   }
> @@ -242,11 +242,11 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
>   
>   static void xdl_free_ctx(xdfile_t *xdf) {
>   
> -	xdl_free(xdf->rhash);
> -	xdl_free(xdf->rindex);
> -	xdl_free(xdf->rchg - 1);
> -	xdl_free(xdf->ha);
> -	xdl_free(xdf->recs);
> +	free(xdf->rhash);
> +	free(xdf->rindex);
> +	free(xdf->rchg - 1);
> +	free(xdf->ha);
> +	free(xdf->recs);
>   	xdl_cha_free(&xdf->rcha);
>   }
>   
> @@ -424,7 +424,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>   	}
>   	xdf2->nreff = nreff;
>   
> -	xdl_free(dis);
> +	free(dis);
>   
>   	return 0;
>   }
> diff --git a/xdiff/xutils.c b/xdiff/xutils.c
> index 865e08f0e93..00eeba452a5 100644
> --- a/xdiff/xutils.c
> +++ b/xdiff/xutils.c
> @@ -88,7 +88,7 @@ void xdl_cha_free(chastore_t *cha) {
>   
>   	for (cur = cha->head; (tmp = cur) != NULL;) {
>   		cur = cur->next;
> -		xdl_free(tmp);
> +		free(tmp);
>   	}
>   }
>   

