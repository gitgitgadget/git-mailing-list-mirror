Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F83C433E7
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 21:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D13622282
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 21:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="ngx/V/ex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388815AbgJIVRa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 17:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731914AbgJIVRa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 17:17:30 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6120C0613D2
        for <git@vger.kernel.org>; Fri,  9 Oct 2020 14:17:29 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id a9so9066710qto.11
        for <git@vger.kernel.org>; Fri, 09 Oct 2020 14:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YQPmmRIKLjQ99p8eK0xmM1cMGpw+k47vqcY0PH7TkYY=;
        b=ngx/V/ex2FfaBEPFBlVK4kUH1wKp5Yy1fNWNwo2vGOqH2tPqSgTnYwe5IdDvZzGszU
         8bv0403ZSBeNuoNBOSRhx8odLK7ds+mzT139r2slDXTHVPJHtdUysFeyBoAYJbglQa++
         xc1gKem61u5TNEEA1Dbd3nJ7kdPS99mOFldRDSJJVWMNdYE0BnvDn39t+v0pQqP6MFdQ
         MPsEmMk2URrRwJLsmTGPIybgUxuQ+Yp6yq34oHPJuLXrEfpa5KzDmfSAoEHidDlWf3kc
         ZBz4XqOrT/Zt8hLGjwifaXJqr2ohuThEUJfnrQqjlAf89S62PIykvbH2M0+PSkuTLf+k
         YXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YQPmmRIKLjQ99p8eK0xmM1cMGpw+k47vqcY0PH7TkYY=;
        b=Qvt8My5FCJ3AIfQHZ5yHLz59ad4aHbI6QH7W8dhjMhYxy6Nk5eVljLiPji8vYAH2V7
         ju6j1lBZ9+kAlCTIVgdUszwkwv4L0WX2ss75B8C4V1aVPpDUTsRaha/K2+XTDtvvCaL/
         ulGtkaE46ya9fdaghpljXTzyFEGopip4oEAM7DihXCwMhO5Kw5X5UxkUI1NQBD4z+9jq
         oCbME+upeYGUGo7KrCLPpGggl/op1HNgcsBCJrbN42SDi3wKVIIPch9j2QxUA5IGoTtI
         6x9xQhoHyzirHRcBvuTnhYSPb6rmh9BqMJxNTIrCClLc2XgJSJdRDaMxegwoOAhfCoTT
         Vr7Q==
X-Gm-Message-State: AOAM530q2qXjHvqabqsE/750Yfyl6hQlKQ1aRE1BFshy5gJIq4fe0PSf
        Is03HP+KPyg77N6WXNT9tUHvJg==
X-Google-Smtp-Source: ABdhPJzGB2eQZkPmKozWF1q98Iz8/p9FmHaX0XSw01o9vkiF9Xa5qs9VF3FnnwCh/p+P4hmVcDn2/A==
X-Received: by 2002:ac8:6c3a:: with SMTP id k26mr8505127qtu.169.1602278248896;
        Fri, 09 Oct 2020 14:17:28 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:b0d1:9fbe:54fa:3044])
        by smtp.gmail.com with ESMTPSA id q6sm6916222qkc.85.2020.10.09.14.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 14:17:28 -0700 (PDT)
Date:   Fri, 9 Oct 2020 17:17:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 2/2] commit-graph: don't write commit-graph when
 disabled
Message-ID: <20201009211725.GA450854@nand.local>
References: <pull.747.v3.git.1602169479482.gitgitgadget@gmail.com>
 <pull.747.v4.git.1602276832.gitgitgadget@gmail.com>
 <4439e8ae8fdc9abf28df29d3038a1483d9084cf2.1602276832.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4439e8ae8fdc9abf28df29d3038a1483d9084cf2.1602276832.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 09, 2020 at 08:53:52PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The core.commitGraph config setting can be set to 'false' to prevent
> parsing commits from the commit-graph file(s). This causes an issue when
> trying to write with "--split" which needs to distinguish between
> commits that are in the existing commit-graph layers and commits that
> are not. The existing mechanism uses parse_commit() and follows by
> checking if there is a 'graph_pos' that shows the commit was parsed from
> the commit-graph file.
>
> When core.commitGraph=false, we do not parse the commits from the
> commit-graph and 'graph_pos' indicates that no commits are in the
> existing file. The --split logic moves forward creating a new layer on
> top that holds all reachable commits, then possibly merges down into
> those layers, resulting in duplicate commits. The previous change makes
> that merging process more robust to such a situation in case it happens
> in the written commit-graph data.

