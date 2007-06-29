From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] diffcore-delta.c: update the comment on the algorithm.
Date: Thu, 28 Jun 2007 23:36:00 -0700
Message-ID: <11830989623983-git-send-email-gitster@pobox.com>
References: <7v3b0bi88r.fsf@assigned-by-dhcp.pobox.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 29 08:36:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4A5c-0004Tp-4f
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 08:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756285AbXF2GgJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jun 2007 02:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761115AbXF2GgI
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 02:36:08 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:35356 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755660AbXF2GgE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2007 02:36:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070629063602.MICB1594.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 Jun 2007 02:36:02 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id HJc11X00M1kojtg0000200; Fri, 29 Jun 2007 02:36:02 -0400
X-Mailer: git-send-email 1.5.2.2.1414.g1e7d9
In-Reply-To: <7v3b0bi88r.fsf@assigned-by-dhcp.pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51154>

The comment at the top of the file described an old algorithm
that was neutral to text/binary differences (it hashed sliding
window of N-byte sequences and counted overlaps), but long time
ago we switched to a new heuristics that are more suitable for
line oriented (read: text) files that are much faster.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diffcore-delta.c |   21 +++++++++------------
 1 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/diffcore-delta.c b/diffcore-delta.c
index 0e1fae7..7116df0 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -5,23 +5,20 @@
 /*
  * Idea here is very simple.
  *
- * We have total of (sz-N+1) N-byte overlapping sequences in buf whose
- * size is sz.  If the same N-byte sequence appears in both source and
- * destination, we say the byte that starts that sequence is shared
- * between them (i.e. copied from source to destination).
+ * Almost all data we are interested in are text, but sometimes we have
+ * to deal with binary data.  So we cut them into chunks delimited by
+ * LF byte, or 64-byte sequence, whichever comes first, and hash them.
  *
- * For each possible N-byte sequence, if the source buffer has more
- * instances of it than the destination buffer, that means the
- * difference are the number of bytes not copied from source to
- * destination.  If the counts are the same, everything was copied
- * from source to destination.  If the destination has more,
- * everything was copied, and destination added more.
+ * For those chunks, if the source buffer has more instances of it
+ * than the destination buffer, that means the difference are the
+ * number of bytes not copied from source to destination.  If the
+ * counts are the same, everything was copied from source to
+ * destination.  If the destination has more, everything was copied,
+ * and destination added more.
  *
  * We are doing an approximation so we do not really have to waste
  * memory by actually storing the sequence.  We just hash them into
  * somewhere around 2^16 hashbuckets and count the occurrences.
- *
- * The length of the sequence is arbitrarily set to 8 for now.
  */
 
 /* Wild guess at the initial hash size */
-- 
1.5.2.2.1414.g1e7d9
