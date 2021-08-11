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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F61BC4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 21:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F21CB6101E
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 21:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhHKVvO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 17:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhHKVvN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 17:51:13 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A647AC061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 14:50:49 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so11857815pjn.4
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 14:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qLO+yraifaZarS4hy2ZApGiO92i5UakzPCYbUALAoWc=;
        b=t9yZSfR4Odtnt1HZ4pSYqnJCuVKKKQLLAJu2YN2gWUYe88g3ZDMAfL7K2h3zSNi5oC
         PIyEut5J+CH3liJMFsDQy2tAavzvaM2ajzn34xGz8Ro/xcjXau/xOh6de92yI6M8lkYp
         2IBDPxvyTmE50OCd2x2x5vLDQ53zWtaaO9O5VwsxZa1L1adhmaAZ60tUUY50dYRB8TWs
         YKJHETHj9lW2o1ERWnoC6NbylRqIb3T7ZGbzBRGiu+6V7RcHP8a3Mg76cCY0kL7zoKJ4
         67SlCpD5zyrTVofzZx2DS4ipFUzfQK1eSIB1as5oUWP3qZyfU6xwpZywQ4ZfOsG3PqPi
         qEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qLO+yraifaZarS4hy2ZApGiO92i5UakzPCYbUALAoWc=;
        b=hyLEMAgPulzZlio3FVL2uNcroKtG0cBzDoBnUp/AA/7XQpoOT3/QpNElmHfBjK607f
         HvCfrJa5NTw8HwGchFm7xdMEsnJdS/HYTyEdGku5BCLGn3zYMikBTtpcHj/HCkg2anHn
         0g5soztjzEhZPoI6ugD57IZZ4jM6ETZD5xZqKLEDmPZbmfxppOKmMCPq4occfgINy9SK
         A5wQmdsDUybi0WGD9Uq/qfZN8HjADwr1hZApZ0Yaah7PbzCrXMiSrNoY6jbuM+kWAvgB
         bUiIH9nO1BrAt0FBE0rxMHjpQp8AFHBsAV34h27oxyHQI9DU5L5S5Cx/1jwABDhuIwGp
         dQDg==
X-Gm-Message-State: AOAM532pCyh0MwdDPuFMneRiTA8p4+ssgxQV2H/CWXsmWUyqaoTKO65Z
        XH6fQYK3+/eMBaXZliqyQNuW6193cCSBNg==
X-Google-Smtp-Source: ABdhPJz718P4N+9fS5QkP9FvDy9VHMUHug6AV77CugD8SO3O2aM9MelkekeKwqPc4dNGjEhSyqMPhw==
X-Received: by 2002:a17:90a:7d11:: with SMTP id g17mr699813pjl.150.1628718648908;
        Wed, 11 Aug 2021 14:50:48 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:1377:1116:63ab:bf4b])
        by smtp.gmail.com with ESMTPSA id 186sm576880pfg.11.2021.08.11.14.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 14:50:47 -0700 (PDT)
Date:   Wed, 11 Aug 2021 14:50:32 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/7] grep: allocate subrepos on heap
Message-ID: <YRRGKKYYQiYTxtJ5@google.com>
References: <cover.1628618950.git.jonathantanmy@google.com>
 <f62608e88f125096c1f236a47e3ee670104c7b78.1628618950.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f62608e88f125096c1f236a47e3ee670104c7b78.1628618950.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 10, 2021 at 11:28:43AM -0700, Jonathan Tan wrote:
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 9e61c7c993..5a40e18e47 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -65,6 +65,9 @@ static int todo_done;
>  /* Has all work items been added? */
>  static int all_work_added;
>  
> +static struct repository **repos_to_free;
> +static size_t repos_to_free_nr, repos_to_free_alloc;

One thing I was curious about was whether it would make more sense to
use an existing utility library in Git to handle this. But I think we
kind of are, since ALLOC_GROW is used, so this is idiomatic for Git
project. Ok, fine, I guess this is life at C ;)

