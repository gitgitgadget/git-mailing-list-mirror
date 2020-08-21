Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59322C433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B0122076E
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgHUVFH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:05:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:37668 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgHUVFH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 17:05:07 -0400
Received: (qmail 21241 invoked by uid 109); 21 Aug 2020 21:05:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Aug 2020 21:05:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 525 invoked by uid 111); 21 Aug 2020 21:05:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Aug 2020 17:05:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Aug 2020 17:05:05 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] strmap: add functions facilitating use as a
 string->int map
Message-ID: <20200821210505.GB11806@coredump.intra.peff.net>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <418975b46039f63476852a868ca6221244b5d88e.1598035949.git.gitgitgadget@gmail.com>
 <20200821201034.GG1165@coredump.intra.peff.net>
 <CABPp-BFi7JSkkVSLkS9Kb5fMJ3xM3CjM7_ZsvJZMv=XgQgb6Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BFi7JSkkVSLkS9Kb5fMJ3xM3CjM7_ZsvJZMv=XgQgb6Lw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 21, 2020 at 01:51:57PM -0700, Elijah Newren wrote:

> > I think wrapping this kind of hackery is worth doing.
> >
> > You'd be able to use put() as usual, wouldn't you? It never deallocates
> > the util field, but just returns the old one. And the caller knows that
> > it's really an int, and shouldn't be deallocated.
> 
> You can use put() as normal, if you don't mind the need to explicitly
> throw in a typecast when you use it.  In fact, strintmap_set() does no
> more than typecasting the int to void* and otherwise calling
> strmap_put().

Yeah, I think hiding the type-casting is worth it alone. I was just
confused by your remark.

> I initially called that strintmap_put(), but got confused once or
> twice and looked up the function definition to make sure there wasn't
> some deallocation I needed to handle.  After that, I decided to just
> rename to _set() because I thought it'd reduce the chance of myself or
> others wondering about that in the future.

Yeah, I'd agree that is a much better name. Since there's an "incr",
having a specific "set" makes it clear that we're overwriting.

> >   struct strintmap {
> >           struct strmap strmap;
> >   };
> [...]
> I like this idea and the extra safety it provides.  Most of strintmap
> is static inline functions anyway, adding a few more wouldn't hurt.

OK. Then I guess we can't cheat our way out of picking a name with
strmap_getint(). :)

-Peff
