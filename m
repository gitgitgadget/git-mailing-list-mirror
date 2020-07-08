Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33781C433E0
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 05:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09BF22078B
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 05:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6GzGvBw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgGHFlR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 01:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgGHFlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 01:41:16 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C46C061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 22:41:16 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id md7so696231pjb.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 22:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t2ZLuk4wk4AKgJ/KY/g2QmXxdcOgdXuRIvKypQNhmdI=;
        b=j6GzGvBwwmUE4B/RfRjYgNlDBnvmSnHz2VjkF+NP+5xHJwfFowLQKgRD6k8DKtruQ8
         hnVrEdnjVwXAeSpsxeP4alvNGom97eKhxL7Yem6vTwfWqL89hIn0fDeFDiZmYg1acRww
         QdaLHCQ5w25Cl48kCX4ToGx6txkOzohjr+2XTk/IaT7vIfcRDIax5dWkxLq+oXB5Xdo5
         92K15kCQ04+qS6vRuLAMxM2SrAAi2kcSQLIkEt9e1UdKHArTkUQ9upeyjA9QInCnjiuQ
         wTB0ewf8DxVPG037N38Z8pCR5vCecBmWUWrfJVQ1Fcm83Q3HubMgsMWVkZQu5uN3fHGh
         QBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t2ZLuk4wk4AKgJ/KY/g2QmXxdcOgdXuRIvKypQNhmdI=;
        b=fLW0ox1YKdsdH+aQuld9gWNW02iPAivRRZ9Pw9YFuV8WChQMueGTHb2qxA5MfhkPTZ
         ZXl3wzs6IMezqXTkE0UuuvMvEJPYdTXguZFI7td/KePVlmVspB0/4b/yI+91wm4iHSrh
         9ASy2bTP/NM0y7nvxbADTTVQ7kMn7rlQo1WVPNcw+X2PjPL+OW1mRUAdIGT4oFLmIiV3
         9w0yPs4ARdFKMP2R1XCJk84kCwYel3EvQFwxrLwVpKOjrQ78+2ii0+N7lE8Zcu0XqSZx
         XNtTMYAav1JQyz1i78/npCVSnH4LR7242FU6V8ZAhNu/gSbgboBeoOqz4YReGF8zXjsT
         sb0w==
X-Gm-Message-State: AOAM532yh3ndfLAwSPjQRDmsE7hAfCYylpwq8w9RV7+oJhed5DYxB8Kb
        /NO5hMORhIXLSiStJTUh1NY=
X-Google-Smtp-Source: ABdhPJz/ZDLjXTVOHnnfIgjN7zwm+sFUHQpC42gQlotsJdm3reX6BQ1ZPvSU3bDNOGej2TgNNhU7kA==
X-Received: by 2002:a17:90a:2a02:: with SMTP id i2mr7863859pjd.157.1594186875852;
        Tue, 07 Jul 2020 22:41:15 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id q22sm2557898pgn.91.2020.07.07.22.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 22:41:14 -0700 (PDT)
Date:   Tue, 7 Jul 2020 22:41:12 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, jrnieder@gmail.com,
        gitster@pobox.com, jayconrod@google.com, jonathantanmy@google.com
Subject: Re: [PATCH] commit.c: don't persist substituted parents when
 unshallowing
Message-ID: <20200708054112.GA118756@google.com>
References: <82939831ad88f7750b1d024b2031f688ecdf6755.1594132839.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82939831ad88f7750b1d024b2031f688ecdf6755.1594132839.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau wrote:

> In 37b9dcabfc (shallow.c: use '{commit,rollback}_shallow_file',
> 2020-04-22), Git learned how to reset stat-validity checks for the
> '$GIT_DIR/shallow' file, allowing it to change between a shallow and
> non-shallow state in the same process (e.g., in the case of 'git fetch
> --unshallow').
>
> However, 37b9dcabfc does not alter or remove any grafts nor substituted
> parents.
[...]
>                               even though the repository isn't shallow
> any longer (that is, we have all of the objects), the in-core
> representation of those objects still has munged parents at the shallow
> boundaries. If a commit-graph write proceeds, we will use the incorrect
> parentage, producing wrong results.
>
> (Prior to this patch, there were two ways of fixing this: either (1)
> set 'fetch.writeCommitGraph' to 'false', or (2) drop the commit-graph
> after unshallowing).

nit: It wasn't obvious to me on first reading which patch "this patch"
refers to --- does it mean 37b9dcabfc or the patch I am reading?

The approach described in Documentation/SubmittingPatches is to treat
the commit message kind of like a bug report:

 . start with the problem the change tries to solve, i.e. what is wrong
   with the current code without the change.

 . request the change, justifying the way it solves the problem, i.e.
   why the result with the change is better.

 . then move on to alternate solutions considered but discarded, if any.

Here, I think that would be similar to what you have written:

 Since 37b9dcabfc (shallow.c: [...]), Git knows how to reset
 stat-validity checks for the $GIT_DIR/shallow file, allowing it to
 [etc].  However, when $GIT_DIR/shallow changes, Git does not alter or
 remove any grafts nor substituted parents in memory.

 This comes up in a "git fetch --unshallow" with fetch.writeCommitGraph
 set to true.  Ordinarily in a shallow repository (and before 37b9dcabfc,
 even in this case), commit_graph_compatible() would return false,
 indicating that the repository should not be used to write a
 commit-graphs (since commit-graph files cannot represent a shallow
 history).  But since 37b9dcabfc, in an --unshallow operation that check
 succeeds.

 Thus even though the repository isn't shallow any longer (that is, we
 have all of the objects), the in-core representation of those objects
 [...].  When the commit-graph write proceeds, we use the incorrect
 parentage, producing wrong results.

 There are two ways for a user to work around this: either (1) set
 'fetch.writeCommitGraph' to 'false', or (2) drop the commit-graph
 after unshallowing.

