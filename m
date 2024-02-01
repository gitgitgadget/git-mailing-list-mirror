Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765F33FB2E
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 22:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706826195; cv=none; b=eZQgc3aWZiiB/Zi8UJRc+F5lZhl1Da2/BrX20HI9fBYqSue30mpQhN9TQ1S+t7WoeFaCoVVPKGPhD2qJ6+ltdETy8itBvub74t9Zc4OHKpKtjgEtQTZLa+8WVCH6L8mAsbLl8IwQjsUeKYWb1YuAe/wHCImI74Z7SwGYMfWUUgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706826195; c=relaxed/simple;
	bh=uvSCz7UwsXV/oO4KQ866LYB9Lh8LkuTqRlnu2mVypis=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mfH8KOwkyXtSVYcGuMHVFYOQfpaGw1W0wdIo68z7/5G8OfjS8UBEtZzQ3V1NlJFXWwvI9l/rjkQ8VjgPjBKOFH/hXFGQRJs3i/3hAt8xyzgfH6IDpZGXaIood9/KmjkBONujJVNThzc/J6gfQYdphZ6HJvsW73dkNXMpRxFW9/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ue8tLifQ; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ue8tLifQ"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BD5413D497;
	Thu,  1 Feb 2024 17:23:12 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=uvSCz7UwsXV/oO4KQ866LYB9Lh8LkuTqRlnu2m
	Vypis=; b=ue8tLifQemPERFlw2IC3gTsRiqCNwmhZS82lLxLW92JjisQ7a4CDrQ
	TvdGY8QjDXl+3eBWOG5HHKtQKdCPYRBpGb9Ej2yMYxyyZ94SNtUUY+XmsSlkFXIY
	sutbOANk9r0cm8yLbVhEo/8rDtqHSYbrTxqs6/6QsiJE6yxswSVuw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B56913D496;
	Thu,  1 Feb 2024 17:23:12 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D8BF93D494;
	Thu,  1 Feb 2024 17:23:08 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,  Emily
 Shaffer <nasamuffin@google.com>,  Josh Steadmon <steadmon@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>,  Linus Arver
 <linusa@google.com>
Subject: Re: [PATCH v3 08/10] trailer: move arg handling to
 interpret-trailers.c
