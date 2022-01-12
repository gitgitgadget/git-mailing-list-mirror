Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E00C433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 13:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241802AbiALN6n (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 08:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236849AbiALN6l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 08:58:41 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26297C06173F
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 05:58:41 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id e9so4441549wra.2
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 05:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=from:content-transfer-encoding:mime-version:subject:date:references
         :to:in-reply-to:message-id;
        bh=hVhw+mYTA0n8S3MIvjTVZ7LCzdBgAZHvDrByDWEioSM=;
        b=jGbVRIFkd5xP8r2CEbtaQ7vGhWNglI4bLvs2OjnpFw0RvUemBxaYZ5kF31f1MuuFTR
         oo4fwevyE88qmcPhd0DRD8qT0gngtqGg5h5IAYiCg4uD5MqyqkZ+EOaf0jgYTxKUQi1d
         tPOIpCX2XodEVtyHE3PCw8mP06bWGLmNowvCDkSpZRUS+k/YezTvdSBeNnt1mO+/0aiM
         HYnk2FTd9ltrasAZgRUwsDnsxzTZMRmFkyp5tZbAgpzmaAfjjQmBjOZ7T0K1X2wOEj4u
         Ssa3RySbhYaimUYkGgc1DCFUDEhiYTcF3B6nQ8uI4C/9VZ3LpeZsE6tdE7232qQW/R8S
         0VXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:date:references:to:in-reply-to:message-id;
        bh=hVhw+mYTA0n8S3MIvjTVZ7LCzdBgAZHvDrByDWEioSM=;
        b=nq9MSAXS+O/tgoy9O/iDylYTHtE3bdNY55avZKa6skSpyWagPD1l8Y5zdVP1LoqvzU
         mfhJsHXg88V+4q/H+4ysgIw+oMK+2mOYmIpn8Qq7ajHI+78QcrYLBw9osYxzZNw9987V
         fjYb4+Y86Z9TjA03qLArhALkfx1/jmfy5ABrWgUEYbeK6bYhF//moZ0+Hv2kyWpiQwwn
         icf4//fC2A0cXh1ffQM4qO9lq/vnFOzknPCg34srXymUTCRUK42wGVodG4GmFzI4m0UU
         l8vP8duh/hg1aZHe93JsP2jJSbsvbe4ziXG9tGI1oNKRSvhmlit3SPB5Dw8h8UB3z84N
         XN9A==
X-Gm-Message-State: AOAM533NmE4IbgzmK0JP1yOFJ/m9BxdN3NfSIWieQTB/H+mWsFdgWu5x
        cVZcg9MC+R+8geqjzCA7w+0IO2VekLT0LrFy
X-Google-Smtp-Source: ABdhPJyY1KlW7RL/58qFYmvK2/bWLTZRQfr4fW4T1Jaci5ph76DiJGPfgW6+7aHmnG0L2bKL/xbv5A==
X-Received: by 2002:adf:f2c3:: with SMTP id d3mr2749508wrp.644.1641995919576;
        Wed, 12 Jan 2022 05:58:39 -0800 (PST)
Received: from smtpclient.apple (global-5-142.nat-2.net.cam.ac.uk. [131.111.5.142])
        by smtp.gmail.com with ESMTPSA id n14sm13734264wrf.107.2022.01.12.05.58.39
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jan 2022 05:58:39 -0800 (PST)
From:   Jessica Clarke <jrtc27@jrtc27.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] Properly align memory allocations and temporary buffers
Date:   Wed, 12 Jan 2022 13:58:38 +0000
References: <20220105132324.6651-1-jrtc27@jrtc27.com>
To:     git@vger.kernel.org
In-Reply-To: <20220105132324.6651-1-jrtc27@jrtc27.com>
Message-Id: <641A33F3-E98A-40B1-BB11-ADC8C1FECA75@jrtc27.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5 Jan 2022, at 13:23, Jessica Clarke <jrtc27@jrtc27.com> wrote:
> 
> Currently git_qsort_s allocates a buffer on the stack that has no
> alignment, and mem_pool_alloc assumes uintmax_t's size is adequate
> alignment for any type.
> 
> On CHERI, and thus Arm's Morello prototype, pointers are implemented as
> hardware capabilities which, as well as having a normal integer address,
> have additional bounds, permissions and other metadata in a second word,
> so on a 64-bit architecture they are 128-bit quantities, including their
> alignment requirements. Despite being 128-bit, their integer component
> is still only a 64-bit field, so uintmax_t remains 64-bit, and therefore
> uintmax_t does not sufficiently align an allocation.
> 
> Moreover, these capabilities have an additional "129th" tag bit, which
> tracks the validity of the capability and is cleared on any invalid
> operation that doesn't trap (e.g. partially overwriting a capability
> will invalidate it) which, combined with the architecture's strict
> checks on capability manipulation instructions, ensures it is
> architecturally impossible to construct a capability that gives more
> rights than those you were given in the first place. To store these tag
> bits, each capability sized and aligned word in memory gains a single
> tag bit that is stored in unaddressable (to the processor) memory. This
> means that it is impossible to store a capability at an unaligned
> address: a normal load or store of a capability will always take an
> alignment fault even if the (micro)architecture supports unaligned
> loads/stores for other data types, and a memcpy will, if the destination
> is not appropriately aligned, copy the byte representation but lose the
> tag, meaning that if it is eventually copied back and loaded from an
> aligned location any attempt to dereference it will trap with a tag
> fault. Thus, even char buffers that are memcpy'ed to or from must be
> properly aligned on CHERI architectures if they are to hold pointers.
> 
> Address both of these by introducing a new git_max_align type put in a
> union with the on-stack buffer to force its alignment, as well as a new
> GIT_MAX_ALIGNMENT macro whose value is the alignment of git_max_align
> that gets used for mem_pool_alloc. As well as making the code work on
> CHERI, the former change likely also improves performance on some
> architectures by making memcpy faster (either because it can use larger
> block sizes or because the microarchitecture has inefficient unaligned
> accesses).
> 
> Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
> ---
> compat/qsort_s.c  | 11 +++++++----
> git-compat-util.h | 11 +++++++++++
> mem-pool.c        |  6 +++---
> 3 files changed, 21 insertions(+), 7 deletions(-)

