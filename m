Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2794EC433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 13:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiKGN2E (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 08:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiKGN2D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 08:28:03 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B1E1C93F
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 05:28:01 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id b2so30073778eja.6
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 05:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=42ouPVWs9hRS+OgXQHlh8nqOOy5wRTM/LCC2o2HYHP0=;
        b=hCrYGa/PRLxepK5eM2oZCYIScK0lYFN+i2gV/PkB1kS3cwz3BR085dONCWU4ELjBEF
         Amlg1xdUHBJnjH/4B+YYfyvoAb2qyOfMPgpdJpTWzDd4IYMp8n91TohQaReu1PijoPS7
         0HR1F+c5IO9B1jnpKmbhmyphQoX60QhcqWrzfmXj0wVZH3PSoJa71DX3L72qhktCvpVv
         eJMbfb6GYhAujBC/j7MM3Wo91bQGjHOFuWFMd636DHMbl7vKWfjX+OMmJcJJzsKuXZ0w
         NUWuSRE2bElW/M6Yk4lcUbsCESw8iFMwxWfj+fh2K4h5mdu/Jzp0tOmw7VtCY89oeDFb
         +QRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42ouPVWs9hRS+OgXQHlh8nqOOy5wRTM/LCC2o2HYHP0=;
        b=0lPY4SMTSuUiG06ctDwn9by9Vthu39d9+bzaFySTM35jU7AfqT/wjyfbm9LGmoLc44
         3Ie+Kwdl7901jkJbiNYInXNjbKVywYgk72pL3X67O++A0dLKGL4UrCeghkgAaueiOKxE
         p2qSH+/5YRobvlJczhLoc/YXEDw+FJmh7orjwtO43N6JOL99yUwobV8inJFRJtm2Sfpq
         BWb6wnWxqGzBaAWkEjYvBRqZ99s2fkiNboX0nI23miJDPtKy9DCAqpNK02h5tU/3N+e+
         ID0NKEpagQTsp43m2eShjED1D8PyN8Wg2gow3ToY2HAiD8Lqx5tIuSlzG/j1ZOKbogyr
         4IVA==
X-Gm-Message-State: ACrzQf3FCAF4f9IWyscJJAZUspsFAX2XX5H4MVdt2GIvJ9MR8ET9p+dv
        3fqUDMY3DacTjTEJV1T9tZ0=
X-Google-Smtp-Source: AMsMyM6ctQuqT4WOJ+756iR+UMU15ODuq7hEXxUP8Iob6XYDTNUt1aa/Br+bHev+NdILyCPrdkPCDA==
X-Received: by 2002:a17:907:6e29:b0:7ad:d7f7:c924 with SMTP id sd41-20020a1709076e2900b007add7f7c924mr38660866ejc.749.1667827679262;
        Mon, 07 Nov 2022 05:27:59 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id f1-20020a05640214c100b00461816beef9sm4203457edx.14.2022.11.07.05.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 05:27:58 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1os2AP-0004ru-2b;
        Mon, 07 Nov 2022 14:27:57 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/6] revision: introduce struct to handle exclusions
Date:   Mon, 07 Nov 2022 13:51:51 +0100
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667823042.git.ps@pks.im>
 <2a6a67df1d470bf790025d55095c237ddc6a6bd6.1667823042.git.ps@pks.im>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <2a6a67df1d470bf790025d55095c237ddc6a6bd6.1667823042.git.ps@pks.im>
Message-ID: <221107.86tu3ax5b6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 07 2022, Patrick Steinhardt wrote:

> [[PGP Signed Part:Undecided]]
> The functions that handle exclusion of refs work on a single string
> list. We're about to add a second mechanism for excluding refs though,
> and it makes sense to reuse much of the same architecture for both kinds
> of exclusion.
>
> Introduce a new `struct ref_exclusions` that encapsulates all the logic
> related to excluding refs.

I think it's a good change, but probably worth mentioning tha we're
moving the "excluded_refs" from being malloc'd to the "struct
string_list" being embedded in this new "struct ref_exclusions".

That change isn't necessary for hoisting it into a container struct, but
does make things nicer down the line.

