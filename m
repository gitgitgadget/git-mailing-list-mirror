Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C8AC433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 18:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5970D61056
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 18:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236975AbhJMSft (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 14:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbhJMSfr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 14:35:47 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9A1C061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 11:33:43 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id 4-20020a620504000000b0044be2cfac9bso2092417pff.0
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 11:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DwHTykuttlYYCTYC9vyRXZoV4ZKvn/+9+7J9a0U3IvQ=;
        b=p54YjJU56ASsDru2M1lcSr8YsRA+cS0rGIGcM036SvYPRwOo0sC6TxmuffH/vNawKs
         JYUntj1bT+K/oNJoJ3eMX6uKwybXgniX+dlFREdABdBprdkwyfvYkn78Jn+7pKPr0J5P
         hh44m+Sm2Nb+yeDb4RiHp83o7W4pW2nfbhmPCaC5A2PjJIuOgRmiqj/QgE4payLoDyFh
         MtYq2z6KtXLz36kR5QLxEm/YaVJ6Wy7K4Ya9uExyhswIRv/LS1tmSnEnmSYm7w8xefuh
         od6DVVCk3mNQfRmrLI1+pBSLmlBnvdq3oq8TJffe8rfbw7h+zcIMYcuQLDSZysThhaQp
         Ee/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DwHTykuttlYYCTYC9vyRXZoV4ZKvn/+9+7J9a0U3IvQ=;
        b=zl1lMqYYsRpi8EEDr4d8qtGAQ8uJ24Lx6fvzGG6RMrTt8c4tXrLXnooqvu27CL/AX9
         WpJnbCKdWlZRW671HH0bUyeAkev/0Ffmjxik80eiHh2nQMyRFOw9BZjhzAJmgjZO//4g
         9tv/7uCvzDUPbzowVpnQ/WjboLFridB28MgLp6VEAlC+RBQ7XUwxscByQ1NYVioCVZIO
         Ji+6jZ2/xiXMCuE59uDdXDwJZ1g7i0Auv4M5h3NSq30gNUyM7Pwb8OUJx64ACzA7xTF4
         cougDjOoAJ0LRVzT5mExWdaRt8eQj9GxsViO3GQuF6zhKyrVYdFDQlWyHQ9LBrqxWJDM
         oZJA==
X-Gm-Message-State: AOAM533X86Q6Cyr9Duakln1WnXpEiAW72mscGJSJmHYOgeWSgLSzRtzm
        27ujv5FZdPs3jFZa6yjnzOwCe1dxo8bwU3nQTUp5
X-Google-Smtp-Source: ABdhPJwe2r2C7pSTdm4uMmVWjI2NTjMZpOiKka1l6V6cWSxfObq7SfTs7LkvqS5zadrmzo2GJLUz870llzo0XWy44NMv
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:4011:: with SMTP id
 ie17mr15239193pjb.41.1634150023466; Wed, 13 Oct 2021 11:33:43 -0700 (PDT)
Date:   Wed, 13 Oct 2021 11:33:41 -0700
In-Reply-To: <YWYafdpemaiAjvUV@coredump.intra.peff.net>
Message-Id: <20211013183341.85761-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YWYafdpemaiAjvUV@coredump.intra.peff.net>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: Re: [RFC PATCH 2/2] config: include file if remote URL matches a glob
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> OK. I was a little wary after reading the subject that this would be
> "when we are using such a URL", which is full of all kinds of odd corner
> cases. But if it is "a remote is defined with a matching URL" that makes
> it a property of the repository, not the operation.
> 
> I think in general this kind of feature is currently served by just
> correlating filesystem paths with their function. So with your patch I
> could do:
> 
>   [includeIf "hasremoteurl:https://myjob.example.com"]
>   path = foo.conf
> 
> But in general, I'd imagine most people put their repository in ~/work
> or similar, and just do:
> 
>   [includeIf "gitdir:~/work"]
>   path = foo.conf
> 
> (and of course you can imagine more subdivisions as necessary). So I
> find the use-case only sort-of compelling. In general, I'm in favor of
> adding new includeIf directions even if they're only moderately
> convenient. But this one is rather sticky, because it is dependent on
> other config keys being defined. So it introduces a new and complicated
> ordering issue. Is it worth it? Maybe I'm not being imaginative enough
> in seeing the use cases.

My main use case is for a remote repo administrator to offer a
recommended config to anyone who clones that repo. For this, I don't
think we can prescribe a local directory structure (e.g. "~/work")
without being too restrictive or broad (that is, if the user ends up
creating a repo that so happens to match our glob but did not intend the
config to apply to it).

I did bring up the idea that an individual could use this to have config
in one place that affects a subset of remotes, but you're right that
they could just do this by putting repositories at different places in
the filesystem.

> > I marked this as RFC because there are some design points that need to
> > be resolved:
> > 
> >  - The existing "include" and "includeIf" instructions are executed
> >    immediately, whereas in order to be useful, the execution of
> >    "includeIf hasremoteurl" needs to be delayed until all config files
> >    are read. Are there better ways to do this?
> 
> Note that this violates the "as if they had been found at the location
> of the include directive" rule which we advertise to users. I'd imagine
> that most of the time it doesn't matter, but this is a pretty big
> exception we'll need to document.

Yes, that's true. Another thing I just thought of is to add a new
"deferIncludeIf" which makes clear the different semantics (deferred
include, and perhaps not allow recursive includes).

> Just brainstorming some alternatives:
> 
>   - We could stop the world while we are parsing and do a _new_ parse
>     that just looks at the remote config (in fact, this is the natural
>     thing if you were consulting the regular remote.c code for the list
>     of remotes, because it does its own config parse).
> 
>     That does mean that the remote-conditional includes cannot
>     themselves define new remotes. But I think that is already the case
>     with your patch (and violating that gets you into weird circular
>     problems).

Hmm...yes, having a special-case rule that such an included file cannot
define new remotes would be complex.

>   - We could simply document that if you want to depend on conditional
>     includes based on a particular remote.*.url existing, then that
>     remote config must appear earlier in the sequence.
> 
>     This is a bit ugly, because I'm sure it will bite somebody
>     eventually. But at the same time, it resolves all of the weird
>     timing issues, and does so in a way that will be easy to match if we
>     have any other config dependencies.

My main issue with this is that different config files are read at
different times, and the repo config (that usually contains the remote)
is read last.

> >  - Is the conditionally-included file allowed to have its own
> >    "include{,If}" instructions? I'm thinking that we should forbid it
> >    because, for example, if we had 4 files as follows: A includes B and
> >    C includes D, and we include A and C in our main config (in that
> >    order), it wouldn't be clear whether B (because A was first included)
> >    or C (because we should execute everything at the same depth first)
> >    should be executed first. (In this patch, I didn't do anything about
> >    includes.)
> 
> I'd say that A would expand B at the moment it is parsed, by the usual
> as-if rule. If it has a recursive includeIf on remotes, then my head may
> explode. I'd argue that we should refuse to do recursive remote-ifs in
> that case (though all of this is a consequence of the after-the-fact
> parsing; I'd much prefer one of the alternatives I gave earlier).

If we can't expand in place, I would say that any recursive includes
should be refused. But as you said, we could still think about whether
in-place expansion can be done before addressing this question.

> >  - A small one: the exact format of the glob. I probably will treat the
> >    URL like a path.
> 
> You might want to use the matcher from urlmatch.[ch], which understands
> things like wildcards. Of course remote "URLs" are not always real
> syntactically valid URLs, which may make that awkward.
> 
> Barring that the usual fnmatch glob is probably our best bet.

OK.

> So we make a copy of every remote name on the off chance that somebody
> has an includeIf which looks at it. That feels wasteful, though in
> practice it's probably not that big a deal.
> 
> By doing the config parsing ourselves here we're missing out on any
> other forms of remote, like .git/remotes. Those are old and not widely
> used, and I'd be OK with skipping them. But we should clearly document
> that this is matching remote.*.url, not any of the other mechanisms.

Sounds good.

> I only lightly read the rest of the patch. I didn't see anything
> obviously wrong, but I think the goal at this point is figuring out the
> design.

Yes, that's right.
