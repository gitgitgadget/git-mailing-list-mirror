From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 08/14] imap-send.c: remove struct imap argument to parse_imap_list_l()
Date: Mon, 14 Jan 2013 06:32:40 +0100
Message-ID: <1358141566-26081-9-git-send-email-mhagger@alum.mit.edu>
References: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 06:34:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TucgW-0007IG-Ad
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 06:34:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567Ab3ANFdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 00:33:50 -0500
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:61654 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752369Ab3ANFdu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jan 2013 00:33:50 -0500
X-AuditID: 1207440c-b7f196d0000008bc-26-50f398bd30ee
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id FE.92.02236.DB893F05; Mon, 14 Jan 2013 00:33:49 -0500 (EST)
Received: from michael.fritz.box (p57A25AA5.dip.t-dialin.net [87.162.90.165])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0E5Wt2p026427
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 14 Jan 2013 00:33:48 -0500
X-Mailer: git-send-email 1.8.0.3
In-Reply-To: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsUixO6iqLt3xucAg+bnwhZdV7qZLBp6rzBb
	3F4xn9niR0sPswOLx9/3H5g8nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujButk1kK
	5gpU7D/cxNrAOIOni5GTQ0LAROJBxyZGCFtM4sK99WwgtpDAZUaJNzd1uhi5gOyzTBInz3Yy
	gSTYBHQlFvU0g9kiAmoSE9sOsYDYzAIpEh3Pu8EGCQuESRw4swpsEIuAqsT73h/sIDavgIvE
	0mPT2CCWKUi83nmJFcTmFHCV+P7xFDPEYheJh6ea2SYw8i5gZFjFKJeYU5qrm5uYmVOcmqxb
	nJyYl5dapGuol5tZopeaUrqJERI+PDsYv62TOcQowMGoxMO7qeRzgBBrYllxZe4hRkkOJiVR
	3vB+oBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3tA6oBxvSmJlVWpRPkxKmoNFSZxXdYm6n5BA
	emJJanZqakFqEUxWhoNDSYLXGRgnQoJFqempFWmZOSUIaSYOThDBBbKBB2jD5+kgG4oLEnOL
	M9Mhik4xKkqJ80qBTBAASWSU5sENgEX6K0ZxoH+Eef+BtPMAkwRc9yugwUxAg89eeA8yuCQR
	ISXVwKhfa/xq47bW3KKXqwRaWRn9Z2cEHdWvulQvqV6eGJp47PrGPgmGukkCWyYrSmk1no2t
	YjUoiFHPK98ZobV7xe/dPLtWnrp6Nf/i5YglWk6LeSetebXrtxDbrfeBKxg1eV9zeRxyKdj1
	363OyXVDFruYbUwcZ42Cdrpg3OS4Sw8Kbrcb9vzOU2Ipzkg01GIuKk4EAAz0bW/P 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213436>

It was always set to NULL.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 imap-send.c | 39 +++------------------------------------
 1 file changed, 3 insertions(+), 36 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 452e73e..5238c74 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -578,11 +578,10 @@ static void free_list(struct imap_list *list)
 	}
 }
 
-static int parse_imap_list_l(struct imap *imap, char **sp, struct imap_list **curp, int level)
+static int parse_imap_list_l(char **sp, struct imap_list **curp, int level)
 {
 	struct imap_list *cur;
 	char *s = *sp, *p;
-	int n, bytes;
 
 	for (;;) {
 		while (isspace((unsigned char)*s))
@@ -598,39 +597,7 @@ static int parse_imap_list_l(struct imap *imap, char **sp, struct imap_list **cu
 			/* sublist */
 			s++;
 			cur->val = LIST;
-			if (parse_imap_list_l(imap, &s, &cur->child, level + 1))
-				goto bail;
-		} else if (imap && *s == '{') {
-			/* literal */
-			bytes = cur->len = strtol(s + 1, &s, 10);
-			if (*s != '}')
-				goto bail;
-
-			s = cur->val = xmalloc(cur->len);
-
-			/* dump whats left over in the input buffer */
-			n = imap->buf.bytes - imap->buf.offset;
-
-			if (n > bytes)
-				/* the entire message fit in the buffer */
-				n = bytes;
-
-			memcpy(s, imap->buf.buf + imap->buf.offset, n);
-			s += n;
-			bytes -= n;
-
-			/* mark that we used part of the buffer */
-			imap->buf.offset += n;
-
-			/* now read the rest of the message */
-			while (bytes > 0) {
-				if ((n = socket_read(&imap->buf.sock, s, bytes)) <= 0)
-					goto bail;
-				s += n;
-				bytes -= n;
-			}
-
-			if (buffer_gets(&imap->buf, &s))
+			if (parse_imap_list_l(&s, &cur->child, level + 1))
 				goto bail;
 		} else if (*s == '"') {
 			/* quoted string */
@@ -673,7 +640,7 @@ static struct imap_list *parse_list(char **sp)
 {
 	struct imap_list *head;
 
-	if (!parse_imap_list_l(NULL, sp, &head, 0))
+	if (!parse_imap_list_l(sp, &head, 0))
 		return head;
 	free_list(head);
 	return NULL;
-- 
1.8.0.3
