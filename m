Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29163C433DF
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 16:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA022204EC
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 16:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BV6fjZHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgHJQ2N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 12:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgHJQ2M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 12:28:12 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA5FC061756
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 09:28:12 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c12so7197188qtn.9
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 09:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fnEHtcGoHT00aOEMwjd65RKYAsENRxl+nnEmTSVMCAo=;
        b=BV6fjZHFlxViLUTUS+Dk6suHOTobX1cAveBWTKyd4iwtd96D3O9qzzB6kE5jYwa4O1
         7z1kgqJkCWhUkx1b8RAI2pEv5PYngmrN8d2xAsDkRIsMVsQSeojcPufDhVWPYeACQegB
         eUgOrJNEMjVy/C+mIj1Uk+eZ/jqDFVD7Iq9gULflmAGjD/xjplWDHszRXSnId9g3NWRT
         fcMV9tLQmyVvbkY/S+ZnTvhv/CmQjeR4c6Ih1v4BRkDi5XjrBNNMNRtCWip6xcoz5ZHP
         Sqq8oj3wqEwNumpOM/io3UiREp9Er6b082I2YurCO5LbCcTY5TPxIpyBwAFHvqGsw53j
         lRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fnEHtcGoHT00aOEMwjd65RKYAsENRxl+nnEmTSVMCAo=;
        b=JKNIAwDlVBTd1CQ42wIf8wqAv+EZ9sLFLBmccbiC7okFcD2SRJg80tcOvZunXPHxgh
         nVdkwinErHES19a+cw8S0NMQEROXhXwYX9aOVJlwGHEy52b3j13LNkjOxhA44IN8xZb1
         AWXHOgCfnPSTFu23EATY2q87O+uUf7iwspRp5fFn9rdl/u4Zg9NUu8SWJDNur8G/bGT3
         WKNhr+h7iix35cdDjtt6mNuz36JyJswn9U/Y1DCHVWgrca4OJmpSnHqUjuNyMuznj9Yz
         +XT3uGGpmg0d+i1jelYA0zAXVMZgJBNp/auBviSZmpY/idiwOsNrQqQKLIEV9fR1mnlj
         oU/A==
X-Gm-Message-State: AOAM532xLbQvp/F3lxBB9lzPeVcGhbGTuN6dKTB9bF3hP5gJXyAkrnm/
        9l4qEk54H3IRAojihBlDO/Y=
X-Google-Smtp-Source: ABdhPJwOg7h6RjcyY6uoGHhu9JjmC+TYroroZjNIblMOr4I7dTeNDlczR4/e+6arW/u8/tvLHwkNkQ==
X-Received: by 2002:ac8:7609:: with SMTP id t9mr28073317qtq.158.1597076891484;
        Mon, 10 Aug 2020 09:28:11 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with ESMTPSA id e23sm15663822qto.15.2020.08.10.09.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 09:28:10 -0700 (PDT)
Subject: Re: [PATCH v2 05/10] commit-graph: implement generation data chunk
To:     Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
 <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
 <cb797e20d79e9dcd3e0b953e0db3ed1defb9aa7c.1596941625.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <aee0ae56-3395-6848-d573-27a318d72755@gmail.com>
Date:   Mon, 10 Aug 2020 12:28:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <cb797e20d79e9dcd3e0b953e0db3ed1defb9aa7c.1596941625.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/8/2020 10:53 PM, Abhishek Kumar via GitGitGadget wrote:
> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
> 
> As discovered by Ævar, we cannot increment graph version to
> distinguish between generation numbers v1 and v2 [1]. Thus, one of
> pre-requistes before implementing generation number was to distinguish
> between graph versions in a backwards compatible manner.
> 
> We are going to introduce a new chunk called Generation Data chunk (or
> GDAT). GDAT stores generation number v2 (and any subsequent versions),
> whereas CDAT will still store topological level.
> 
> Old Git does not understand GDAT chunk and would ignore it, reading
> topological levels from CDAT. New Git can parse GDAT and take advantage
> of newer generation numbers, falling back to topological levels when
> GDAT chunk is missing (as it would happen with a commit graph written
> by old Git).

There is a philosophical problem with this patch, and I'm not sure
about the right way to fix it, or if there really is a problem at all.
At minimum, the commit message needs to be improved to make the issue
clear:

This version of the chunk does not store corrected commit date offsets!

This commit add a chunk named "GDAT" and fills it with topological
levels. This is _different_ than the intended final format. For that
reason, the commit-graph-format.txt document is not updated.

The reason I say this is a "philosophical" problem is that this patch
introduces a version of Git that has a different interpretation of the
GDAT chunk than the version presented two patches later. While this
version would never be released, it still exists in history and could
present difficulty if someone were to bisect on an issue with the GDAT
chunk (using external data, not data produced by the compiled binary
at that version).

