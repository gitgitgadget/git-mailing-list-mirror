Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70BD31F954
	for <e@80x24.org>; Thu, 23 Aug 2018 18:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeHWVuO (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 17:50:14 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44870 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbeHWVuO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 17:50:14 -0400
Received: by mail-qt0-f193.google.com with SMTP id r13-v6so7323054qtr.11
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 11:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nLJN5YqnafTGc68+ah6WvVJhnOd0GC1V8HIWBXTTIZw=;
        b=o+yVbUw95NkO/Eo7pQPOSypS9GJGErL22aqTMIvMKli/sIXeRQA/KuKnn1E/hQ3L34
         blJ+n+NBgztZy4+5UezAbdLYcOHAWqjLruaftF2DqpjzwEEAK69JBKCv0HhDWdnadq6I
         dgJ6WUnhb98QP7rALJBBnuEfVgEc8138psdutm+Rgr39+KEKtpfBIizCBJMSo67+5lxW
         xyfSbFJk5UiF5cCI5V5T8bMWARdBspiXkkKnAufFwOozQA70zFotT+JfzQX+3PpjiBuh
         pQD7qEg5r6P/QP+LUbk1P3L2BsjBFlbL2M+ZxmyCg1h/jk9OaViwEou5cCRfVxFtuKng
         7Sww==
X-Gm-Message-State: AOUpUlGlceyyG+/8H8mfQpvrJZah6YgEjvxo6jFUhON/jBP1vomPtWp/
        TinvRO1ruoSA1q7vqTmvHRQBtHM3eJmoKtEQ7KNXSq/4
X-Google-Smtp-Source: AA+uWPw1Z/moO6EHKksawgqxutrG66wicPqxtK11pOOEVWYllAuqVCHaBudSkTDTJxtNqCYifK1RRY7TWwe/bDK96Z8=
X-Received: by 2002:ac8:e84:: with SMTP id v4-v6mr22519611qti.220.1535048359698;
 Thu, 23 Aug 2018 11:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180821192321.GA720@sigill.intra.peff.net> <20180821193556.GA859@sigill.intra.peff.net>
 <CAPig+cT+LBSJHoR1kUi+S2h96y_qmVEpK0xAy6sRUGQj6GQEyg@mail.gmail.com> <20180821204341.GA24431@sigill.intra.peff.net>
In-Reply-To: <20180821204341.GA24431@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 23 Aug 2018 14:19:08 -0400
Message-ID: <CAPig+cTghgbBo5VfZN+VP2VM00nPkhUqm0dOUqO37arxraxBKw@mail.gmail.com>
Subject: Re: worktree duplicates, was: [PATCH] SubmittingPatches: mention doc-diff
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 21, 2018 at 4:43 PM Jeff King <peff@peff.net> wrote:
> On Tue, Aug 21, 2018 at 04:22:08PM -0400, Eric Sunshine wrote:
> > On Tue, Aug 21, 2018 at 3:36 PM Jeff King <peff@peff.net> wrote:
> > How about using "git clone --shared" instead?
>
> That seems even more dangerous to me, since the created clone can become
> corrupt when the parent prunes. Probably not huge for a single
> operation, but you may be surprised when you run the script a few days
> later and it barfs horribly due to a missing object.

Okay. I had thought that doc-diff was never doing anything other than
read-only operations on the checked-out worktree after the initial
creation, but, looking more closely at the script, I now see that it
can perform other Git-based operations, so what you say makes sense.

> > In the case that you've already blown away the directory, then having
> > "git worktree add" prune away the old worktree bookkeeping would make
> > sense and wouldn't lose anything (you've already thrown it away
> > manually). However, it could be lossy for the case when the directory
> > is only temporarily missing (because it's on removable media or a
> > network share).
>
> I think the removable ones already suffer from that problem (an auto-gc
> can prune them). And they should already be marked with "git worktree
> lock". That said, people don't always do what they should, and I'd
> rather not make the problem worse. :)

Hmph. I thought that "git worktree prune" had a sensible "expire"
default to protect against such cases of removable media for which
"git worktree lock" wasn't invoked, but, looking at the code, I see
that the default is TIME_MAX.

> > In this case, it might make sense for "git worktree add" to refuse to
> > operate if an existing worktree entry still points at the directory
> > that you're trying to add. That should prevent those duplicate
> > worktree entries you saw.
>
> Yes, but then what's the next step for my script? I can't "remove" since
> the worktree isn't there. I can't blow away any directory that I know
> about, since there isn't one.

I was thinking that "worktree add" could start respecting the --force
option as an escape hatch.

> I need to somehow know that an existing
> "$GIT_DIR/worktrees/foo" is the problem. But "foo" is not even
> deterministic. Looking at the duplicates, it seems to be the basename of
> the working tree, but then mutated to avoid collisions with other
> worktrees.

If the worktree directory still existed, "git -C rev-parse --git-dir"
inside the worktree would give you the proper path of
$GIT_DIR/worktrees/foo, but the directory doesn't exist, so...
nothing.

> What about refusing by default, but forcing an overwrite with "-f"?

My thought, also.