In-Reply-To: <465dc51cdcba28d235241021bc52369f6082d329.1706664145.git.gitgitgadget@gmail.com>
	(Linus Arver via GitGitGadget's message of "Wed, 31 Jan 2024 01:22:22
	+0000")
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
	<pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<465dc51cdcba28d235241021bc52369f6082d329.1706664145.git.gitgitgadget@gmail.com>
Date: Thu, 01 Feb 2024 14:23:07 -0800
Message-ID: <xmqqttmrx1ro.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7A558940-C150-11EE-865B-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> We don't move the "arg_item" struct to interpret-trailers.c, because it
> is now a struct that contains information about trailers that could be
> added into the input text's own trailers. This is a generic concept that
> extends beyond trailers defined as CLI arguments (it applies to trailers
> defined in configuration as well). We will rename "arg_item" to
> "trailer_template" in a follow-up patch to keep the diff here small.
>
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  builtin/interpret-trailers.c | 88 ++++++++++++++++++++++--------------
>  trailer.c                    | 62 ++++++++++++++++++-------
>  trailer.h                    | 12 +++++
>  3 files changed, 112 insertions(+), 50 deletions(-)
>
> diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
> index 9f0ba39b317..9a902012912 100644
> --- a/builtin/interpret-trailers.c
> +++ b/builtin/interpret-trailers.c
> @@ -45,23 +45,17 @@ static int option_parse_if_missing(const struct option *opt,
>  	return trailer_set_if_missing(opt->value, arg);
>  }
>  
> -static void free_new_trailers(struct list_head *trailers)
> -{
> -	struct list_head *pos, *tmp;
> -	struct new_trailer_item *item;
> -
> -	list_for_each_safe(pos, tmp, trailers) {
> -		item = list_entry(pos, struct new_trailer_item, list);
> -		list_del(pos);
> -		free(item);
> -	}
> -}
> +static char *cl_separators;

It somehow feels ugly and goes backward to depend on a new global,
especially when you are aiming to libify more things.  If we are
doing something like ...

>  static int option_parse_trailer(const struct option *opt,
>  				   const char *arg, int unset)
>  {
>  	struct list_head *trailers = opt->value;
> -	struct new_trailer_item *item;
> +	struct strbuf tok = STRBUF_INIT;
> +	struct strbuf val = STRBUF_INIT;
> +	const struct trailer_conf *conf;
> +	struct trailer_conf *conf_current = new_trailer_conf();
> +	ssize_t separator_pos;
>  
>  	if (unset) {
>  		free_new_trailers(trailers);
> @@ -71,12 +65,31 @@ static int option_parse_trailer(const struct option *opt,
>  	if (!arg)
>  		return -1;
>  
> -	item = xmalloc(sizeof(*item));
> -	item->text = arg;
> -	item->where = where;
> -	item->if_exists = if_exists;
> -	item->if_missing = if_missing;
> -	list_add_tail(&item->list, trailers);
> +	separator_pos = find_separator(arg, cl_separators);
> +	if (separator_pos) {
> +		parse_trailer(arg, separator_pos, &tok, &val, &conf);
> +		duplicate_trailer_conf(conf_current, conf);
> +
> +		/*
> +		 * Override conf_current with settings specified via CLI flags.
> +		 */

... this, which apparently needs to know that we are dealing with
input from CLI, shouldn't we be able to do the "CLI allows '=' as
well as whatever is the default" here, instead of mucking with the
global variable in the caller?

Even if you plan to later make this function callable from outside
the context of parse_options() callback, and if you do not want "CLI
allows '=' as well" for such new callers, we should be able to have
a shared helper function that is the bulk of this function but takes
additional parameter to tweak its behaviour slightly depending on
the needs of the callers?

> +		trailer_conf_set(where, if_exists, if_missing, conf_current);

I am getting an impression that the use of and the introduction of
the new helper, mixed with movement of the responsibility, makes
reviewing the change unnecessarily more cumbersome.  An equivalent
series with a few more steps, each of them focusing on a small
change (like, "updating the conf_current members is done with
assignments that appear as a pattern very often---introduce a helper
to reduce boilerplate") would have been more enticing to reviewers.

> +		trailer_add_arg_item(strbuf_detach(&tok, NULL),
> +				     strbuf_detach(&val, NULL),
> +				     conf_current,
> +				     trailers);
> +	} else {
> +		struct strbuf sb = STRBUF_INIT;
> +		strbuf_addstr(&sb, arg);
> +		strbuf_trim(&sb);
> +		error(_("empty trailer token in trailer '%.*s'"),
> +			(int) sb.len, sb.buf);
> +		strbuf_release(&sb);
> +	}
> +
> +	free(conf_current);
> +
>  	return 0;
>  }
>  
> @@ -135,7 +148,7 @@ static void read_input_file(struct strbuf *sb, const char *file)
>  }
>  
>  static void interpret_trailers(const struct process_trailer_options *opts,
> -			       struct list_head *new_trailer_head,
> +			       struct list_head *arg_trailers,
>  			       const char *file)
>  {
>  	LIST_HEAD(head);
> @@ -144,8 +157,6 @@ static void interpret_trailers(const struct process_trailer_options *opts,
>  	struct trailer_block *trailer_block;
>  	FILE *outfile = stdout;
>  
> -	trailer_config_init();
> -
>  	read_input_file(&sb, file);
>  
>  	if (opts->in_place)
> @@ -162,12 +173,7 @@ static void interpret_trailers(const struct process_trailer_options *opts,
>  
>  
>  	if (!opts->only_input) {
> -		LIST_HEAD(config_head);
> -		LIST_HEAD(arg_head);
> -		parse_trailers_from_config(&config_head);
> -		parse_trailers_from_command_line_args(&arg_head, new_trailer_head);
> -		list_splice(&config_head, &arg_head);
> -		process_trailers_lists(&head, &arg_head);
> +		process_trailers_lists(&head, arg_trailers);
>  	}

So, the bulk of the parsing is no longer responsibility of this
function.  Instead, the caller (e.g., cmd_interpret_trailers()) is
expected to do that before they call us.

> ...
>  	git_config(git_default_config, NULL);
> +	trailer_config_init();
> +
> +	if (!opts.only_input) {
> +		parse_trailers_from_config(&configured_trailers);
> +	}

By the way, until we add more statements in this block, lose the
unnecessary {} around it.

> +	/*
> +	* In command-line arguments, '=' is accepted (in addition to the
> +	* separators that are defined).
> +	*/
> +	cl_separators = xstrfmt("=%s", trailer_default_separators());
>  
>  	argc = parse_options(argc, argv, prefix, options,
>  			     git_interpret_trailers_usage, 0);
>  
> -	if (opts.only_input && !list_empty(&trailers))
> +	free(cl_separators);
> +
> +	if (opts.only_input && !list_empty(&arg_trailers))
>  		usage_msg_opt(
>  			_("--trailer with --only-input does not make sense"),
>  			git_interpret_trailers_usage,
>  			options);
>  
> +	list_splice(&configured_trailers, &arg_trailers);

This corresponds to what the old code did in interpret_trailers(),
OK.

The move of the responsibility may make sense.

>  	if (argc) {
>  		int i;
>  		for (i = 0; i < argc; i++)
> -			interpret_trailers(&opts, &trailers, argv[i]);
> +			interpret_trailers(&opts, &arg_trailers, argv[i]);
>  	} else {
>  		if (opts.in_place)
>  			die(_("no input file given for in-place editing"));
> -		interpret_trailers(&opts, &trailers, NULL);
> +		interpret_trailers(&opts, &arg_trailers, NULL);
>  	}
>  
> -	free_new_trailers(&trailers);
> +	free_new_trailers(&arg_trailers);
>  
>  	return 0;
>  }
> diff --git a/trailer.c b/trailer.c
> index c16f552b463..19637ff295d 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -66,6 +66,11 @@ static LIST_HEAD(conf_head);
>  
>  static char *separators = ":";
>  
> +const char *trailer_default_separators(void)
> +{
> +	return separators;
> +}
> +
>  static int configured;
>  
>  #define TRAILER_ARG_STRING "$ARG"
> @@ -424,6 +429,25 @@ int trailer_set_if_missing(enum trailer_if_missing *item, const char *value)
>  	return 0;
>  }
>  
> +void trailer_conf_set(enum trailer_where where,
> +		      enum trailer_if_exists if_exists,
> +		      enum trailer_if_missing if_missing,
> +		      struct trailer_conf *conf)
> +{
> +	if (where != WHERE_DEFAULT)
> +		conf->where = where;
> +	if (if_exists != EXISTS_DEFAULT)
> +		conf->if_exists = if_exists;
> +	if (if_missing != MISSING_DEFAULT)
> +		conf->if_missing = if_missing;
> +}

So, this is such a helper function. It is curious that it
deliberately lacks the ability to reset what has already been
configured back to the default.

For example, we earlier saw this original code ...

> -	item = xmalloc(sizeof(*item));
> -	item->text = arg;
> -	item->where = where;
> -	item->if_exists = if_exists;
> -	item->if_missing = if_missing;

... gets replaced with this call.

> +	struct trailer_conf *conf_current = new_trailer_conf();
> ...
> +		trailer_conf_set(where, if_exists, if_missing, conf_current);

For this conversion to be correct, we require that the value of the
*_DEFAULT macro to be 0 and/or these three values getting assigned
are not *_DEFAULT values.  Maybe that may happen to be the case in
today's code, but such an unwritten assumption makes me feel nervous.

I am not sure if it is worth the confusion factor to make a function
whose name is $anything_set() to be making a conditional assignment.
If such a conditional assignment *also* happens often and deserves
to have its own helper, it is fine to have such a helper for
conditional assignment, but calling it $anything_set() is probably a
mistake.

Other than that, the main thrust of this step seems sensible.

Thanks.
