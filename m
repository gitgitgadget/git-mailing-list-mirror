Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4376C433EF
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 22:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244758AbiBGWlY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 17:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242105AbiBGWlX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 17:41:23 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72279C061355
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 14:41:22 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id x3so12292026pll.3
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 14:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iAr1ZKXmiJx1biqTKbyjavO1kw+nbS4JaV7IGlWyH/I=;
        b=CfC9HyELQ2QnmKNOtboEuCLeqlWRKvRaHi23a64yj2vROqTwwlMmjDZ7vdc6WN/sx9
         EESCiK/0DzxFrggkPUAqqvKlB1aVmtNK8nvVrotdy3OQpD7JDn1/IId75cfjbwZ/yhp7
         qQmTFj4qH+ZsOvlGab8FVrCaSYWQpn0tpmJu8dj9V/zIO//6m1XackX1FEzDKjmx2knx
         ZQ+Xys637NVvfnbSVQ7H5+ln6rddvr2k0xn/tCIxPZ3pKLQGcmVvyxflq4sqRs4Rh7fx
         GEhZRhZfGlN4JaAiWhynITMj67OKOEfefiCh4DrGwQYvhLLw1VQI/m2y8SBEFhUWwGor
         VYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iAr1ZKXmiJx1biqTKbyjavO1kw+nbS4JaV7IGlWyH/I=;
        b=Jorcvgio12EnVjDPfezrQ6J0PPRSGPYRjRbWDtRgMXECXYdvIn9Afn3m2pq2tnjcBf
         kPZeF9EV8uVVEOqzl7zdgV5EnFAyBEBNSQTfNLAkscaQE0V/gNkfxsBCuLKzDqOhgdjK
         wvtc3+fxfTeCobKEGcOvSbf9Ink5OL6CARfQ8W4Exwr+mfvUGZ0R2qWHhpZzRL7H6ZTl
         7WUMAZ6BYM8CnvzYpVyFOcGMjs4Nztj9rjCyWNb9BSwaHZ7oriIy/xt/c9FgDwGc5908
         gmNu3RKgJU0l7VKuX7gDKbtv4OgrejvZknA50hwYw2TdOuBdCCU+nTRRoiNtTHVpobhO
         2GcQ==
X-Gm-Message-State: AOAM533Vqj3KsVPqJk1KT/qjAZFd1SoX+nqKSFVdw2N++mQE/Lu7vIub
        LEGjLlnNC339ezslrqrUtJTnKw==
X-Google-Smtp-Source: ABdhPJxbD9FIXFjawDdlGZNsnA1419Qrq4CyUtlwBhS1DYgvupj0sPi9E2hxcQ1MNTbaTBfWx6I/ag==
X-Received: by 2002:a17:902:7609:: with SMTP id k9mr1404496pll.143.1644273681686;
        Mon, 07 Feb 2022 14:41:21 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:9798:e8e3:7c60:d157])
        by smtp.gmail.com with ESMTPSA id rj1sm352091pjb.49.2022.02.07.14.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 14:41:20 -0800 (PST)
Date:   Mon, 7 Feb 2022 14:41:13 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 03/15] merge-tree: add option parsing and initial
 shell for real merge function
Message-ID: <YgGgCasl1eVz679E@google.com>
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
 <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
 <63f42df21aec5bda50e4414493eb59dcb64e5558.1643787281.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63f42df21aec5bda50e4414493eb59dcb64e5558.1643787281.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 02, 2022 at 07:34:29AM +0000, Elijah Newren via GitGitGadget wrote:
