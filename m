Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A24C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 19:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9064620870
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 19:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbgKCTX2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 14:23:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:46572 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbgKCTX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 14:23:28 -0500
Received: (qmail 6980 invoked by uid 109); 3 Nov 2020 19:23:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Nov 2020 19:23:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3837 invoked by uid 111); 3 Nov 2020 19:23:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Nov 2020 14:23:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Nov 2020 14:23:27 -0500
From:   Jeff King <peff@peff.net>
To:     Sathyajith Bhat <sathya@sathyasays.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: Segfault in git when using git logs
Message-ID: <20201103192327.GA462936@coredump.intra.peff.net>
References: <CAMsWJsyPVQWV++gc2YJriEOEWBELa_xj2G0NWFMSgNYt47swiQ@mail.gmail.com>
 <0581272e-6ad2-42d9-0196-b804ee304619@gmail.com>
 <CAMsWJsxyW=JUh=XGCkGG3LhOsZASwFHtx9b6ziNi_uHa918Scw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMsWJsxyW=JUh=XGCkGG3LhOsZASwFHtx9b6ziNi_uHa918Scw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 03, 2020 at 08:55:52PM +0200, Sathyajith Bhat wrote:

> I believe it is GitLens [1] which is causing the incorrect behaviour.
> I haven't had any crashes after I disabled GitLens, and that's the
> only extension I've had which interacts with scm.
> 
> [1] https://github.com/eamodio/vscode-gitlens

That makes sense. It seems pretty clear that its log__file() function
will produce this bogus combination. Despite having some indication that
it knows about the documentation forbidding it:

  https://github.com/eamodio/vscode-gitlens/blob/6cfd9fdedd7c6ec3bfa732af7c418bbbecdfba54/src/git/git.ts#L805

I don't know that project's code well enough to say whether there is a
higher-level bug there (the issue seems to be the "renames" flag being
enabled along with startLine; maybe the caller is wrong to specify
both).

-Peff
