Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6119DC433EF
	for <git@archiver.kernel.org>; Tue, 10 May 2022 22:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbiEJWAe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 18:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbiEJWAW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 18:00:22 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BB92983B4
        for <git@vger.kernel.org>; Tue, 10 May 2022 15:00:21 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id y17-20020a637d11000000b003ab06870074so31027pgc.15
        for <git@vger.kernel.org>; Tue, 10 May 2022 15:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=czHh1KxEafOxuX5RA9+RJZq/bxVmfZAqbPIrDvKayQ0=;
        b=UA27CCbmZEimEeEHVP+hPRGg+HpiVHz6IA07tRYlfZB3rtNat69WaqW5sIX8K3Umfl
         YqqnOF/eQTQjk8UlKQH8hL94QKPp8Ij5/P9fhUsLxJsSnka5wn0OflrPsWjxhe4p+lBk
         q73SB1etp2LT56Ts1P95TzFgKUam2PiemVugEMBa/TxJXOFNwcJ1egNeP7ylobx+UMfo
         9h8nZFd0FlzO7ezNd61H7C2fyehVCeub2OViR6Q/gVPBVVucaHvkt2EvhAQegNgLWib2
         WdPNEV1ETlM/EGIJRzZFe/8UoBSqZzLiA4xRZ/5Ioiwe+0TvJEZ711dSO8E44cZCKi6A
         hA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=czHh1KxEafOxuX5RA9+RJZq/bxVmfZAqbPIrDvKayQ0=;
        b=pHx98piUUvNxp7UDcb7MFwOxKPmPYCM+q+wigCCxR0HNwY2XCloD7mnXBdtCh8uS1p
         xj/txrA/g294P1k12LCiYRNMZZYk4fiE36+NtAWOSpUCYMB1KFW+qBIMc9WNXn79kAmG
         gdwuZOqMtHLld+IwV//D46nYui3z8kz4w/2EQ3qfYJilEwR5gOh0L058kLfxgntL2Evx
         Q72NlAZpD36Jz3xer4wl4hnt/4H0Wio3d1xUHPf6qJYe8h+FnsGmCTdIRZp+AfMZBRAy
         q0nZfqqzwcJYOhFMXeFrOsmhS2b4gqK3Nqt0tBda0Q0esFQa2toH/9yUwZOEwzrdyQzf
         siOw==
X-Gm-Message-State: AOAM532jmCGqZgyZ7VzkvA+xVQDtVx+l9nZC16BdxHqYYHRza4vg6KiA
        834wpP/uhDn1/S0fBzBOVwsla4882GZqlw==
X-Google-Smtp-Source: ABdhPJwreRc9iDMOPUlmpyZMLL6vpZWCZdP5wRMN2eb4WJkhajY0aBgOMliF/QVWYDZn3fXb+78TtzU4a3mRUg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:e510:b0:1d9:ee23:9fa1 with SMTP
 id t16-20020a17090ae51000b001d9ee239fa1mr33061pjy.0.1652220020193; Tue, 10
 May 2022 15:00:20 -0700 (PDT)
Date:   Tue, 10 May 2022 15:00:17 -0700
In-Reply-To: <YnmKwLoQCorBnMe2@nand.local>
Message-Id: <kl6lwnet6ob2.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1261.git.git.1651861810633.gitgitgadget@gmail.com> <YnmKwLoQCorBnMe2@nand.local>
Subject: Re: [PATCH] [RFC] setup.c: make bare repo discovery optional
From:   Glen Choo <chooglen@google.com>
To:     Taylor Blau <me@ttaylorr.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

Taylor Blau <me@ttaylorr.com> writes:

> Hi Glen,
>
> On Fri, May 06, 2022 at 06:30:10PM +0000, Glen Choo via GitGitGadget wrote:
>> From: Glen Choo <chooglen@google.com>
>>
>> Add a config variable, `safe.barerepository`, that tells Git whether or
>> not to recognize bare repositories when it is trying to discover the
>> repository. This only affects repository discovery, thus it has no
>> effect if discovery was not done (e.g. `--git-dir` was passed).
>
> To summarize, this proposal attempts to work around the problem of
> embedding bare repositories in non-bare checkouts by providing a way to
> opt-out of bare repository discovery (which is to only discover things
> that are listed in the safe.bareRepository configuration).
>
> I agree that this would prevent the problem you're trying to solve, but
> I have significant concerns that this patch is going too far (at the
> risk of future damage to unrelated workflows) in order to accomplish
> that goal.

