Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C17EC38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 18:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbiJZStX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 14:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJZStV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 14:49:21 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13CCD4A29
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 11:49:19 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r14so43099297edc.7
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 11:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P13oJArWkgj0TDKxGPW+5Nap3+bhAaW48NPVfawNMuE=;
        b=HJjT2aDyKrDMiYLPFraiVvQsM0gS5AGRwP0pnf27M7BGolTa6inwNQ8EH2AbbIfKvM
         C/tR/hS/cgjWRPrQlWPTets5vkoc/7DBD/xd/VagcuA3daxhhxZJS7SR+xZWj5IQEDt0
         gsSL3RVbB0HGdsFNQ0TXmlFrHlp3xEpAY2Rh/DUe8ESDv+POxeUj09jnXPdnWjWL2OGa
         cs9KzvEvEN0abKEKHIu5/5mI5wR9GrvuvhqXuh/A5muLuG+eBwHQ0ltYaW+aGKL1uZIz
         6KeDIj88ZhlSLiGhv56nCP1CM3CvIX1KjRqR5y3ivhBcBblvch2yd6EJz2V8UmYWNthQ
         W+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P13oJArWkgj0TDKxGPW+5Nap3+bhAaW48NPVfawNMuE=;
        b=K93+l+sy8AVzt3RzVZCmMX/gURsqnWdO9W7BLoH6m5PqncVf6uzIbJ/WLdtgEtXXa7
         BSh+K51bbfe5hd4ZEavfOHEfiNOHyuDet0mcdiVJ8XgKKg13a9FpI+yOwX7EzBfoJQ3T
         u1hGBWx3RCWcY/Q+uJJ9HKdHH6OtIQA5uJ1Fx+VzCy8+dhG9UrvPOMAKlIldqFlnX7A3
         g5KBrAVI0f0KHyzz0rD/SzDwjRTxC7ach9QOS8YqYMLwlo8W1JNcaH6fwOMFODgCJnTf
         VEaErdCIhbcohBv48dCmtTyUY1rADOCuTBOGdH4Q+8NqrJyrX4vN2Y8PDyNJNaN2/VX9
         vMKg==
X-Gm-Message-State: ACrzQf3YQfGV8lDksbPWy/KzyYzJEXkElcdeMURSO8AHmNuikSVpr2KB
        /qVkTn5NWklGEiUue61g6MU=
X-Google-Smtp-Source: AMsMyM5qm7k8bLIGsoxI51MH3Q45Bs3fxGAOw8VxU3fMJgfOhh4wBMnpe/dkpgyS4O8P0/avz8uUVg==
X-Received: by 2002:a05:6402:35cb:b0:462:6545:5d99 with SMTP id z11-20020a05640235cb00b0046265455d99mr4098032edc.51.1666810157940;
        Wed, 26 Oct 2022 11:49:17 -0700 (PDT)
Received: from localhost (94-21-58-15.pool.digikabel.hu. [94.21.58.15])
        by smtp.gmail.com with ESMTPSA id ky21-20020a170907779500b0079de6b05c99sm3331178ejc.138.2022.10.26.11.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 11:49:17 -0700 (PDT)
Date:   Wed, 26 Oct 2022 20:49:15 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 01/10] config API: have *_multi() return an "int" and
 take a "dest"
Message-ID: <20221026184915.GA1828@szeder.dev>
References: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
 <patch-01.10-eefa253ab1f-20221026T151328Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-01.10-eefa253ab1f-20221026T151328Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2022 at 05:35:14PM +0200, Ævar Arnfjörð Bjarmason wrote:
> The git_configset_get_value_multi() function added in 3c8687a73ee (add
> `config_set` API for caching config-like files, 2014-07-28) is a
> fundamental part of of the config API, and
> e.g. "git_config_get_value()" and others are implemented in terms of
> it.
> 
> But it has had the limitation that configset_find_element() calls
> git_config_parse_key(), but then throws away the distinction between a
> "ret < 1" return value from it, and return values that indicate a key

Shouldn't that be "ret < 0"?

