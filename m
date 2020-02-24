Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E96BC35641
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 04:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8D920656
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 04:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgBXEwP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 23:52:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:52390 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727186AbgBXEwO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 23:52:14 -0500
Received: (qmail 5327 invoked by uid 109); 24 Feb 2020 04:52:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Feb 2020 04:52:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7114 invoked by uid 111); 24 Feb 2020 05:01:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Feb 2020 00:01:19 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 23 Feb 2020 23:52:13 -0500
From:   Jeff King <peff@peff.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] Remove non-SHA1dc sha1 implementations
Message-ID: <20200224045213.GA1574706@coredump.intra.peff.net>
References: <xmqqk14rtonu.fsf@gitster-ct.c.googlers.com>
 <20200223223758.120941-1-mh@glandium.org>
 <20200224044732.GK1018190@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200224044732.GK1018190@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 23, 2020 at 11:47:32PM -0500, Jeff King wrote:

> One thing that compels me is the recent report that we still build with
> common crypto by default on macOS, which was definitely _not_ intended.
> That's a bug that can be fixed, but it wouldn't have happened in the
> first place if we only supported sha1dc.

I just noticed you were the original reporter there, too. So I guess it
compelled you, too. ;)

If we do want to keep the other implementations around, another thing
that might be worth doing is to teach t0013 to complain when the
collision-detecting sha1 is not in use (i.e., rather than auto-skipping
when built without DC_SHA1, require the user to set a special
NO_REALLY_I_CHOOSE_NOT_TO_USE_DC_SHA1_AND_AM_AWARE_OF_THE_IMPLICATIONS
variable). That would provide a cross-check on the build flags.

-Peff
