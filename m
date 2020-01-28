Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6CDC33CB3
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 09:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A4924684
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 09:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgA1JYQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 04:24:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:46128 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725271AbgA1JYP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 04:24:15 -0500
Received: (qmail 8584 invoked by uid 109); 28 Jan 2020 09:24:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 Jan 2020 09:24:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5726 invoked by uid 111); 28 Jan 2020 09:31:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jan 2020 04:31:46 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Jan 2020 04:24:14 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Zeger-Jan van de Weg <git@zjvandeweg.nl>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] config: learn the --stdin option for instructions
Message-ID: <20200128092414.GB574544@coredump.intra.peff.net>
References: <20200127100933.10765-1-git@zjvandeweg.nl>
 <20200127100933.10765-2-git@zjvandeweg.nl>
 <CAPig+cS03oS9PhN_cusjpzoCzwNmgc5rXiVAmG3ceUCFw71PVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cS03oS9PhN_cusjpzoCzwNmgc5rXiVAmG3ceUCFw71PVg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 27, 2020 at 11:59:03AM -0500, Eric Sunshine wrote:

> Second, this doesn't give any indication about how the lines should be
> terminated. It should instead be written as:
> 
>     set SP <key> NUL <value> NUL
>     unset SP <key> NUL
> 
> Third, importantly, unlike git-update-ref from which this DSL takes
> inspiration and in which "refs" might have oddball names for which
> NUL-termination makes sense, it's hard to imagine a case in which a
> configuration key would be so strange as to warrant NUL-termination.
> This observation suggests a simpler DSL in which only <value> is
> NUL-terminated:
> 
>     set SP <key> SP <value> NUL
>     unset SP <key> LF
> 
> (The proposed code changes in config.c would need adjustment, as well,
> to implement this revised DSL.)

The section and key parts of a config key are pretty restricted, but the
subsection portion can contain anything except newline and NUL. So in
particular, it would be valid to have a space, which would make the
input ambiguous.

I agree it would probably be rare, but isn't the whole point of "-z" to
be able to represent anything without worrying about quoting?

-Peff
