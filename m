Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE3EC2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 16:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFB220702
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 16:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgA0Q2d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 11:28:33 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37531 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgA0Q2c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 11:28:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so12135172wru.4
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 08:28:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2xqoHagUmMLpY9ZA400cDhducHIGP6th8W9C1I3/+yo=;
        b=t2Hd2wj8zZm4IGYBwff7/YSTJLQ059p6NE+6mNNnailbH7RhrLSk3oHGf11IaZDe1Q
         nINEViZIMpHXHO4SBz7JpKZ2S+bZrRnmc6zYMgQVKNn8dsptd3LCCmW7We+/GO6PfoYd
         HWB/wIF17Q/90nuX8LCjUhcKsGtXzYG6FNSCo8ahUmRTo92WaCK8Fd8PvxcAEd0lkyiq
         eaLTn/bEpq7vOCw3bX+pi3uRoOzDIyPRvqKcLgHWPsT9WnctqhwnUPm40kNzXIZUSimI
         pEh0Rbyr/H8eZq7io8fqIcqjH0SyoYlB+Xz8Vw8Au4IBRU1sZF7sLeKIQzKdjW2PeKSC
         IADQ==
X-Gm-Message-State: APjAAAUQU9pCh7yVPkcbpXyggmh5gqk7j499GgkV1eAeJZgGX8THHwjl
        XBnQrAO+UAVArG+q+kMYdyq1+VijDnVL9xtD0JFUlU72
X-Google-Smtp-Source: APXvYqxteRZqQ+LCBreKWGaNmQlkOcSMjtIbOD+ZE9croDH1bdS0s75+BxGJYEDtggezrBDhYfsRkY4hQocT7lqtucU=
X-Received: by 2002:adf:fd87:: with SMTP id d7mr24086337wrr.226.1580142510857;
 Mon, 27 Jan 2020 08:28:30 -0800 (PST)
MIME-Version: 1.0
References: <20200125173744.4334-1-me@yadavpratyush.com>
In-Reply-To: <20200125173744.4334-1-me@yadavpratyush.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 27 Jan 2020 11:28:19 -0500
Message-ID: <CAPig+cRrVQNtXGCjWcj5eDbPCQyO-NfjqKAVh8tD3sLc=KdjjQ@mail.gmail.com>
Subject: Re: [PATCH] worktree: add shorthand '-d' for detach
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 25, 2020 at 12:37 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> [...]
> An alternative to this is to create a detached worktree which doesn't
> lead to a branch being created. This can be done by the '--detach'
> option. Add the shorthand to make it more convenient to use it.
>
> Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
> ---
> For more context:
> https://lore.kernel.org/git/CAPig+cQmqKiYWDWFH5eK2S6XPOi2t2+8Oas8yZa8R=bKLym3wQ@mail.gmail.com/
>
> I'll send a patch to add the config option as a follow up some time
> later.

Although the suggestion of a config option came from me (in [1] and
extended in [2]), I had second thoughts about it very shortly after
sending [2], and can't say that I am particularly in favor of it.
There are at least a couple reasons why I have taken this view.

First, the idea suggested in [2] can be seen as a specialized
mechanism which is perhaps already handled better by the more
generalized mechanism provided by Git aliases. That is, someone can
achieve the same goal of conveniently providing a particular set of
command-line options by simply defining a Git alias; for instance,
"git wttemp" might expand to "git worktree add --detach". We don't
need to be re-inventing the wheel (poorly).

Second, the only real case which has arisen thus far is that of
throwaway (detached) worktrees, and the added '-d' alias for
'--detach' makes that about as simple as possible to achieve without
requiring any extra machinery. If, at some point down the road, other
real-world cases arise in which it would be convenient to tweak
worktree creation in some mechanized fashion, perhaps then it would
make sense to implement all the extra code to support such a config
option, but right now it seems overkill.

[1]: https://lore.kernel.org/git/CAPig+cQmqKiYWDWFH5eK2S6XPOi2t2+8Oas8yZa8R=bKLym3wQ@mail.gmail.com/
[2]: https://lore.kernel.org/git/CAPig+cTva89t8Zco-Ke0oD5xDZF_uuGH-gSkLXE2r31NtSE8nw@mail.gmail.com/
