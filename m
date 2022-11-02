Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0459C4332F
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 08:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiKBIB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 04:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKBIB4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 04:01:56 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2C519F
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 01:01:54 -0700 (PDT)
Received: (qmail 9077 invoked by uid 109); 2 Nov 2022 08:01:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Nov 2022 08:01:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3243 invoked by uid 111); 2 Nov 2022 08:01:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Nov 2022 04:01:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 2 Nov 2022 04:01:53 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/2] Documentation/howto/maintain-git.txt: a pair of
 bugfixes
Message-ID: <Y2Ij8c9NCdhJkTE8@coredump.intra.peff.net>
References: <cover.1667260044.git.me@ttaylorr.com>
 <Y2DSSM8ujceSgp+b@coredump.intra.peff.net>
 <xmqqo7tqco0y.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo7tqco0y.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 01, 2022 at 03:23:25PM -0700, Junio C Hamano wrote:

> and use 
> 
>     $ git branch --no-merged jch --no-merged seen --sort=-committerdate '??/*'
> 
> to see any topics that are not in last 'seen' and 'jch' we just
> rebuilt.  They are either replaced in 'seen' or new ones.  Then
> merge some of them that you are more confident than others to 'jch'
> and test and update the redo-jch.sh script.
> 
>     $ git merge xy/xxy
>     $ git merge fr/otz
>     ...
>     $ Meta/round ;# or whatever tests that are appropriate
>     $ Meta/redo-jch.sh -u
> 
> This "-u"pdate step can be done without disturbing what should later
> build on top for 'seen' by having the script separately.

Ah, OK, this is the part I was missing. I assumed you would write the
new topic names into the redo-jch file, then run it to create the merged
state (since with rerere, it's easy-ish to reset jch back to master and
just rebuild to the desired spot).

But that is inside-out from your workflow, which is to treat topics
individually. Updating redo-jch.sh is done by the script and explains
what you did manually, rather than manually updating redo-jch.sh and
having it build automatically. Your way makes much more sense, since you
get the opportunity to examine the intermediate states more closely.

Thanks for explaining!

-Peff