Thanks again for the careful read. As I understand it, your concern is
that making bare repository discovery configurable and then flipping the
default to e.g. never detecting bare repositories is too disruptive to
fix the embedded bare repository problem. And to avoid disrupting
non-embedded bare repositories, you would prefer to pursue a more
targeted fix.

If the problem statement were limited to embedded bare repositories,
then I agree that this is way more than overkill, and that a targeted
solution would be preferable.

More generally however, the problem of embedded bare repositories seems
to suggest that bare repository discovery doesn't serve all users well,
and in fact, may even be a net negative for a subset of users. I'd be
interested in hearing your thoughts from that perspective, e.g.

- Should bare repository discovery should be configurable?
- What is a good default for bare repository discovery? (regardless of
  how feasible changing the default is)

This is a somewhat different direction from how the conversation started
(I hope it doesn't look like I'm shifting the goal posts), but I think
it's a good opportunity to step back and simplify something that we
wished we got right in the beginning.

And even if we don't flip the default, shipping the config value still
seems useful e.g. there's a good amount of interest in disabling bare
repository discovery at $DAYJOB (and I think we'll get a lot of
interesting results once we do).

>>     safe.barerepository is presented to users as an allow-list of
>>     directories that Git will recognize as a bare repository during the
>>     repository discovery process (much like safe.directory), but this patch
>>     only implements (and permits) boolean behavior (i.e. on, off and unset).
>>     Hopefully, this gives us some room to discuss and experiment with
>>     possible formats.
>>
>>     Thanks to Taylor for suggesting the allow-list idea :)
>
> I did suggest an allow-list, but not this one ;-).

Ah, yes. Oops. Sorry if it looked like I was putting words in your
mouth.

What I really meant was that an allow-list (untethered from any specific
purpose) seems like a useful 'UI primitive', so thanks for bringing up
the option.

>>     I think the core concept of letting users toggle bare repo discovery is
>>     solid, but I'm sending this as RFC for the following reasons:
>>
>>      * I don't love the name safe.barerepository, because it feels like Git
>>        is saying that bare repos are unsafe and consequently, that bare repo
>>        users are behaving unsafely. On the other hand, this is quite similar
>>        to safe.directory in a few respects, so it might make sense for the
>>        naming to reflect that.
>
> Yes, the concerns I outlined above are definitely echoing this
> sentiment. Another way to say it is that this feels like too big of a
> hammer (i.e., it is targeting _all_ bare repositories, not just embedded
> ones) for too small of a nail (embedded bare repositories). As you're
> probably sick of hearing me say by now, I would strongly prefer a more
> targeted solution (perhaps what I outlined, or perhaps something else,
> so long as it doesn't break non-embedded bare repositories if/ever we
> decided to change the default value of safe.bareRepository).

Ok, yeah I think safe.barerepository is a terrible way to achieve my
purported goal of 'making bare repository discovery
configurable/simpler/' - using the "safe." namespace makes it impossible
to see this as anything other than protection against dangerous, unknown
bare repositories. I'll drop the idea of safe-listing known bare
repositories for now, that seems unproductive.

'Optionally disable bare repository discovery' still sounds like it's on
the table though, but probably with a different kind of UX e.g.
"discovery.barerepository" with the options:

- always: always discover bare repos
- never: never discover bare repos
- cwd-only: only discover bare repos if they are the cwd
- dotgit-only: only discover bare repos if they are a descendant of
  .git/

>>      * The *-gcc CI jobs don't pass. I haven't discerned any kind of pattern
>>        yet.
>
> Interesting. I wouldn't expect this to be the case (since the default is
> to allow everything right now).

This might be a false alarm - I saw similar failures on an unrelated
patch. I think my "master" is just out of date :(
