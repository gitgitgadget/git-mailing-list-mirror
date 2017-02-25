Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C9082022D
	for <e@80x24.org>; Sat, 25 Feb 2017 09:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751577AbdBYJjP (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 04:39:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:33950 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751571AbdBYJjP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 04:39:15 -0500
Received: (qmail 27406 invoked by uid 109); 25 Feb 2017 09:32:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Feb 2017 09:32:33 +0000
Received: (qmail 28575 invoked by uid 111); 25 Feb 2017 09:32:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Feb 2017 04:32:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Feb 2017 04:32:32 -0500
Date:   Sat, 25 Feb 2017 04:32:32 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] interoperability test harness
Message-ID: <20170225093231.k7jtvx47jieka7qm@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds a small test harness for interoperability tests. The
heavy lifting is done by the normal test-lib.sh; this just makes it easy
for you to have access to two git versions at the same time.

This is something I've wanted a few times in the past when we make a
fix that can only be tested when interacting with a different version of
git.  As we start to work on changes like new protocols or hash
functions, this will hopefully make it easier to demonstrate what
happens when an older version of git encounters our new features.

This doesn't run when the regular test suite runs (it's likely to be a
bit flakier, as it actually has to build the alternative versions
separately). So I don't necessarily expect people to run it all the
time. But it lets us write down in a repeatable way the sorts of testing
that often ends up being done manually (or not at all) today.

This series just adds the harness and a basic test that we can still
clone from modern git using v1.0.0 (yay!). If people are interested, I
suspect there are previous cases that could be backfilled. A few I can
think of are:

  1. How older versions handle repositoryformatversion=2.

  2. Newer clients hitting older servers without various capabilities.
     One example is in:

       http://public-inbox.org/git/1433961320-1366-1-git-send-email-adgar@google.com/

  3. Vice-versa: older clients without capabilities hitting newer
     servers (especially in exotic situations, like shallow clone).

I don't think there's a huge value in doing that for old changes unless
somebody has actively reported a problem. So only do it if it sounds
like a fun experiment. :)

  [1/2]: t: add an interoperability test harness
  [2/2]: t/interop: add test of old clients against modern git-daemon

 Makefile                      |  3 ++
 t/interop/.gitignore          |  4 ++
 t/interop/Makefile            | 16 ++++++++
 t/interop/README              | 84 +++++++++++++++++++++++++++++++++++++++
 t/interop/i0000-basic.sh      | 27 +++++++++++++
 t/interop/i5500-git-daemon.sh | 41 +++++++++++++++++++
 t/interop/interop-lib.sh      | 92 +++++++++++++++++++++++++++++++++++++++++++
 t/lib-git-daemon.sh           |  3 +-
 8 files changed, 269 insertions(+), 1 deletion(-)
 create mode 100644 t/interop/.gitignore
 create mode 100644 t/interop/Makefile
 create mode 100644 t/interop/README
 create mode 100755 t/interop/i0000-basic.sh
 create mode 100755 t/interop/i5500-git-daemon.sh
 create mode 100644 t/interop/interop-lib.sh

-Peff
