From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 23/27] struct ref_update: Store refname as a FLEX_ARRAY.
Date: Mon, 24 Mar 2014 18:56:56 +0100
Message-ID: <1395683820-17304-24-git-send-email-mhagger@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 18:59:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS99A-0002Oo-T0
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 18:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753855AbaCXR56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 13:57:58 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:53655 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753829AbaCXR54 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2014 13:57:56 -0400
X-AuditID: 1207440d-f79d86d0000043db-29-533072230072
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id FA.23.17371.32270335; Mon, 24 Mar 2014 13:57:55 -0400 (EDT)
Received: from michael.fritz.box (p57A25F6C.dip0.t-ipconnect.de [87.162.95.108])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2OHv4xt028070
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 24 Mar 2014 13:57:53 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqKtcZBBsMO+5qMXOdRIWXVe6mSwa
	eq8wW8y7u4vJ4vaK+cwWP1p6mC0+di5gdmD3+Pv+A5PHzll32T0uvfzO5vHx2XJ2j2e9exg9
	Ll5S9vi8SS6APYrbJimxpCw4Mz1P3y6BO+PS5KmsBW28FZu//mVsYLzI1cXIySEhYCLx+uZD
	dghbTOLCvfVsXYxcHEIClxklrnQtAksICZxgklh8ggfEZhPQlVjU08wEYosIqElMbDvEAtLA
	LHAFqOHjdhaQhLCAt8SeD49YQWwWAVWJbwtnAw3i4OAVcJV48rEaYpmcxJTfC8DmcwKFt7Yf
	ZobY5SKx42Mv0wRG3gWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdI30cjNL9FJTSjcxQgKP
	dwfj/3UyhxgFOBiVeHg3mBoEC7EmlhVX5h5ilORgUhLl3VYIFOJLyk+pzEgszogvKs1JLT7E
	KMHBrCTCaxkOlONNSaysSi3Kh0lJc7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAoSfBOBRkq
	WJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4qM+GJgbICkeID21oK08xYXJOYCRSFa
	TzEqSonzXisASgiAJDJK8+DGwtLJK0ZxoC+FeeeDtPMAUxFc9yugwUxAg8Ob9EAGlyQipKQa
	GP1793j3v3yePrGfW15gxdOwPFW+UnnWz3OXumiscejpkrHZldPBwv3u8S82ObcZW658P5Az
	65DUDmP57l9v0+6wOxx3OuBX0K4affhY8epLSoK/6mRdX26yKHEXuSbR53z8WKHO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244855>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index d72d0ab..2b80f6d 100644
--- a/refs.c
+++ b/refs.c
@@ -3274,11 +3274,11 @@ static int update_ref_write(const char *action, const char *refname,
  * value or to zero to ensure the ref does not exist before update.
  */
 struct ref_update {
-	const char *refname;
 	unsigned char new_sha1[20];
 	unsigned char old_sha1[20];
 	int flags; /* REF_NODEREF? */
 	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
+	const char refname[FLEX_ARRAY];
 };
 
 /*
@@ -3301,12 +3301,8 @@ static void ref_transaction_free(struct ref_transaction *transaction)
 {
 	int i;
 
-	for (i = 0; i < transaction->nr; i++) {
-		struct ref_update *update = transaction->updates[i];
-
-		free((char *)update->refname);
-		free(update);
-	}
+	for (i = 0; i < transaction->nr; i++)
+		free(transaction->updates[i]);
 
 	free(transaction->updates);
 	free(transaction);
@@ -3320,9 +3316,10 @@ void ref_transaction_rollback(struct ref_transaction *transaction)
 static struct ref_update *add_update(struct ref_transaction *transaction,
 				     const char *refname)
 {
-	struct ref_update *update = xcalloc(1, sizeof(*update));
+	size_t len = strlen(refname);
+	struct ref_update *update = xcalloc(1, sizeof(*update) + len + 1);
 
-	update->refname = xstrdup(refname);
+	strcpy((char *)update->refname, refname);
 	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
 	transaction->updates[transaction->nr++] = update;
 	return update;
-- 
1.9.0
