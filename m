Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A77C2D0C3
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 22:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E1D206DB
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 22:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="onlya0gV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfL3WB7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 17:01:59 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54681 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfL3WB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 17:01:59 -0500
Received: by mail-pj1-f67.google.com with SMTP id kx11so351571pjb.4
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 14:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uqX67kPVqpqC1IaA7xiALDBOZKpLfoBvKPOHuziFatQ=;
        b=onlya0gVvBeplq3K54wQYL4jMIRU9Kvvev5G9T5zr9Yvzk+xBC0+toCsA6mNlKhl9P
         unx3YXGHtq1NyB2QZrZwo1fMuqjTxfqENhPCN7S8f3O8DAwwNn40GqfB1FNDkO/B0hHm
         tRNkdqzcsI92te5pHN/5/xheT1b4xVQaBfqQMazd27xgrwi4tdnDI8xIOBhqTrI/jFwP
         0UTMBiHs45bbIV+yFyRwK7j5BBawHKzwSMQxqT1BKW9CW7MFwe/KXFlNGRipOopROj6K
         P8q94KTy3QtEEpsfFgJaZ1Y4gCpL8TCGfG1c+UcWmJK0EifNBeaJdZlFTLRqwbuzh7rG
         u4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uqX67kPVqpqC1IaA7xiALDBOZKpLfoBvKPOHuziFatQ=;
        b=TXqAaPliEZUAcLELnVHPxUlV+lNZa5taVogtjGtqI6Z7aYiI4v2GFlrz2Zed1qm6ML
         e0BPOLExdx4Zv/+nA18NW3pBNAvz3oLrDuzldv7H7AQH3+EaXAcjUxg+qy8yPfsHrbeg
         ZZbPx4SMtKy6Hl7WE36GlwAtdNSCiuCLJwZr3fd+XJzvTuRxJpYpsttl5BTQuxhiFBxp
         Ln6bMCXzb4aqTFujg05scuQrlOakUnpdrKvYD/sJCypprRqc+TIrnYuDpBPgB426XESw
         gK1lZKvANekDOyqM55Fc6NKlfsbcAWKd7b9v1MGjouwRf0RLI2J6iE9xoGB4nmbXWu4x
         dKyQ==
X-Gm-Message-State: APjAAAWEuJrVHZ6cKqDP8aKydC6WEqJihwUmnYfr4CqhE//rxUg6jH5F
        3z8BQyABcj6TF0RRWk7XHXg3qU3P
X-Google-Smtp-Source: APXvYqyCOWpi/77qF60VEGBYD2QNBuGPoGDa8HNbPT06A10DYfDVsog9bfynBBW4Bxg/hKw1PRptbQ==
X-Received: by 2002:a17:90a:5ac4:: with SMTP id n62mr1770905pji.59.1577743318421;
        Mon, 30 Dec 2019 14:01:58 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id z19sm49874026pfn.49.2019.12.30.14.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 14:01:57 -0800 (PST)
Date:   Mon, 30 Dec 2019 14:01:55 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] sha1-file: remove OBJECT_INFO_SKIP_CACHED
Message-ID: <20191230220155.GF57251@google.com>
References: <20191230211027.37002-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230211027.37002-1-jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan wrote:

