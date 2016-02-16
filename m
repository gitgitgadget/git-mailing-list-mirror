From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 18/20] delete_ref_loose(): inline function
Date: Tue, 16 Feb 2016 14:22:31 +0100
Message-ID: <59ef9e1f7f750564411f141efdfa07cbb906be13.1455626201.git.mhagger@alum.mit.edu>
References: <cover.1455626201.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 14:30:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfiL-0003Ac-At
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:30:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbcBPNao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 08:30:44 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:48662 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932384AbcBPNak (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 08:30:40 -0500
X-AuditID: 12074414-89fff70000005020-fc-56c322c4bcc3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 3C.1E.20512.4C223C65; Tue, 16 Feb 2016 08:23:16 -0500 (EST)
Received: from michael.fritz.box (p548D6919.dip0.t-ipconnect.de [84.141.105.25])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1GDMfOe028717
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Feb 2016 08:23:14 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1455626201.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqHtE6XCYwdZ1AhbzN51gtOi60s1k
	0dB7hdniw9pDbBa9k3tZLW6vmM9s8aOlh9mB3ePv+w9MHk+3T2H2eHG+wuNZ7x5Gj4uXlD0W
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd8bUfZ/ZC2byVJw5vICxgfEGZxcjJ4eEgInEvpd3
	2bsYuTiEBLYySvQuW8EE4Zxgknh2uI8JpIpNQFdiUU8zmC0ioCYxse0QC0gRs8AjRomu/dsZ
	uxg5OIQFrCQ6/oSA1LAIqEpceDKDGcTmFYiS2Pp1JxPENjmJlh+7WUFsTgELiZMtvSwgtpCA
	ucSdL3uYJjDyLGBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka6GXm1mil5pSuokREmIiOxiP
	nJQ7xCjAwajEw8vhcShMiDWxrLgy9xCjJAeTkigvD/fhMCG+pPyUyozE4oz4otKc1OJDjBIc
	zEoivP9eAZXzpiRWVqUW5cOkpDlYlMR5vy1W9xMSSE8sSc1OTS1ILYLJynBwKEnwflIEGipY
	lJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPioH4YmAUgKR4gPamgbTzFhck5gJFIVpP
	MSpKifPuB0kIgCQySvPgxsISxytGcaAvhXm7Qap4gEkHrvsV0GAmoME5l0AeKi5JREhJNTB6
	PmBqL3+0dEWZtLH4yrU+rQbGT3W1z6cevdV9PPngt3frgy54ajY83b7jySK95dFHF2boHZp9
	b9oVeWut3/LrHospeBzXCn7s7Vj8i+3Ofsl3H0okpe0XMLdl5/4QXrbGLbF1k6jg 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286382>

It was hardly doing anything anymore.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 754d254..b2b0f39 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2336,21 +2336,6 @@ static int repack_without_refs(struct string_list *refnames, struct strbuf *err)
 	return ret;
 }
 
-static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
-{
-	assert(err);
-
-	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
-		/*
-		 * loose.  The loose file name is the same as the
-		 * lockfile name, minus ".lock":
-		 */
-		if (unlink_or_msg(git_path("%s", lock->ref_name), err))
-			return 1;
-	}
-	return 0;
-}
-
 int delete_refs(struct string_list *refnames)
 {
 	struct strbuf err = STRBUF_INIT;
@@ -3257,9 +3242,13 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (update->flags & REF_DELETING) {
-			if (delete_ref_loose(update->lock, update->type, err)) {
-				ret = TRANSACTION_GENERIC_ERROR;
-				goto cleanup;
+			if (!(update->type & REF_ISPACKED) ||
+			    update->type & REF_ISSYMREF) {
+				/* It is a loose reference. */
+				if (unlink_or_msg(git_path("%s", update->lock->ref_name), err)) {
+					ret = TRANSACTION_GENERIC_ERROR;
+					goto cleanup;
+				}
 			}
 
 			if (!(update->flags & REF_ISPRUNING))
-- 
2.7.0