> 
> 
> Let merge-tree accept a `--write-tree` parameter for choosing real
> merges instead of trivial merges, and accept an optional
> `--trivial-merge` option to get the traditional behavior.  Note that
> these accept different numbers of arguments, though, so these names
> need not actually be used.
> 
> Note that real merges differ from trivial merges in that they handle:
>   - three way content merges
>   - recursive ancestor consolidation
>   - renames
>   - proper directory/file conflict handling
>   - etc.
> Basically all the stuff you'd expect from `git merge`, just without
> updating the index and working tree.  The initial shell added here does
> nothing more than die with "real merges are not yet implemented", but
> that will be fixed in subsequent commits.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/merge-tree.c | 61 +++++++++++++++++++++++++++++++++++++-------
>  git.c                |  2 +-
>  2 files changed, 53 insertions(+), 10 deletions(-)
> 
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index 914ec960b7e..e98ec8a9f1d 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -3,13 +3,12 @@
>  #include "tree-walk.h"
>  #include "xdiff-interface.h"
>  #include "object-store.h"
> +#include "parse-options.h"
>  #include "repository.h"
>  #include "blob.h"
>  #include "exec-cmd.h"
>  #include "merge-blobs.h"
>  
> -static const char merge_tree_usage[] = "git merge-tree <base-tree> <branch1> <branch2>";
> -
>  struct merge_list {
>  	struct merge_list *next;
>  	struct merge_list *link;	/* other stages for this object */
> @@ -366,15 +365,17 @@ static void *get_tree_descriptor(struct repository *r,
>  	return buf;
>  }
>  
> -static int trivial_merge(int argc, const char **argv)
> +static int trivial_merge(const char *base,
> +			 const char *branch1,
> +			 const char *branch2)
>  {
>  	struct repository *r = the_repository;
>  	struct tree_desc t[3];
>  	void *buf1, *buf2, *buf3;
>  
> -	buf1 = get_tree_descriptor(r, t+0, argv[1]);
> -	buf2 = get_tree_descriptor(r, t+1, argv[2]);
> -	buf3 = get_tree_descriptor(r, t+2, argv[3]);
> +	buf1 = get_tree_descriptor(r, t+0, base);
> +	buf2 = get_tree_descriptor(r, t+1, branch1);
> +	buf3 = get_tree_descriptor(r, t+2, branch2);
>  	trivial_merge_trees(t, "");
>  	free(buf1);
>  	free(buf2);
> @@ -384,9 +385,51 @@ static int trivial_merge(int argc, const char **argv)
>  	return 0;
>  }
>  
> +struct merge_tree_options {
> +	int mode;
> +};
> +
> +static int real_merge(struct merge_tree_options *o,
> +		      const char *branch1, const char *branch2)
> +{
> +	die(_("real merges are not yet implemented"));
> +}
> +
>  int cmd_merge_tree(int argc, const char **argv, const char *prefix)
>  {
> -	if (argc != 4)
> -		usage(merge_tree_usage);
> -	return trivial_merge(argc, argv);
> +	struct merge_tree_options o = { 0 };
> +	int expected_remaining_argc;
> +
> +	const char * const merge_tree_usage[] = {
> +		N_("git merge-tree [--write-tree] <branch1> <branch2>"),
> +		N_("git merge-tree [--trivial-merge] <base-tree> <branch1> <branch2>"),
> +		NULL
> +	};
> +	struct option mt_options[] = {
> +		OPT_CMDMODE(0, "write-tree", &o.mode,
> +			    N_("do a real merge instead of a trivial merge"),
> +			    'w'),
> +		OPT_CMDMODE(0, "trivial-merge", &o.mode,
> +			    N_("do a trivial merge only"), 't'),
> +		OPT_END()
> +	};

In the review club last week I had mentioned I thought OPT_CMDMODE
worked well with enums. I found some a reasonably nice example in
builtin/replace.c:cmd_replace(), although I have some Opinions about the
enum declaration placement there. Regardless, I think using an enum
instead of a single character would make this more readable - otherwise
I need to remember what 'w' means when I'm reasoning about how many args
to expect below.


> +
> +	/* Parse arguments */
> +	argc = parse_options(argc, argv, prefix, mt_options,
> +			     merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTION);
> +	if (o.mode) {
> +		expected_remaining_argc = (o.mode == 'w' ? 2 : 3);
> +		if (argc != expected_remaining_argc)
> +			usage_with_options(merge_tree_usage, mt_options);
> +	} else {
> +		if (argc < 2 || argc > 3)
> +			usage_with_options(merge_tree_usage, mt_options);
> +		o.mode = (argc == 2 ? 'w' : 't');
> +	}
> +
> +	/* Do the relevant type of merge */
> +	if (o.mode == 'w')
> +		return real_merge(&o, argv[0], argv[1]);
> +	else
> +		return trivial_merge(argv[0], argv[1], argv[2]);
>  }

Sorry for the slow reply.

 - Emily
