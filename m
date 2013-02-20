From: Jeff King <peff@peff.net>
Subject: [PATCH v3 09/19] pkt-line: move a misplaced comment
Date: Wed, 20 Feb 2013 15:01:46 -0500
Message-ID: <20130220200146.GI25647@sigill.intra.peff.net>
References: <20130220195147.GA25332@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 20 21:02:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8Frp-0004Sq-J2
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 21:02:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935112Ab3BTUBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 15:01:49 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54592 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935062Ab3BTUBs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 15:01:48 -0500
Received: (qmail 17734 invoked by uid 107); 20 Feb 2013 20:03:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Feb 2013 15:03:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2013 15:01:46 -0500
Content-Disposition: inline
In-Reply-To: <20130220195147.GA25332@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216723>

The comment describing the packet writing interface was
originally written above packet_write, but migrated to be
above safe_write in f3a3214, probably because it is meant to
generally describe the packet writing interface and not a
single function. Let's move it into the header file, where
users of the interface are more likely to see it.

Signed-off-by: Jeff King <peff@peff.net>
---
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
1.8.2.rc0.9.g352092c