> doesn't exist. As a result the git_config_get_value_multi() function
> would either return a "const struct string_list *", or NULL.
> 
> By changing the *_multi() function to return an "int" for the status
> and to write to a "const struct string_list **dest" parameter we can
> avoid losing this information. API callers can now do:
> 
> 	const struct string_list *dest;
> 	int ret;
> 
> 	ret = git_config_get_value_multi(key, &dest);
> 	if (ret < 1)

This catches all negative values and zero.

> 		die("bad key: %s", key);
> 	else if (ret)

This catches all non-zero values.

> 		; /* key does not exist */
> 	else

So how could this ever be executed?!

> 		; /* got key, can use "dest" */
> 
> A "get_knownkey_value_multi" variant is also provided, which will
> BUG() out in the "ret < 1" case. This is useful in the cases where we

Shouldn't that be "ret < 0" as well?  The condition in that "knownkey"
variant added in this patch is:

  +	ret = configset_find_element(cs, key, &e);
  +	if (ret < 0 && knownkey)
  +		BUG("*_get_knownkey_*() only accepts known-good (hardcoded) keys, but '%s' is bad!", key);

> hardcode the keyname in our source code, and therefore use the more
> idiomatic pattern of:
> 
> 	if (!git_config_get_value_multi(key, &dest)
> 		; /* got key, can use "dest" */
> 	else
> 		; /* key does not exist */
> 
> The "knownkey" name was picked instead of e.g. "const" to avoid a
> repeat of the issues noted in f1de981e8b6 (config: fix leaks from
> git_config_get_string_const(), 2020-08-14) and 9a53219f69b (config:
> drop git_config_get_string_const(), 2020-08-17). API users might think
> that "const" means that the value(s) don't need to be free'd.
> 
> As noted in commentary here we treat git_die_config() as a
> special-case, i.e. we assume that a value we're complaining about has
> already had its key pass the git_config_parse_key() check.
> 
> Likewise we consider the keys passed to "t/helper/test-config.c" to be
> "knownkey", and will emit a BUG() if they don't pass
> git_config_parse_key(). Those will come from our *.sh tests, so
> they're also "known keys" coming from our sources.
> 
> A logical follow-up to this would be to change the various "*_get_*()"
> functions to ferry the git_configset_get_value() return value to their
> own callers, e.g.:
> 
> 	diff --git a/config.c b/config.c
> 	index 094ad899e0b..7e8ee4cfec1 100644
> 	--- a/config.c
> 	+++ b/config.c
> 	@@ -2479,11 +2479,14 @@ static int git_configset_get_string_tmp(struct config_set *cs, const char *key,
> 	 int git_configset_get_int(struct config_set *cs, const char *key, int *dest)
> 	 {
> 	 	const char *value;
> 	-	if (!git_configset_get_value(cs, key, &value)) {
> 	-		*dest = git_config_int(key, value);
> 	-		return 0;
> 	-	} else
> 	-		return 1;
> 	+	int ret;
> 	+
> 	+	if ((ret = git_configset_get_value(cs, key, &value)))
> 	+		goto done;
> 	+
> 	+	*dest = git_config_int(key, value);
> 	+done:
> 	+	return ret;
> 	 }
> 
> 	 int git_configset_get_ulong(struct config_set *cs, const char *key, unsigned long *dest)
> 
> Most of those callers don't care, and call those functions as
> "if (!func(...))", but if they do they'll be able to tell key
> non-existence from errors we encounter. Before this change those API
> users would have been unable to tell the two conditions apart, as
> git_configset_get_value() hid the difference.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/for-each-repo.c     |  5 +-
>  builtin/gc.c                |  6 +--
>  builtin/log.c               |  6 +--
>  builtin/submodule--helper.c |  6 ++-
>  config.c                    | 94 ++++++++++++++++++++++++++++++-------
>  config.h                    | 52 ++++++++++++++++----
>  pack-bitmap.c               |  7 ++-
>  submodule.c                 |  3 +-
>  t/helper/test-config.c      |  6 +--
>  versioncmp.c                | 10 ++--
>  10 files changed, 148 insertions(+), 47 deletions(-)
> 
> diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
> index fd86e5a8619..b01721762ef 100644
> --- a/builtin/for-each-repo.c
> +++ b/builtin/for-each-repo.c
> @@ -28,7 +28,7 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
>  {
>  	static const char *config_key = NULL;
>  	int i, result = 0;
> -	const struct string_list *values;
> +	const struct string_list *values = NULL;
>  
>  	const struct option options[] = {
>  		OPT_STRING(0, "config", &config_key, N_("config"),
> @@ -42,8 +42,7 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
>  	if (!config_key)
>  		die(_("missing --config=<config>"));
>  
> -	values = repo_config_get_value_multi(the_repository,
> -					     config_key);
> +	repo_config_get_value_multi(the_repository, config_key, &values);
>  
>  	/*
>  	 * Do nothing on an empty list, which is equivalent to the case
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 243ee85d283..04c48638ef4 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1485,8 +1485,7 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
>  	else
>  		git_config_set("maintenance.strategy", "incremental");
>  
> -	list = git_config_get_value_multi(key);
> -	if (list) {
> +	if (!git_config_get_knownkey_value_multi(key, &list)) {
>  		for_each_string_list_item(item, list) {
>  			if (!strcmp(maintpath, item->string)) {
>  				found = 1;
> @@ -1542,8 +1541,7 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
>  		usage_with_options(builtin_maintenance_unregister_usage,
>  				   options);
>  
> -	list = git_config_get_value_multi(key);
> -	if (list) {
> +	if (!git_config_get_knownkey_value_multi(key, &list)) {
>  		for_each_string_list_item(item, list) {
>  			if (!strcmp(maintpath, item->string)) {
>  				found = 1;
> diff --git a/builtin/log.c b/builtin/log.c
> index ee19dc5d450..75464c96ccf 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -182,10 +182,10 @@ static void set_default_decoration_filter(struct decoration_filter *decoration_f
>  	int i;
>  	char *value = NULL;
>  	struct string_list *include = decoration_filter->include_ref_pattern;
> -	const struct string_list *config_exclude =
> -			git_config_get_value_multi("log.excludeDecoration");
> +	const struct string_list *config_exclude;
>  
> -	if (config_exclude) {
> +	if (!git_config_get_knownkey_value_multi("log.excludeDecoration",
> +					      &config_exclude)) {
>  		struct string_list_item *item;
>  		for_each_string_list_item(item, config_exclude)
>  			string_list_append(decoration_filter->exclude_ref_config_pattern,
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 0b4acb442b2..1f8fe6a8e0d 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -541,6 +541,7 @@ static int module_init(int argc, const char **argv, const char *prefix)
>  		NULL
>  	};
>  	int ret = 1;
> +	const struct string_list *values;
>  
>  	argc = parse_options(argc, argv, prefix, module_init_options,
>  			     git_submodule_helper_usage, 0);
> @@ -552,7 +553,7 @@ static int module_init(int argc, const char **argv, const char *prefix)
>  	 * If there are no path args and submodule.active is set then,
>  	 * by default, only initialize 'active' modules.
>  	 */
> -	if (!argc && git_config_get_value_multi("submodule.active"))
> +	if (!argc && !git_config_get_value_multi("submodule.active", &values))
>  		module_list_active(&list);
>  
>  	info.prefix = prefix;
> @@ -2708,6 +2709,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
>  	if (opt.init) {
>  		struct module_list list = MODULE_LIST_INIT;
>  		struct init_cb info = INIT_CB_INIT;
> +		const struct string_list *values;
>  
>  		if (module_list_compute(argc, argv, opt.prefix,
>  					&pathspec2, &list) < 0) {
> @@ -2720,7 +2722,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
>  		 * If there are no path args and submodule.active is set then,
>  		 * by default, only initialize 'active' modules.
>  		 */
> -		if (!argc && git_config_get_value_multi("submodule.active"))
> +		if (!argc && !git_config_get_value_multi("submodule.active", &values))
>  			module_list_active(&list);
>  
>  		info.prefix = opt.prefix;
> diff --git a/config.c b/config.c
> index cbb5a3bab74..2100b29b689 100644
> --- a/config.c
> +++ b/config.c
> @@ -2275,23 +2275,28 @@ void read_very_early_config(config_fn_t cb, void *data)
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
> +	if (ret < 0)
> +		return ret;
>  
>  	hashmap_entry_init(&k.ent, strhash(normalized_key));
>  	k.key = normalized_key;
>  	found_entry = hashmap_get_entry(&cs->config_hash, &k, ent, NULL);
>  	free(normalized_key);
> -	return found_entry;
> +	*dest = found_entry;
> +	return 0;
>  }
>  
>  static int configset_add_value(struct config_set *cs, const char *key, const char *value)
> @@ -2300,8 +2305,11 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
>  	struct string_list_item *si;
>  	struct configset_list_item *l_item;
>  	struct key_value_info *kv_info = xmalloc(sizeof(*kv_info));
> +	int ret;
>  
> -	e = configset_find_element(cs, key);
> +	ret = configset_find_element(cs, key, &e);
> +	if (ret < 0)
> +		return ret;
>  	/*
>  	 * Since the keys are being fed by git_config*() callback mechanism, they
>  	 * are already normalized. So simply add them without any further munging.
> @@ -2400,24 +2408,54 @@ int git_configset_add_parameters(struct config_set *cs)
>  int git_configset_get_value(struct config_set *cs, const char *key, const char **value)
>  {
>  	const struct string_list *values = NULL;
> +	int ret;
> +
>  	/*
>  	 * Follows "last one wins" semantic, i.e., if there are multiple matches for the
>  	 * queried key in the files of the configset, the value returned will be the last
>  	 * value in the value list for that key.
>  	 */
> -	values = git_configset_get_value_multi(cs, key);
> +	ret = git_configset_get_value_multi(cs, key, &values);
>  
> -	if (!values)
> +	if (ret < 0)
> +		return ret;
> +	else if (!values)
>  		return 1;
>  	assert(values->nr > 0);
>  	*value = values->items[values->nr - 1].string;
>  	return 0;
>  }
>  
> -const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key)
> +static int git_configset_get_value_multi_1(struct config_set *cs, const char *key,
> +					   const struct string_list **dest,
> +					   int knownkey)
>  {
> -	struct config_set_element *e = configset_find_element(cs, key);
> -	return e ? &e->value_list : NULL;
> +	struct config_set_element *e;
> +	int ret;
> +
> +	ret = configset_find_element(cs, key, &e);
> +	if (ret < 0 && knownkey)
> +		BUG("*_get_knownkey_*() only accepts known-good (hardcoded) keys, but '%s' is bad!", key);
> +	else if (ret < 0)
> +		return ret;
> +	else if (!e)
> +		return 1;
> +	*dest = &e->value_list;
> +
> +	return 0;
> +}
> +
> +int git_configset_get_value_multi(struct config_set *cs, const char *key,
> +				  const struct string_list **dest)
> +{
> +	return git_configset_get_value_multi_1(cs, key, dest, 0);
> +}
> +
> +int git_configset_get_knownkey_value_multi(struct config_set *cs,
> +					   const char *const key,
> +					   const struct string_list **dest)
> +{
> +	return git_configset_get_value_multi_1(cs, key, dest, 1);
>  }
>  
>  int git_configset_get_string(struct config_set *cs, const char *key, char **dest)
> @@ -2563,11 +2601,20 @@ int repo_config_get_value(struct repository *repo,
>  	return git_configset_get_value(repo->config, key, value);
>  }
>  
> -const struct string_list *repo_config_get_value_multi(struct repository *repo,
> -						      const char *key)
> +int repo_config_get_value_multi(struct repository *repo,
> +				const char *key,
> +				const struct string_list **dest)
>  {
>  	git_config_check_init(repo);
> -	return git_configset_get_value_multi(repo->config, key);
> +	return git_configset_get_value_multi(repo->config, key, dest);
> +}
> +
> +int repo_config_get_knownkey_value_multi(struct repository *repo,
> +					 const char *const key,
> +					 const struct string_list **dest)
> +{
> +	git_config_check_init(repo);
> +	return git_configset_get_knownkey_value_multi(repo->config, key, dest);
>  }
>  
>  int repo_config_get_string(struct repository *repo,
> @@ -2684,9 +2731,15 @@ int git_config_get_value(const char *key, const char **value)
>  	return repo_config_get_value(the_repository, key, value);
>  }
>  
> -const struct string_list *git_config_get_value_multi(const char *key)
> +int git_config_get_value_multi(const char *key, const struct string_list **dest)
> +{
> +	return repo_config_get_value_multi(the_repository, key, dest);
> +}
> +
> +int git_config_get_knownkey_value_multi(const char *const key,
> +					const struct string_list **dest)
>  {
> -	return repo_config_get_value_multi(the_repository, key);
> +	return repo_config_get_knownkey_value_multi(the_repository, key, dest);
>  }
>  
>  int git_config_get_string(const char *key, char **dest)
> @@ -2833,7 +2886,16 @@ void git_die_config(const char *key, const char *err, ...)
>  		error_fn(err, params);
>  		va_end(params);
>  	}
> -	values = git_config_get_value_multi(key);
> +
> +	/*
> +	 * We don't have a "const" key here, but we should definitely
> +	 * have one that's passed git_config_parse_key() already, if
> +	 * we're at the point of complaining about its value. So let's
> +	 * use *_knownkey_value_multi() here to get that BUG(...).
> +	 */
> +	if (git_config_get_knownkey_value_multi(key, &values))
> +		BUG("key '%s' does not exist, should not be given to git_die_config()",
> +		    key);
>  	kv_info = values->items[values->nr - 1].util;
>  	git_die_config_linenr(key, kv_info->filename, kv_info->linenr);
>  }
> diff --git a/config.h b/config.h
> index ca994d77147..c88619b7dcf 100644
> --- a/config.h
> +++ b/config.h
> @@ -457,11 +457,30 @@ int git_configset_add_parameters(struct config_set *cs);
>  
>  /**
>   * Finds and returns the value list, sorted in order of increasing priority
> - * for the configuration variable `key` and config set `cs`. When the
> - * configuration variable `key` is not found, returns NULL. The caller
> - * should not free or modify the returned pointer, as it is owned by the cache.
> + * for the configuration variable `key` and config set `cs`.
> + *
> + * When the configuration variable `key` is not found, returns 1
> + * without touching `value`.
> + *
> + * The key will be parsed for validity with git_config_parse_key(), on
> + * error a negative value will be returned. See
> + * git_configset_get_knownkey_value_multi() for a version of this which
> + * BUG()s out on negative return values.
> + *
> + * The caller should not free or modify the returned pointer, as it is
> + * owned by the cache.
> + */
> +int git_configset_get_value_multi(struct config_set *cs, const char *key,
> +				  const struct string_list **dest);
> +
> +/**
> + * Like git_configset_get_value_multi(), but BUG()s out if the return
> + * value is < 0. Use it for keys known to pass git_config_parse_key(),
> + * i.e. those hardcoded in the code, and never user-provided keys.
>   */
> -const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key);
> +int git_configset_get_knownkey_value_multi(struct config_set *cs,
> +					   const char *const key,
> +					   const struct string_list **dest);
>  
>  /**
>   * Clears `config_set` structure, removes all saved variable-value pairs.
> @@ -495,8 +514,12 @@ struct repository;
>  void repo_config(struct repository *repo, config_fn_t fn, void *data);
>  int repo_config_get_value(struct repository *repo,
>  			  const char *key, const char **value);
> -const struct string_list *repo_config_get_value_multi(struct repository *repo,
> -						      const char *key);
> +int repo_config_get_value_multi(struct repository *repo,
> +				const char *key,
> +				const struct string_list **dest);
> +int repo_config_get_knownkey_value_multi(struct repository *repo,
> +					 const char *const key,
> +					 const struct string_list **dest);
>  int repo_config_get_string(struct repository *repo,
>  			   const char *key, char **dest);
>  int repo_config_get_string_tmp(struct repository *repo,
> @@ -543,10 +566,21 @@ int git_config_get_value(const char *key, const char **value);
>  /**
>   * Finds and returns the value list, sorted in order of increasing priority
>   * for the configuration variable `key`. When the configuration variable
> - * `key` is not found, returns NULL. The caller should not free or modify
> - * the returned pointer, as it is owned by the cache.
> + * `key` is not found, returns 1 without touching `value`.
> + *
> + * The caller should not free or modify the returned pointer, as it is
> + * owned by the cache.
> + */
> +int git_config_get_value_multi(const char *key,
> +			       const struct string_list **dest);
> +
> +/**
> + * A wrapper for git_config_get_value_multi() which does for it what
> + * git_configset_get_knownkey_value_multi() does for
> + * git_configset_get_value_multi().
>   */
> -const struct string_list *git_config_get_value_multi(const char *key);
> +int git_config_get_knownkey_value_multi(const char *const key,
> +					const struct string_list **dest);
>  
>  /**
>   * Resets and invalidates the config cache.
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 440407f1be7..0b4e73abbfa 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -2301,7 +2301,12 @@ int bitmap_is_midx(struct bitmap_index *bitmap_git)
>  
>  const struct string_list *bitmap_preferred_tips(struct repository *r)
>  {
> -	return repo_config_get_value_multi(r, "pack.preferbitmaptips");
> +	const struct string_list *dest;
> +
> +	if (!repo_config_get_knownkey_value_multi(r, "pack.preferbitmaptips",
> +					       &dest))
> +		return dest;
> +	return NULL;
>  }
>  
>  int bitmap_is_preferred_refname(struct repository *r, const char *refname)
> diff --git a/submodule.c b/submodule.c
> index bf7a2c79183..e8c4362743d 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -274,8 +274,7 @@ int is_tree_submodule_active(struct repository *repo,
>  	free(key);
>  
>  	/* submodule.active is set */
> -	sl = repo_config_get_value_multi(repo, "submodule.active");
> -	if (sl) {
> +	if (!repo_config_get_knownkey_value_multi(repo, "submodule.active", &sl)) {
>  		struct pathspec ps;
>  		struct strvec args = STRVEC_INIT;
>  		const struct string_list_item *item;
> diff --git a/t/helper/test-config.c b/t/helper/test-config.c
> index 4ba9eb65606..f0d476d2376 100644
> --- a/t/helper/test-config.c
> +++ b/t/helper/test-config.c
> @@ -95,8 +95,7 @@ int cmd__config(int argc, const char **argv)
>  			goto exit1;
>  		}
>  	} else if (argc == 3 && !strcmp(argv[1], "get_value_multi")) {
> -		strptr = git_config_get_value_multi(argv[2]);
> -		if (strptr) {
> +		if (!git_config_get_knownkey_value_multi(argv[2], &strptr)) {
>  			for (i = 0; i < strptr->nr; i++) {
>  				v = strptr->items[i].string;
>  				if (!v)
> @@ -159,8 +158,7 @@ int cmd__config(int argc, const char **argv)
>  				goto exit2;
>  			}
>  		}
> -		strptr = git_configset_get_value_multi(&cs, argv[2]);
> -		if (strptr) {
> +		if (!git_configset_get_knownkey_value_multi(&cs, argv[2], &strptr)) {
>  			for (i = 0; i < strptr->nr; i++) {
>  				v = strptr->items[i].string;
>  				if (!v)
> diff --git a/versioncmp.c b/versioncmp.c
> index 069ee94a4d7..9064478dc4a 100644
> --- a/versioncmp.c
> +++ b/versioncmp.c
> @@ -160,10 +160,14 @@ int versioncmp(const char *s1, const char *s2)
>  	}
>  
>  	if (!initialized) {
> -		const struct string_list *deprecated_prereleases;
> +		const struct string_list *deprecated_prereleases = NULL;
> +
>  		initialized = 1;
> -		prereleases = git_config_get_value_multi("versionsort.suffix");
> -		deprecated_prereleases = git_config_get_value_multi("versionsort.prereleasesuffix");
> +		git_config_get_knownkey_value_multi("versionsort.suffix",
> +						 &prereleases);
> +		git_config_get_value_multi("versionsort.prereleasesuffix",
> +					   &deprecated_prereleases);
> +
>  		if (prereleases) {
>  			if (deprecated_prereleases)
>  				warning("ignoring versionsort.prereleasesuffix because versionsort.suffix is set");
> -- 
> 2.38.0.1251.g3eefdfb5e7a
> 
