Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56E5B1FA14
	for <e@80x24.org>; Tue, 11 Apr 2017 10:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754412AbdDKKf2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 06:35:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:59794 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754393AbdDKKf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 06:35:27 -0400
Received: (qmail 24122 invoked by uid 109); 11 Apr 2017 10:35:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 10:35:26 +0000
Received: (qmail 852 invoked by uid 111); 11 Apr 2017 10:35:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 06:35:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Apr 2017 06:35:24 -0400
Date:   Tue, 11 Apr 2017 06:35:24 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 10/12] grep: change the internal PCRE macro names to be
 PCRE1
Message-ID: <20170411103523.tlub4v65er32ikix@sigill.intra.peff.net>
References: <20170408132506.5415-1-avarab@gmail.com>
 <20170408132506.5415-11-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170408132506.5415-11-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 08, 2017 at 01:25:04PM +0000, Ævar Arnfjörð Bjarmason wrote:

> Change the internal USE_LIBPCRE define, & build options flag to use a
> naming convention ending in PCRE1, without changing the long-standing
> USE_LIBPCRE Makefile flag which enables this code.
> 
> This is for preparation for libpcre2 support where having things like
> USE_LIBPCRE and USE_LIBPCRE2 in any more places than we absolutely
> need to for backwards compatibility with old Makefile arguments would
> be confusing.
> 
> In some ways it would be better to change everything that now uses
> USE_LIBPCRE to use USE_LIBPCRE1, and to make specifying
> USE_LIBPCRE (or --with-pcre) an error. This would impose a one-time
> burden on packagers of git to s/USE_LIBPCRE/USE_LIBPCRE1/ in their
> build scripts.
> 
> However I'd like to leave the door open to making
> USE_LIBPCRE=YesPlease eventually mean USE_LIBPCRE2=YesPlease,
> i.e. once PCRE v2 is ubiquitous enough that it makes sense to make it
> the default.

Yeah, I think it's nice to keep the build-time knobs compatible. In the
long run I assume we'll want to add a USE_LIBPCRE1 flag and USE_LIBPCRE
just becomes a synonym for it (in fact, we could do that in this
commit).

I suspect we won't ever want to make it a synonym for USE_LIBPCRE2.
Unlike the run-time synonyms, where the expressions themselves are
backwards compatible, builders need to care which one they're using.

-Peff
