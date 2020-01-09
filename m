Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A44CC32771
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 10:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66FE7206ED
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 10:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgAIKxS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 05:53:18 -0500
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:54964 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729609AbgAIKxR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 05:53:17 -0500
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 9C4A53C04C0;
        Thu,  9 Jan 2020 11:53:15 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Zrijl_e0EQq7; Thu,  9 Jan 2020 11:53:10 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 6BA673C00B7;
        Thu,  9 Jan 2020 11:53:10 +0100 (CET)
Received: from lxhi-065.adit-jv.com (10.72.93.66) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Thu, 9 Jan 2020
 11:53:09 +0100
Date:   Thu, 9 Jan 2020 11:53:07 +0100
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Elijah Newren <newren@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: Unreliable 'git rebase --onto'
Message-ID: <20200109105307.GA1349@lxhi-065.adit-jv.com>
References: <20200108214349.GA17624@lxhi-065.adit-jv.com>
 <CABPp-BHsyMOz+hi7EYoAnAWfzms7FRfwqCoarnu8H+vyDoN6SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CABPp-BHsyMOz+hi7EYoAnAWfzms7FRfwqCoarnu8H+vyDoN6SQ@mail.gmail.com>
X-Originating-IP: [10.72.93.66]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah, hi Szeder,

On Wed, Jan 08, 2020 at 02:06:22PM -0800, Elijah Newren wrote:
> This looks like a known bug in rebase, in particular in the am-backend that
> rebase uses by default.  If I'm correct that it's just a context region
> issue, then this is the same bug that was recently discussed at
> https://lore.kernel.org/git/CAN_72e2h2avv-U9BVBYqXVKiC+5kHy-pjejyMSD3X22uRXE39g@mail.gmail.com/.
> The current plan is to switch the default over to the merge backend (the
> same machinery that cherry-pick uses), which doesn't suffer from the same
> shortcomings (you can see the current work being done in this area at
> https://lore.kernel.org/git/pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com/
> ).

Thank you for your feedback and references, here and in [*].

Once hit by this or similar issues, I think there is high chance for
people to go through the same feelings as described by Pavel in [**]:

  ---
  That's so scary that I'm going to stop using "git rebase" for now.
  ---

Some years ago I was hit by 'git merge' producing slightly different
results compared to 'git rebase --onto' and 'git cherry-pick A..B'
(maybe I can come up with a reproduction scenario for that too).

Since then, I usually contrast the outcomes of merging, cherry-picking
and rebasing, to make sure they match, but that's painful and
time-consuming.

> In the mean time, you can pass the -m flag to rebase to avoid these types
> of problems.  In fact, if you could retry with -m you may be able to
> confirm whether it's the same issue.

Indeed, neither `git rebase -m` nor `git rebase -i` exhibit the problem.

[*] https://lore.kernel.org/git/CABPp-BHsy75UGm4wTOP2_AYik_dZi-_BxtAn-hyi-ZrNRRWGuw@mail.gmail.com/T/#m1cbf80ef56c260a626146d61291d7fbabd108f1b
[**] https://lore.kernel.org/git/CAN_72e2h2avv-U9BVBYqXVKiC+5kHy-pjejyMSD3X22uRXE39g@mail.gmail.com/

Thanks again.

-- 
Best Regards,
Eugeniu
