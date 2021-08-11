Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98747C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 21:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CCB960724
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 21:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhHKVpT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 17:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbhHKVpP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 17:45:15 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF5BC061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 14:44:51 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id oa17so5790288pjb.1
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 14:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xmyiHH9AV1ZDrh0nXZpNS5WfnmTHMv2s33SZiVX3O5w=;
        b=mcYTRIPc1w5hSE9WUUgWtt9neD8hEqh82GeGeEZJGelYcVoIO0/dT8rPRWT1JL58oO
         XkaxsKTSaTRirqHNf8nIZ1JK9Ika3X2OxbN/aAcqwDjMq4RK3Z+fp79JJWsJUhL42I59
         dmvDJFwlE09PR6/gOA6aQKDrhaoEbR5QU6PiLWtA40VUj8ChP9HDr46jF7UDCwHPPYtQ
         3H8hxLYheYBovFVa4F6pjReM5bcQyaKDQK9sqmtkUyNAcAZ5fF9T2i1fpwTCqJ3TclJM
         Msn3NAm4SpnFSFegxZFMMRdAm8nRX8VAqw4s/cJWYT73wxG8eVqwJpFiQNr788FMZsPG
         w80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xmyiHH9AV1ZDrh0nXZpNS5WfnmTHMv2s33SZiVX3O5w=;
        b=kZgRzYHYQ7S82OEiLoFpxWJ0LYI1LWTjEXXyDBaahe2qFF6i8JUh4cgG5vlnPaWmzg
         6JjBewi/T0hHbbv3RtDg0I5eNby+H3XGiQlWxAHqO36kZ40lY5VI3DEXf4GvXs17sayo
         aynBG8Fh6pKuvE6ZUyY+xn2wf0WD3F0H7VxFe1L4IZGMcqUrj2ryk3J0OpLyakSuzz4z
         x2m0X2as97fGEolbp+h3HFutNOSPPfg3YXTVxwe9yrLHTp7NQOjDUrdcIaoQ0mgwzItb
         /LwRGeh3zo/CKzioXTwMlIrguD1JAE8WYwiIifVf2Qb+5O99vQETUC83pDNLNd4YD/6E
         ZQeQ==
X-Gm-Message-State: AOAM533g875672Wbamno3vf3+x+mnt0GJ8/L0N+pebb0BTASArhchCIY
        DU8+BX5KA6inVRbmxoJpNrg1ew==
X-Google-Smtp-Source: ABdhPJw1Ugoyc8E2xIDKp9M9GIyScYr0dPatG/j8oUYvSfnKBYjyCxnJEdk1BgSkGVCvpUsaMRRC+A==
X-Received: by 2002:a62:648c:0:b029:3e0:80dd:9b9e with SMTP id y134-20020a62648c0000b02903e080dd9b9emr182730pfb.10.1628718290795;
        Wed, 11 Aug 2021 14:44:50 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:1377:1116:63ab:bf4b])
        by smtp.gmail.com with ESMTPSA id mr18sm414361pjb.39.2021.08.11.14.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 14:44:50 -0700 (PDT)
Date:   Wed, 11 Aug 2021 14:44:42 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/7] grep: read submodule entry with explicit repo
Message-ID: <YRREyrAXBmxVoxRr@google.com>
References: <cover.1628618950.git.jonathantanmy@google.com>
 <30ead880b38c5f572e609554b075ef81ff80ad87.1628618950.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30ead880b38c5f572e609554b075ef81ff80ad87.1628618950.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 10, 2021 at 11:28:42AM -0700, Jonathan Tan wrote:
> 
> Replace an existing parse_object_or_die() call (which implicitly works
> on the_repository) with a function call that allows a repository to be
> passed in. There is no such direct equivalent to parse_object_or_die(),
> but we only need the type of the object, so replace with
> oid_object_info().

Always exciting to see less implicit use of the_repository ;)

> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/grep.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/builtin/grep.c b/builtin/grep.c
> index e454335e9d..9e61c7c993 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -457,27 +457,27 @@ static int grep_submodule(struct grep_opt *opt,
>  	subopt.repo = &subrepo;
>  
>  	if (oid) {
> -		struct object *object;
> +		enum object_type object_type;
>  		struct tree_desc tree;
>  		void *data;
>  		unsigned long size;
>  		struct strbuf base = STRBUF_INIT;
>  
>  		obj_read_lock();
> -		object = parse_object_or_die(oid, NULL);
> +		object_type = oid_object_info(&subrepo, oid, NULL);

One thing I wonder is whether we are missing out on some error
conditions we used to get with parse_object_or_die() by using
oid_object_info() instead. Do we need to be more defensive in
investigating 'oid' before calling that helper, now?

>  		obj_read_unlock();
>  		data = read_object_with_reference(&subrepo,
> -						  &object->oid, tree_type,
> +						  oid, tree_type,

And a handful of instances where we were using object->oid instead of
the oid we were already passed. Ok.

>  						  &size, NULL);
>  		if (!data)
> -			die(_("unable to read tree (%s)"), oid_to_hex(&object->oid));
> +			die(_("unable to read tree (%s)"), oid_to_hex(oid));
>  
>  		strbuf_addstr(&base, filename);
>  		strbuf_addch(&base, '/');
>  
>  		init_tree_desc(&tree, data, size);
>  		hit = grep_tree(&subopt, pathspec, &tree, &base, base.len,
> -				object->type == OBJ_COMMIT);
> +				object_type == OBJ_COMMIT);

And finally, using the type we got from oid_object_info instead. Ok.

>  		strbuf_release(&base);
>  		free(data);
>  	} else {
> -- 
> 2.33.0.rc1.237.g0d66db33f3-goog
> 

LGTM. Thanks.

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