I can see the alternative fixes for qsort are now in next, as is the
cleanup of register_symlink_changes to use string sets, which just
leaves the mem-pool.c change to not assume that uintmax_t is
sufficiently aligned for every type that git will use. If I move
GIT_MAX_ALIGNMENT and its helper aggregates to mem-pool.c would that be
acceptable?

Jess

> diff --git a/compat/qsort_s.c b/compat/qsort_s.c
> index 52d1f0a73d..1ccdb87451 100644
> --- a/compat/qsort_s.c
> +++ b/compat/qsort_s.c
> @@ -49,16 +49,19 @@ int git_qsort_s(void *b, size_t n, size_t s,
> 		int (*cmp)(const void *, const void *, void *), void *ctx)
> {
> 	const size_t size = st_mult(n, s);
> -	char buf[1024];
> +	union {
> +		char buf[1024];
> +		git_max_align align;
> +	} u;
> 
> 	if (!n)
> 		return 0;
> 	if (!b || !cmp)
> 		return -1;
> 
> -	if (size < sizeof(buf)) {
> -		/* The temporary array fits on the small on-stack buffer. */
> -		msort_with_tmp(b, n, s, cmp, buf, ctx);
> +	if (size < sizeof(u.buf)) {
> +		/* The temporary array fits in the small on-stack buffer. */
> +		msort_with_tmp(b, n, s, cmp, u.buf, ctx);
> 	} else {
> 		/* It's somewhat large, so malloc it.  */
> 		char *tmp = xmalloc(size);
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 5fa54a7afe..28581a45c5 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -274,6 +274,17 @@ typedef unsigned long uintptr_t;
> #define _ALL_SOURCE 1
> #endif
> 
> +typedef union {
> +	uintmax_t max_align_uintmax;
> +	void *max_align_pointer;
> +} git_max_align;
> +
> +typedef struct {
> +	char unalign;
> +	git_max_align aligned;
> +} git_max_alignment;
> +#define GIT_MAX_ALIGNMENT offsetof(git_max_alignment, aligned)
> +
> /* used on Mac OS X */
> #ifdef PRECOMPOSE_UNICODE
> #include "compat/precompose_utf8.h"
> diff --git a/mem-pool.c b/mem-pool.c
> index ccdcad2e3d..748eff925a 100644
> --- a/mem-pool.c
> +++ b/mem-pool.c
> @@ -69,9 +69,9 @@ void *mem_pool_alloc(struct mem_pool *pool, size_t len)
> 	struct mp_block *p = NULL;
> 	void *r;
> 
> -	/* round up to a 'uintmax_t' alignment */
> -	if (len & (sizeof(uintmax_t) - 1))
> -		len += sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
> +	/* round up to a 'GIT_MAX_ALIGNMENT' alignment */
> +	if (len & (GIT_MAX_ALIGNMENT - 1))
> +		len += GIT_MAX_ALIGNMENT - (len & (GIT_MAX_ALIGNMENT - 1));
> 
> 	if (pool->mp_block &&
> 	    pool->mp_block->end - pool->mp_block->next_free >= len)
> -- 
> 2.33.1
> 

