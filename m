From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 21/26] struct ref_update: Store refname as a FLEX_ARRAY.
Date: Mon, 10 Mar 2014 13:46:38 +0100
Message-ID: <1394455603-2968-22-git-send-email-mhagger@alum.mit.edu>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 13:54:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMzj5-0005KL-UI
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 13:54:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753835AbaCJMyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 08:54:35 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:54344 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753831AbaCJMyd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 08:54:33 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Mar 2014 08:54:33 EDT
X-AuditID: 1207440c-f79656d000003eba-22-531db462f096
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 60.6E.16058.264BD135; Mon, 10 Mar 2014 08:47:30 -0400 (EDT)
Received: from michael.fritz.box (p57A2497B.dip0.t-ipconnect.de [87.162.73.123])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2ACkjwj025479
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Mar 2014 08:47:29 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqJu0RTbY4Fq7nsXOdRIWXVe6mSwa
	eq8wW8y7u4vJ4vaK+cwWP1p6mC0+di5gdmD3+Pv+A5PHzll32T0uvfzO5vHx2XJ2j2e9exg9
	Ll5S9vi8SS6APYrbJimxpCw4Mz1P3y6BO+PS4W62gt88Fds3rGNqYDzO1cXIySEhYCLxpfcs
	I4QtJnHh3nq2LkYuDiGBy4wS0zrnQTknmCRm9pxjB6liE9CVWNTTzARiiwioSUxsO8QCUsQs
	cIVR4vPXX2BFwgIeEm8P3QIbyyKgKtG+7wiYzSvgInFg0WwmiHVyElN+LwCr5wSKT7/yAMwW
	EnCWeLmnmXUCI+8CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbqGermZJXqpKaWbGCHBx7OD
	8ds6mUOMAhyMSjy8B97KBAuxJpYVV+YeYpTkYFIS5Z24VjZYiC8pP6UyI7E4I76oNCe1+BCj
	BAezkghv5mKgHG9KYmVValE+TEqag0VJnFd1ibqfkEB6YklqdmpqQWoRTFaGg0NJgrd+M1Cj
	YFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPCg64ouB8QGS4gHa6wDSzltckJgLFIVo
	PcWoKCXOOwckIQCSyCjNgxsLSymvGMWBvhTmbQWp4gGmI7juV0CDmYAGNx+XAhlckoiQkmpg
	VKrmvaaUdmCbxrmFRTZL5Yvd5u7R6DOI9FoaYtztdux/88nNbRtqVu+4HF2wWlTefHm9g3mt
	tEtry5vqYJvClq3zS1deUryek/u4rtBW2o6jZ703U4XJD+9ZD1zKzXU3b1wQbLoo 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243758>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 5d08cdf..335d0e2 100644
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
@@ -3301,12 +3301,8 @@ void free_ref_transaction(struct ref_transaction *transaction)
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
@@ -3315,9 +3311,10 @@ void free_ref_transaction(struct ref_transaction *transaction)
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
