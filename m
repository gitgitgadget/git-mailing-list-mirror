From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 05/14] imap-send.c: remove struct message
Date: Tue, 15 Jan 2013 09:06:23 +0100
Message-ID: <1358237193-8887-6-git-send-email-mhagger@alum.mit.edu>
References: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 09:07:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv1YV-0002VJ-UZ
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 09:07:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756638Ab3AOIHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 03:07:13 -0500
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:48808 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755754Ab3AOIHL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2013 03:07:11 -0500
X-AuditID: 12074413-b7f786d0000008bb-ec-50f50e2ed9e0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id AF.79.02235.E2E05F05; Tue, 15 Jan 2013 03:07:10 -0500 (EST)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0F86n5R029668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 15 Jan 2013 03:07:10 -0500
X-Mailer: git-send-email 1.8.0.3
In-Reply-To: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsUixO6iqKvH9zXA4F6bjUXXlW4mi4beK8wW
	t1fMZ3Zg9vj7/gOTx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGdsPXGIreAWX8WNA3eZGhiP
	cXcxcnJICJhItDWuZ4SwxSQu3FvP1sXIxSEkcJlRYsHmNUwQzhkmicWPf7GBVLEJ6Eos6mlm
	ArFFBNQkJrYdYgGxmQUcJDZ/bgSbJCxgI3H48hwwm0VAVWLTuSXsIDavgLPEo5e3WCC2KUi8
	3nmJFcTmFHCRuPrzGDOILQRU82XDacYJjLwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuma
	6+VmluilppRuYoQEi/AOxl0n5Q4xCnAwKvHw3tH9EiDEmlhWXJl7iFGSg0lJlLeD62uAEF9S
	fkplRmJxRnxRaU5q8SFGCQ5mJRFen3dA5bwpiZVVqUX5MClpDhYlcV61Jep+QgLpiSWp2amp
	BalFMFkZDg4lCd5sHqChgkWp6akVaZk5JQhpJg5OEMEFsoEHaMMrbqBC3uKCxNzizHSIolOM
	ilLivLUgEwRAEhmleXADYHH9ilEc6B9h3mSQKh5gSoDrfgU0mAlo8Ka9n0EGlyQipKQaGFnv
	Ndm9erDagFP3mED7TfGcPrUq87znMWv/qdqbK09Mkvbse6zBKCJTd3wm5yPbBrbTN3QrnLcf
	WCPzeMeVxx+XhT57mVR+d54ft1Jj/2yHk2vqme2bP8V9urRKNehE4t/vIaclY6oYL31WYVDY
	ddxw67eN6R8XOU4+tvCulJdC5Y8931ZmCyqxFGckGmoxFxUnAgBpT/BzxgIAAA== 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213607>

It was never used.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 imap-send.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index b8a7ff9..9e181e0 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -33,23 +33,10 @@ typedef void *SSL;
 #include <openssl/hmac.h>
 #endif
 
-/* For message->status */
-#define M_RECENT       (1<<0) /* unsyncable flag; maildir_* depend on this being 1<<0 */
-#define M_DEAD         (1<<1) /* expunged */
-#define M_FLAGS        (1<<2) /* flags fetched */
-
-struct message {
-	struct message *next;
-	size_t size; /* zero implies "not fetched" */
-	int uid;
-	unsigned char flags, status;
-};
-
 struct store {
 	/* currently open mailbox */
 	const char *name; /* foreign! maybe preset? */
 	char *path; /* own */
-	struct message *msgs; /* own */
 	int uidvalidity;
 	unsigned char opts; /* maybe preset? */
 	/* note that the following do _not_ reflect stats from msgs, but mailbox totals */
@@ -74,8 +61,6 @@ static void imap_warn(const char *, ...);
 
 static char *next_arg(char **);
 
-static void free_generic_messages(struct message *);
-
 __attribute__((format (printf, 3, 4)))
 static int nfsnprintf(char *buf, int blen, const char *fmt, ...);
 
@@ -447,16 +432,6 @@ static char *next_arg(char **s)
 	return ret;
 }
 
-static void free_generic_messages(struct message *msgs)
-{
-	struct message *tmsg;
-
-	for (; msgs; msgs = tmsg) {
-		tmsg = msgs->next;
-		free(msgs);
-	}
-}
-
 static int nfsnprintf(char *buf, int blen, const char *fmt, ...)
 {
 	int ret;
@@ -914,7 +889,6 @@ static void imap_close_server(struct imap_store *ictx)
 static void imap_close_store(struct store *ctx)
 {
 	imap_close_server((struct imap_store *)ctx);
-	free_generic_messages(ctx->msgs);
 	free(ctx);
 }
 
-- 
1.8.0.3
