Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A6081F51C
	for <e@80x24.org>; Sat, 19 May 2018 01:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751851AbeESByt (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 21:54:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:46162 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750957AbeESBys (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 21:54:48 -0400
Received: (qmail 9090 invoked by uid 109); 19 May 2018 01:54:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 19 May 2018 01:54:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15830 invoked by uid 111); 19 May 2018 01:54:55 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 18 May 2018 21:54:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 May 2018 18:54:45 -0700
Date:   Fri, 18 May 2018 18:54:45 -0700
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/5] snprintf truncation fixes
Message-ID: <20180519015444.GA12080@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I happened today to be looking at a piece of code that used a bare
snprintf() without checking for truncation, and I got annoyed enough to
root out the last few cases in our codebase. After this series, looking
over the results of:

  git grep '[^vxn]snprintf' '*.c' :^compat

is pretty pleasant.

This series also gets rid of some uses of PATH_MAX, which is another pet
peeve of mine. :)

  [1/5]: http: use strbufs instead of fixed buffers
  [2/5]: log_write_email_headers: use strbufs
  [3/5]: query_fsmonitor: use xsnprintf for formatting integers
  [4/5]: shorten_unambiguous_ref: use xsnprintf
  [5/5]: fmt_with_err: add a comment that truncation is OK

 fsmonitor.c |  4 ++--
 http.c      | 66 +++++++++++++++++++++++++++++------------------------
 http.h      |  4 ++--
 log-tree.c  | 16 ++++++++-----
 refs.c      |  4 ++--
 usage.c     |  1 +
 6 files changed, 53 insertions(+), 42 deletions(-)

-Peff
