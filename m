Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29B6C43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 21:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3D320707
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 21:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbfLEVJq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 16:09:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:39598 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729861AbfLEVJq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 16:09:46 -0500
Received: (qmail 12689 invoked by uid 109); 5 Dec 2019 21:09:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Dec 2019 21:09:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21700 invoked by uid 111); 5 Dec 2019 21:13:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Dec 2019 16:13:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Dec 2019 16:09:45 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?5YiY54Kc?= <lw17qhdz@gmail.com>
Subject: Re: [PATCH] xdiff: unignore changes in function context
Message-ID: <20191205210945.GA49397@coredump.intra.peff.net>
References: <3053f7a8-0723-aaa7-fe43-9b8b13b2e259@web.de>
 <xmqq5ziu1y0l.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq5ziu1y0l.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 05, 2019 at 09:29:46AM -0800, Junio C Hamano wrote:

> > -# Note that the "6" in the expected hunk header below is funny, since we only
> > -# show 5 lines (the missing one was blank and thus ignored). This is how
> > -# --ignore-blank-lines behaves even without --function-context, and this test
> > -# is just checking the interaction of the two features. Don't take it as an
> > -# endorsement of that output.
> 
> Nice to see that somebody anticipated that we may fix this some day.

Or that somebody just didn't want to be embarrassed by introducing such
obvious nonsense into the test suite. :)

I was curious, though, whether there was still a lurking bug in
"--ignore-blank-lines", based on what that comment says. But I don't
think so. It reports the correct numbers for this test case, but that's
because the blank line drops off the context. If we add -U4, then it
does mention 6 lines in the preimage, and includes the line.

Which matches what René claimed in the commit message: "Changes
involving only blank lines are hidden with --ignore-blank-lines, unless
they appear in the context lines of other changes." But now I've
double-checked. :)

(And I agree that the output after this patch is way better).

-Peff
