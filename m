Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B373AC433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 23:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C402615E3
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 23:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbhKQXqI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 18:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhKQXqF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 18:46:05 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA49BC061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 15:43:04 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id x18-20020a170902ec9200b00143c6409dbcso1976890plg.5
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 15:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XDmz+Qh3hJAd5XMx8qUnbX+Nfm580xKqYhKrFaH0P9s=;
        b=hbklw7SjiHESVNnudIQATcz31BwX4jd1eR6zhPjOYSPAIVqoSPSMqEVTwouVcrfYY6
         FltaFWbCAnWy55TEqZ3Qz5HYOsz03IXwBDZKeZpeiGhWcIDdU8zm3ZWG9EetAOjAMrLI
         licJluLz5NbuF5pT8n8JYv8ZExz/mJgSkaWn1xiqxScHDRlzvX0ZABJZJaSJc7ABDoUr
         W6nLUsiIlQMMBvC44f+HrUD6GFURN2D+lsbyXXMVyOKV10gzlM6qxZDihfFMoaIHbQ+b
         29M/sf+6vLniZEAJRjHO19v8GPhEH/cBkcTkwJlImkmTZKpADouUQIhDoIAldvXtBEOJ
         QoKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XDmz+Qh3hJAd5XMx8qUnbX+Nfm580xKqYhKrFaH0P9s=;
        b=GgYGCTXuShzqes/6EdxTyuIZjYcOebbrO91ebyiFwHGYp1gKmySr1aIE0PaQwiO+XP
         tPpD6495kmx5VoqD4sIS4AgTw/hBJj2P+uwdG3lA0SP7PA7weQxPwlM41L5wwJhrss49
         ZpuQSIwyeqlUJBmlHCpLTUIbRf7gWOMnPrJ5L/JK5nW3+Ep6p61sH9XthzeKWbMXyWB2
         Q+7Mt9p0IzY9l1ahwNICW2yEsuInhYpv1qJK8K20gzYHebQ+99fK7zyHsRNO+60kPMWo
         rNAQDr1TCcGJfLKv8IRZuQEwV82olbr5ybmW6Whzuk0m3e+4BRIyoxoCXj3yu8YIHnWG
         HyNw==
X-Gm-Message-State: AOAM530Wn9TMQuaq4myUyh3guCvVv+/VX4w7zfLFMHKQDScs0e3koWn9
        xDcVcUlhvCrgquwc4KASM94UBPmimT9qYo0FLz8Y
X-Google-Smtp-Source: ABdhPJxK3cNlT+yWY3kto/rNQq7LH1KAff8wWcBofsoK1DrEqkDEeTt1ekpB23CloP96+ZO4VNxdEsrlubq2gXLVNsvk
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:a510:b0:143:7fd1:b18a with
 SMTP id s16-20020a170902a51000b001437fd1b18amr61016203plq.2.1637192584341;
 Wed, 17 Nov 2021 15:43:04 -0800 (PST)
Date:   Wed, 17 Nov 2021 15:43:00 -0800
In-Reply-To: <20211117005701.371808-3-emilyshaffer@google.com>
Message-Id: <20211117234300.2598132-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20211117005701.371808-3-emilyshaffer@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: Re: [PATCH v6 2/5] introduce submodule.superprojectGitDir record
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:
> Teach submodules a reference to their superproject's gitdir. This allows
> us to A) know that we're running from a submodule, and B) have a
> shortcut to the superproject's vitals, for example, configs.

If we're going with my proposal [1], I think it's worth further
explaining the concept right at the beginning of the commit message:

  Teach submodules a config variable referencing their superproject's
  gitdir. Git commands may rely on this reference to determine if the
  current repo is a submodule to another repo: if this reference is
  absent, Git may assume that the current repo is not a submodule. In
  practice, commands and arguments that specifially reference the
  submodule relationship (like "rev-parse
  --show-superproject-working-tree") will still search the ancestor
  directory, but others (say, a "git status" that prints the submodule's
  status in relation to its superproject or a config option that lets
  the superproject and submodule share config) would not.

[1] https://lore.kernel.org/git/20211117232846.2596110-1-jonathantanmy@google.com/

> By using a relative path instead of an absolute path, we can move the
> superproject directory around on the filesystem without breaking the
> submodule's pointer. And by using the path from gitdir to gitdir, we can
> move the submodule within the superproject's tree structure without
> breaking the submodule's pointer, too. Finally, by pointing at the
> superproject's worktree gitdir (if it exists), we ensure that we can
> tell which worktree contains our submodule.

OK.

> Since this hint value is only introduced during new submodule creation
> via `git submodule add`, though, there is more work to do to allow the
> record to be created at other times.

This is not a hint anymore. I would reword as:

  This commit teaches "git submodule add" to add the aforementioned
  config variable. Subsequent commits will teach other commands to do
  so.

> Once this new config is reliably in place, we can use it to know
> definitively that we are working in a submodule, and to know which
> superproject we are a submodule of. This allows us to do some
> value-added behavior, like letting "git status" print additional info
> about the submodule's status in relation to its superproject, or like
> letting the superproject and submodule share an additional config file
> separate from either one's local config.

I folded this into the first paragraph above, so this would no longer
needed if you used my suggestion above.

> +submodule.superprojectGitDir::
> +	The relative path from the submodule's gitdir to its superproject's
> +	gitdir. When Git is run in a repository, it usually makes no
> +	difference whether this repository is standalone or a submodule, but if
> +	this configuration variable is present, additional behavior may be
> +	possible, such as "git status" printing additional information about
> +	this submodule's status with respect to its superproject. This config
> +	should only be present in projects which are submodules, but is not
> +	guaranteed to be present in every submodule, so only optional
> +	value-added behavior should be linked to it. It is set automatically
> +	during submodule creation.

If we're going to rely on the variable more, this needs to be updated.
Maybe:

  If this repository is a submodule, the relative path from this repo's
  gitdir to its superproject's gitdir. Git commands may rely on this
  reference to determine if the current repo is a submodule to another
  repo: if this reference is absent, Git may assume that the current
  repo is not a submodule (this does not make a difference to most Git
  commands). It is set automatically during ??

(and probably each subsequent patch will need to update the ??)
