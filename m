From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 04/13] struct ref_update: move "have_old" into "flags"
Date: Tue, 17 Feb 2015 18:00:14 +0100
Message-ID: <1424192423-27979-5-git-send-email-mhagger@alum.mit.edu>
References: <1424192423-27979-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 18:00:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNlVz-0003mH-Iq
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 18:00:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219AbbBQRAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 12:00:40 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:61587 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752171AbbBQRAj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Feb 2015 12:00:39 -0500
X-AuditID: 1207440f-f792a6d000001284-d5-54e373b621a9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 1C.5E.04740.6B373E45; Tue, 17 Feb 2015 12:00:38 -0500 (EST)
Received: from michael.fritz.box (p5DDB008A.dip0.t-ipconnect.de [93.219.0.138])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1HH0TXZ000419
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 17 Feb 2015 12:00:37 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1424192423-27979-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsUixO6iqLut+HGIwZJvBhZdV7qZLBp6rzBb
	vL25hNHi9or5zBbdU94yWvT2fWK12Ly5ncWB3ePv+w9MHjtn3WX3WLCp1OPiJWWPz5vkAlij
	uG2SEkvKgjPT8/TtErgzZnU8ZCrYKFHRemsvYwPjS6EuRk4OCQETiV+XDrNC2GISF+6tZ+ti
	5OIQErjMKHFx3xdWCOc4k8Sj6X/AqtgEdCUW9TQzgdgiAmoSE9sOsYDYzAKrmSS23mUDsYUF
	PCVOv/3CCGKzCKhKPP86iRnE5hVwkfh9+g8TxDY5ifPHf4LFOQVcJZb9WsYOYgsB1czvmM00
	gZF3ASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdE73czBK91JTSTYyQMOPfwdi1XuYQowAH
	oxIPr8WERyFCrIllxZW5hxglOZiURHnDix6HCPEl5adUZiQWZ8QXleakFh9ilOBgVhLhDUoB
	yvGmJFZWpRblw6SkOViUxHnVl6j7CQmkJ5akZqemFqQWwWRlODiUJHhNQYYKFqWmp1akZeaU
	IKSZODhBhnNJiRSn5qWkFiWWlmTEg2IjvhgYHSApHqC9eiDtvMUFiblAUYjWU4yKUuK8KSAJ
	AZBERmke3FhY8njFKA70pTDvOpAqHmDiget+BTSYCWjw/D+PQAaXJCKkpBoYLfc++MGge27a
	uke7XmfO3qEhtzZis+9567XH1FOjDS9fPNVb6Xy+tjBgXnf8komS+yve3snY2l3J0vbf+XBd
	k98OX69f+43qcybwmTNa1xctyjpcMb9c/ljcod4YbTYxzvW+904f+CAQGrRwxXXB 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263955>

Instead of having a separate have_old field, record this boolean value
as a bit in the "flags" field.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 45 ++++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/refs.c b/refs.c
index a203e44..e3a2ba8 100644
--- a/refs.c
+++ b/refs.c
@@ -41,12 +41,18 @@ static unsigned char refname_disposition[256] = {
 #define REF_DELETING	0x02
 
 /*
- * Used as a flag to ref_transaction_delete when a loose ref is being
+ * Used as a flag in ref_update::flags when a loose ref is being
  * pruned.
  */
 #define REF_ISPRUNING	0x04
 
 /*
+ * Used as a flag in ref_update::flags when old_sha1 should be
+ * checked.
+ */
+#define REF_HAVE_OLD	0x08
+
+/*
  * Try to read one refname component from the front of refname.
  * Return the length of the component found, or -1 if the component is
  * not legal.  It is legal if it is something reasonable to have under
@@ -3563,16 +3569,20 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 }
 
 /**
- * Information needed for a single ref update.  Set new_sha1 to the
- * new value or to zero to delete the ref.  To check the old value
- * while locking the ref, set have_old to 1 and set old_sha1 to the
- * value or to zero to ensure the ref does not exist before update.
+ * Information needed for a single ref update. Set new_sha1 to the new
+ * value or to null_sha1 to delete the ref. To check the old value
+ * while the ref is locked, set (flags & REF_HAVE_OLD) and set
+ * old_sha1 to the old value, or to null_sha1 to ensure the ref does
+ * not exist before update.
  */
 struct ref_update {
 	unsigned char new_sha1[20];
 	unsigned char old_sha1[20];
-	unsigned int flags; /* REF_NODEREF? */
-	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
+	/*
+	 * One or more of REF_HAVE_OLD, REF_NODEREF,
+	 * REF_DELETING, and REF_ISPRUNING:
+	 */
+	unsigned int flags;
 	struct ref_lock *lock;
 	int type;
 	char *msg;
@@ -3666,10 +3676,11 @@ int ref_transaction_update(struct ref_transaction *transaction,
 
 	update = add_update(transaction, refname);
 	hashcpy(update->new_sha1, new_sha1);
-	update->flags = flags;
-	update->have_old = have_old;
-	if (have_old)
+	if (have_old) {
 		hashcpy(update->old_sha1, old_sha1);
+		flags |= REF_HAVE_OLD;
+	}
+	update->flags = flags;
 	if (msg)
 		update->msg = xstrdup(msg);
 	return 0;
@@ -3785,13 +3796,13 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 		if (is_null_sha1(update->new_sha1))
 			flags |= REF_DELETING;
-		update->lock = lock_ref_sha1_basic(update->refname,
-						   (update->have_old ?
-						    update->old_sha1 :
-						    NULL),
-						   NULL,
-						   flags,
-						   &update->type);
+		update->lock = lock_ref_sha1_basic(
+				update->refname,
+				((update->flags & REF_HAVE_OLD) ?
+				 update->old_sha1 : NULL),
+				NULL,
+				flags,
+				&update->type);
 		if (!update->lock) {
 			ret = (errno == ENOTDIR)
 				? TRANSACTION_NAME_CONFLICT
-- 
2.1.4
