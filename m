From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 01/41] refs.c: remove ref_transaction_rollback
Date: Tue, 27 May 2014 13:25:20 -0700
Message-ID: <1401222360-21175-2-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:27:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNyL-0004MU-F2
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753626AbaE0U1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:27:42 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:60402 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655AbaE0U0F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:05 -0400
Received: by mail-vc0-f202.google.com with SMTP id hq11so846720vcb.3
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=92TzHSdkfEDvsoYpamCS+OgO+YKvVeEE+jNTv27YQRo=;
        b=U9U0ybOBq/+STlX7D+gayZ0TI6V3qNDVA01Y7uuJZ9VZ2J1fE82gZQxsmJcy50WbtG
         WQiUkUZcORB9rhi7n7P6MEKNbThN9Z4pj69VOzFYT6w/KnVAFzcHj/T8q59Ax4+8CiKU
         r78kO53s9V5xuzUP83wjSO7qmmdyVNIf96olG3P7R35w6ggCFHFJq4sAcLtNAXtoO0ka
         k/QrGwMknj9atDugcycjXBmHaUe95rNkR91ETrdsMNMPM9p6ap1Fln4QchIWAniphmzk
         bhdqvgYRbYbyokiYKwie1bb+grya6kmbu1eD7r7vc1plvazsXAVw/5wVR3RRYSzECMeC
         eHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=92TzHSdkfEDvsoYpamCS+OgO+YKvVeEE+jNTv27YQRo=;
        b=iC183UBi1vxSQMdmBBdsGYwWAGehXSH1gDJhI6DIy+6i2FA7tSpBdmRA9zesUSNbkF
         8VG76bBh7sKmMfvW7fxkc7Su51SB00rUsS4ykW0+O7DlFJUMq1knpPStX6kx/REeT3wi
         9nReghsDIZ6ClOuSFfxDDIPsfxzfDr7PxXv1Ut74ycj/2nbtcMps1TCGhhZRVNaObG2T
         cFHKhBWO5sfNyCpZm4UWk3OtdRUz07h22KC9MGsuVDgVEfhMiwA5MKlQPje7yEqEbchd
         RhuffZWWw83fFMPwNs/RHjPS9NgIz1Pv3VwOQfedQCTgIijc5+v1Z+7j9ntvxFv7gf2k
         jH/A==
X-Gm-Message-State: ALoCoQnyOq7+Aj5Pe9mj3vRxDmoJpymQvlKNIqcJVf3YX5xBqWB2JVUTAwZzSReV93EiakkNsTvU
X-Received: by 10.58.30.108 with SMTP id r12mr13798345veh.17.1401222363888;
        Tue, 27 May 2014 13:26:03 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n68si1574638yhj.5.2014.05.27.13.26.03
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:03 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id A5E632F4ACE;
	Tue, 27 May 2014 13:26:03 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 3841DE0BB8; Tue, 27 May 2014 13:26:03 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250224>

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
2.0.0.rc3.474.g0203784
