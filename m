Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6FBC7619A
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 09:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbjDEJ3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 05:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237650AbjDEJ24 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 05:28:56 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FF055AE
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 02:28:16 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id er13so98481314edb.9
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 02:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680686895;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j6w5aQTQ3VlPgX83UF1bwbX38tSqYhNODL3gxaOzNNE=;
        b=cyon15czPu6wKzXc5m0occcO/v4WTWGSVNlrNa1Eue1b8jeJgRnEaFumbbOTIlztGI
         pZpcqBfRrZwQlJB+cPOYrcoxgD5httq+KUuAKZlpMaxtPRIhz67+q1s46d7HOwSmD/PJ
         TZyHSYgJUG/a9M9BHWeqSJwAZ0wdPF9OGgmBnbN6tOnlfcslTHKrmZ9WYiOwj6hbeoTM
         ALT1FB3bi7GNm9EJ90aqSoNCvN4zN6CxX9o/3y+AHTbvcKYfhRiLLnXlr39V5oYSKYNC
         evsqt8gCO+dTHI0XiRADWBL/CBsmkq4g5+787KDgadRE5y2Uo/SDb4MNbDYYvvuanuJ0
         SfmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680686895;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6w5aQTQ3VlPgX83UF1bwbX38tSqYhNODL3gxaOzNNE=;
        b=YWkjD6e/FYIvPMxXfOEHu0cfiA/aPsx8eUMfWfWTLNYGqP1weMSrhpNnR0aB+qIFI2
         k2urjm3t3Fx8vWuIWmWoBwqzMNj8b26LLn3dtH0eV1llWRRunY+uxT8AwyBdE6OWNgfg
         7iNap8k4pp5iHIVfmMuzpQkE8xxrjM/kCHt6oJbdOa38PYA6BsX1SY0ey18kvkeQIt6v
         6+ZRlSfL3ftARS8ZpczZcJ7XuUUBNQ6WsoyfkSkGG5M653nywE+G74fjQl6LgZG1O7Mk
         oBINyLu0ZXE6oo443WPuHuLBtCeYPpIAxlzWiSB+RrVx1cRs/WbX7DiF8mZNfjZB3mJd
         4Ftg==
X-Gm-Message-State: AAQBX9e9ZdTA0zuHPdEEixruBDR1VaBynVDJZngzxGqN7qVh676rTvfc
        y2Ht1fzfjNqMdo0rJwEmUGFzc++pjvA=
X-Google-Smtp-Source: AKy350ZkPFb384K5pkNXG0iecVzPrSXemO7Nll+bKgpkxfnpe2gBkcGdAOt2r63fd6xxB9lo5t79Ug==
X-Received: by 2002:a17:907:118a:b0:948:aac6:7def with SMTP id uz10-20020a170907118a00b00948aac67defmr1832160ejb.19.1680686894707;
        Wed, 05 Apr 2023 02:28:14 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id xh12-20020a170906da8c00b00947ccb6150bsm6403698ejb.102.2023.04.05.02.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 02:28:14 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pjzR7-005K3A-2d;
        Wed, 05 Apr 2023 11:28:13 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Daniel =?utf-8?Q?Mart?= =?utf-8?Q?=C3=AD?= <mvdan@mvdan.cc>
Subject: Re: [PATCH 1/2] Add fetch.updateHead option
Date:   Wed, 05 Apr 2023 11:16:12 +0200
References: <20230405012742.2452208-1-felipe.contreras@gmail.com>
 <20230405012742.2452208-2-felipe.contreras@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230405012742.2452208-2-felipe.contreras@gmail.com>
Message-ID: <230405.86fs9evfte.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 04 2023, Felipe Contreras wrote:

