Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BE3C07E95
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 20:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6488613B0
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 20:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhGDU6M (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jul 2021 16:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhGDU6M (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 16:58:12 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF6CC061574
        for <git@vger.kernel.org>; Sun,  4 Jul 2021 13:55:36 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t3so21061179edc.7
        for <git@vger.kernel.org>; Sun, 04 Jul 2021 13:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=3IL5e6NDU+h0pyoe5nVJywNXcdA55uySVeQaRhWkh9Q=;
        b=iUQQthgLACaMikCx8sGMqj4P7wUZlHoww+Uf4KqfuBdYDR6+flVLeR1y/1waKdF+6g
         M5Kp8XvhyhbKT9JIqqGL/wRQxp56iA1CCX/gmG0KoeC1prewqJ+G/PKxHJebcqHsDRuZ
         hcmPuLZ4+PQ1Uunpuuw/oiohIQCOxk5Ok4r5U13gKX+slkyJVQBlKICnKcwJ+vaEL/kp
         sg9LHFEx0Bovbht9FH9fXas0UCE0gFxFc/HV1xHSD9u2iau6oUax4LEGyqPiJy4Av9Wi
         jSYa6zZm7wYM21cRgDN7JtuB5PHeo/vjmXFVMaCzbugq6VtSIVjIPtZKP2skszvoBCfr
         rEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=3IL5e6NDU+h0pyoe5nVJywNXcdA55uySVeQaRhWkh9Q=;
        b=elWEvPUGjK6XogY0jBzq6t4FHi83zDta32fMb9vqsCTDD3kfbZAOeFj65GHNWt4TGe
         pU5gv8bHFb/dGIJgqAHANDtVGWkPjjVyOZ+3IbVTcjjdoEUvEVJPj1Vg4J6zrz/Ld7kZ
         0Y4iuo4/2AgDoznmNKH8FxO67Kld1g/EuhICm6F4q+WGNS2jkkwaBkdULUisOOAPwwZX
         EjBcKel2xpr2EK7qP3fCzwu041xShvMuCVeTiP1gRghQOdI1yLJgl3A1kEk/sfKaM38G
         at6bbCFGXDYtGs/0epykAIesRw2dTPKdV2BrdCA9vTvBEuzxa9iCfJpkcii1gfN4oEG2
         jvBQ==
X-Gm-Message-State: AOAM5312OWYZ3IF6hUjm0SduvOQabEmvAkv2YgPwOyYXdbwR3yCZ3suL
        DV/qxFDm6ElnXnZpNZ+TvYw=
X-Google-Smtp-Source: ABdhPJyOCcH9YN5gNhqmalwjfr0Lc80ulsv6KklriD7QrQ1HEd0E1HeiYxQFxH1wA41xNh6pt2zRgw==
X-Received: by 2002:a05:6402:b9c:: with SMTP id cf28mr3669467edb.198.1625432133322;
        Sun, 04 Jul 2021 13:55:33 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id cn17sm1832231edb.29.2021.07.04.13.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 13:55:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: The git spring cleanup challenge completion
Date:   Sun, 04 Jul 2021 22:47:32 +0200
References: <60df97ed24687_34a92088a@natae.notmuch>
 <C19D6C61-D62A-4344-BA1C-A532EB4FEFFE@gmail.com>
 <60e0a9707e09a_2f7208f2@natae.notmuch> <YOEEjwbMPRmWOmrM@mit.edu>
 <60e1ee7a3cfbc_6d11d20811@natae.notmuch>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <60e1ee7a3cfbc_6d11d20811@natae.notmuch>
Message-ID: <87wnq57q9n.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jul 04 2021, Felipe Contreras wrote:

> Theodore Ts'o wrote:
>> On Sat, Jul 03, 2021 at 01:16:16PM -0500, Felipe Contreras wrote:
>> > Atharva Raykar wrote:
>> > > I can imagine aliases like 'co' only adding to the overload of
>> > > information if an instructor is not careful. FWIW, I have never seen a new
>> > > user complain about the length of the typing, it's usually with the plethora
>> > > of unintelligible (to them) options that each command has when they open the
>> > > Git man pages, which adds more fear.
>> > 
>> > This is one of the reasons I suggested to split git into two binaries:
>> > git for normal users, and git-tool for all the plumbing not many humans
>> > use.
>> 
>> It might be that the answer for the problem Atharva has described
>> would be for someone so include to create a new front-end to git ---
>> call it "sg", for simplified git", or "gt" for git tool (different
>> from the "git-tool suggested by Felipe), etc.
>> 
>> It could be an extremely opinionated subset of git's functionality;
>> for example, it could be one where the index is completely hidden from
>> the user, so you never need to type "sg add" when modifying a file,
>> but only when adding a new file to be under source code management
>> (e.g., that "sg commit" would effectively imply "git add -u ; git
>> commit"), and so on.  Since the index doesn't conceptually exist in
>> the sg interface, then "sg reset" would only have the meaning of "git
>> reset --hard", etc.
>> 
>> By definition this simplified front-end to git would have a subset of
>> the functionality of "full git", but that's OK.  The whole goal would
>> be to make something super newbie-friendly --- the equivalent of a
>> "Mac OS-like" interface, that perhaps doesn't have the power of
>> someone who opens up a shell and uses tools like awk or perl, but is
>> good enough "for the rest of the human race".
>> 
>> Note that this doesn't have to be an official "git" ccommunity
>> initiative; anyone could try to create such one of these things (and I
>> believe a few things exist already).
>> 
>> Making it a non-goal that this "user friendly" front end doesn't have
>> to have the full functionality of git, and its main goal is to allow
>> the use of different user interface design choices made by git, might
>> be much simpler than trying to change git, which would require having
>> the argument over which functionality is used by "normal users", and
>> which features should be exiled to "git-pull" as being "fringe"
>> features.
>
> I think there's some value in that idea but that doesn't solve the same
> problem my suggestion solves. Basically there's too many commands in
> `man git`. Splitting the git binary would allow us to only put the
> important commands in `man git`.
>
> I think having too many commands overwhelms many newcomers, because they
> don't know which it's important for them to learn and which are
> basically noise.

I'm very much for the idea of a cleanup of "man git", but I don't think
we need to introduce a git-tool(1) for that.

E.g. "man perl" is a good example of where we should be
headed. I.e. right off the bat in "man git" we have a long listing of
command-line options to git itself, things like --exec-path and
--no-optional-locks etc. are useful to almost no casual user.

We should really split everything except a passing mention of -p, -P, -c
etc. into a "man gitrun" or something (just like perl has "man
perlrun"), ditto the whole "ENVIRONMENT VARIABLES" section.

Our whole list of "porcelain" v.s. "plumbing" also needs to be
refactored. I've been meaning to get to that[1], i.e. the
plumbing/porcelain split we present in "man git" isn't the ground truth
at all. We need some manual page that covers commands, but also exit
codes, and specific options (e.g. "git-status" is either porcelain or
plumbing depending on the mode it's in, same for "log" etc.).

If I try to print https://git-scm.com/docs/git in my browser it's 36
pages, it's only on page 34 that we start to discuss[2] tutorials
etc. in a bit more detail than in the starting DESCRIPTION section. By
comparison e.g. perl (probably a more complex tool overall) is 2-3 pages
of just pointing you at other documentation appropriate to various
sub-topics.

1. https://lore.kernel.org/git/878sa7xujm.fsf@evledraar.gmail.com/
2. https://git-scm.com/docs/git#_discussion
