Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328EDC19F2C
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 17:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237672AbiHCRU0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 13:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237699AbiHCRUY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 13:20:24 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F6E1C93C
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 10:20:22 -0700 (PDT)
Received: (qmail 8267 invoked by uid 109); 3 Aug 2022 17:20:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Aug 2022 17:20:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13114 invoked by uid 111); 3 Aug 2022 17:20:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 Aug 2022 13:20:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 3 Aug 2022 13:20:20 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] pipe_command(): mark stdin descriptor as non-blocking
Message-ID: <YuquVEqEl6wxCLM7@coredump.intra.peff.net>
References: <YuikU//9OrdpKQcE@coredump.intra.peff.net>
 <YulFTSTbVaTwuQtt@coredump.intra.peff.net>
 <xmqq5yjahb8u.fsf@gitster.g>
 <YunxHOa2sJeEpJxd@coredump.intra.peff.net>
 <a9953278-b15f-fd76-17b0-e949c7937992@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9953278-b15f-fd76-17b0-e949c7937992@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 03, 2022 at 06:45:23PM +0200, René Scharfe wrote:

> > +test_expect_success 'handle very large filtered diff' '
> > +	git reset --hard &&
> > +	# The specific number here is not important, but it must
> > +	# be large enough that the output of "git diff --color"
> > +	# fills up the pipe buffer. 10,000 results in ~200k of
> > +	# colored output.
> > +	test_seq 10000 >test &&
> > +	false &&
> 
> Isn't this test going to end here, reporting failure before it even gets
> to the interesting part?

Urgh, whoops. That was from some last-minute tweaking of the comment.
There was also a line:

  git diff --color | wc -c

before it so I could measure how big the output was for a few values.

It snuck into the emailed patch, but the actual test runs (including the
Windows CI) didn't include that (since obviously they'd have failed the
test).

Thanks for catching.

-Peff
