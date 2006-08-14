From: David Rientjes <rientjes@google.com>
Subject: [PATCH 07/28] builtin-mailinfo.c cleanup
Date: Mon, 14 Aug 2006 13:24:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608141323530.19383@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 14 22:25:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCizp-0007E0-LX
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 22:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932713AbWHNUZK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 16:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932718AbWHNUZJ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 16:25:09 -0400
Received: from smtp-out.google.com ([216.239.45.12]:25745 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932713AbWHNUZI
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 16:25:08 -0400
Received: from zps77.corp.google.com (zps77.corp.google.com [172.25.146.77])
	by smtp-out.google.com with ESMTP id k7EKOteX007149
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:24:55 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=rnTY2ONhom7MWdep3zqY49xhrbmFFmjx65AM4HvHT76WL4YkKczvMWeSOi7oyl3Bl
	MXOXgYAodw/EPPNsb46EA==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps77.corp.google.com with ESMTP id k7EKOmQR017321
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:24:49 -0700
Received: by localhost (Postfix, from userid 24081)
	id E691087D71; Mon, 14 Aug 2006 13:24:48 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id E415487D70
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:24:48 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25387>

Makes decode_q_segment and decode_b_segment void and cleans up function calls.

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 builtin-mailinfo.c |   16 +++++++---------
 1 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 24a4fc6..bac3048 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -462,7 +462,7 @@ static unsigned hexval(int c)
 	return ~0;
 }
 
-static int decode_q_segment(char *in, char *ot, char *ep, int rfc2047)
+static void decode_q_segment(char *in, char *ot, char *ep, int rfc2047)
 {
 	int c;
 	while ((c = *in++) != 0 && (in <= ep)) {
@@ -478,10 +478,9 @@ static int decode_q_segment(char *in, ch
 		*ot++ = c;
 	}
 	*ot = 0;
-	return 0;
 }
 
-static int decode_b_segment(char *in, char *ot, char *ep)
+static void decode_b_segment(char *in, char *ot, char *ep)
 {
 	/* Decode in..ep, possibly in-place to ot */
 	int c, pos = 0, acc = 0;
@@ -525,7 +524,6 @@ static int decode_b_segment(char *in, ch
 		}
 	}
 	*ot = 0;
-	return 0;
 }
 
 static void convert_to_utf8(char *line, char *charset)
@@ -606,10 +604,12 @@ static int decode_header_bq(char *it)
 		default:
 			return rfc2047; /* no munging */
 		case 'b':
-			sz = decode_b_segment(cp + 3, piecebuf, ep);
+			decode_b_segment(cp + 3, piecebuf, ep);
+			sz = 0;
 			break;
 		case 'q':
-			sz = decode_q_segment(cp + 3, piecebuf, ep, 1);
+			decode_q_segment(cp + 3, piecebuf, ep, 1);
+			sz = 0;
 			break;
 		}
 		if (sz < 0)
@@ -746,9 +746,7 @@ static int handle_multipart_one_part(int
 		handle_patch();
 		break;
 	}
-	if (n == 0)
-		return -1;
-	return 0;
+	return n ? 0 : -1;
 }
 
 static void handle_multipart_body(void)
-- 
1.4.2.g89bb-dirty
