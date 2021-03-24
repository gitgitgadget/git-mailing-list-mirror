Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E0BC433DB
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 01:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A546E619EF
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 01:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhCXBY5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 21:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbhCXBYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 21:24:25 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A6EC061763
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 18:24:25 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id ce10so30174937ejb.6
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 18:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=gBloZJXzu6fQqrcX+HcT7crFqDTCn/6ABLdnXUf7/nU=;
        b=B2pDUiZTWPlkRGQNpWo2gziQqTU1ekdjgqKMkz3rlDkcrHyQgpz0FOTLC74zhgmsGp
         gFjvCXD0SuhHmMskxDTxDWlVBhiqueke/BoS0Db8/E9+RkV5ZX1NFf2TzvrlVigz6t8/
         aFD+Ww5PjNcjF7LflTR//0PTkha+3tm0Ny1OJymJzHNVHqBAb7WGJ4lqStwDYxLdX5nW
         CQVlvoxnhupkQs2nKRYUPfvXpMT83dDKjLdG2+QE//mJ4G8R60qSbLrrQzyX3i3Qji0v
         VD7CkQD5QFJt5bh2b/R1lTsO/vzlKXh7I5xZs0erYQP9RsDMmxOO6UBfFZpPBlm3hpoV
         yRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=gBloZJXzu6fQqrcX+HcT7crFqDTCn/6ABLdnXUf7/nU=;
        b=eKx/WlZGlPZkwwdgvDJa2vI5s3TjBp+BXHb3wJCf9+hxQjn8Z/OxfWwnwhsU76ys6f
         if8AHE9SEY5t79hXix2pD6z1jtFyZnTrSrklRc/5E8esTY8W5gG6XebUKcdCTbn0OoJz
         y0mWkrkQLU1uV/0NjksHTlnot5a0sV8phIkhSjJ2xLybvSTlvos5BXBahD9pfEs7YI2U
         W/rUQubIOWJDtBuTt4E2hL20CkkUhamF8znTLvchyuwNMpLPhyuxxd/dniIgMWOwHOxr
         wtBS1szngsBKAtPzmZ95xX06UHLNI5QgrwaqDteyQpfwMD4Mae14CmeCjV0ufWSuVw0D
         Ypew==
X-Gm-Message-State: AOAM5323FEe0xpfEzAYWPhTdZA8nbEwlpxIEKNbvfj089EoyHAUpOomC
        MNakgm6mQdj1UjePFOvh7nQtDBXtXx7mUA==
X-Google-Smtp-Source: ABdhPJwJnFWgX+sLBVN8ree3kzfhmOFOS8IX3uZyp8GPmVnw8DKFhykfyfpZZFpKfOwlv4XH+ZVVQA==
X-Received: by 2002:a17:907:9152:: with SMTP id l18mr995773ejs.376.1616549063777;
        Tue, 23 Mar 2021 18:24:23 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id c20sm194777eja.22.2021.03.23.18.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 18:24:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com,
        pclouds@gmail.com, jrnieder@gmail.com,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 07/20] test-read-cache: print cache entries with --table
References: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
 <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
 <7ebd9570b1ad81720569a770526651c62c152b9f.1616507069.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <7ebd9570b1ad81720569a770526651c62c152b9f.1616507069.git.gitgitgadget@gmail.com>
Date:   Wed, 24 Mar 2021 02:24:22 +0100
Message-ID: <87r1k5pcmx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 23 2021, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> This table is helpful for discovering data in the index to ensure it is
> being written correctly, especially as we build and test the
> sparse-index. This table includes an output format similar to 'git
> ls-tree', but should not be compared to that directly. The biggest
> reasons are that 'git ls-tree' includes a tree entry for every
> subdirectory, even those that would not appear as a sparse directory in
> a sparse-index. Further, 'git ls-tree' does not use a trailing directory
> separator for its tree rows.
>
> This does not print the stat() information for the blobs. That will be
> added in a future change with another option. The tests that are added
> in the next few changes care only about the object types and IDs.
> However, this future need for full index information justifies the need
> for this test helper over extending a user-facing feature, such as 'git
> ls-files'.

Is that stat() information that's going to be essential to grab in the
same process that runs the "for (i = 0; i < istate->cache_nr; i++)"
for-loop, or stat() information that could be grabbed as:

    git ls-files -z --stage | some-program-that-stats-all-listed-blobs

It's not so much that I still disagree as I feel like I'm missing
something. I haven't gone through this topic with a fine toothed comb,
so ...

If and when these patches land and I'm using this nascent sparse
checkout support why wouldn't I want ls-files or another not-a-test-tool
to support extracting this new information that's in the index?

That's why I sent the RFC patches at
https://lore.kernel.org/git/20210317132814.30175-2-avarab@gmail.com/ to
roll this functionality into ls-files.

