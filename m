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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADA7C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 21:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 216FB6105A
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 21:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbhHKVea (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 17:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhHKVe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 17:34:29 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4ECC061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 14:34:05 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d1so4493060pll.1
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 14:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PKsZwhIt2v50rh3GnE6lx3NQ1LcbPcjBKa/IemG1j4s=;
        b=aT3PYyeW31UlUwxNIo7MRVPowDlLeFPsl5iLzefOUOyWQ8ebExGGOiB0ss+JaABuqS
         k20SNDGy8u0WFpWAiIhU7W0XXTfh/iaAYdV15ZDtNhS9O3kIPSh5UxtzrxKcSmLWj5wp
         HPabFz4c8rTXiWM1zU/FDM8Njmxwwdu2LNzj9EGAOSpdrVz0PMse8Mi1BiHIxaU05Jd4
         gmktihtywSlSS8VBJkrAwrL8VX2y3Y5GDqf9Chg4R6RM/QjtVVbNKBrZXmMyK1NWenDf
         08evKKYjbIsdEG8eJo6iHrg4mL3Xlz6Aiu2Vrdm502jY+mWR63PpIFKiM73vvlhmKFHH
         v5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PKsZwhIt2v50rh3GnE6lx3NQ1LcbPcjBKa/IemG1j4s=;
        b=ZEwpoq4qjeagJ6+YETbwNWvAPxYRzD8K0z97nhA4liXJXRaNCJEi3fMtLzFV9Gt8aq
         XySEwKCkXJRgkovAB7NsInFRZgKYgu6UdNEfV9gcBSFLXYamNsVb9J6BokPmoL3Frqn8
         DZxqxJ/aaOCBJidOP8c2etO1yTxRqNhDWH8wbS1vLmTju08Bnu0JROclW1MtE3BrhzuH
         rtYdTyTSNfcDzF2MDK+Ygnp7PPo3GFS+6FPxOHKodq8QEc7nYd4prFvDWpv7DtlPT+ld
         CiR6ENhaqRlffFoF7j4vFlBkJSk2yCrpCOO06/kWuimE8yXosIDF9KMMee7rv2wtw4+T
         /e/Q==
X-Gm-Message-State: AOAM531eodLjOvp8xszsAasYh5f3++EcZg9NHHqltkTsWooyPu1MUcPZ
        lPZ0amJLrsAJlRQEFfYmPcVTEw==
X-Google-Smtp-Source: ABdhPJywotGYjM/17WIM46C3nPT08Aljw7OU2vxeI4jpotBg2ZxF0P3YKhSJlSYfBaU2bBLh4WvUug==
X-Received: by 2002:aa7:8052:0:b029:3e0:1fed:e622 with SMTP id y18-20020aa780520000b02903e01fede622mr837320pfm.54.1628717645178;
        Wed, 11 Aug 2021 14:34:05 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:1377:1116:63ab:bf4b])
        by smtp.gmail.com with ESMTPSA id d134sm529604pfd.60.2021.08.11.14.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 14:34:04 -0700 (PDT)
Date:   Wed, 11 Aug 2021 14:33:56 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/7] submodule: lazily add submodule ODBs as alternates
Message-ID: <YRRCRHTgXU2x+s0l@google.com>
References: <cover.1628618950.git.jonathantanmy@google.com>
 <5994a517e8afc345e8f649b2368756e22b0e9ebe.1628618950.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5994a517e8afc345e8f649b2368756e22b0e9ebe.1628618950.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 10, 2021 at 11:28:39AM -0700, Jonathan Tan wrote:
> diff --git a/object-file.c b/object-file.c
> index 3d27dc8dea..621b121bcb 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -32,6 +32,7 @@
>  #include "packfile.h"
>  #include "object-store.h"
>  #include "promisor-remote.h"
> +#include "submodule.h"
>  
>  /* The maximum size for an object header. */
>  #define MAX_HEADER_LEN 32
> @@ -1592,6 +1593,10 @@ static int do_oid_object_info_extended(struct repository *r,
>  				break;
>  		}
>  
> +		if (register_all_submodule_odb_as_alternates())
> +			/* We added some alternates; retry */
> +			continue;
> +

