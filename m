Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C97C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 074E860F6E
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbhG0Vjt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 17:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhG0Vjt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 17:39:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3252C061757
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:39:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a188-20020a25cac50000b029055d47682463so310048ybg.5
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=K1bRC2+LOefwFkFJRcppl/0vOR3VPr26qlq5Z4E57SE=;
        b=fEWu3j3Mcbv/5eC3BGoMzll7P/l7uFtZca3gj8xWf0IKBuP5bDBs5vjGEQQZ8uW3+X
         EiRUXICmjm6W2FESO2JDpMLjtdgzh9CsXQBbJrDg6HdPt39OE0n+dDLL2IO80HiqPRmr
         vtpqqz+ChVppuadtSE082/MOt7irArYUOXCq1RwCOeMx5Hh4N24tXdnfTkdbXdXnK75g
         g+lE+G9rT3pCP3o4lYTvaHKUyzU98crf5ppHIPZ+9vhjj1reDn1Vos171DQWIhOTFvBi
         rrXE9mI6oDEyz9gPGDQAnyd9wE55k2eK1aBbajL/0o1mdU9OJLzOoloTbpBlSLaNBZq0
         tmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=K1bRC2+LOefwFkFJRcppl/0vOR3VPr26qlq5Z4E57SE=;
        b=gGmzUgZ3FTrKQGR6tufsCJgmJFnyXmG95tlMaDiBmDx+fU1/o3TCY4RrunBWsCIlo0
         Uvg65Afzt7uIV0Bvn6s8q+zRgkdfZRGGn3kOFEAcTn/6XdE05QvcI8RdtJy4BZQ9wQdD
         LKdzgO7uxvh2MibFwcjNd7nZKf5CHbq+Srp3nTn3rqRsW1sgfUl3plzCM25KbLn7Iikh
         BUe1nrRfkAzbIQczlYlHv1uJGptFTJ9lp4PPyvpQymYnBU88Zn3U3zsuXKVwyLOs7WPT
         lJXjXbn9ZcRvDvT9PS7ZdTZf4CWNMErvIDNruclaZVtj7+V9G0to0dkAEXVEdM8+gARe
         WySQ==
X-Gm-Message-State: AOAM532XeTcxgCDObk6NrcGi7pM19361MxxvJ3onmytk8D5T0ASqJJJo
        fwWKl0S1VEXl//audN51IEx8QKqGaOvLx8mIGuji
X-Google-Smtp-Source: ABdhPJxpiQ30j6CspIFbNe/t232vbhZlfM2gxdlmFu47x0RLyFNDgd+Bf/VglfWK1KFDt0ztBj9Uo8Eg8y0Z71rMXAPn
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:81ca:: with SMTP id
 n10mr34789346ybm.164.1627421987872; Tue, 27 Jul 2021 14:39:47 -0700 (PDT)
Date:   Tue, 27 Jul 2021 14:39:42 -0700
In-Reply-To: <xmqqczr4fsso.fsf@gitster.g>
Message-Id: <20210727213942.2574308-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqczr4fsso.fsf@gitster.g>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: Re: [RFC PATCH v2 2/2] hook: remote-suggested hooks
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     emilyshaffer@google.com, jonathantanmy@google.com,
        avarab@gmail.com, git@vger.kernel.org, iankaz@google.com,
        sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Emily Shaffer <emilyshaffer@google.com> writes:
>=20
> > I think this is a pretty important point. To me, the ideal flow looks
> > like this:
> >
> >  - I clone some repo, planning to just use the source code. I ignore th=
e
> >    hook prompt.
> >  - I notice some bug which is within my power to fix. I have forgotten
> >    about the hook prompt, because I was having so much fun using the
> >    source code in the repo.
> >  - I 'git commit' - and 'git commit' says, "Did you know this repo
> >    suggests installing a commit-msg hook? You can install it by running
> >    'git hook install pre-commit' and run it by running 'git commit
> >    --amend --no-edit'. You can audit the commit-msg hook by running 'gi=
t
> >    hook magic-audit-command-name-tbd'. You can hide this advice <typica=
l
> >    advice-hiding advice here>."
>=20
> Devil's advocate in me says that delaying this until the last
> possible moment will make people *not* look at the hook's contents
> and just say "yes".  After all, you have been working on a task and
> reached one milestone (i.e. you are now ready to say "commit"), and
> you want to start recording your thought process before it slips
> away from your mind.  To many of us non-multi-tasking types, it is
> one of the worst moment to force switching our attention to a
> secondary task of vetting project supplied hooks---rather, I'd say
> "Oh, I work for project X and if these hooks are supplied by project
> X, it is good enough for them, and it must be good enough for me".

I think both "I want to vet" and "good enough for project X is good
enough for me" are both reasonable points of view, and this
remote-suggested hook scheme supports both.

> > MOTD approach also makes it hard to *update* hooks when the maintainer
> > so recommends - would be nice to have something baked in to notice when
> > there are new changes to the hooks, so we hopefully don't have
> > developers running hook implementations correlating to the date they
> > most recently cloned the project.
>=20
> Interesting.  Every time you run "git commit", the command will
> check the existence of remotes/origin/suggested-hooks, compares the
> installed .git/hooks/pre-commit with a blob in the tree stored
> there, and tells you to update if they are different?  Or perhaps
> the installed hooks record from which blob their contents came from,
> and perform a three-way content level merge to carry local changes
> forward?

We do notice when there are new changes, but only during fetch.=20

I don't think we should compare the installed .git/hooks/pre-commit with
remotes/origin/suggested-hooks (since the user may have locally modified
that hook), so a solution involving storing the OID of the installed
hook somewhere (I haven't figured out where, though) and comparing that
OID against remotes/origin/suggested-hooks would be reasonable and would
be compatible with the current approach (as opposed to the one which
=C3=86var describes which, if I understand it correctly, would require
"commit" to access the network to figure out if the hook the client has
is the latest one).
