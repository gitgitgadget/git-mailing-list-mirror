Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A61C433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 15:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C816E23AFE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 15:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbgLIPaT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 10:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbgLIPaS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 10:30:18 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69410C0613CF
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 07:29:38 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id a16so2705667ejj.5
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 07:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Z5akfwwye6bXWWFxM8foy9KJThrdkI0ulE0NRqq3bmk=;
        b=o35ULhyGZ1ax1i5sBRptbh45oS6sUGXu3lA1FP5oSm/inAfUr+XvvtNujdMuHWjomw
         B9okut9aHm8IYvJfAl60KEsOtfsH1knNfxUmt0+ZomN5AiMUbolzsoMHl5IrvUckUp0r
         BPwBBxkNqm7ZDoXC5XkUzrB6rTdkcotV9qTwYYomO+cLWrKPbllkjZg0fci+isD9AZgJ
         4baknTxyh4rT1G4QXbRLNPTykRgnr/rSGbjOk6Gj6M8ofxRBlAdlb9Yzoar1zHKOX3pV
         Yg6YDgJEi1cA6dHImduahP3DCQKSjDJ/FXoG8mANwr0MHSMo/HUxvyCfmG+qh0NHqE9L
         LfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Z5akfwwye6bXWWFxM8foy9KJThrdkI0ulE0NRqq3bmk=;
        b=dqeP/nIVTYo4R0l2ok0EhlGt6MYDUZayMiQet9hsA84Bt82Hg/S4cMJEfl0ZFc1qrb
         gdomP+8dNQ8/T3UEAsdUiH6aA1YFum4q0GW3C7zxDbpqQt1BKXoLoFSj+5hdIf3GQOpv
         KL2yH0Tf8HNzQSPVi7po/iG6hDjqp0V/IXrX1bXGd5UR8kOQ8ywIGuW2bEx2YUGrF4MF
         xk6fTLqLk7nV8EyIqrDLDy0DoHbsSamtBRyC8OX0mXM8wTmLY1SS2JiPyQwYTl8PxXCH
         AFAUeTap06WstQormx7TdG3g3ps3xEbp6S5VZTwdZ6kJqWRREmG/KnKi9+fcuKyNYQQq
         UBCQ==
X-Gm-Message-State: AOAM530BnLLuuWkboSPFWp+3jU7nsBH1NSB/kxEH7iJithoCRfTKBCXF
        Mmx8rfQP37DGiVrPP1UszsA=
X-Google-Smtp-Source: ABdhPJzxKslDG6nCS6z9uv1s1oXcIUz2roAaBG1e3ugd0oWUxcFWDMWvHY+5YbpV9Wu5qSYdXSnIlQ==
X-Received: by 2002:a17:906:1481:: with SMTP id x1mr2552340ejc.186.1607527776991;
        Wed, 09 Dec 2020 07:29:36 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id a12sm1949703edu.89.2020.12.09.07.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 07:29:35 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 0/6] config: allow specifying config entries via env
References: <cover.1606214397.git.ps@pks.im> <cover.1607514692.git.ps@pks.im>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <cover.1607514692.git.ps@pks.im>
Date:   Wed, 09 Dec 2020 16:29:35 +0100
Message-ID: <87y2i7vvz4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 09 2020, Patrick Steinhardt wrote:

> this is the fourth version of my patch series which aims to implement a
> way to pass config entries via the environment while avoiding any
> requirements to perform shell quoting on the user's side.
>
> Given that the What's Cooking report notes that my third version is
> about to be dropped dropped because the `--config-env` way of doing
> things is preferred, I've now adopted that approach. I've taken the
> patch which Peff posted originally (with one change strchr->strrchr) and
> added documentation and tests to it.
>
> This patch series still includes my old proposal as it would actually be
> a better fit for our usecase at GitLab I have in mind, which is to put
> all configuration which applies to all git commands into the commands
> instead of using a config file for this. I have structured the series in
> such a way though that those patches come last -- so if you continue to
> think this approach shouldn't make it in, please feel free to drop
> patches 3-6.

To add even more to your headaches (sorry!) I hadn't really fully looked
at that --config-env proposal.

As noted in my per-patch reply in [1] it will still expose the key part
of the key=value, and in at least one place (url.<base>.insteadOf) the
key is where we'll pass the user/password on the command-line still with
that.

I'd much prefer either your 6/6 over --config-env for that reason & that
--config-env makes it impossible to pass a key with "=" in. For "-c" I
don't think that's much of an issue, but e.g. with
"url.<base>.insteadOf" needing to take arbitrary passwords + us
implicitly/explicitly advertising this as a "here's how you can pass the
password" feature not being able to have "=" is more painful.

I mildly prefer Jeff's suggestion of just getting GIT_CONFIG_PARAMETERS
to the point where we could document it [2][3] to both of those, but
that's mostly an asthetic concern of dealing with N values. It won't
matter for the security aspect (but I think you (but haven't tested)
that you still can't pass a "=", but your 6/6 does allow that).

I still can't quite shake the bad spidey-sense feeling that any of these
are bad in some way we haven't thought of, just from the perspective
that no other tool I can think of that accepts a password has this
mechanism for passing in a user/password or other sensitive data.

E.g. openssh explicitly has refused to add anything of the sort (a
--password parameter, but maybe they didn't consider
--password=ENV_VAR). E.g. curl has a mode where you can have a password
on the command-line, but they then make you use -netrc-file to grab it
from a file. From searching around I see concerns about shell histories
being part of the security model, maybe that's why it's not a common
pattern.

So I still wonder if some version of what I tried with /dev/fd/321 in
[4] would be best, i.e. something that combines transitory+no extra
command invocation+not adding things to shell history. We support that
pattern in general, just not in fetch.c/remote.c for no particular good
reason AFAICT.

I do that that whatever we go for this series would be much better if
the commit messages / added docs explained why we're doing particular
things, and to users why they'd use one method but not the other.

E.g. IIRC this whole series is because it's a hassle to invoke
core.askpass in some stateful program where you'd like to just provide a
transitory password. I think some brief cross-linking or explanation
somewhere of these various ways to pass sensitive values around would be
relly helpful.

1. https://lore.kernel.org/git/871rfzxctq.fsf@evledraar.gmail.com/
2. https://lore.kernel.org/git/20201117023454.GA34754@coredump.intra.peff.net/
3. https://lore.kernel.org/git/20201118015907.GD650959@coredump.intra.peff.net/
4. https://lore.kernel.org/git/87k0upflk4.fsf@evledraar.gmail.com/

