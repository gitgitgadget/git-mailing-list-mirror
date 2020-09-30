Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302B7C2D0A8
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 07:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE1A8207C3
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 07:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbgI3HTk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 03:19:40 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:41652 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgI3HTk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 03:19:40 -0400
Received: by mail-ej1-f65.google.com with SMTP id lo4so1269831ejb.8
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 00:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zdyXtQ3+cVOClUCwrM8ItJvVV8FrRM+3AFqYfouCo1A=;
        b=Y+VtbJFS2HeBphPywM2XBg2ps6h05fL0Ljok6DRxwrd6PbGaDnMGL1IsOwfWPNElWB
         lOMD/kcq9nCjZHd7dVKBZ5KdE5CjU64whs+owPEO5ygLYCHTp10yj/zPkeDQ98h0EzQS
         BsKKRkd8ZVOp+FvlMLxR02Kfo7qkWa4lAZyr5vmx9kE1mZv3wHFyjay3akouUCDruSq2
         1G7AwnbAlHW/nCba1Uq+VXdiY+XdUE+h99CHdj5Yxm+BX3zVAa8Sy68ikiJ6atqVlRXa
         VTEZ+08SeTRhNqZzAB38dTNtgs2uYhkofb0Se2jDjzwCCh0O7EsPoWbk7CS6EmU6Mz0Q
         okGA==
X-Gm-Message-State: AOAM532leMTjMuW8wnxT4PlB20rJSqfhG4kO4aV6caQU32mEiA0bNCBi
        n+Ibam4g6KLhXH0CPP0cFRzRVidjELpsseNzEqc=
X-Google-Smtp-Source: ABdhPJz9U5a4KoHkihLwFZq4oscQhNUXMiJVZYI79JBRg+8pxUvpj1S8cDvNF4J/YdDBI46AVJZVfEYIJ41Hgwfxowo=
X-Received: by 2002:a17:907:43c3:: with SMTP id i3mr463126ejs.231.1601450378034;
 Wed, 30 Sep 2020 00:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200928154953.30396-1-rafaeloliveira.cs@gmail.com>
In-Reply-To: <20200928154953.30396-1-rafaeloliveira.cs@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 30 Sep 2020 03:19:27 -0400
Message-ID: <CAPig+cQXkP8vTNR+LJ4fZRT-an0vEgKxcFpfi+aQ-BdipTgq=A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] teach `worktree list` to mark locked worktrees
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 28, 2020 at 11:50 AM Rafael Silva
<rafaeloliveira.cs@gmail.com> wrote:
> This patch series introduces a new information on the git `worktree list`
> command output, to mark when a worktree is locked with a (locked) text mark.

Thanks for working on this. "locked" is one of several additional
annotations to the output of "git worktree list" which have long been
envisioned. For reference, here are some earlier messages related to
this topic:

[1]: https://lore.kernel.org/git/CAPig+cTTrv2C7JLu1dr4+N8xo+7YQ+deiwLDA835wBGD6fhS1g@mail.gmail.com/
[2]: https://lore.kernel.org/git/CAPig+cQF6V8HNdMX5AZbmz3_w2WhSfA4SFfNhQqxXBqPXTZL+w@mail.gmail.com/
[3]: https://lore.kernel.org/git/CAPig+cSGXqJuaZPhUhOVX5X=LMrjVfv8ye_6ncMUbyKox1i7QA@mail.gmail.com/
[4]: https://lore.kernel.org/git/CAPig+cTitWCs5vB=0iXuUyEY22c0gvjXvY1ZtTT90s74ydhE=A@mail.gmail.com/

I'll leave a few review comments to supplement those already by Junio.

> This is the output of the worktree list with locked marker:
>
>  $ git worktree list
>  /repo/to/main        abc123 [master]
>  /path/to/unlocked-worktree1 456def [brancha]
>  /path/to/locked-worktree   123abc (detached HEAD) (locked)

In [2], I gave an example of output similar to this but without
encapsulating "locked" within parentheses:

    % git worktree list
    giggle     89ea799ffc [master]
    ../bobble  f172cb543d [feature1] locked
    ../fumple  6453c84b7d (detached HEAD) prunable

I omitted the parentheses partly due to the extra noise they
introduce, but mostly because I foresaw that a single entry might
eventually have multiple annotations, for instance:

    % git worktree list
    giggle     89ea799ffc [master]
    ../bobble  f172cb543d [feature1] locked prunable

in which case, the eyes glide over "locked prunable" a bit more easily
than over "(locked) (prunable)" or "(locked, prunable)" or some such.
Generally speaking, "the less noise, the better".

> This patches are marked with RFC mainly due to:
>
>  - Perhaps the `(locked)` marker is not the best suitable way to output
>   this information and we might need to come with a better way.

Taking [2] into consideration, I think it's fine to annotate the line
with "locked" (sans the parentheses), and it's compatible with the the
verbose mode, also proposed by [2]:

    % git worktree list -v
    giggle     89ea799ffc [master]
    ../bobble  f172cb543d [feature1]
        locked: worktree on removable media
    ../fumple  6453c84b7d (detached HEAD)
        prunable: directory does not exist

in which case the short "locked" annotation gets moved to the next
line, indented, and expanded to include the reason, if available
(otherwise would probably not be moved to the next line).

I'm not suggesting that this patch series implement verbose mode, but
bring it to attention to make sure we don't paint ourselves into a
corner when deciding how the "locked" annotation should be presented.

>  - I am a new contributor to the code base, still learning a lot of git
>   internals data structure and commands. Likely this patch will require
>   updates.

Under normal circumstances, I would be hesitant to accept a
contribution which makes an addition to the human-consumable "git
worktree list" output without also making the corresponding addition
to the --porcelain format. Thus, for instance, I would expect the
porcelain format to be updated, as well, to produce output such as
this (taken from [4]):

    worktree /blah
    branch refs/heads/blah
    locked Sneaker-net removable storage\nNot always mounted

That's a bit complicated because the lock reason may need escaping if
it contains special characters (such as the newline in the example).
Thus, I'm a bit hesitant to expect such a change from a newcomer.

More problematic, though, with regard to the porcelain format is that
the documentation is so woefully under-specified, as explained in [4],
that some people may interpret it as meaning that no additional
information can be added. I'm not particularly sympathetic to that
view since the intention from the start was that the porcelain format
should be extensible[4], thus adding new attributes should be allowed.
But I'm hesitant to ask a newcomer to undertake the task of addressing
these shortcomings. As such, I think it may be okay merely to change
the human-consumable output as this series does, and leave porcelain
output for a later date if someone wants to tackle it.

A reason that it would be nice to address the shortcomings of
porcelain format is because there are several additional pieces of
information it could be providing. Summarizing from [1], in addition
to the worktree path, its head, checked out branch, whether its bare
or detached, for each worktree, porcelain could also show:

    * whether it is locked
      - the lock reason (if available)
      - and whether the worktree is currently accessible (mounted)
    * whether it can be pruned
      - and the prune reason if so
    * worktree ID (the <id> of .git/worktrees/<id>/)
