Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB006C433EF
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 09:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236856AbiAXJui (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 04:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236830AbiAXJuh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 04:50:37 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26440C06173B
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 01:50:37 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id l5so38436957edv.3
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 01:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=2KVxl/2TX+ujV01KJWqucOtFDLi3bIe8jScvOTwWI5o=;
        b=GEtMTWP+4b5RZi+Do+yhs7JQRff/fRfRS0+mNJnASMbSV51LO0O3gry2OqxYZvQxaw
         ZTCsbrciTb5ZOy7FD5wWCmDq6stIBiZ5Vpy74NvJ1U3HlKiaVpo+lk2ahGGXF5feLUpk
         y+2fQJDX5wFySrbF8pWyNx6aLqLSs39XURNSSXD5qCu5fTwbIJQxL1ymDfcAu8vdcWNQ
         miyHsGcMpnUQuvbGVo15iZl0K354ccrqvhpBjgPMXtCiX6/21Pw2VG0MRePd+t3JN6Xj
         K4rY9c/0HO655QzHaGQMbUxWURaRL4GB7hhwwrTGqAAILIW8KQf06SLVZvRZtP70PDng
         q9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=2KVxl/2TX+ujV01KJWqucOtFDLi3bIe8jScvOTwWI5o=;
        b=iBVB0warL5IxjbwD+4uf6mBNq9RGBjSFMZ03EXsxW6FFxpiolW+TQRYkxnC2Ge/F9F
         IiwoFDxwSwzruS8ojMQ0uLyFWZhpsR3aU8g2+DjbcbCnuCkfRwnFU52//XR7hxI0TuAE
         JrX7PWdpBv469yFahHb7FbjfUl/6hUseekTXguxLRTXptSbOvqST75TUen1oroxBP4UJ
         GJVR5G632RBELUsyMz3krixTBBrx0SifUY0Pb+dWckcftsb7seC8cGtBN2hc6Gnatf1q
         s3OmJiimJizbiZ55+dxj2H4ZyEB7OQmjGCG1BSvVnBYqfFPy8+O0C/lT44QrhRYiVlKn
         ovDw==
X-Gm-Message-State: AOAM5320S3mDBOTD1FaD+N5dKHy4AlcDC98PBmb+pHxnheUR33bJ4iEY
        7olYC3TzYStZdve4tcYF+82EQqvu1zw=
X-Google-Smtp-Source: ABdhPJxZlh41RrnZKaGyZDfrgRu/kq5+/jbJ/lysG3Os4sTKvNW5i7jraVkLM8UaV8/T5Crooh4auQ==
X-Received: by 2002:aa7:dd59:: with SMTP id o25mr14992491edw.288.1643017834832;
        Mon, 24 Jan 2022 01:50:34 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m16sm1160254eji.110.2022.01.24.01.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 01:50:33 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nBvzb-002Q0v-T4;
        Mon, 24 Jan 2022 10:50:31 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 03/12] merge-tree: add option parsing and initial shell
 for real merge function
Date:   Mon, 24 Jan 2022 10:46:13 +0100
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <65fdae9ddba7c7065ce27acbf4e80a1a74842aa7.1642888562.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <65fdae9ddba7c7065ce27acbf4e80a1a74842aa7.1642888562.git.gitgitgadget@gmail.com>
Message-ID: <220124.86lez5ihso.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jan 22 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
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
>  builtin/merge-tree.c | 67 ++++++++++++++++++++++++++++++++++++++------
>  git.c                |  2 +-
>  2 files changed, 59 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index 914ec960b7e..33e47cc1534 100644
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
> @@ -384,9 +385,57 @@ static int trivial_merge(int argc, const char **argv)
>  	return 0;
>  }
>  
> +struct merge_tree_options {
> +	int real;
> +	int trivial;
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
> +		OPT_BOOL(0, "write-tree", &o.real,
> +			 N_("do a real merge instead of a trivial merge")),
> +		OPT_BOOL(0, "trivial-merge", &o.trivial,
> +			 N_("do a trivial merge only")),
> +		OPT_END()
> +	};
> +
> +	/* Check for a request for basic help */
> +	if (argc == 2 && !strcmp(argv[1], "-h"))
> +		usage_with_options(merge_tree_usage, mt_options);

Is this bit cargo-culted from something else, perhaps
non-parse-options.c usage? I don't think this is needed, the
parse_options() below intercepts "-h" by default.

> +	/* Parse arguments */
> +	argc = parse_options(argc, argv, prefix, mt_options,
> +			     merge_tree_usage, 0);
> +	if (o.real && o.trivial)
> +		die(_("--write-tree and --trivial-merge are incompatible"));

Shouldn't those two just be OPT_CMDMODE()? Then you get this
incompatibility checking for free. See 485fd2c3dae (cat-file: make
--batch-all-objects a CMDMODE, 2021-12-28).

> +	if (o.real || o.trivial) {
> +		expected_remaining_argc = (o.real ? 2 : 3);
> +		if (argc != expected_remaining_argc)
> +			usage_with_options(merge_tree_usage, mt_options);
> +	} else {
> +		if (argc < 2 || argc > 3)
> +			usage_with_options(merge_tree_usage, mt_options);
> +		o.real = (argc == 2);
> +	}

And this can also be done like this, but I wonder if using
PARSE_OPT_STOP_AT_NON_OPTION and then routing to a sub-function wouldn't
be better, i.e. to treat these like sub-commands if they've got
different arity etc.

> +	/* Do the relevant type of merge */
> +	if (o.real)
> +		return real_merge(&o, argv[0], argv[1]);
> +	else
> +		return trivial_merge(argv[0], argv[1], argv[2]);
>  }
> diff --git a/git.c b/git.c
> index 5ff21be21f3..6090a1289db 100644
> --- a/git.c
> +++ b/git.c
> @@ -558,7 +558,7 @@ static struct cmd_struct commands[] = {
>  	{ "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
>  	{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
>  	{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
> -	{ "merge-tree", cmd_merge_tree, RUN_SETUP | NO_PARSEOPT },
> +	{ "merge-tree", cmd_merge_tree, RUN_SETUP },
>  	{ "mktag", cmd_mktag, RUN_SETUP | NO_PARSEOPT },
>  	{ "mktree", cmd_mktree, RUN_SETUP },
>  	{ "multi-pack-index", cmd_multi_pack_index, RUN_SETUP },

