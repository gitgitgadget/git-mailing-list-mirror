Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F67C1F935
	for <e@80x24.org>; Wed, 21 Sep 2016 22:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932313AbcIUWER (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 18:04:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:46349 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754056AbcIUWEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 18:04:16 -0400
Received: (qmail 21188 invoked by uid 109); 21 Sep 2016 22:04:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Sep 2016 22:04:16 +0000
Received: (qmail 3545 invoked by uid 111); 21 Sep 2016 22:04:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Sep 2016 18:04:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Sep 2016 18:04:13 -0400
Date:   Wed, 21 Sep 2016 18:04:13 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Benjamin Kramer <benny.kra@googlemail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v4 0/3] Fix a segfault caused by regexec() being called
 on mmap()ed data
Message-ID: <20160921220413.5iedndabx7v6wdl7@sigill.intra.peff.net>
References: <cover.1473321437.git.johannes.schindelin@gmx.de>
 <cover.1474482164.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1474482164.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 21, 2016 at 08:23:11PM +0200, Johannes Schindelin wrote:

> We solve this by introducing a helper, regexec_buf(), that takes a
> pointer and a length instead of a NUL-terminated string.
> 
> This helper then uses REG_STARTEND where available, and falls back to
> allocating and constructing a NUL-terminated string. Given the
> wide-spread support for REG_STARTEND (Linux has it, MacOSX has it, Git
> for Windows has it because it uses compat/regex/ that has it), I think
> this is a fair trade-off.

I did a double-take on this, but then read:

> Changes since v3:
> [...]
> - removed fallback when REG_STARTEND is not supported, in favor of
>   requiring NO_REGEX.

So I think we are all in agreement. :)

With the exception of a few commit message fixups that Junio already
pointed out, this looks good to me. Thanks.

-Peff
