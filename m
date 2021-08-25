Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5800CC432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C642604DB
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbhHYX7g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 19:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbhHYX7g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 19:59:36 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1DEC061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:58:49 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id h9so2098336ejs.4
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=8PtVe85VLUyInLvu0Lfl5JGXLhcmRmkFzw9VqCGE5ek=;
        b=BlnWbxjAtB09ywgUgfZYvdPD0c6882/ftz1Jczsx0hzNnd3ofEw6YdGfDtkIbQ7I2u
         HJvByYLBtYWZ+1SwLulYvumfEe5ks0tBC/1av7P/fPeqlS8aXBw206Qsh7A9lulv/T2o
         E5N5AqzEDzpvhy9ncW2BJXZUuu6toyXvSvHEpDCT7kquZr+ODGGbF/a1TPriAynIDg+C
         H/ITORKXabT3Re7BXyXyYr1tK7l21NDThN0MX3fwU3eMgh++1pj/kS2HjX+2Qu+XU/MQ
         FjWdW59bm/1BKgeK5sogOxFO35D8no/bM5AjFig3a3soEanwkgBFVMyM+gUGop4sI8u2
         jWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=8PtVe85VLUyInLvu0Lfl5JGXLhcmRmkFzw9VqCGE5ek=;
        b=Ba4ay277LT0N++KP+gmV899U7e3VNgSbLkb+QlzJB530O7KbX/4dJ60hZxTOGl03dN
         mxbHZFoguqWw5j/RayXXVUTCErbtKQ2cEkFvDuAHP2LBmnsTRo0/V0Hwh1o3HSKaOO1R
         PAtK/0+5D/nMUNaNtPDER0cE3RXagAqvaWmIy+OlJlqSIq8eQSlC8jBIDbkQBbWeTzkZ
         y88ot+VvotmPqDAnn3bU1dZiTWbkdqaYH5gEVixaTllHuFAH9EyoF45WyEkCcvkgVNel
         Fxe+LzLPKaVm9/0IQPtD4J7X3G4e371/gO2dt/fJUvUIAj8Pi45eaUTF4yNTzAxU4Su0
         r75w==
X-Gm-Message-State: AOAM532nl4+Np6sl28eopCiovZBcnJBYKwdRtYMCzPeaqVLMsddgLB+R
        47Jx/Cvd8DfDd4KQq+f6Od4=
X-Google-Smtp-Source: ABdhPJyfLXba464z3r7NiILri329auWRUkVHphG3hinrgwfphbdbH7EuzFp6B8rWW4KhZh1CyKTyMQ==
X-Received: by 2002:a17:907:3f91:: with SMTP id hr17mr1225835ejc.496.1629935928141;
        Wed, 25 Aug 2021 16:58:48 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k12sm723928edq.59.2021.08.25.16.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 16:58:47 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: [PATCH v5 09/14] commit.h: add wrapped tags in commit struct
Date:   Thu, 26 Aug 2021 01:58:23 +0200
References: <cover.1629805395.git.dyroneteng@gmail.com>
 <011e5eaea3f48eeacac1614f769e8fd809e0c093.1629805396.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <011e5eaea3f48eeacac1614f769e8fd809e0c093.1629805396.git.dyroneteng@gmail.com>
Message-ID: <87wno9axfs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 25 2021, Teng Long wrote:

> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  commit.h   | 5 +++++
>  revision.c | 8 ++++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/commit.h b/commit.h
> index df42eb434f..1e99e9ae8a 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -38,6 +38,11 @@ struct commit {
>  	 */
>  	struct tree *maybe_tree;
>  	unsigned int index;
> +	/*
> +	* wrapped tags or NULL.  If the commit is peeled from tag(s),
> +	* then save the wraps, otherwise will be NULL.
> +	*/
> +	struct object_list *wraps;
>  };
>  
>  extern int save_commit_buffer;
> diff --git a/revision.c b/revision.c
> index 65e0926d25..aecf493f46 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -416,14 +416,17 @@ static struct commit *handle_commit(struct rev_info *revs,
>  	const char *path = entry->path;
>  	unsigned int mode = entry->mode;
>  	unsigned long flags = object->flags;
> -
> +	struct object_list *wraps = NULL;
>  	/*
>  	 * Tag object? Look what it points to..
>  	 */
>  	while (object->type == OBJ_TAG) {
>  		struct tag *tag = (struct tag *) object;
> -		if (revs->tag_objects && !(flags & UNINTERESTING))
> +		if (revs->tag_objects && !(flags & UNINTERESTING)) {
> +			object_list_insert(object, &wraps);
>  			add_pending_object(revs, object, tag->tag);
> +		}
> +
>  		object = parse_object(revs->repo, get_tagged_oid(tag));
>  		if (!object) {
>  			if (revs->ignore_missing_links || (flags & UNINTERESTING))
> @@ -449,6 +452,7 @@ static struct commit *handle_commit(struct rev_info *revs,
>  	 */
>  	if (object->type == OBJ_COMMIT) {
>  		struct commit *commit = (struct commit *)object;
> +		commit->wraps = wraps;
>  
>  		if (repo_parse_commit(revs->repo, commit) < 0)
>  			die("unable to parse commit %s", name);

Can't we store this info on the side between these two static functions
somehow, instead of adding this "wraps" to all commit structs?
