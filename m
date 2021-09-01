Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876ADC432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 15:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D0AE60BD3
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 15:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245442AbhIAPBT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 11:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243971AbhIAPBR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 11:01:17 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC64C061575
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 08:00:21 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id y3-20020a4ab403000000b00290e2a52c71so918962oon.2
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 08:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UHrouVynzbTMB6LlUqay9S+zjy4YJ9Xg7eVwnAbc/bA=;
        b=gwypPHJGjrXZLxS1odXrqdEXted1+U8Dsz5Iw6UTIxc4IO4FXupcRL3oXn7iu/GOJ3
         OKK1gXOYC6b0OXWHmbP0cQ3+aghhfJ4QfwMH8JD4gYLvjYGlBz1+VoDeYfirDmTlwDqN
         JhYuowxRNAbxHee1bBqSge+lisCH2/2yH1e16ZuqfY4lg3otaTb0ttQiBH+TJYtWNqov
         PnMG/HTFOGutLJEMX0kupZoQveMA1GlO9BWJe2AqAHbiY8+UdCF/a2g9sIzDDEco0Gpb
         qN2JlftZlQPNdF0mvJS2Mc/8crG3OsbfYv2vdPuDYEbw/5HwIhyB0Ty+4hYsXRmEeAxW
         ziGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UHrouVynzbTMB6LlUqay9S+zjy4YJ9Xg7eVwnAbc/bA=;
        b=JdviR5JSBtnrDH1ziBpG5NmCF0R5/J8H/akoptLniinxO5eF07ijh9+d/SKX+Ur4K1
         JLrX5673Jv0vj799DS5WeIa+0iTso0ey2L+7ZIWy7rjsUCQbIUz0ZrBeZ9VkW2LgWFBv
         IYsmo+WfG7MAp5OepAGxJ4baYxjZl64ok+xPFjZOjxJZ/aatFVTPpTyI5VDgpZI1r+eW
         0qkgj2GxQWBCZBwkixJhMh1p1YfKnVrEuKAvZJikYZoNt5Z3g4x2GVNm/WnW5txRKhbt
         z3//PXHRSmBkV1wVNDs5EkX6jiyRY9XJ9Yuc/EJ0qoJ+sPWyf01fL9vuATS6R6/hqdZx
         UfYQ==
X-Gm-Message-State: AOAM532ef69IMsDWPWqWc8qY3ROvagzXD3himHNAD20vGzS1LrlLkiSM
        M72q7007MBr8G9L896Hdj9mkTgEFYVZRUpxGfnhwWGRU3qc=
X-Google-Smtp-Source: ABdhPJwf/p3bOE15pr2jcejJ/kT2mD6rQFsdtdQ+u0P2qcguG2UY49cXmGuQI4Yu8RjJ2U/Kt3xXsOTqklVDJhuehyc=
X-Received: by 2002:a4a:9b8d:: with SMTP id x13mr19236273ooj.7.1630508420338;
 Wed, 01 Sep 2021 08:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com> <0d1ce3c0-2a19-e97a-bf0f-5f8893c806ea@gmail.com>
In-Reply-To: <0d1ce3c0-2a19-e97a-bf0f-5f8893c806ea@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 1 Sep 2021 08:00:08 -0700
Message-ID: <CABPp-BGEDdpb9QFBQux2-_3BJZAcBo30svRF+hfV-KjOcQPojA@mail.gmail.com>
Subject: Re: [PATCH 00/15] [RFC] Upstreaming the Scalar command
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 5:52 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 8/30/21 5:34 PM, Johannes Schindelin via GitGitGadget wrote:
> > tl;dr: This series contributes the Scalar command to the Git project. This
> > command provides an opinionated way to create and configure repositories
> > with a focus on very large repositories.
>
> I want to give Johannes a big thanks for organizing this RFC. As you
> can see from the authorship of the patches, this was an amazingly
> collaborative effort, but Johannes led the way by creating a base that
> the rest of us could work with, then finally he brought in all of the
> gritty details to finish the effort.
>
> > Background
> > ==========
>
> ...
>
> > The Scalar project
> > was created to make that separation, refine the key concepts, and then
> > extract those features into the new Scalar command.
>
> When people have asked me how Scalar fits with the core Git client, I
> point them to our "Philosophy of Scalar" document [1]. The most concise
> summary of our goals since starting Scalar has been that Scalar aligns
> with features already within Git that enable scale. I've said several
> times that we are constantly making Scalar do less by making Git do more.
>
> [1] https://github.com/microsoft/git/blob/HEAD/contrib/scalar/docs/philosophy.md
>
> Here is an example: when our large, internal customer told us that they
> required Linux support for Scalar, we looked at what it would take. We
> could have done the necessary platform-specific things to convince .NET
> Core to create a long-running process that launched Git maintenance tasks
> at different intervals, creating a similar mechanism to the Windows and
> macOS services that did those operations. But we also knew that the
> existing system was stuck with architectural decisions from VFS for Git
> that were not actually in service of how Scalar worked. Instead, we
> decided to build background maintenance into Git itself and had our Linux
> port of Scalar run "git maintenance start".
>
> Once the Linux port was proven out with Git's background maintenance, we
> realized that the window where a user actually interacts with Scalar instead
> of Git is extremely narrow: users run "scalar clone" or "scalar register"
> and otherwise only run Git commands. The Scalar process does not need to
> exist outside of that. (There are some other helpers that can be used in
> a pinch to diagnose and fix problems, but they are rarely used. These
> commands, such as 'scalar diagnose' can be contributed separately.)
>
> It became clear that for our own needs it would be easier to ship one
> installer that included the microsoft/git fork and the Scalar CLI, and
> it would be simple to rewrite the Scalar CLI with all of the Git helper
> APIs. We organized the code in a way that we thought would be amenable
> to an upstream contribution (by placing in contrib/ and using Git code
> style).
>
> The thing about these commands is that they are _opinionated_. We rely
> on these opinions for important internal users, but we realize that they
> are not necessarily optimal for all users. Hence, we did not think it
> wise to push those opinions onto the 'git' executable. Having 'scalar'
> continue to live as a separate executable made sense to us.
>
> I believe that by contributing Scalar to the full community, that we
> create opportunities for Git in the future. For one, users and Git
> distributors can opt into compiling Scalar so it is more available
> to users who are interested. Another hopeful idea is that maybe this
> reinvigorates ideas of how to streamline Git clones for large repos
> without users needing to learn each and every knob to twist to get
> things working. Since the Scalar CLI is contributed in the full
> license of the Git project, pieces of it can be adapted into Git
> proper as needed.
>
> I look forward to hearing your thoughts.
>
> Thanks,
> -Stolee

Looks like exciting stuff, you two.  I'm behind on review as it is; I
still need to get back to Stolee's sparse-index add/rm/mv series, but
I'll try to circle back and take a look.
