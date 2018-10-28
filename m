Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A8C71F453
	for <e@80x24.org>; Sun, 28 Oct 2018 23:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbeJ2HtI (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 03:49:08 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46012 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbeJ2HtI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 03:49:08 -0400
Received: by mail-qt1-f193.google.com with SMTP id l9-v6so7218621qtj.12
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 16:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D2pC+A+ZBGb+9F/C2lFept/yFd/chusahwbeOGqRrcI=;
        b=KxGqCCPxoy1WB3akn4c50yhcI7Mw6+OoWDWGkIQicpI7KBIIMUCQOiEBujaRW4IM4t
         RzF1pyn0GAjyt1exoWsMW546P/fKKZQr6p9pKElZ52Jd0q+bfGbIGA/voC8nreOh4Scq
         q1UwGjf3QKlQr88MfF5jqTgDcV7YMML3/sachIullWcn890Kicsak44/ZyqOVovajJVn
         PVh7uTx8EVNF6zGSy35XYhyE0X72O6Dub3gv/fie7sbmuigKJZbyoVnb75Dy3Qq6Xjo1
         hXfMrPqc1Qh6qZ7UlkpcfcuBoQ95XWk7iWrcaOR6HdPBw0Ed3sHiO3pEYP/wRX1G0vFJ
         T7BQ==
X-Gm-Message-State: AGRZ1gIYmUMRcL5NhZS6xOYzvEOEti8H3utiibajHmLCK3tOPO6qilrl
        KfvW3D12Uy1Gqp6XS+/dG7zBbdiFuYozU2TBJB3jMkmS
X-Google-Smtp-Source: AJdET5fdoJlvMkbCeZXMSMwXA3toJth3fxmKH4b29z4i1RjouzqErWBJtRj/4a6f79UtAK93iQ16IRov4z58TiVukeE=
X-Received: by 2002:ac8:901:: with SMTP id t1-v6mr10733934qth.335.1540767783042;
 Sun, 28 Oct 2018 16:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAC05386F1X7TsPr6kgkuLWEwsmdiQ4VKTF5RxaHvzpkwbmXPBw@mail.gmail.com>
 <20181025055142.38077-1-nbelakovski@gmail.com> <xmqq4ldajz05.fsf@gitster-ct.c.googlers.com>
 <CAC05386cSUhBm4TLD5NUeb5Ut9GT5=h-1MvqDnFpuc+UdZFmwg@mail.gmail.com>
In-Reply-To: <CAC05386cSUhBm4TLD5NUeb5Ut9GT5=h-1MvqDnFpuc+UdZFmwg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 28 Oct 2018 19:02:50 -0400
Message-ID: <CAPig+cT1XYt60PsRGJ0FUa_qCn1vPjdXHygsWzYZYg2Ey=yqkg@mail.gmail.com>
Subject: Re: [PATCH] worktree: refactor lock_reason_valid and lock_reason to
 be more sensible
To:     Nickolai Belakovski <nbelakovski@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 28, 2018 at 5:55 PM Nickolai Belakovski
> <nbelakovski@gmail.com> wrote: This was meant to be a reply to
> https://public-inbox.org/git/CAC05386F1X7TsPr6kgkuLWEwsmdiQ4VKTF5RxaHvzpkwbmXPBw@mail.gmail.com/T/#m8898c8f7c68e1ea234aca21cb2d7776b375c6f51,
> please look there for some more context. I think it both did and
> didn't get listed as a reply? In my mailbox I see two separate
> threads but in public-inbox.org/git it looks like it correctly got
> labelled as 1 thread. This whole mailing list thing is new to me,
> thanks for bearing with me as I figure it out :).

Gmail threads messages entirely by subject; it doesn't pay attention
to In-Reply-To: or other headers for threading, which is why you see
two separate threads. public-inbox.org, on the other hand, does pay
attention to the headers, thus understands that all the messages
belong to the same thread. Gmail's behavior may be considered
anomalous.

