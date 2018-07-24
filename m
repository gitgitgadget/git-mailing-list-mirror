Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20E371F597
	for <e@80x24.org>; Tue, 24 Jul 2018 19:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388486AbeGXU3P (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 16:29:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37809 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388470AbeGXU3P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 16:29:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id q10-v6so5192365wrd.4
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 12:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gMS63YS6dflmmZ32GUZ7pllNPxQvQlKTOA/0HXFK9b0=;
        b=CvHISOI51mY1sqwD/Wig4ZzIcNxKiW9E2X8ue7nx3n5wDKo4F7Io70KVpQmzFwsqMm
         sijSvAhHCbcjdoK0Dyd3JZJIb8cERbB1xZXN/SRuPKeoXgCqwsc98LwodR2PrLp3vh/q
         nszkP7KDITwcVKBjHCEY5Golm3Z5FioZzaK6BOgJ8f9UnsI+O1E4JEnOg0jDxEeI+7Hr
         JUCfDrVyz0q9fnvhiHIilKj1XzdMvlb6Jzv/5dvyxIIc2cRr6mto8yY5WtUB4WTPH/xI
         rircd44bdJLpGyoOa4U8Cv52F6axylQOP5r/vegZmYB2PFHPCNx3Twny9AJE6ssFKcwd
         4prg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gMS63YS6dflmmZ32GUZ7pllNPxQvQlKTOA/0HXFK9b0=;
        b=uSqTYW/fUvDvRd+0nukVuxl5+ccGTEknofW43RQcbHb62LCC9JSFhnavobi4Tt2SjA
         qGdSgAVJsA66sV0nQgUJ06YJywUDRIGS5l6IigWiVHw53GFlq+ZWgTToLDdExbcDsWK+
         LLxkrJB6jm+Azl9VIy7GCznUbsHAJB1ilMPO/HE4XiIS1ucb/BC+SjezbHOCHiBUBS1O
         ubWlcfqDj42f8CDvjBAMNGW0WmuKkQmWRqxTBKLkTq616YWTOeB+zva3qrUNysY27yza
         XEZJ4QpWgEp8HmWd7B7mvyf9qMYWc5CXAG1+tPuDZE1Yqk9fIpOTwihfGAfTwMoLk6t3
         5S3Q==
X-Gm-Message-State: AOUpUlEsI22l3vl1GXnX7DH3ufW9+A+TYKvxbwhLG/jrG2zDDz5KJ4Kx
        3g72/tgeJNMj0mpAMtRaGv0=
X-Google-Smtp-Source: AAOMgpeD5emBj8DXaxwN49LjFfqJ9n5cprQ6bikKeqwOFSv8k+sAbekOUIaJRmRk18lcdf05V1PnFQ==
X-Received: by 2002:adf:8296:: with SMTP id 22-v6mr12168082wrc.252.1532460078730;
        Tue, 24 Jul 2018 12:21:18 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e10-v6sm2843642wmh.19.2018.07.24.12.21.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 12:21:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v1] checkout: optionally speed up "git checkout -b foo"
References: <20180724180122.29212-1-benpeart@microsoft.com>
Date:   Tue, 24 Jul 2018 12:21:17 -0700
In-Reply-To: <20180724180122.29212-1-benpeart@microsoft.com> (Ben Peart's
        message of "Tue, 24 Jul 2018 18:01:39 +0000")
Message-ID: <xmqqh8koxwwi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <Ben.Peart@microsoft.com> writes:

> From: Ben Peart <Ben.Peart@microsoft.com>
>
> If the new core.optimizecheckout config setting is set to true, speed up
> "git checkout -b foo" by avoiding the work to merge the working tree.  This
> is valid because no merge needs to occur - only creating the new branch/
> updating the refs. Any other options force it through the old code path.
>
> This change in behavior is off by default and behind the config setting so
> that users have to opt-in to the optimized behavior.




> We've been running with this patch internally for a long time but it was
> rejected when I submitted it to the mailing list before because it
> implicitly changes the behavior of checkout -b. Trying it again configured
> behind a config setting as a potential solution for other optimizations to
> checkout that could change the behavior as well.
>
> https://public-inbox.org/git/20180724042740.GB13248@sigill.intra.peff.net/T/#m75afe3ab318d23f36334cf3a6e3d058839592469

An incorrect link?  It does not look like a thread that explains
what was previously submitted but failed.  The last paragraph looks
like a fine material below the three-dash line.


> Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
> ---
>
> Notes:
>     Base Ref: master
>     Web-Diff: https://github.com/benpeart/git/commit/f43d934ce7
>     Checkout: git fetch https://github.com/benpeart/git checkout-b-v1 && git checkout f43d934ce7
>
>  Documentation/config.txt |  6 +++
>  builtin/checkout.c       | 94 ++++++++++++++++++++++++++++++++++++++++
>  cache.h                  |  1 +
>  config.c                 |  5 +++
>  environment.c            |  1 +
>  5 files changed, 107 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index a32172a43c..2c4f513bf1 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -911,6 +911,12 @@ core.commitGraph::
>  	Enable git commit graph feature. Allows reading from the
>  	commit-graph file.
>  
> +core.optimizedCheckout
> +	Speed up "git checkout -b foo" by skipping much of the work of a
> +	full checkout command.  This changs the behavior as it will skip
> +	merging the trees and updating the index and instead only create
> +	and switch to the new ref.

By the way, why is it a core.* thing, not checkout.* thing?

If a new feature is not necessarily recommendable for normal users
and it needs to be hidden behind an opt-in knob (I do not have a
strong opinion if that is or is not the case for this particular
feature at this point), the documentation for the knob should give a
bit more than "This chang(e)s the behavior" to the readers, I would
think, to be intellectually honest ;-).  Let's tell them what bad
things happen if we pretend that we switched the branch without
twoway merge and the index update to help them make an informed
decision.

> +static int needs_working_tree_merge(const struct checkout_opts *opts,
> +	const struct branch_info *old_branch_info,
> +	const struct branch_info *new_branch_info)
> +{
> +	/*
> +	 * We must do the merge if we are actually moving to a new
> +	 * commit tree.

What's a "commit tree"?  Shouldn't it be just a "commit"?

> +	 */
> +	if (!old_branch_info->commit || !new_branch_info->commit ||
> +		oidcmp(&old_branch_info->commit->object.oid, &new_branch_info->commit->object.oid))
> +		return 1;
> +
> +	/*
> +	 * opts->patch_mode cannot be used with switching branches so is
> +	 * not tested here
> +	 */
> +
> +	/*
> +	 * opts->quiet only impacts output so doesn't require a merge
> +	 */
> +
> +	/*
> +	 * Honor the explicit request for a three-way merge or to throw away
> +	 * local changes
> +	 */
> +	if (opts->merge || opts->force)
> +		return 1;
> +
> +	/*
> +	 * --detach is documented as "updating the index and the files in the
> +	 * working tree" but this optimization skips those steps so fall through
> +	 * to the regular code path.
> +	 */
> +	if (opts->force_detach)
> +		return 1;
> +
> +	/*
> +	 * opts->writeout_stage cannot be used with switching branches so is
> +	 * not tested here
> +	 */
> +
> +	/*
> +	 * Honor the explicit ignore requests
> +	 */
> +	if (!opts->overwrite_ignore || opts->ignore_skipworktree ||
> +		opts->ignore_other_worktrees)
> +		return 1;
> +
> +	/*
> +	 * opts->show_progress only impacts output so doesn't require a merge
> +	 */
> +
> +	/*
> +	 * If we aren't creating a new branch any changes or updates will
> +	 * happen in the existing branch.  Since that could only be updating
> +	 * the index and working directory, we don't want to skip those steps
> +	 * or we've defeated any purpose in running the command.
> +	 */
> +	if (!opts->new_branch)
> +		return 1;
> +
> +	/*
> +	 * new_branch_force is defined to "create/reset and checkout a branch"
> +	 * so needs to go through the merge to do the reset
> +	 */
> +	if (opts->new_branch_force)
> +		return 1;
> +
> +	/*
> +	 * A new orphaned branch requrires the index and the working tree to be
> +	 * adjusted to <start_point>
> +	 */
> +	if (opts->new_orphan_branch)
> +		return 1;
> +
> +	/*
> +	 * Remaining variables are not checkout options but used to track state
> +	 */
> +
> +	return 0;
> +}

This helper function alone looks like we are creating a maintenance
nightmare from a quick scan.  How are we going to keep this up to
date?

I offhand do not know how "git checkout -b foo" would behave
differently if we do not do a two-way merge between HEAD and HEAD to
update the index.  We'd still need to list the local modifications
and say "Switched to a new branch 'foo'", but that would be a minor
thing compared to the two-way merge machinery.

Was the primary reason why the patch "changes the behaviour" because
nobody could prove that needs_working_tree_merge() helper reliably
detects that "checkout -b foo" case and that case alone, and show a
way to make sure it will keep doing so in the future when other new
features are added to the command?

> @@ -479,6 +565,14 @@ static int merge_working_tree(const struct checkout_opts *opts,
>  	int ret;
>  	struct lock_file lock_file = LOCK_INIT;
>  
> +	/*
> +	 * Skip merging the trees, updating the index, and work tree only if we
> +	 * are simply creating a new branch via "git checkout -b foo."  Any
> +	 * other options or usage will continue to do all these steps.
> +	 */
> +	if (core_optimize_checkout && !needs_working_tree_merge(opts, old_branch_info, new_branch_info))
> +		return 0;
> +
>  	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
>  	if (read_cache_preload(NULL) < 0)
>  		return error(_("index file corrupt"));

Thanks.