>  	struct string_list_item *item;
> -
> -	if (!ref_excludes)
> -		return 0;
> -	for_each_string_list_item(item, ref_excludes) {
> +	for_each_string_list_item(item, &exclusions->excluded_refs) {
>  		if (!wildmatch(item->string, path, 0))
>  			return 1;

E.g. because here we don't care about the distinction between NULL and
!list->nr anymore, it *does* matter in some cases, but it's always nice
to be able to clearly distinguish the cases where we don't, such as this
one....

> -void clear_ref_exclusion(struct string_list **ref_excludes_p)
> +void init_ref_exclusions(struct ref_exclusions *exclusions)
>  {
> -	if (*ref_excludes_p) {
> -		string_list_clear(*ref_excludes_p, 0);
> -		free(*ref_excludes_p);
> -	}
> -	*ref_excludes_p = NULL;

...and this becomes much nicer.

Aside: There's some churn, and this diff is worse for the
rename-while-at-it of "clear_ref_exclusion" to "add_ref_exclusion", but
that's probably worth it to have the macro match the struct name etc.

> +	string_list_init_dup(&exclusions->excluded_refs);

Okey, so this is partly my fault for not following up on f196c1e908d
(revisions API users: use release_revisions() needing REV_INFO_INIT,
2022-04-13) :); But here:

If we keep this *_init() function don't duplicate what you're adding to
the macro, just init this in terms of the macro. See the two-line
examples in:

	git grep -W memcpy.*blank

But here (and this is the part that's mostly me) as we don't malloc this
anymore you're only needing to keep this init function for
repo_init_revisions().

So, probably too big a digression for a "while at it", but FWIW this on
top of your topic would do:
	
	 revision.c | 10 ++--------
	 revision.h | 10 +++++++---
	 2 files changed, 9 insertions(+), 11 deletions(-)
	
	diff --git a/revision.c b/revision.c
	index 45652f9b0bb..cf352d1fa43 100644
	--- a/revision.c
	+++ b/revision.c
	@@ -1534,12 +1534,6 @@ int ref_excluded(const struct ref_exclusions *exclusions, const char *path)
	 	return 0;
	 }
	 
	-void init_ref_exclusions(struct ref_exclusions *exclusions)
	-{
	-	string_list_init_dup(&exclusions->excluded_refs);
	-	string_list_init_dup(&exclusions->hidden_refs);
	-}
	-
	 void clear_ref_exclusions(struct ref_exclusions *exclusions)
	 {
	 	string_list_clear(&exclusions->excluded_refs, 0);
	@@ -1897,7 +1891,8 @@ void repo_init_revisions(struct repository *r,
	 			 struct rev_info *revs,
	 			 const char *prefix)
	 {
	-	memset(revs, 0, sizeof(*revs));
	+	struct rev_info blank = REV_INFO_INIT;
	+	memcpy(revs, &blank, sizeof(*revs));
	 
	 	revs->repo = r;
	 	revs->abbrev = DEFAULT_ABBREV;
	@@ -1933,7 +1928,6 @@ void repo_init_revisions(struct repository *r,
	 
	 	init_display_notes(&revs->notes_opt);
	 	list_objects_filter_init(&revs->filter);
	-	init_ref_exclusions(&revs->ref_excludes);
	 }
	 
	 static void add_pending_commit_list(struct rev_info *revs,
	diff --git a/revision.h b/revision.h
	index fef5e063d16..75b8ecc307b 100644
	--- a/revision.h
	+++ b/revision.h
	@@ -94,6 +94,10 @@ struct ref_exclusions {
	 	 */
	 	struct string_list hidden_refs;
	 };
	+#define REF_EXCLUSIONS_INIT { \
	+	.excluded_refs = STRING_LIST_INIT_DUP, \
	+	.hidden_refs = STRING_LIST_INIT_DUP, \
	+}
	 
	 struct oidset;
	 struct topo_walk_info;
	@@ -371,7 +375,9 @@ struct rev_info {
	  * called before release_revisions() the "struct rev_info" can be left
	  * uninitialized.
	  */
	-#define REV_INFO_INIT { 0 }
	+#define REV_INFO_INIT { \
	+	.ref_excludes = REF_EXCLUSIONS_INIT, \
	+}
	 
	 /**
	  * Initialize a rev_info structure with default values. The third parameter may
	@@ -455,10 +461,8 @@ void show_object_with_name(FILE *, struct object *, const char *);
	 /**
	  * Helpers to check if a reference should be excluded.
	  */
	-#define REF_EXCLUSIONS_INIT { .excluded_refs = STRING_LIST_INIT_DUP, .hidden_refs = STRING_LIST_INIT_DUP }
	 
	 int ref_excluded(const struct ref_exclusions *exclusions, const char *path);
	-void init_ref_exclusions(struct ref_exclusions *);
	 void clear_ref_exclusions(struct ref_exclusions *);
	 void add_ref_exclusion(struct ref_exclusions *, const char *exclude);
	 void exclude_hidden_refs(struct ref_exclusions *, const char *section);

But I'll submit that cleanup seperately, but for now let's not duplicate
your REF_EXCLUSIONS_INIT macro here in init_ref_exclusions(), just have
the function do what the macro is doing, now that we don't need the
malloc.

> -void add_ref_exclusion(struct string_list **ref_excludes_p, const char *exclude)
> +void clear_ref_exclusions(struct ref_exclusions *exclusions)
>  {
> -	if (!*ref_excludes_p) {
> -		CALLOC_ARRAY(*ref_excludes_p, 1);
> -		(*ref_excludes_p)->strdup_strings = 1;
> -	}
> -	string_list_append(*ref_excludes_p, exclude);
> +	string_list_clear(&exclusions->excluded_refs, 0);

Also nicer.

>  static void add_pending_commit_list(struct rev_info *revs,
> @@ -2689,10 +2684,10 @@ static int handle_revision_pseudo_opt(struct rev_info *revs,
>  			init_all_refs_cb(&cb, revs, *flags);
>  			other_head_refs(handle_one_ref, &cb);
>  		}
> -		clear_ref_exclusion(&revs->ref_excludes);
> +		clear_ref_exclusions(&revs->ref_excludes);
>  	} else if (!strcmp(arg, "--branches")) {
>  		handle_refs(refs, revs, *flags, refs_for_each_branch_ref);
> -		clear_ref_exclusion(&revs->ref_excludes);
> +		clear_ref_exclusions(&revs->ref_excludes);
>  	} else if (!strcmp(arg, "--bisect")) {
>  		read_bisect_terms(&term_bad, &term_good);
>  		handle_refs(refs, revs, *flags, for_each_bad_bisect_ref);
> @@ -2701,15 +2696,15 @@ static int handle_revision_pseudo_opt(struct rev_info *revs,
>  		revs->bisect = 1;
>  	} else if (!strcmp(arg, "--tags")) {
>  		handle_refs(refs, revs, *flags, refs_for_each_tag_ref);
> -		clear_ref_exclusion(&revs->ref_excludes);
> +		clear_ref_exclusions(&revs->ref_excludes);
>  	} else if (!strcmp(arg, "--remotes")) {
>  		handle_refs(refs, revs, *flags, refs_for_each_remote_ref);
> -		clear_ref_exclusion(&revs->ref_excludes);
> +		clear_ref_exclusions(&revs->ref_excludes);
>  	} else if ((argcount = parse_long_opt("glob", argv, &optarg))) {
>  		struct all_refs_cb cb;
>  		init_all_refs_cb(&cb, revs, *flags);
>  		for_each_glob_ref(handle_one_ref, optarg, &cb);
> -		clear_ref_exclusion(&revs->ref_excludes);
> +		clear_ref_exclusions(&revs->ref_excludes);
>  		return argcount;
>  	} else if ((argcount = parse_long_opt("exclude", argv, &optarg))) {
>  		add_ref_exclusion(&revs->ref_excludes, optarg);
> @@ -2718,17 +2713,17 @@ static int handle_revision_pseudo_opt(struct rev_info *revs,
>  		struct all_refs_cb cb;
>  		init_all_refs_cb(&cb, revs, *flags);
>  		for_each_glob_ref_in(handle_one_ref, optarg, "refs/heads/", &cb);
> -		clear_ref_exclusion(&revs->ref_excludes);
> +		clear_ref_exclusions(&revs->ref_excludes);
>  	} else if (skip_prefix(arg, "--tags=", &optarg)) {
>  		struct all_refs_cb cb;
>  		init_all_refs_cb(&cb, revs, *flags);
>  		for_each_glob_ref_in(handle_one_ref, optarg, "refs/tags/", &cb);
> -		clear_ref_exclusion(&revs->ref_excludes);
> +		clear_ref_exclusions(&revs->ref_excludes);
>  	} else if (skip_prefix(arg, "--remotes=", &optarg)) {
>  		struct all_refs_cb cb;
>  		init_all_refs_cb(&cb, revs, *flags);
>  		for_each_glob_ref_in(handle_one_ref, optarg, "refs/remotes/", &cb);
> -		clear_ref_exclusion(&revs->ref_excludes);
> +		clear_ref_exclusions(&revs->ref_excludes);

The churn I mentioned with the renaming, so maybe worth doing that as a
"prep" commit?

> +struct ref_exclusions {
> +	/*
> +	 * Excluded refs is a list of wildmatch patterns. If any of the
> +	 * patterns matches, the reference will be excluded.
> +	 */
> +	struct string_list excluded_refs;
> +};

Per the above POC diff though, please move...

>  struct oidset;
>  struct topo_walk_info;
>  
> @@ -103,7 +111,7 @@ struct rev_info {
>  	struct list_objects_filter_options filter;
>  
>  	/* excluding from --branches, --refs, etc. expansion */
> -	struct string_list *ref_excludes;
> +	struct ref_exclusions ref_excludes;
>  
>  	/* Basic information */
>  	const char *prefix;
> @@ -439,12 +447,14 @@ void mark_trees_uninteresting_sparse(struct repository *r, struct oidset *trees)
>  void show_object_with_name(FILE *, struct object *, const char *);
>  
>  /**
> - * Helpers to check if a "struct string_list" item matches with
> - * wildmatch().
> + * Helpers to check if a reference should be excluded.
>   */
> -int ref_excluded(struct string_list *, const char *path);
> -void clear_ref_exclusion(struct string_list **);
> -void add_ref_exclusion(struct string_list **, const char *exclude);
> +#define REF_EXCLUSIONS_INIT { .excluded_refs = STRING_LIST_INIT_DUP }

...this macro to right after declaring the struct, which is what we
usually do, and will help in adding it to "REV_INFO_INIT" sooner than
later.

Also, at the end of your series this end up being overly long, so per
the diff-above (which is tot he end of the series), let's start by
line-wrapping it:

	#define ..._INIT { \
        	.member = ..._INIT, \
	}
