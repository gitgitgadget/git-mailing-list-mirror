Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDBAC32767
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 04:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD62721734
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 04:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbgAFEUy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Jan 2020 23:20:54 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35437 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbgAFEUy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Jan 2020 23:20:54 -0500
Received: by mail-wr1-f68.google.com with SMTP id g17so48209250wro.2
        for <git@vger.kernel.org>; Sun, 05 Jan 2020 20:20:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=75wjtenD+0DJNIkH6zmNfmhtImz4RC041AwkNFd5XJU=;
        b=G8aVs6GrJ2NEOaUfqnfsvIWsK8sLHYPuc6L1JuxD4iXAL93yZ2xAevPRj5owrBn3fN
         vzrx7uKK/weEX7+c4bg+r+Subq0UEVJkT2FQJCPe/jcJkVdRRU/08d4Eve1+uRDmvX6b
         jWMobvvkmhFVw2KHTn4iaPrJnYp9Ph5UtlkPtQlpk7JZOSlrqN45ZxefEfFJDNqlD4P2
         rnvDS4Si2Cg4gbAl0JjgbsoZ+1LB6wBExjREMwgYbGpV4g6urU3LwsdHzKnMpPmzzqgs
         ztSpNATU/jJYswZHegW+tw719PDUzagMNqaX2dY3I9mbYL+jPOG1UwMrSEEHHbSEsMdl
         V/TA==
X-Gm-Message-State: APjAAAUOktjiYGXWGeqKywQbIiJNd+VpKm+jmq5HWcvhk7yZ5x3zrPaN
        sLJpsLHS5SQpaBHovrzUwojvFxN1k8yfIKY54pFV8abe
X-Google-Smtp-Source: APXvYqy2Zx5ekQY4qw6XpjbY4NDCpfLCdwUzT4a//mY8XFJkC7AlMNUxldN1zWf3Di5uKJqhI9bwnpuMBqSbriKypw0=
X-Received: by 2002:adf:b193:: with SMTP id q19mr100720522wra.78.1578284452344;
 Sun, 05 Jan 2020 20:20:52 -0800 (PST)
MIME-Version: 1.0
References: <20191214161438.16157-1-me@yadavpratyush.com> <20191214161438.16157-2-me@yadavpratyush.com>
 <CAPig+cRL5w7azdALeBKKisTZwjgU6QhBqJRzQqDENjYiaTT0oA@mail.gmail.com>
In-Reply-To: <CAPig+cRL5w7azdALeBKKisTZwjgU6QhBqJRzQqDENjYiaTT0oA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 5 Jan 2020 23:20:41 -0500
Message-ID: <CAPig+cQmqKiYWDWFH5eK2S6XPOi2t2+8Oas8yZa8R=bKLym3wQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] worktree: delete branches auto-created by 'worktree add'
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 27, 2019 at 6:05 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Dec 14, 2019 at 11:16 AM Pratyush Yadav <me@yadavpratyush.com> wrote:
> > When no branch name is supplied to 'worktree add', it creates a new
> > branch based on the name of the directory the new worktree is located
> > in. But when the worktree is later removed, that created branch is left
> > over.
>
> This is describing the existing (intentional) behavior but doesn't
> explain why this might be annoying or problematic. To help sell the
> patch, it might make sense to say something about how the behavior can
> trip up newcomers to git-worktree, leaving them to wonder why they are
> accumulating so many branches that they weren't aware they created. A
> comment about why you think "git worktree add -d foo" is not a viable
> way to side-step the creation of unwanted branches might also be
> worthwhile.

As an alternative to this patch, would the simpler approach of
improving git-worktree documentation to do a better job of pointing
people at -d/--detach as a way to side-step unwanted branch creation
make sense? That is, at minimum, enhance the "Description" section to
prominently talk about throwaway worktrees (created with -d/--detach),
and add an example to the "Examples" section (perhaps as the first
example) showing creation/use/deletion of a throwaway worktree.

Some points in favor of just updating the documentation to address
this issue (rather than implementing the new behavior suggested by
this patch) include:

* far simpler; no code to implement or debug

* no (surprising) behavior changes

* "git worktree add -d foo" is about as easy to type and remember as
  "git worktree add foo"

Of lesser importance, it might make sense, as a followup, to add a
configuration which changes the default behavior to detach instead of
auto-creating a branch. I wonder if this could be piggybacked on the
existing "worktree.guessremote" configuration. Or rather,
retire/deprecate that configuration and add a new one which affects
DWIM'ing behavior such that it becomes multi-state. Some possible
values for the new configuration: "auto" (or "dwim" or whatever),
"guessremote", "detach". (I haven't thought this through thoroughly,
so there might be holes in my suggestion.)

There's at least one point not in favor of merely updating the
documentation to promote -d/--detach more heavily, and that is that
(presumably) the concept of detached HEAD is perceived as an advanced
topic, so it may not be suitable for the newcomer or casual user.
