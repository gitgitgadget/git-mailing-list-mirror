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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAE9C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 21:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAFAB61019
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 21:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhHKVhO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 17:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhHKVhM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 17:37:12 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D742C061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 14:36:48 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n12so3819752plf.4
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 14:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FlkqmzAZAXIM1tO0P8tn4VMsBsv3gSmkMFFftciAoBI=;
        b=BpXGNFQ4r3mHuTkMCRrU0rOknY8wz7OPkgdhoBIyFBJOQdwKRhGae0y4l/8DYcU+X4
         9QScimItd78OxbXvTEWZQeVIjlYeHuVpjBOBV6K4lOtS2d7iO27J1B7z68AHiQJcH7G2
         vgPZuRqRUKBMplpYhm5+hKmJmu2zF5EHbGEzuZi9VV0IXIdA+qwkCr76GcOrpi4wVEaQ
         jge6VIKHS8kgl6zOXcvou5yWSM90ozQ4zi5wcZDsHlD826CZqqSRMCuXu29eOhFXvaAe
         uAHF06IP6UpUDGoJsf8VdH2762F62O5odLA/0uIHtNZsxBMLim4YOAxjnbQcFsf/kHAP
         fwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FlkqmzAZAXIM1tO0P8tn4VMsBsv3gSmkMFFftciAoBI=;
        b=i24VNsSnyWIuNeDrtOFfgaYScsNyrXRwhcAU2AO3SixayT7gT6me2v3zfqkpVamAfj
         c4RHv3UWPrnoYX3iLdFAR5Rcr0iyiB8HOcbaEZOMfnAxpgaXakybykbO2MhHzXPq4jf1
         kMh7mvG3aMW6qfpdZu49EmJ5ndfILgJJS3Zeu0EgMkhGk/OKAJmNTqrXTut22arqALak
         RTgaPteS28Z3nKXZLHKjGHFxXqjoogLhm0BA/rIAUznvIBZLxVYiknLaaQjEfhYnCyPY
         d77E4nY/V7Lb2rMlf8yZe9x2hmyaguej0MtwLa5YuVY5s+rxeCt0V5Z4+VuJZP04FqOP
         GYOw==
X-Gm-Message-State: AOAM5313nIOFQ2wZTRETjSeksArQyn9VENWhkBA0snQr+0demkjMSGbL
        M05xBhTLeQGKm607myQbhlvFe+3SUGXCWA==
X-Google-Smtp-Source: ABdhPJyB+EurmsxOQg/ChgGtQKnRQGN6LqCJbCFSOMjweaDcz5/UeZoVZRGv079jRorVydpXkrwhdw==
X-Received: by 2002:a62:824a:0:b029:3be:dcd5:b012 with SMTP id w71-20020a62824a0000b02903bedcd5b012mr805850pfd.61.1628717807870;
        Wed, 11 Aug 2021 14:36:47 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:1377:1116:63ab:bf4b])
        by smtp.gmail.com with ESMTPSA id k130sm508839pfd.219.2021.08.11.14.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 14:36:47 -0700 (PDT)
Date:   Wed, 11 Aug 2021 14:36:39 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/7] grep: use submodule-ODB-as-alternate lazy-addition
Message-ID: <YRRC528p06ByShE5@google.com>
References: <cover.1628618950.git.jonathantanmy@google.com>
 <31e9b914c4bb500a98fbb14674c93a0d8ece47a2.1628618950.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31e9b914c4bb500a98fbb14674c93a0d8ece47a2.1628618950.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 10, 2021 at 11:28:40AM -0700, Jonathan Tan wrote:
> 
> In the parent commit, Git was taught to add submodule ODBs as alternates
> lazily, but grep does not use this because it computes the path to add
> directly, not going through add_submodule_odb(). Add an equivalent to
> add_submodule_odb() that takes the exact ODB path and teach grep to use
> it.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/grep.c | 2 +-
>  submodule.c    | 5 +++++
>  submodule.h    | 1 +
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 7d2f8e5adb..87bcb934a2 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -450,7 +450,7 @@ static int grep_submodule(struct grep_opt *opt,
>  	 * store is no longer global and instead is a member of the repository
>  	 * object.
>  	 */
> -	add_to_alternates_memory(subrepo.objects->odb->path);
> +	add_submodule_odb_by_path(subrepo.objects->odb->path);

I had wondered whether we can entirely drop add_to_alternates_memory()
but I see on second reading that that's still used by
register_all_submodule_odb...(). I wonder if it can become static in
submodule.c to prevent users from dodging the envvar+BUG()?

>  	obj_read_unlock();
>  
>  	memcpy(&subopt, opt, sizeof(subopt));
> diff --git a/submodule.c b/submodule.c
> index 8fde90e906..8de1aecaeb 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -187,6 +187,11 @@ int add_submodule_odb(const char *path)
>  	return ret;
>  }
>  
> +void add_submodule_odb_by_path(const char *path)
> +{
> +	string_list_insert(&added_submodule_odb_paths, xstrdup(path));
> +}
> +
>  int register_all_submodule_odb_as_alternates(void)
>  {
>  	int i;
> diff --git a/submodule.h b/submodule.h
> index c252784bc2..17a06cc43b 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -104,6 +104,7 @@ int bad_to_remove_submodule(const char *path, unsigned flags);
>   * the_repository.
>   */
>  int add_submodule_odb(const char *path);
Curious whether add_submodule_odb() can be reduced by calling
add_submodule_odb_by_path() internally.
> +void add_submodule_odb_by_path(const char *path);
>  int register_all_submodule_odb_as_alternates(void);
>  
>  /*
> -- 
> 2.33.0.rc1.237.g0d66db33f3-goog
> 

These are all pretty minor comments; with or without them,

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
