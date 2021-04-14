Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD577C433B4
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 05:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DA9E61176
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 05:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347243AbhDNFV4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 01:21:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:52016 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347232AbhDNFVv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 01:21:51 -0400
Received: (qmail 3266 invoked by uid 109); 14 Apr 2021 05:21:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Apr 2021 05:21:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4172 invoked by uid 111); 14 Apr 2021 05:21:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Apr 2021 01:21:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Apr 2021 01:21:28 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/2] git-compat-util.h: clarify comment on GCC-specific
 code
Message-ID: <YHZ72NVfEUXZmBoz@coredump.intra.peff.net>
References: <YHOLo36MfuTj6YeD@camp.crustytoothpaste.net>
 <cover-0.2-00000000000-20210412T105422Z-avarab@gmail.com>
 <patch-1.2-a8cc05cf56f-20210412T105422Z-avarab@gmail.com>
 <YHVPAGVDjS1EH6L3@coredump.intra.peff.net>
 <xmqqblahlwqm.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqblahlwqm.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 13, 2021 at 02:07:13PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> + * We restrict this trick to gcc, though, because while we rely on the
> >> + * presence of C99 variadic macros, this code also relies on the
> >> + * non-standard behavior of GCC's __VA_ARGS__, allowing error() to
> >> + * work even if no format specifiers are passed to error().
> 
> The last part of this comment is puzzlling.  Do we ever call error()
> without any format specifier?  There may be GCC-ism behaviour around
> the __VA_ARGS__ stuff, but are we relying on that GCC-ism?

I took "format specifier" to mean the "%" code within the format. E.g.:

  error("foo");

has no format specifier, and thus no arguments after the format. But
every call will have at least the format string itself.

AFAIK, portably using variadic macros means you need there to always be
at least one argument. Hence "error(fmt, ...)" is wrong (the "..." may
have no arguments) but "error(...)" is OK (you always have a format
string). I'm not sure if Ævar knows about some other portability gotcha,
or if he just didn't realize that this was written in the portable way.

-Peff
