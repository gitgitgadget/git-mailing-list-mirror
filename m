Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45FAC433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88E0B611C5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbhIJPVY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 11:21:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:44032 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234384AbhIJPVY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 11:21:24 -0400
Received: (qmail 6086 invoked by uid 109); 10 Sep 2021 15:20:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Sep 2021 15:20:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26073 invoked by uid 111); 10 Sep 2021 15:20:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Sep 2021 11:20:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Sep 2021 11:20:11 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 0/8] post-v2.33 "drop support for ancient curl"
 follow-up
Message-ID: <YTt3qwVPXEkgh6LP@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
 <YTtttIuur0JvcPub@coredump.intra.peff.net>
 <87lf44cvkp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lf44cvkp.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 10, 2021 at 05:08:32PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > So I dunno. I do not have any clever solution that would have caught
> > this automatically without creating an even bigger maintenance headache.
> 
> Yeah, ideally we'd have tests for these optional features, and we'd then
> just add them to GIT-BUILD-OPTIONS and skip dedicated tests
> appropriately, then it would be more visible to see those tests
> skipped. Presumably someone testing this would run "make test" against a
> glob that includes *curl*.
> 
> But that's not easy to do in practice since the flags are either not
> visible from the outside in terms of behavior, or if they are it's all
> something that requires proxies, SSL etc, which we don't test currently.
> 
> We can and should test that, but requires e.g. extending lib-httpd.sh to
> start apache with ssl support, or maybe we could do it more easily with
> an optional stunnel or something...

Yeah, even after we get the right version/feature flags into the test
suite, most of these are pretty obscure and hard to test.

I definitely think that's not something we should worry about for this
series.

> > (Though for other reasons, it might be nice to report the curl version
> > from "git version --build-options". This is a bit tricky because we
> > avoid linking at libcurl at all in the main binary. Definitely
> > orthogonal to your series, anyway).
> 
> We could always ship a git-version-curl and shell out to it, or embed
> the version curl-config --vernum gave us at compile time via Makefile ->
> -DGIT_CURL_VERSION.

Yeah, I was thinking "git remote-curl --curl-version" or something.
Let's punt on it for now, though. I think this series is getting close
to ready, and this is all only semi-related.

-Peff
