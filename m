Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D36EB64DA
	for <git@archiver.kernel.org>; Sun,  9 Jul 2023 02:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjGIBzr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jul 2023 21:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGIBzq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2023 21:55:46 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C26E48
        for <git@vger.kernel.org>; Sat,  8 Jul 2023 18:55:44 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-c80aeecb6d0so5844276.0
        for <git@vger.kernel.org>; Sat, 08 Jul 2023 18:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688867744; x=1691459744;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=ya/KcaBQLN0nU6smGdQ/9p5mPnnwnL+pyVqNP5kYKGc=;
        b=QybNm3p+Mtiz2YN4USnGa0KmWzHPdrF8IakVGNYXFDVmUXNWeMoatPgA1MWPUMupui
         qw8yKWF71AHIhjy6rxeP9UFdeoDkO0zdG6GG58fMtYxryG6mo6ObcceuQz+HO7jQEBPN
         nEFq9p3ABv+bxKwSsfd1AW/uiDgFU4foo3Nvq6dIiEiA7D/ZqeBLX6dZop3Dy95JcaUg
         fJ5UbV3DTWq6qcM9Dl4MgVLAGjiPhTHuLtQneiYZtqU1N4YzMqdrAkbFyBR2bkeygRrs
         Sz+VMjt4L0vkNbYxB6gVPrERB+oWzeEKYdVdmCzBr+Q3ivliBnvrYUrJRjavC6pZoppL
         9nmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688867744; x=1691459744;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ya/KcaBQLN0nU6smGdQ/9p5mPnnwnL+pyVqNP5kYKGc=;
        b=fbGEOw7d/UNFW+5fbVrsYrmsRtD4OAxNAj1nJatrR29YMjHmW4EZVZUrM6ATkECtNE
         RrGbBx8wpYIRc7Rhyd5UWw28LqU+LdRzKjQUSSoUj9CDr9H4dQ+cDTzx0nNLCoR1ijUB
         ofbfbw6LRYD3pkFjAeppinXHrvO0qZk57ydq8FfECO58mIpe1WextwtPUd+321vv8Izr
         GbTo9GC1Ae+5RAATQKqDTnWeOgwonZesUPQQDmt5uBgWJokqCc49Wu/VLvm/U6Fhlpcr
         2uH8rFAdSlSM3NKSlZuT0dv/lknGjNPRFwKtTbjaFQwuP0bgmYO/XEqBmq9xaxfoWGJa
         mntg==
X-Gm-Message-State: ABy/qLbOD9cm5iiPW/cpPBpTCACn/VsKFlkW3+QDyJLluEQ5k/5oftSs
        /vyyyVDOmFcrni3LfZ3fxGYD7xBhIZc=
X-Google-Smtp-Source: APBJJlFfjkPh3Bd5FfjWw1CCOoVrxjxeDzbB++7QInxyS3+6GOjl/8pr44UfrNm7Kgz2Q06+V50AFw==
X-Received: by 2002:a81:1e92:0:b0:56c:e486:3386 with SMTP id e140-20020a811e92000000b0056ce4863386mr4667553ywe.0.1688867743643;
        Sat, 08 Jul 2023 18:55:43 -0700 (PDT)
Received: from epic96565.epic.com ([2620:72:0:6480::7f])
        by smtp.gmail.com with ESMTPSA id k128-20020a0dc886000000b00569ff2d94f6sm2169303ywd.19.2023.07.08.18.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 18:55:43 -0700 (PDT)
References: <DS7PR01MB758914BD44E20CF8185B7C5BF64B9@DS7PR01MB7589.prod.exchangelabs.com>
User-agent: mu4e 1.11.1; emacs 29.0.91
From:   Sean Allred <allred.sean@gmail.com>
To:     "Mor, Gil (DXC Luxoft)" <gil.mor@dxc.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git monorepo - recommendation regarding usage of sparse-checkout
Date:   Sat, 08 Jul 2023 20:44:06 -0500
In-reply-to: <DS7PR01MB758914BD44E20CF8185B7C5BF64B9@DS7PR01MB7589.prod.exchangelabs.com>
Message-ID: <m0a5w5etlu.fsf@epic96565.epic.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


"Mor, Gil (DXC Luxoft)" <gil.mor@dxc.com> writes:
> Hello, we are experimenting with migrating a large-ish code base from
> SVN to a Git Monorepo and it would help us if we can get some input
> regarding the usage of sparse-checkout.

We're in the same boat. I haven't been able to keep up with the list as
well as I would like, but I can share our experience so far. We're
writing developer tooling for a team of ~2k devs.

> From our timing experiments sparse-checkout is the only method so far
> that reduces our times to good results.

You should also look into sparse-index.

> The only issue might be the Disclaimer that the sparse-checkout
> feature is experimental, and that the behavior will change.

It seems vanishingly unlikely that the feature will go away at this
point (even if the CLI changes). We have automated integration tests set
up for our automation and have near-term plans to start running those
against `git.git:main` and `git.git:next`. This way, we'll get advance
notice if something we're relying on starts breaking.

> The command is already featured in GitHub and GitLab articles about
> reducing Monorepos size but we are still not sure how un/stable the
> feature is or how commonly used the feature is already.

We haven't encountered many issues with stability. There was one issue
a few months back where the pattern syntax changed, but as I recall that
was more of a problem with one of our developers going off the beaten
path and trying to write to GIT_DIR directly instead of using `git
sparse-checkout set` or similar.

> So, we thought we'll write an email to see if we can get a bit more
> nuanced answer about the safety of real-world usage so that we can
> make an informed decision whether or not to start using
> sparse-checkout, despite it being experimental.

One of the goals of our tooling is to teach people how to actually use
Git (i.e., use our tooling to automate the boring stuff -- not to
replace Git itself). To meet this goal, we're using the more 'ergonomic'
git-switch command instead of git-checkout. In our case, as long as we
can react to changes in git-switch syntax (which we haven't seen since
the project started a few years ago) and as long as we can get the same
side-effects, we'll be fine. This comfort is largely driven by the
existence of integration tests.

> We are not looking for 100% assurance, we know the responsibility is
> eventually totally ours and there are no guarantees, but it seems like
> a game changer so we are just looking for a bit more information so
> that we can make a decision.

Sparse checkout is not a silver bullet, but it does make a difference.
We still see commits take several seconds on Windows (even with sparse
index). This is *several orders of magnitude* better than SVN on our
repository (where naive commits on top-level folders can take tens of
minutes), but it's not what folks are going to be expecting from Git. In
the long-term, we're looking at what would be involved in splitting up
our monorepo and seeing whether the rewards really outweigh the costs
(both of which reach far beyond source control).

Best of luck!

--
Sean Allred
