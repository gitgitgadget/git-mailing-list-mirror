Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8499C433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 21:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244563AbiAFVqX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 16:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244495AbiAFVqR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 16:46:17 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA39C061245
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 13:46:17 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id u8so4808795iol.5
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 13:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=j8y/IPKRv12IJUGXKfPOAUH02EsEsyZulHrNrRk0Zlg=;
        b=Ng10W7WGnjRyO1BXgnNXqY6bPM6ajIu+o745+DzAu+Iuos1rjPIj9kXovLlRJIDuYb
         ZjbdRiZcG6dT2VhYBHfxYLc0fPm0Lw6e1yM3awGp1p5tYoJkocVTp5Vw3ObzD2PGdljN
         DFTwuAbRC06rw6aDkUHfaCtMO0UA+CAeTk/BknUbpV0VxXWuQG91DKWD53eEohbdphmv
         25zlQvReSCVJzgxTPk08F2LfftMPpVS+IMCBQzJF3yKyfKPp3DkPALZUICLd3Z8uHveS
         Mkd0vl+jmKeob4E49O6SdIes6YmIAddcmWNadtxkZanZwJwhP6+/I6XLpbzH0xa7Qk++
         w+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=j8y/IPKRv12IJUGXKfPOAUH02EsEsyZulHrNrRk0Zlg=;
        b=T2w1NicFThhwDW8Tn8ZQxxv8ORo1G094SLgtdiaiGqbj5zj6uxgQpOVF5cZAVo/dam
         KaGrVXula4E6MFXWio8vgRYJrqFsSDzck3bIGXYMzk7RLKCNwWlt3koRpV9lgHBFYmq2
         kBaJF3uaupP/W791nI0QoEw29CecycVKrQiWjgDQnDdG7xoAlGz0HzQ/BmLft2HCumfG
         rBuUGMBXb41V1nFu4AF9noaory4Fyynme+/QB4OrxvOenvcT9RAp/uEkJiHgCzg79s8R
         G68h1+UROrgapq5b3Ni3Gv9uGQu78LFCEyWf2R/wOSNBlbICftcVioU7lgikg2YK4hmi
         qdjQ==
X-Gm-Message-State: AOAM5336hMIYph7wsbYyFGmelM7S5Cw0jFFSW/cZllMUQVI9dPY+qDRN
        PqRpSvLIfodP91oak4K5FdNbjA==
X-Google-Smtp-Source: ABdhPJx+XFyBlRGxr73atAIkI35TkoH0jZGdSkHgKyPOjW84UTpgo6aICAwREfGNhD/z4eAkWLkHzA==
X-Received: by 2002:a05:6602:26c1:: with SMTP id g1mr29280827ioo.69.1641505576958;
        Thu, 06 Jan 2022 13:46:16 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n2sm2181113ioc.0.2022.01.06.13.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 13:46:16 -0800 (PST)
Date:   Thu, 6 Jan 2022 16:46:15 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: [PATCH] Properly align memory allocations and temporary buffers
Message-ID: <YddjJ+uIQM34Gedo@nand.local>
References: <20220105132324.6651-1-jrtc27@jrtc27.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220105132324.6651-1-jrtc27@jrtc27.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(+cc René as another possible reviewer)

On Wed, Jan 05, 2022 at 01:23:24PM +0000, Jessica Clarke wrote:
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
>  compat/qsort_s.c  | 11 +++++++----
>  git-compat-util.h | 11 +++++++++++
>  mem-pool.c        |  6 +++---
>  3 files changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/compat/qsort_s.c b/compat/qsort_s.c
> index 52d1f0a73d..1ccdb87451 100644
> --- a/compat/qsort_s.c
> +++ b/compat/qsort_s.c
> @@ -49,16 +49,19 @@ int git_qsort_s(void *b, size_t n, size_t s,
>  		int (*cmp)(const void *, const void *, void *), void *ctx)
>  {
>  	const size_t size = st_mult(n, s);
> -	char buf[1024];
> +	union {
> +		char buf[1024];
> +		git_max_align align;
> +	} u;

I'm not sure I understand. Clearly this union aligns buf along the width
of git_max_align. But what about the preimage makes buf unaligned?

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 5fa54a7afe..28581a45c5 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -274,6 +274,17 @@ typedef unsigned long uintptr_t;
>  #define _ALL_SOURCE 1
>  #endif
>
> +typedef union {
> +	uintmax_t max_align_uintmax;
> +	void *max_align_pointer;
> +} git_max_align;

OK, the purpose of this union is to be as wide as the least common
alignment between uintmax_t and void *, yes?

> +
> +typedef struct {
> +	char unalign;
> +	git_max_align aligned;
> +} git_max_alignment;
> +#define GIT_MAX_ALIGNMENT offsetof(git_max_alignment, aligned)

...then the offset of the aligned field within the git_max_alignment
struct is going to be that common alignment? Could you not `#define
GIT_MAX_ALIGNMENT` to be `sizeof(git_max_align)` directly, or is there
something I'm missing?

I suppose the way you wrote it here is done in order to prevent padding
on the end of the git_max_align union from artificially increasing the
value of GIT_MAX_ALIGNMENT.

In any case, I *think* what you wrote here is right. The typedef's are
uncommon to our codebase, though. I wonder how much of this is all
necessary.

Thanks,
Taylor
