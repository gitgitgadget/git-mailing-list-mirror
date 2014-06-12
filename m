From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 01/48] refs.c: remove ref_transaction_rollback
Date: Thu, 12 Jun 2014 10:20:52 -0700
Message-ID: <1402593699-13983-2-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:22:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8hQ-0006vy-Hd
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:22:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756343AbaFLRV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:21:57 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:44685 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756187AbaFLRVn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:43 -0400
Received: by mail-qa0-f74.google.com with SMTP id w8so244875qac.5
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WGzWfYOM++sYCzre8Nfi1g7u9031TBUuAV+fGDsRQ/o=;
        b=ekcFPS/YfB/qI6eKDPXnkFOAdIIzPHrSD1VyJw85ogkCRLATrMPUqsVrq96ap8aO/8
         tmX9z3OL1dEajSwoq8WrlNAX45U/8u314VcOIuwMCw826BW9kB/t5RpDmgofYznidhC8
         JNZFKQ7p/PqheBqOXHGOrGwdiE6DvpkNNCbdGxRINqT9CbVR2ddEISFFmRN2beTsg+5+
         olnl5QPGb25GVBIUhuhHZnKEodbyDF2zeSZru4HdFCKPt3MUbcRl/wOGm59dDpp/2i6d
         sETZlC3xxGNnozRNTUwz9W/MCFxkbdKYqLsHzScdQoGzKnaVmPs3ei+j1F5T8FP82Pqc
         uOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WGzWfYOM++sYCzre8Nfi1g7u9031TBUuAV+fGDsRQ/o=;
        b=etVzJGbPYxJrcFkeIapA0C5uq8R0ZzImzN9NG6Arx5NY0NfVlQyhKOIrXAbqUpFUkQ
         FV6Jz7Y8gHj0q6bcFYYGYhHRTXOEG2OFt+Mc4nBebw6TD8u5MU2eSkeILsovgOnD0HRf
         fXH3N64hSiVzOnOxvFwvShaZ73T4H91D/5WnTgWTtUL19vN9nOHKEeb/+iCFU1s08gTZ
         ZWrrzhQcZnXVV6AXcJ7PFm5vmoHMKr85rLoSGPQGqT/F/vfHUNvFlh0uhgqBTBhSHMWt
         oRCN8KJGzAgBAeKNnjNtfn0TWQ5foUVa8v+Z7vbt5glnrkmELaXynKa8dMub0UGifSoT
         +p2g==
X-Gm-Message-State: ALoCoQlaL46APtu4yeTinmCdJbLCt9kqXy8ybAfGwWP1Q2YAANdpg1LvON0zJnqeF1XI8T0H9P/4
X-Received: by 10.236.150.114 with SMTP id y78mr67399yhj.7.1402593702958;
        Thu, 12 Jun 2014 10:21:42 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id t4si113763yhm.0.2014.06.12.10.21.42
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:42 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id CC65831C6AC;
	Thu, 12 Jun 2014 10:21:42 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 750DFE0A7E; Thu, 12 Jun 2014 10:21:42 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251422>

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
index 6898263..48573e3 100644
--- a/refs.c
+++ b/refs.c
@@ -3308,7 +3308,7 @@ struct ref_transaction *ref_transaction_begin(void)
 	return xcalloc(1, sizeof(struct ref_transaction));
 }
 
-static void ref_transaction_free(struct ref_transaction *transaction)
+void ref_transaction_free(struct ref_transaction *transaction)
 {
 	int i;
 
@@ -3319,11 +3319,6 @@ static void ref_transaction_free(struct ref_transaction *transaction)
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
index 09ff483..a07a5d0 100644
--- a/refs.h
+++ b/refs.h
@@ -216,18 +216,12 @@ enum action_on_err {
 
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
@@ -235,7 +229,6 @@ void ref_transaction_rollback(struct ref_transaction *transaction);
  * can be REF_NODEREF; it is passed to update_ref_lock().
  */
 
-
 /*
  * Add a reference update to transaction.  new_sha1 is the value that
  * the reference should have after the update, or zeros if it should
@@ -277,6 +270,11 @@ void ref_transaction_delete(struct ref_transaction *transaction,
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
2.0.0.599.g83ced0e
