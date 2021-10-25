Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C6FC433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 18:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD23A60F6F
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 18:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbhJYS4Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 14:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbhJYS4X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 14:56:23 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85A1C061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 11:54:00 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id m74-20020a633f4d000000b0029fed7e61f9so6764035pga.16
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 11:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NoQltj5erG7YaCH0xZadoo+fOEw6mzSG34Sre6wbLBA=;
        b=OZErkXbCxLtuKmJ3SmgG5iNp6leQ7cPAiTCs+LDoLOEtVcRPy5uZ6qahgiJrOMmfYW
         4Ttu/8q/gVQgIaaH/NzmDlkJwmlImRq4KOcYXUdUj0m7rtk7LTwWydKlMZ4+Our1FTrs
         /glbTqOL+dwTgYLptNvuooSC+rFp9nbZZ9i1SkFvcSsjJyZ5sY4C+S27ctk64Vo/kDgm
         yCUroOdxJCKvCDc6p7/ysV5Y/T4gZqR/KKEOlpdd5NcugHyNtxnZ+5XP3SQaWmwx62Th
         HKSnL/XjbeOhv44DF5EzDb/wj+lAo26ZVdNQJijqA7EiwMbQKrWO/XsZS3PWqY2Db4SP
         K0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NoQltj5erG7YaCH0xZadoo+fOEw6mzSG34Sre6wbLBA=;
        b=uq/KdA6bGG76FgI/35XoPsfuOz/HFaMgMPLqPuCTjXh07UzOFE9Ym7MoYdSsNJWlHl
         cPbI6snhksAZbLJ/9FsgXrlhZsBzA7+emgOUL4gFqiU1hlPafl8bmSnO6lsKzrL/n/bh
         EXkZjatJFsM8Y1W/FFGl+hsYEFMrnJpHr2xLRMg4y7WzkF2+OIJuJCjPAUehMmydNPjh
         JSD/L8OheEYX7Pfu5jj9P/3vHmEpUeyfVrZUtydVIaDAKDQMbobvEyZk0vb2BOqjM/Cg
         OJo4jJC3AWvsTBLFNEBoTigw4sU8vJp0qOQUdhkdAqWyKx4eG+TzdQ2t9WMkT9EIRA5L
         NEcg==
X-Gm-Message-State: AOAM532Cld4P+301ZOyUjjmfcmgVwZirJ82exZRQs5gGIIRVFo/pkuVZ
        4VczK/5nDv33EEkhUWq8YS2lQw4emkCWZkqOaU8I
X-Google-Smtp-Source: ABdhPJw6pxL0E5zIXtLEGEx7Utj3uJtP7n1uT4fAAZ7pa5AjPPtZbfuA/uW0YEDBmvhI4mzkqZYjDZ61CzgxUVsMqKvd
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:758c:b0:141:4c99:22b3 with
 SMTP id j12-20020a170902758c00b001414c9922b3mr847694pll.40.1635188040006;
 Mon, 25 Oct 2021 11:54:00 -0700 (PDT)
Date:   Mon, 25 Oct 2021 11:53:56 -0700
In-Reply-To: <211025.86lf2hgsmj.gmgdl@evledraar.gmail.com>
Message-Id: <20211025185356.1232635-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <211025.86lf2hgsmj.gmgdl@evledraar.gmail.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: Re: [RFC PATCH 0/2] Conditional config includes based on remote URL
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I had some concerns about the specifics of the implementation/what
> seemed to be tailoring it a bit too closely to one use-case[1][2], not
> inherently with the idea (although I think e.g. for brian that more
> closely reflects his thoughts).
> 
> Anyway, just saying that aside from this RFC I don't think we were at
> the point of really fleshing out what this would look like, and there
> being some hard "no", so I think that idea could still be pursued.

Which idea specifically do you think could still be pursued?

