Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6177CC433FE
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 18:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiKOSPb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 13:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKOSP2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 13:15:28 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62542FC09
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 10:15:27 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 204-20020a2510d5000000b006be7970889cso14046735ybq.21
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 10:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IeWAuQTvmU1A1yZHDJFqUDbWV4cfF5zG6OAxRVMneTk=;
        b=TWvtkJ+V/RZI9L7BrNG/lMdbyCv79DmidWtIyh50vAlLn+xtai9elKtnBd3JUMylBq
         3e87TPViypkey8iTtvbFCPTryiJ1vQb12HEAr/N1m8K6BctdebYS03SdSHuDaE67yAwR
         3EBeVX6FXRbF70Hbop8wquiO7rHQYgQKZFIssIdNek6mIdiV82RuXTJgiKHpoJ4E22/f
         gLWr1HUbYaR1JB/mhOH3sI/3FwBtbrEM3qNKBkzo9VW6N7k0mR3XA+Vwe8qhnSVsNIEK
         DJ7LnOVGQj/OeGIjCbwaGLmbdyjwvdfSqfP7IXW4s3owNlyc4UXt8d2r745SQsDhC+eg
         kSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IeWAuQTvmU1A1yZHDJFqUDbWV4cfF5zG6OAxRVMneTk=;
        b=hBcrrs+AQ2sdha8EmY9eZ9SG5G2UXcg3k9pa3xEkhTRMnpw7HH+R7rGYT5ykrN42E/
         cxjDCY4ahL4csHSVX+2Gq7urSp8uIkQamBeEXgo2cPQDrOq6uSb8X47WtlcfJO/eGqNX
         1XMGKsIvFTkhTCxHbFW+c9lRL7nv0YWlEwnqY42eQ8CfNwFDpOt1lWDiUhQsKubuCyv/
         VKKz2VhxOZ3Szw9Ovp0pqGDDgthC9p0yGPkrmdbKZgE/mOoDQZC2qmHoHysEh8lN5G4f
         2TT9WnKlrdf8tdNB1ShVxWICC7wFCsfaSkDyPl7bljrMwiH50gct3B398lswsGQngJ+N
         AxsA==
X-Gm-Message-State: ANoB5pnpup7XH7P/ELqAgfEYKgtZ3kfyKLpRLt1upMYg9BN0yQDuGbMR
        Lsa7VWM/pigRlwThdR2PMvoODLz+YncEkf78nhLa
X-Google-Smtp-Source: AA0mqf7lCcEYxgujG71BIdvY5ZW/0LR+IrKO+SbP8LF6ScNoGKA5P3IfRs9HPWDyIdBb51AHQn0As6LEg/5WQ+FwNH39
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:900c:0:b0:6c4:8a9:e4d2 with SMTP
 id s12-20020a25900c000000b006c408a9e4d2mr18341987ybl.164.1668536127222; Tue,
 15 Nov 2022 10:15:27 -0800 (PST)
Date:   Tue, 15 Nov 2022 10:15:24 -0800
In-Reply-To: <7cdd6c4184da2d3109498589167f10ecf972edc9.1666988096.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
Message-ID: <20221115181524.164472-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 8/8] clone, submodule update: create and check out branches
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
> +# Test the behavior of an already-cloned submodule.
> +# NEEDSWORK When updating with branches, we always use the branch instead of the
> +# gitlink's OID. This results in some imperfect behavior:
> +#
> +# - If the gitlink's OID disagrees with the branch OID, updating with branches
> +#   may result in a dirty worktree
> +# - If the branch does not exist, the update fails.
> +#
> +# We will reevaluate when "git checkout --recurse-submodules" supports branches
> +# For now, just test for this imperfect behavior.

I think the rationale for this behavior is as follows:

We want a world in which submodules have branches and Git commands use them
wherever possible. There are a few options for "git submodule update" when the
superproject has a branch checked out:

1. Checkout the branch, ignoring OID (as in this patch).
2. Checkout the branch, erroring out if the OID is wrong.
3. 1 + creating the branch if it does not exist.
4. 2 + creating the branch if it does not exist.
5. Always forcibly create the branch at the gitlink's OID and then checking
   it out.

At this point in the discussion, for a low-level command like "git submodule
update", doing as little as possible makes sense to me, which is 1.

But since we do not automatically create the branch if it does not exist, this
means that we have to do it when we clone the submodule. Our options are:

A. Create only the branch that is checked out in the superproject (as in this
   patch).
B. Create all branches that are present in the superproject.
C. Go back on our previous decision, switching to 3.

My instinct is that we want to maintain, as much as possible, the invariant
that for each branch in the superproject, if the branch tip has a gitlink
pointing to a submodule, that submodule has a branch of the same name. And I
think that this invariant can only be maintained by "git submodule update" if
we use B or C.

> +test_expect_success 'branches - other branch checked out, correct branch exists, OIDs disagree' '
> +	test_when_finished "rm -fr branch-super-cloned" &&
> +	cp -r branch-super-clean branch-super-cloned &&
> +
> +	git -C branch-super-cloned branch --recurse-submodules new-branch &&
> +	git -C branch-super-cloned checkout new-branch &&
> +	git -C branch-super-cloned/sub1 checkout new-branch &&
> +	test_commit -C branch-super-cloned/sub1 new-commit &&
> +	git -C branch-super-cloned/sub1 checkout main &&
> +	git -C branch-super-cloned submodule update &&
> +
> +	HEAD_BRANCH1=$(git -C branch-super-cloned/sub1 symbolic-ref HEAD) &&
> +	test $HEAD_BRANCH1 = "refs/heads/new-branch" &&
> +	test_clean_submodule ! branch-super-cloned sub1
> +'
> +
> +test_expect_success 'branches - other branch checked out, correct branch does not exist' '
> +	test_when_finished "rm -fr branch-super-cloned" &&
> +	cp -r branch-super-clean branch-super-cloned &&
> +
> +	git -C branch-super-cloned branch new-branch &&
> +	git -C branch-super-cloned checkout new-branch &&
> +	test_must_fail git -C branch-super-cloned submodule update

Can we also check what error message is being printed?
 
