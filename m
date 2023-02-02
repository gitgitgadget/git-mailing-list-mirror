Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98680C61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 23:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbjBBX4i (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 18:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjBBX4h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 18:56:37 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE946B00C
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 15:56:34 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id cr11so2417676pfb.1
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 15:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BgbeKT5RLpOXzYxay63z0v0CA2IVigDBkbF3nIC5z/U=;
        b=AmrWKLZ+iHR5mE5557brCIy0CLeYk5btjL9k2ote4qbauhtXFBKFByQ+mT2YG82mS8
         lt2s6/FAaZ6nPIxp+mlNZNyLMWIPWcsxofWwEGn/+onEGvbbcgKLMWVd5s6p2+6q92nO
         +PlPMOEXh1CTW7M7Ei4i6KGtg6ArVDPj9lrBb9adUw0yhDbcnpbDwMEoQzuU9CFtUh3k
         I8eFZAmpWcfTD/5HB9hxVY2E1RqOWLYfb7qIJiQT9wY2uNCGGt9H0HMJKkiyZkrLSMm6
         HGQ+2MCdAVX+GIicpmQO+5T+8JefgQk1bkCYeuJBU01ZloeCZgL3SOI8cvR7joBAqxoq
         SnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BgbeKT5RLpOXzYxay63z0v0CA2IVigDBkbF3nIC5z/U=;
        b=eI9FoMZlA9C6lOqYIm4WnWgMbOdF7jzL8WE8wcxg6ofxrpyGTG4/E6/M7jm65OQj/0
         ccNqSBGxt5kB/bWMP2iw7lbmbBP1hVJ6tmSoKnOZJVIXIEjnNOspePOwfeT8ZgLYFMFm
         Qg09aY4sA68gOvs2w3DCOstaXg0JBom4zk0aD8JXVXs9xUAAaC/X7WeCEnw0uzoJtbB8
         z9ODLK0BD3TuQxzjQdz9n4uQ7nKrinDXX7MShdFX80gMZCGijDGl1F3Ohl3PvhBOO2vO
         LC4vZxbbJ0YhjVTbtPeKfX6TuJ2CXKfGiz8c66Dc/l6B858x2KQZQFVj5j2SxF9OnLM4
         6+ng==
X-Gm-Message-State: AO0yUKXwakjHD6+97oHDw7+jW2CCgLgw0DEF1F7Njg9F+cRVRsOef2kE
        DzhOvj28WfCZ1tXYpE/FaXE=
X-Google-Smtp-Source: AK7set9+XylehXJyLoM5+nGa5IL8cw4sxtZRaEOThF/muooICbE+a66vFepo8fR4RTu+KFyZ56xzAA==
X-Received: by 2002:a62:6547:0:b0:58d:9791:44bc with SMTP id z68-20020a626547000000b0058d979144bcmr6441489pfb.9.1675382194333;
        Thu, 02 Feb 2023 15:56:34 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id c62-20020a621c41000000b0058d8db0e4adsm259329pfc.171.2023.02.02.15.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 15:56:33 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com
Subject: Re: [PATCH v4 3/9] config API: add and use a "git_config_get()"
 family of functions
References: <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>
        <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com>
        <patch-v4-3.9-998b11ae4bc-20230202T131155Z-avarab@gmail.com>
Date:   Thu, 02 Feb 2023 15:56:33 -0800
In-Reply-To: <patch-v4-3.9-998b11ae4bc-20230202T131155Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 2 Feb
 2023 14:27:15
        +0100")
Message-ID: <xmqqv8kjpqoe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> We already have the basic "git_config_get_value()" function and its
> "repo_*" and "configset" siblings to get a given "key" and assign the
> last key found to a provided "value".
>
> But some callers don't care about that value, but just want to use the
> return value of the "get_value()" function to check whether the key
> exist (or another non-zero return value).
>
> The immediate motivation for this is that a subsequent commit will
> need to change all callers of the "*_get_value_multi()" family of
> functions. In two cases here we (ab)used it to check whether we had
> any values for the given key, but didn't care about the return value.

So, the idea is that 

	if (!git_config_get_string(key, &discard))
		free(discard);
	else
		... the key is missing ...

becomes

	if (git_config_get(key))
		... the key is missing ...

In other words, git_config_get() returns 0 only when the key is
used, and non-zero return signals that the key is not used?

Similarly, get_value_multi() was an interface to get to the
value_list associated to the given key, and was abused like

	if (git_config_get_value_multi(key))
		... the key exists ...

which will become

	if (!git_config_get(key))
		... the key exists ...

right?

>  	/* Set maintenance strategy, if unset */
> -	if (!git_config_get_string("maintenance.strategy", &config_value))
> -		free(config_value);
> -	else
> +	if (git_config_get("maintenance.strategy"))
>  		git_config_set("maintenance.strategy", "incremental");

OK.  config_get() says "true" meaning the key is missing.

> -	if (!argc && git_config_get_value_multi("submodule.active"))
> +	if (!argc && !git_config_get("submodule.active"))
>  		module_list_active(&list);

OK.

> @@ -2743,7 +2743,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
>  		 * If there are no path args and submodule.active is set then,
>  		 * by default, only initialize 'active' modules.
>  		 */
> -		if (!argc && git_config_get_value_multi("submodule.active"))
> +		if (!argc && !git_config_get("submodule.active"))
>  			module_list_active(&list);

OK.

> @@ -3185,7 +3184,7 @@ static void configure_added_submodule(struct add_data *add_data)
>  	 * is_submodule_active(), since that function needs to find
>  	 * out the value of "submodule.active" again anyway.
>  	 */
> -	if (!git_config_get_string_tmp("submodule.active", &val)) {
> +	if (!git_config_get("submodule.active")) {

string_tmp() variant is to retrieve borrowed value, and it returns 0
when there is a value.  If it is a valueless true, we get -1 back
with an error message.  What does the updated version do in the
valueless true case?

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index f51c40f1e1e..6ba42d4ad20 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -338,7 +337,7 @@ static void copy_filtered_worktree_config(const char *worktree_git_dir)
>  				to_file, "core.bare", NULL, "true", 0))
>  			error(_("failed to unset '%s' in '%s'"),
>  				"core.bare", to_file);
> -		if (!git_configset_get_value(&cs, "core.worktree", &core_worktree) &&
> +		if (!git_configset_get(&cs, "core.worktree") &&

OK.

> diff --git a/config.c b/config.c
> index 00090a32fc3..b88da70c664 100644
> --- a/config.c
> +++ b/config.c
> @@ -2289,23 +2289,28 @@ void read_very_early_config(config_fn_t cb, void *data)
>  	config_with_options(cb, data, NULL, &opts);
>  }
>  
> -static struct config_set_element *configset_find_element(struct config_set *cs, const char *key)
> +static int configset_find_element(struct config_set *cs, const char *key,
> +				  struct config_set_element **dest)
>  {
>  	struct config_set_element k;
>  	struct config_set_element *found_entry;
>  	char *normalized_key;
> +	int ret;
> +
>  	/*
>  	 * `key` may come from the user, so normalize it before using it
>  	 * for querying entries from the hashmap.
>  	 */
> -	if (git_config_parse_key(key, &normalized_key, NULL))
> -		return NULL;
> +	ret = git_config_parse_key(key, &normalized_key, NULL);
> +	if (ret)
> +		return ret;
>  
>  	hashmap_entry_init(&k.ent, strhash(normalized_key));
>  	k.key = normalized_key;
>  	found_entry = hashmap_get_entry(&cs->config_hash, &k, ent, NULL);
>  	free(normalized_key);
> -	return found_entry;
> +	*dest = found_entry;
> +	return 0;

OK, so we used to return NULL when the key is not parseable, and
otherwise we returned the config_set_element we found for the key,
or NULL if there is no such element.  Now we return error code as
the return value and allow the caller to peek the element via *dest
parameter.

So, from the caller's point of view (dest != NULL) is how it checks
if the key is used.  The function returning 0 is a sign that the key
passed to it is healthy.  OK.

> @@ -2314,8 +2319,11 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
>  	struct string_list_item *si;
>  	struct configset_list_item *l_item;
>  	struct key_value_info *kv_info = xmalloc(sizeof(*kv_info));
> +	int ret;
>  
> -	e = configset_find_element(cs, key);
> +	ret = configset_find_element(cs, key, &e);
> +	if (ret)
> +		return ret;

The function never returned any meaningful error, so the callers may
not be prepared to see such an error return.  But now we at least
notice an error at this level.

> @@ -2425,8 +2433,25 @@ int git_configset_get_value(struct config_set *cs, const char *key, const char *
>  
>  const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key)
>  {
> -	struct config_set_element *e = configset_find_element(cs, key);
> -	return e ? &e->value_list : NULL;
> +	struct config_set_element *e;
> +
> +	if (configset_find_element(cs, key, &e))
> +		return NULL;
> +	else if (!e)
> +		return NULL;
> +	return &e->value_list;
> +}

OK.  !e means "we got a healthy key and peeking into the hash table,
there wasn't any entry for the key", and that is reported with NULL.
Do we evern return a string list with .nr == 0, I wonder.  Having to
deal with such a list would make the caller's job more complex, but
perhaps we are not allowing the code to shrink value_list.nr to
avoid such a situation?

> +int git_configset_get(struct config_set *cs, const char *key)
> +{
> +	struct config_set_element *e;
> +	int ret;
> +
> +	if ((ret = configset_find_element(cs, key, &e)))
> +		return ret;
> +	else if (!e)
> +		return 1;
> +	return 0;
>  }

OK.  So 0 return from the function means there is a value (or more)
for a given key.  Good.

> diff --git a/config.h b/config.h
> index ef9eade6414..04c5e594015 100644
> --- a/config.h
> +++ b/config.h
> @@ -471,9 +471,12 @@ void git_configset_clear(struct config_set *cs);
>  
>  /*
>   * These functions return 1 if not found, and 0 if found, leaving the found
> - * value in the 'dest' pointer.
> + * value in the 'dest' pointer (if any).
>   */

Now the returned non-zero values are no longer 1 alone, no?
Whatever lower-level functions use to signal an error is propagated
up with the

	if ((ret = func())
		return ret;

pattern.
