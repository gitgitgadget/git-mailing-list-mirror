Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F2A51F597
	for <e@80x24.org>; Wed, 18 Jul 2018 18:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbeGRTMJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 15:12:09 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54647 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeGRTMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 15:12:09 -0400
Received: by mail-wm0-f66.google.com with SMTP id c14-v6so3726792wmb.4
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 11:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BYQxxZsQT0Aik+CkIpbqPdMQVb7qyWxGQJcVPdhW0mA=;
        b=tqo1XILASgd5kgWwItS6mxWVMbWLiaY94GBjXGnKHTEQregPwAfLJRORuPBWzEQnV3
         dzQsCMtPudkpZ86usp6jYWfiErxJn4eT4YOtwO2LAFz+O41wunTSxKbzdSeGMvJzDfkL
         2uMrMYPqrpsQL4v7FOUegeLa3orv/UoQOCMpMwzcor4U7Y5NvURxc/vrh4K10h6iaDvk
         mXEpRqyaVdNJYMsWBMobKCuoemqUrn+wcJPWjV+o6umJhg4eAXVfta6xdF41vLkttqIz
         Cp6FaizwSPl3vrXG5AwOtvdoCJU7PttIVQtx6r7laqMytgPkolnxWZjp9lyylmsfjQtr
         OEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BYQxxZsQT0Aik+CkIpbqPdMQVb7qyWxGQJcVPdhW0mA=;
        b=IgBaUlh0tqsMe7mrsV7QrKWFOytPkI6Rqx1ddcZtCBK3FWTL+BJqRAeJPzoeNJ4jN0
         hs1e042YZlPtM0Eya4m3Ki9PFitqQw82m+kIProfUBy5sDs6VY0GhzD0UgFr8/Bysvw4
         htOrcLKlpuQ57B6BCGWKHncl+hCybIvgTwWsJVmKytkA74LzzAV0iYbWaY6/9ONT6Pl9
         bs7WDKCYTMnMcgFy+NMDnayxXIjCgDeQkStgc1zEQ2R0MQa7DxAFRZN77uSiLs65ASZ8
         gKlGb3A7k6yxgfqwLj7KQxL597tNNq8wv+Y3US/348EVICIwGwCD42Osr7MYzsJniQKR
         vdiw==
X-Gm-Message-State: AOUpUlFj79lnuI3av2TZYabQQmcamyOQ9CHJU3uX4/w65wY3pDYaph+b
        6PIKvYxLRmsyZLJnyw6fo/s=
X-Google-Smtp-Source: AAOMgpeQMWQGUIwSZMrDn174/CWkSPRwzAwzPztbdeoTpc8JKwVIuICUCv2E5sik5+Bd6R4hMH+WSQ==
X-Received: by 2002:a7b:c058:: with SMTP id u24-v6mr2306889wmc.136.1531938777889;
        Wed, 18 Jul 2018 11:32:57 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p3-v6sm3008067wrg.47.2018.07.18.11.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 11:32:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Stefan Beller via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jnareb@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/8] refs.c: upgrade for_each_replace_ref to be a each_repo_ref_fn callback
References: <pull.11.git.gitgitgadget@gmail.com>
        <22dc9ce8364dd20876ab5eb626ecc6a7396d3b3e.1531926932.git.gitgitgadget@gmail.com>
