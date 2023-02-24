Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B39C61DA4
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 02:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjBXCLX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 21:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBXCLV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 21:11:21 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EDF48E23
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 18:11:20 -0800 (PST)
Received: (qmail 1857 invoked by uid 109); 24 Feb 2023 02:11:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Feb 2023 02:11:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28152 invoked by uid 111); 24 Feb 2023 02:11:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Feb 2023 21:11:19 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Feb 2023 21:11:18 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 03/16] t5541: simplify and move "no empty path
 components" test
Message-ID: <Y/gcxkqZutHa90QC@coredump.intra.peff.net>
References: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
 <Y/dFN4GuCjqpIi2O@coredump.intra.peff.net>
 <xmqqttzc3qeq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqttzc3qeq.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2023 at 03:36:45PM -0800, Junio C Hamano wrote:

> > As a bonus, this also lets us drop the check for the v0 protocol (which
> > is otherwise necessary since v2 makes multiple requests, and
> > check_access_log insists on exactly matching the number of requests,
> > even though we don't care about that here).
> 
> Makes me wonder why we do not clear the log for each test, but OK.

Yes, I think that is a better strategy than the current code, but IMHO
these targeted greps are even better at showing what we really care
about. After my series, there are only two calls to check_access_log
left:

  - the one in t5541, from patch 2. This could be a grep, but since
    there is no v0/v2 confusion it was easy enough to leave it (and
    after my patch, it now is clearing and checking the activity of just
    one test)

  - one in t5561, which really does want to check the results after a
    ton of manual requests

So I think the state after my series is OK, at least from a maintenance
perspective.

-Peff
