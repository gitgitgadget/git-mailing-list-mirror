Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E0CC433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 19:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FE0C20838
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 19:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgHLT5E (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:57:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:56966 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbgHLT5E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 15:57:04 -0400
Received: (qmail 11845 invoked by uid 109); 12 Aug 2020 19:57:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Aug 2020 19:57:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3757 invoked by uid 111); 12 Aug 2020 19:57:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Aug 2020 15:57:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 Aug 2020 15:57:03 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/11] renaming argv_array
Message-ID: <20200812195703.GA1340519@coredump.intra.peff.net>
References: <20200728202124.GA1021264@coredump.intra.peff.net>
 <82991f30-fe37-d6d2-ffd5-8b0878f46c83@web.de>
 <20200812150611.GA33189@coredump.intra.peff.net>
 <20200812151038.GB33189@coredump.intra.peff.net>
 <045ea49b-7165-0f45-e670-a24bf648f880@web.de>
 <20200812170849.GA43566@coredump.intra.peff.net>
 <13d0b147-3c62-5d73-630e-2305c08c3ab1@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13d0b147-3c62-5d73-630e-2305c08c3ab1@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 12, 2020 at 08:18:33PM +0200, René Scharfe wrote:

> Am 12.08.20 um 19:08 schrieb Jeff King:
> > Yeah, I've had various issues with the packaging. For a long time they
> > had 1.0.7 in experimental, but with no python support. I wonder if it's
> > worth starting to use python scriptlets in our coccinelle rules, as
> > described in 4d168e742a (coccinelle: use <...> for function exclusion,
> > 2018-08-28). They're faster and IMHO easier to understand.
> 
> The idea to use Python as a faster alternative to anything makes me
> a bit uneasy.  That can't be right. ;-)

Well, when you're comparing it to some exponential algorithm with the
other technique, even a scripted language can do well. :)

I definitely remember getting big speedups back at the time of that
commit. But applying the patch below, building object_id.cocci.patch
actually gets a few seconds slower. So maybe something changed between
the various coccinelle versions. At any rate, it doesn't seem worth
pursuing further.

> > Of course I tried it out and got some inscrutable errors:
> >
> >   SPATCH contrib/coccinelle/object_id.cocci
> >   init_defs_builtins: /usr/bin/../lib/coccinelle/standard.h
> >   Python path configuration:
> >     PYTHONHOME = '/lib/x86_64-linux-gnu/..'
> 
> This looks bogus.  Can you try to unset this environment variable?
> Or set it to "/usr"?

It's not set in my environment. However, I was able to solve it by
fiddling with my system python packages (I'm not sure of the exact
cause; it was a case of corrected-while-testing).

-Peff
