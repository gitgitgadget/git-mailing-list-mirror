Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7243EC433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 22:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243901AbhLMW6s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 17:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbhLMW6p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 17:58:45 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C043AC061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 14:58:45 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id j23-20020a63e757000000b0033ab682dc51so3861345pgk.19
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 14:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6y29rsrk04Wi3bfwKDAzPCzE8EsHdIdHB55+lQ4yPa0=;
        b=qzf8BYt0kcv+HmrLByU6+kOz6e6u0QTTYUmLilpzDZ08ab9fggqXzi5YszrL+1fLDh
         MLFZsSz0lAqCzrDbJafLtMy26V1KfuzrNJsFw6L7Bzj4offIvo1AaMboOEzseAAl+skn
         pVQXujvrz4xkqizSVwYw84rjOsgp5imdKS3PG6rbdY5b9OmWhKl+4sLdf9jJ34r+LJeU
         XxGgnHpOnGuKiaaRjWlcyzgxyqbzY9puo387PUCV6PuDk+K1VSTcPR7g5cxcStspBNqi
         sK1Y9jsNcDRrzz4sC3EOnSTC5Eu7XR+JKYgJn+bpoSy2+Hd/HMPSOUj9byZV4hWSTTeA
         Qalg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6y29rsrk04Wi3bfwKDAzPCzE8EsHdIdHB55+lQ4yPa0=;
        b=NhhoDd8VOhJdQCx7pNDmv+y4YsG0uAGKf5zoXNZMMn7Cf6eQjTQ9h7pzE9I+a4U4Q9
         pVqoQkrX/LO6vWOvpxcg+342msDNyhP7fQspSMXwtZc3nUCjx5ykOGOaV1DPlHEgn1RT
         DYgGTXFitTwv7eSlPXGClcaAEN3k6v7HEDpaP0EErZ2Hct5daXV0uaUaQrfUYZ3i3/Ju
         8YbLMwXoUI9Mszj9jy3t7w9lojRrORjJc/Dubop5v3vmgc3zIFL5kAovlYHNkQOo2wu5
         AR/d7C912+Xm13iVOO/S2lmGDFqNpm4z8gJ9fE8HoewEvaHiYt/vV9G9OmxTwru/MUNk
         xvBA==
X-Gm-Message-State: AOAM530ajHyeplzrqvIjgQrA8OgtF/k/tCFpmXZdloxQUQNmjV9Wlcer
        Gc2Xus/W8026IVFsyiHVrBonr8J3VNf0R360Mt0i
X-Google-Smtp-Source: ABdhPJwqtQtjVKe28Eve6psU723ooRzZcbEjKm6EmkKAl6k+xtJhiJh5BtcIoqL2q6UOLrbARR+1sD/3vYARo4gkeVIZ
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:1a8b:: with SMTP id
 ng11mr1285880pjb.3.1639436325245; Mon, 13 Dec 2021 14:58:45 -0800 (PST)
Date:   Mon, 13 Dec 2021 14:58:42 -0800
In-Reply-To: <kl6lbl1p9zjf.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <20211213225842.768852-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <kl6lbl1p9zjf.fsf@chooglen-macbookpro.roam.corp.google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: Re: [PATCH] builtin/fetch: skip unnecessary tasks when using --negotiate-only
From:   Jonathan Tan <jonathantanmy@google.com>
To:     chooglen@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > Glen Choo <chooglen@google.com> writes:
> >> `git fetch --negotiate-only` does not fetch objects and thus, it should
> >> not perform certain auxiliary tasks like updating submodules, updating
> >> the commit graph, or running gc. Although send_pack() invokes `git fetch
> >> --negotiate-only` correctly, cmd_fetch() also reads config variables,
> >> leading to undesirable behavior, like updating submodules if
> >> `submodule.recurse=true`.
> >> 
> >> Make cmd_fetch() return early if --negotiate-only was specified so that
> >> these auxiliary tasks are skipped.
> >> 
> >> Signed-off-by: Glen Choo <chooglen@google.com>
> >> ---
> >> `git fetch --negotiate-only` is used during push negotiation to
> >> determine the reachability of commits. As its name implies, only
> >> negotiation is performed, not the actual fetching of objects. However,
> >> cmd_fetch() performs certain tasks with the assumption that objects are
> >> fetched:
> >> 
> >> * Submodules are updated if enabled by recurse.submodules=true, but
> >>   negotiation fetch doesn't actually update the repo, so this doesn't
> >>   make sense (introduced in [1]).
> >> * Commit graphs will be written if enabled by
> >>   fetch.writeCommitGraph=true. But according to
> >>   Documentation/config/fetch.txt [2], this should only be done if a
> >>   pack-file is downloaded
> >> * gc is run, but according to [3], we only do this because we expect
> >>   `git fetch` to introduce objects
> >> 
> >> Instead of disabling these tasks piecemeal, let's just make cmd_fetch()
> >> return early if --negotiate-only was given. To accommodate possible
> >> future options that don't fetch objects, I opted to introduce another
> >> `if` statement instead of putting the early return in the existing
> >> `if (negotiate_only)` block.
> >
> > Some of this probably should be in the commit message too.
> 
> I suppose you mean the explanation of why the tasks are irrelevant to
> negotiation fetch? i.e. 
> 
>    * Submodules are updated if enabled by recurse.submodules=true...
>    * Commit graphs will be written if enabled by...
>    * gc is run, but according to [3]...

Yes - why the behavior is undesirable, and the way you're doing it (by
adding another "if" statement).

After looking at this, more concretely, it might be better to use the
part below the "---" as your commit message. :-) Just note that we're
not just accommodating future options that don't fetch objects - "fetch"
already may not fetch objects (e.g. if the ref we want doesn't exist or
if we already have all the objects).

> > Maybe add a check here that --recurse-submodules was not explicitly
> > given.
> 
> Hm, that's not a bad idea, but it's not so easy because we don't have
> RECURSE_SUBMODULES_EXPLICIT so it's not easy to tell whether or not
> submodule recursion was enabled by CLI option or config.
> 
> This is the exact same use case I encountered with "branch
> --recurse-submodules" [1]. I think this means that we should consider
> standardizing the parsing of submodule.recurse + --recurse-submodules. I
> haven't done it yet because it's a little tricky and hard to review.
> 
> So I'll punt on this check until we get RECURSE_SUBMODULES_EXPLICIT.

Hmm...can we separate out the recurse_submodules variable into one
that's given by config and one that's given by CLI argument?
