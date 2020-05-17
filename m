Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA356C433DF
	for <git@archiver.kernel.org>; Sun, 17 May 2020 15:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D4332070A
	for <git@archiver.kernel.org>; Sun, 17 May 2020 15:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sMJyvY5j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgEQPob (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 11:44:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56420 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbgEQPob (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 May 2020 11:44:31 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 03C355F326;
        Sun, 17 May 2020 11:44:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aB+Cu/l7MvF0gtXzzGv6ENeL4Vo=; b=sMJyvY
        5jvDPscXNPxLJHq1HcVHHEy6Q5TD1GUSgp6/4OdZOIzZ9HbPPKALiVnC95DVxADg
        6UpP6uNSi+20jveGfV9eu3L5XBKTo9dU9OcdJQNv28y5VnerpZc/FVigzt0cq424
        NGsS65PnCfYqtMKpez0tGGDI97vdkaKLBgvbY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZDZZZmCfpVD+8Rrg/9ZUdWvMH7pTO7x3
        76gljUz3jpphXYHnIJtXPk/3M0uH5h0nXhDxs23NhShgy0CbR6JKRteZC7JYTk0V
        PIK+GPLvw+6IU70XdbaiKuCcpTcmKeJGxELzn6sx5HnfzYvdYZUovm/CRkze5rwX
        Tehb2YV5gNU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EFFA85F324;
        Sun, 17 May 2020 11:44:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7DC005F323;
        Sun, 17 May 2020 11:44:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] commit-slab-decl.h: fix define gaurds
References: <20200516172837.2872-1-abhishekkumar8222@gmail.com>
Date:   Sun, 17 May 2020 08:44:28 -0700
In-Reply-To: <20200516172837.2872-1-abhishekkumar8222@gmail.com> (Abhishek
        Kumar's message of "Sat, 16 May 2020 22:58:37 +0530")
Message-ID: <xmqqd0727ehv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4AF32824-9855-11EA-B03B-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:

That's "guard" ;-)

> commit-slab was split into commit-slab-decl and commit-slab-impl header
> files by a9f1f1f9f8 ("commit-slab.h: code split", 2018-05-19). The
> define guards for commit-slab-decl stll use "COMMIT_SLAB_HDR_H", which
> no longer matches the file name. Let's fix this.

It would have been helpful to explain that the split did not break
anything because the other half of the split started using a new and
different proprocessor macro before saying "Let's fix".

It would have been "broken" that needs "fixing" if two headers
inherited the use of the same _HDR_H preprocessor macro, of course.

The patch obviously looks good.

> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  commit-slab-decl.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/commit-slab-decl.h b/commit-slab-decl.h
> index adc7b46c83..bfbed1516a 100644
> --- a/commit-slab-decl.h
> +++ b/commit-slab-decl.h
> @@ -1,5 +1,5 @@
> -#ifndef COMMIT_SLAB_HDR_H
> -#define COMMIT_SLAB_HDR_H
> +#ifndef COMMIT_SLAB_DECL_H
> +#define COMMIT_SLAB_DECL_H
>  
>  /* allocate ~512kB at once, allowing for malloc overhead */
>  #ifndef COMMIT_SLAB_SIZE
> @@ -40,4 +40,4 @@ elemtype *slabname## _peek(struct slabname *s, const struct commit *c)
>  	declare_commit_slab(slabname, elemtype); \
>  	declare_commit_slab_prototypes(slabname, elemtype)
>  
> -#endif /* COMMIT_SLAB_HDR_H */
> +#endif /* COMMIT_SLAB_DECL_H */