> Users might change the behavior when running "git fetch" so that the
> remote's HEAD symbolic ref is updated at certain point.
>
> For example after running "git remote add" the remote HEAD is not
> set like it is with "git clone".
>
> Setting "fetch.updatehead = missing" would probably be a sensible
> default that everyone would want, but for now the default behavior is to
> never update HEAD, so there shouldn't be any functional changes.
>
> For the next major version of Git, we might want to change this default.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/config/fetch.txt  |  4 +++
>  Documentation/config/remote.txt |  3 ++
>  builtin/fetch.c                 | 64 ++++++++++++++++++++++++++++++++-
>  remote.c                        | 21 +++++++++++
>  remote.h                        | 11 ++++++
>  t/t5510-fetch.sh                | 31 ++++++++++++++++
>  6 files changed, 133 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
> index 568f0f75b3..dc147ffb35 100644
> --- a/Documentation/config/fetch.txt
> +++ b/Documentation/config/fetch.txt
> @@ -120,3 +120,7 @@ fetch.bundleCreationToken::
>  The creation token values are chosen by the provider serving the specific
>  bundle URI. If you modify the URI at `fetch.bundleURI`, then be sure to
>  remove the value for the `fetch.bundleCreationToken` value before fetching.
> +
> +fetch.updateHead::
> +	Defines when to update the remote HEAD symbolic ref. Values are 'never',
> +	'missing' (update only when HEAD is missing), and 'always'.
> diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
> index 0678b4bcfe..9d739d2ed4 100644
> --- a/Documentation/config/remote.txt
> +++ b/Documentation/config/remote.txt
> @@ -86,3 +86,6 @@ remote.<name>.partialclonefilter::
>  	Changing or clearing this value will only affect fetches for new commits.
>  	To fetch associated objects for commits already present in the local object
>  	database, use the `--refetch` option of linkgit:git-fetch[1].
> +
> +remote.<name>.updateHead::
> +	Defines when to update the remote HEAD symbolic ref. See `fetch.updateHead`.
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 7221e57f35..7e93a1aa46 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -59,6 +59,8 @@ static int fetch_prune_tags_config = -1; /* unspecified */
>  static int prune_tags = -1; /* unspecified */
>  #define PRUNE_TAGS_BY_DEFAULT 0 /* do we prune tags by default? */
>  
> +static int fetch_update_head = FETCH_UPDATE_HEAD_DEFAULT;
> +
>  static int all, append, dry_run, force, keep, multiple, update_head_ok;
>  static int write_fetch_head = 1;
>  static int verbosity, deepen_relative, set_upstream, refetch;
> @@ -129,6 +131,9 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
>  		return 0;
>  	}
>  
> +	if (!strcmp(k, "fetch.updatehead"))
> +		return parse_update_head(&fetch_update_head, k, v);
> +
>  	return git_default_config(k, v, cb);
>  }
>  
> @@ -1579,6 +1584,47 @@ static int backfill_tags(struct transport *transport,
>  	return retcode;
>  }
>  
> +static void update_head(int config, const struct ref *head, const struct remote *remote)

Here you pass a "const struct remote".

