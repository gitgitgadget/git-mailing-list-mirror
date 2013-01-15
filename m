From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 13/14] imap-send.c: fold struct store into struct imap_store
Date: Tue, 15 Jan 2013 09:06:31 +0100
Message-ID: <1358237193-8887-14-git-send-email-mhagger@alum.mit.edu>
References: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 09:08:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv1Ys-0002qx-Vv
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 09:07:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755754Ab3AOIHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 03:07:38 -0500
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:61413 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756252Ab3AOIHb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2013 03:07:31 -0500
X-AuditID: 12074411-b7fa36d0000008cc-74-50f50e42cc98
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 74.B9.02252.24E05F05; Tue, 15 Jan 2013 03:07:30 -0500 (EST)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0F86n5Z029668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 15 Jan 2013 03:07:29 -0500
X-Mailer: git-send-email 1.8.0.3
In-Reply-To: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsUixO6iqOvE9zXA4OgDdYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M5ouXydsWCvUMXa95eZGxiv
	83UxcnJICJhIvHnTyARhi0lcuLeerYuRi0NI4DKjxM0vF9khnDNMEo+XLWMEqWIT0JVY1NMM
	1iEioCYxse0QC4jNLOAgsflzI1iNsIC/xMfrV8FqWARUJdbfuMkKYvMKuEj8ffuIGWKbgsTr
	nZfA4pxA8as/j4HFhQScJb5sOM04gZF3ASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdU73c
	zBK91JTSTYyQYBHcwTjjpNwhRgEORiUeXlODLwFCrIllxZW5hxglOZiURHk7uL4GCPEl5adU
	ZiQWZ8QXleakFh9ilOBgVhLh9XkHVM6bklhZlVqUD5OS5mBREuflW6LuJySQnliSmp2aWpBa
	BJOV4eBQkuCN4QUaKliUmp5akZaZU4KQZuLgBBFcIBt4gDa84gYq5C0uSMwtzkyHKDrFqCgl
	zmsGMkEAJJFRmgc3ABbXrxjFgf4R5g0CqeIBpgS47ldAg5mABm/a+xlkcEkiQkqqgXHu24XC
	c0/52M9r+Xnv/ByfK1cyPhm8ePHNLXhVuOPxoHup3FfmLlj29GPDm5e3TC7nbZGySRCLOTEt
	dbEP+/mFER2vjs1kfWd6++AsBwb1cFddbRGlwKRFxk93VdZ+l5sfLO40leH1r/pvK6Za7Yto
	Tp/zeM/dSVO2bM7bZMPoPYf/Qo3x/pJrSizFGYmGWsxFxYkA1Lgp08YCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213613>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 imap-send.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index a0f42bb..f2933e9 100644
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
@@ -1140,7 +1136,7 @@ static int imap_store_msg(struct imap_store *ctx, struct strbuf *msg)
 	cb.dlen = msg->len;
 	cb.data = strbuf_detach(msg, NULL);
 
-	box = ctx->gen.name;
+	box = ctx->name;
 	prefix = !strcmp(box, "INBOX") ? "" : ctx->prefix;
 	cb.create = 0;
 	ret = imap_exec_m(ctx, &cb, "APPEND \"%s%s\" ", prefix, box);
@@ -1352,7 +1348,7 @@ int main(int argc, char **argv)
 	}
 
 	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
-	ctx->gen.name = imap_folder;
+	ctx->name = imap_folder;
 	while (1) {
 		unsigned percent = n * 100 / total;
 
-- 
1.8.0.3
