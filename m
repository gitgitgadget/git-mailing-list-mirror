From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 14/14] imap-send.c: fold struct store into struct imap_store
Date: Mon, 14 Jan 2013 06:32:46 +0100
Message-ID: <1358141566-26081-15-git-send-email-mhagger@alum.mit.edu>
References: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 06:34:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tucgr-0007f9-LK
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 06:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688Ab3ANFeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 00:34:12 -0500
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:61325 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752318Ab3ANFeK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jan 2013 00:34:10 -0500
X-AuditID: 1207440e-b7f116d0000008ae-c8-50f398d2422e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 55.9C.02222.2D893F05; Mon, 14 Jan 2013 00:34:10 -0500 (EST)
Received: from michael.fritz.box (p57A25AA5.dip.t-dialin.net [87.162.90.165])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0E5Wt2v026427
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 14 Jan 2013 00:34:09 -0500
X-Mailer: git-send-email 1.8.0.3
In-Reply-To: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsUixO6iqHtpxucAgzk3hC26rnQzWTT0XmG2
	uL1iPrPFj5YeZgcWj7/vPzB5POvdw+hx8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGd/m7GIp
	2CNU8WTSN9YGxut8XYycHBICJhKzzlxmgbDFJC7cW8/WxcjFISRwmVFiwo1vrBDOWSaJ9QcW
	sYNUsQnoSizqaWYCsUUE1CQmth0C62YWSJHoeN7NCGILC/hI/Px+Eqieg4NFQFXiwNVskDCv
	gKtE09XzUMsUJF7vvMQKYnMCxb9/PMUMYgsJuEg8PNXMNoGRdwEjwypGucSc0lzd3MTMnOLU
	ZN3i5MS8vNQiXWO93MwSvdSU0k2MkPDh28HYvl7mEKMAB6MSD++Wks8BQqyJZcWVuYcYJTmY
	lER5w/uBQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4Q+uAcrwpiZVVqUX5MClpDhYlcV61Jep+
	QgLpiSWp2ampBalFMFkZDg4lCV5OYJwICRalpqdWpGXmlCCkmTg4QQQXyAYeoA2fp4NsKC5I
	zC3OTIcoOsWoKCXOKwUyQQAkkVGaBzcAFumvGMWB/hHm/QfSzgNMEnDdr4AGMwENPnvhPcjg
	kkSElFQDo9i1nJgT53RNlE4anrq2d6XvbwYB30nXF1pWLBKrPuAUVJgWWrii6vNLucwDx7KP
	265SC5xSc8OS7S3rxxT+p84r1uu+jVUXOzkt9+2zq94L3DSnasZ9/yto8XAizzmZ129YuNkc
	WjiNX6jONOy9FLb8VF2+Qu3n2LMNzHHHuqLurnSZOdX4rhJLcUaioRZzUXEiACut 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213441>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 imap-send.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 4d24faf..1b665bb 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -33,12 +33,6 @@ typedef void *SSL;
 #include <openssl/hmac.h>
 #endif
 
-struct store {
-	/* currently open mailbox */
-	const char *name; /* foreign! maybe preset? */
-	int uidvalidity;
-};
-
 static const char imap_send_usage[] = "git imap-send < <mbox>";
 
 #undef DRV_OK
@@ -123,7 +117,9 @@ struct imap {
 };
 
 struct imap_store {
-	struct store gen;
+	/* currently open mailbox */
+	const char *name; /* foreign! maybe preset? */
+	int uidvalidity;
 	struct imap *imap;
 	const char *prefix;
 };
@@ -618,7 +614,7 @@ static int parse_response_code(struct imap_store *ctx, struct imap_cmd_cb *cb,
 	*p++ = 0;
 	arg = next_arg(&s);
 	if (!strcmp("UIDVALIDITY", arg)) {
-		if (!(arg = next_arg(&s)) || !(ctx->gen.uidvalidity = atoi(arg))) {
+		if (!(arg = next_arg(&s)) || !(ctx->uidvalidity = atoi(arg))) {
 			fprintf(stderr, "IMAP error: malformed UIDVALIDITY status\n");
 			return RESP_BAD;
 		}
@@ -636,7 +632,7 @@ static int parse_response_code(struct imap_store *ctx, struct imap_cmd_cb *cb,
 		for (; isspace((unsigned char)*p); p++);
 		fprintf(stderr, "*** IMAP ALERT *** %s\n", p);
 	} else if (cb && cb->ctx && !strcmp("APPENDUID", arg)) {
-		if (!(arg = next_arg(&s)) || !(ctx->gen.uidvalidity = atoi(arg)) ||
+		if (!(arg = next_arg(&s)) || !(ctx->uidvalidity = atoi(arg)) ||
 		    !(arg = next_arg(&s)) || !(*(int *)cb->ctx = atoi(arg))) {
 			fprintf(stderr, "IMAP error: malformed APPENDUID status\n");
 			return RESP_BAD;
@@ -1124,7 +1120,7 @@ static int imap_store_msg(struct imap_store *ctx, struct strbuf *msg)
 	cb.dlen = msg->len;
 	cb.data = strbuf_detach(msg, NULL);
 
-	box = ctx->gen.name;
+	box = ctx->name;
 	prefix = !strcmp(box, "INBOX") ? "" : ctx->prefix;
 	cb.create = 0;
 	ret = imap_exec_m(ctx, &cb, "APPEND \"%s%s\"", prefix, box);
@@ -1336,7 +1332,7 @@ int main(int argc, char **argv)
 	}
 
 	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
-	ctx->gen.name = imap_folder;
+	ctx->name = imap_folder;
 	while (1) {
 		unsigned percent = n * 100 / total;
 
-- 
1.8.0.3
