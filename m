Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4790B1F404
	for <e@80x24.org>; Thu, 15 Feb 2018 22:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756171AbeBOWJ4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 17:09:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:54498 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752862AbeBOWJz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 17:09:55 -0500
Received: (qmail 18366 invoked by uid 109); 15 Feb 2018 22:09:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Feb 2018 22:09:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14841 invoked by uid 111); 15 Feb 2018 22:10:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Feb 2018 17:10:39 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Feb 2018 17:09:52 -0500
Date:   Thu, 15 Feb 2018 17:09:52 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org, tboegi@web.de,
        j6t@kdbg.org, sunshine@sunshineco.com, ramsay@ramsayjones.plus.com,
        Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v7 0/7] convert: add support for different encodings
Message-ID: <20180215220952.GA23970@sigill.intra.peff.net>
References: <20180215152711.158-1-lars.schneider@autodesk.com>
 <xmqqr2pm81hh.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr2pm81hh.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 15, 2018 at 12:03:06PM -0800, Junio C Hamano wrote:

> And from that point of view, perhaps w-t-e attribute is somewhat
> misdesigned.
> 
> In general, an attribute is about the project's contents in the
> manner independent of platform or environment.  You define "this
> file is a C source" or "this file has JPEG image" there.  What exact
> program you use to present diffs between the two versions of such a
> file (external diff command) or what exact program you use to
> extract the textual representations (textconv filter) is environment
> and platform dependent and is left to the configuration mechanism
> for each repository.
> 
> To be in line with the above design principle, I think the attribute
> ought to be "the in-tree contents of this path is encoded in ..."
> whose values could be things like UTF-8, ShiftJIS, etc.  What
> external encoding the paths should be checked out is not a
> project-wide matter, especially when talking about cross platform
> projects.  Perhaps a project in Japanese language wants to check
> out its contents in EUC-jp on Unices and in ShiftJIS on DOS derived
> systems.  The participants all need to know what in-repository
> encoding is used, which is a sensible use of attributes.  They also
> need to know what the recommended external encoding to be used in
> the working tree is for their platforms, but that is more like what
> Makefile variable to set for their platforms, etc., and is not a
> good match to the attributes system.

While I agree what you're saying philosophically here, I suspect you'd
still need another attribute for "no really, this needs to be checked
out as encoding X". The same way we treat line endings as a platform
decision, but we still need to have `eol=crlf` for those files which
really, no matter what platform you're on, have external tools depending
on them to have some particular line ending.

So a full proposal would support both cases: "check this out in the
local platform's preferred encoding" and "always check this out in
_this_ encoding". And Lars's proposal is just the second half of that.

But I'm not sure anybody even really cares about the first part; I don't
think we've seen anybody actually ask for it.

-Peff
