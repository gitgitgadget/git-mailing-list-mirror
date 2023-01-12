Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D39C54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 09:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239926AbjALJXV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 04:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239831AbjALJWn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 04:22:43 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A9758D2A
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 01:12:58 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id hw16so31310359ejc.10
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 01:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mTZMxRHt7k2/LptpjxWCPAylZoUi3rxuhagAdWMF2IU=;
        b=pjSi7NcdmABMHI/7MtPQJMbq3EGOMLpKjmnsJpyrZ4gmFIoA3Ondw7C7J2vZaUfr8L
         fC7LLNx4DKk1WFLuwo1TGR+rRxkjrr3E0dD2n81q8U1K5mB8YGTywec/IQbpVO0g+yD9
         dzEXm7bxV5WY8+clv65RTuX1p/7JqcPG7+fTePMs4z9oS2ba6ez8w3sNuuCCmVblemxN
         7UrcxjsGlwkPUvLwqbmA6NxCxizuVu2X1CgNiGNN0epQistTJxQ1b5O8ZogY01W9iqI+
         nlpTbwu4OlD7HT9Yyq7eXQeRwBguFAzX5SM78gNJITjSguMlHCGkASmjAOTb2Z/PSeRM
         zvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTZMxRHt7k2/LptpjxWCPAylZoUi3rxuhagAdWMF2IU=;
        b=PYprw3TDSxhmFIsCTYLvonicxqHQ588sPvHd6KOihhBZlxhHnQmrL76LGlWLddKFiG
         m7RaX/JFha6OtxTY0eONmkZ5OkvpEWaZuxS+4rQT0uK1HRi0qbwkspkwXNpw8fdTV0Ay
         zL9nBUo0/udgfOa1jdn1S/Qd+cd5tkPjCZrdHLw+q3743UJ0I32CX+czemOa/ugSrsPd
         f/olQgBu4QVqrgurOWvbsEUzp3jQ2/qcBYomppnnoeIRB4QdYhEQqUet2AvxOvseqZsB
         6HfRWt+Q1CezlkpLzwHEqVZR3y2u4SA1utIQPgfeAfDOHHQBjmghfpiJYV5iPgZ6Eph/
         vT8g==
X-Gm-Message-State: AFqh2kqCRdAmu6iSazYtIsuanx6wbxTFK3mEq/h52uvudp8dWmekNAUU
        kKKUfB63Ss3iGLN1pNR5n+M=
X-Google-Smtp-Source: AMrXdXsxqKxN8AEBKvCOXAZE+gx2FmwWrLT+fIfUZ5RXwfvR1SkAKWoVWc8z2oZfFVqX1JxkOsb5gg==
X-Received: by 2002:a17:906:a1c5:b0:7c1:2529:b25e with SMTP id bx5-20020a170906a1c500b007c12529b25emr62874426ejb.43.1673514776953;
        Thu, 12 Jan 2023 01:12:56 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id kx1-20020a170907774100b0084d368b1628sm6077966ejc.40.2023.01.12.01.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 01:12:56 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pFtdo-0005Qp-0J;
        Thu, 12 Jan 2023 10:12:56 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 5/5] packfile: inline custom read_object()
Date:   Thu, 12 Jan 2023 10:01:28 +0100
References: <Y7l4LsEQcDT9HZ21@coredump.intra.peff.net>
 <Y7l4vQwRZzGtxlBB@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <Y7l4vQwRZzGtxlBB@coredump.intra.peff.net>
Message-ID: <230112.86o7r42k13.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jan 07 2023, Jeff King wrote:

> When the pack code was split into its own file[1], it got a copy of the
> static read_object() function. But there's only one caller here, so we
> could just inline it. And it's worth doing so, as the name read_object()
> invites comparisons to the public read_object_file(), but the two don't
> behave quite the same.
>
> [1] The move happened over several commits, but the relevant one here is
>     f1d8130be0 (pack: move clear_delta_base_cache(), packed_object_info(),
>     unpack_entry(), 2017-08-18).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  packfile.c | 26 +++++++++-----------------
>  1 file changed, 9 insertions(+), 17 deletions(-)
>
> diff --git a/packfile.c b/packfile.c
> index c0d7dd93f4..79e21ab18e 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1650,22 +1650,6 @@ struct unpack_entry_stack_ent {
>  	unsigned long size;
>  };
>  
> -static void *read_object(struct repository *r,
> -			 const struct object_id *oid,
> -			 enum object_type *type,
> -			 unsigned long *size)
> -{
> -	struct object_info oi = OBJECT_INFO_INIT;
> -	void *content;
> -	oi.typep = type;
> -	oi.sizep = size;
> -	oi.contentp = &content;
> -
> -	if (oid_object_info_extended(r, oid, &oi, 0) < 0)
> -		return NULL;
> -	return content;
> -}
> -
>  void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
>  		   enum object_type *final_type, unsigned long *final_size)
>  {
> @@ -1798,14 +1782,22 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
>  			uint32_t pos;
>  			struct object_id base_oid;
>  			if (!(offset_to_pack_pos(p, obj_offset, &pos))) {
> +				struct object_info oi = OBJECT_INFO_INIT;
> +
>  				nth_packed_object_id(&base_oid, p,
>  						     pack_pos_to_index(p, pos));
>  				error("failed to read delta base object %s"
>  				      " at offset %"PRIuMAX" from %s",
>  				      oid_to_hex(&base_oid), (uintmax_t)obj_offset,
>  				      p->pack_name);
>  				mark_bad_packed_object(p, &base_oid);
> -				base = read_object(r, &base_oid, &type, &base_size);
> +
> +				oi.typep = &type;
> +				oi.sizep = &base_size;
> +				oi.contentp = &base;
> +				if (oid_object_info_extended(r, &base_oid, &oi, 0) < 0)
> +					base = NULL;
> +
>  				external_base = base;
>  			}
>  		}

This isn't introducing a behavior difference, in fact it's diligently
bending over backwards to preserve existing behavior, but I don't think
we need to do so, and shouldn't have this "base = NULL" line.

Here we're within an "if" block where we tested that "base == NULL"
(which is why we're trying to populate it)

Before when we had read_object() re-assigning to "base" here was the
obvious thing to do, but now this seems like undue an incomplete
paranoia.

If oid_object_info_extended() why can't we trust that it didn't touch
our "base"? And if we can't trust that, why are we trusting that it left
"type" and "base_size" untouched?

I think squashing this in would be much better:
	
	diff --git a/packfile.c b/packfile.c
	index 79e21ab18e7..f45017422a1 100644
	--- a/packfile.c
	+++ b/packfile.c
	@@ -1795,10 +1795,8 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
	 				oi.typep = &type;
	 				oi.sizep = &base_size;
	 				oi.contentp = &base;
	-				if (oid_object_info_extended(r, &base_oid, &oi, 0) < 0)
	-					base = NULL;
	-
	-				external_base = base;
	+				if (!oid_object_info_extended(r, &base_oid, &oi, 0))
	+					external_base = base;
	 			}
	 		}

Not only aren't we second-guessing that our "base" was left alone, we're
using the return value of oid_object_info_extended() to guard that
assignment to "external_base" instead (it's NULL at this point too).




