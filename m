Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D18F51F404
	for <e@80x24.org>; Fri, 26 Jan 2018 18:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752461AbeAZSnW (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 13:43:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:59072 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752420AbeAZSnW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 13:43:22 -0500
Received: (qmail 16003 invoked by uid 109); 26 Jan 2018 18:43:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 26 Jan 2018 18:43:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17442 invoked by uid 111); 26 Jan 2018 18:44:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 26 Jan 2018 13:44:00 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jan 2018 13:43:20 -0500
Date:   Fri, 26 Jan 2018 13:43:20 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 08/10] t: forbid piping into 'test_i18ngrep'
Message-ID: <20180126184319.GE27618@sigill.intra.peff.net>
References: <20180126123708.21722-1-szeder.dev@gmail.com>
 <20180126123708.21722-9-szeder.dev@gmail.com>
 <xmqq1sic8omp.fsf@gitster.mtv.corp.google.com>
 <xmqqshas79di.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqshas79di.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 26, 2018 at 10:39:05AM -0800, Junio C Hamano wrote:

> Is there a case where test_i18ngrep (after your clean-ups in this
> series up to 06/10) needs to read from more than one file?
> 
> I actually think that the kind of inconveniences we *can* work with,
> without risking breakage to legitimate test, would be to allow and
> require test_i18ngrep to name and read only from one file that
> appears at the end of its command line.  IOW, instead of doing a
> probing "read" that you cannot undo and break legitimate test, I
> think it is OK to see if the last token names a file that is on the
> filesystem, e.g.
> 
> 	test_i18ngrep () {
> 		eval test -f \"\${$#}\" ||
> 		error "bug in the test sript: test_i18ngrep must" \
> 		      "name a file to read as the last token on the command line"

FWIW I like that much more than the weird "read" thing. It would also
disallow "-", but we could make an exception for that if we choose to.

-Peff
