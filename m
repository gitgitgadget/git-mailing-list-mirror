Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768F6C433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 18:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiKISbP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 13:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiKISbP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 13:31:15 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6023A388E
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 10:31:14 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-348608c1cd3so171791967b3.10
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 10:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DCOlG22RnM3KzNz4lPLm8rFV6eVZjHVFWRXriCoz5jk=;
        b=iGAKUqxyqU5criVElYg1TRU7lTJCaMWMtHYI7X/83nV347Km1jORNG3w44aMffDt77
         ab12TDyNYZxoLwFJZtWor3ya36KCHV6Y4A79aPLBJ0nrKGtX5gSb6PRVnL37Qwep8wlz
         iQg9DZSPYn0GsQyIlab3ARZ6Bqpi8ZSwKU65L/deGWr7plvZl1buDk32CgQ1e9tze0DI
         ARCqn1276sIQkT3yI3ldk3EgUfT0EKH+hfp06rFYiy+RaejIdBC71mndQg+Mw31OO3Pn
         pnE8dn4dmBKK5vvGW48RWZkEUgZYISg3z2sI82KPX9oM27OnfD0nXBO3xLps0PnC99zf
         RCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DCOlG22RnM3KzNz4lPLm8rFV6eVZjHVFWRXriCoz5jk=;
        b=yyMgHNNsn2hiQQN6HLiOdqDz6dkmquGdofZKZmqAc5xAFzOveKLwG36QWE8SlQfJDm
         dTpcV8bk8yfhYKipBrQBq2Gae3mLyQtaFWF0ZifLiTfZJJ2pUCkF3qt6F4UHtxYhLXay
         6mUKYLgtXAFYpCwLw5ZgOyczqEwX09oaVFUk8k+Ya2I7t8ypjDscjFVDQBlUPzsIJef5
         BRrqjwYYEPVhbYWvKieSq+z6BSiZ+uC1KiF9Y1AZtfdQGYG9kAzWFe7Q8+UTzCpZW6/v
         KBZNao7K6WrxtMmF9ZsklC8cX0Jr7m/LzjX44FZBDwKE3mM90WAHjlG59ywZrdwrgG+/
         eyMg==
X-Gm-Message-State: ACrzQf24L+SrE02M17FKpbB0gpgAP5TG0K/ADB4uU77o1b9zNrc/49Ca
        CtQoGkfYWurj1K8xprtUZX1uZqxlGb44ug==
X-Google-Smtp-Source: AMsMyM5XaLJRjgzLb+JVkHTEGBNMjOF7qvTHKNExzCScCkmogF64AJGMOXljR8Xm/p6bDRBTEp1jwIiM5yWzpw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a81:1353:0:b0:369:5ee:6656 with SMTP id
 80-20020a811353000000b0036905ee6656mr58803955ywt.194.1668018673660; Wed, 09
 Nov 2022 10:31:13 -0800 (PST)
Date:   Wed, 09 Nov 2022 10:31:05 -0800
In-Reply-To: <20221108214344.272053-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20221108214344.272053-1-jonathantanmy@google.com>
Message-ID: <kl6l8rkk3rpy.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH] submodule: explicitly specify on-demand upon push
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> Not having thought about this a lot, the behavior I might expect is
>> something along the lines of recursively pushing throughout the
>> submodule tree, stopping the recursion as soon as we get to a nested
>> submodule which says "don't push any of my children".
>> 
>> On the other hand, I could sympathize with a compelling argument that
>> the superproject alone should be in charge of determining what gets
>> pushed.
>> 
>> Though TBH, it seems like the former is more convincing. If I depend on
>> an external repository through a submodule, and that repository itself
>> has submodules, it would be nice to configure (once) that I don't want
>> to even try and push any of that repository's children.
>
> I just tried this and the behavior is reasonable except possibly for when
> push.recurseSubmodules=only is configured in a top-level submodule. Let's see
> if other people have something to say. For me, this would also be fine since we
> can just make sure that we don't configure "only" in top-level submodules that
> have their own nested submodules.

For this patch, I think what Jonathan has proposed is preferable because
that's close to what "git fetch" [1] does, i.e. when a superproject has
parsed a setting for "recurse into submodules" (from either the CLI or
config), it passes that value to its submodules via
"--recurse-submodules", overriding the submodule's config.

In the longer term though, I think neither "git fetch" nor "git push"
(as of this patch) gets it right. I think it should be closer to:

- If the user has passed a "--recurse-submodules" flag via the CLI,
  respect that in the superproject and all submodules regardless of
  nesting. (Make sure not to conflate config values with the CLI option
  in the way "git fetch" does today.)
- Otherwise, each submodule should respect their own config setting if
  it is set.
- Otherwise, each submodule should respect their superproject's config
  setting if it is set.

[1] "git fetch" is somewhat more complicated than this, since it also
  reads values from .gitmodules and passes a "default" value, neither of
  which is relevant here I think. See this ML thread for some previous
  discussion.
  https://lore.kernel.org/git/kl6lbkwa8h5n.fsf@chooglen-macbookpro.roam.corp.google.com/
