Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91BCC4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 16:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86D7A60E98
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 16:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhGWQOb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 12:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbhGWQOa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 12:14:30 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B01AC0613CF
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 09:55:00 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id a19so2478217oiw.6
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 09:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=QZN1LROnfhFaw/hFBEtWFMCTe2EriNB/J08TmpKHeUQ=;
        b=gfteiIHZ1ATYRajjFQsHkk1IOQqYirfubWnIyYrP9/u54B8c8D/AA76j1RKME0l0BD
         ArXCGpxBTzy8sn5v/R4f8Dfk37Up6NJM366CgnWxXXkbfZ+1+/bjQsMCK1j7YvTDd8Zn
         5ph21PtWsQUqnKuLRBHivyBCKeCAXv1ZBdIt/J7d5ZZtG6JD5ZXKkExls4dxHmRpTTUL
         uBlaEvoELv190EyzqMxiAKpw1cTBssZqjDuHDHHJWU1ULI2EjAvy3IcYjDoamBqIfWbh
         1vhuvuMzYoBylM+JsWDgK93hZvbWLG2kJ8zRpMZwqpZi0im4iBweFHXdjQDBsZ7h0PQv
         3ZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=QZN1LROnfhFaw/hFBEtWFMCTe2EriNB/J08TmpKHeUQ=;
        b=Txk/lsDcKIpSLVPUxOFxNqeZANe6X1V44e1jfNHSyiSsdZGAzSEE6h0FUcv9mnUsEu
         zlAAblj4pimguB9SYJsnLU5ZdILOVantRiezc7+5QKAwIOeYh8d4ImD8UytH2ez1kXN1
         qnfNWqKC/+UQyfYK87Vdsh/bZrY1haAmEBobZ1QUS7LBuajk5A2HR44rza3ZWu/y1njY
         qX1/f0fvulTLLpv/U6UmEKHaWFUNJWyD/Yx2gd/uvfTh1ss33SVgcSU1ZvLBdvcJ0yE9
         /23jkeDW/Exqxh5/rAQtQ58A8prRGdQ+1Afqjo6hbHIaBEjRNrRgTmPq1F0PeejxeXrm
         LhTw==
X-Gm-Message-State: AOAM533FFU9yfmQOyHgaSE2GtwXVt8EUpQ69YNrT8uLwKqv0KINEBUWn
        NPcHGyXR+Ems/hln9gIWh7M=
X-Google-Smtp-Source: ABdhPJwmEYmpluIcokNpSOyRDAWDA3e9r1lAtIxP0dWuGDwh1R/Qc7VGpWGtSHSMYIJzZyGggjnxBQ==
X-Received: by 2002:aca:1c17:: with SMTP id c23mr9143541oic.75.1627059298946;
        Fri, 23 Jul 2021 09:54:58 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id y19sm6001504oia.22.2021.07.23.09.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 09:54:58 -0700 (PDT)
Date:   Fri, 23 Jul 2021 11:54:57 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Alex Henrie <alexhenrie24@gmail.com>,
        Marc Branchaud <marcnarc@xiplink.com>,
        Elijah Newren <newren@gmail.com>,
        Stephen Haberman <stephen@exigencecorp.com>
Message-ID: <60faf46153f62_defb208aa@natae.notmuch>
In-Reply-To: <9cb70776-8684-9d1e-e4c5-188c6c19fdc7@iee.email>
References: <20210721221545.1878514-1-felipe.contreras@gmail.com>
 <xmqqy29z9r94.fsf@gitster.g>
 <xmqqtukn9p0g.fsf@gitster.g>
 <60f8c8c92a215_1d0abb20859@natae.notmuch>
 <YPpwIazVxL4GoLbC@coredump.intra.peff.net>
 <9cb70776-8684-9d1e-e4c5-188c6c19fdc7@iee.email>
Subject: Re: [PATCH] doc: pull: fix rebase=false documentation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley wrote:
> On 23/07/2021 08:30, Jeff King wrote:
> > On Wed, Jul 21, 2021 at 08:24:25PM -0500, Felipe Contreras wrote:
> >
> >> I'm not trashing the current behavior, I'm explaining what the consensus
> >> is. I spent several man-days re-reading old threads, and this is the
> >> consensus of what should happen:
> >>
> >>   1. git pull              # merge HEAD into upstream
> >>   2. git pull origin topic # merge topic into HEAD
> >>
> >> Of the people that expressed an opinion, 100% of them stated that what
> >> `git pull` does in the first case today is not desirable.
> > I did not participate in the threads you linked earlier, so I am
> > probably not in that 100%. But you did use my name below:
> >
> >> Yes, you are correct that if *everyone* followed the topic branch
> >> workflow, everything would work correctly, but that's not what happens
> >> in reality, in reality people do all kinds of workflows, and wrong
> >> merges are pervasive.
> >>
> >> Everyone--including Linus, Jeff, and you--agree that there's two
> >> different ways of using `git pull`: integrator versus developer.
> >>
> >> When a user is doing `git pull` to synchronize changes to push to the
> >> same branch, that's a centralized two-way workflow, so he is acting both
> >> as an integrator and as a developer, and it's in that particular case
> >> that the order of the parents should be reversed. Everyone agrees on
> >> that.
> >>
> >> When the user the opposite explicitely: `git pull origin master`
> >> Linus calls it a "back-merge" [1], and in that case the order of the
> >> parents should not be reversed.
> > So I feel compelled to say now that I do not think that changing the
> > order of parents for "git pull" is the obviously correct thing to do.
> While I never `pull` because it's not right for me as a 'contributor', I
> do agree that the default 'maintainer' view of `pull` will need to be
> retained for long term backward compatibility.

Of course, but a maintainer never does `git pull` to merge a pull request,
she does `git pull github/john topic`, does she not?

Nobody was in favor of reversing the parents in the case of
`git pull $where $what`, that would be the wrong thing to do.

So the maintainer view of `git pull` would remain fine.

> What I have rarely seen in the discussion is explanation that is based
> on workflow style, though the potential `update` command (1) may break
> some of the deadlock about the direction of 'pull requests', and
> possibly confusion regarding the location of the 'golden' publish repo.

I think that's because most of the people that follow a workflow don't
have this problem.

It's only newcomers that don't follow any workflow that are hit by this.
Another name for this no-workflow is trunk-based development [1].
Essentially everyone pulls and pushes to the same branch.

People that use topic branches don't need `git update`, people who
follow trunk-based development do.

> (1) there are a lot of 'update' commands floating about, esp on Git for
> Windows. If there is a suitably named `update` command to do the `pull
> --contributor` merge-ff swap then many of the issues could fade away.

Indeed. And at least when I was maintaining my git-fc fork, people did
enjoy my implementation of `git update`.

[1] https://trunkbaseddevelopment.com/

-- 
Felipe Contreras
