Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F8AC77B75
	for <git@archiver.kernel.org>; Wed, 17 May 2023 17:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjEQRhY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 13:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjEQRhV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 13:37:21 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9E230D4
        for <git@vger.kernel.org>; Wed, 17 May 2023 10:37:11 -0700 (PDT)
Received: (qmail 21774 invoked by uid 109); 17 May 2023 17:37:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 May 2023 17:37:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11265 invoked by uid 111); 17 May 2023 17:37:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 May 2023 13:37:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 May 2023 13:37:09 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] tag: keep the message file in case ref transaction
 fails
Message-ID: <20230517173709.GA535409@coredump.intra.peff.net>
References: <cover.1684067644.git.code@khaugsbakk.name>
 <20230517093214.GA527234@coredump.intra.peff.net>
 <xmqqo7mjq779.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo7mjq779.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2023 at 09:00:10AM -0700, Junio C Hamano wrote:

> > I dunno. There is a certain elegance to telling the user about what
> > progress we _did_ make, but if there isn't an easy way to turn that into
> > a retry of their command, it may not be all that useful.
> 
> Yeah, I am OK with "leaving TAG_EDITMSG behind" and a future "tag
> -c/-C $another" to coexist.

Me too.

One thing I wondered is whether the obvious command to retry:

  git tag -F .git/TAG_EDITMSG foo

would work, or if we would overwrite the file before it is read. But it
does work, which is good. I wonder if we:

  a. want to protect that with a test (since I could imagine a
     refactoring where we try to copy the "-F" contents from file to
     file, rather than reading it into a memory buffer ahead of time)

  b. want to tell users that is a good way to recover (though maybe that
     is a rabbit hole of details as one subtlety is that it will be
     overwritten by an unrelated tag command).

But I am also happy to leave it to the user's imagination to pull the
contents from the file with "cp" or their editor. :)

-Peff
