From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 01/48] refs.c: remove ref_transaction_rollback
Date: Tue, 17 Jun 2014 08:53:15 -0700
Message-ID: <1403020442-31049-2-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:54:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwvi8-0003O5-Sm
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756363AbaFQPyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:54:08 -0400
Received: from mail-ig0-f202.google.com ([209.85.213.202]:63498 "EHLO
	mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755479AbaFQPyF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:05 -0400
Received: by mail-ig0-f202.google.com with SMTP id r2so360927igi.1
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ax21INl2JnF/vW1gdzxjxNzxLNkwC6j05C8T6IUVmMY=;
        b=pYUHv/mCJUm5g+1GvEeTp48h2/7tE22heDRUJ3PATHHhy099e15/2XFBm+IiJ/8SGd
         3IW8bN8N5GONO2l3jiYMumM2GYCA9+Z2zLzS40rcE3JP6PjssYca/aSCfsWLODDitJtf
         GR4MMRAMG2y6brlNWjnT3b5z+o/6tRs/BY7VusdEeD3DK1xz/LUa3oAnuOJ/HIRIU+UP
         e2bcD5sjOnQI7EmjQwaHKzDL0RRSwPX70E0bYGN4YnNsCUOHRJVtX7IXjDYcbeGxyJjT
         zIy8qTaw8iLQ/hagTGGONPxvfjn/vZn0kqzwjlBqqUoJu32d7NNac0VHpT1vugYus0R+
         Axbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ax21INl2JnF/vW1gdzxjxNzxLNkwC6j05C8T6IUVmMY=;
        b=jXy4Sjt66AxFLO26KniyA50CoKARprqSfFHTi/ysT9n7d4TGJipFjXswl2JUGVYO90
         3IE56syKZx1WrtSPH8KC6nBDWo9Mjes1NliLTT12e+8P15Y+r1HCs0R0G3/chweVSYgh
         NbkLmCCVxB7utFJsLdH/Irfi6SdpZMHOBUGUfTEM900lcVObOZl0EJb/8HpecfIW4ghd
         l4LmXdUXaYWKoVUgiJ0U1gzazHRZ1BVgtyJ/5d/GuT3A3af8LBD+Il+5TzW7j7xDSkJN
         YPwDjast/qkFbC1vLzgqoz0ZdWLCb2zDT9ERLtxUQoz7+Mq0g62fD6PPKBfYL+Qwz7BG
         arqA==
X-Gm-Message-State: ALoCoQlWR1+8DDh7VDwn4ybeqQhR3m0gHtwSIrLTavH630ZroXVPh6iD3NeKy4stc3Yb7HqpsShh
X-Received: by 10.182.250.229 with SMTP id zf5mr377480obc.4.1403020444301;
        Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si1208712yhk.4.2014.06.17.08.54.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 216D45A4367;
	Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id BD36AE036B; Tue, 17 Jun 2014 08:54:03 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251871>

We do not yet need both a rollback and a free function for transactions.
Remove ref_transaction_rollback and use ref_transaction_free instead.

At a later stage we may reintroduce a rollback function if we want to start
adding reusable transactions and similar.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c |  7 +------
 refs.h | 16 +++++++---------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/refs.c b/refs.c
index dc45774..6d841a0 100644
--- a/refs.c
+++ b/refs.c
@@ -3334,7 +3334,7 @@ struct ref_transaction *ref_transaction_begin(void)
 	return xcalloc(1, sizeof(struct ref_transaction));
 }
 
-static void ref_transaction_free(struct ref_transaction *transaction)
+void ref_transaction_free(struct ref_transaction *transaction)
 {
 	int i;
 
@@ -3345,11 +3345,6 @@ static void ref_transaction_free(struct ref_transaction *transaction)
 	free(transaction);
 }
 
-void ref_transaction_rollback(struct ref_transaction *transaction)
-{
-	ref_transaction_free(transaction);
-}
-
 static struct ref_update *add_update(struct ref_transaction *transaction,
 				     const char *refname)
 {
diff --git a/refs.h b/refs.h
index 4e3050d..cfd1832 100644
--- a/refs.h
+++ b/refs.h
@@ -219,18 +219,12 @@ enum action_on_err {
 
 /*
  * Begin a reference transaction.  The reference transaction must
- * eventually be commited using ref_transaction_commit() or rolled
- * back using ref_transaction_rollback().
+ * eventually be commited using ref_transaction_commit() or freed by
+ * calling ref_transaction_free().
  */
 struct ref_transaction *ref_transaction_begin(void);
 
 /*
- * Roll back a ref_transaction and free all associated data.
- */
-void ref_transaction_rollback(struct ref_transaction *transaction);
-
-
-/*
  * The following functions add a reference check or update to a
  * ref_transaction.  In all of them, refname is the name of the
  * reference to be affected.  The functions make internal copies of
@@ -238,7 +232,6 @@ void ref_transaction_rollback(struct ref_transaction *transaction);
  * can be REF_NODEREF; it is passed to update_ref_lock().
  */
 
-
 /*
  * Add a reference update to transaction.  new_sha1 is the value that
  * the reference should have after the update, or zeros if it should
@@ -280,6 +273,11 @@ void ref_transaction_delete(struct ref_transaction *transaction,
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   const char *msg, enum action_on_err onerr);
 
+/*
+ * Free an existing transaction and all associated data.
+ */
+void ref_transaction_free(struct ref_transaction *transaction);
+
 /** Lock a ref and then write its file */
 int update_ref(const char *action, const char *refname,
 		const unsigned char *sha1, const unsigned char *oldval,
-- 
2.0.0.438.gec92e5c
