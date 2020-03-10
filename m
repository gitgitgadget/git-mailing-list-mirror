Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AF6C10F27
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 16:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F53E20873
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 16:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEkn2FTM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgCJQNG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 12:13:06 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:33054 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgCJQNG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 12:13:06 -0400
Received: by mail-wr1-f46.google.com with SMTP id a25so12837557wrd.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2020 09:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yw5MhHNQ31ld5MYfBYC2pOmxrVwpItV0RJqJmFB5D+M=;
        b=pEkn2FTMiqyMcW8ce7ItuGkOWg3CIHhSYm6Bb9m/srjv702Hw6bQ1xnLpZexzsMOCG
         K3UeAhSNRd+xKoip20fpD+fEWnGVeZ8n4e2PLDUL1LR08BxBvFu9ptkT9RM0DzTfMLZ3
         83H/C8vQVD0PPFxEwwnhKzu1RI3FXXJmD4ej2QnLaFU8DPjn8459M9BKfkpcA1eaeV96
         j7jUJuoZoMCqNsJgEU/klXwDIXk2gseHyEE7DxXHFyUi6kOpc6VC+IxY6tzDsdikuSbC
         vULlmOjWs3qK57v/bBp6AyimDj00Ym73LxJmSWzlBRheS1uzN1OPvvKCtH+aDpqj7gRt
         HVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yw5MhHNQ31ld5MYfBYC2pOmxrVwpItV0RJqJmFB5D+M=;
        b=LnY1KmECWyTyR80SFT0OpmYmdLeYO/RMMYsUQIv8SobEI2+LQMy+Nr9vPvAuLowxlb
         bOtoGNzq9jHr7r0Fj5tVeTwWXXkQNH9TIg12J+pzeqERxclmWi91yU1RKth/ZnCzgkhA
         0+rPWAgj8LKtX1MlqjrQiWFV2hecH26bpet8TTVepX83Vi8sxgqS2uWMA9uywegHrNBa
         s1cMYrgpUGyA9ed4OwMY+twEleuuwblFWYgnvKFimBDuXYC/qTrAGL9INkm9c0NmXMl7
         9KBXYSch3JTl6kEULH3s0Z+t9MVExuO++2qFy70iY2YTo0dFOnXtzo8ZZ5lswTfdJyIU
         FXgA==
X-Gm-Message-State: ANhLgQ3i2bu43W59IvBj27g7phc4G+fi9TSq4U7VjhJ+eOS5YGBKMLWV
        0oHWVYqS9hUlqQ/YPGeDmBk=
X-Google-Smtp-Source: ADFU+vt4DGHhEcfSgJihVfY0lmMKuZ4NzJvXhPYdOVG39L0hl1xdNFMKT2B3PB5BPDzNgoxKHKe/og==
X-Received: by 2002:adf:ff89:: with SMTP id j9mr2830257wrr.281.1583856783957;
        Tue, 10 Mar 2020 09:13:03 -0700 (PDT)
Received: from localhost ([2.28.70.205])
        by smtp.gmail.com with ESMTPSA id i9sm4745650wmd.37.2020.03.10.09.13.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Mar 2020 09:13:02 -0700 (PDT)
Date:   Tue, 10 Mar 2020 16:13:01 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2020, #02; Thu, 5)
Message-ID: <20200310161301.GA157628@cat>
References: <xmqq4kv24fzo.fsf@gitster-ct.c.googlers.com>
 <20200306172913.GF1571684@cat>
 <xmqqv9nh2wu9.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv9nh2wu9.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/06, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > On 03/05, Junio C Hamano wrote:
> >> * tg/retire-scripted-stash (2020-03-05) 2 commits
> >>   (merged to 'next' on 2020-03-05 at 8e82eb9dec)
> >>  + stash: remove the stash.useBuiltin setting
> >>  + stash: get git_stash_config at the top level
> >> 
> >>  "git stash" has kept an escape hatch to use the scripted version
> >>  for a few releases, which got stale.  It has been removed.
> >> 
> >>  Will merge to 'master'.
> >
> > I was thinking only getting this into a release after 2.26 dropped,
> > and have written the docs with that in mind.  Not sure if this "Will
> > merge to 'master'" means that you were planning to get this into 2.26?
> 
> Committed to merge to 'master' sometime in the future, but it still
> is not known if it will be before or after the upcoming release.
> 
> > I have a slight preference for waiting until after the release to
> > merge this down, but I'm okay with doing it now.
> 
> Being cautious is good.  I do not think this is ultra-urgent; as you
> said in <20200303174613.3557960-2-t.gummerer@gmail.com>, the "bug"
> has been with us for a couple of releases already.  I do not mind
> keeping it in 'next' and merge as a part of the first batch after
> the release.

I would prefer that, thanks!

> > If we want to do so
> > we need to tweak the description in 'Documentation/config/stash.txt'
> > to refer to 2.25 instead of 2.26.
> >
> > Either way, we'll need the patch below on top, as I made an
> > embarrassing copy-paste mistake.  Sorry for the trouble.
> 
> Heh, I think 8a2cd3f5 ("stash: remove the stash.useBuiltin setting",
> 2020-03-03) that is on 'next' already has it (and s/Variable/variable/
> casefix).

Ah great, thanks for catching this already.  One less embarrassing
mistake of mine in Gits history :)
