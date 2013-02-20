From: Jeff King <peff@peff.net>
Subject: [PATCH v3 13/19] pkt-line: move LARGE_PACKET_MAX definition from
 sideband
Date: Wed, 20 Feb 2013 15:02:45 -0500
Message-ID: <20130220200245.GM25647@sigill.intra.peff.net>
References: <20130220195147.GA25332@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 20 21:03:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8Fsm-00059u-1Q
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 21:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935163Ab3BTUCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 15:02:48 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54652 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935054Ab3BTUCr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 15:02:47 -0500
Received: (qmail 17811 invoked by uid 107); 20 Feb 2013 20:04:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Feb 2013 15:04:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2013 15:02:45 -0500
Content-Disposition: inline
In-Reply-To: <20130220195147.GA25332@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216727>

Having the packet sizes defined near the packet read/write
functions makes more sense.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c     | 1 +
 pkt-line.h | 3 +++
 sideband.h | 3 ---
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/http.c b/http.c
index d9d1aad..8803c70 100644
--- a/http.c
+++ b/http.c
@@ -5,6 +5,7 @@
 #include "url.h"
 #include "credential.h"
 #include "version.h"
+#include "pkt-line.h"
 
 int active_requests;
 int http_is_verbose;
diff --git a/pkt-line.h b/pkt-line.h
index 5d2fb42..6927ea5 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -58,6 +58,9 @@ int packet_read_line(int fd, char *buffer, unsigned size);
  */
 int packet_read_line(int fd, char *buffer, unsigned size);
 
+#define DEFAULT_PACKET_MAX 1000
+#define LARGE_PACKET_MAX 65520
+
 int packet_get_line(struct strbuf *out, char **src_buf, size_t *src_len);
 
 #endif
diff --git a/sideband.h b/sideband.h
index d72db35..e46bed0 100644
--- a/sideband.h
+++ b/sideband.h
@@ -4,9 +4,6 @@
 #define SIDEBAND_PROTOCOL_ERROR -2
 #define SIDEBAND_REMOTE_ERROR -1
 
-#define DEFAULT_PACKET_MAX 1000
-#define LARGE_PACKET_MAX 65520
-
 int recv_sideband(const char *me, int in_stream, int out);
 ssize_t send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_max);
 
-- 
1.8.2.rc0.9.g352092c
