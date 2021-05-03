Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEB2C433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 20:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8947261208
	for <git@archiver.kernel.org>; Mon,  3 May 2021 20:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhECUrW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 16:47:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:43630 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhECUrT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 16:47:19 -0400
Received: (qmail 7678 invoked by uid 109); 3 May 2021 20:46:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 May 2021 20:46:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7673 invoked by uid 111); 3 May 2021 20:46:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 May 2021 16:46:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 May 2021 16:46:23 -0400
From:   Jeff King <peff@peff.net>
To:     Daniel Carpenter <dc@ammonit.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: http.sslVersion only specifies minimum TLS version, later
 versions are allowed
Message-ID: <YJBhH0eLKRSpPFy3@coredump.intra.peff.net>
References: <8f664b07d1df45bcb6b3f787f42bd046@ammonit.com>
 <87pmy7x6le.fsf@evledraar.gmail.com>
 <YJAEVMeY9v/j6PeS@coredump.intra.peff.net>
 <ed63aa37ef0547bd97a5d965fb5e123f@ammonit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed63aa37ef0547bd97a5d965fb5e123f@ammonit.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 03, 2021 at 03:02:10PM +0000, Daniel Carpenter wrote:

> > Just looking at how the curl binary does it, "--tlsv1.2" means "1.2 or
> > greater" (which is not at all surprising; the library interface tends to
> > mirror their command-line and vice versa, and our behavior is influenced
> > by the library interface here).  But that implies to me that curl folks
> > considered this and though the "or greater" behavior was useful (which
> > makes sense -- the main goal is probably to avoid insecurities in older
> > versions of the protocol).
> > 
> > Anyway, the binary also has --tls-max for capping the maximum version.
> > That seems more flexible in general than "use this version exactly" (if
> > you only care that 1.3 is broken, then setting "max=1.2" lets you talk
> > to servers that support 1.1 or 1.2).
> > 
> > -Peff
> 
> I agree that the current behaviour is better for most users, and that
> some kind of separate "max" config option would work for anyone in my
> situation.
> 
> Another idea would be to keep the current behaviour for
> `http.sslVersion`, but use an exact match with the environment
> variable only. That already takes priority, and I imagine its main
> appeal over the config option is for users that want to try something
> with a specific TLS version.

I think you're right that it may work for many people, but I'd shy away
from it simply because it's subtle and hard to explain.

Adding config and environment variables for "max" is pretty
straight-forward to explain. I think it would also make sense to improve
the documentation for http.sslVersion to make it clear that this is a
minimum (the current wording is quite misleading).

-Peff
