Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769BDC47082
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 22:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53EF5613F9
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 22:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhFCWMF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 18:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCWME (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 18:12:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A204BC06174A
        for <git@vger.kernel.org>; Thu,  3 Jun 2021 15:10:08 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g9-20020a25ae490000b029052f9e5b7d3fso9142412ybe.4
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 15:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=e6iHEv1VwAMpP/gZtfhn4U5DvZzJ+R6gOF7GdbUTkzM=;
        b=jbC2RbZt1P05H/zK7Bt/yg9EfSIinzX2BevWc2OqP6YIgxPiPRKB9B8bXK1Hmio9XN
         vYq3Ib6oWmJ4F6AtJUk7hF3a4hjObouT5K+j1B6fb2kC2fO+u96SonD1ugNe+LRlu7W6
         ZapMZgtA+OqzSpRmLR+V/XQwHemJ5Xok+qdR+6NFg8RZV/D7hNOHZ8byoee0lgO7vAnY
         eBA3CSJOA0NNi6P6wQkrv3rE8x9iPd+Drx7DyFEEk7MRhVPRsKlpjR7Hid6tDfVmlkKm
         vuBa/9NMlyH+/cmyFaGQ6pdaVMgagR5C0Q8J47R+aCgF1H2WIRSxlkP0pXK2BST1AirH
         eH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e6iHEv1VwAMpP/gZtfhn4U5DvZzJ+R6gOF7GdbUTkzM=;
        b=X6E3WgJaARp2s8dfK273l1ntHsTT1GjE7ITwHKJGRoK1UI0ffH7nyXGKsei2MrDyye
         4EesZhNgk2cxHEnbMa9IVyYJXjU1cMcEwVy1HiE4wxRV4djiVIYRveaxBpjB/GUCCLhF
         xRDMakuJeeLxrnDCiAeLS8FvN6ObIYHYpItY4oLAwp/+bjfMAFQ+e35MpwfOO4oyXoqF
         YFoXUrKXhFjhia2uzgwW0zgz64ioQ+6aukaA0cch7FwH+oaejlgzgEVc/tNifg2ZZC0u
         g2pczDQ83B6/62sCNb/CLvh2NGttvea3BeOo5mMojIFvVl9gnfd7jjkxkmBitL2EJ6VB
         N53w==
X-Gm-Message-State: AOAM530zQM0bBD/NzwM+uTRHTXQBBx4jhoE+MGvkx1gQAguy4zsPejGh
        MsHaRu96ixfYMPMuiaP2lNetJy2hJSKqSZPvhIP8
X-Google-Smtp-Source: ABdhPJwsNyeEukQMCxkgNAoItllq1zvT/uFCqu1ZUnTJtBth5XPWqb4iyuFiVdXjYhm5XKIDp0jlqYxA+kCTMZvpEknU
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:2551:: with SMTP id
 l78mr911412ybl.353.1622758207880; Thu, 03 Jun 2021 15:10:07 -0700 (PDT)
Date:   Thu,  3 Jun 2021 15:10:06 -0700
In-Reply-To: <CAMbkP-Qkd0EzNvhKLeOU3LCdTDiYKpTmZJqMN5rFDg-WkVMrAw@mail.gmail.com>
Message-Id: <20210603221006.458323-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CAMbkP-Qkd0EzNvhKLeOU3LCdTDiYKpTmZJqMN5rFDg-WkVMrAw@mail.gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: Re: [PATCH v4] hooks: propose project configured hooks
From:   Jonathan Tan <jonathantanmy@google.com>
To:     albertqcui@gmail.com
Cc:     jonathantanmy@google.com, gitgitgadget@gmail.com,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        avarab@gmail.com, emilyshaffer@google.com, stolee@gmail.com,
        emaste@freebsd.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > From the implementation point of view, would it be sufficient to just
> > advertise that hooks are available? Assuming that the hooks will be
> > available from a specially named ref (as stated below), then we would
> > only need to inform the user that this ref exists and hooks can be
> > inspected using a special command. Likewise for when we fetch and notice
> > that the ref now points to a different object. Then, we wouldn't need to
> > do any extra fetching upon clone/fetch, saving time and bandwidth, but
> > just do so if the user requests it.
> >
> 
> From a user perspective, I think it's better to not just tell users
> that hooks are available but also /what/ hooks are available.
> 
> That said, that doesn't require getting everything from the ref as the
> hook command itself might be stored in this ref. So something like
> this seems sufficient to me: "Origin suggests setting up a `pre-push`
> hook which runs `pre_push.sh`. To view the contents of `pre_push.sh`,
> run {special command}."

I agree that on its own, more information upfront is better than less.
But we can't store anything more than an object ID (a SHA-1 hash) in a
ref, though. Knowing anything beyond the object ID would require
fetching some objects, which incurs time and bandwidth (perhaps
comparatively a tiny amount in well-behaved repos, but we still need to
acknowledge that). (Well, there is also the possibility of using
multiple refs to communicate which hooks are present and which are not,
but I think that's too cumbersome.)

> > Right now hooks are fixed files (well, not counting Emily Shaffer's work
> > on config hooks). Would it be sufficient to just provide replacements
> > for those files?
> >
> 
> My thought was we'd leverage config hooks and basically write to the
> config for setting up hooks.

The config hooks work is still in progress, so I think we need to
support both the legacy way and the new way. I think this shouldn't be a
problem since both ways involve writing something somewhere.

In any case, if the aim is to support config hooks, I think it's clearer
if this section just says "write a config" without explaining what the
config can do, since that is the responsibility of the config hooks
feature. (But then there remains the question of whether there will be a
whitelist of acceptable configs to write.)

> > Hmm...what would be a use case of this? And how would, say, a pre-commit
> > hook know which remote it is for?
> >
> 
> For a concrete example, we use Gerrit for internal reviews and need
> the Change-Id hook, but we don't want that when upstreaming.
> 
> Good question for specifying remotes. This might imply the need for
> something like `git commit --hooks-from=origin`.

I think passing a parameter to choose which hook to invoke is beyond the
scope of upstream-supplied hooks. (Also, I don't think that this
situation is resolved by having 2 remotes providing 2 different sets of
hooks. Perhaps one of the remote's set knows to set the Change-Id
trailer, but the other set would not know that it needs to remove a
specific trailer.)

> > This seems contradictory to a point above where we only inform the user
> > upon clone (when the user is in the setup mood).
> >
> 
> Good catch, I should clarify that previous point. The main concern is
> prompting before a hook will execute which would get in the way of
> existing workflows, making users susceptible to blindly agreeing.
> Showing advice after the fact doesn't get in the way, and this is one
> reason why "advice" felt like the right terminology to use (more
> below): it's merely a helpful message that a user can optionally
> choose to follow.

Ah, I see. I'm still not sure that it is a good idea. Firstly, the user
should have already made this decision when they read the message at
clone time, and secondly, this advice might come too late (a pre-commit
hook might be "salvageable" but a push hook might not). Having said
that, the presence or absence of this doesn't affect the overall design
and implementation, so we can leave this in if you want.

> > > +* If, after fetch, the central repository suggests new or updated hooks, the
> > > +user should receive advice to install these new hooks (note: implementation
> > > +should not interfere with requirement listed in "Fast Follows")
> >
> > In Git, the term "advice" seems to be used more for extra
> > explanations that you can turn off once you're experienced with Git.
> > Here, these seem like things that we would want to notify users about
> > regardless of experience level, so maybe the word "notification" is more
> > appropriate.
> >
> 
> Another reason to use "advice" here is because the existing system
> allows users to turn off the advice when it's not needed for the
> requirement: "The user should be able to use configuration to turn off
> this advice."
> 
> Do advice settings work on a per-clone basis? If not, I agree "advice"
> is probably not the right term.

Those settings don't work per-clone. My main point, though, is that the
user probably would always need to know if there are new hooks.

> No, that's what I meant by "Fast Follows" -- not needed for the initial feature.

Ah, maybe call it "future work" then. "Fast follows" is not a term I'm
familiar with (and searching online, it doesn't seem like a common term
either).
