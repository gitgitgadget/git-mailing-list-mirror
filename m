Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA97C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 22:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E56D2074D
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 22:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgHNWZV convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 14 Aug 2020 18:25:21 -0400
Received: from elephants.elehost.com ([216.66.27.132]:25249 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgHNWZV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 18:25:21 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 07EMPBHo045282
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Aug 2020 18:25:12 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        <jim.cromie@gmail.com>
Cc:     <git@vger.kernel.org>
References: <CAJfuBxw2KudBPfpmVqU9VOfnvrKdczU6Us5FWvpj50T88BarHw@mail.gmail.com> <20200814220828.GP8085@camp.crustytoothpaste.net>
In-Reply-To: <20200814220828.GP8085@camp.crustytoothpaste.net>
Subject: RE: git bisect enhancement request
Date:   Fri, 14 Aug 2020 18:25:05 -0400
Message-ID: <012301d67289$c5c36010$514a2030$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLA1TswLub1wJdglSp//FP9kbFv/wITf/ABp1LKNMA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 14, 2020 6:08 PM, brian m. carlson wrote:
> On 2020-08-14 at 21:11:19, jim.cromie@gmail.com wrote:
> > please teach git bisect how to use 2 separate worktrees for the
> > bisection, toggling between them as bisection progresses, so that the
> > end result is 2 compiled kernels, one broken, one good.
> 
> I'm not sure how such a thing would be implemented.  Git doesn't know until
> after it's checked out the tree whether a revision is good or bad, since usually
> the user needs to tell it (or use git bisect run).  Even if Git alternated between
> the two worktrees in order, that doesn't mean that one of them will end up
> being good, since Git may find the last good revision early on, then continue
> to bisect and find many bad revisions until it determines the right one.
> 
> Can you tell us more about the algorithm you'd like to see here?

I'm wondering more about the requirements on this. Does the bisect manipulate both worktrees at once or separately? Are these worktrees variants on a theme but on different branches (so synchronizing the commits would probably be impractical) - or bisect both workspaces but using different commits as start and end (this should be scriptable)? Does it flip back and forth between the two worktrees doing a bisect in one, then the other (this should be scriptable)? Or is this just to teach git to bisect a worktree in a distinct manner - which, correct me if I'm wrong, I think it already supports.

Or is this more, I have two worktrees on basically the same branch. When bisect happens, one worktree is bisected, tested. If the new code succeeds, and the other worktree is in a failed state, don't bisect the other worktree in the same direction - that's not right, but I think I know your end-state goal: keep bisecting both worktrees until a state change. What that is leading to is really something different, which is that once bisect is done, you know which commit introduced the bug, so set one worktree to the working commit and the other to the broken commit. If that's the case, it's not a toggle, but an end-state operation to set two worktrees to adjacent commits essentially surrounding the introduction point. Is that what you want?

Regards,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



