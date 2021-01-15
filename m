Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9ABC433E0
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 16:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 038A12339E
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 16:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbhAOQaX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 11:30:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:57386 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbhAOQaX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 11:30:23 -0500
Received: (qmail 2780 invoked by uid 109); 15 Jan 2021 16:29:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 15 Jan 2021 16:29:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30920 invoked by uid 111); 15 Jan 2021 16:29:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 Jan 2021 11:29:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 15 Jan 2021 11:29:41 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 04/11] sha1dc: mark forgotten message for translation
Message-ID: <YAHC9faa4ykNOWj6@coredump.intra.peff.net>
References: <pull.836.git.1610441262.gitgitgadget@gmail.com>
 <8f2c08474a75793c24af7d4ae44d73d2b23920bc.1610441263.git.gitgitgadget@gmail.com>
 <X/2J8KL/Jig/xttF@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2101151639030.52@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2101151639030.52@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 15, 2021 at 04:43:05PM +0100, Johannes Schindelin wrote:

> > > -	die("SHA-1 appears to be part of a collision attack: %s",
> > > +	die(_("SHA-1 appears to be part of a collision attack: %s"),
> > >  	    hash_to_hex_algop(hash, &hash_algos[GIT_HASH_SHA1]));
> >
> > I didn't find any list discussion, but I think I may have actually left
> > this untranslated intentionally. Like a BUG(), we'd expect it to come up
> > basically never. And when it does, being able to search for the exact
> > wording online may be more important than providing a translated
> > version.
> 
> I disagree with that reasoning. By that rationale, any message we deem to
> be somewhat rare should be _untranslated_.
> 
> A much better rule, at least from my perspective is: is the target
> audience the Git users? If so, the message is to be translated. If not,
> then not.

That's what I was getting at. The audience is really Git developers,
just like it would be for a BUG(). We don't expect either of those
things to happen.

> In this instance, it is quite obviously targeting the Git users who need
> to understand why the command they tried to run was failing. The test in
> t0013 is totally agreeing with this:
> 
> 	test_expect_success 'test-sha1 detects shattered pdf' '
> 		test_must_fail test-tool sha1 <"$TEST_DATA/shattered-1.pdf" 2>err &&
> 		test_i18ngrep collision err &&
> 		grep 38762cf7f55934b34d179ae6a4c80cadccbb7f0a err
> 	'
> 
> Notice that `test_i18ngrep`? It tells me that we expect this message to be
> translated.

Well, I wrote both that line and the untranslated original code, so I'm
not sure what we can deduce from that. ;)

But yeah, I am not strongly opposed to translating this. I brought it up
more in the line of "I don't think it's that big a deal that it was not
translated".

-Peff
