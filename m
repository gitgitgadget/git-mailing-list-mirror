From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 02/14] imap-send.c: remove struct msg_data
Date: Mon, 14 Jan 2013 06:32:34 +0100
Message-ID: <1358141566-26081-3-git-send-email-mhagger@alum.mit.edu>
References: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 06:34:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TucgJ-00077r-0R
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 06:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234Ab3ANFdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 00:33:31 -0500
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:48135 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751095Ab3ANFda (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jan 2013 00:33:30 -0500
X-AuditID: 1207440d-b7f306d0000008b7-27-50f398aa496f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 4B.E0.02231.AA893F05; Mon, 14 Jan 2013 00:33:30 -0500 (EST)
Received: from michael.fritz.box (p57A25AA5.dip.t-dialin.net [87.162.90.165])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0E5Wt2j026427
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 14 Jan 2013 00:33:29 -0500
X-Mailer: git-send-email 1.8.0.3
In-Reply-To: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsUixO6iqLtqxucAg7Vn2Sy6rnQzWTT0XmG2
	uL1iPrPFj5YeZgcWj7/vPzB5POvdw+hx8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGfNu72Mt
	mClYcenuQcYGxvO8XYycHBICJhLrTp5lgrDFJC7cW8/WxcjFISRwmVHi+aV5LBDOWSaJJ10H
	2ECq2AR0JRb1NIN1iAioSUxsO8QCYjMLpEh0PO9mBLGFBawkPi6cDFbPIqAqsfJxK1g9r4CL
	xPTZE9ghtilIvN55iRXE5hRwlfj+8RQziC0EVPPwVDPbBEbeBYwMqxjlEnNKc3VzEzNzilOT
	dYuTE/PyUot0jfRyM0v0UlNKNzFCAoh3B+P/dTKHGAU4GJV4eDeVfA4QYk0sK67MPcQoycGk
	JMob3g8U4kvKT6nMSCzOiC8qzUktPsQowcGsJMIbWgeU401JrKxKLcqHSUlzsCiJ86otUfcT
	EkhPLEnNTk0tSC2CycpwcChJ8HICI0VIsCg1PbUiLTOnBCHNxMEJIrhANvAAbfg8HWRDcUFi
	bnFmOkTRKUZFKXHe1SAJAZBERmke3ABYrL9iFAf6R5j3H0gVDzBNwHW/AhrMBDT47IX3IINL
	EhFSUg2MRps98lbsNU+OjfeQvS7iluc0e8JDicNsW7huWcb6bk1fcMK5s/cH7z6NazpOtedX
	enLZnAjT9oxyYlvlz3OoQmLl4tDm6lx/nmTRw4ZsbZo3rSrWfZjsnmrUPSV9B+eL0D+xxyYo
	btrz5bhDROEeod3VUkdr9056xMsRmKmlYFz3tfkr1xwlluKMREMt5qLiRABT+DcI 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213433>

Now that its flags member has been deleted, all that is left is a
strbuf.  So use a strbuf directly.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 imap-send.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 451d502..a8cb66a 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -68,10 +68,6 @@ struct store {
 	int recent; /* # of recent messages - don't trust this beyond the initial read */
 };
 
-struct msg_data {
-	struct strbuf data;
-};
-
 static const char imap_send_usage[] = "git imap-send < <mbox>";
 
 #undef DRV_OK
@@ -1279,7 +1275,7 @@ static void lf_to_crlf(struct strbuf *msg)
  * Store msg to IMAP.  Also detach and free the data from msg->data,
  * leaving msg->data empty.
  */
-static int imap_store_msg(struct store *gctx, struct msg_data *msg)
+static int imap_store_msg(struct store *gctx, struct strbuf *msg)
 {
 	struct imap_store *ctx = (struct imap_store *)gctx;
 	struct imap *imap = ctx->imap;
@@ -1287,11 +1283,11 @@ static int imap_store_msg(struct store *gctx, struct msg_data *msg)
 	const char *prefix, *box;
 	int ret;
 
-	lf_to_crlf(&msg->data);
+	lf_to_crlf(msg);
 	memset(&cb, 0, sizeof(cb));
 
-	cb.dlen = msg->data.len;
-	cb.data = strbuf_detach(&msg->data, NULL);
+	cb.dlen = msg->len;
+	cb.data = strbuf_detach(msg, NULL);
 
 	box = gctx->name;
 	prefix = !strcmp(box, "INBOX") ? "" : ctx->prefix;
@@ -1449,7 +1445,7 @@ static int git_imap_config(const char *key, const char *val, void *cb)
 int main(int argc, char **argv)
 {
 	struct strbuf all_msgs = STRBUF_INIT;
-	struct msg_data msg = {STRBUF_INIT};
+	struct strbuf msg = STRBUF_INIT;
 	struct store *ctx = NULL;
 	int ofs = 0;
 	int r;
@@ -1511,10 +1507,10 @@ int main(int argc, char **argv)
 		unsigned percent = n * 100 / total;
 
 		fprintf(stderr, "%4u%% (%d/%d) done\r", percent, n, total);
-		if (!split_msg(&all_msgs, &msg.data, &ofs))
+		if (!split_msg(&all_msgs, &msg, &ofs))
 			break;
 		if (server.use_html)
-			wrap_in_html(&msg.data);
+			wrap_in_html(&msg);
 		r = imap_store_msg(ctx, &msg);
 		if (r != DRV_OK)
 			break;
-- 
1.8.0.3
