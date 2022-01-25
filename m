Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBAEC5AC75
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 23:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbiAYXjv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 18:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbiAYXju (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 18:39:50 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15583C06161C
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 15:39:50 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id a4-20020a17090a70c400b001b21d9c8bc8so1862678pjm.7
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 15:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OAjmSRyQY7QYymsRzKoFbnpE+tlnsSFTv5b/vq7vWL0=;
        b=qHqIbhU6az0wQJNq+PotmTItgO4Pa4EQWUDFo3gL6mfYuKyARGv4368gbZpA40SCYa
         4uauNWNtsABONfwrRBBs3urA4Hln9beZeN0lHk2a0WOb+/elNormT65RtJrER7AGDkxr
         bHPA3Kzi+GKAFxpv0bOLRbooxUujp04INkwUJbJw1CHv0CRyR3CR8v3Ta33giUgMcZ2U
         qMTlHx0SKLqo71Az2t/I4QBEgowzuHzl2rdLTwQS8dv7ClxWTYNyaOEafaCpclF7WdLS
         BxXUJ/7F4M+8cfPP9RC/7Kch4Yl8/IIzIUy/cUmWFXd6JJ8SMnmaTPla27N1en+yWLle
         u/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OAjmSRyQY7QYymsRzKoFbnpE+tlnsSFTv5b/vq7vWL0=;
        b=Vx5V8qaYHkdCofZedWqPlObNfxWl2yoCF0+URHNCUkq9FxVR/KV4AXat+fN6bchf0H
         bu2AR5C3yL0qxdO2Fi/U31RBa1eV70mFgWWapzVplca7stqWCMF8vUiy5txvHngfdBjw
         kJtBTmpr0rMRRqYLODsBRQdA5QrM0OST+WDq5hbXiM4XFyiZg2zaXQSoQBlgom+zS5wb
         faDYH39q4AwzrZM77NQtRbtA7b6y4qcDVDzMnjNnaUZwsLilNQ27sTOmYal0BOoh1f2o
         UDaflD/B8VZ42nAaDou3J9n4nRI8v1wydYrLIoyS4R5QWFyEJnWruUIsuh5RqrhYfDzA
         DSPQ==
X-Gm-Message-State: AOAM531MMg8cnq+kCeGNGg2ScX26Rum9We/8/jZjXnKYcX8xEDdCIfcd
        eDHHgx802nXWhiK5JeqVz7TWTnXHxjaoQHLAJBPyjLp+nu6E3AxV4K+qa4Xskx8qiPgysDa5zk8
        W5tZYlERs2kx9mXedOyC16dUq3BzHgR0cnT5wijc8BhEbEN/ytr/N2N+Wif82zbk=
X-Google-Smtp-Source: ABdhPJytELdZtpmwYoI6yo6AUxPhUo1v0NDekPxzF2UP4AM7FiEHCB7AQVBeByDZXczoppyuftW8jzTvW/W5Hg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:be15:b0:149:a608:7098 with SMTP
 id r21-20020a170902be1500b00149a6087098mr20568628pls.63.1643153989526; Tue,
 25 Jan 2022 15:39:49 -0800 (PST)
Date:   Tue, 25 Jan 2022 15:39:48 -0800
In-Reply-To: <20220125233612.46831-1-chooglen@google.com>
Message-Id: <kl6lfspb1j23.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220125233612.46831-1-chooglen@google.com>
Subject: Re: [PATCH] sequencer.c: set GIT_WORK_TREE in run_git_checkout
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> When rebasing in a subdirectory of a worktree, Git fails due to a dirty
> worktree:
>
>   error: The following untracked working tree files would be overwritten
> by merge:
>           a/b/c
>   Please move or remove them before you merge.
>
> This occurs because "git rebase" invokes a "git checkout" without
> propagating the GIT_WORK_TREE environment variable, causing the worktree
> to be assumed to be ".". This was not an issue until bc3ae46b42 (rebase:
> do not attempt to remove startup_info->original_cwd, 2021-12-09), when
> the .dir of the "git checkout" child process was changed such that it no
> longer runs at the root of the worktree.
>
> Propagate GIT_WORK_TREE to the "git checkout" child process and test
> that rebase in a subdirectory of a worktree succeeds.
>
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
> Here is a fix for the bug I found in [1]. I didn't look through the rest
> of the "preserve cwd" thread for other possible bugs pertaining to
> worktrees, but I didn't find any during a cursory glance at sequencer.c.
>
> I'm also not sure if this is the idiomatic way to do it since, I assume,
> we'd always want to propagate GIT_WORK_TREE, but this is identical to
> how do_exec() sets GIT_WORK_TREE in the same file (perhaps this is
> something that should be refactored).
>
> [1] https://lore.kernel.org/git/kl6lilu71rzl.fsf@chooglen-macbookpro.roam.corp.google.com

I forgot to add this to the previous email:

cc-ing Junio because this bug is in master.
