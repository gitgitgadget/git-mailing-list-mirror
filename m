From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 23/27] struct ref_update: store refname as a FLEX_ARRAY
Date: Mon,  7 Apr 2014 15:48:14 +0200
Message-ID: <1396878498-19887-24-git-send-email-mhagger@alum.mit.edu>
References: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 15:49:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WX9vd-0003AS-8K
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 15:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755405AbaDGNta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 09:49:30 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:44178 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755392AbaDGNtK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 09:49:10 -0400
X-AuditID: 12074413-f79076d000002d17-b3-5342acd491b3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 12.88.11543.4DCA2435; Mon,  7 Apr 2014 09:49:08 -0400 (EDT)
Received: from michael.fritz.box (p5B156B1D.dip0.t-ipconnect.de [91.21.107.29])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s37DmJaU026029
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 7 Apr 2014 09:49:07 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsUixO6iqHtljVOwwZE+G4ud6yQsuq50M1k0
	9F5htph3dxeTxe0V85ktfrT0MFt87FzA7MDu8ff9ByaPnbPusntcevmdzePjs+XsHs969zB6
	XLyk7PF5k1wAexS3TVJiSVlwZnqevl0Cd8bcNwkFbbwV01fWNjBe5Opi5OSQEDCR+DV5ETOE
	LSZx4d56ti5GLg4hgcuMEqduPWCFcI4xSUx495INpIpNQFdiUU8zE4gtIqAmMbHtEAtIEbPA
	FUaJKx+3s4AkhAW8JP7c+AhWxCKgKnF1+T+gZg4OXgFXic3P/CG2yUmcPDaZFcTmBArPOHSL
	EcQWEnCRuL/mGMsERt4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3TN9XIzS/RSU0o3MULC
	TngH466TcocYBTgYlXh4Vx5yDBZiTSwrrsw9xCjJwaQkyvt8mVOwEF9SfkplRmJxRnxRaU5q
	8SFGCQ5mJRFertVAOd6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBO96
	kEbBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UFzEFwMjAyTFA7R3Ltje4oLEXKAo
	ROspRkUpcd4SkIQASCKjNA9uLCyZvGIUB/pSmPc5SBUPMBHBdb8CGswENNjQFWxwSSJCSqqB
	0Ttk/tXqyo+6pxQ5lva6rY5S8bD8dOuRXOWq0o2loVYWYuu9tRhnPOfTFudmuHFo9xzW6ase
	CrjH+h+dFdLSyyfJOO1vqeCK22mLHe8oPFixSqznVJip2v9eyxUMwfGyS5bft+lK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245851>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index b6778aa..2ff195f 100644
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
1.9.1