> +{
> +	char *ref, *target;
> +	const char *r;
> +	int flags;
> +
> +	if (!head || !head->symref || !remote)
> +		return;
> +
> +	ref = apply_refspecs((struct refspec *)&remote->fetch, "refs/heads/HEAD");
> +	target = apply_refspecs((struct refspec *)&remote->fetch, head->symref);

But here we end up with this cast, as it's not const after all, we're
modifying it.

I think this sort of thing makes the code harder to read & reason about,
and adds cast verbosity.

If you want to clearly communicate that the "remote->name" and
"remote->mirror" you're using are "const" I think a better way to do
this is to pass those as explicit parameters to this new static helper
function, and then just pass a "struct refspec *fetch_rs" directly.

> +
> +	if (!ref || !target) {
> +		warning(_("could not update remote head"));
> +		return;
> +	}
> +
> +	r = resolve_ref_unsafe(ref, 0, NULL, &flags);
> +
> +	if (r) {
> +		if (config == FETCH_UPDATE_HEAD_MISSING) {
> +			if (flags & REF_ISSYMREF)
> +				/* already present */
> +				return;
> +		} else if (config == FETCH_UPDATE_HEAD_ALWAYS) {
> +			if (!strcmp(r, target))
> +				/* already up-to-date */
> +				return;

I think you should name the "enum" you're adding below, the one that
contains the new "FETCH_UPDATE_HEAD_DEFAULT".

Then this could be a "switch", and the compiler could check the
arguments, i.e. you could pass an enum type instead of an "int".

> +		} else

{} missing, if you keep this, but...

> +			/* should never happen */
> +			return;

...so, here we're not checking some enum values, but presumably other
things check this, I haven't checked.


But for a "should never happen", should we make this a "BUG()", or is it
user-controlled?



> +	}
> +
> +	if (!create_symref(ref, target, "remote update head")) {
> +		if (verbosity >= 0)
> +			printf(_("Updated remote '%s' HEAD\n"), remote->name);
> +	} else {
> +		warning(_("could not update remote head"));
> +	}
> +}
> +
>  static int do_fetch(struct transport *transport,
>  		    struct refspec *rs)
>  {
> @@ -1592,6 +1638,7 @@ static int do_fetch(struct transport *transport,
>  	int must_list_refs = 1;
>  	struct fetch_head fetch_head = { 0 };
>  	struct strbuf err = STRBUF_INIT;
> +	int need_update_head = 0, update_head_config = 0;
>  
>  	if (tags == TAGS_DEFAULT) {
>  		if (transport->remote->fetch_tags == 2)
> @@ -1626,9 +1673,21 @@ static int do_fetch(struct transport *transport,
>  	} else {
>  		struct branch *branch = branch_get(NULL);
>  
> -		if (transport->remote->fetch.nr)
> +		if (transport->remote->fetch.nr) {
> +
> +			if (transport->remote->update_head)
> +				update_head_config = transport->remote->update_head;
> +			else
> +				update_head_config = fetch_update_head;
> +
> +			need_update_head = update_head_config && update_head_config != FETCH_UPDATE_HEAD_NEVER;
> +
> +			if (need_update_head)
> +				strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
>  			refspec_ref_prefixes(&transport->remote->fetch,
>  					     &transport_ls_refs_options.ref_prefixes);
> +		}
> +
>  		if (branch_has_merge_config(branch) &&
>  		    !strcmp(branch->remote_name, transport->remote->name)) {
>  			int i;
> @@ -1737,6 +1796,9 @@ static int do_fetch(struct transport *transport,
>  
>  	commit_fetch_head(&fetch_head);
>  
> +	if (need_update_head)
> +		update_head(update_head_config, find_ref_by_name(remote_refs, "HEAD"), transport->remote);

Some overly long lines here...

> +
>  	if (set_upstream) {
>  		struct branch *branch = branch_get("HEAD");
>  		struct ref *rm;
> diff --git a/remote.c b/remote.c
> index 641b083d90..5f3a9aa53e 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -344,6 +344,25 @@ static void read_branches_file(struct remote_state *remote_state,
>  	remote->fetch_tags = 1; /* always auto-follow */
>  }
>  
> +int parse_update_head(int *r, const char *var, const char *value)
> +{
> +	if (!r)
> +		return -1;
> +	else if (!value)
> +		return config_error_nonbool(var);
> +	else if (!strcmp(value, "never"))
> +		*r = FETCH_UPDATE_HEAD_NEVER;
> +	else if (!strcmp(value, "missing"))
> +		*r = FETCH_UPDATE_HEAD_MISSING;
> +	else if (!strcmp(value, "always"))
> +		*r = FETCH_UPDATE_HEAD_ALWAYS;

Ditto, this could really benefit from an enum type, instead of the bare
"int".

> +	else {
> +		error(_("malformed value for %s: %s"), var, value);
> +		return error(_("must be one of never, missing, or always"));

Shouldn't we use git_die_config() or similar here, to get the line
number etc., or do we get that somehow (I can't recall).

> +	}
> +	return 0;
> +}
> +
>  static int handle_config(const char *key, const char *value, void *cb)
>  {
>  	const char *name;
> @@ -473,6 +492,8 @@ static int handle_config(const char *key, const char *value, void *cb)
>  					 key, value);
>  	} else if (!strcmp(subkey, "vcs")) {
>  		return git_config_string(&remote->foreign_vcs, key, value);
> +	} else if (!strcmp(subkey, "updatehead")) {
> +		return parse_update_head(&remote->update_head, key, value);
>  	}
>  	return 0;
>  }
> diff --git a/remote.h b/remote.h
> index 73638cefeb..9dce42d65d 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -22,6 +22,13 @@ enum {
>  	REMOTE_BRANCHES
>  };
>  
> +enum {
> +	FETCH_UPDATE_HEAD_DEFAULT = 0,

We tend to only init these to 0 when the default being 0 matters,
i.e. we use it as a boolean, but is that the case here?

> +	FETCH_UPDATE_HEAD_NEVER,
> +	FETCH_UPDATE_HEAD_MISSING,
> +	FETCH_UPDATE_HEAD_ALWAYS,
> +};

I.e. let's name this.


> +
>  struct rewrite {
>  	const char *base;
>  	size_t baselen;
> @@ -97,6 +104,8 @@ struct remote {
>  	int prune;
>  	int prune_tags;
>  
> +	int update_head;
> +
>  	/**
>  	 * The configured helper programs to run on the remote side, for
>  	 * Git-native protocols.
> @@ -449,4 +458,6 @@ void apply_push_cas(struct push_cas_option *, struct remote *, struct ref *);
>  char *relative_url(const char *remote_url, const char *url,
>  		   const char *up_path);
>  
> +int parse_update_head(int *r, const char *var, const char *value);

For new functions and/or enums, having some brief API docs (using the
"/** ... */" syntax) would be better.


> +
>  #endif
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index dc44da9c79..dbeb2928ae 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -814,6 +814,37 @@ test_expect_success 'fetch from multiple configured URLs in single remote' '
>  	git fetch multipleurls
>  '
>  
> +test_cmp_symbolic_ref () {
> +	git symbolic-ref "$1" >actual &&
> +	echo "$2" >expected &&
> +	test_cmp expected actual
> +}

Sort of an aside, but this seems to be the Nth use of this pattern in
the test suite, e.g. t1401-symbolic-ref.sh repeatedly hardcodes the
same.

I wonder if a prep commit to stick this in test-lib-functions.sh would
be in order, or maybe a "--symbolic" argument to "test_cmp_rev"?
