Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C2EC433E0
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 01:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B5D464E3F
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 01:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhBNBde convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 13 Feb 2021 20:33:34 -0500
Received: from mail-ej1-f42.google.com ([209.85.218.42]:38888 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhBNBdd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Feb 2021 20:33:33 -0500
Received: by mail-ej1-f42.google.com with SMTP id bl23so5704623ejb.5
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 17:33:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s05qwL5N66erPzOoF7s+Vd0Ua/oCAXLJsgPF6uaHyg4=;
        b=j61ehDFAzH6t96HPss286tpYsnMX/pVt9yz7aAhrvQRcpI0AUSrj4eqJJX49oelteF
         zXm7GTAAiu2y6aoeJ7bmMDyKbBAXsMrnHx/zhajPRWhU9CM6WabyX/mpr/dxDpDDK4LH
         j4O34YiUtD3D07gktIFvmzzpGGHVtjODBucysqXD4eTSi5VEHH9ZfQzAs/JSnbKs6zY+
         sH0qksAAF+ojaM6vsr+BJcZWZrhf6NX/iWNkGVq5HUxPYaM+zC+dR2lg2MYtoC6GJS8Y
         JkroaXMLXs+oTWPYTSqw22jtDZQKZdy1S4B9932TFlIUs4HvGfP/5z1PZNju3xGTW1sw
         SLTw==
X-Gm-Message-State: AOAM530LBI/5SijS8nQO7gpiuw7PtJyLp99T5buz8aTuz1ppQOcD/UjB
        WxM32vraa18hpmFvsXHNEL51AxByvO6pQnJHpO8=
X-Google-Smtp-Source: ABdhPJzT3DCZmdeDhSKi08UcXzseuqUF6OnsSe8LWhZY7PxMFd+lYT3Mi6KhyiycLCw8XOtF9TZyZ9ESWJhNZvAWfHM=
X-Received: by 2002:a17:906:444d:: with SMTP id i13mr9368493ejp.170.1613266371076;
 Sat, 13 Feb 2021 17:32:51 -0800 (PST)
MIME-Version: 1.0
References: <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
 <pull.843.v3.git.1612970140.gitgitgadget@gmail.com> <3e6af929d135ef2dc239e2f47f92a7e2e91cbd17.1612970140.git.gitgitgadget@gmail.com>
 <xmqq4kigvkct.fsf@gitster.c.googlers.com> <CABPp-BHyYOAw939vU20oA_tOSFRVm=EaLKuw+4M1oP1GDDV5cg@mail.gmail.com>
 <xmqqblcnttcr.fsf@gitster.c.googlers.com> <CABPp-BErByO=6jE+tZQHSsGJacr92AqVL7dnctE9MjQzmeQfcg@mail.gmail.com>
In-Reply-To: <CABPp-BErByO=6jE+tZQHSsGJacr92AqVL7dnctE9MjQzmeQfcg@mail.gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Sat, 13 Feb 2021 17:32:40 -0800
Message-ID: <CAPc5daVVNaBiWt8vRv3xrXd7GvNPwRGRF=W31DUJCnZRo+9qtA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] t4001: add a test comparing basename similarity
 and content similarity
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I do not consider "the same file changed in place" the same as "we
seem to have lost a file in the old tree, ah, we found one that has
the same basename in a different directory" at all, so your argument
still does not make any sense to me, sorry.

2021年2月13日(土) 17:25 Elijah Newren <newren@gmail.com>:
>
> On Sat, Feb 13, 2021 at 3:56 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Elijah Newren <newren@gmail.com> writes:
> >
> > > This is not true.  If src/main.c is 99% similar to src/foo.c, and is
> > > 0% similar to the src/main.c in the new commit, we match the old
> > > src/main.c to the new src/main.c despite being far more similar
> > > src/foo.c.  Unless break detection is turned on, we do not allow
> > > content similarity to trump (full) filename equality.
> >
> > Absolutely.  And we are talking about a new optimization that kicks
> > in only when there is no break or no copy detection going on, no?
>
> Yes, precisely, we are only considering cases without break
> detection...and thus we are considering cases where for the last 15
> years or more, sufficiently large filename similarity (an exact
> fullname match) trumps any level of content similarity.  I think it is
> useful to note that while my optimization is adding more
> considerations that can overrule maximal content similarity, it is not
> the first such code choice to do that.
>
> But let me back up a bit...
>
> When I submitted the series, you and Stolee went into a long
> discussion about an optimization that I didn't submit, one that feels
> looser on "matching" than anything I submitted, and which I think
> might counter-intuitively reduce performance rather than aid it.  (The
> performance side only comes into view in combination with later
> series, but it was why I harped so much since then on only comparing
> against at most one other file in the steps before full inexact rename
> detection.)  I was quite surprised by the diversion, but it made it
> clear to me that my descriptions and commit messages were far too
> vague and could be read to imply a completely different algorithm than
> I intended.  So, I tried to be far more careful in subsequent
> iterations by adding wider context and contrasts.
>
> Further, after I wrote various things to try to clarify the
> misunderstandings, I noticed that Stolee picked out one thing and
> stated that "This idea of optimizing first for 100% filename
> similarity is a good perspective on Git's rename detection algorithm."
> (see https://lore.kernel.org/git/57d30e7d-7727-8d98-e3ef-bcfeebf9edd3@gmail.com/)
>  So, that particular point seemed to help him understand more, and
> thus might be useful extra context for others reading along now or in
> the future.
>
> Given all the above, I was trying to address earlier misunderstandings
> and provide more context.  Perhaps I swung the pendulum too far and
> talked too much about other cases, or perhaps I just worded things
> poorly again.  All I was attempting to do in the commit message was
> point out the multiple basic rules with filename and content
> similarity, to lay the groundwork for new rules that do alternative
> weightings.
>
> Anyway, I've added a few more tweaks to try to improve the wording for
> the next round I'll submit today.  Given my track record so far, it
> would not be surprising if it still needed more tweaks.
