Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA03C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 04:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4214561354
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 04:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbhDUErL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 00:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbhDUErK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 00:47:10 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CA1C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 21:46:38 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id u7so19117882plr.6
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 21:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=myhvAAcFAzQt18RHy1sVStT8HxwyxJKn2LCtptV/zqk=;
        b=qiH42X5Foimjmgaj4+Twcf1pjzRrBrPGxWEsv2mw14EfULGHi6fy7yUdBAn6mCMm/s
         NVOSwugM6mJczZMJ6Fy0q+Chfzypva1qcw4trCbXAoke/xOMy6X+VjQlfjmOdvYnSVxA
         raxT+jShuSm38EivTKGtdaqlHfOUnRcXbMET0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=myhvAAcFAzQt18RHy1sVStT8HxwyxJKn2LCtptV/zqk=;
        b=scfd8PrHn/GZNpxNPSoIpz3QJEyfhFg/W2j5f7s45k9Z89uoEmRpU8fBXupB5vftcQ
         Z+Y2iZ7wlKZ6LHoEUXF54CH6nn5noMHNChjaPb1d+g9W74Z1xNhTt56kKEmOc9Xa1F9z
         jklF1B3oJtmP89h5WpgXMAZ1v+REqxL0hOhN7cRCSO5XqQImTwNAC6nta49TlPoFm5cO
         is/GOL6wJILaoV4Bbs6lRrZnBFSqkHZ7wPxp4YAYrqlS55a947ysXOSnS/Rk8n5VSQP1
         HbMvO/Snkq3zKYhvlSuOZmV2hOZ0l8Mmp8oCCT/9kmGo2zkWnTVTWbwQ0xwMGDPovPw/
         aD2g==
X-Gm-Message-State: AOAM531EQ1ly1yIwob+1Ivuk4/KjA3ph7hhhSDPiy+h/bkrZBykC6EXj
        0bnGkAvo9XyRZH6LyX4N3HQnXA==
X-Google-Smtp-Source: ABdhPJwrGYF6CNV9WhjNoIHTKG081EA5p+0a+A+COynhrf+/OfGlWJPT5aLdWrxGhFGWDxY7SscbVw==
X-Received: by 2002:a17:902:8e89:b029:e9:a576:886e with SMTP id bg9-20020a1709028e89b02900e9a576886emr31988925plb.65.1618980397712;
        Tue, 20 Apr 2021 21:46:37 -0700 (PDT)
Received: from localhost (2001-44b8-1113-6700-84b8-5ec2-0878-87f8.static.ipv6.internode.on.net. [2001:44b8:1113:6700:84b8:5ec2:878:87f8])
        by smtp.gmail.com with ESMTPSA id f6sm563877pgd.61.2021.04.20.21.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 21:46:36 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        patchwork@lists.ozlabs.org, mricon@kernel.org,
        Raxel Gutierrez <raxelgutierrez09@gmail.com>
Subject: Re: Pain points in Git's patch flow
In-Reply-To: <YHaIBvl6Mf7ztJB3@google.com>
References: <YHaIBvl6Mf7ztJB3@google.com>
Date:   Wed, 21 Apr 2021 14:46:33 +1000
Message-ID: <87tuo0z1li.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

> I'd like to introduce Raxel (cc-ed), who is starting an internship
> this June with the Git team at Google.
>
> He'll be working on a bit of an experimental project: we want to take
> Patchwork[1], which in principle can be a helpful addition to a
> mailing list centric workflow[2], and improve it to be something that
> people in the Git open source project get day-to-day benefit from.
> Raxel's previous successes in making changes to tools to support a
> better user experience make me excited for the potential for this
> work.

Greetings Raxel! Myself and Stephen F are patchwork maintainers so we'll
be reviewing and merging any proposals you have for patchwork. We try to
be a welcoming place. We're also both extremely busy so (unfortunately)
you will probably need to ping me if I forget to respond.

> Anyway, yesterday[3] Junio, Taylor, and Emily were discussing how to
> encourage more reviews:
>
>  <gitster> this week, i'd be thinking about ways to get topics, that
>            are not reviewed sufficiently, reviewed. I can act as the
>            last-resort fallback reviewer, but that's not sufficient.
>  <ttaylorr> gitster: I share your concern.
>  <nasamuffin> gitster: yep, agree, on both counts
>
> That reminded me that it would be useful preparation to collect
> descriptions of pain points we are having with our existing patch
> flow.  For example:
>
> - As a reviewer, I want to be able to easily find a series that needs
>   review.  Using patchwork, I can see some recent patch series; or
>   using a hierarchical threaded mail reader, I can find a neglected
>   thread or one that seems to be likely to have an interesting
>   discussion going on.  But without reading in detail, there is no
>   easy way to see whether the series has reached a review, whether
>   someone else intends to review it, and what the author believes its
>   status to be.

