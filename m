Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 774B220248
	for <e@80x24.org>; Wed,  6 Mar 2019 19:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbfCFTFM (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 14:05:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:41278 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730655AbfCFTFM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 14:05:12 -0500
Received: (qmail 26855 invoked by uid 109); 6 Mar 2019 19:05:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Mar 2019 19:05:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16185 invoked by uid 111); 6 Mar 2019 19:05:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 06 Mar 2019 14:05:29 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Mar 2019 14:05:10 -0500
Date:   Wed, 6 Mar 2019 14:05:10 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: [PATCH] compat/bswap: add include header guards
Message-ID: <20190306190509.GA18239@sigill.intra.peff.net>
References: <20190301213619.GA1518@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903022058230.45@tvgsbejvaqbjf.bet>
 <20190303171951.GD23811@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903041206300.45@tvgsbejvaqbjf.bet>
 <20190304214155.GB3347@sigill.intra.peff.net>
 <xmqqzhq9vpik.fsf@gitster-ct.c.googlers.com>
 <20190305230723.GB22901@sigill.intra.peff.net>
 <42d125d4-76bf-afc3-8f12-a9fa1296c85c@ramsayjones.plus.com>
 <20190306044006.GA6664@sigill.intra.peff.net>
 <xmqqd0n4r2qm.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd0n4r2qm.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 06, 2019 at 02:28:01PM +0900, Junio C Hamano wrote:

> > +#ifndef COMPAT_BSWAP_H
> > +#define COMPAT_BSWAP_H
> [...]
> 
> This probably is worth having as an independent clean-up.

Yeah, let's do that now before we forget.

-- >8 --
Subject: [PATCH] compat/bswap: add include header guards

Our compat/bswap.h lacks the usual preprocessor guards against multiple
inclusion. This usually isn't an issue since it only gets included from
git-compat-util.h, which has its own guards. But it would produce
redeclaration errors if any file included it separately.

Our hdr-check target would complain about this, except that it currently
skips items in compat/ entirely.

Signed-off-by: Jeff King <peff@peff.net>
---
 compat/bswap.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/compat/bswap.h b/compat/bswap.h
index 5078ce5ecc..e4e25735ce 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -1,3 +1,6 @@
+#ifndef COMPAT_BSWAP_H
+#define COMPAT_BSWAP_H
+
 /*
  * Let's make sure we always have a sane definition for ntohl()/htonl().
  * Some libraries define those as a function call, just to perform byte
@@ -210,3 +213,5 @@ static inline void put_be64(void *ptr, uint64_t value)
 }
 
 #endif
+
+#endif /* COMPAT_BSWAP_H */
-- 
2.21.0.699.ge1748d4d73