> One way to fix this would be to reset the parsed object pool entirely
> (flushing the cache and thus preventing subsequent reads from modifying
> their parents) after unshallowing. This can produce a problem when

nit: seems easier to read with s/This can/That would/, since it's
describing the road not taken

> callers have a now-stale reference to the old pool, and so this patch
> implements a different approach. Instead, we attach a new bit to the

nit: s/we attach/attach/, to avoid ambiguity with the previous part of
the commit message that describes the current, unpatched behavior.

> pool, 'substituted_parent' which indicates if the repository *ever*
> stored a commit which had its parents modified (i.e., the shallow
> boundary *before* unshallowing).
>
> This bit is sticky, since all subsequent reads after modifying a
> commit's parent are unreliable when unshallowing. This patch modifies
> the check in 'commit_graph_compatible' to take this bit into account,
> and correctly avoid generating commit-graphs in this case.

likewise:

 This bit needs to be sticky because [...]

> Helped-by: Derrick Stolee <dstolee@microsoft.com>
> Helped-by: Jonathan Nieder <jrnieder@gmail.com>
> Reported-by: Jay Conrod <jayconrod@google.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> This is a follow-up to Jonathan Nieder's recent message; this patch
> fixes the persistent-shallow issue originally reported by Jay Conrod in:
>
>   https://lore.kernel.org/git/20200603034213.GB253041@google.com/
>
> Like Jonathan, I am also late to send this with -rc0 so close around the
> corner. I think that this *could* wait until v2.28.1 or v2.29.0 since
> fetch.writeCommitGraph is no longer implied by feature.experimental, but
> I figure that it is probably better to get this into v2.28.0 since it
> fixes the issue once and for all, so long as there is consensus that the
> patch is good.

I'm of course inclined to like it, so before reading through the rest my
preference would be to include both patches (this fix and the patch I
sent to reduce user exposure) in -rc0.  But let's see if the patch
changes my opinion. ;-)

[...]
>  commit-graph.c           |  3 ++-
>  commit.c                 |  2 ++
>  object.h                 |  1 +
>  t/t5537-fetch-shallow.sh | 14 ++++++++++++++
>  4 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/commit-graph.c b/commit-graph.c
> index fdd1c4fa7c..328ab06fd4 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -203,7 +203,8 @@ static int commit_graph_compatible(struct repository *r)
>  	}
> 
>  	prepare_commit_graft(r);
> -	if (r->parsed_objects && r->parsed_objects->grafts_nr)
> +	if (r->parsed_objects &&
> +	    (r->parsed_objects->grafts_nr || r->parsed_objects->substituted_parent))

A subtlety: we can't *just* check for substituted parents, because
there could be a graft affecting a commit we haven't parsed yet.  So
we'd have to check for both grafts yet to be applied (grafts_nr) and
grafts already applied (substituted_parent).

Good.

[...]
> --- a/commit.c
> +++ b/commit.c
> @@ -423,6 +423,8 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
>  	pptr = &item->parents;
> 
>  	graft = lookup_commit_graft(r, &item->object.oid);
> +	if (graft)
> +		r->parsed_objects->substituted_parent = 1;

This applies right away at the only place in commit parsing where
grafts can be discovered.

The only other callers to lookup_commit_graft are get_shallow_commits
and prepare_shallow_info.  Those are protocol code and they don't
affect the in-core history.

[...]
> --- a/object.h
> +++ b/object.h
> @@ -25,6 +25,7 @@ struct parsed_object_pool {
>  	char *alternate_shallow_file;
> 
>  	int commit_graft_prepared;
> +	int substituted_parent;

parsed_object_pool is zero-initialized on creation (in
parsed_object_pool_new), so this gets correctly initialized to false.

[...]
> --- a/t/t5537-fetch-shallow.sh
> +++ b/t/t5537-fetch-shallow.sh
> @@ -81,6 +81,20 @@ test_expect_success 'fetch --unshallow from shallow clone' '
>  	)
>  '
> 
> +test_expect_success 'fetch --unshallow from a full clone' '
> +	git clone --no-local --depth=2 .git shallow3 &&
> +	(
> +	cd shallow3 &&
> +	git log --format=%s >actual &&
> +	test_write_lines 4 3 >expect &&
> +	test_cmp expect actual &&
> +	git -c fetch.writeCommitGraph fetch --unshallow &&
> +	git log origin/master --format=%s >actual &&
> +	test_write_lines 4 3 2 1 >expect &&
> +	test_cmp expect actual
> +	)
> +'
> +

The indentation is odd here, but it's consistent with the rest of the
file.

A fairly straightforward test that demonstrates the bug being fixed and
only relies on what was set up in the initial 'setup' test (4 commits).
Thanks for tying that loose end.

With or without commit message tweaks along the lines described above,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for your thoughtful work, as always.
