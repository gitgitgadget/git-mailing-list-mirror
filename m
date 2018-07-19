Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C5881F597
	for <e@80x24.org>; Thu, 19 Jul 2018 20:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbeGSVRr (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 17:17:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:53198 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727485AbeGSVRr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 17:17:47 -0400
Received: (qmail 8847 invoked by uid 109); 19 Jul 2018 20:33:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Jul 2018 20:33:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16480 invoked by uid 111); 19 Jul 2018 20:33:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 19 Jul 2018 16:33:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jul 2018 16:33:00 -0400
Date:   Thu, 19 Jul 2018 16:33:00 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/2] fail compilation with strcpy
Message-ID: <20180719203259.GA7869@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a patch series to address the discussion in the thread at:

  https://public-inbox.org/git/20180713204350.GA16999@sigill.intra.peff.net/

Basically, the question was: can we declare strcpy banned and have a
linter save us the trouble of finding it in review. The answer is yes,
the compiler is good at that. ;)

There are probably as many lists of banned functions as there are coding
style documents. I don't agree with every entry in the ones I've seen.
And in many cases coccinelle is a better choice, because the problem is
not "this function is so bad your patch should not even make it to the
list with it", but "don't do it like A; we prefer to do it like B
instead". And coccinelle does the latter more flexibly and
automatically.

So I tried to pick some obvious and uncontroversial candidates here.
gets() could be another one, but it's mostly banned already (it's out of
the standard, and most libcs mark it with a deprecated attribute).

Note that this needs to be applied on top of 022d2ac1f3 (blame: prefer
xsnprintf to strcpy for colors, 2018-07-13) or it will complain loudly. :)

  [1/2]: introduce "banned function" list
  [2/2]: banned.h: mark strncpy as banned

 Documentation/CodingGuidelines |  3 +++
 banned.h                       | 20 ++++++++++++++++++++
 git-compat-util.h              |  2 ++
 3 files changed, 25 insertions(+)
 create mode 100644 banned.h

-Peff
