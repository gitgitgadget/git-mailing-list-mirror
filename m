Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C896C433FE
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 02:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB85823BC7
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 02:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgLJCCq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 21:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbgLJCCp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 21:02:45 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC9BC0613D6
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 18:02:05 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id 198so2640718qkj.7
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 18:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=zlhc6YluhPMkrrQviWed9nPEQLGVkbuwqsTFGuIC97Q=;
        b=k98+hhrXfmvyTp/kAsQ8z4xG3vhhp+W4UXWAQ7uvt/He7ffxOUtH+T/T10p6TjUgVd
         rTOOjg6sbVrcFrs5d9Nz5EX2H7KJHJNY+T3+r3qsdUxhwyRpCxJHr2h+fVW3x8IlocjG
         l8PissielUyfKcSTFffinN3PfFjmDl88bdpEBEV1MiZHJxsEfyDUsYfC8NqBo+gzDMY5
         y/0CxifJ9lcKoppmdnDw6aZ0bkJi7CKdmYa+NX7ToQbFPP/0/8w9ionUFldb+hkmLIb1
         6Yn8onnvVaXwgBTlNOaahP05jG/bno4Qt66Q1cdAjSbfYOQAtH19VXAakDjw6A+csWZl
         HlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zlhc6YluhPMkrrQviWed9nPEQLGVkbuwqsTFGuIC97Q=;
        b=nUctEKYWeY1c6tbcYbljLASk3yCznLZH/l7W3vmZQwM0bDvSI2y+PxY/CJ/oewXHU7
         ahpa3xhMzD/p9n1kSB6eGPh3QxE00+Kj3bVI50ikJxjsqPVqMLE1IesH1lLKU07iD54O
         d3/0h3OGreGEhAtLwqIcUrwFO7owCKFr0/xZw2D1IBWukhoB3Z0r+0fTHhVuqBRpCH5N
         hxsfkjMKgjpuHl0+2DzxJbECRHERirOxG5sWiG7nty34kIxdM2R5tpc6+bUw5qjGnLG5
         cH1D7uavyvd1iNFFqrYgqfy6GsnRuH7VHrLQSH7UXzNp/x2PRZSghEeDRXY/EOv91Z/n
         dKFA==
X-Gm-Message-State: AOAM530f/xdywG4bHrpeqtiNEJGhKw5VIDAnvA7L/YWpKXL60kVVhrmx
        E2ujq4/UQt+Vn7nPH0ugHTECloiWY24/Mfrc7HZd
X-Google-Smtp-Source: ABdhPJxdO3R1F1qK7Pv/1mGfIaiAumbvwr5Ds9fb6GYklAopIWDD8kdyRNO/xqeN+dTiqtxrprUNQ2siQwpoqfYYaNFx
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:f38a:: with SMTP id
 i10mr6744423qvk.32.1607565723764; Wed, 09 Dec 2020 18:02:03 -0800 (PST)
Date:   Wed,  9 Dec 2020 18:02:00 -0800
In-Reply-To: <X9ArLOecIhoivhym@nand.local>
Message-Id: <20201210020200.1636414-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <X9ArLOecIhoivhym@nand.local>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: Re: What's cooking in git.git (Dec 2020, #01; Tue, 8)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     gitster@pobox.com, git@vger.kernel.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > * tb/pack-bitmap (2020-12-08) 24 commits
> >
> >  Various improvement to the codepath that writes out pack bitmaps.
> >
> >  Will merge to 'next'?
> 
> I'm obviously biased, but I'd be quite happy to see this get onto next.
> I would like Jonathan Tan to take another look over the series (since he
> reviewed many parts of v2), in addition to anybody else with interest
> and time.

I think this patch set can be merged to 'next'. I've looked at v3's and
v4's range-diffs and my comments have been addressed. (Well, I was still
hoping for more information about the git/git fork network - in
particular, how wide the commit bitmasks got - but that does not need to
prevent merging this patch set into 'next'.)
