From: Jeff King <peff@peff.net>
Subject: [PATCHv2 01/10] pkt-line: move a misplaced comment
Date: Mon, 18 Feb 2013 04:14:30 -0500
Message-ID: <20130218091430.GA5096@sigill.intra.peff.net>
References: <20130218091203.GB17003@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 10:15:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7MoN-0006LP-QK
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 10:15:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757035Ab3BRJOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 04:14:34 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51657 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756751Ab3BRJOd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 04:14:33 -0500
Received: (qmail 17557 invoked by uid 107); 18 Feb 2013 09:16:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Feb 2013 04:16:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Feb 2013 04:14:30 -0500
Content-Disposition: inline
In-Reply-To: <20130218091203.GB17003@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216446>

The comment describing the packet writing interface was
originally written above packet_write, but migrated to be
above safe_write in f3a3214, probably because it is meant to
generally describe the packet writing interface and not a
single function. Let's move it into the header file, where
users of the interface are more likely to see it.

Signed-off-by: Jeff King <peff@peff.net>
---
I just left the comment intact as I moved it. It kind of implies to me
that you hand a big buffer to these functions and they would packetize
it for you, which is not true. I don't know if anybody else sees that;
it might be worth tweaking the text.

 pkt-line.c | 15 ---------------
 pkt-line.h | 14 +++++++++++++-
 2 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index eaba15f..5138f47 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -46,21 +46,6 @@ static void packet_trace(const char *buf, unsigned int len, int write)
 	strbuf_release(&out);
 }
 
-/*
- * Write a packetized stream, where each line is preceded by
- * its length (including the header) as a 4-byte hex number.
- * A length of 'zero' means end of stream (and a length of 1-3
- * would be an error).
- *
- * This is all pretty stupid, but we use this packetized line
- * format to make a streaming format possible without ever
- * over-running the read buffers. That way we'll never read
- * into what might be the pack data (which should go to another
- * process entirely).
- *
- * The writing side could use stdio, but since the reading
- * side can't, we stay with pure read/write interfaces.
- */
 ssize_t safe_write(int fd, const void *buf, ssize_t n)
 {
 	ssize_t nn = n;
diff --git a/pkt-line.h b/pkt-line.h
index 8cfeb0c..7a67e9c 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -5,7 +5,19 @@
 #include "strbuf.h"
 
 /*
- * Silly packetized line writing interface
+ * Write a packetized stream, where each line is preceded by
+ * its length (including the header) as a 4-byte hex number.
+ * A length of 'zero' means end of stream (and a length of 1-3
+ * would be an error).
+ *
+ * This is all pretty stupid, but we use this packetized line
+ * format to make a streaming format possible without ever
+ * over-running the read buffers. That way we'll never read
+ * into what might be the pack data (which should go to another
+ * process entirely).
+ *
+ * The writing side could use stdio, but since the reading
+ * side can't, we stay with pure read/write interfaces.
  */
 void packet_flush(int fd);
 void packet_write(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
-- 
1.8.1.20.g7078b03
