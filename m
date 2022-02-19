Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F98C433F5
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 04:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241287AbiBSEIZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 23:08:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241282AbiBSEIX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 23:08:23 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7663F255A1
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 20:08:05 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id x3so18681831qvd.8
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 20:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jrWo15vzbVEGAIwFMNhXXu0WKaI1u60vtBq0r64i5gg=;
        b=pOCkwgGfu5byRegHqDgyDN44vyBvZWT3jjw4+D1UotHUmGYWBjH39PmxreIWah6dqY
         9z6fOSiOppNW7Kwt7Licqk/L/s/6lg9S2aowHqjF8gfgDP3hXIGPY2JWoVIlS+q78TQS
         buojzoeiZg9+jXaj5MYO3YM6ajLe2R98JsSSep+J0U3NW6jY5o6rhQM8mKK8AO/U9E3t
         rkfkl+Kp/dh6mihWxHqDkxwczzGjUtC6KzEvMwxVGTbE7ZRD/50tVwB4xD++Ke6Q+sLF
         g7P8nqBTh9cZW4zAR7rtIW2K6OOA2N0UcGqdXbd4B+zGE4ksMu9/Gevk5rUxT4027dDP
         uypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jrWo15vzbVEGAIwFMNhXXu0WKaI1u60vtBq0r64i5gg=;
        b=tkbKrW6RNLKFSLJSB5T1lCu9uBLxLHPGtJDxzB10rpC1tIXZwd+l5LFhCiQGNXzHYf
         rHTBoEAADnBQVTMhNdlFzjeysvk9PQaAaghoksdZB+nEj4OMJ7RIsqkSv4GLnzEgb5xZ
         WpEivcyhcDQvb9ORrWc2jVhXMC0dybCFsmGPL72EEs+uXv+zDTAnR32zf6DCsLdmgql9
         QrUgv5BMcQvZ0LNQd/7alO6mz7fosl0Fjp1sGQ1Nbj87tegxphR1QQ2srTNex2YljrSi
         khb5oCz7k3QyM2roMLo8R5nFLlgftl45xFbOvPR99pyBghNbPKXbc6YWQGRSgAK9uG6l
         egnw==
X-Gm-Message-State: AOAM5310/kTWwOWT6P7imqQHY4tXC0rlzehRgrVo/QCJnco8D5QLlY+o
        kh0Y+IlklZrEF40E4T0mjgJBmc4UtdrIUw==
X-Google-Smtp-Source: ABdhPJzFIzQz0jz1iJTS+paInAZwY/QhZXh2lQD8YXpzJHblACqr35Oc1kmr6SGfMlW+3HNsbzclWA==
X-Received: by 2002:a0c:ff21:0:b0:42c:42f:6c24 with SMTP id x1-20020a0cff21000000b0042c042f6c24mr8306657qvt.14.1645243684631;
        Fri, 18 Feb 2022 20:08:04 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 13sm26419916qtz.87.2022.02.18.20.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 20:08:04 -0800 (PST)
Date:   Fri, 18 Feb 2022 23:08:03 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 2/2] hooks: fix a TOCTOU in "did we run a hook?" heuristic
Message-ID: <YhBtI6PY5s/nC8og@nand.local>
References: <cover-0.2-00000000000-20220218T203834Z-avarab@gmail.com>
 <patch-2.2-d01d088073b-20220218T203834Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-2.2-d01d088073b-20220218T203834Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 18, 2022 at 09:43:52PM +0100, Ævar Arnfjörð Bjarmason wrote:
> diff --git a/builtin/commit.c b/builtin/commit.c
> index b9ed0374e30..bc5d34bc31f 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -725,11 +725,13 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  	int clean_message_contents = (cleanup_mode != COMMIT_MSG_CLEANUP_NONE);
>  	int old_display_comment_prefix;
>  	int merge_contains_scissors = 0;
> +	int invoked_hook;
>
>  	/* This checks and barfs if author is badly specified */
>  	determine_author_info(author_ident);
>
> -	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit", NULL))
> +	if (!no_verify && run_commit_hook(use_editor, index_file, &invoked_hook,
> +					  "pre-commit", NULL))
>  		return 0;
>
>  	if (squash_message) {
> @@ -1052,10 +1054,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		return 0;
>  	}
>
> -	if (!no_verify && hook_exists("pre-commit")) {
> +	if (!no_verify && invoked_hook) {
>  		/*
> -		 * Re-read the index as pre-commit hook could have updated it,
> -		 * and write it out as a tree.  We must do this before we invoke
> +		 * Re-read the index as the pre-commit-commit hook was invoked
> +		 * and could have updated it. We must do this before we invoke
>  		 * the editor and after we invoke run_status above.
>  		 */
>  		discard_cache();

Sanity checking my own understating of this race: if we ran the
pre-commit hook and it modified the index, but hook_exists() returns
false later on (e.g., because the hook itself went away, the directory
became unreadable, etc.), then we won't call discard_cache() when we
should have?

If so, OK. This definitely seems like a pretty niche race, but
independent of that I think the change here is an improvement in
readability, and makes it clearer that calling discard_cache() depends
on whether or not we *ran* the pre-commit hook, not whether we (still)
*have* a pre-commit hook.

Thanks,
Taylor