> Next time I'll make sure to change the subject line on updated
> patches as PATCH v2 (that's the convention, right?).

That's correct.

> This is an improvement because it fixes an issue in which the fields
> lock_reason and lock_reason_valid of the worktree struct were not
> being populated. This is related to work I'm doing to add a worktree
> atom to ref-filter.c.

Those fields are considered private/internal. They are not intended to
be accessed by calling code. (Unfortunately, only 'lock_reason' is
thus marked; 'lock_reason_valid' should be marked "internal".) Clients
are expected to retrieve the lock reason only through the provided
API, is_worktree_locked().

> I see your concerns about extra hits to the filesystem when calling
> get_worktrees and about users interested in lock_reason having to
> make extra calls. As regards hits to the filesystem, I could remove
> is_locked from the worktree struct entirely. To address the second
> concern, I could refactor worktree_locked_reason to return null if
> the wt is not locked. I would still want to keep is_worktree_locked
> around to provide a facility to check whether or not the worktree is
> locked without having to go get the reason.
>
> There's also been some concerns raised about caching. As I pointed
> out in the other thread, the current use cases for this information
> die upon accessing it, so caching is a moot point. For the use case
> of a worktree atom, caching would be relevant, but it could be done
> within ref-filter.c. Another option is to add the lock_reason back
> to the worktree struct and have two functions for populating it:
> get_worktrees_wo_lock_reason and get_worktrees_with_lock_reason. A
> bit more verbose, but it makes it clear to the caller what they're
> getting and what they're not getting. I might suggest starting with
> doing the caching within ref-filter.c first, and if more use cases
> appear for caching lock_reason we can consider the second option. It
> could also be get_worktrees and get_worktrees_wo_lock_reason, though
> I think most callers would be calling the latter name.
>
> So, my proposal for driving this patch to completion would be to:
> -remove is_locked from the worktree struct
> -refactor worktree_locked_reason to return null if the wt is not locked
> -refactor calls to is_locked within builtin/worktree.c to call
> either the refactored worktree_locked_reason or is_worktree_locked

My impression, thus far, is that this all seems to be complicating
rather than simplifying. These changes also seem entirely unnecessary.
In [1], I made the observation that it seemed that your new ref-filter
atom could be implemented with the existing is_worktree_locked() API.
As far as I can tell, it can indeed be implemented without having to
make any changes to the worktree API or implementation at all.

The worktree API is both compact and orthogonal, and I haven't yet
seen a compelling reason to change it. That said, though, the API
documentation in worktree.h may be lacking, even if the implementation
is not. I'll say a bit more about that below.

> In addition to making the worktree code clearer, this patch fixes a
> bug in which the current is_worktree_locked over-eagerly sets
> lock_reason_valid. There are currently no consumers of
> lock_reason_valid within master, but obviously we should fix this
> before they appear :)

As noted above, 'lock_reason_valid' is private/internal. It's an
accident that it is not annotated such (like 'lock_reason', which is
correctly annotated as "internal"). So, there should never be any
external consumers of that field. It also means that there is no bug
in the current code (as far as I can see) since that field is
correctly consulted (internally) to determine whether the lock reason
has been looked up yet.

The missing "internal only" annotation is unfortunate since it may
have led you down this road of considering the implementation and API
broken.

Moreover, the documentation for is_worktree_locked() apparently
doesn't convey strongly enough that it serves the dual purpose of (1)
telling you whether or not the worktree is locked, and (2) telling you
the reason it is locked.

A patch which adds the missing "internal only" annotation to
'lock_reason_valid', and which makes it easier to understand the dual
purpose of is_worktree_locked() would be welcome, especially if it
helps avoid such confusion in the future.

Aside from that, it doesn't seem like worktree needs any changes for
the ref-filter atom you have in mind. (Don't interpret this
observation as me being averse to changes to the API; I'm open to
improvements, but haven't seen anything yet indicating a bug or
showing that the API is more difficult than it ought to be.)

[1]: https://public-inbox.org/git/CAPig+cTvKd2DVu7wW_A31p_o7BaNJszu14kNRz9sqk8h45H4-g@mail.gmail.com/
