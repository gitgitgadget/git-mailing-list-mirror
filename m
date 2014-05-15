From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 32/44] refs.c: remove the update_ref_write function
Date: Thu, 15 May 2014 10:29:47 -0700
Message-ID: <1400174999-26786-33-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:32:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzVf-000206-Q1
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755787AbaEORbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:31:50 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:36886 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755681AbaEORaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:09 -0400
Received: by mail-pa0-f74.google.com with SMTP id rd3so257158pab.5
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wDx7bHVc3lBEUSACcHR+dbvaQTuCpLnGPukots9VBqU=;
        b=Tfhobpr2ioU6eLVx5iFis6WtaWjPyO14VcsQXqXxM4yuB1TPU7oDLJnUrIs7hE0Ir/
         w5vHcLFue5W33OguqvDdgpV7uyGHcyB3D9ybwI1IdcbLhkvDo1gzaUNUjBI0BSSEF+27
         7WI6+IJAbkUFImG8lDdAa4BCBgAfJUlUi/ETJK3BAEjHcnhGYnrO5kg+gfHznf0FEYXO
         poGLAVozRddfp3BXGoxtsEA7ZRdi3yopjj3TtqOy5rOYcTL496Ly1XGVBYK2mkh6rnTD
         Uo2w98igecEMU7e5+YMjs3JfUeCS0IhNWcCJXGKMsVToTgw9eknulWw1y4a+ECX5Uhwm
         O+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wDx7bHVc3lBEUSACcHR+dbvaQTuCpLnGPukots9VBqU=;
        b=fHHQ/s9gG364WBFY7QJdCt607xHKIeA3nJriBmFg2adNYCqNlYeRfLp0v0tN6s5NAl
         tRCQbCn1BnUot78cjhMMCDQsCUnqTqlMhstB5ywB9VDk2sOYftzXpQwgf+1N3CiX68bP
         VAXmbkzbpvvscI6msokQWX2nMQaP7wYSLozyUKoJxz3Cj3WF+C7r7AG4IIE/dwDxzGHs
         stNZQdqa+Lise4Fx8onvggHsylvECS+YnKSI33C3fR1sMb46R+MwExCPhgklP2bdO3kB
         mFUIRVdCexGgdZ2qrsrV9JjFxOYCBYv7hOsXgLB4aXc0+JijedBp4Sqt5J8GRzRqgqdv
         ZoKA==
X-Gm-Message-State: ALoCoQmiANhbTZ4f363vmJg4emBBM9DpHzhKFK4VpLjzhgGHVbRDTUQg0ktNcgWyJ+wiVV2Kh0RQ
X-Received: by 10.66.230.226 with SMTP id tb2mr2861436pac.41.1400175007160;
        Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si273168yhk.4.2014.05.15.10.30.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 0035231C239;
	Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D03EAE1747; Thu, 15 May 2014 10:30:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249151>

Since we only call update_ref_write from a single place and we only call it
with onerr==QUIET_ON_ERR we can just as well get rid of it and just call
write_ref_sha1 directly.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/refs.c b/refs.c
index 07377ad..7aa5512 100644
--- a/refs.c
+++ b/refs.c
@@ -3255,25 +3255,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 	return retval;
 }
 
-static int update_ref_write(const char *action, const char *refname,
-			    const unsigned char *sha1, struct ref_lock *lock,
-			    struct strbuf *err, enum action_on_err onerr)
-{
-	if (write_ref_sha1(lock, sha1, action) < 0) {
-		const char *str = "Cannot update the ref '%s'.";
-		if (err)
-			strbuf_addf(err, str, refname);
-
-		switch (onerr) {
-		case UPDATE_REFS_MSG_ON_ERR: error(str, refname); break;
-		case UPDATE_REFS_DIE_ON_ERR: die(str, refname); break;
-		case UPDATE_REFS_QUIET_ON_ERR: break;
-		}
-		return 1;
-	}
-	return 0;
-}
-
 /**
  * Information needed for a single ref update.  Set new_sha1 to the
  * new value or to zero to delete the ref.  To check the old value
@@ -3518,14 +3499,16 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (!is_null_sha1(update->new_sha1)) {
-			ret = update_ref_write(msg,
-					       update->refname,
-					       update->new_sha1,
-					       update->lock, err,
-					       UPDATE_REFS_QUIET_ON_ERR);
-			update->lock = NULL; /* freed by update_ref_write */
-			if (ret)
+			ret = write_ref_sha1(update->lock, update->new_sha1,
+					     msg);
+			update->lock = NULL; /* freed by write_ref_sha1 */
+			if (ret) {
+				const char *str = "Cannot update the ref '%s'.";
+
+				if (err)
+					strbuf_addf(err, str, update->refname);
 				goto cleanup;
+			}
 		}
 	}
 
-- 
2.0.0.rc3.477.g0f8edf7
