Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949C7221540
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 12:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769084025; cv=none; b=fZXpi8ZaLgMEeB9BmQCNgKrOO6D3I3xLrr70BnpQJNQFNXXwCfaT/u/mGLSATuFOlpvI2mLe9r3Hw4f+ppffkxE/KsIzOcEc1QnpTENBRoqEuMGxK4wj4GkH5vO4BAACI3Jt57qeiNrMvG4SwpP5utACZE6Erx7w15HtW2OOh+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769084025; c=relaxed/simple;
	bh=62YF8mfAj4yTgaqdfO8N42Bh1X1ZcwLM7QTNl+3NbYc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GxyHQGYS2Am0GQPyHpih7WCWUCqwwQ4GuIRryKHvVymIN7g01nAPrKW63gAI7Mxw2L/38OblNyA+bjHiRlk7BjOWL43HoJ0TDItuLkdMDH68M85jaXvL2CH+VauT8+Z42phAV59hqyFheJnNEQUqvV76WFD0ZWYn2eOyGFy51Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=D7MOyz3/; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="D7MOyz3/"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1769084017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1tEX/tvxGWnh1R1jYCVdJ5EDB3ZAyWTeCTnRS8s60Ng=;
	b=D7MOyz3/pVyotkCr1Tyzo1HYBFKzWpc+b0cgyCbmtyDU7ZB1e1eEjZbQylll6DyIsWXWxg
	iWgKWiLxa8ZJwtuu1p8ZRa+0bNnI/0C4kv88oAwUVT1K3kOfcuwIQ6qBNUgnt1kTpK/+Sv
	5dINYpBy2HI41VGRgdBysn72gMbvei4=
From: Toon Claes <toon@iotcl.com>
To: Olamide Caleb Bello <belkid98@gmail.com>, git@vger.kernel.org
Cc: phillip.wood123@gmail.com, gitster@pobox.com,
 christian.couder@gmail.com, usmanakinyemi202@gmail.com,
 kaartic.sivaraam@gmail.com, me@ttaylorr.com, karthik.188@gmail.com,
 Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [Outreachy PATCH v3 1/3] environment: stop storing
 `core.attributesFile` globally
In-Reply-To: <1aa41da8334296e4c1063b81fc40ec3b1dcdcb7b.1768681947.git.belkid98@gmail.com>
References: <cover.1768681947.git.belkid98@gmail.com>
 <1aa41da8334296e4c1063b81fc40ec3b1dcdcb7b.1768681947.git.belkid98@gmail.com>
Date: Thu, 22 Jan 2026 13:13:20 +0100
Message-ID: <871pjhkfq7.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Olamide Caleb Bello <belkid98@gmail.com> writes:

> The config value is parsed in git_default_core_config(), loaded

I assume you mean 'core.attributesFile' because it's in the title. But
personnally I don't mind seeing the name repeated in the body to make it
more clear.

> eagerly and stored in the global variable `git_attributes_file`.
> Storing this value in a global variable can lead to unexpected
> behaviours when more than one Git repository run in the same Git process.
>
> Create a new struct `repo_config_values` to hold this value and
> other repository dependent values parsed by `git_default_config()` and
> can be accessed per repository via `git_default_config()`.

I'd suggest to split off the part after the second 'and' into a new
sentence.

> This will ensure the current behaviour remains the same while also
> enabling the libification of Git.

How is this true? Was that value already accessible through
`git_default_config()`? 

> It is important to note that `git_default_config()` is a wrapper to other
> `git_default_*_config()` such as `git_default_core_config()`.

I'd suggest to insert 'functions' before 'such'.

> Therefore to access and modify this global variable,
> the change has to be made in the function which parses and
> stores the value in the global variable.

This doesn't clarify much for me. Do you mean 'git_attr_global_file()'
and 'git_default_core_config()'?