> In a partial clone, if a user provides the hash of the empty tree ("git
> mktree </dev/null" - for SHA-1, this is 4b825d...) to a command which
> requires that that object be parsed, for example:
>
>   git diff-tree 4b825d <a non-empty tree>
>
> then Git will lazily fetch the empty tree. This fetch would merely be
> inconvenient if the promisor remote could supply that tree, but at
> $DAYJOB we discovered that some repositories do not (e.g. [1]).

Ooh, I think there's something subtle hiding in this paragraph.

When I first read it, I thought you meant that the repositories are
not self-contained --- that they contain references to the empty tree
but do not fulfill "want"s for them.  I don't believe that's what you
mean, though.

My second reading is the repository genuinely doesn't contain the
empty tree but different Git server implementations handle that
differently.  I tried to reproduce this with

	empty_tree=$(git mktree </dev/null)
	git init --bare x
	git clone --filter=blob:none file://$(pwd)/x y
	cd y
	echo hi >README
	git add README
	git commit -m 'nonempty tree'
	GIT_TRACE=1 git diff-tree "$empty_tree" HEAD

and indeed, it looks like Git serves the empty tree even from
repositories that don't contain it.  By comparison, JGit does not do
the same trick.  So we don't need to refer to a specific repository in
the wild to reproduce this.

All that said, having to fetch this object in the first place is
unexpected.  The question of the promisor remote serving it is only
relevant from the point of view of "why didn't we discover this
sooner?"

> There are 2 functions: repo_has_object_file() which does not consult
> find_cached_object() (which, among other things, knows about the empty
> tree); and repo_read_object_file() which does.

Hm, where does this dichotomy come from?  E.g. is the latter a
lower-level function used by the former?

>                                                This issue occurs
> because,

nit: on first reading I had trouble figuring out what "this issue"
refers to here.

[...]
>          as an optimization to avoid reading blobs into memory,
> parse_object() calls repo_has_object_file() before
> repo_read_object_file(). In the case of a regular repository (that is,
> not a partial clone), repo_has_object_file() will return false for the
> empty tree (thus bypassing the optimization) and repo_read_object_file()
> will nevertheless succeed, thus things coincidentally work.

This might be easier to understand if phrased in terms of the
intention behind the code instead of the specific call stacks used.
See f06ab027 for an example of this kind of thing.  For example:

  Applications within and outside of Git benefit from being able to
  assume that every repository contains the empty tree as an object
  (see, for example, commit 9abd46a347 "Make sure the empty tree
  exists when needed in merge-recursive", 2006-12-07).  To this end,
  since 346245a1bb (hard-code the empty tree object, 2008-02-13), Git
  has made the empty tree available in all repositories via
  find_cached_object, which all object access paths can use.

  Object existence checks (has_object_file), however, do not use
  find_cached_object.  <describe reason here>

>                                                             But in a
> partial clone, repo_has_object_file() triggers a lazy fetch of the
> missing empty tree.

  This particularly affects partial clones: has_object_file does not
  only report false in this case but contacts the promisor remote in
  order to obtain that answer.  The cost of these repeated negative
  lookups can add up.

  For example, in an optimization introduced in 090ea12671
  ("parse_object: avoid putting whole blob in core", 2012-03-07),
  object parsing uses has_object_file before read_object_file to check
  for a fast-path, so this negative lookup is triggered whenever we
  try to parse the absent empty tree.

When I state it this way, it's not obvious why this particular caller
of has_object_file is more relevant than others.  Did I miss some
subtlety?

[...]
>                                            This fetch would merely be
> inconvenient if the promisor remote could supply that tree, but at
> $DAYJOB we discovered that some repositories do not (e.g. [1]).

  If the promisor remote is running standard Git then it *does* have a
  copy of the empty tree, via the cached object itself.  This
  guarantee is not a documented part of the protocol, however, and
  other Git servers do not implement it.

> The best solution to the problem introduced at the start of this commit
> message seems to be to eliminate this dichotomy.

Indeed.  Can we justify the change even more simply in those terms?

  Object existence checks (has_object_file), however, do not use
  find_cached_object.  <describe reason here>

  This makes the API unnecessarily difficult to reason about.
  Instead, let's consistently view the empty tree as a genuine part of
  the repository, even in has_object_file.  As a side effect, this
  allows us to simplify the common 'has_object_file ||
  find_cached_object' pattern to a more simple existence check.

[...]
>                               A cost is that repo_has_object_file() will
> now need to oideq upon each invocation, but that is trivial compared to
> the filesystem lookup or the pack index search required anyway. (And if
> find_cached_object() needs to do more because of previous invocations to
> pretend_object_file(), all the more reason to be consistent in whether
> we present cached objects.) Therefore, remove OBJECT_INFO_SKIP_CACHED.

Thanks for discussing the possible costs, and I agree that they're
trivial relative to the I/O that these functions already incur.

[...]
>  object-store.h |  2 --
>  sha1-file.c    | 38 ++++++++++++++++++--------------------
>  2 files changed, 18 insertions(+), 22 deletions(-)

As hinted above, we should be able to simplify away has_sha1_file ||
find_cached_object checks in this change.

Thanks and hpoe that helps,
Jonathan