The justification for this commit the way you did it is clear: there
is a lot of test fallout to just including a new chunk. The question
is whether it is enough to justify this "dummy" implementation for
now?

The tricky bit is the series of three patches starting with this
one.

1. The next patch "commit-graph: return 64-bit generation number" can
   be reordered to be before this patch, no problem. I don't think
   there will be any text conflicts _except_ inside the
   write_graph_chunk_generation_data() method introduced here.

2. The patch after that, "commit-graph: implement corrected commit date"
   only has a small dependence: it writes to the GDAT chunk and parses
   it out. If you remove the interaction with the GDAT chunk, then you
   still have the computation as part of compute_generation_numbers()
   that is valuable. You will need to be careful about the exit
   condition, though, since you also introduce the topo_level chunk.

Patches 5-7 could perhaps be reorganized as follows:

  i. commit-graph: return 64-bit generation number, as-is.

 ii. Add a topo_level slab that is parsed from CDAT. Modify
     compute_generation_numbers() to populate this value and modify
     write_graph_chunk_data() to read this value. Simultaneously
     populate the "generation" member with the same value.

iii. "commit-graph: implement corrected commit date" without any GDAT
     chunk interaction. Make sure the algorithm in
     compute_generation_numbers() walks commits if either topo_level or
     generation are unset. There is a trick here: the generation value
     _is_ set if the commit is parsed from the existing commit-graph!
     Is this case covered by the existing logic to not write GDAT when
     writing a split commit-graph file with a base that does not have
     GDAT? Note that the non-split case does not load the commit-graph
     for parsing, so the interesting case is "--split-replace". Worth
     a test (after we write the GDAT chunk), which you have in "commit-graph:
     handle mixed generation commit chains".

 iv. This patch, introducing the chunk and the read/write logic.

  v. Add the remaining patches.

Again, this is a complicated patch-reorganization. The hope is that
the end result is something that is easy to review as well as something
that produces an as-sane-as-possible history for future bisecters.

Perhaps other reviewers have similar feelings, or can say that I am
being too picky.

> We introduce a test environment variable 'GIT_TEST_COMMIT_GRAPH_NO_GDAT'
> which forces commit-graph file to be written without generation data
> chunk to emulate a commit-graph file written by old Git.

Thank you for introducing this. It really makes it clear what the
benefit is when looking at the t6600-test-reach.sh changes. However,
the changes to that script are more "here is an opportunity for extra
coverage" as opposed to a necessary change immediately upon creating
the GDAT chunk. That could be separated out and justified on its own.
Recall that the justification is that the new version of Git will
continue to work with commit-graph files without a GDAT chunk.

> +static int write_graph_chunk_generation_data(struct hashfile *f,
> +					      struct write_commit_graph_context *ctx)
> +{
> +	int i;
> +	for (i = 0; i < ctx->commits.nr; i++) {
> +		struct commit *c = ctx->commits.list[i];
> +		display_progress(ctx->progress, ++ctx->progress_cnt);
> +		hashwrite_be32(f, commit_graph_data_at(c)->generation);

Here is the "incorrect" data being written.

> +	}
> +
> +	return 0;
> +}
> +

> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -72,7 +72,7 @@ graph_git_behavior 'no graph' full commits/3 commits/1
>  graph_read_expect() {
>  	OPTIONAL=""
>  	NUM_CHUNKS=3
> -	if test ! -z $2
> +	if test ! -z "$2"

A subtle change, but important because we now have multiple "extra"
chunks possible here. Good.

>  graph_git_behavior 'bare repo with graph, commit 8 vs merge 1' bare commits/8 merge/1
> @@ -421,8 +421,9 @@ test_expect_success 'replace-objects invalidates commit-graph' '
>  
>  test_expect_success 'git commit-graph verify' '
>  	cd "$TRASH_DIRECTORY/full" &&
> -	git rev-parse commits/8 | git commit-graph write --stdin-commits &&
> -	git commit-graph verify >output
> +	git rev-parse commits/8 | GIT_TEST_COMMIT_GRAPH_NO_GDAT=1 git commit-graph write --stdin-commits &&
> +	git commit-graph verify >output &&
> +	graph_read_expect 9 extra_edges
>  '

And it is this case as to why we don't just add "generation_data" to our
list of expected chunks.

> @@ -29,9 +29,9 @@ graph_read_expect() {
>  		NUM_BASE=$2
>  	fi
>  	cat >expect <<- EOF
> -	header: 43475048 1 1 3 $NUM_BASE
> +	header: 43475048 1 1 4 $NUM_BASE
>  	num_commits: $1
> -	chunks: oid_fanout oid_lookup commit_metadata
> +	chunks: oid_fanout oid_lookup commit_metadata generation_data

In this script, you _do_ add it to the default chunk list, which
saves some extra work in the rest of the tests. Good.


Thanks,
-Stolee