Still, I think if there's a good reason for why we want this in the
index but never want our plumbing to be able to dump it in some
user-facing way I think just as a matter of reviewing this code it would
be much simpler if it was in ls-files behind some
git_env_bool("GIT_TEST_...") flag or something.

Or maybe I'm the only one who spends a lot of time with both ls-files.c
and test-read-cache.c open while trying to review this trying to keep
track of if and how this helper is and isn't subtly different from
ls-files (as my RFC series shows, not really that different at all...).
Especially with the really-just-ls-files-plus-one-thing tool mimicking
ls-tree output, for reasons I still don't get...

> To make the option parsing slightly more robust, wrap the string
> comparisons in a loop adapted from test-dir-iterator.c.
>
> Care must be taken with the final check for the 'cnt' variable. We
> continue the expectation that the numerical value is the final argument.

I think even if you're set on not having this exposed in some
builtin/*.c command this code would be much clearer based on some
version of my
https://lore.kernel.org/git/20210317132814.30175-6-avarab@gmail.com/
i.e. the part that isn't entirely deleting t/helper/test-read-cache.c,
which would survive as t/helper/test-read-cache-sparse.c or something.

As that patch shows this code is needlessly convoluted because it's
serving 3x wildly different in-tree use-cases. I don't see how the very
small amount of de-duplication we're getting is worth the complexity.

At that point we don't need any care with the cnt variable, because
we're not combining the fsmonitor and perf use-cases of reading the
index in some loop with the ls-files-alike.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/helper/test-read-cache.c | 55 +++++++++++++++++++++++++++++++-------
>  1 file changed, 45 insertions(+), 10 deletions(-)
>
> diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
> index 244977a29bdf..6cfd8f2de71c 100644
> --- a/t/helper/test-read-cache.c
> +++ b/t/helper/test-read-cache.c
> @@ -1,36 +1,71 @@
>  #include "test-tool.h"
>  #include "cache.h"
>  #include "config.h"
> +#include "blob.h"
> +#include "commit.h"
> +#include "tree.h"
> +
> +static void print_cache_entry(struct cache_entry *ce)
> +{
> +	const char *type;
> +	printf("%06o ", ce->ce_mode & 0177777);
> +
> +	if (S_ISSPARSEDIR(ce->ce_mode))
> +		type = tree_type;
> +	else if (S_ISGITLINK(ce->ce_mode))
> +		type = commit_type;
> +	else
> +		type = blob_type;
> +
> +	printf("%s %s\t%s\n",
> +	       type,
> +	       oid_to_hex(&ce->oid),
> +	       ce->name);
> +}
> +
> +static void print_cache(struct index_state *istate)
> +{
> +	int i;
> +	for (i = 0; i < istate->cache_nr; i++)
> +		print_cache_entry(istate->cache[i]);
> +}
>  
>  int cmd__read_cache(int argc, const char **argv)
>  {
> +	struct repository *r = the_repository;
>  	int i, cnt = 1;
>  	const char *name = NULL;
> +	int table = 0;
>  
> -	if (argc > 1 && skip_prefix(argv[1], "--print-and-refresh=", &name)) {
> -		argc--;
> -		argv++;
> +	for (++argv, --argc; *argv && starts_with(*argv, "--"); ++argv, --argc) {
> +		if (skip_prefix(*argv, "--print-and-refresh=", &name))
> +			continue;
> +		if (!strcmp(*argv, "--table"))
> +			table = 1;
>  	}
>  
> -	if (argc == 2)
> -		cnt = strtol(argv[1], NULL, 0);
> +	if (argc == 1)
> +		cnt = strtol(argv[0], NULL, 0);
>  	setup_git_directory();
>  	git_config(git_default_config, NULL);
> +
>  	for (i = 0; i < cnt; i++) {
> -		read_cache();
> +		repo_read_index(r);
>  		if (name) {
>  			int pos;
>  
> -			refresh_index(&the_index, REFRESH_QUIET,
> +			refresh_index(r->index, REFRESH_QUIET,
>  				      NULL, NULL, NULL);
> -			pos = index_name_pos(&the_index, name, strlen(name));
> +			pos = index_name_pos(r->index, name, strlen(name));
>  			if (pos < 0)
>  				die("%s not in index", name);
>  			printf("%s is%s up to date\n", name,
> -			       ce_uptodate(the_index.cache[pos]) ? "" : " not");
> +			       ce_uptodate(r->index->cache[pos]) ? "" : " not");
>  			write_file(name, "%d\n", i);
>  		}
> -		discard_cache();
> +		if (table)
> +			print_cache(r->index);
> +		discard_index(r->index);
>  	}
>  	return 0;
>  }

