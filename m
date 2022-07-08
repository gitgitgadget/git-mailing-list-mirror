Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B31FC433EF
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 16:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbiGHQIy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 12:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiGHQIx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 12:08:53 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB2D13F3B
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 09:08:52 -0700 (PDT)
Received: (qmail 9063 invoked by uid 109); 8 Jul 2022 16:08:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 08 Jul 2022 16:08:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12629 invoked by uid 111); 8 Jul 2022 16:08:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 Jul 2022 12:08:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 8 Jul 2022 12:08:48 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 2/3] clone: propagate empty remote HEAD even with
 other branches
Message-ID: <YshWkMFy124otENI@coredump.intra.peff.net>
References: <YsdyLS4UFzj0j/wB@coredump.intra.peff.net>
 <Ysdy+STDIhCZU05+@coredump.intra.peff.net>
 <xmqqedyvwr0k.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqedyvwr0k.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 08, 2022 at 08:41:47AM -0700, Junio C Hamano wrote:

> > +	grep "refs/heads/mydefaultbranch" file_unborn_child/.git/HEAD &&
> 
> We know they do not have mydefaultbranch2 branch, so this grep may
> be sufficient, but peeking into the implementation detail of HEAD is
> not necessary.  The kosher way is way more verbose and awkward,
> though:
> 
> 	git -C file_unborn_child symbolic-ref HEAD >actual &&
> 	echo refs/heads/mydefaultbranch >expect &&
> 	test_cmp actual expect &&
> 
> I dunno.

Yeah, that occurred to me, too. I _think_ it's fine for now, even in a
reftable world, because HEAD there is always still a file.

At any rate, this was following the lead of the other tests in the file,
so my thought was to do that for now, and if we care we can convert them
all on top (maybe even with a helper).

-Peff
