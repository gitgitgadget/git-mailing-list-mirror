Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B504C433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 18:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239353AbhLHSwP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 13:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhLHSwP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 13:52:15 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05719C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 10:48:43 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id p3-20020a170903248300b00143c00a5411so1278436plw.12
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 10:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vcwyafEqac5ceNnTG5LVkp1lmV+/WhMb35XmwjwDNPA=;
        b=kbFnyoXeVXTw9DAiBcKrfrVfmW5nzOsht+CRQ0qbYI57+B2J1PVMQ9GlQj7cSy623j
         u+xVNuhL6quZy8UhPs9xpoqUDJAdzpehZ1z+PV3dlqZ9z2rhs3iCtmbXSZKx7iTOULbi
         4Qd39jaDt/3TZYKUtirAuHrXMCZulBjf7DyWO93VTsGu3kfCuUmgS71xfa0Kh0fGOy8a
         s5O85sbz3UQBAdbmJ8tcQhgEyWypdBHjPvFt/ELtbfe34gUF25eJDKS/qQjcqovKvW2g
         jsH/G1y9n8ybWWBaFYHCLFz7GK7RQR0Yu/SZqHFTBopaScBkOB3oPdYDPP4i199vtuxR
         AFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vcwyafEqac5ceNnTG5LVkp1lmV+/WhMb35XmwjwDNPA=;
        b=vhQCctmyq5rQA540k5QcphDznsM2VToercqBXpA40IvohX0grkB8W3unxR5HfJI4qi
         WdaTCubCdzAhy9BvD7XNfyx4yhpP5fFoHQCUjWw4lItwcsjsG0Z2A1BKV8eAOi+jBxPN
         zv23V9JPdnYXFOVfGVEMNw+8WPCFVyWW0wCTNNdM545l27GQgN3CmRDsW0TevIzJGnNK
         89lFGF4vBsS8Tyo3TIu5BizpRhG1lu+oul014FDJRvqPhL4MxtduTdFqnwKLmhmT7sYu
         dYCWJoU0gfJ1ONDsjZTqAwk9D2D/pDdmj+kphajugex393QqjX5siDPHdhxmDG1UcKR3
         ejyA==
X-Gm-Message-State: AOAM5321VwFbMlOqxp89pQR679tJ+xMP/HBFNcT0VjYkhUWicWrPR8PL
        lsotG+Z5a3mgVyUft+rRrKFB+Cq2omhxeg==
X-Google-Smtp-Source: ABdhPJxC2WLQlcfUby/UoXsgylGchTBUn8GoIzyj+m+NdO8ZUg5sdoQfvLP1KNpsuE23sazVsR6VgSW5jSWD+A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1a51:b0:4a3:4af3:fcc6 with SMTP
 id h17-20020a056a001a5100b004a34af3fcc6mr7117207pfv.85.1638989322482; Wed, 08
 Dec 2021 10:48:42 -0800 (PST)
Date:   Wed, 08 Dec 2021 10:48:40 -0800
In-Reply-To: <xmqqbl1tcptq.fsf@gitster.g>
Message-Id: <kl6l5yrzaq5z.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211122223252.19922-1-chooglen@google.com> <20211206215528.97050-1-chooglen@google.com>
 <20211206215528.97050-2-chooglen@google.com> <xmqqbl1tcptq.fsf@gitster.g>
Subject: Re: [PATCH v2 1/3] branch: move --set-upstream-to behavior to setup_tracking()
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> As Jonathan noted in v1, the diff is quite large. I could shrink this
>> by forward-declaring setup_tracking() so that the function definitions
>> are in the same order; let me know if that would be preferred.
>
> If you are not making any changes to setup_tracking() and just
> moving, then the patch size inflated by the move is OK.
>
> If you are moving and changing at the same time, well, that would
> make it harder to read what is going on in the patch, so you want to
> find a way to avoid it.  Splitting it the pure move into a separate
> patch or use of forward-declaration may be good ways to do so.

Thanks for the advice! I'll use one of these approaches.

> The post context continues with:
>
> 				advise(_(upstream_advice));
> 				exit(1);
> 			}
> 			die(_(upstream_missing), start_name);
>
> This is not a problem with this patch, and it should not be fixed as
> part of this series, but since I noticed it, I'll mention it as a
> leftover low-hanging fruit to be fixed after the dust settles.  The
> exit(1) looks wrong.  We should exit with 128 just like die() does.
> Issuing of an advice message should not affect the exit code.

I'll include an optional cleanup patch to address this and the exit(-1).

