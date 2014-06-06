From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 08/40] refs.c: add an err argument to delete_ref_loose
Date: Fri,  6 Jun 2014 15:28:46 -0700
Message-ID: <1402093758-3162-9-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:31:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2fv-0003X3-WD
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713AbaFFWbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:31:39 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:57658 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457AbaFFW3W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:22 -0400
Received: by mail-ie0-f202.google.com with SMTP id rd18so741072iec.1
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EDojycO1eO/Djyp3h+TIWtvc5oCitDXUvS75p2yDG4E=;
        b=V1PCFgauouqan1/+WA9uIoteUdgWokB+sqErybycCKsB3nNdeLgkXtsoSEqz+4e+A/
         PoKvUvpm2y4Bc/1Fb6yKJ/0FOMG7lEswX1DxvifPTffffkLcwV3fm0TH0dAWMkMNpQMM
         rW8qeIJdvsvA74vHHqhQ2E2onFCuOGTwusCI9b7Vzh77UGkksMF6crQwnO2NKsjNaUma
         R4ebRde3fgr96ROVAbjDs6qU0YiAel7FdP5YD1xRLatv4JuzIAvU9a3ybBeGbMUh5Utw
         sxU1aMrqX2oquIXO1b9wfrdezVg+NSKutlA3Mx/ih8NZRXNI9cA6YGjdKUaalL2Lg8vQ
         DO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EDojycO1eO/Djyp3h+TIWtvc5oCitDXUvS75p2yDG4E=;
        b=e2oFdC2/44qF/yfiG5SNqjN4SlHTO9Ghj6hnNq7g2b2kk86zwdb1CKWlML+I0pmb3E
         WVkjoH2IRClt0DHRr7uH8YnGu0VSTCm87qtVzWmhawSnKeZXRgVSuhUUtLYmwVtG23aQ
         tbus0wlny77yPB48sFThCimRxT08AmtZrrYj4i7fukwbw8NB4c/CJhv5Mui21Szq6MaU
         MAMxG1BriEyw6gEQSbZlPghNb0oJTUbuM2pmtG/fmErSdSY/tFEfHeP7VEMYBUUG1TtO
         0paW0BDoMyAUyq8mFQBU2JpteT2o9keFPOpVcWpBrRQjtm5AKvfWNUXvfAelbNIRGh3I
         B9Qg==
X-Gm-Message-State: ALoCoQmFEy0TN6XqeO6oozfWjo3bhG3VLiJaYkWX4V41Lr7CqF3E1hkMiHF69AutDDhFKfnUagm4
X-Received: by 10.50.148.1 with SMTP id to1mr3755523igb.0.1402093761997;
        Fri, 06 Jun 2014 15:29:21 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id ds6si750429vdb.0.2014.06.06.15.29.21
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:21 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id B9D9731C629;
	Fri,  6 Jun 2014 15:29:21 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6D77CE109D; Fri,  6 Jun 2014 15:29:21 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251009>

Add an err argument to delete_loose_ref so that we can pass a descriptive
error string back to the caller. Pass the err argument from transaction
commit to this function so that transaction users will have a nice error
string if the transaction failed due to delete_loose_ref.

Add a new function unlink_or_err that we can call from delete_ref_loose. This
function is similar to unlink_or_warn except that we can pass it an err
argument. If err is non-NULL the function will populate err instead of
printing a warning().

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 2d6941b..dd498cf 100644
--- a/refs.c
+++ b/refs.c
@@ -2510,16 +2510,38 @@ static int repack_without_ref(const char *refname)
 	return repack_without_refs(&refname, 1, NULL);
 }
 
-static int delete_ref_loose(struct ref_lock *lock, int flag)
+static int add_err_if_unremovable(const char *op, const char *file,
+				  struct strbuf *e, int rc)
+{
+	int err = errno;
+	if (rc < 0  && errno != ENOENT) {
+		strbuf_addf(e, "unable to %s %s: %s",
+			    op, file, strerror(errno));
+		errno = err;
+		return -1;
+	}
+	return 0;
+}
+
+static int unlink_or_err(const char *file, struct strbuf *err)
+{
+	if (err)
+		return add_err_if_unremovable("unlink", file, err,
+					      unlink(file));
+	else
+		return unlink_or_warn(file);
+}
+
+static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 {
 	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
 		/* loose */
-		int err, i = strlen(lock->lk->filename) - 5; /* .lock */
+		int res, i = strlen(lock->lk->filename) - 5; /* .lock */
 
 		lock->lk->filename[i] = 0;
-		err = unlink_or_warn(lock->lk->filename);
+		res = unlink_or_err(lock->lk->filename, err);
 		lock->lk->filename[i] = '.';
-		if (err && errno != ENOENT)
+		if (res && errno != ENOENT)
 			return 1;
 	}
 	return 0;
@@ -2533,7 +2555,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 	lock = lock_ref_sha1_basic(refname, sha1, delopt, &flag);
 	if (!lock)
 		return 1;
-	ret |= delete_ref_loose(lock, flag);
+	ret |= delete_ref_loose(lock, flag, NULL);
 
 	/* removing the loose one could have resurrected an earlier
 	 * packed one.  Also, if it was not loose we need to repack
@@ -3540,7 +3562,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 		if (update->lock) {
 			delnames[delnum++] = update->lock->ref_name;
-			ret |= delete_ref_loose(update->lock, update->type);
+			ret |= delete_ref_loose(update->lock, update->type,
+						err);
 		}
 	}
 
-- 
2.0.0.582.ge25c160
