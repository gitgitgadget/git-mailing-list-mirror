From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 09/14] imap-send.c: remove namespace fields from struct imap
Date: Tue, 15 Jan 2013 09:06:27 +0100
Message-ID: <1358237193-8887-10-git-send-email-mhagger@alum.mit.edu>
References: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 09:07:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv1Yi-0002iF-Cy
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 09:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756656Ab3AOIHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 03:07:25 -0500
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:43583 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755754Ab3AOIHW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2013 03:07:22 -0500
X-AuditID: 1207440d-b7f306d0000008b7-9d-50f50e39bb51
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id E2.BD.02231.93E05F05; Tue, 15 Jan 2013 03:07:21 -0500 (EST)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0F86n5V029668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 15 Jan 2013 03:07:20 -0500
X-Mailer: git-send-email 1.8.0.3
In-Reply-To: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsUixO6iqGvJ9zXA4F+LlkXXlW4mi4beK8wW
	t1fMZ3Zg9vj7/gOTx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGd8PTyRpWCFcsWuj6uYGhhb
	pbsYOTkkBEwkprRfYIKwxSQu3FvP1sXIxSEkcJlR4suiXcwQzhkmiXXb1zODVLEJ6Eos6mkG
	6xARUJOY2HaIBcRmFnCQ2Py5kbGLkYNDWMBfom1eCkiYRUBVYvW8lawgNq+Ai8Tr/RvZIJYp
	SLzeeQkszgkUv/rzGNh4IQFniS8bTjNOYORdwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjX
	SC83s0QvNaV0EyMkVHh3MP5fJ3OIUYCDUYmH97bulwAh1sSy4srcQ4ySHExKorwdXF8DhPiS
	8lMqMxKLM+KLSnNSiw8xSnAwK4nw+rwDKudNSaysSi3Kh0lJc7AoifOqLVH3ExJITyxJzU5N
	LUgtgsnKcHAoSfAq8AINFSxKTU+tSMvMKUFIM3FwgggukA08QBtecQMV8hYXJOYWZ6ZDFJ1i
	VJQS5/3DA5QQAElklObBDYBF9StGcaB/hHnvgFTxABMCXPcroMFMQIM37f0MMrgkESEl1cCY
	O9nVL5dfeF+RpdCGwnOX3pwtMg7Yu+jHt8K60K2tpz/H51pPiDy6bdL9A60nMrVYX2/qN/nR
	/DTQLvp323OJifnu10Rbk+zDdrZttbTc7rPe3Hg6g2fiFhfz78fmXbhSoT3JInZqZNOTb2kx
	03NLj1Tc27rqTdsDyUjRnpD2YmGXsuPNT7OUWIozEg21mIuKEwFTJkzFxQIAAA== 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213610>

They are unused, and their removal means that a bunch of list-related
infrastructure can be disposed of.

It might be that the "NAMESPACE" response that is now skipped over in
get_cmd_result() should never be sent by the server.  But somebody
would have to check the IMAP protocol and how we interact with the
server to be sure.  So for now I am leaving that branch of the "if"
statement there.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 imap-send.c | 75 ++++++++-----------------------------------------------------
 1 file changed, 9 insertions(+), 66 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 29e4037..ff44013 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -99,15 +99,6 @@ static struct imap_server_conf server = {
 	NULL,	/* auth_method */
 };
 