Ok, this is where we finally get around to loading the alternate much
later. Fine.

>  		/* Check if it is a missing object */
>  		if (fetch_if_missing && repo_has_promisor_remote(r) &&
>  		    !already_retried &&
> diff --git a/submodule.c b/submodule.c
> index 8e611fe1db..8fde90e906 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -165,6 +165,8 @@ void stage_updated_gitmodules(struct index_state *istate)
>  		die(_("staging updated .gitmodules failed"));
>  }
>  
> +static struct string_list added_submodule_odb_paths = STRING_LIST_INIT_NODUP;
> +
>  /* TODO: remove this function, use repo_submodule_init instead. */
>  int add_submodule_odb(const char *path)
>  {
> @@ -178,12 +180,28 @@ int add_submodule_odb(const char *path)
>  		ret = -1;
>  		goto done;
>  	}
> -	add_to_alternates_memory(objects_directory.buf);
> +	string_list_insert(&added_submodule_odb_paths,
> +			   strbuf_detach(&objects_directory, NULL));

And here is where we hijack the usual alternate load and put the path
into the lazy load list instead. Ok.

>  done:
>  	strbuf_release(&objects_directory);
>  	return ret;
>  }
>  
> +int register_all_submodule_odb_as_alternates(void)
> +{
> +	int i;
> +	int ret = added_submodule_odb_paths.nr;
> +
> +	for (i = 0; i < added_submodule_odb_paths.nr; i++)
> +		add_to_alternates_memory(added_submodule_odb_paths.items[i].string);
> +	if (ret) {
> +		string_list_clear(&added_submodule_odb_paths, 0);
> +		if (git_env_bool("GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB", 0))
> +			BUG("register_all_submodule_odb_as_alternates() called");

Nice, and this is the flag you mentioned in the cover letter to complain
if we're trying to use alternates to access submodule objects. This will
be useful for finding out other random places where we are using that
weird hack.

> +	}
> +	return ret;
> +}
> +
>  void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
>  					     const char *path)
>  {
> diff --git a/submodule.h b/submodule.h
> index 84640c49c1..c252784bc2 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -97,7 +97,14 @@ int submodule_uses_gitfile(const char *path);
>  #define SUBMODULE_REMOVAL_IGNORE_IGNORED_UNTRACKED (1<<2)
>  int bad_to_remove_submodule(const char *path, unsigned flags);
>  
> +/*
> + * Call add_submodule_odb() to add the submodule at the given path to a list.
> + * When register_all_submodule_odb_as_alternates() is called, the object stores
> + * of all submodules in that list will be added as alternates in
> + * the_repository.
> + */
>  int add_submodule_odb(const char *path);
> +int register_all_submodule_odb_as_alternates(void);

Does it need to be public? Could this be a static in submodule.c
instead?

>  
>  /*
>   * Checks if there are submodule changes in a..b. If a is the null OID,
> diff --git a/t/README b/t/README
> index 9e70122302..8b67b4f00b 100644
> --- a/t/README
> +++ b/t/README
> @@ -448,6 +448,16 @@ GIT_TEST_CHECKOUT_WORKERS=<n> overrides the 'checkout.workers' setting
>  to <n> and 'checkout.thresholdForParallelism' to 0, forcing the
>  execution of the parallel-checkout code.
>  
> +GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=<boolean>, when true, makes
> +registering submodule ODBs as alternates a fatal action. Support for
> +this environment variable can be removed once the migration to
> +explicitly providing repositories when accessing submodule objects is
> +complete (in which case we might want to replace this with a trace2
> +call so that users can make it visible if accessing submodule objects
> +without an explicit repository still happens) or needs to be abandoned
> +for whatever reason (in which case the migrated codepaths still retain
> +their performance benefits).
> +
>  Naming Tests
>  ------------
>  
> -- 
> 2.33.0.rc1.237.g0d66db33f3-goog
> 

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
