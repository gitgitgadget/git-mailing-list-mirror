Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB0B41F954
	for <e@80x24.org>; Thu, 23 Aug 2018 17:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbeHWVCc (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 17:02:32 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:34344 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbeHWVCc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 17:02:32 -0400
Received: by mail-yb0-f195.google.com with SMTP id t10-v6so2315003ybb.1
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 10:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zPtGDMo4ckptMCpsNm88R+mL+CgYV9lEpU7oSRDNxpo=;
        b=EzNcWZbqDiHug8rPY90qeuesOE/005OFfqQ5eJZVZI3OYQKyEgxadx/4GXLLXw86Or
         ryYaQey+VI4F+sQG6OhsGeQ0o7SKlF4+UgUvF7AJ03pyWUEIQKGSjJTMaXpyRUzdCp6A
         ClAMBfMrzhvMYr2nnZTSMaFH472l9WNLQTXm7UwlG1NyNvhzLtkXZCkj5hBer6Gqdtld
         V7HOnSK6jSR0cb+sApiR5G4krqfbkC6y88ctXh4Z9FKvAFH6R33gagEw4DFF2BUZ9BVb
         IOEbP4+7FHynGJLXd+lqBYHmoMgdFqOn2JAm/addIrZh1utTUUR+883u9DtwdmYLf6tO
         Ar1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zPtGDMo4ckptMCpsNm88R+mL+CgYV9lEpU7oSRDNxpo=;
        b=acZ4w6oDt5gU8WedU8U5h6Me6MdNJCDAQpwWZEAIWJpxizS/kA2caJrZ0z8ZK7v5rN
         rwWYDek6Lg4cG+cgHrJeuxTF84OjInWTWug28AXVN+vagsRTpX8NjzK7Nw5Pp7fxmu6G
         upi8zNMY+zpdRD1Zyw3lActniekkI9txmAJlSGEK2/qmnF4/gui/F54N+jUTWRFy/wNq
         vB2V83GE3+BG4fj0AT2BlD2ZNL80XSCRVeBf4TXgobMbnOx/JymxPqodnEwogZrl5mmV
         Q/Ux3iDH/KB8ZFUPKmJML/j078NGjwgnYgAkbtuEpdKXkZ9Hkx2m0EzC0e0Bqq7lb6YN
         cKqA==
X-Gm-Message-State: AOUpUlEa4LNvdJyUqgs1uTHbqBnjBdlGa89hJELB5F3kRy9eXQ59yMRe
        j/FGfbreWiYoES3tzoYSq1di1RXDMgRYIJ8KYK6YHg==
X-Google-Smtp-Source: AA+uWPwF5ScjOTjJRb17dnSjQDVGl0sZWPAEGg5dZaUdKWDQh7k/y3p5kDzUXHXN34tWlR8fuhBz57/jQG6Mb71ztDE=
X-Received: by 2002:a5b:703:: with SMTP id g3-v6mr12367401ybq.201.1535045506417;
 Thu, 23 Aug 2018 10:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180823154053.20212-1-benpeart@microsoft.com>
In-Reply-To: <20180823154053.20212-1-benpeart@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 23 Aug 2018 10:31:35 -0700
Message-ID: <CAGZ79kbXfPPvcQ1rnUdiOqWs5wC2qccGCnf8DvCVnp8QV126MA@mail.gmail.com>
Subject: Re: [PATCH v1] read-cache: speed up index load through parallelization
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 23, 2018 at 8:45 AM Ben Peart <Ben.Peart@microsoft.com> wrote:
>
> This patch helps address the CPU cost of loading the index by creating
> multiple threads to divide the work of loading and converting the cache
> entries across all available CPU cores.
>
> It accomplishes this by having the primary thread loop across the index file
> tracking the offset and (for V4 indexes) expanding the name. It creates a
> thread to process each block of entries as it comes to them. Once the
> threads are complete and the cache entries are loaded, the rest of the
> extensions can be loaded and processed normally on the primary thread.
>
> Performance impact:
>
> read cache .git/index times on a synthetic repo with:
>
> 100,000 entries
> FALSE       TRUE        Savings     %Savings
> 0.014798767 0.009580433 0.005218333 35.26%
>
> 1,000,000 entries
> FALSE       TRUE        Savings     %Savings
> 0.240896533 0.1751243   0.065772233 27.30%
>
> read cache .git/index times on an actual repo with:
>
> ~3M entries
> FALSE       TRUE        Savings     %Savings
> 0.59898098  0.4513169   0.14766408  24.65%
>
> Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
> ---
>
> Notes:
>     Base Ref: master
>     Web-Diff: https://github.com/benpeart/git/commit/67a700419b
>     Checkout: git fetch https://github.com/benpeart/git read-index-multithread-v1 && git checkout 67a700419b
>
>  Documentation/config.txt |   8 ++
>  config.c                 |  13 +++
>  config.h                 |   1 +
>  read-cache.c             | 218 ++++++++++++++++++++++++++++++++++-----
>  4 files changed, 216 insertions(+), 24 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1c42364988..3344685cc4 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -899,6 +899,14 @@ relatively high IO latencies.  When enabled, Git will do the
>  index comparison to the filesystem data in parallel, allowing
>  overlapping IO's.  Defaults to true.
>
> +core.fastIndex::
> +       Enable parallel index loading
> ++
> +This can speed up operations like 'git diff' and 'git status' especially
> +when the index is very large.  When enabled, Git will do the index
> +loading from the on disk format to the in-memory format in parallel.
> +Defaults to true.

"fast" is a non-descriptive word as we try to be fast in any operation?
Maybe core.parallelIndexReading as that just describes what it
turns on/off, without second guessing its effects?
(Are there still computers with just a single CPU, where this would not
make it faster? ;-))


> +int git_config_get_fast_index(void)
> +{
> +       int val;
> +
> +       if (!git_config_get_maybe_bool("core.fastindex", &val))
> +               return val;
> +
> +       if (getenv("GIT_FASTINDEX_TEST"))
> +               return 1;

We look at this env value just before calling this function,
can be write it to only look at the evn variable once?

> +++ b/config.h
> @@ -250,6 +250,7 @@ extern int git_config_get_untracked_cache(void);
>  extern int git_config_get_split_index(void);
>  extern int git_config_get_max_percent_split_change(void);
>  extern int git_config_get_fsmonitor(void);
> +extern int git_config_get_fast_index(void);

Oh. nd/no-extern did not cover config.h


>
> +#ifndef min
> +#define min(a,b) (((a) < (b)) ? (a) : (b))
> +#endif

We do not have a minimum function in the tree,
except for xdiff/xmacros.h:29: XDL_MIN.
I wonder what the rationale is for not having a MIN()
definition, I think we discussed that on the list a couple
times but the rationale escaped me.

If we introduce a min/max macro, can we put it somewhere
more prominent? (I would find it useful elsewhere)

> +/*
> +* Mostly randomly chosen maximum thread counts: we
> +* cap the parallelism to online_cpus() threads, and we want
> +* to have at least 7500 cache entries per thread for it to
> +* be worth starting a thread.
> +*/
> +#define THREAD_COST            (7500)

This reads very similar to preload-index.c THREAD_COST

> +       /* loop through index entries starting a thread for every thread_nr entries */
> +       consumed = thread = 0;
> +       for (i = 0; ; i++) {
> +               struct ondisk_cache_entry *ondisk;
> +               const char *name;
> +               unsigned int flags;
> +
> +               /* we've reached the begining of a block of cache entries, kick off a thread to process them */

beginning

Thanks,
Stefan