> On this proposal: this also applies globally to all history, but I don't
> have the same concern with that as the 1=1 mapping of remote-suggested
> hooks, our path includes work that way, after all.
> 
> I think it would be nice if you could think about if/how this and the
> "onbranch" include would work together though to serve the general case
> better.
> 
> Also if you have a repo with N remotes each where "origin" tracks URLs
> at git.example.com, and you add a "dev" tracking dev.example.com, will
> the config apply if you're say on a branch tracking the "live" server,
> if you've said "include this for repos matching dev.example.com?

Right now, the feature is only dependent on remote URLs configured
through remote.?.url. It wouldn't work with "onbranch" because there's
no way to combine conditions (and I have no plans to do that). I think
that if you have something that you want depending on which branch
you're on, you can just use the existing "onbranch" feature.

> Arguably that's what you want, but perhaps something that those more
> used to the centralized workflows wouldn't consider as being unintuitive
> for users who might want to add this config only for their main "origin"
> remote. We don't really have a way of marking that special-ness though,
> except maybe checkout.defaultRemote.

What do you mean by adding a config for a specific remote?

> I'm also still somewhat mystified at how this would better serve your
> userbase than the path-based included, i.e. the selling point of the
> remote-suggested configuration was that it would Just Work.
> 
> But for this the users would either need to setup the config themselves
> for your remote, but that would be easier than pro-actively cloning in
> "work" or whatever? I guess, just wondering if I'm missing something.
> 
> Or if it's a partly-automated system where some automation is dropping
> in a /etc/gitconfig.d/google-remote-config-include 

Yes, the config is meant to be handled e.g. through a package manager
like apt. We don't want to prescribe directory structures like "work",
which is why the include is conditional upon the remote URL.

Even if the user pro-actively clones into "work", the user still needs
to set up the conditional config, so I don't see how that is a net
benefit.

> I wonder if this
> whole thing wouldn't be better for users with such special-needs if we
> just supported an "early config hook".
> 
> i.e. similar to how we read trace2 config from /etc/gitconfig early, we
> could start picking up a hook that just so happens to conform to the
> config schema Emily's config-based hooks use.
> 
> So the /etc/gitconfig would have say:
> 
>     hook.ourConfigThingy.command=/usr/bin/googly-git-config
>     hook.ourConfigThingy.event=include-config
> 
> That hook would just produce a config snippet to be included on STDOUT.
> 
> Since it's an arbitrary external command it would nicely get around any
> chicken and egg problems in git itself, it could run "git remote -v",
> inspect the equivalent of an "onbranch" etc. etc, then just dynamically
> produce config-to-be-included.

I see that later on, you suggest an environment variable to guard
against recursion.

One thing is that if there are multiple such hooks, each one won't be
able to see what the other hooks have produced.

If the feature you described already existed in Git, I think I could use
that, but if we're deciding between implementing the config hook you
describe versus something with more constraints, I think the one I
proposed is better for now. Some design points that have already been
discussed are whether setting a config during processing of an included
file would then invalidate the include and also the order of operations,
both of which would be much more difficult to control with config hooks.

> Please don't take this as some objection to your current proposal, just
> a thought on something that might entirely bypass odd edge cases and
> arbitrary limitations associated with doing this all in the "main"
> process on-the-fly.
> 
> The special-ness with that one would need to be that we'd say it
> wouldn't have the normal "last set wins" semantics, or maybe we could do
> that and just note that we saw it, and execute the "include" when we
> detect the end of the full config parsing (I'm not familiar enough with
> those bits to say where that is).

The "last set" would be those set by the hooks, so yes, a user would
need to know to make their own hook in order to override anything set by
the hooks. The end of the full config parsing is in
config_with_options().

> Both of those seem easier than dealing with any chicken & egg problems
> in parsing the config stream itself, since such a hook could just invoke
> "git remote -v" and the like itself, after e.g. setting some environment
> variable of its own to guard against its own recursion (or we'd do it
> for it for such hooks...).
> 
> 1. https://lore.kernel.org/git/87k0mn2dd3.fsf@evledraar.gmail.com/
> 2. https://lore.kernel.org/git/87o8awvglr.fsf@evledraar.gmail.com/
