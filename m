From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 12/14] imap-send.c: use struct imap_store instead of struct store
Date: Mon, 14 Jan 2013 06:32:44 +0100
Message-ID: <1358141566-26081-13-git-send-email-mhagger@alum.mit.edu>
References: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 06:41:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tucnl-0005ez-ID
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 06:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699Ab3ANFlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 00:41:21 -0500
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:49086 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751040Ab3ANFlV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jan 2013 00:41:21 -0500
X-AuditID: 12074412-b7f216d0000008e3-a8-50f398ca75cb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id C6.B6.02275.AC893F05; Mon, 14 Jan 2013 00:34:02 -0500 (EST)
Received: from michael.fritz.box (p57A25AA5.dip.t-dialin.net [87.162.90.165])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0E5Wt2t026427
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 14 Jan 2013 00:34:01 -0500
X-Mailer: git-send-email 1.8.0.3
In-Reply-To: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsUixO6iqHtqxucAg4lr9C26rnQzWTT0XmG2
	uL1iPrPFj5YeZgcWj7/vPzB5POvdw+hx8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGVOPPmMs
	mCdSsePwBbYGxpkCXYwcHBICJhLnDzt3MXICmWISF+6tZ+ti5OIQErjMKHHp8G9mCOcsk8TT
	0/9ZQKrYBHQlFvU0M4HYIgJqEhPbDoHFmQVSJDqedzOC2MICgRL7rvSD2SwCqhKHX7xhB1nG
	K+AqsfZqCcQyBYnXOy+xgticQOHvH08xg9hCAi4SD081s01g5F3AyLCKUS4xpzRXNzcxM6c4
	NVm3ODkxLy+1SNdMLzezRC81pXQTIyR4hHYwrj8pd4hRgINRiYd3Y8nnACHWxLLiytxDjJIc
	TEqivOH9QCG+pPyUyozE4oz4otKc1OJDjBIczEoivKF1QDnelMTKqtSifJiUNAeLkjjvz8Xq
	fkIC6YklqdmpqQWpRTBZGQ4OJQne/ulAjYJFqempFWmZOSUIaSYOThDBBbKBB2hDDUghb3FB
	Ym5xZjpE0SlGRSlx3lSQhABIIqM0D24ALM5fMYoD/SPM2wRSxQNMEXDdr4AGMwENPnvhPcjg
	kkSElFQDI+uHnr07klaXPytmeXr03saQIyyP+TfvLMxVnRjDmSo25+/J8qNqD3lVjZ9eL5q0
	a8bsSTpHldas+sm0wG5/HJdwaLNG/S71gsJiLqOvEQccc43lZ+498G+FnIT9S0NN3nPir9Vd
	bvlUCD4LnFxxNrPfgPvYwufnJU6xzA6x+1xzJaZVOdGnQomlOCPRUIu5qDgRAOAW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213445>

In fact, all struct store instances are upcasts of struct imap_store
anyway, so stop making the distinction.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 imap-send.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 3167dcc..31fdbf3 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -781,9 +781,9 @@ static void imap_close_server(struct imap_store *ictx)
 	free(imap);
 }
 
-static void imap_close_store(struct store *ctx)
+static void imap_close_store(struct imap_store *ctx)
 {
-	imap_close_server((struct imap_store *)ctx);
+	imap_close_server(ctx);
 	free(ctx);
 }
 
@@ -868,7 +868,7 @@ static int auth_cram_md5(struct imap_store *ctx, struct imap_cmd *cmd, const cha
 	return 0;
 }
 
-static struct store *imap_open_store(struct imap_server_conf *srvc)
+static struct imap_store *imap_open_store(struct imap_server_conf *srvc)
 {
 	struct imap_store *ctx;
 	struct imap *imap;
@@ -1078,10 +1078,10 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
 	} /* !preauth */
 
 	ctx->prefix = "";
-	return (struct store *)ctx;
+	return ctx;
 
 bail:
-	imap_close_store(&ctx->gen);
+	imap_close_store(ctx);
 	return NULL;
 }
 
@@ -1112,9 +1112,8 @@ static void lf_to_crlf(struct strbuf *msg)
  * Store msg to IMAP.  Also detach and free the data from msg->data,
  * leaving msg->data empty.
  */
-static int imap_store_msg(struct store *gctx, struct strbuf *msg)
+static int imap_store_msg(struct imap_store *ctx, struct strbuf *msg)
 {
-	struct imap_store *ctx = (struct imap_store *)gctx;
 	struct imap *imap = ctx->imap;
 	struct imap_cmd_cb cb;
 	const char *prefix, *box;
@@ -1126,7 +1125,7 @@ static int imap_store_msg(struct store *gctx, struct strbuf *msg)
 	cb.dlen = msg->len;
 	cb.data = strbuf_detach(msg, NULL);
 
-	box = gctx->name;
+	box = ctx->gen.name;
 	prefix = !strcmp(box, "INBOX") ? "" : ctx->prefix;
 	cb.create = 0;
 	ret = imap_exec_m(ctx, &cb, "APPEND \"%s%s\"", prefix, box);
@@ -1282,7 +1281,7 @@ int main(int argc, char **argv)
 {
 	struct strbuf all_msgs = STRBUF_INIT;
 	struct strbuf msg = STRBUF_INIT;
-	struct store *ctx = NULL;
+	struct imap_store *ctx = NULL;
 	int ofs = 0;
 	int r;
 	int total, n = 0;
@@ -1338,7 +1337,7 @@ int main(int argc, char **argv)
 	}
 
 	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
-	ctx->name = imap_folder;
+	ctx->gen.name = imap_folder;
 	while (1) {
 		unsigned percent = n * 100 / total;
 
-- 
1.8.0.3
