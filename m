From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 32/44] refs.c: remove the update_ref_write function
Date: Thu, 15 May 2014 16:15:29 -0700
Message-ID: <1400195741-22996-33-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:17:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4ty-0007YW-10
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756280AbaEOXRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:17:04 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:58359 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756038AbaEOXPq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:46 -0400
Received: by mail-pb0-f73.google.com with SMTP id ma3so346891pbc.4
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SOIGgyobCUvJVhiESBKYZ65I5dtMwIr++aGKgnbgcCs=;
        b=c2jk2rFkhcTWsOsvJ5nqnH3sIL/C8+KX5k8KCODRnTXXFg/HAp79bBFrSJ3L0J0Tc9
         AWm609jTIrBpKAeEavvg0u49C9I3BiLrYHoWHOKDtZxmSvEz9ezFWvsmL+qYzWtBnxHr
         ZE74+bemUCyRbakZPqIUMzK/T94AU2nWQym60i19AHKcM5+xeV2i6uLGg21QwxhVdJEJ
         nEhG3kiTYugKGP4s+xOYtxsZduf/yqrW0EwiIatEoZNf81KVltyM3seHfnQIntAkgbZv
         2x2BhsLReDApjd73R6AxH9jESTSlxptByDQYUrJHcddNIA25ZLNNQ3ISNWJ9FSmw0l1q
         /UUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SOIGgyobCUvJVhiESBKYZ65I5dtMwIr++aGKgnbgcCs=;
        b=Om4xM0TIKDoSxiZKvJrgJ/39aTgphlk33Kx0stEPLMuXfRis89NkdtZ5AaIRFYaT7E
         HvsUwstPW937g7T+ropayU7Cr6ZG3vuY5Nzj3jWiT8dz7/J1+f9NINJOLJmbGQnQMF0W
         vPhTDd1CwJ+6Pyg7k3PF72iaCctWovlYRXRkl/lCvz3KpXTDUDbnaX97+VwN12PM9Kxk
         q6q+t7eJnqbR3bgdRFnXLhTgo2LsV54y2mwTqPZCsP0/nvXSG5IB614+uuKSCxLmsnKD
         IWSe4ra+YSyqGveNFoac3nmhPXONdPZWZN9u9DcdiLN20YFvZJf4LYtkbzjCtNcYCF5P
         ClrQ==
X-Gm-Message-State: ALoCoQmdhy1ozt1mwBD3ilWINSM7oKITA3X7wZYG3XyTGvJrVxAjujJ4l8FJ+NqjOSDgruCdcR9K
X-Received: by 10.66.216.130 with SMTP id oq2mr6452885pac.44.1400195745829;
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si318642yhk.4.2014.05.15.16.15.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id A4A8C31C25B;
	Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 84E28E0C53; Thu, 15 May 2014 16:15:45 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249250>

Since we only call update_ref_write from a single place and we only call it
with onerr==QUIET_ON_ERR we can just as well get rid of it and just call
write_ref_sha1 directly.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/refs.c b/refs.c
index 3b0d574..1857e61 100644
--- a/refs.c
+++ b/refs.c
@@ -3283,25 +3283,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
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
@@ -3549,14 +3530,16 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.rc3.477.gffe78a2
