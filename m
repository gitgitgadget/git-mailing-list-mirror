Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18587C4332F
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 16:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiKXQfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 11:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiKXQfS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 11:35:18 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C724D769E9
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 08:35:17 -0800 (PST)
Received: (qmail 27244 invoked by uid 109); 24 Nov 2022 16:35:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Nov 2022 16:35:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28720 invoked by uid 111); 24 Nov 2022 16:35:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Nov 2022 11:35:17 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Nov 2022 11:35:16 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Zack Weinberg <zack@owlfolio.org>, phillip.wood@dunelm.org.uk,
        git@vger.kernel.org
Subject: Re: [bug] git log --invert-grep --grep=[sufficiently complicated
 regex] prints nothing
Message-ID: <Y3+dRELMa8AXZ0tZ@coredump.intra.peff.net>
References: <71fcf215-101e-4398-bffa-4ed7e286d9c8@app.fastmail.com>
 <909b0770-2ac2-1a87-498b-0537a94e94ac@dunelm.org.uk>
 <cfbd647e-0e66-4417-8c94-c8cac905a78a@app.fastmail.com>
 <221124.861qpspckm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221124.861qpspckm.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 24, 2022 at 04:53:28PM +0100, Ævar Arnfjörð Bjarmason wrote:

> This doesn't help with your case, but I remember there being some
> similar confusions and/or expectations mismatches reported in the
> patch. E.g. "--since" here:
> https://lore.kernel.org/git/220401.86pmm1nmvh.gmgdl@evledraar.gmail.com/
> 
> I couldn't find a reference quickly, but I seem to recall (but perhaps
> I'm imagining it) that we had a report/discussion semi-recently about:
> 
> 	git log --reverse --follow -- path
> 
> Which has a similar edge case, e.g. try on git.git:
> 
> 	git log --reverse --follow -- object-name.c
> 
> That's also "correct" if you look at it from the POV of how we implement
> it, i.e. we'll traverse, and the rename to object-name.c is the first
> time we encounter the name from the POV of the walking logic.

I think all of this goes back to Linus's original "--follow is a hack I
bolted on" implementation. It probably should happen up-front as part of
the history simplification. I think it's a combination of nobody wanting
to do the work to extract that, and that it may produce less "streaming"
output, as we have to do a lot more work before producing the first line
of output.

-Peff
