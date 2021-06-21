Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8C2C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 18:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 406EA61002
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 18:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhFUTBQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 15:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhFUTBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 15:01:16 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BA9C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 11:59:00 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id 12-20020a05621420ecb02902766cc25115so1644689qvk.1
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 11:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bUQ6E54hsTc0JX3gRLZBgUM4s3TxLEI9KWb48Lcmv1M=;
        b=mdkAJh80jY5j1M+nRQx7RdvvQ3P9m3xxdv8B4djjIIydW3W3wqMnBhpbeIMbpA6EDb
         b3YwowEaUbGB/rr5+VDX2c7JvNs2lOIwUmwWNsDQeQKQMIsbmv5MEmrcmtV1VPZpsfDs
         HOlXH9UeqEnNo4GdOaWE2m4qQA713AMA9oEzARQVHdH3IerzJY4k5FDK69LaDGg2GTzL
         l68Dj06YJouFAJ5dR/vlVxg+0FXyNLU9gEwcFZPn4kIqyHj3kMWx2f7ZwzJP2JW2fVca
         xwIVF83mKnKnirBW0GNWNIW12S4Am6Oij7V7GUUn2wNyF4OdrCSYo8/t/8efD/0IYKS3
         dDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bUQ6E54hsTc0JX3gRLZBgUM4s3TxLEI9KWb48Lcmv1M=;
        b=EwkddNfAE7m4RLzWM7zttkxGZZicjZ+f0hCZ/NkTjPva1nqWLP0TTu7dfyOStqX8ub
         Xus/LjcbcT+3O4815WQWUQocZ6T+s0vKuv4TBDU4eqMkrEyAveiHhrE4GNLi076SUbHd
         h2VKL3gcQ5O++OMQXV/SdE/TVB5zrkgmrq7UTaU3uC2t1Wch57bFz/VLMTke43oG72wm
         F1+eDYAMh5S7+I1u0TrPlJcXDfEwwhgY/tCmxxs0VlKtrOh8nTHxq41elJ8FWR6lSW2k
         24AlVBS2meU6lXtYLQ4l2pdoGCnijaU86kfQEBw+CnxXTZz9GU1ZTMpLKUDiwYESCAFS
         4jGA==
X-Gm-Message-State: AOAM531044oEMM18X8UTalTlAiI9FMyNY9pzBvOYpsivIYBqNmQnUXU0
        FNVpHIrOdFZo5d4bIVlH9geiHe9GNNqmS5ssCdYp
X-Google-Smtp-Source: ABdhPJy/fEwPHgMY8qBopGOJ4hRgGsQtMVsscaRQHzoXEr9/MQyR+AoEnoBhO2fgH/mnEywQJ6Cf0mS2whyde5siKDIH
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:98c3:: with SMTP id
 m3mr35230854ybo.116.1624301939918; Mon, 21 Jun 2021 11:58:59 -0700 (PDT)
Date:   Mon, 21 Jun 2021 11:58:58 -0700
In-Reply-To: <87fsxc47le.fsf@evledraar.gmail.com>
Message-Id: <20210621185858.1169385-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <87fsxc47le.fsf@evledraar.gmail.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: Re: [RFC PATCH 0/2] MVP implementation of remote-suggested hooks
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        sandals@crustytoothpaste.net, emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Wed, Jun 16 2021, Jonathan Tan wrote:
> 
> > This is a continuation of the work from [1]. That work described the
> > reasons, possible features, and possible workflows, but not the
> > implementation in detail. This patch set has an MVP implementation, and
> > my hope is that having a concrete implementation to look at makes it
> > easier to discuss matters of implementation.
> 
> My C on this RFC is:
> 
> 1) A request that someone reply (there or here would do) to my comments
>    on the last iteration of this at:
>    https://lore.kernel.org/git/874kghk906.fsf@evledraar.gmail.com/

OK - I'll take a look at that.

> 2) I think you'd get better feedback if you CC'd the people who've been
>   actively discussing this in previous rounds.

Good point.

