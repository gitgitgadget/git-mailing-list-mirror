Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D5FD1FA14
	for <e@80x24.org>; Tue, 11 Apr 2017 10:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754476AbdDKKaW (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 06:30:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:59777 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754466AbdDKKaV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 06:30:21 -0400
Received: (qmail 23579 invoked by uid 109); 11 Apr 2017 10:30:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 10:30:21 +0000
Received: (qmail 762 invoked by uid 111); 11 Apr 2017 10:30:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 06:30:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Apr 2017 06:30:18 -0400
Date:   Tue, 11 Apr 2017 06:30:18 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 08/12] grep: make grep.patternType=[pcre|pcre1] a synonym
 for "perl"
Message-ID: <20170411103018.dkq5gangx3vcxhp4@sigill.intra.peff.net>
References: <20170408132506.5415-1-avarab@gmail.com>
 <20170408132506.5415-9-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170408132506.5415-9-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 08, 2017 at 01:25:02PM +0000, Ævar Arnfjörð Bjarmason wrote:

> Make the pattern types "pcre" & "pcre1" synonyms for long-standing
> "perl" grep.patternType.
> 
> This change is part of a longer patch series to add pcre2 support to
> Git. It's nice to be able to performance test PCRE v1 v.s. v2 without
> having to recompile git, and doing that via grep.patternType makes
> sense.
> 
> However, just adding "pcre2" when we only have "perl" would be
> confusing, so start by adding a "pcre" & "pcre1" synonym.
> 
> In the future "perl" and "pcre" might be changed to default to "pcre2"
> instead of "pcre1", and depending on how Git is compiled the more
> specific "pcre1" or "pcre2" pattern types might produce an error.

I think this makes sense.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 475e874d51..5ef12d0694 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1624,6 +1624,15 @@ grep.patternType::
>  	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
>  	`--fixed-strings`, or `--perl-regexp` option accordingly, while the
>  	value 'default' will return to the default matching behavior.
> ++
> +The 'pcre' and 'pcre1' values are synonyms for 'perl'. The other
> +values starting with 'pcre' are reserved for future use, e.g. if we'd
> +like to use 'pcre2' for the PCRE v2 library.

Do you want to define this the other way around (that perl and pcre are
synonyms for pcre1)?

I know that hey are being added now as synonyms, but from the
perspective of the user (and this is the user-facing documentation), the
end-game we want is "you can pick pcre1 or pcre2, and the others are
floating synonyms that may change".

I think it would be OK to continue to refer to "perl" elsewhere. Even
though it's a synonym, it's the one we'd expect people to use.

-Peff
