From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 37/48] refs.c: remove the update_ref_write function
Date: Tue, 10 Jun 2014 15:29:25 -0700
Message-ID: <1402439376-25839-38-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:39:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUZx-0006FL-CG
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754151AbaFJWbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:31:36 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:44505 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753638AbaFJW3m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:42 -0400
Received: by mail-oa0-f73.google.com with SMTP id eb12so132340oac.0
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X/cPYc2OSZJ1CLtrKP0p+qtjDOlSnwjCTzLkjezeLhA=;
        b=S8k6Cko1mTvlUfQQv9hlI7EF2S6eJz3ALGAryA5TZ9Vs1kQdPtdx4HLxr5KG49cdL2
         vzqVEKrPVfVeubHz2/DJJa2kXSGkPYFuBfiHM/b028VF/HrdqHvrnbRupk2KqjZgkYvt
         f0HgtSBbGtmeueBSTPJvhWxy2b+BRUqdB5A/9zBe56dnt9jXkkRAiReBugGwFrtGZRzC
         a/YURIllAwl4cNjUTG4cpmhfbtAoESV0ru+XSpznC+cbtL7huj15YfTU7P1HMxR/lTi7
         ynGbsY46LI8+jU8FuuOldgGlYm9X1smJeaC6fYOY8X57PPB80ojrk5PYANbyt6j2q9vP
         LTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X/cPYc2OSZJ1CLtrKP0p+qtjDOlSnwjCTzLkjezeLhA=;
        b=N5XAsV8I0fYryeL+jZBCatQcVjzc1WAX7m5xnzb5cMTOsDeQuoG8DRp/ZarF74Y4Yv
         tqAzsm5uz0PifUiuzpkPpQXJRtqHTH1TyQnE9GhoyM6E7YXGNkwhC/M8K6wfw+4mMSgW
         Kfnf8apWYNO6+QcKmofmeBgUZAp9GUeYDdeu/ceER7zeMLjgsxAYlYBjLmVAmsov+PiI
         vYJRj+JAU5yKjpAKZ0SYQ/BEAmK7bEapRcMtF+lgUedFCroAtoSpKSDdWX/whB0LzFw4
         /Byyl97yu24RA2ZjpHdaphuwzunu5GIrXo2AlBSygrV1aOpEIWaEux7LKndvUIMo1up2
         N9lg==
X-Gm-Message-State: ALoCoQlNmgBFL8w7JI7oP/tb8WEYdtpsWPf6hOmlgrLYDiSVfIJHvx4kmXBDi2N7CJXBcpUlngrf
X-Received: by 10.182.104.161 with SMTP id gf1mr17774850obb.45.1402439381661;
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si1395396yhk.4.2014.06.10.15.29.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 8131931C746;
	Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 5E68EE0BF1; Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251298>

Since we only call update_ref_write from a single place and we only call it
with onerr==QUIET_ON_ERR we can just as well get rid of it and just call
write_ref_sha1 directly. This changes the return status for _commit from
1 to -1 on failures when writing to the ref. Eventually we will want
_commit to start returning more detailed error conditions than the current
simple success/failure. For example if the commit failed due to name
conflicts etc.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/refs.c b/refs.c
index c42472c..3e77cf8 100644
--- a/refs.c
+++ b/refs.c
@@ -3330,25 +3330,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
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
@@ -3599,14 +3580,16 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.574.g30c2c5e