>
> Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
> ---
>  attr.c        |  7 ++++---
>  environment.c | 12 +++++++++---
>  environment.h |  9 ++++++++-
>  repository.c  |  1 +
>  repository.h  |  4 ++++
>  5 files changed, 26 insertions(+), 7 deletions(-)
>
> diff --git a/attr.c b/attr.c
> index 4999b7e09d..fbb9eaffaf 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -881,10 +881,11 @@ const char *git_attr_system_file(void)
>  
>  const char *git_attr_global_file(void)
>  {
> -	if (!git_attributes_file)
> -		git_attributes_file = xdg_config_home("attributes");
> +	struct repo_config_values *cfg = &the_repository->config_values;

Is 'cfg' guaranteed to be != NULL?

> +	if (!cfg->attributes_file_path)
> +		cfg->attributes_file_path = xdg_config_home("attributes");
>  
> -	return git_attributes_file;
> +	return cfg->attributes_file_path;
>  }
>  
>  int git_attr_system_is_enabled(void)
> diff --git a/environment.c b/environment.c
> index a770b5921d..283db0a1a0 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -53,7 +53,6 @@ char *git_commit_encoding;
>  char *git_log_output_encoding;
>  char *apply_default_whitespace;
>  char *apply_default_ignorewhitespace;
> -char *git_attributes_file;
>  int zlib_compression_level = Z_BEST_SPEED;
>  int pack_compression_level = Z_DEFAULT_COMPRESSION;
>  int fsync_object_files = -1;
> @@ -327,6 +326,8 @@ static enum fsync_component parse_fsync_components(const char *var, const char *
>  static int git_default_core_config(const char *var, const char *value,
>  				   const struct config_context *ctx, void *cb)
>  {
> +	struct repo_config_values *cfg = &the_repository->config_values;
> +
>  	/* This needs a better name */
>  	if (!strcmp(var, "core.filemode")) {
>  		trust_executable_bit = git_config_bool(var, value);
> @@ -364,8 +365,8 @@ static int git_default_core_config(const char *var, const char *value,
>  	}
>  
>  	if (!strcmp(var, "core.attributesfile")) {
> -		FREE_AND_NULL(git_attributes_file);
> -		return git_config_pathname(&git_attributes_file, var, value);
> +		FREE_AND_NULL(cfg->attributes_file_path);
> +		return git_config_pathname(&cfg->attributes_file_path, var, value);
>  	}
>  
>  	if (!strcmp(var, "core.bare")) {
> @@ -756,3 +757,8 @@ int git_default_config(const char *var, const char *value,
>  	/* Add other config variables here and to Documentation/config.adoc. */
>  	return 0;
>  }
> +
> +void repo_config_values_init(struct repo_config_values *cfg)
> +{
> +	cfg->attributes_file_path = NULL;
> +}

I assume the reason for adding this function becomes clear in a later
commit?

> diff --git a/environment.h b/environment.h
> index 51898c99cd..aea73ff25b 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -84,6 +84,12 @@ extern const char * const local_repo_env[];
>  
>  struct strvec;
>  
> +/* Config values parsed by git_default_config() */

Mentioning here they get filled from git_default_config() doesn't feel
really correct? Although I'm sure what comment would fit better, maybe
just drop the comment above the struct. I see you have a similar comment
in 'struct repository', where it *does* make sense.

> +struct repo_config_values {
> +	/* core config values */

I prefer emphasizing it's the "section 'core'" or something like that.

> +	char *attributes_file_path;

Would it be overkill to append: /* `core.attributesFile` */? This can
help when grepping through the codebase to find where some settings are
being parsed into. What do you think?

> +};
> +
>  /*
>   * Wrapper of getenv() that returns a strdup value. This value is kept
>   * in argv to be freed later.
> @@ -107,6 +113,8 @@ const char *strip_namespace(const char *namespaced_ref);
>  int git_default_config(const char *, const char *,
>  		       const struct config_context *, void *);
>  
> +void repo_config_values_init(struct repo_config_values *cfg);
> +
>  /*
>   * TODO: All the below state either explicitly or implicitly relies on
>   * `the_repository`. We should eventually get rid of these and make the
> @@ -152,7 +160,6 @@ extern int assume_unchanged;
>  extern int warn_on_object_refname_ambiguity;
>  extern char *apply_default_whitespace;
>  extern char *apply_default_ignorewhitespace;
> -extern char *git_attributes_file;
>  extern int zlib_compression_level;
>  extern int pack_compression_level;
>  extern unsigned long pack_size_limit_cfg;
> diff --git a/repository.c b/repository.c
> index c7e75215ac..d308cd78bf 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -57,6 +57,7 @@ void initialize_repository(struct repository *repo)
>  	ALLOC_ARRAY(repo->index, 1);
>  	index_state_init(repo->index, repo);
>  	repo->check_deprecated_config = true;
> +	repo_config_values_init(&repo->config_values);
>  
>  	/*
>  	 * When a command runs inside a repository, it learns what
> diff --git a/repository.h b/repository.h
> index 6063c4b846..638a142577 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -3,6 +3,7 @@
>  
>  #include "strmap.h"
>  #include "repo-settings.h"
> +#include "environment.h"
>  
>  struct config_set;
>  struct git_hash_algo;
> @@ -148,6 +149,9 @@ struct repository {
>  	/* Repository's compatibility hash algorithm. */
>  	const struct git_hash_algo *compat_hash_algo;
>  
> +	/* Repository's config values parsed by git_default_config() */
> +	struct repo_config_values config_values;
> +
>  	/* Repository's reference storage format, as serialized on disk. */
>  	enum ref_storage_format ref_storage_format;
>  
> -- 
> 2.34.1
>
>

-- 
Cheers,
Toon
