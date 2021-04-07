Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AB7C433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 19:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA56E61159
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 19:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348858AbhDGTs3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 15:48:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:43664 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347438AbhDGTs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 15:48:28 -0400
Received: (qmail 17559 invoked by uid 109); 7 Apr 2021 19:48:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Apr 2021 19:48:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22367 invoked by uid 111); 7 Apr 2021 19:48:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Apr 2021 15:48:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Apr 2021 15:48:16 -0400
From:   Jeff King <peff@peff.net>
To:     Eugen Konkov <kes-kes@yandex.ru>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Can not list stash (git version 2.30.0)
Message-ID: <YG4MgBMJGBbIyGDJ@coredump.intra.peff.net>
References: <1851413381.20210407204938@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1851413381.20210407204938@yandex.ru>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 07, 2021 at 08:49:38PM +0300, Eugen Konkov wrote:

> I am in progress of rebasing
> 
> ~/e/Auth/Mojolicious/Plugin $ git rebase aa3376
> Created autostash: 4018bc7
> hint: Waiting for your editor to close the file...
> 
> 
> while I am in editor I switched to different console to view created autostash:
> 
> ~/e/Auth $ git stash list
> 
> and see nothing
> 
> but can view stash by its id:
> ~/e/Auth $ git show 4018bc7
> commit 4018bc7bc870eb37aa35f40a0f612ca55a586045
> Merge: a790392 674e39f
> .....

If you run with GIT_TRACE=1, you can see that the autostash feature uses
"git stash create" and not "git stash push". That creates the stash
commit but _doesn't_ push it onto the stash list.

So it's working as intended. The rationale comes from the very
first commit adding autostash, 587947750b (rebase: implement
--[no-]autostash and rebase.autostash, 2013-05-12), which says:

    The advantage of this approach is that we do not affect the normal
    stash's reflogs, making the autostash invisible to the end-user.  This
    means that you can use 'git stash' during a rebase as usual.

-Peff