-#define NIL	(void *)0x1
-#define LIST	(void *)0x2
-
-struct imap_list {
-	struct imap_list *next, *child;
-	char *val;
-	int len;
-};
-
 struct imap_socket {
 	int fd[2];
 	SSL *ssl;
@@ -124,7 +115,6 @@ struct imap_cmd;
 
 struct imap {
 	int uidnext; /* from SELECT responses */
-	struct imap_list *ns_personal, *ns_other, *ns_shared; /* NAMESPACE info */
 	unsigned caps, rcaps; /* CAPABILITY results */
 	/* command queue */
 	int nexttag, num_in_progress, literal_pending;
@@ -554,34 +544,9 @@ static int imap_exec_m(struct imap_store *ctx, struct imap_cmd_cb *cb,
 	}
 }
 
-static int is_atom(struct imap_list *list)
-{
-	return list && list->val && list->val != NIL && list->val != LIST;
-}
-
-static int is_list(struct imap_list *list)
-{
-	return list && list->val == LIST;
-}
-
-static void free_list(struct imap_list *list)
-{
-	struct imap_list *tmp;
-
-	for (; list; list = tmp) {
-		tmp = list->next;
-		if (is_list(list))
-			free_list(list->child);
-		else if (is_atom(list))
-			free(list->val);
-		free(list);
-	}
-}
-
-static int parse_imap_list_l(char **sp, struct imap_list **curp, int level)
+static int skip_imap_list_l(char **sp, int level)
 {
-	struct imap_list *cur;
-	char *s = *sp, *p;
+	char *s = *sp;
 
 	for (;;) {
 		while (isspace((unsigned char)*s))
@@ -590,36 +555,23 @@ static int parse_imap_list_l(char **sp, struct imap_list **curp, int level)
 			s++;
 			break;
 		}
-		*curp = cur = xmalloc(sizeof(*cur));
-		curp = &cur->next;
-		cur->val = NULL; /* for clean bail */
 		if (*s == '(') {
 			/* sublist */
 			s++;
-			cur->val = LIST;
-			if (parse_imap_list_l(&s, &cur->child, level + 1))
+			if (skip_imap_list_l(&s, level + 1))
 				goto bail;
 		} else if (*s == '"') {
 			/* quoted string */
 			s++;
-			p = s;
 			for (; *s != '"'; s++)
 				if (!*s)
 					goto bail;
-			cur->len = s - p;
 			s++;
-			cur->val = xmemdupz(p, cur->len);
 		} else {
 			/* atom */
-			p = s;
 			for (; *s && !isspace((unsigned char)*s); s++)
 				if (level && *s == ')')
 					break;
-			cur->len = s - p;
-			if (cur->len == 3 && !memcmp("NIL", p, 3))
-				cur->val = NIL;
-			else
-				cur->val = xmemdupz(p, cur->len);
 		}
 
 		if (!level)
@@ -628,22 +580,15 @@ static int parse_imap_list_l(char **sp, struct imap_list **curp, int level)
 			goto bail;
 	}
 	*sp = s;
-	*curp = NULL;
 	return 0;
 
 bail:
-	*curp = NULL;
 	return -1;
 }
 
-static struct imap_list *parse_list(char **sp)
+static void skip_list(char **sp)
 {
-	struct imap_list *head;
-
-	if (!parse_imap_list_l(sp, &head, 0))
-		return head;
-	free_list(head);
-	return NULL;
+	skip_imap_list_l(sp, 0);
 }
 
 static void parse_capability(struct imap *imap, char *cmd)
@@ -722,9 +667,10 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
 			}
 
 			if (!strcmp("NAMESPACE", arg)) {
-				imap->ns_personal = parse_list(&cmd);
-				imap->ns_other = parse_list(&cmd);
-				imap->ns_shared = parse_list(&cmd);
+				/* rfc2342 NAMESPACE response. */
+				skip_list(&cmd); /* Personal mailboxes */
+				skip_list(&cmd); /* Others' mailboxes */
+				skip_list(&cmd); /* Shared mailboxes */
 			} else if (!strcmp("OK", arg) || !strcmp("BAD", arg) ||
 				   !strcmp("NO", arg) || !strcmp("BYE", arg)) {
 				if ((resp = parse_response_code(ctx, NULL, cmd)) != RESP_OK)
@@ -834,9 +780,6 @@ static void imap_close_server(struct imap_store *ictx)
 		imap_exec(ictx, NULL, "LOGOUT");
 		socket_shutdown(&imap->buf.sock);
 	}
-	free_list(imap->ns_personal);
-	free_list(imap->ns_other);
-	free_list(imap->ns_shared);
 	free(imap);
 }
 
-- 
1.8.0.3
