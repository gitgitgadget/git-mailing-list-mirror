Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7226C20A17
	for <e@80x24.org>; Mon, 16 Jan 2017 22:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751749AbdAPWIb (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 17:08:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:39904 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751734AbdAPWI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 17:08:29 -0500
Received: (qmail 23443 invoked by uid 109); 16 Jan 2017 22:08:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Jan 2017 22:08:24 +0000
Received: (qmail 12603 invoked by uid 111); 16 Jan 2017 22:09:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Jan 2017 17:09:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jan 2017 17:08:21 -0500
Date:   Mon, 16 Jan 2017 17:08:21 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: [PATCH] CodingGuidelines: clarify multi-line brace style
Message-ID: <20170116220821.4tji5mrfcdbdpfuo@sigill.intra.peff.net>
References: <xmqqh94zbwlu.fsf@gitster.mtv.corp.google.com>
 <257b4175-9879-7814-5d8d-02050792574d@kdbg.org>
 <alpine.DEB.2.20.1701161251100.3469@virtualbox>
 <20170116160456.ltbb7ofe47xos7xo@sigill.intra.peff.net>
 <alpine.DEB.2.20.1701161746200.3469@virtualbox>
 <20170116220014.bwi5xi2br56lyqsw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170116220014.bwi5xi2br56lyqsw@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 16, 2017 at 05:00:14PM -0500, Jeff King wrote:

> > > Please don't. Obviously C treats the "if/else" as a single unit, but
> > > IMHO it's less error-prone to include the braces any time there are
> > > multiple visual lines. E.g., something like:
> > > 
> > >   while (foo)
> > > 	if (bar)
> > > 		one();
> > > 	else
> > > 		two();
> > > 	three();
> > > 
> > > is much easier to spot as wrong when you would require braces either
> > > way (and not relevant here, but I'd say that even an inner block with a
> > > comment deserves braces for the same reason).
> > 
> > There is no documentation about the preferred coding style.
> 
> Documentation/CodingGuidelines says:
> 
>  - We avoid using braces unnecessarily.  I.e.
> 
>         if (bla) {
>                 x = 1;
>         }
> 
>    is frowned upon.  A gray area is when the statement extends
>    over a few lines, and/or you have a lengthy comment atop of
>    it.  Also, like in the Linux kernel, if there is a long list
>    of "else if" statements, it can make sense to add braces to
>    single line blocks.
> 
> I think this is pretty clearly the "gray area" mentioned there. Which
> yes, does not say "definitely do it this way", but I hope makes it clear
> that you're supposed to use judgement about readability.

So here's a patch.

I know we've usually tried to keep this file to guidelines and not
rules, but clearly it has not been clear-cut enough in this instance.

-- >8 --
Subject: [PATCH] CodingGuidelines: clarify multi-line brace style

There are some "gray areas" around when to omit braces from
a conditional or loop body. Since that seems to have
resulted in some arguments, let's be a little more clear
about our preferred style.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/CodingGuidelines | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 4cd95da6b..0e336e99d 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -206,11 +206,38 @@ For C programs:
 		x = 1;
 	}
 
-   is frowned upon.  A gray area is when the statement extends
-   over a few lines, and/or you have a lengthy comment atop of
-   it.  Also, like in the Linux kernel, if there is a long list
-   of "else if" statements, it can make sense to add braces to
-   single line blocks.
+   is frowned upon. But there are a few exceptions:
+
+	- When the statement extends over a few lines (e.g., a while loop
+	  with an embedded conditional, or a comment). E.g.:
+
+		while (foo) {
+			if (x)
+				one();
+			else
+				two();
+		}
+
+		if (foo) {
+			/*
+			 * This one requires some explanation,
+			 * so we're better off with braces to make
+			 * it obvious that the indentation is correct.
+			 */
+			doit();
+		}
+
+	- When there are multiple arms to a conditional, it can make
+	  sense to add braces to single line blocks for consistency.
+	  E.g.:
+
+		if (foo) {
+			doit();
+		} else {
+			one();
+			two();
+			three();
+		}
 
  - We try to avoid assignments in the condition of an "if" statement.
 
-- 
2.11.0.642.gd6f8cda6c

