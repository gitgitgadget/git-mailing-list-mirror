From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 25/33] add_update(): initialize the whole ref_update
Date: Fri,  6 May 2016 18:14:06 +0200
Message-ID: <64ba0ef8de63267f9625ce8303804a0814d1ecc6.1462550456.git.mhagger@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:15:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayiPp-0000NI-LA
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756726AbcEFQPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:15:40 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:58921 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758539AbcEFQPH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 12:15:07 -0400
X-AuditID: 1207440f-8a7ff700000008e4-13-572cc3098fcf
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 74.D5.02276.903CC275; Fri,  6 May 2016 12:15:05 -0400 (EDT)
Received: from michael.fritz.box (p508EA663.dip0.t-ipconnect.de [80.142.166.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u46GEHV7031758
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 6 May 2016 12:15:04 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1462550456.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqMt5WCfcYP15K4v5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxq7cDu8ff9ByaPnbPusns8693D6HHxkrLH/qXb2DwW
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd8aKWYcZC5bIVUzY1MvSwLhfoouRk0NCwETi1ImJ
	jF2MXBxCAlsZJRZOegPlHGeSaHixngmkik1AV2JRTzOYLSIQIdHwqgWoiIODWeAzo8RKbpCw
	sIC7REfDJWYQm0VAVWL9tdVsIDavQJTErp2LGSGWyUlcnv4ALM4pYCFxqPc42EghAXOJjrU3
	2Ccw8ixgZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuil5tZopeaUrqJERJg/DsYu9bLHGIU
	4GBU4uHNOKkdLsSaWFZcmXuIUZKDSUmU93uBTrgQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd4r
	+4ByvCmJlVWpRfkwKWkOFiVxXvUl6n5CAumJJanZqakFqUUwWRkODiUJ3kMHgRoFi1LTUyvS
	MnNKENJMHJwgw7mkRIpT81JSixJLSzLiQREQXwyMAZAUD9BeeZB23uKCxFygKETrKUZdjiP7
	761lEmLJy89LlRLnnQtSJABSlFGaB7cClk5eMYoDfSzMy30IqIoHmIrgJr0CWsIEtOT9XE2Q
	JSWJCCmpBkb5ZOmVF/+cnMy069Xixfn6aU++Xy/KdRJlUTw9R2ta9gari09cXCf9dYlJceON
	nWo344rp4zjWF7O/GbmXyfCvPPynw8Pi79yKNS3XV2zT+yN+cGas/+MwyXh7i4Cg 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293818>

Change add_update() to initialize all of the fields in the new
ref_update object. Rename the function to ref_transaction_add_update(),
and increase its visibility to all of the refs-related code.

All of this makes the function more useful for other future callers.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               | 48 ++++++++++++++++++++++++++----------------------
 refs/refs-internal.h | 14 ++++++++++++++
 2 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/refs.c b/refs.c
index 5dc2473..7c4eeb1 100644
--- a/refs.c
+++ b/refs.c
@@ -766,13 +766,33 @@ void ref_transaction_free(struct ref_transaction *transaction)
 	free(transaction);
 }
 
-static struct ref_update *add_update(struct ref_transaction *transaction,
-				     const char *refname)
+struct ref_update *ref_transaction_add_update(
+		struct ref_transaction *transaction,
+		const char *refname, unsigned int flags,
+		const unsigned char *new_sha1,
+		const unsigned char *old_sha1,
+		const char *msg)
 {
 	struct ref_update *update;
+
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		die("BUG: update called for transaction that is not open");
+
+	if ((flags & REF_ISPRUNING) && !(flags & REF_NODEREF))
+		die("BUG: REF_ISPRUNING set without REF_NODEREF");
+
 	FLEX_ALLOC_STR(update, refname, refname);
 	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
 	transaction->updates[transaction->nr++] = update;
+
+	update->flags = flags;
+
+	if (flags & REF_HAVE_NEW)
+		hashcpy(update->new_sha1, new_sha1);
+	if (flags & REF_HAVE_OLD)
+		hashcpy(update->old_sha1, old_sha1);
+	if (msg)
+		update->msg = xstrdup(msg);
 	return update;
 }
 
@@ -783,16 +803,8 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err)
 {
-	struct ref_update *update;
-
 	assert(err);
 
-	if (transaction->state != REF_TRANSACTION_OPEN)
-		die("BUG: update called for transaction that is not open");
-
-	if ((flags & REF_ISPRUNING) && !(flags & REF_NODEREF))
-		die("BUG: REF_ISPRUNING set without REF_NODEREF");
-
 	if (new_sha1 && !is_null_sha1(new_sha1) &&
 	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 		strbuf_addf(err, "refusing to update ref with bad name '%s'",
@@ -800,18 +812,10 @@ int ref_transaction_update(struct ref_transaction *transaction,
 		return -1;
 	}
 
-	update = add_update(transaction, refname);
-	if (new_sha1) {
-		hashcpy(update->new_sha1, new_sha1);
-		flags |= REF_HAVE_NEW;
-	}
-	if (old_sha1) {
-		hashcpy(update->old_sha1, old_sha1);
-		flags |= REF_HAVE_OLD;
-	}
-	update->flags = flags;
-	if (msg)
-		update->msg = xstrdup(msg);
+	flags |= (new_sha1 ? REF_HAVE_NEW : 0) | (old_sha1 ? REF_HAVE_OLD : 0);
+
+	ref_transaction_add_update(transaction, refname, flags,
+				   new_sha1, old_sha1, msg);
 	return 0;
 }
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 9686e60..babdf27 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -158,6 +158,20 @@ struct ref_update {
 };
 
 /*
+ * Add a ref_update with the specified properties to transaction, and
+ * return a pointer to the new object. This function does not verify
+ * that refname is well-formed. new_sha1 and old_sha1 are only
+ * dereferenced if the REF_HAVE_NEW and REF_HAVE_OLD bits,
+ * respectively, are set in flags.
+ */
+struct ref_update *ref_transaction_add_update(
+		struct ref_transaction *transaction,
+		const char *refname, unsigned int flags,
+		const unsigned char *new_sha1,
+		const unsigned char *old_sha1,
+		const char *msg);
+
+/*
  * Transaction states.
  * OPEN:   The transaction is in a valid state and can accept new updates.
  *         An OPEN transaction can be committed.
-- 
2.8.1
