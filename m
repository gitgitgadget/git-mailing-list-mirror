From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 01/48] refs.c: remove ref_transaction_rollback
Date: Thu, 19 Jun 2014 08:52:43 -0700
Message-ID: <1403193210-6028-2-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:56:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxehT-0000yz-5j
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758071AbaFSPxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:53:34 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:58934 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757376AbaFSPxd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:33 -0400
Received: by mail-pd0-f201.google.com with SMTP id v10so290586pde.0
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kq3XXdp1edMTtpoJN25JCFzkQCm5moN6xSZ1ZqwBlF8=;
        b=NALDEueBoXyas8bgGXNXcmYrVPxdpDGV1ULwPVFfX5uy4S1cGV0QsUiIPKmwYZkUvi
         AQ3q3tcuLRv8r11YmekeXjOTj4Ts5SxXolb7Z7jyYqF60tZjJLrcjjoZabKZvv8RWx7J
         whvALH3FIDraGq56pLFbYqMrv8DwnWtse46JpYT/5MmhEFWn4eBzkICgz9Cc7p6RTHPT
         eDGePK/L09JA6KYFNVBHWz9FqyM5zgF94/UDmBMzG0iaKeg5nN6R1ELskEwwRb9h9cvT
         cmdlqOMiXP4C9jUTxab86FFo5AGkbG8Z20KrfiZt6wIEflqCx7XRvxLxRag8934zr/KD
         zRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Kq3XXdp1edMTtpoJN25JCFzkQCm5moN6xSZ1ZqwBlF8=;
        b=CD4GkHs6sDcjRVsrxEzasVMzAufFNGrJn+IzKDsW1Dp9YrLY3PffEBYGZvNFgAkPbf
         DyAJJheIPa939dnnG+CEzr9gY5UOs3/Lln9pWpmGm93tn8eKkendOGTfL+SBs4nr4Yfo
         +BeV3qfIwjz0Xsr2Aaz6sFCzTCS8HAP/HSeE8bvOiYWwjT8u86oTAtGdgj9cv7tl/H3Z
         8sDkjMyIIJen99lwX1nOPCMGrsDF/40D3IVJ+wQT4ENSRpmEmwLlbRlpM1tjjBrNXXIi
         Nz6r+Yd/zlYT2EaG5CQJbTxX66yrwzqFDO6BVmPsJXuZZT9vtoO0OblgGtM/cEFqx1gz
         xUhQ==
X-Gm-Message-State: ALoCoQm3VExIjj5Mj4ErdOoUK6nSDU/9NlG1tqnJ5t0JC36YHM7Vsv6EXPwBmHaGmVLkpzkAHgNF
X-Received: by 10.66.65.142 with SMTP id x14mr2729948pas.14.1403193212791;
        Thu, 19 Jun 2014 08:53:32 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id j43si187559yhh.5.2014.06.19.08.53.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:32 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 99EAA31C3A6;
	Thu, 19 Jun 2014 08:53:32 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 446E4E033F; Thu, 19 Jun 2014 08:53:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252157>

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
2.0.0.438.g337c581
