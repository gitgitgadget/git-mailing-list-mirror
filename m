Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C07C433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 19:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7FB7207D3
	for <git@archiver.kernel.org>; Wed, 27 May 2020 19:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgE0Tbx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 15:31:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:44448 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgE0Tbw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 15:31:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AB482AF52;
        Wed, 27 May 2020 19:31:53 +0000 (UTC)
Date:   Wed, 27 May 2020 21:31:49 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Kevin Buchs <kevin.buchs@newcontext.com>
Cc:     git@vger.kernel.org
Subject: Re: rationale behind git not tracking history of branches
Message-ID: <20200527193149.GJ25173@kitsune.suse.cz>
References: <CAKTRx=09tjsH0j+Nf4_1uzn-GwasWFB_Q96KEO=qtr5nVBkAew@mail.gmail.com>
 <20200527025048.GC172669@google.com>
 <CAKTRx=29XBtKgt0m1+aCex_YZeiDzk5oBBxuM45NvVHmuqUVNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKTRx=29XBtKgt0m1+aCex_YZeiDzk5oBBxuM45NvVHmuqUVNQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 27, 2020 at 11:24:59AM -0500, Kevin Buchs wrote:
> Hi Jonathan,
> 
> Thanks for the reply. I will give you my current situation. I am just
> taking over a project that many cooks were involved in previously. We
> have three persistent branches: dev, staging and master which
> correspond directly to three CD environments: dev, staging and prod.
> The nominal commit history ought to be that all changes happen in the
> dev branch, and that the latest dev is merged into staging and then to
> master at appropriate milestones of testing. However, the history of
In this setup you should have merges on dev only. staging should be
behind dev and master behid staging but any merge between these branches
should be fast-forward. Creating the merge commits would only add noise.

> commit chains clearly show that is not the case. Here is what gitk
> shows me: https://1drv.ms/u/s!AgKA2HL-SveIha4Y_5lihkQO7ulfKQ?e=oA9PEi
> .
> Now, you can see that the nominal practice was not followed. Sure,
> there are many commit messages to indicate merges and I could assume
> those are correct and possibly reconstruct which branch each commit
> might have belonged to. However, you can see there were a series of
> changes to multiple commit chains, when there should have just been a
> single chain - corresponding to the dev branch. How do I know there
> were not changes that should be included in dev that were stranded?
Find commits that are not ancestors of dev branch tip.

But if you are taking over the project maybe just auditing the actual
difference between the branches might be easier. Then you can use git
blame to see how the pieces of code that differ entered the branch in
question.

Going from the diverging history to one where the branches are as
described you can merge master to dev once to make all commits formally
ancestors of dev, preferably after examining and reconciling the
differences.

HTH

Michal
