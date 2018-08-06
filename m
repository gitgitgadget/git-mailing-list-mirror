Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEA31208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 16:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbeHFTHP (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 15:07:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:44136 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728569AbeHFTHP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 15:07:15 -0400
Received: (qmail 16115 invoked by uid 109); 6 Aug 2018 16:57:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 Aug 2018 16:57:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27910 invoked by uid 111); 6 Aug 2018 16:57:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 06 Aug 2018 12:57:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Aug 2018 12:57:15 -0400
Date:   Mon, 6 Aug 2018 12:57:15 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] add a script to diff rendered documentation
Message-ID: <20180806165714.GC19053@sigill.intra.peff.net>
References: <20180803205204.GA3790@sigill.intra.peff.net>
 <20180805204930.GA202464@genre.crustytoothpaste.net>
 <20180806133954.GA31282@sigill.intra.peff.net>
 <20180806134237.GB31282@sigill.intra.peff.net>
 <xmqqd0uvr0dc.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd0uvr0dc.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 06, 2018 at 08:16:47AM -0700, Junio C Hamano wrote:

> It's a bit dissapointing that we cannot express personal preference
> in config.mak ;-)

Try this:

diff --git a/Makefile b/Makefile
index e7994888e8..36bddff3be 100644
--- a/Makefile
+++ b/Makefile
@@ -1119,6 +1119,11 @@ ifdef DEVELOPER
 include config.mak.dev
 endif
 
+ifneq ($(or $(J_RECURSED), $(J), done), done)
+%:
+	$(MAKE) -j$(J) J_RECURSED=done $@
+else
+
 comma := ,
 empty :=
 space := $(empty) $(empty)
@@ -3034,3 +3039,4 @@ cover_db: coverage-report
 cover_db_html: cover_db
 	cover -report html -outputdir cover_db_html cover_db
 
+endif


Pretty nasty. ;)

-Peff
