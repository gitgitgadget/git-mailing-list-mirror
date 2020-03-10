Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A15C10F27
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 15:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD59E215A4
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 15:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GJ4SZntg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgCJPvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 11:51:11 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:55912 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgCJPvL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 11:51:11 -0400
Received: by mail-pf1-f202.google.com with SMTP id 78so6712792pfy.22
        for <git@vger.kernel.org>; Tue, 10 Mar 2020 08:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gS8wFFZVunfr5BqQCfGwvNbrN/FeHhXIGbu4aXXW4MU=;
        b=GJ4SZntg9H3vdVCdmcYrz5j/YlnBlVPV/GG/YobVolyo+Oz+PHXYWzFUjNKq+CZGGB
         4LAmnrdFQTuBNMJ4V49lHje9xzvZyDfXQ8BmFWardX7+53pp1MGFJFXUSMuOIPMRAOG1
         vuR8V52PUd5QSfBQJDTeGG0N9LWFJtmskxqnmorDT7d8SQvy0iUZuiOWOQnaieH/LMZd
         lfZq5hAlfIUbWHdHz6O7hILIg69i4JxEp5ENAIK67gLjJcR+yfbrNZQ9Vmk14TLECxm0
         Ko7/D3FWKlQaA19TGqzIhxETKOOBwcvjYUnEyGhaTHFSWzCHffzm/pWE5adNvX+npRTE
         wQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gS8wFFZVunfr5BqQCfGwvNbrN/FeHhXIGbu4aXXW4MU=;
        b=YXy7GqMBR/xbjmCtWjZstS329PPpjew/TkcvBKZpAqyjiYXJLmdQVbIW9Xl1AayxaM
         u/hi73LKiGrBKd/uBUH4pZh2HqT+dOq+s2bbgUpKxXcgKQPAsXNKFwAnggiab2eYaJd1
         MgrxMV/GkN0fwCWbyyLbGu7AKrnxAu/kOXR7VORbn/VeRG2Z0O476zlTcaokj81/RmPr
         ZamPxfEDDzsxowkACNlGCjxgqDZLeniShBCq967PJQ5m9KuFHv6Sc4rBzhQP6NSMA7/D
         Dz8lwzOlMfFtptxoGDufendASMC2G8FXX3B7fdxf1rU5UiPv63RylHT5TIGzi5Mt2p7u
         ueVQ==
X-Gm-Message-State: ANhLgQ0eckJ1+dlvR2N+V4gtTnUcmYNu52YVvQU5Xucq8+UHRBbRgNck
        Xg52lmcZoOZI4RqZDDHBgCvLXAltCvst9XqrKG+G
X-Google-Smtp-Source: ADFU+vuR9N0Z+WJjrDDQ+t4rLkz3oD5jQyZ2fbRHUzzIQZGzo7QI1clmqTcwthZymuUTncV5vGSAi/i39GcMV8HCJkaP
X-Received: by 2002:a17:90a:9501:: with SMTP id t1mr2446199pjo.108.1583855468912;
 Tue, 10 Mar 2020 08:51:08 -0700 (PDT)
Date:   Tue, 10 Mar 2020 08:51:05 -0700
In-Reply-To: <20200310021015.GC42010@syl.local>
Message-Id: <20200310155105.18184-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200310021015.GC42010@syl.local>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: Re: [PATCH] rebase --merge: optionally skip upstreamed commits
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, stolee@gmail.com,
        git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Hi Jonathan,
> 
> This patch makes good sense to me. I left a few notes below, but they
> are relatively minor, and this seems to be all in a good direction.
> 
> As a (somewhat) interesting aside, this feature would be useful to me
> outside of partial clones, since I often have this workflow in my local
> development wherein 'git rebase' spends quite a bit of time comparing
> patches on my branch to everything new upstream.

Thanks for your review, and it's great to know of a use case that this
helps.

> This sentence is a little confusing if you skip over the graph, since it
> reads: "When rebasing against an because ... because ...". It may be
> clearer if you swap the order of the last two clauses to instead be:
> 
>   it must read the contents of every novel upstream commit, in addition to
>   the tip of the upstream and the merge base, because "git rebase"
>   attempts to exclude commits that are duplicates of upstream ones.

Sounds good; will do.

> > +--skip-already-present::
> > +--no-skip-already-present::
> > +	Skip commits that are already present in the new upstream.
> > +	This is the default.
> 
> I believe that you mean '--skip-already-present' is the default, here,
> but the placement makes it ambiguous, since it is in a paragraph with a
> header that contains both the positive and negated version of this flag.
> 
> Maybe this could changed to: s/This/--skip-already-present/'.

Will do.

> >  In that case, the fix is easy because 'git rebase' knows to skip
> > -changes that are already present in the new upstream.  So if you say
> > +changes that are already present in the new upstream (unless
> > +`--no-skip-already-present` is given). So if you say
> 
> Extremely minor nit: there is a whitespace change on this line where the
> original has two spaces between the '.' and 'So', and the new version
> has only one.

OK - I'll change it to 2 spaces.

> > diff --git a/sequencer.h b/sequencer.h
> > index 393571e89a..39bb12f624 100644
> > --- a/sequencer.h
> > +++ b/sequencer.h
> > @@ -149,7 +149,7 @@ int sequencer_remove_state(struct replay_opts *opts);
> >   * `--onto`, we do not want to re-generate the root commits.
> >   */
> >  #define TODO_LIST_ROOT_WITH_ONTO (1U << 6)
> > -
> > +#define TODO_LIST_SKIP_ALREADY_PRESENT (1U << 7)
> 
> This was another spot that I thought could maybe be turned into an enum,
> but it's clearly not the fault of your patch, and could easily be turned
> into #leftoverbits.

There was a recent discussion on the list [1] about whether bitsets
should be enums, and we decided against it. But anyway we can revisit
this later if need be.

[1] https://lore.kernel.org/git/20191016193750.258148-1-jonathantanmy@google.com/

The changes Taylor suggested were minor, so I'll hold off sending
another version until there are more substantial changes requested.
