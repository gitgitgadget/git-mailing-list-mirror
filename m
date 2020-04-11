Return-Path: <SRS0=KYeX=53=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6E7C2D0EC
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 02:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E078C2083E
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 02:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDJiQqgo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgDKCqT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 22:46:19 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36304 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgDKCqT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 22:46:19 -0400
Received: by mail-ot1-f65.google.com with SMTP id l23so3634938otf.3
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 19:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nQJdPIk4EObuJ4ucKVp96f8LblAZ5NifMQVRCw8Fx1o=;
        b=GDJiQqgokRlCLwctDSm+SYWTiKK6VOv+cZmuV3u7NM50JBs4NHpHYKBLcnEqoXgh38
         YlCR1kkEjpU+Ewf15GRgbhZp5Jw1E2hSVidDpJXTa/0I2AnEh4tMaSxoVllZhTIwmQ2w
         cnOk3C/1WU1YPaxtnIclcI0ty3W815QA0NQ70bm3jbYomLSPIk7GSgHCSrt6hSFaigON
         vhnr2KYcdAj53kAkPKUH2rsgeEHy8a9ciWQHNKEAYmlW60ozFRLmcDt3UwDKj3Hp9dVw
         FaRl6Xi/tl5orJtF5tdGBXdSzo6VKN7R+gFsJDpVKLawYLQNJop/iAsR+LEtGz4kQfCZ
         AvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nQJdPIk4EObuJ4ucKVp96f8LblAZ5NifMQVRCw8Fx1o=;
        b=ooTFAmPrRcOgsGoTeEcXvRw9GAS1rVUCRZIH8CKURPB/rmJXuJ4hiS3BlOyjGTnMmd
         VExuqx3vQVXWvl10RaxNkDFJl42R0pNP0Z0ASLy3ndTGF0Uqh2Ni9fZoBkm3jdb4jz03
         cC7Zqoh5rV+BCDo2+/DE2RLFNOeqtSugaltuPbL/mnIgb67yEAhvh2K8us3mZe9kcSuO
         IvOO8RoFKebYbCNq+azJSmsysgYR3XRcO3c05wHA3LCkbggNXxx4SLsVGiuQYkFnrqFF
         QilOhuPHuahvKpwLwjjAzkJvc8AUOiZdNjGu91I3l5bwgolrJZaxfgRjoAPbvdUgaAZb
         h8mQ==
X-Gm-Message-State: AGi0PuaTFyeIKwD0iqDfNgbkribS5X0R/M7wXdMmOY7QDet/EI3jvxEy
        M7lpPcgVeR6qiZFZgTTrnn5mnRz2uZ/8JrJTi+Y=
X-Google-Smtp-Source: APiQypKT8AWWrGMnM/udO11BTagRT3wHHOflz8N3uNVn/yYdbh4dvVlVdDynlK4jFnwRq8jN3RT109fGQL5Z0ltE+TM=
X-Received: by 2002:a9d:5e0d:: with SMTP id d13mr6517106oti.162.1586573178669;
 Fri, 10 Apr 2020 19:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BFEtd9X1XJwwpJ2YP6a4Zyc_yevwnMfNA+Dr45p4-7YEA@mail.gmail.com>
 <20200411011152.115895-1-jonathantanmy@google.com>
In-Reply-To: <20200411011152.115895-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 10 Apr 2020 19:46:07 -0700
Message-ID: <CABPp-BFQSZeeM-WNQi0vFzX_1M099yfHrHcAEoQOHgg8TvnjWg@mail.gmail.com>
Subject: Re: [PATCH v3] rebase --merge: optionally skip upstreamed commits
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>, congdanhqx@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 10, 2020 at 6:11 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > >   Reapply all clean cherry-picks of any upstream commit instead of
> > >   dropping them. (If these commits then become empty after rebasing,
> > >   because they contain a subset of already upstream changes, the
> > >   behavior towards them is controlled by the `--empty` flag.)
> >
> > Perhaps add "preemptively" in there, so that it reads "...instead of
> > preemptively dropping them..."?
>
> Sounds good. Yes I can do this.
>
> > > If this works, I'll send out a new version containing Elijah's patches
> > > and mine in whatever branch my patch shows up in [1].
> > >
> > > [1] https://lore.kernel.org/git/xmqqd08fhvx5.fsf@gitster.c.googlers.com/
> >
> > Yeah, I was making changes to this exact same area in my series to
> > reference your flags.[2]
> >
> > [2] https://lore.kernel.org/git/e15c599c874956f1a297424c68fe28e04c71807b.1586541094.git.gitgitgadget@gmail.com/
> >
> > Would you mind if I took your proposed changes, put them in your
> > patch, and then rebased your patch on top of my series and touched up
> > the wording in the manpage to have the options reference each other?
>
> Go ahead! Thanks.

Cool, please double check that I made the changes as you expected:

https://lore.kernel.org/git/20d3a50f5a4bf91223c1b849d91e790683d70d66.1586573068.git.gitgitgadget@gmail.com/

> > > > Why not just list --keep-cherry-pick[s] in the list of options that
> > > > require use of the merge backend (i.e. the list containing '--merge')
> > > > instead of adding another sentence here?
> > >
> > > My reading of the list containing "--merge" is that they *trigger* the
> > > merge backend, not require the merge backend. My new option requires but
> > > does not trigger it (unless we want to change it to do so, which I'm
> > > fine with).
> >
> > Interesting; what part of the man page comes across that way?  That
> > may just be poor wording.
>
> "--merge" is documented as "Use merging strategies to rebase", which I
> interpret as triggering the merge backend. There are other things in the
> list like "--strategy" and "--interactive", which seem to be things that
> trigger the merge backend too, so I concluded that the list is about
> triggering the merge backend, not requiring it.
>
> > However, if an option requires a certain backend, is there a reason
> > why we would want to require the user to manually specify that backend
> > for their chosen option to work?  We know exactly which backend they
> > need, so we could just trigger it.  For every other case in rebase I
> > can think of, whenever a certain backend was required for an option we
> > always made the option trigger that backend (or throw an error if a
> > different backend had already been requested).
>
> I guess I wanted to leave open the option to have the same feature in
> the "apply" (formerly "am") backend. The use cases I am thinking of
> won't need that in the near future (for partial clone to make use of it
> in the "apply" backend, the "apply" backend would have to be further
> improved to batch fetching of missing blobs), though, so it might be
> best to just require and trigger "merge" (like the other cases you
> mention). I'll do that in the next version.

Putting them in the list doesn't mean that they're designed to only
work with one backend, just a reflection of what the current
requirements/incompatibilities are.  We've removed things from the
list before when we implemented it in the other backend(s).
