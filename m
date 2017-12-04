Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF7EA20954
	for <e@80x24.org>; Mon,  4 Dec 2017 17:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbdLDRNO (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 12:13:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:47532 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752025AbdLDRNL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 12:13:11 -0500
Received: (qmail 430 invoked by uid 109); 4 Dec 2017 17:13:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Dec 2017 17:13:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24779 invoked by uid 111); 4 Dec 2017 17:13:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 04 Dec 2017 12:13:31 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Dec 2017 12:13:08 -0500
Date:   Mon, 4 Dec 2017 12:13:08 -0500
From:   Jeff King <peff@peff.net>
To:     Florian Manschwetus <manschwetus@cs-software-gmbh.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v6 1/2] http-backend: respect CONTENT_LENGTH as specified
 by rfc3875
Message-ID: <20171204171308.GA13332@sigill.intra.peff.net>
References: <20171126193813.12531-1-max@max630.net>
 <20171126193813.12531-2-max@max630.net>
 <20171129032214.GB32345@sigill.intra.peff.net>
 <xmqqr2sclj2q.fsf@gitster.mtv.corp.google.com>
 <20171203024958.GA31493@sigill.intra.peff.net>
 <xmqq1skcjqer.fsf@gitster.mtv.corp.google.com>
 <F0F5A56A22F20D4CB4A03BB8D66587970253F87B86@SERVER2011.CS-SOFTWARE.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <F0F5A56A22F20D4CB4A03BB8D66587970253F87B86@SERVER2011.CS-SOFTWARE.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 04, 2017 at 07:18:55AM +0000, Florian Manschwetus wrote:

> I could provide a bash script I used in between to make this working
> with IIS, without fixing http-backend binary, maybe this helps to
> understand how this cases might be handled.

I think it would be pretty easy to handle all cases by inserting another
process in front of http-backend that just reads $CONTENT_LENGTH bytes
and then gives an EOF to http-backend. I assume that's what your bash
script does. It's just that this passes the data through an extra layer
of pipes.

If that's an acceptable tradeoff, it seems like an ideal solution from a
maintainability standpoint, since it skips all the tricky situations
inside the http-backend code.

-Peff
