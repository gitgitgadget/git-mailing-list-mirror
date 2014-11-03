From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 04/15] refs.c: add a new update_type field to ref_update
Date: Mon,  3 Nov 2014 08:55:46 -0800
Message-ID: <1415033757-9539-5-git-send-email-sahlberg@google.com>
References: <1415033757-9539-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 17:59:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlKyc-0003Rr-Gr
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 17:59:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbaKCQ7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 11:59:15 -0500
Received: from mail-yh0-f74.google.com ([209.85.213.74]:43069 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229AbaKCQ4D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 11:56:03 -0500
Received: by mail-yh0-f74.google.com with SMTP id 29so706855yhl.3
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 08:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zZZGO80bXJLIMAgWZZAKFTFCRkLsC93hKZmiW7iRkqs=;
        b=igEjXfle4WMitqVEHnXiAPVpcMLHwRy1IvChcjpqZXDs2/9SUYBY0hro7RwnkEgzaN
         uqKkEbH5PI3UnCMYyxekwpGwtyFVyczagoPvoQDnAp0ptCPUyfQIIGcoSbL940Z9WL6L
         Lh/nBkd6GE3rt5ar4euAlwj6hw41ZFYMw5QZRMRP+/Qks2uRCv/nYqfidZkbu3MMQd/1
         TN76ssk4w7Da0u+LKmhF0lBR1PZ6ANugTrIRn7vdhw+32AkaLjk43E++15XM3+KfoADf
         nVjkE25/0WIWZ1YSGrsNxlre6w8ZexNob1JSlQDoMibBzICkzJ80ELPoP+48Uj3XBPGE
         tjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zZZGO80bXJLIMAgWZZAKFTFCRkLsC93hKZmiW7iRkqs=;
        b=M6969Eye+MAK4Y+koOQ8YPrlNEj8ODITdduS8h3pWHmUe9nDb8kOBl2wLbNlzfAVvp
         G6eCIpPelkAgUJ2yyHTjP0iTZZXpnupi5cnSr/52oUZSDFkMxI6LfdjCfTMTJvPc+ECV
         UoV/OmWrRGzvV6vrq24vXwNNIAkuhSA01zEnr5sDysDvVk4XdzhWGcHmzeR8cAwT92Ef
         qEztMll5BVXyoooRFD8UeiURs4PQG10/GrL9lWKYW66krnW3HWCj55zwy5SomTDixoHa
         FcSF4n/PCuh2v9iHhjvnkyQU2wB+EAHV3uo9YocWH62jbfYL3B3A2cuPS1SyhYHYZC5C
         tscA==
X-Gm-Message-State: ALoCoQnlZE7ZYZBmw7N4nmnBZsyOFRdJmKXydkfqH6jL3Mc/JQea4t2pimWm4VFI5na91JoymMRd
X-Received: by 10.236.15.131 with SMTP id f3mr2444993yhf.57.1415033762873;
        Mon, 03 Nov 2014 08:56:02 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id 5si150658yhd.6.2014.11.03.08.56.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 08:56:02 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id ympwsOQP.1; Mon, 03 Nov 2014 08:56:02 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id F0A32E0967; Mon,  3 Nov 2014 08:56:01 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
In-Reply-To: <1415033757-9539-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a field that describes what type of update this refers to. For now
the only type is UPDATE_SHA1 but we will soon add more types.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index a1bfaa2..8803b95 100644
--- a/refs.c
+++ b/refs.c
@@ -3504,6 +3504,10 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 	return retval;
 }
 
+enum transaction_update_type {
+	UPDATE_SHA1 = 0
+};
+
 /**
  * Information needed for a single ref update.  Set new_sha1 to the
  * new value or to zero to delete the ref.  To check the old value
@@ -3511,6 +3515,7 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
  * value or to zero to ensure the ref does not exist before update.
  */
 struct ref_update {
+	enum transaction_update_type update_type;
 	unsigned char new_sha1[20];
 	unsigned char old_sha1[20];
 	int flags; /* REF_NODEREF? */
@@ -3571,12 +3576,14 @@ void transaction_free(struct transaction *transaction)
 }
 
 static struct ref_update *add_update(struct transaction *transaction,
-				     const char *refname)
+				     const char *refname,
+				     enum transaction_update_type update_type)
 {
 	size_t len = strlen(refname);
 	struct ref_update *update = xcalloc(1, sizeof(*update) + len + 1);
 
 	strcpy((char *)update->refname, refname);
+	update->update_type = update_type;
 	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
 	transaction->updates[transaction->nr++] = update;
 	return update;
@@ -3606,7 +3613,7 @@ int transaction_update_ref(struct transaction *transaction,
 		return -1;
 	}
 
-	update = add_update(transaction, refname);
+	update = add_update(transaction, refname, UPDATE_SHA1);
 	hashcpy(update->new_sha1, new_sha1);
 	update->flags = flags;
 	update->have_old = have_old;
@@ -3684,13 +3691,17 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 
 	assert(err);
 
-	for (i = 1; i < n; i++)
+	for (i = 1; i < n; i++) {
+		if (updates[i - 1]->update_type != UPDATE_SHA1 ||
+		    updates[i]->update_type != UPDATE_SHA1)
+			continue;
 		if (!strcmp(updates[i - 1]->refname, updates[i]->refname)) {
 			strbuf_addf(err,
 				    "Multiple updates for ref '%s' not allowed.",
 				    updates[i]->refname);
 			return 1;
 		}
+	}
 	return 0;
 }
 
@@ -3722,13 +3733,17 @@ int transaction_commit(struct transaction *transaction,
 		goto cleanup;
 	}
 
-	/* Acquire all locks while verifying old values */
+	/* Acquire all ref locks while verifying old values */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 		int flags = update->flags;
 
+		if (update->update_type != UPDATE_SHA1)
+			continue;
+
 		if (is_null_sha1(update->new_sha1))
 			flags |= REF_DELETING;
+
 		update->lock = lock_ref_sha1_basic(update->refname,
 						   (update->have_old ?
 						    update->old_sha1 :
@@ -3750,6 +3765,8 @@ int transaction_commit(struct transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
+		if (update->update_type != UPDATE_SHA1)
+			continue;
 		if (!is_null_sha1(update->new_sha1)) {
 			if (write_ref_sha1(update->lock, update->new_sha1,
 					   update->msg)) {
@@ -3767,6 +3784,8 @@ int transaction_commit(struct transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
+		if (update->update_type != UPDATE_SHA1)
+			continue;
 		if (update->lock) {
 			if (delete_ref_loose(update->lock, update->type, err)) {
 				ret = TRANSACTION_GENERIC_ERROR;
-- 
2.1.0.rc2.206.gedb03e5
