Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9059C433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 23:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B6EA2076B
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 23:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B8YJSzwH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgHLXKm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 19:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgHLXKm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 19:10:42 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1701BC061383
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 16:10:42 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y6so1789510plt.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 16:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0+eOi16ov81mRhbnRAkDEOwSADiX1MQ08kRhAQ4nlho=;
        b=B8YJSzwHzbgoAFZ6eSEYZrGLx5safGioqioTAFD0oFScBGG9bq8IDjIjQf3wadz8Mf
         tQnfcLy+OqFwMprnS9dBXP64fNtGrkynVx1mLl9u13LKOVWfxh21ktVD6kv6OlS8Y8hf
         8UHNOdR8fWKnpWX0aa/hVuia14iTu5fp6Z8+5wdkRJYiQ2Xp104buKur6W+DBliETjS7
         yZtqaBpAZWuzbv/76fea6aX+twhNHcSnLAYf8q9uGjDYVxhtRXS0pI1H1JDiuoWzlqe3
         AKFhKlCURd4gvOT5eM4BsIE0vYl4Zwkudxbatez+PwYcQ1GsTcBT7ryy2N238jM4liXJ
         e47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0+eOi16ov81mRhbnRAkDEOwSADiX1MQ08kRhAQ4nlho=;
        b=UK/hwumxWUZEwKCTEoC9bw5mvN1+Qa5v8FAKxwJRNFoafjxxq1OdMasqHz9y3Q1thL
         iSFbCRn9EIOOvdDbgCyMnJYhQJPTeG/qudC3vpedCsQcgdRRtKCOt863+homsQbtSX2m
         wGSCNqH9VAGgHohKSeWNqA3mj6DuXNsKrWZpy/AdomuW6DKpaF9WBecDs7c6ttwYK9e/
         ZKT9qdoTYNfeQ7lHwslyM403VrYzg8FbcCWmNvIbuJzV+3je93CotkZ7o4WBuw12p/Ns
         GRLUHPmyEu1jDFfFXvhTzMB8NX466wQPziUvacwBXLGcv/sCbol55LKbgf5LzgOOJUgH
         yt1w==
X-Gm-Message-State: AOAM530tVVSRSxEpw3dhlWNlIvbWu6PUMT16G47VsKX/WR2Fwvk4WMhv
        jtRK6rKuFyGbNGcGFtO3kAnBRA==
X-Google-Smtp-Source: ABdhPJygyZ9bsUH3jCv2cUc+C1CGSjFpLM064IBIlZTUFEYG2ha1jThiP3jGAsExDFJHXkopvCgu5g==
X-Received: by 2002:a17:902:56a:: with SMTP id 97mr1582127plf.130.1597273841410;
        Wed, 12 Aug 2020 16:10:41 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id t69sm3275039pgd.66.2020.08.12.16.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 16:10:40 -0700 (PDT)
Date:   Wed, 12 Aug 2020 16:10:36 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/9] maintenance: add prefetch task
Message-ID: <20200812231036.GH2965447@google.com>
References: <pull.696.git.1596731424.gitgitgadget@gmail.com>
 <85118ed5f19468d5051dd1579e35cae3c3114d24.1596731425.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85118ed5f19468d5051dd1579e35cae3c3114d24.1596731425.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 06, 2020 at 04:30:17PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
> 3. By adding a new refspec "+refs/heads/*:refs/prefetch/<remote>/*"
>    we can ensure that we actually load the new values somewhere in
>    our refspace while not updating refs/heads or refs/remotes. By
>    storing these refs here, the commit-graph job will update the
>    commit-graph with the commits from these hidden refs.

