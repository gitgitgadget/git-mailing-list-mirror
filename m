Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D580FC1B0D9
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 21:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A10D923B1F
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 21:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbgLHVhU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 16:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730050AbgLHVhU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 16:37:20 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C7AC0613D6
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 13:36:40 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id f132so77493oib.12
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 13:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Is5RuGyeWUAoRCqxV+YrgnVdYCJEXIYoa5nW6wRG++Y=;
        b=qRonJrMt1el3LUWvvWOJzOPANMiJaEnMmZ9utZbVPaJcIFhjEIKepuYKWBdVuj0AaY
         7pb0/u6rn5z1EMiBBP1fQ5MW567I7Q4FipiYXyvnzRU7pcv+1PvcmuQbrIF2FL+jdFr/
         obOA1inPG8WqVzhmxKDTwpaT3VhKn3ksvYQIHXEmr/iwqG6L86drcZtI6zxrxLjQWo4w
         PpVpT1RsnOJByjpE8+4lR0GMHo8DCxcstJ6+RNkEBZgJQtzvcDm5F0NWh2x5FwxppjAg
         nx8tke46OA+HfibBmxmfJQ0gE+Pumo0xfGPoz29a9XpiA5mHf3kSA+J0504YrlAKbdMV
         +4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Is5RuGyeWUAoRCqxV+YrgnVdYCJEXIYoa5nW6wRG++Y=;
        b=CLErRgyBhB58UydqDOpkmU+WxAy8nl40sFLIes+Np0nv9f598kF1RDgETsuR4sqziU
         C69kVKJJJmj0jlz+EqpN33gWQiN753RwTidOuz3PGa9o596P2g4VrFFmiaMie/JR0Kme
         kVI0j6sXlsgDISb6E15cM+Oa2n0eM2YrjKpJuhhvuhp05ZfAHTbd0L3VS604Hmp9NxE4
         bZzMgoWu7lPf3uyjUrhcv8+LMxPy04vFgfNKOGH6OhpGvl+Ue4HGL1/P33RSlerVDArx
         jK/l2KX+iAxPgmtjtsI5dPQIgcXaj+S/xy0gLRrMhtT8ZmkPc2vJlPWvLHE+qjpVc71y
         58wA==
X-Gm-Message-State: AOAM531qxF31IkP6qIy03oFkbZIYtzixmnV5wphaczuHvZRfMlZhWhKy
        kWIYsuZMPjUqlLM5Aum22wlzKg==
X-Google-Smtp-Source: ABdhPJwbAPeXTODSUh1Vor8vDIR9hpMsCV1B0ACFN6wwO9Savk77cIJ49q+t4otgSLOREVYxcsU9/A==
X-Received: by 2002:aca:ea87:: with SMTP id i129mr4589595oih.166.1607463399688;
        Tue, 08 Dec 2020 13:36:39 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id v12sm37065ooi.46.2020.12.08.13.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 13:36:38 -0800 (PST)
Date:   Tue, 8 Dec 2020 16:36:36 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t5310: stop expecting the default branch name `master`
Message-ID: <X8/x5LaeZgbvXT0l@nand.local>
References: <pull.809.git.1607260623935.gitgitgadget@gmail.com>
 <xmqqim9dbh17.fsf@gitster.c.googlers.com>
 <X8/bYzjP569wEL5x@nand.local>
 <xmqq360g6lxc.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq360g6lxc.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 08, 2020 at 01:13:35PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Mon, Dec 07, 2020 at 10:35:48AM -0800, Junio C Hamano wrote:
> >> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> >> writes:
> >>
> >> >     This one goes on top of tb/pack-bitmap, and requires an update of
> >> >     js/default-branch-name-tests-final-stretch (it no longer needs to
> >> >     hard-code GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME in t5310).
> >>
> >> As the targetted topic is not in 'next' and marked with "Needs a bit
> >> of reshuffling?", I'd appreciate this patch to be also forwarded so
> >> that I do not have to worry about it myself.
> >
> > Ah, sorry that I missed this before sending out v3. I was hoping that
> > the fixup would be limited to one patch, but this needs to be either
> > spread across multiple patches, or applied at the end.
> >
> > Since I already sent v3, how do you want to handle this?
>
> As I have many other topics on the table to attend to, I can skip v3
> and take v4 if it is not too much trouble to fix the issue at the
> source.  Thanks.

No problem at all. Your instructions were spot on (4/24 and 15/24 needed
adjusting, as well as the later patches which could no longer be
applied after modifying those two).

Checking my work against upstream, I can see that the only diff lines
which mention "master" are removals:

$ git diff @{u}.. | grep master
-	git checkout master &&
-	bitmaptip=$(git rev-parse master) &&
-		git rev-list --count other...master >expect &&
-		git rev-list --use-bitmap-index --count other...master >actual &&
-	git --git-dir=clone.git fetch origin master:master &&
-	git --git-dir=clone.git fetch origin master:master &&

and spot checking the inter-diff between what I have and what Johannes
posted I can see that they are the same. I've added some Helped-by lines
in the relevant patches to indicate where the suggestions came from.

v4 coming shortly...

Thanks,
Taylor