Patchwork does have the A/R/T/F
(Acked-by:/Reviewed-by:/Tested-by:/Fixes:) column, but this doesn't have
a good way to capture something that falls short of a full
review. There's also the patch states (e.g. Changes Requested), but that
requires either the author or a maintainer to change the status via the
web interface or with an API client.

> - Relatedly, as a patch author or reviewer, I want to be able to
>   easily tell whether a topic has been sufficiently reviewed.  Today,
>   the signals for this are implicit: I have to judge consensus, or to
>   check the Git repository for whether the patch has been merged, or
>   to check the maintainer's latest "What's cooking in git.git"
>   message.
>
> - As a potential reviewer or interested user, I want to be able to
>   follow all relevant discussion for a patch series, while also
>   having the ability to stop following it if the discussion goes on
>   too long and starts overwhelming my email inbox.  Today, I can join
>   the discussion and then (1) it is hit-or-miss whether the patch
>   author ccs me on later iterations of the patch and (2) there is no
>   easy way without aggressive email filtering to stop watching it if
>   I am cc-ed.
>
> - After having diagnosed an issue to be due to a patch, I want to be
>   able to easily find all relevant review discussion.  Today I can
>   use the mailing list archive[4] or patchwork to find review
>   discussion on the latest version of the series that patch was in,
>   but tracing back to previous iterations of that same series can be
>   non-trivial.  Moreover, if I'm interested in a particular puzzling
>   line of code, finding which iteration introduced it can take a long
>   time.
>

Yeah, cross-series linking is something we've been interested in for a
long time. We have a little bit of the infrastructure already but
there's a long way to go.

One of the real challenges for us has been figuring out how to reliably
link iterations. It's one thing if iterations are sent in-reply-to the
early version, but at least for the kernel that's not The Way Things Are
Done. There's lot of common things people do (split series, rename
series, add/drop patches) that makes reliable linking very
challenging. And traditionally Patchwork has tried to Do It Right rather
than go for a probabilistic approach. (We get a lot of email complaints
if we get things wrong.)

(Having said that, I'd certainly be open to considering any attempts to
automatically link series, even if only probabilistic, so long as they
err by missing things rather than err by linking things that are
unrelated.)

One thing that's come up as another possible option is free-form tags. I
think there's some old series on the list from Veronika that attempts
this. That'd allow Someone to 'tag' a patch or a series on
patchwork. For Veronika's use case this was for complex CI - things like
"ready-for-real-hw-tests" that shouldn't happen until someone has cast
an eye over the patches.

One big challenge for patchwork development (which catches us out
regularly) is the odd interaction between patchwork-the-project and
patchwork-the-deployments. There are 2 large deployments:
patchwork.ozlabs.org and patchwork.kernel.org, and they all have
multiple-GB databases. This means that performance and db load matters,
but is really hard to test locally. A good example is writing efficient
migrations - historically we have struggled with this.

Anyway, good luck with the dozens of messages and strong opinions!

Kind regards,
Daniel

> Those four are important in my everyday life.  Questions:
>
>  1. What pain points in the patch flow for git.git are important to
>     you?
>
>  2. What tricks do you use to get by with those existing pain points?
>
>  3. Do you think patchwork goes in a direction that is likely to help
>     with these?
>
>  4. What other tools would you like to see that could help?
>
> Thanks,
> Jonathan
>
> [1] http://jk.ozlabs.org/projects/patchwork/; you can see an instance
> for Git at https://patchwork.kernel.org/project/git/list/
> [2] https://kernel-recipes.org/en/2016/talks/patches-carved-into-stone-tablets/,
> https://www.kernel.org/pub/software/scm/git/docs/gitworkflows.html#_patch_workflow
> [3] https://colabti.org/irclogger/irclogger_log/git-devel?date=2021-04-12#l40
> [4] https://lore.kernel.org/git/
> _______________________________________________
> Patchwork mailing list
> Patchwork@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/patchwork