[emily] How does the content of refs/prefetch/* get used?
[jrnieder] How does the content of refs/prefetch/* get cleaned up?
[jonathantan] refs/prefetch/* will get used in negotiation so it is
useful to keep these.
> 
> 4. --prune will delete the refs/prefetch/<remote> refs that no
>    longer appear on the remote.
[jrnieder] this is what cleans up refs/prefetch/* later :)

> +static int fetch_remote(const char *remote, struct maintenance_opts *opts)
> +{
> +	struct child_process child = CHILD_PROCESS_INIT;
> +
> +	child.git_cmd = 1;
> +	strvec_pushl(&child.args, "fetch", remote, "--prune", "--no-tags",
> +		     "--no-write-fetch-head", "--refmap=", NULL);
[jonathantan] It would be good to pass --recurse-submodules=no.
[jrnieder] Since we are specifying the refmap here, if we were to
recurse into submodules, we'd have to be careful about making sure
refmap gets propagated correctly.

> +static int fill_each_remote(struct remote *remote, void *cbdata)
[jrnieder] Since this is a callback that happens for each remote, maybe
this should be named to indicate it only fills one remote at a time
instead. Nit :)
> +{
> +	struct string_list *remotes = (struct string_list *)cbdata;
> +
> +	string_list_append(remotes, remote->name);
> +	return 0;
> +}
> +
> +static int maintenance_task_prefetch(struct maintenance_opts *opts)
> +{
> +	int result = 0;
> +	struct string_list_item *item;
> +	struct string_list remotes = STRING_LIST_INIT_DUP;
> +
> +	if (for_each_remote(fill_each_remote, &remotes)) {
> +		error(_("failed to fill remotes"));
> +		result = 1;
> +		goto cleanup;
> +	}
> +
> +	for (item = remotes.items;
> +	     item && item < remotes.items + remotes.nr;
> +	     item++)

Is there a reason not to use for_each_string_list_item() instead? This
would be more brief and also easier to read (less thinking about what
the loop is doing).

> +		result |= fetch_remote(item->string, opts);
> +
> +cleanup:
> +	string_list_clear(&remotes, 0);
> +	return result;
> +}
> +

>  enum maintenance_task_label {
> +	TASK_PREFETCH,
[jrnieder] Nit: Is there a sort order for these? Should we establish an order
early on (e.g. alphabetical)?
>  	TASK_GC,
>  	TASK_COMMIT_GRAPH,

> +test_expect_success 'prefetch multiple remotes' '
> +	git clone . clone1 &&
> +	git clone . clone2 &&
> +	git remote add remote1 "file://$(pwd)/clone1" &&
> +	git remote add remote2 "file://$(pwd)/clone2" &&
> +	git -C clone1 switch -c one &&
> +	git -C clone2 switch -c two &&
> +	test_commit -C clone1 one &&
> +	test_commit -C clone2 two &&
> +	GIT_TRACE2_EVENT="$(pwd)/run-prefetch.txt" git maintenance run --task=prefetch 2>/dev/null &&
> +	fetchargs="--prune --no-tags --no-write-fetch-head --refmap= --quiet" &&
> +	test_subcommand git fetch remote1 $fetchargs +refs/heads/\\*:refs/prefetch/remote1/\\* <run-prefetch.txt &&
[jrnieder] In practice, why were all the \\ needed? Trying to figure out
where Git is using a shell that would need the * escaped and finding it
hard to reason about.
> +	test_subcommand git fetch remote2 $fetchargs +refs/heads/\\*:refs/prefetch/remote2/\\* <run-prefetch.txt &&
> +	test_path_is_missing .git/refs/remotes &&
> +	test_cmp clone1/.git/refs/heads/one .git/refs/prefetch/remote1/one &&
> +	test_cmp clone2/.git/refs/heads/two .git/refs/prefetch/remote2/two &&
[jrnieder] Should we use test_cmp_rev instead to make compatible with
packed-refs?
> +	git log prefetch/remote1/one &&
> +	git log prefetch/remote2/two
[jonathantan] Why do we use 'git log' to check? I'm a little confused
about what's going on; if you just want to check that the refs are
present you could use 'git rev-parse' instead?
