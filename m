Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8982CC433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 23:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BDF46134F
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 23:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhDWXMO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 19:12:14 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:35459 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhDWXMH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 19:12:07 -0400
Received: by mail-ed1-f44.google.com with SMTP id h8so18993297edb.2
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 16:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HYlAfHBMI9rwIzvzaGs4hXW6pSvR5WItReJUtKMPqnQ=;
        b=TQBXyg+1oZRjOWIEq+igQccodcrhO7/nT3EVAgOO+uBAzJO+CzE/JLtNp+lTOZzNjs
         S3CkXzDvMbxaBiZB6WO5gbLKHspSEHQMXWLih6BVVJB1oKel1gBSt+Yqvu3rfqp8/AWI
         AadB96j/YpdisZZl52vilU6tyP4ZTwxcLxGdWrOZyMLN8qDHWQaIIeXnzVz5E9VO3dmU
         wX75lbIE/Ee5socp3v61RCJFuDgd+FX/KTL7n+YyuiEcZZieeb5idoM3HSvt12eilfIV
         60FlbvTgC/ZBE0aAl3WOq/9MjVx4biKuPXQ+cQifVwygH4FIQ+ldkYJucdxlBvZQDiKL
         0qoA==
X-Gm-Message-State: AOAM532MqQb13oJ0mZzC3/wR/eub91NkRzV5u8n1bzYm5Rm/ScBOreZ2
        0qKXJzoV/4Ob97feODq8U9DDZxgLECUD9McrBCymB4xdy0IyhH/v
X-Google-Smtp-Source: ABdhPJwZ+xvsWKY2u2FSftlcMQGfEg7yOk/p9ydv3KIY/M8/ZD/i0GlQp7C7HxzT0hOP1FLM7T9W6r2A8nQKL7CPw/8=
X-Received: by 2002:a05:6402:35c9:: with SMTP id z9mr7235835edc.94.1619219482305;
 Fri, 23 Apr 2021 16:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210423194230.1388945-1-lukeshu@lukeshu.com> <20210423194230.1388945-13-lukeshu@lukeshu.com>
 <CAPig+cQLP1XFnMFWOp4Zj-Ku8M-aqgE5DmpgEy=UWLqpBBW8Ng@mail.gmail.com> <87tunw1v1l.wl-lukeshu@lukeshu.com>
In-Reply-To: <87tunw1v1l.wl-lukeshu@lukeshu.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 23 Apr 2021 19:11:11 -0400
Message-ID: <CAPig+cTnqYnxPpcn1GTDOpzb2mHAseA694cc-d3mP0JD7VNU5A@mail.gmail.com>
Subject: Re: [PATCH 12/30] subtree: don't have loose code outside of a function
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     Git List <git@vger.kernel.org>,
        Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Luke Shumaker <lukeshu@datawire.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 23, 2021 at 6:43 PM Luke Shumaker <lukeshu@lukeshu.com> wrote:
> On Fri, 23 Apr 2021 14:23:18 -0600, Eric Sunshine wrote:
> > What is the purpose of this change? Does some subsequent commit depend
> > upon this or is it just a personal preference? The commit message
> > explains the "what" of the change but not the "why".
>
> Dropping the commit would surely cause me much trouble with rebasing
> both the subsequent commits in this patchset and the commits I haven't
> yet submitted.  But I don't think they "depend" on it.
>
> I guess it is personal preference... [...]

That's fine. I wasn't suggesting removing the commit but was
interested in having the commit message explain the reason for the
change, which is often the most important part of the commit message
to convince readers (reviewers) that the patch isn't just needless
noise. Obviously, if changes in subsequent patches become easier by
making this change, then that's easier to explain than something which
is mere personal preference -- which isn't to say that such preference
isn't important, especially if you're going to be living in the code
for a while.

> In this specific case, it's also moving the `set -- -h`, the `git
> rev-parse --parseopt`, and the `. git-sh-setup` to be closer to all
> the rest of the argument parsing, which is a readability win on its
> own, IMO.

If you happen to re-roll, perhaps update the commit message to include
a small bit of your explanation (which I've mostly snipped here). The
last bit about moving `set -- -h` and whatnot closer to the rest of
the argument parsing -- basically improving encapsulation -- may be
justification enough for readers.
