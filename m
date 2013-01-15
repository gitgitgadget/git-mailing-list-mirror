From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 11/14] imap-send.c: use struct imap_store instead of struct store
Date: Tue, 15 Jan 2013 09:06:29 +0100
Message-ID: <1358237193-8887-12-git-send-email-mhagger@alum.mit.edu>
References: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 09:15:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv1ft-0000b5-Ox
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 09:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756804Ab3AOIOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 03:14:46 -0500
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:60598 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756494Ab3AOIOo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2013 03:14:44 -0500
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jan 2013 03:14:44 EST
X-AuditID: 12074412-b7f216d0000008e3-4e-50f50e3e5c4f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 01.54.02275.E3E05F05; Tue, 15 Jan 2013 03:07:26 -0500 (EST)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0F86n5X029668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 15 Jan 2013 03:07:25 -0500
X-Mailer: git-send-email 1.8.0.3
In-Reply-To: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsUixO6iqGvH9zXAYNlpAYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M5Y/vYMU8F8kYreBeoNjDMF
	uhg5OSQETCR6Or8zQdhiEhfurWfrYuTiEBK4zCjR+GovK4Rzhkmic+lCRpAqNgFdiUU9zWAd
	IgJqEhPbDrGA2MwCDhKbPzeC1QgLhEi03JkKZrMIqEpsPrkdrJ5XwEXi2Nx1bBDbFCRe77zE
	CmJzAsWv/jzGDGILCThLfNlwmnECI+8CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbpmermZ
	JXqpKaWbGCGhIrSDcf1JuUOMAhyMSjy8xgZfAoRYE8uKK3MPMUpyMCmJ8nZwfQ0Q4kvKT6nM
	SCzOiC8qzUktPsQowcGsJMLr8w6onDclsbIqtSgfJiXNwaIkzvtzsbqfkEB6YklqdmpqQWoR
	TFaGg0NJgjeGF2ioYFFqempFWmZOCUKaiYMTRHCBbOAB2vCKG6iQt7ggMbc4Mx2i6BSjopQ4
	rxnIBAGQREZpHtwAWFS/YhQH+keYNwikigeYEOC6XwENZgIavGnvZ5DBJYkIKakGxnbulen7
	1pzc+Wl724Pz/g+lHhy+mGw6+8v/pKTAU7EJXx223P3iGftzweHV+YWVi+/08Rxr2JkwPbza
	zufttQ0b4qMWnnsn+WR72smzUjM3z5DfWrdYSuJuh2XotdivkZ16Rlny6uwGczLaXQTnhfZO
	FOqLOGssaJ3Q/mz+6+dGt6LkO8ra85RYijMSDbWYi4oTAckuyK/FAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213618>

In fact, all struct store instances are upcasts of struct imap_store
anyway, so stop making the distinction.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 imap-send.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 909e4db..48c646c 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -782,9 +782,9 @@ static void imap_close_server(struct imap_store *ictx)
 	free(imap);
 }
 
-static void imap_close_store(struct store *ctx)
+static void imap_close_store(struct imap_store *ctx)
 {
-	imap_close_server((struct imap_store *)ctx);
+	imap_close_server(ctx);
 	free(ctx);
 }
 
@@ -869,7 +869,7 @@ static int auth_cram_md5(struct imap_store *ctx, struct imap_cmd *cmd, const cha
 	return 0;
 }
 
-static struct store *imap_open_store(struct imap_server_conf *srvc)
+static struct imap_store *imap_open_store(struct imap_server_conf *srvc)
 {
 	struct imap_store *ctx;
 	struct imap *imap;
@@ -1079,10 +1079,10 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
 	} /* !preauth */
 
 	ctx->prefix = "";
-	return (struct store *)ctx;
+	return ctx;
 
 bail:
-	imap_close_store(&ctx->gen);
+	imap_close_store(ctx);
 	return NULL;
 }
 
@@ -1128,9 +1128,8 @@ static void lf_to_crlf(struct strbuf *msg)
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
@@ -1142,7 +1141,7 @@ static int imap_store_msg(struct store *gctx, struct strbuf *msg)
 	cb.dlen = msg->len;
 	cb.data = strbuf_detach(msg, NULL);
 
-	box = gctx->name;
+	box = ctx->gen.name;
 	prefix = !strcmp(box, "INBOX") ? "" : ctx->prefix;
 	cb.create = 0;
 	ret = imap_exec_m(ctx, &cb, "APPEND \"%s%s\" ", prefix, box);
@@ -1298,7 +1297,7 @@ int main(int argc, char **argv)
 {
 	struct strbuf all_msgs = STRBUF_INIT;
 	struct strbuf msg = STRBUF_INIT;
-	struct store *ctx = NULL;
+	struct imap_store *ctx = NULL;
 	int ofs = 0;
 	int r;
 	int total, n = 0;
@@ -1354,7 +1353,7 @@ int main(int argc, char **argv)
 	}
 
 	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
-	ctx->name = imap_folder;
+	ctx->gen.name = imap_folder;
 	while (1) {
 		unsigned percent = n * 100 / total;
 
-- 
1.8.0.3
