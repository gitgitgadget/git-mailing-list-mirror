Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428AFC433E9
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 23:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CD5664FD6
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 23:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbhCJX30 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 18:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbhCJX3K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 18:29:10 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E810FC061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 15:29:09 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id w2so5608328pjk.4
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 15:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=anaMj65/mVEad6RAPFPIpYmZSLovXL1NKFihOlA7kXY=;
        b=dxTOWn1NVwU7Nsb+XdniM/mWyZSwBuiUv1u92483C+WZVdTqF+Gt3KBYrDzWVwYce9
         Yw8epstTc/NZ2fYFrczM+H23FKZQpliNvJFCKoReCWcp4gQtpY+3L4QHZXZ6GOcndabi
         9Kv5Ef+5BM3iaRBlCeqwrpFBHa9KUuJj4QhqwEIS+FDdR/tOeAZAlFv88ndAOxea3CAN
         Oc17Y4DodbPEY0DRvR//OlVWPJXi/+lpvur0zBppbCmFGXM+LeJXolHn1z0PB8/qtxMF
         JfnkC4veWQW++lM3vrarFeexzRgKg3WT8xaf2CIhG+KCrXaepdJ52j4e9yjT5LMjQyzs
         H/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=anaMj65/mVEad6RAPFPIpYmZSLovXL1NKFihOlA7kXY=;
        b=WlHRUQa3xZV+dVh+y6aX0GhMW2C5Wnn1ZAy9plMtD5K4jpp4NGAuCDtKZjeaZ9q7pT
         J9oveduzujWTn89ZX/XbWzj2snObdeCSzjn8JqLqxQ1E5ytWMV36JQrgX3gD76A14DRc
         r/+mRO/oHuzi8VRJJ1RfQzyvY3rXX1P61PlOlpuc5YVf7GbxI8W51Mh8qTJPp0mk8H8M
         wQI0ffwboL4sXP6IjFrdfbF+7T9Bp97N4pFUjfjAkThIb+xVQmfLlqSm85I+oQ7aQ4ct
         s6bqklqUFshxmyZeV9p6Px4NRvE9qbQpQA6dXThkIqudZgT1gMG/OF2iCiFF4KBKuGF7
         D3tw==
X-Gm-Message-State: AOAM533BuU4o00wAtDDtrFwgh5EVwGmGFiKDhRZCaHEyBFiu50UgWpcY
        kWLmr2WG+CFcBbzIjyEHzpky2On5EPVS3LOwHcwr
X-Google-Smtp-Source: ABdhPJxWrMTrdjmi24113ojgDveXcl5YrXgwGP+mdTevr7ujbCOh/dVNQo3QvxLlCJMG8ERUoccpFiBmzs1x9CMPmBaJ
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:b711:b029:e3:71f1:e08e with
 SMTP id d17-20020a170902b711b02900e371f1e08emr5418987pls.18.1615418949436;
 Wed, 10 Mar 2021 15:29:09 -0800 (PST)
Date:   Wed, 10 Mar 2021 15:29:06 -0800
In-Reply-To: <xmqq5z1ykckc.fsf@gitster.g>
Message-Id: <20210310232906.2135256-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq5z1ykckc.fsf@gitster.g>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: Re: [PATCH] fetch-pack: do not mix --pack_header and packfile uri
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        nmulcahey@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I already said that I think 2aec3bc4 (fetch-pack: do not mix
> > --pack_header and packfile uri, 2021-03-04) is OK as a short-term
> > fix for the upcoming release, but it does not change the fact that
> > it is piling technical debt on top of existing technical debt.
> >
> > And that is why I am reacting against your earlier mention of
> > "filering out" rather strongly.  The approach continues the "keep
> > the single args array in the belief that two must be mostly the
> > same", which I view as a misguided starting point that must be
> > rethought.
> 
> Another way to think about the codepath is this.
> 
> Can the bulk of get_pack() that deals with a single incoming
> packfile (from the part that makes the decision to use either
> index-pack or unpack-objects and chooses what options to pass to the
> command, to the part that actually calls run_command() and feeds the
> packdata to the command) be made into a helper function that handles
> one packdata stream and nothing else?  Such a helper would most
> likely take as its parameters
> 
>  - a stream to read the packdata from (for in-stream packfile that
>    is handled by get_pack(), we already have it available)
> 
>  - fetch_pack_args and other options that are meant to affect the
>    operation of fetch-pack, among which are two bits that are of
>    interest in this topic: if we want to run fsck-objects and if the
>    entire fetch-pack is dealing with more than one packfile
>    (currently, the only source of need to process multiple packfiles
>    is packfile URI mechanism, but that does not have to stay that
>    way).

This probably means that fetch-pack.c itself (instead of
finish_http_pack_request(), currently being called from a separate
http_fetch process) should call index-pack for the out-of-band
packfiles, which is conceptually reasonable. This means that
finish_http_pack_request() will need to be able to refrain from running
index-pack itself and instead just return where the pack was downloaded.

> Then get_pack() can move a lot of code out of it to this helper and
> just call it.  The processing the other packfile obtained by the
> packfile URI mechanism out of band can open the packstream and call
> the helper the same way.  When packfile URI mechanism is in use, both
> invocations of the helper would get "you are not alone so fsck may
> hit missing objects" bit, if fsck-objects are asked for.
> 
> That would avoid the "duplicated logic" and still allow the code to
> choose the best disposition of the incoming packdata per packfile.
> 
> In an extreme case, it is not hard to imagine that somebody prepares
> a very small base packfile and feed it via packfile URI mechanism,
> but have accumulated so many objects that are not yet rolled into an
> updated base packfile---cloning from such a repository may result in
> running unpack-objects for the packfile that came out of band, while
> processing the in-stream packfile with index-pack.
> 
> Hmm?

Your suggestion (as opposed to the current situation, in which we're
locked into using index-pack for the out-of-band packfiles) would make
this possible, yes.