> +
>  /* This lock protects all the variables above. */
>  static pthread_mutex_t grep_mutex;
>  
> @@ -168,6 +171,17 @@ static void work_done(struct work_item *w)
>  	grep_unlock();
>  }
>  
> +static void free_repos(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < repos_to_free_nr; i++) {
> +		repo_clear(repos_to_free[i]);
> +		free(repos_to_free[i]);
> +	}
> +	free(repos_to_free);
> +}

Should repos_to_free_nr be reset here? I guess it doesn't make sense to,
since we'd be trying to use-after-free the initial repos_to_free head
pointer too if we wanted to reuse this array.

> +
>  static void *run(void *arg)
>  {
>  	int hit = 0;
> @@ -415,19 +429,24 @@ static int grep_submodule(struct grep_opt *opt,
>  			  const struct object_id *oid,
>  			  const char *filename, const char *path, int cached)
>  {
> -	struct repository subrepo;
> +	struct repository *subrepo;
>  	struct repository *superproject = opt->repo;
>  	const struct submodule *sub;
>  	struct grep_opt subopt;
> -	int hit;
> +	int hit = 0;
>  
>  	sub = submodule_from_path(superproject, null_oid(), path);
>  
>  	if (!is_submodule_active(superproject, path))
>  		return 0;
>  
> -	if (repo_submodule_init(&subrepo, superproject, sub))
> +	subrepo = xmalloc(sizeof(*subrepo));
> +	if (repo_submodule_init(subrepo, superproject, sub)) {
> +		free(subrepo);
>  		return 0;
> +	}
> +	ALLOC_GROW(repos_to_free, repos_to_free_nr + 1, repos_to_free_alloc);
> +	repos_to_free[repos_to_free_nr++] = subrepo;

Is this the only place we add to the repos_to_free array? It looks like
yes, so I guess this doesn't need a helper.

>  
>  	/*
>  	 * NEEDSWORK: repo_read_gitmodules() might call
> @@ -438,7 +457,7 @@ static int grep_submodule(struct grep_opt *opt,
>  	 * subrepo's odbs to the in-memory alternates list.
>  	 */
>  	obj_read_lock();
> -	repo_read_gitmodules(&subrepo, 0);
> +	repo_read_gitmodules(subrepo, 0);
>  
>  	/*
>  	 * NEEDSWORK: This adds the submodule's object directory to the list of
> @@ -450,11 +469,11 @@ static int grep_submodule(struct grep_opt *opt,
>  	 * store is no longer global and instead is a member of the repository
>  	 * object.
>  	 */
> -	add_submodule_odb_by_path(subrepo.objects->odb->path);
> +	add_submodule_odb_by_path(subrepo->objects->odb->path);
>  	obj_read_unlock();
>  
>  	memcpy(&subopt, opt, sizeof(subopt));
> -	subopt.repo = &subrepo;
> +	subopt.repo = subrepo;
>  
>  	if (oid) {
>  		enum object_type object_type;
> @@ -464,9 +483,9 @@ static int grep_submodule(struct grep_opt *opt,
>  		struct strbuf base = STRBUF_INIT;
>  
>  		obj_read_lock();
> -		object_type = oid_object_info(&subrepo, oid, NULL);
> +		object_type = oid_object_info(subrepo, oid, NULL);
>  		obj_read_unlock();
> -		data = read_object_with_reference(&subrepo,
> +		data = read_object_with_reference(subrepo,
>  						  oid, tree_type,
>  						  &size, NULL);
>  		if (!data)
> @@ -484,7 +503,6 @@ static int grep_submodule(struct grep_opt *opt,
>  		hit = grep_cache(&subopt, pathspec, cached);
>  	}
>  
> -	repo_clear(&subrepo);
>  	return hit;
>  }
>  
> @@ -1182,5 +1200,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  		run_pager(&opt, prefix);
>  	clear_pathspec(&pathspec);
>  	free_grep_patterns(&opt);
> +	free_repos();
>  	return !hit;
>  }

The rest of the diff seems to be a pretty clear object-becomes-reference
conversion, so...

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
