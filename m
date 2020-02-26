Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE80C4BA0B
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 09:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E17D24673
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 09:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgBZJrS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 04:47:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:54736 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727724AbgBZJrR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 04:47:17 -0500
Received: (qmail 18857 invoked by uid 109); 26 Feb 2020 09:47:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 26 Feb 2020 09:47:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24216 invoked by uid 111); 26 Feb 2020 09:56:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Feb 2020 04:56:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 26 Feb 2020 04:47:16 -0500
From:   Jeff King <peff@peff.net>
To:     Chris Jerdonek <chris.jerdonek@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: create reflog for reflog-less ref
Message-ID: <20200226094716.GA14546@coredump.intra.peff.net>
References: <CAOTb1wc2uMSyc7DMau2cWrWtk=_Z94+CCovORj1dGCrwgJhL=w@mail.gmail.com>
 <20200226023909.GC7911@camp.crustytoothpaste.net>
 <20200226034731.GA2915944@coredump.intra.peff.net>
 <CAOTb1wfWtFsy415k+goRiuLUiVBqtizmmoyxqFdy7xsRhjnBww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOTb1wfWtFsy415k+goRiuLUiVBqtizmmoyxqFdy7xsRhjnBww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 25, 2020 at 11:18:39PM -0800, Chris Jerdonek wrote:

> Thanks for the suggestions both of you. I didn't know about "always."
> It looks like it was added in 2.12.0:
> https://github.com/git/git/blob/master/Documentation/RelNotes/2.12.0.txt#L129
> 
> After experimenting a bit more, I seem to be finding that--
> 
> * The "one-shot" `-c core.logAllRefUpdates=always` approach only seems
> to work with git-update-ref if you're *changing* the SHA with
> update-ref, and
> * Passing `--create-reflog` also seems to work like the one-shot
> config approach (again, as long as you're changing the SHA).
> 
> I feel like these options are still wanting.. If you want to add a
> missing reflog without changing the ref, these approaches still seem
> to require you to temporarily change it to something different (as did
> the delete-create approach I stated in my first email). It would be
> nice to be able to create (or append to) the reflog without having to
> change where the ref is pointing. Or maybe I'm missing a variation
> that will do this..

No, I don't think there is a variation that will do that. You'd have to
wait for the next update.

The "touch" trick I showed would work for that, but it's not going to be
portable going forward. I don't think it would be a bad idea to have
some way of triggering a "noop" reflog update via update-ref, where we
either create the reflog as empty, or insert a pointless entry going
from the current sha1 to itself. But AFAIK that doesn't exist right now.

-Peff
