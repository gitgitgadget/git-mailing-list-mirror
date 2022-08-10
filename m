Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA15DC00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 21:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiHJVqQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 17:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbiHJVqN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 17:46:13 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AAF5005E
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 14:46:11 -0700 (PDT)
Received: (qmail 7026 invoked by uid 109); 10 Aug 2022 21:46:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Aug 2022 21:46:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16097 invoked by uid 111); 10 Aug 2022 21:46:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Aug 2022 17:46:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Aug 2022 17:46:10 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Xavier Morel <xavier.morel@masklinn.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] fsck: actually detect bad file modes in trees
Message-ID: <YvQnIuVzMrOaM589@coredump.intra.peff.net>
References: <YvQcNpizy9uOZiAz@coredump.intra.peff.net>
 <YvQc9egGzwFomQbw@coredump.intra.peff.net>
 <xmqq4jyjkcij.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4jyjkcij.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 10, 2022 at 02:35:32PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > We use the normal tree_desc code to iterate over trees in fsck, meaning
> > we only see the canonicalized modes it returns. And hence we'd never see
> > anything unexpected, since it will coerce literally any garbage into one
> > of our normal and accepted modes.
> 
> Wow.  I did know canon_mode() deliberately discarding the extra
> permission bits on trees and blobs, but it was that bad to mark
> whatever it does not understand as a gitlink.  That is simply
> horrible.

Yeah, I noticed that, as well. It might actually be reasonable to put a
die() at the end of that canon_mode() function. It's rather unfriendly,
but then, treating nonsense as a gitlink is likely to just result in the
caller ending up aborting anyway.

Outside the scope of my patch, though. :)

-Peff
