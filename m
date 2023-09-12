Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BB0CA0ECA
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 08:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbjILIkk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 04:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjILIke (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 04:40:34 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BD910CE
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 01:40:30 -0700 (PDT)
Received: (qmail 14606 invoked by uid 109); 12 Sep 2023 08:40:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Sep 2023 08:40:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16851 invoked by uid 111); 12 Sep 2023 08:40:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Sep 2023 04:40:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Sep 2023 04:40:29 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] parse-options: use and require int pointer for
 OPT_CMDMODE
Message-ID: <20230912084029.GD1630538@coredump.intra.peff.net>
References: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
 <e6d8a291-03de-cfd3-3813-747fc2cad145@web.de>
 <ZP2X9roiaeEjzf24@ugly>
 <15530a5f-8d06-24c9-bc2d-e313c895f477@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15530a5f-8d06-24c9-bc2d-e313c895f477@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 11, 2023 at 10:11:56PM +0200, René Scharfe wrote:

> Am 10.09.23 um 12:18 schrieb Oswald Buddenhagen:
> > On Sat, Sep 09, 2023 at 11:14:20PM +0200, René Scharfe wrote:
> >> Convert the offending OPT_CMDMODE users and use the typed value_int
> >> point in the macro's definition to enforce that type for future ones.
> >>
> > that defeats -Wswitch[-enum], though.
> 
> True.  Though I don't fully understand these warnings (why not then
> also warn about if without else?), but taking them away is a bit rude
> to those who care.

I think losing warnings is unfortunate, but it's just one example.
We're losing the type information completely from the values. That might
be of use to the compiler (both for -Wswitch, but also for code
generation in general). But it is also of use to human readers, who see
that "foo" is of type "enum bar" and know what it's supposed to contain.

> > the pedantically correct solution would be using setter callbacks.
> 
> Or to use an int to point to and then copy into a companion enum
> variable to after parsing, which would be my choice.

Yeah, I had the same thought. I'm just not sure how to do that in a way
that isn't a pain for the callers.

-Peff
