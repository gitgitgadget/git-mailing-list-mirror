Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E2FC48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 09:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BBA861245
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 09:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhFOJSs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 05:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbhFOJSr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 05:18:47 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057F6C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 02:16:43 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso13609204otu.10
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 02:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=CjC0qhVQxZ/36hKCRlXO2vNv/2Oj4L/Bc610gU/VhRM=;
        b=RwMsJ5+XC8nG5vojCBvs2RnL/TbmrNyAimtox8JfNKZb2qamhcCLuAGXY4wQoi9YWn
         vvfrnpAZVf9Zq7Bdi2K3iCjDNROPH09meO4akbGk4ID2ezjuIA6F/JUG7IKzRFN44c0i
         aByHVpYrOCyblmqxRjybFRGD3LCYumyAYeIjav/L6tustpt0A+C5Jc5g2RqIouzxLAON
         veXJT0xTCZnJt7XqbZQ+D2dqpv/ZtuF20+UCjG+grOsM7UudVaserhc/D6QfP5jDV8VP
         UKrxlO3P/DjEdIwbS6gm+S3uQKDU7A+9BkEhLGLpnQB2sQG8cfam0ntByHpkkk25vndE
         paIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=CjC0qhVQxZ/36hKCRlXO2vNv/2Oj4L/Bc610gU/VhRM=;
        b=dwnpuHVSyjc95Nlfgu3v1LuVzfMkIFWdlxb7FPQy0rQV+6lBhZN+kvHIYdr8NJJvPC
         z8dM+E/+i8/GfOW8KnG24pSTlPCZSRt+FxJJw8rZrtuzS04SzekaU7cDWfeuL6hdoW5c
         V1JYsZ1br/7D2EVUj4nOHRkOLvYDhcKOIcYt+s96eAIwomgkiIYTign48FnzpGvCvHL0
         MLGolWT3SpL6GfsrU7Yz1qMgfirNCRl6i7BbBXnF7jnAWNZS1Ab2mP0hUyqNuw2u3ak+
         e52ouqTUTs4H5nPTpkGnGOmS4++NuIlQ4TYTYsqpncq026ezk4uF8w0Ony6wvXC6/0ST
         1uRw==
X-Gm-Message-State: AOAM532DVBhKoql6/+Wlab8wa51rDSu70RJ5zQtwC3roIMKzNnT0owso
        wOAg1yjzLYPYGpLxRi4ZYb4=
X-Google-Smtp-Source: ABdhPJzhQBDixo43WduUUcOOZC/oEoUD5EHBiukUUulmDEBNnXH6e9iiymInUGJ9iVWa9Xb4n03Tjw==
X-Received: by 2002:a9d:7254:: with SMTP id a20mr16817611otk.142.1623748602366;
        Tue, 15 Jun 2021 02:16:42 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id x31sm3842350ota.24.2021.06.15.02.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 02:16:41 -0700 (PDT)
Date:   Tue, 15 Jun 2021 04:16:40 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <60c86ff87d598_e6332085b@natae.notmuch>
In-Reply-To: <CABPp-BFY7uU5Ugypv4xCHq+XHTc3UROWPdV1v-JbN7xBycDZTA@mail.gmail.com>
References: <20210613143155.836591-1-felipe.contreras@gmail.com>
 <YMYnVWSEgxvKRU9j@coredump.intra.peff.net>
 <60c647c1d9b5c_41f452089@natae.notmuch>
 <60c677a2c2d24_f5651208cf@natae.notmuch>
 <xmqq7divzxrr.fsf@gitster.g>
 <CABPp-BFY7uU5Ugypv4xCHq+XHTc3UROWPdV1v-JbN7xBycDZTA@mail.gmail.com>
Subject: Re: [PATCH] xdiff: implement a zealous diff3
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Mon, Jun 14, 2021 at 7:07 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Felipe Contreras <felipe.contreras@gmail.com> writes:
> >
> > > I found the problem, m->chg0 was not initialized in xdl_refine_conflicts.
> > >
> > > I'm not familiar with the area so I don't know if the following makes
> > > sense, but it fixes the crash:
> >
> > Unlike the remainder of the xdiff/ directory, xdiff/xmerge.c was
> > Dscho's brainchild if I am not mistaken, so I'm CCing him for
> > input.
> 
> This is going to sound harsh, but people shouldn't waste (any more)
> time reviewing the patches in this thread or the "merge: cleanups and
> fix" series submitted elsewhere.  They should all just be rejected.
> 
> I do not think it is reasonable to expect reviewers to spend time
> responding to re-posted patches when:
>   * no attempt was made to make sure they were up-to-date with current
> code beyond compiling (see below)

What makes you think so?

>   * no attempt was made to address missing items pointed out in
> response to the original submission[1]

The original submission caused a discussion with no resolution, and
edned with Jeff saying he wanted to try real use-cases and that that he
wanted to use it in practice for a while.

The purpose v1 of this series was to respark the discussion and see if
any of the original parties had changed their minds.

People do change their minds after 8 years.

>   * no attempt was made to handle or even test particular cases
> pointed out in response to the original submission (see [1] and below)

Those were sent *after* the series, except [4], which clearly states the
*opposite* of there being a deal-breaker:

  But again, we don't do this splitting now. So I don't think it's
  something that should make or break a decision to have zdiff3. Without
  the splitting, I can see it being quite useful.

>   * the patches were posted despite knowing they caused segfaults, and
> without even stating as much![2]

Whomever *knew* that, it wasn't me.

>   * the segfault "fixes" are submitted as a separate series from the
> patch introducing the segfault[3], raising the risk that one gets
> picked up without the other.

My v2 includes the patch.

Just because a patch is in one series that doesn't preclude it from
being in another series. `git merge` and `git rebase` are smart enough
to handle such cases.

There is no risk of that happening (unless there's plans of merging v1
as-is).

> In my opinion, these submissions were egregiously cavalier.

If you make unwarranted assumptions everything is possible.

> I'll submit a patch (or perhaps a few) soon that has a functioning
> zdiff3.

I already have a functioning zdiff3.

> However, since I've already put in the time to understand it, let me
> explain what is wrong with this patch.  This particular change is in
> the area of the code that splits conflict regions when there are
> portions of the sides (not the base) that match.  Doing such splitting
> makes sense with "merge" conflictStyle since the base is never shown;
> this splitting can allow pulling the common lines out of the conflict
> region.  However, with diff3 or zdiff3, the original text does not
> match the sides and by splitting the conflict region, we are forced to
> decide how or where to split the original text among the various
> conflict (and non-conflict?) regions.  This is pretty haphazard, and
> the effect of this patch is to assign all of the original text to the
> first conflict region in the split, and make all other regions have
> empty base text.

Yes, that is *one* opinion. The jury is still out on what is the best
approach. Junio and Jeff did not agree on that.


The whole point of "zdiff3" was to have something closer to "merge",
even if it wasn't 100% correct. Your approach maybe more correct, but
correctness was never the point.

Either way, I have more rewarding things to focus on, so good luck with
that.

> [1] https://lore.kernel.org/git/CABPp-BGZ2H1MVgw9RvSdogLMdqsX3n89NkkDYDa2VM3TRHn7tg@mail.gmail.com/
> [2] https://lore.kernel.org/git/YMbexfeUG78yBix4@coredump.intra.peff.net/
> [3] https://lore.kernel.org/git/20210613225836.1009569-5-felipe.contreras@gmail.com/
> [4] https://lore.kernel.org/git/20130307180157.GA6604@sigill.intra.peff.net/

-- 
Felipe Contreras