> > Design choices:
> >
> >  1. Where should the suggested hooks be in the remote repo? A branch,
> >     a non-branch ref, a config? I think that a branch is best - it is
> >     relatively well-understood and any hooks there can be
> >     version-controlled (and its history is independent of the other
> >     branches).
> 
> First, unlike brian I don't (I hope I'm fairly summarizing his view
> here) disagree mostly or entirely with the existence of such a feature
> at all. I mean, I get the viewpoint that git shouldn't bless what
> amounts to an active RCE from the remote.
> 
> I just think that we could probably do a better job of it than what
> people are doing in practice, and I've seen people do stuff like have
> build systems setup permanent symlinks to git-hooks/<some-name> in the
> tracked dir. We could at least envision a git-native implementation
> asking the user "do you want this hook update? <shows diff>".
> 
> I just find this design approach completely bizarre as noted (probably
> in less blunt words) in the linked E-Mail.

That's fair. You suggest an alternative below (and maybe more in the
linked e-mail) - let's look at your suggestion...

> We have Emily's series to convert hooks to be config driven that we hope
> to land in some form, at that point they won't be any more of a special
> snowflake than any other config.
> 
> And then, instead of doing what I'd think would be the natural result of
> that: Simply supporting an in-repo top-level ".gitconfig" file. We're
> still going to seemingly forever have them be an even more special
> snowflake with this facility, and the reason seems to be mostly/entirely
> to do with working around some aspect or restriction of Google's
> internal infrastructure.

I don't think that this is "natural". In particular, I still don't think
that hooks should be tied to code revision. E.g. if we make commits
based on an old revision and push them, we still want them to follow the
latest requirements.

> I think it's just un-git-y to have a meta-branch that in some way drives
> not only all other branches, but all other revisions of all branches,
> ever.
> 
> It breaks expectations around git in lots of different ways, you can't
> fetch a single branch and get its hooks,

Are you saying that each branch should have its own hooks? That might be
reasonable in certain projects, but I don't see how that is a Git
expectation.

> you can't locally alter, commit
> and update your hooks while e.g. renaming a "t/" directory to "test/";
> your hooks and code can't be atomically changed).

I still think that hooks should work independent of code versions, so I
wouldn't think that atomicity here is important.

> I think I get why you want to do it that way, I just don't get why, as
> mostly noted in those earlier rounds why it wouldn't be a better
> approach / more straightforward / more git-y to:
> 
> 1. Work on getting hooks driven by config <this is happening with
>    Emily's series / my split-out "base" topic>
> 2. Have a facility to read an in-repo '.gitconfig'; have lots of safety
>    valves etc. around this, I suggested starting with a whitelist of the
>    N least dangerous config options, e.g. some diff viewing options, or
>    a suggested sendemail.to or whatever.

I've replied to this above.

> 3. Work our way up to trusting that for more dangerous stuff, eventually
>    hooks. Most of the legitimate concerns from others with this is
>    having some UX where our users won't be trained to just blindly say
>    "yes" to an alias/hook config that "rm -rf's /" or whatever.
> 
>    If we start experimenting with that with aliases or hooks that can
>    run arbitrary code it's like handing a toddlder a shotgun, let's at
>    least start with a sharp fork or something (less dangerous config) :)
> 
> 4. People who want this "I want my hooks to apply to all revisions ever"
>    could probably get 99% or 100% of what they want if their hook is
>    just a stub that does the equivalent of:
> 
>        sh `curl https://git.google.com/$reponame/hooks/$hookname`
> 
>    You'd then simply forbid on your servers any changes to a .gitconfig
>    that did anything with the hook.* namespace.

This would work if set in .git/config (not version controlled), but not
.gitconfig (version controlled).

> With such an implementation you don't need a magic
> "refs/remotes/origin/suggested-hooks" refs, just some state machine (I
> suggested e.g. GPG signing chains as an eventual end-state, but "show a
> diff every time" would also do) that keeps track of what config (and
> hooks are just one such case) has been OK'd, and which has not.

This sounds complicated.

> I'd think it would even work better in the Googleplex, you could clone a
> co-worker's branch and execute their hooks, since they're the same as
> what you've pre-approved,

In the presence of .gitconfig, how would you know?

> you could even clone some random person's fork
> of a "blessed" project, because the hooks would be the same `sh $(curl
> <url I already trust>)`. That validation could even be a system-level
> in-config hook on your laptop, thus bringing the whole thing full
> circle...

Same here.

In summary, I think your point of using hook configs + remote-suggested
configs instead of remote-suggested hooks is a reasonable one, but I
disagree with your reasons (or, at least, your reasons as I understand
them).
