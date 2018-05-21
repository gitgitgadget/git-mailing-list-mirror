Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4C181F51C
	for <e@80x24.org>; Mon, 21 May 2018 19:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751127AbeEUTlW (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 15:41:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:48256 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751050AbeEUTlW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 15:41:22 -0400
Received: (qmail 28053 invoked by uid 109); 21 May 2018 19:41:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 21 May 2018 19:41:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31223 invoked by uid 111); 21 May 2018 19:41:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 21 May 2018 15:41:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 May 2018 15:41:20 -0400
Date:   Mon, 21 May 2018 15:41:20 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH 1/5] http: use strbufs instead of fixed buffers
Message-ID: <20180521194120.GA9742@sigill.intra.peff.net>
References: <20180519015444.GA12080@sigill.intra.peff.net>
 <20180519015636.GA32492@sigill.intra.peff.net>
 <CAGZ79kYZ9HSCC95qCZ4Zix1oEFLscsU1HZe64s--6KuWEz2ojg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYZ9HSCC95qCZ4Zix1oEFLscsU1HZe64s--6KuWEz2ojg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 21, 2018 at 11:11:51AM -0700, Stefan Beller wrote:

> Hi Jeff,
> 
> On Fri, May 18, 2018 at 6:56 PM, Jeff King <peff@peff.net> wrote:
> 
> > @@ -2421,4 +2426,5 @@ void release_http_object_request(struct http_object_request *freq)
> ..
> > +       strbuf_release(&freq->tmpfile);
> 
> Do we need an equivalent in release_http_pack_request as well?

Yes, but isn't there one?

From the original patch:

--- a/http.c
+++ b/http.c
@@ -2082,6 +2082,7 @@ void release_http_pack_request(struct http_pack_request *preq)
                preq->packfile = NULL;
        }
        preq->slot = NULL;
+       strbuf_release(&preq->tmpfile);
        free(preq->url);
        free(preq);
 }

Or am I missing something?

-Peff