Date:   Wed, 18 Jul 2018 11:32:56 -0700
In-Reply-To: <22dc9ce8364dd20876ab5eb626ecc6a7396d3b3e.1531926932.git.gitgitgadget@gmail.com>
        (Stefan Beller via GitGitGadget's message of "Wed, 18 Jul 2018
        08:15:37 -0700 (PDT)")
Message-ID: <xmqqd0vkjsx3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Stefan Beller via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Stefan Beller <sbeller@google.com>
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/replace.c | 8 ++++----
>  refs.c            | 9 ++++-----
>  refs.h            | 2 +-
>  replace-object.c  | 5 +++--
>  4 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/builtin/replace.c b/builtin/replace.c
> index ef22d724b..d0b1cdb06 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -39,7 +39,8 @@ struct show_data {
>  	enum replace_format format;
>  };
>  
> -static int show_reference(const char *refname, const struct object_id *oid,
> +static int show_reference(struct repository *r, const char *refname,
> +			  const struct object_id *oid,
>  			  int flag, void *cb_data)
>  {
>  	struct show_data *data = cb_data;
> @@ -56,9 +57,8 @@ static int show_reference(const char *refname, const struct object_id *oid,
>  			if (get_oid(refname, &object))
>  				return error("Failed to resolve '%s' as a valid ref.", refname);
>  
> -			obj_type = oid_object_info(the_repository, &object,
> -						   NULL);
> -			repl_type = oid_object_info(the_repository, oid, NULL);
> +			obj_type = oid_object_info(r, &object, NULL);
> +			repl_type = oid_object_info(r, oid, NULL);
>  
>  			printf("%s (%s) -> %s (%s)\n", refname, type_name(obj_type),
>  			       oid_to_hex(oid), type_name(repl_type));
> diff --git a/refs.c b/refs.c
> index 2513f77ac..5700cd468 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1478,12 +1478,11 @@ int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
>  	return do_for_each_ref(refs, prefix, fn, 0, flag, cb_data);
>  }
>  
> -int for_each_replace_ref(struct repository *r, each_ref_fn fn, void *cb_data)
> +int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data)
>  {
> -	return do_for_each_ref(get_main_ref_store(r),
> -			       git_replace_ref_base, fn,
> -			       strlen(git_replace_ref_base),
> -			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
> +	return do_for_each_repo_ref(r, git_replace_ref_base, fn,
> +				    strlen(git_replace_ref_base),
> +				    DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
>  }
>  
>  int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
> diff --git a/refs.h b/refs.h
> index 80eec8bbc..a0a18223a 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -317,7 +317,7 @@ int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
>  int for_each_tag_ref(each_ref_fn fn, void *cb_data);
>  int for_each_branch_ref(each_ref_fn fn, void *cb_data);
>  int for_each_remote_ref(each_ref_fn fn, void *cb_data);
> -int for_each_replace_ref(struct repository *r, each_ref_fn fn, void *cb_data);
> +int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data);

With a signature change like this, any change that introduces new
call to for_each_replace_ref() using eac_ref_fn() would get
compilation error, so this is minimally correct.

Two things that bothersome are that

 - for_each_tag/branch/remote_ref() and for_each_replace_ref() now
   work and look quite differently.

 - existing users of for_each_replace_ref() who were all happy
   working in the_repository have to pass it explicitly, even
   thought they do not have any need to.

In this case, even if you introduced for_each_replace_ref_in_repo(),
making for_each_replace_ref() a thin wrapper that always uses
the_repository is a bit more cumbersome than just a simple macro.

But it *is* doable (you'd need to use a wrapping structure around
cb_data), and a developer who case about maintainability during API
transition would have taken pains to do so.  A bit dissapointing.

>  int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
>  int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
>  			 const char *prefix, void *cb_data);
> diff --git a/replace-object.c b/replace-object.c
> index 801b5c167..017f02f8e 100644
> --- a/replace-object.c
> +++ b/replace-object.c
> @@ -6,7 +6,8 @@
>  #include "repository.h"
>  #include "commit.h"
>  
> -static int register_replace_ref(const char *refname,
> +static int register_replace_ref(struct repository *r,
> +				const char *refname,
>  				const struct object_id *oid,
>  				int flag, void *cb_data)
>  {
> @@ -25,7 +26,7 @@ static int register_replace_ref(const char *refname,
>  	oidcpy(&repl_obj->replacement, oid);
>  
>  	/* Register new object */
> -	if (oidmap_put(the_repository->objects->replace_map, repl_obj))
> +	if (oidmap_put(r->objects->replace_map, repl_obj))
>  		die("duplicate replace ref: %s", refname);
>  
>  	return 0;
