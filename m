Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8714C35242
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 00:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F202207FF
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 00:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Nx0Pu8eq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbgBOAPy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:15:54 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51924 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgBOAPy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 19:15:54 -0500
Received: by mail-pj1-f68.google.com with SMTP id fa20so4517240pjb.1
        for <git@vger.kernel.org>; Fri, 14 Feb 2020 16:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c2drQC6LZjfpf7JWJyX/8Ct3jl8o6bQoeWyf7VYcpGg=;
        b=Nx0Pu8eq8pGhA9wxzCV8BvQYIN4Pt0Fv1Bagi/wbMgpxSDVrAlu1VQha0OtuKJY/SB
         q7irSodHnWKFZB3/n+xVl0cxc4p1nKFQ5FUNSYtVjugjH70+PCuygkC+qbNpjmhGe2HO
         62CX2oISAmrqV3Y6r1zcfnUaNJV2vnFMJ4jE7V2IA23rLL7bTpi291w81hRA1QfBLtui
         EN36RteUfCFjO4t4+J0pR6yfqqF/8aDwTLhqjo4qt9+NAfGEKfE2w+jm+uUpqszAoGpe
         /oShr3EdWmTrnbbjrjMKM0nwiS6nuCWHpPDAFfiuKsBLoYk0uDO8m39IFOKd+bON83h4
         neBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c2drQC6LZjfpf7JWJyX/8Ct3jl8o6bQoeWyf7VYcpGg=;
        b=YEhH0hXhOQ5U7Idygq/NvfDzcfpX6YvRpj2DUIG4AbH+IWJvDvcG2EPSlKoEyhtsPr
         5uJ3JGtwsQzDEOOAij0VRSN1ZvMWuhATxmRHzYm4mC3NGzYjJsKnnnzg8dIrG+rlbcVQ
         Om/5xjrVjTuzoi2HvmnRWCHtsmuCuWToil3ZEGQExWuVVtZCQNMhrSv2o85Bh0mFC8J/
         ie8io7E/fI428U5/aUkZMynXzz9l09v2xV5USjdTbgc4J+jovkIkKXG8L2CZ/kJJHfrv
         drlqK9tf9MhiqxO9Vun71NL1fniMYVxokBWupYQNYTfY/0hzkviuIy03CxGan3/fDVzV
         Pb6g==
X-Gm-Message-State: APjAAAV5ACKZuXkUj8Yt7zE6DgRSh/P/n9co3Kc1NYTjmas/GOMVhAhN
        2gyPGadD1HngHtya1LvduHUvVsD6/lQ9Jw==
X-Google-Smtp-Source: APXvYqyC6vOJoLtvGdosMojjXjchfNW7T3RB/UGZbHhXuGIfaKCrBJ0Dcv1Yuh+su2Tgy50rkmjVRg==
X-Received: by 2002:a17:90b:46cf:: with SMTP id jx15mr6876163pjb.2.1581725753676;
        Fri, 14 Feb 2020 16:15:53 -0800 (PST)
Received: from localhost ([2600:100f:b02c:92d4:11e2:3a54:273f:b5fe])
        by smtp.gmail.com with ESMTPSA id 5sm8348532pfx.163.2020.02.14.16.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 16:15:53 -0800 (PST)
Date:   Fri, 14 Feb 2020 16:15:52 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/15] pack-bitmap: fix leak of haves/wants object
 lists
Message-ID: <20200215001552.GE11400@syl.local>
References: <20200214182147.GA654525@coredump.intra.peff.net>
 <20200214182211.GB150965@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200214182211.GB150965@coredump.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 14, 2020 at 01:22:11PM -0500, Jeff King wrote:
> When we do a bitmap-aware revision traversal, we create an object_list
> for each of the "haves" and "wants" tips. After creating the result
> bitmaps these are no longer needed or used, but we never free the list
> memory.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  object.c      | 9 +++++++++
>  object.h      | 2 ++
>  pack-bitmap.c | 5 +++++
>  3 files changed, 16 insertions(+)
>
> diff --git a/object.c b/object.c
> index 142ef69399..4d11949b38 100644
> --- a/object.c
> +++ b/object.c
> @@ -307,6 +307,15 @@ int object_list_contains(struct object_list *list, struct object *obj)
>  	return 0;
>  }
>
> +void object_list_free(struct object_list **list)
> +{
> +	while (*list) {
> +		struct object_list *p = *list;
> +		*list = p->next;
> +		free(p);
> +	}
> +}

Hmm. I was going to write a comment saying more-or-less, "I think I'm
nitpicking here, but I'm not crazy about this as a 'while' loop". But,
when I wrote this as a 'for' loop instead, I wrote a use-after-free, and
then when I rid the code of that, it wasn't any more readable than the
version above.

>  /*
>   * A zero-length string to which object_array_entry::name can be
>   * initialized without requiring a malloc/free.
> diff --git a/object.h b/object.h
> index 25f5ab3d54..2dbabfca0a 100644
> --- a/object.h
> +++ b/object.h
> @@ -151,6 +151,8 @@ struct object_list *object_list_insert(struct object *item,
>
>  int object_list_contains(struct object_list *list, struct object *obj);
>
> +void object_list_free(struct object_list **list);
> +
>  /* Object array handling .. */
>  void add_object_array(struct object *obj, const char *name, struct object_array *array);
>  void add_object_array_with_path(struct object *obj, const char *name, struct object_array *array, unsigned mode, const char *path);
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 9ca356ee29..6c06099dc7 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -787,10 +787,15 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs)
>  	bitmap_git->result = wants_bitmap;
>  	bitmap_git->haves = haves_bitmap;
>
> +	object_list_free(&wants);
> +	object_list_free(&haves);
> +

Makes sense.

>  	return bitmap_git;
>
>  cleanup:
>  	free_bitmap_index(bitmap_git);
> +	object_list_free(&wants);
> +	object_list_free(&haves);

Ditto.

>  	return NULL;
>  }
>
> --
> 2.25.0.796.gcc29325708

Thanks,
Taylor
