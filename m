Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 711202023C
	for <e@80x24.org>; Fri,  8 Jul 2016 09:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754315AbcGHJIK (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 05:08:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:41846 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754160AbcGHJII (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 05:08:08 -0400
Received: (qmail 4893 invoked by uid 102); 8 Jul 2016 09:08:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 05:08:10 -0400
Received: (qmail 11814 invoked by uid 107); 8 Jul 2016 09:08:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 05:08:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Jul 2016 05:08:05 -0400
Date:	Fri, 8 Jul 2016 05:08:05 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/8] am: ignore return value of write_file()
Message-ID: <20160708090805.GB10152@sigill.intra.peff.net>
References: <20160708090400.GA26594@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160708090400.GA26594@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: René Scharfe <l.s.r@web.de>

write_file() either returns 0 or dies, so there is no point in checking
its return value.  The callers of the wrappers write_state_text(),
write_state_count() and write_state_bool() consequently already ignore
their return values.  Stop pretending we care and make them void.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
Signed-off-by: Jeff King <peff@peff.net>
---
I included this just to make it clear that I am building on top. You
can also just apply on top of the existing branch (though note that I
fixed a typo s/pretenting/pretending/ in the commit message).

 builtin/am.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index d5da5fe..339e360 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -184,22 +184,22 @@ static inline const char *am_path(const struct am_state *state, const char *path
 /**
  * For convenience to call write_file()
  */
-static int write_state_text(const struct am_state *state,
-			    const char *name, const char *string)
+static void write_state_text(const struct am_state *state,
+			     const char *name, const char *string)
 {
-	return write_file(am_path(state, name), "%s", string);
+	write_file(am_path(state, name), "%s", string);
 }
 
-static int write_state_count(const struct am_state *state,
-			     const char *name, int value)
+static void write_state_count(const struct am_state *state,
+			      const char *name, int value)
 {
-	return write_file(am_path(state, name), "%d", value);
+	write_file(am_path(state, name), "%d", value);
 }
 
-static int write_state_bool(const struct am_state *state,
-			    const char *name, int value)
+static void write_state_bool(const struct am_state *state,
+			     const char *name, int value)
 {
-	return write_state_text(state, name, value ? "t" : "f");
+	write_state_text(state, name, value ? "t" : "f");
 }
 
 /**
-- 
2.9.0.393.g704e522

