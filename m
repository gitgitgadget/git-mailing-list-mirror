Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B0761FA14
	for <e@80x24.org>; Tue, 11 Apr 2017 10:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754149AbdDKKLB (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 06:11:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:59726 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754164AbdDKKKO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 06:10:14 -0400
Received: (qmail 21488 invoked by uid 109); 11 Apr 2017 10:10:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 10:10:13 +0000
Received: (qmail 32758 invoked by uid 111); 11 Apr 2017 10:10:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 06:10:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Apr 2017 06:10:10 -0400
Date:   Tue, 11 Apr 2017 06:10:10 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 02/12] grep: remove redundant regflags assignment under
 PCRE
Message-ID: <20170411101010.fl437hkvidkkx54w@sigill.intra.peff.net>
References: <20170408132506.5415-1-avarab@gmail.com>
 <20170408132506.5415-3-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170408132506.5415-3-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 08, 2017 at 01:24:56PM +0000, Ævar Arnfjörð Bjarmason wrote:

> Remove a redundant assignment to the "regflags" variable. This
> variable is only used for POSIX regular expression matching, not when
> the PCRE library is used.
> 
> This redundant assignment was added as a result of copy/paste
> programming in commit 84befcd0a4 ("grep: add a grep.patternType
> configuration setting", 2012-08-03). That commit modified already
> working code in commit cca2c172e0 ("git-grep: do not die upon -F/-P
> when grep.extendedRegexp is set.", 2011-05-09) which didn't assign to
> regflags when under PCRE.
> 
> Revert back to that behavior, more to reduce "wait this is used under
> PCRE how?" confusion when reading the code, than to to save ourselves
> trivial CPU cycles by removing one assignment.

Right, this makes sense. I wondered if there might be an obscure case
where we set the flag, but I couldn't find one.

-Peff
