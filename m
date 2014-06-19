From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 05/48] refs.c: add a strbuf argument to ref_transaction_commit for error logging
Date: Thu, 19 Jun 2014 08:52:47 -0700
Message-ID: <1403193210-6028-6-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:56:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxehR-0000yz-Sm
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758058AbaFSP4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:56:16 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:39391 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757656AbaFSPxe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:34 -0400
Received: by mail-qa0-f73.google.com with SMTP id m5so330844qaj.4
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c+BBQbGae9IFrvJ5as0L1y1yvYfn8IO2o90Iztdzr8k=;
        b=R4tKEAEUXTG3TzNf//vwltg2V4JPtx91s5IhEu2LwLroWcj32hDWnIgKn/WvOybbjT
         I/XH6z1V5XTPdVCRpHMcPq4ShWUNcp3LzLimV8x8MhLgCxrFdipI5iRxVuDevmfLJDz9
         7Ic2BSGTNuZEsnsXf61FFplzNDsZgHizIb21ImLEkkdOXHJuSmm8t1WR/9a9228+vg9n
         f1yU/bbDoRBD3kOxO6Rkuaul6CGraowCnka/WEBakhR39tcwa/IdmYoasPuLnAyV6g8X
         rvvEcKXgKyvVnK4M1/r+NcExi7n/P0MxonK4WYPpdhZlURFEaEgvs21NQqC8RNtWh/nb
         avlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c+BBQbGae9IFrvJ5as0L1y1yvYfn8IO2o90Iztdzr8k=;
        b=WE4E7gZ2c+Tl0SP5K0723kKJ5/EoQTb6hSUUcZaI2mehYcfwuk0wVbkt/pXYVGTEJF
         SQo+C8JklTaO/ZbdOuu0G0BSg7uTs9+tRRVZtjz1rEWNjISeYbH4nRsBpgF1I+PM+Wzs
         D64cJX8yAdR4EfQKFXYIPB7WRzLkdnwGjGgpg4Q2N6ExAmvhdrIxHbkQi4KGeMJXFuOL
         /+93yD87LS5xj8/M0PGD9YgjW6dU11IWIcCFjIkWjnZ1GfKXuLFKy+4WfCBhMdfMHCs9
         pVSSI+IZFHffsTkqsloWqGWj4Vmuqnu9ZSoxcXXzJ0kPcYBDR/prUxAZNodLvLZ5XPps
         ldeA==
X-Gm-Message-State: ALoCoQnDX2CMINFnRFf48rcTGb2xo18EgZf2OEVPNZhU761eVkGBpd9W3P98jvrmulz7gYlA13kW
X-Received: by 10.236.228.98 with SMTP id e92mr2249921yhq.58.1403193213126;
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id o69si418780yhp.6.2014.06.19.08.53.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 01B1F31C2E6;
	Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 88524E1106; Thu, 19 Jun 2014 08:53:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252156>

Add a strbuf argument to _commit so that we can pass an error string back to
the caller. So that we can do error logging from the caller instead of from
_commit.

Longer term plan is to first convert all callers to use onerr==QUIET_ON_ERR
and craft any log messages from the callers themselves and finally remove the
onerr argument completely.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 2 +-
 refs.c               | 6 +++++-
 refs.h               | 5 ++++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 1fd7a89..22617af 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -367,7 +367,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		if (end_null)
 			line_termination = '\0';
 		update_refs_stdin();
-		ret = ref_transaction_commit(transaction, msg,
+		ret = ref_transaction_commit(transaction, msg, NULL,
 					     UPDATE_REFS_DIE_ON_ERR);
 		ref_transaction_free(transaction);
 		return ret;
diff --git a/refs.c b/refs.c
index 1d6dece..db05602 100644
--- a/refs.c
+++ b/refs.c
@@ -3444,7 +3444,8 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 }
 
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, enum action_on_err onerr)
+			   const char *msg, struct strbuf *err,
+			   enum action_on_err onerr)
 {
 	int ret = 0, delnum = 0, i;
 	const char **delnames;
@@ -3473,6 +3474,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 					       update->flags,
 					       &update->type, onerr);
 		if (!update->lock) {
+			if (err)
+				strbuf_addf(err, "Cannot lock the ref '%s'.",
+					    update->refname);
 			ret = 1;
 			goto cleanup;
 		}
diff --git a/refs.h b/refs.h
index 8c7f9c4..09d3564 100644
--- a/refs.h
+++ b/refs.h
@@ -269,9 +269,12 @@ void ref_transaction_delete(struct ref_transaction *transaction,
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.  Return a nonzero value if there is a
  * problem.
+ * If err is non-NULL we will add an error string to it to explain why
+ * the transaction failed. The string does not end in newline.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, enum action_on_err onerr);
+			   const char *msg, struct strbuf *err,
+			   enum action_on_err onerr);
 
 /*
  * Free an existing transaction and all associated data.
-- 
2.0.0.438.g337c581
