From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 31/44] refs.c: remove the update_ref_lock function
Date: Thu, 15 May 2014 16:15:28 -0700
Message-ID: <1400195741-22996-32-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:17:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4tg-0006jI-1W
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756273AbaEOXRB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:17:01 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:57211 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756051AbaEOXPq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:46 -0400
Received: by mail-ob0-f201.google.com with SMTP id wn1so390640obc.4
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TGAF8zIugwiPJjqRuxbWryG7HefcQMnqnKwxLnr17s0=;
        b=IPyW7p3+4ZV2OXDiANtYGe8vIkLI5Ztziggccx9IP59bqzOWj3t+qb1W2vmRHbRsQq
         PdMhShSIgChtV3v2LIBx1gWUksZbF6PwVyxKNKUgh4BBAE8sUVLx7ooej0I2SZ1W1dbk
         jOBEjWkm4L82LldOIO+pdSN1etAOE7OqweGrDPPqcA2K2my60bwCF4YGk/msDsd/1p71
         4BaNiHx4EficG6ZoXjUPZhOLRqTqBmHhupDv83sv+HVzfGqO6ZJwQkj5mUhMQ6NBBHeV
         LQqxO1NEKgg9wr4btDeYZCDBalYESGhE8DvlKYgDX02YdIxqApROJNUt5z657d+bT2tA
         PTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TGAF8zIugwiPJjqRuxbWryG7HefcQMnqnKwxLnr17s0=;
        b=GUbmZg2uf/K95XbqVMGlquyaOqN6L4TxmZwOCYfKSm8AIByzl8FIGLa8Rz7SzVWw03
         0WmreZINMIS6dRtq8IE/H5L40Smtr25JuQiIJAQrIxqfXp1NYlGOr1lpv0Agearn0L/r
         e3gvGFRNGDsb4lqDTKZsEEromqJ4lljnHVhRL7E33jN1hdKAK4PdMKXZFGBHHktjxg5M
         FhkBGtfjecq7eqbUpGl6dKdgdCNh1xTajJSMFKhqEu52l2iDr9qaJBg2ZMgdeOX/dHT5
         4vcDN8PZ0sg0gABeqLSzSeoL22FRt7fP4UDZFwrdvvIFYshcw27ZTwn9H2vqx54icrfN
         RfFw==
X-Gm-Message-State: ALoCoQnmGu936R9xChhladdSX8B9XRoqb2sxqrPO9dmUnymhDs6bT6qaPWKio/rV2VbDc2cVKVkC
X-Received: by 10.182.24.5 with SMTP id q5mr6569710obf.23.1400195745948;
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si317566yhl.7.2014.05.15.16.15.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id C7F2F31C259;
	Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A4235E0528; Thu, 15 May 2014 16:15:45 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249245>

Since we now only call update_ref_lock with onerr==QUIET_ON_ERR we no longer
need this function and can replace it with just calling lock_any_ref_for_update
directly.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/refs.c b/refs.c
index 3fb5cb8..3b0d574 100644
--- a/refs.c
+++ b/refs.c
@@ -3283,24 +3283,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 	return retval;
 }
 
-static struct ref_lock *update_ref_lock(const char *refname,
-					const unsigned char *oldval,
-					int flags, int *type_p,
-					enum action_on_err onerr)
-{
-	struct ref_lock *lock;
-	lock = lock_any_ref_for_update(refname, oldval, flags, type_p);
-	if (!lock) {
-		const char *str = "Cannot lock the ref '%s'.";
-		switch (onerr) {
-		case UPDATE_REFS_MSG_ON_ERR: error(str, refname); break;
-		case UPDATE_REFS_DIE_ON_ERR: die(str, refname); break;
-		case UPDATE_REFS_QUIET_ON_ERR: break;
-		}
-	}
-	return lock;
-}
-
 static int update_ref_write(const char *action, const char *refname,
 			    const unsigned char *sha1, struct ref_lock *lock,
 			    struct strbuf *err, enum action_on_err onerr)
@@ -3547,12 +3529,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
-		update->lock = update_ref_lock(update->refname,
-					       (update->have_old ?
-						update->old_sha1 : NULL),
-					       update->flags,
-					       &update->type,
-					       UPDATE_REFS_QUIET_ON_ERR);
+		update->lock = lock_any_ref_for_update(update->refname,
+						       (update->have_old ?
+							update->old_sha1 :
+							NULL),
+						       update->flags,
+						       &update->type);
 		if (!update->lock) {
 			if (err)
 				strbuf_addf(err, "Cannot lock the ref '%s'.",
-- 
2.0.0.rc3.477.gffe78a2
