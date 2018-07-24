Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABAE91F597
	for <e@80x24.org>; Tue, 24 Jul 2018 18:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388515AbeGXTt7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 15:49:59 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:45814 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388429AbeGXTt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 15:49:59 -0400
Received: by mail-yb0-f194.google.com with SMTP id h127-v6so2013831ybg.12
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 11:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=id/yuyw9XmOfijcjQLanl8ewwy2mR2rfdTA9ljl3KdA=;
        b=mX9Kfu1oBfTNBf8nr9B/lhqQ2ftOrbLm0le8mu0U6ZLtCY4AUYCs0fYxuxQ6VWhV1P
         jwkN6schv+dCNDiJstL2S8NIDetdIf9EvHvG7KMkiKcLvdDFXuj3wYPIoGmTwkckTj4+
         m5/O1/GDYz0BTOXB2P/6g0g3w7sX7lhYrKgzzEszWPudbyP9I4UpLa367KeAeE42Epkm
         dlsY21pUQ8kPWgFrBhFaTyPMlZAI8UJVGJ39IjWGQjHF5t8OUbDRl+mSNB/TFHV2G09d
         /5ryUi+XmLZmns5RSTkSbcIs10Gpb8kZRzDK9DaN5oV30+5ILQU0A7zhmfmEpLAg1j/u
         ewkA==
X-Gm-Message-State: AOUpUlH4OyUVZClmI3RuyojadgyrCP/stUoVqiNWBY9G2cQk3yaJqkIo
        USAafDCO0PmjgDhg2WsDtZwlSH2Bsq7e1qyHvaI=
X-Google-Smtp-Source: AAOMgpeGVkGLlPapRPLr0QZH+0qdqNsvPyD56tIQChPx8p2iSIeozc0ubXUbQ5axaKA1Ukf5PpGUyS8NfnQURxUe/u0=
X-Received: by 2002:a5b:601:: with SMTP id d1-v6mr9829865ybq.295.1532457731858;
 Tue, 24 Jul 2018 11:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180724180122.29212-1-benpeart@microsoft.com>
In-Reply-To: <20180724180122.29212-1-benpeart@microsoft.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 24 Jul 2018 14:42:00 -0400
Message-ID: <CAPig+cQZ4g-6uT3zB0n2XWb-68DUUBZdaimTb6_Y4DNZrLUdyQ@mail.gmail.com>
Subject: Re: [PATCH v1] checkout: optionally speed up "git checkout -b foo"
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 24, 2018 at 2:01 PM Ben Peart <Ben.Peart@microsoft.com> wrote:
> If the new core.optimizecheckout config setting is set to true, speed up

Maybe:

    Add core.optimizeCheckout config setting which, when true, speeds up

> "git checkout -b foo" by avoiding the work to merge the working tree.  This
> is valid because no merge needs to occur - only creating the new branch/
> updating the refs. Any other options force it through the old code path.
>
> This change in behavior is off by default and behind the config setting so
> that users have to opt-in to the optimized behavior.
>
> We've been running with this patch internally for a long time but it was
> rejected when I submitted it to the mailing list before because it
> implicitly changes the behavior of checkout -b. Trying it again configured
> behind a config setting as a potential solution for other optimizations to
> checkout that could change the behavior as well.

This paragraph is mere commentary which probably belongs below the
"---" line following your sign-off.

> https://public-inbox.org/git/20180724042740.GB13248@sigill.intra.peff.net/T/#m75afe3ab318d23f36334cf3a6e3d058839592469

Is this link meant to reference the previous attempt of optimizing
"checkout -b"? Although there's a single mention of "checkout -b" in
that discussion, it doesn't seem to be the previous attempt or explain
why it was rejected.

It would be quite nice to see a discussion in both the commit message
and the documentation about the pros and cons of enabling this
optimization. That it was previously rejected suggests that there may
be serious or unexpected consequences. How will a typical user know
whether its use is desirable or not?

> Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> @@ -911,6 +911,12 @@ core.commitGraph::
> +core.optimizedCheckout
> +       Speed up "git checkout -b foo" by skipping much of the work of a
> +       full checkout command.  This changs the behavior as it will skip

s/changs/changes/

> +       merging the trees and updating the index and instead only create
> +       and switch to the new ref.
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> @@ -471,6 +475,88 @@ static void setup_branch_path(struct branch_info *branch)
> +static int needs_working_tree_merge(const struct checkout_opts *opts,
> +       const struct branch_info *old_branch_info,
> +       const struct branch_info *new_branch_info)
> +{
> +       /*
> +        * We must do the merge if we are actually moving to a new
> +        * commit tree.
> +        */
> +       if (!old_branch_info->commit || !new_branch_info->commit ||
> +               oidcmp(&old_branch_info->commit->object.oid, &new_branch_info->commit->object.oid))
> +               return 1;
> +       [...]
> +       return 0;
> +}

This long list of special-case checks doesn't leave me too enthused,
however, that aside, this approach seems backward. Rather than erring
on the side of safety by falling back to the merging behavior, it errs
in the other direction, which may be a problem if this list of
special-case checks ever gets out of sync with 'checkout_opts'. That
is, if someone adds a new option which ought to employ the merging
behavior, but forgets to update this function, then this function will
incorrectly default to using the optimization.

A safer approach would be the inverse, namely:

    static int skip_worktree_merge(...)
    {
        if (...meets all criteria for optimization...)
            return 1;
        return 0;
    }

>  static int merge_working_tree(const struct checkout_opts *opts,
>                               struct branch_info *old_branch_info,
>                               struct branch_info *new_branch_info,
> {
> +       /*
> +        * Skip merging the trees, updating the index, and work tree only if we
> +        * are simply creating a new branch via "git checkout -b foo."  Any
> +        * other options or usage will continue to do all these steps.
> +        */
> +       if (core_optimize_checkout && !needs_working_tree_merge(opts, old_branch_info, new_branch_info))
> +               return 0;

This seems a somewhat odd place to hook in this optimization,
especially as there is only a single caller of this function. Instead,
one might expect the caller itself to make this judgment and avoid
trying the merge in the first place if not needed. That is, in
switch_branches:

    if (!skip_worktree_merge(...))
        ret = merge_working_tree(...);