>> +void setup_tracking(const char *new_ref, const char *orig_ref,
>> +			   enum branch_track track, int quiet, int expand_orig)
>
> It is unclear what expand_orig option is supposed to do and how it
> would help the caller.  Perhaps a comment before the function is in
> order (the comment in branch.h before the declaration of this
> function does not make it clear, either).

Ah, I will add extra clarification.

This boolean parameter controls whether or not we should validate + DWIM
orig_ref. This is a performance optimization to avoid expanding an
orig_ref that has already been expanded (e.g. because create_branch()
has already expanded it).

But, as you point out later on, this may not be a good idea.

>> +{
>> +	struct tracking tracking;
>> +	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
>> +	char *full_orig_ref;
>> +	struct object_id unused_oid;
>> +
>> +	memset(&tracking, 0, sizeof(tracking));
>> +	if (expand_orig)
>> +		validate_branch_start(the_repository, orig_ref, track, &unused_oid, &full_orig_ref);
>
> So, the idea is, because we are setting up a new_ref to "track"
> orig_ref, we may be better off pretending that we are "creating a
> new branch from the orig_ref and tracking it", so that orig_ref that
> is not something we can track will be caught with the same logic?
>
> This will cause full_orig_ref to start with "refs/heads/" or
> "refs/remotes/" if 'track' is something that requires tracking.

Yes.

>> +	else
>> +		full_orig_ref = xstrdup(orig_ref);
>
> Even though the variable claims to be FULL orig_ref, when this side
> of if/else is taken, nobody guarantees that full_orig_ref is in fact
> a full ref, or merely the name of the branch, no?  Would that cause
> problems later?

Yes, the assumption is that the caller has already done the work of
making sure that orig_ref has been validated and expanded into its full
form. As mentioned earlier, this is purely a performance optimzation,
but it is not a very safe one because it requires the caller to pick the
correct value for expand_orig.

I chose this approach because I anticipate that the only callers of
setup_tracking() will be create_branch() (which always wants expand_orig
= 0) and cmd_branch() (which always wants expand_orig = 1), so the right
course of action is clear for now. I don't think setup_tracking() will
be useful to anyone else, but expand_orig is a potential sharp edge for
new callers.

My next-preferred option would be to remove "expand_orig" and always
call validate_branch_start(). We might waste a few cycles sometimes, but
the function becomes impossible to misuse.

>> +	tracking.spec.dst = full_orig_ref;
>> +	if (for_each_remote(find_tracked_branch, &tracking))
>> +		goto cleanup;
>> +
>> +	if (!tracking.matches)
>> +		switch (track) {
>> +		case BRANCH_TRACK_ALWAYS:
>> +		case BRANCH_TRACK_EXPLICIT:
>> +		case BRANCH_TRACK_OVERRIDE:
>> +			break;
>> +		default:
>> +			goto cleanup;
>> +		}
>> +
>> +	if (tracking.matches > 1)
>> +		die(_("Not tracking: ambiguous information for ref %s"),
>> +		    full_orig_ref);
>
> What's the next step for the user to take, after seeing this message?
> Do we have the necessary info readily available to help them at this
> point in tracking.* structure (e.g. "it could be following X or Y and
> we cannot decide between the two for you"), or have we discarded the
> information already?

This information is discarded in expand_ref(). From the function
signature:

  int expand_ref(struct repository *repo, const char *str, int len,
	       struct object_id *oid, char **ref)

The return value is the number of matched refs and "ref" is an out
parameter containing the first matched ref.

> If tracking.matches == 0, because we broke out of the switch() for
> some values of track, we will make this install_branch_config()
> using members of the tracking structure, which is a bit unnerving.
>
>> +	if (install_branch_config(config_flags, new_ref, tracking.remote,
>> +			      tracking.src ? tracking.src : full_orig_ref) < 0)
>
> But tracking.src==NULL is substituted with full_orig_ref, so as long
> as the value in that variable is sensible, we would probably be ok
> on the 4th parameter.

When tracking.matches is zero, the assumption is that
install_branch_config() should set up tracking based off a local branch.
By default, we assume that users only want tracking for remote-tracking
branches, so only track local branches if we are confident that the user
wants this, aka track = BRANCH_TRACK_{EXPLICIT,ALWAYS,OVERRIDE} (and
soon, BRANCH_TRACK_INHERIT).

> I am not sure who set tracking.remote or if it is always set to a
> sensible value. Especially when tracking.matches is zero.

tracking.matches == 0 should imply that tracking.remote == NULL, which
gives us the expected behavior of tracking a local branch in
install_branch_config().

This is also a bit too implicit for my tastes, but I don't think this is
the time for such a refactor :)
