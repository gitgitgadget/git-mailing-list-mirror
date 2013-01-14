From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 01/14] imap-send.c: remove msg_data::flags, which was always zero
Date: Mon, 14 Jan 2013 06:32:33 +0100
Message-ID: <1358141566-26081-2-git-send-email-mhagger@alum.mit.edu>
References: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 06:40:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tucmv-0004mG-Ka
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 06:40:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795Ab3ANFk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 00:40:29 -0500
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:57842 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751182Ab3ANFk3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jan 2013 00:40:29 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Jan 2013 00:40:28 EST
X-AuditID: 12074414-b7f9b6d0000008b3-ea-50f398a68a18
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id A7.31.02227.6A893F05; Mon, 14 Jan 2013 00:33:27 -0500 (EST)
Received: from michael.fritz.box (p57A25AA5.dip.t-dialin.net [87.162.90.165])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0E5Wt2i026427
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 14 Jan 2013 00:33:25 -0500
X-Mailer: git-send-email 1.8.0.3
In-Reply-To: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsUixO6iqLt8xucAgz21Fl1XupksGnqvMFvc
	XjGf2eJHSw+zA4vH3/cfmDye9e5h9Lh4Sdnj8ya5AJYobpukxJKy4Mz0PH27BO6MAw8usxbc
	Eq5obp7O1MC4lr+LkZNDQsBE4n53LwuELSZx4d56ti5GLg4hgcuMEp1XHjFBOGeZJK78fMAM
	UsUmoCuxqKeZCcQWEVCTmNh2CKybWSBFouN5NyOILSwQKLH79CV2EJtFQFXi6rQDYPW8Ai4S
	Rw62MEFsU5B4vfMSK4jNKeAq8f3jKbD5QkA1D081s01g5F3AyLCKUS4xpzRXNzcxM6c4NVm3
	ODkxLy+1SNdCLzezRC81pXQTIyR8RHYwHjkpd4hRgINRiYd3c8nnACHWxLLiytxDjJIcTEqi
	vOH9QCG+pPyUyozE4oz4otKc1OJDjBIczEoivKF1QDnelMTKqtSifJiUNAeLkjjvt8XqfkIC
	6YklqdmpqQWpRTBZGQ4OJQne0OlAjYJFqempFWmZOSUIaSYOThDBBbKBB2hDDUghb3FBYm5x
	ZjpE0SlGRSlx3lSQhABIIqM0D24ALNJfMYoD/SPM2wRSxQNMEnDdr4AGMwENPnvhPcjgkkSE
	lFQDY3gbc0a5i8irVTpfFmzJ0jjmuOpmg/V1AfnMcHfbYtHDquK+i9JkFsx9dP/y6zCte8UR
	F57sLny9b8XEW44zhHTDXar+3/RpYGDId7RZ+TafS/QN25SjBzbqTnKIXP+/OXmaj9SPe4xt
	YSKuJrHuGbsvFnAeK+gRKzDa8okjeN011RlLmX9fVmIpzkg01GIuKk4EAHB42H3P 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213442>

This removes the need for function imap_make_flags(), so delete it,
too.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 imap-send.c | 40 +++-------------------------------------
 1 file changed, 3 insertions(+), 37 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index e521e2f..451d502 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -70,7 +70,6 @@ struct store {
 
 struct msg_data {
 	struct strbuf data;
-	unsigned char flags;
 };
 
 static const char imap_send_usage[] = "git imap-send < <mbox>";
@@ -225,14 +224,6 @@ static const char *cap_list[] = {
 static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd);
 
 
-static const char *Flags[] = {
-	"Draft",
-	"Flagged",
-	"Answered",
-	"Seen",
-	"Deleted",
-};
-
 #ifndef NO_OPENSSL
 static void ssl_socket_perror(const char *func)
 {
@@ -1246,23 +1237,6 @@ bail:
 	return NULL;
 }
 
-static int imap_make_flags(int flags, char *buf)
-{
-	const char *s;
-	unsigned i, d;
-
-	for (i = d = 0; i < ARRAY_SIZE(Flags); i++)
-		if (flags & (1 << i)) {
-			buf[d++] = ' ';
-			buf[d++] = '\\';
-			for (s = Flags[i]; *s; s++)
-				buf[d++] = *s;
-		}
-	buf[0] = '(';
-	buf[d++] = ')';
-	return d;
-}
-
 static void lf_to_crlf(struct strbuf *msg)
 {
 	size_t new_len;
@@ -1311,8 +1285,7 @@ static int imap_store_msg(struct store *gctx, struct msg_data *msg)
 	struct imap *imap = ctx->imap;
 	struct imap_cmd_cb cb;
 	const char *prefix, *box;
-	int ret, d;
-	char flagstr[128];
+	int ret;
 
 	lf_to_crlf(&msg->data);
 	memset(&cb, 0, sizeof(cb));
@@ -1320,17 +1293,10 @@ static int imap_store_msg(struct store *gctx, struct msg_data *msg)
 	cb.dlen = msg->data.len;
 	cb.data = strbuf_detach(&msg->data, NULL);
 
-	d = 0;
-	if (msg->flags) {
-		d = imap_make_flags(msg->flags, flagstr);
-		flagstr[d++] = ' ';
-	}
-	flagstr[d] = 0;
-
 	box = gctx->name;
 	prefix = !strcmp(box, "INBOX") ? "" : ctx->prefix;
 	cb.create = 0;
-	ret = imap_exec_m(ctx, &cb, "APPEND \"%s%s\" %s", prefix, box, flagstr);
+	ret = imap_exec_m(ctx, &cb, "APPEND \"%s%s\"", prefix, box);
 	imap->caps = imap->rcaps;
 	if (ret != DRV_OK)
 		return ret;
@@ -1483,7 +1449,7 @@ static int git_imap_config(const char *key, const char *val, void *cb)
 int main(int argc, char **argv)
 {
 	struct strbuf all_msgs = STRBUF_INIT;
-	struct msg_data msg = {STRBUF_INIT, 0};
+	struct msg_data msg = {STRBUF_INIT};
 	struct store *ctx = NULL;
 	int ofs = 0;
 	int r;
-- 
1.8.0.3