You're noting something interesting here which is that I actually think
setting 'core.commitGraph' _would_ be OK for non-split writes, and
'--split=replace' (along with any other split that happens to write a
single layer).

But, I think that actually enforcing that rule (i.e., "if you have
core.commitGraph set to false, you can't run `git commit-graph write`
except in X Y Z certain situations") is overly-complex and confusing to
users. So, I like what you have here a lot.

> The easy answer here is to avoid writing a commit-graph if reading the
> commit-graph is disabled. Since the resulting commit-graph will would not
> be read by subsequent Git processes. This is more natural than forcing
> core.commitGraph to be true for the 'write' process.
>
> Reported-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
> Helped-by: Jeff King <peff@peff.net>
> Helped-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

You can add my:

  Signed-off-by: Taylor Blau <me@ttaylorr.com>

to the patch below, too, unless you want to take my suggestion below...

> ---
>  Documentation/git-commit-graph.txt | 4 +++-
>  commit-graph.c                     | 5 +++++
>  t/t5324-split-commit-graph.sh      | 3 ++-
>  3 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> index de6b6de230..e1f48c95b3 100644
> --- a/Documentation/git-commit-graph.txt
> +++ b/Documentation/git-commit-graph.txt
> @@ -39,7 +39,9 @@ COMMANDS
>  --------
>  'write'::
>
> -Write a commit-graph file based on the commits found in packfiles.
> +Write a commit-graph file based on the commits found in packfiles. If
> +the config option `core.commitGraph` is disabled, then this command will
> +output a warning, then return success without writing a commit-graph file.
>  +
>  With the `--stdin-packs` option, generate the new commit graph by
>  walking objects only in the specified pack-indexes. (Cannot be combined
> diff --git a/commit-graph.c b/commit-graph.c
> index 0280dcb2ce..6f62a07313 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -2160,6 +2160,11 @@ int write_commit_graph(struct object_directory *odb,
>  	int replace = 0;
>  	struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
>
> +	prepare_repo_settings(the_repository);
> +	if (!the_repository->settings.core_commit_graph) {
> +		warning(_("attempting to write a commit-graph, but 'core.commitGraph' is disabled"));
> +		return 0;
> +	}

Should this check be folded into 'commit_graph_compatible()'? Maybe in
'prepare_commit_graph()' which itself calls 'commit_graph_compatible()'?
I admit that I find this chain of callers to be confusing.

I suppose one argument for checking it here _before_ calling
'commit_graph_compatible()' is that it allows you to issue a specific
warning before returning from this function, so I'm OK with it.

I also don't have a concrete suggestion of where a better place for this
hunk might be, so I'm fine with what you wrote.

>  	if (!commit_graph_compatible(the_repository))
>  		return 0;
>
> diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
> index a314ce0368..4d3842b83b 100755
> --- a/t/t5324-split-commit-graph.sh
> +++ b/t/t5324-split-commit-graph.sh
> @@ -442,8 +442,9 @@ test_expect_success '--split=replace with partial Bloom data' '
>
>  test_expect_success 'prevent regression for duplicate commits across layers' '
>  	git init dup &&
> -	git -C dup config core.commitGraph false &&
>  	git -C dup commit --allow-empty -m one &&
> +	git -C dup -c core.commitGraph=false commit-graph write --split=no-merge --reachable 2>err &&
> +	test_i18ngrep "attempting to write a commit-graph" err &&
>  	git -C dup commit-graph write --split=no-merge --reachable &&
>  	git -C dup commit --allow-empty -m two &&
>  	git -C dup commit-graph write --split=no-merge --reachable &&

Hmm. I would have preferred to see a new test here. Unless I'm wrong, I
believe the patched version of this test _doesn't_ have a duplicate
commit across multiple layers:

  - We try to write a layer with 'one', but don't (because
    'core.commitGraph' is set to false).

  - Then we write a layer for 'one' with 'core.commitGraph' unset.

  - Then we write a layer for 'two' (and only 'two'), since we read the
    below layer containing 'one'.

But, I'm not sure of a better way to test this, either. You fixed the
bug that this is trying to exercise, so it's no longer being exercised
here, but then again neither is the new code that is supposed to handle
it.

I wonder if it is maybe worth having some sample commit-graphs laying
around in a t5324 directory that _would_ demonstrate this problem. OTOH,
maybe that is just me being overly pedantic and worrying about something
that isn't actually a problem.

I trust your judgement, so whatever you feel like is fine with me.

Thanks,
Taylor
