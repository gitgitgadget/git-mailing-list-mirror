From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 30/42] refs.c: remove the update_ref_write function
Date: Wed, 14 May 2014 14:17:04 -0700
Message-ID: <1400102236-30082-31-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:20:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkgag-0006Pz-3N
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601AbaENVTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:19:41 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:39889 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753311AbaENVRa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:30 -0400
Received: by mail-pa0-f74.google.com with SMTP id rd3so36875pab.5
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SThu5bwmtfFPusLw0Y5Sj+vuteeu0Yy9Ury2lNRViaw=;
        b=i/TKHjkNDdn+8HOVe8JfW7VcFqi1cchPg34knukXZIw3lHSS/W2tkS0rs35O1MpMPI
         11tk6hbsKuZPP8FpEE9vUoxVy9nB0+L80MSPBzp7sTGJx4o+6Z70Od+LxpsMhTp0oRCu
         5Z4x/g9GyDKZuSn0A+Z4u0+CWtuBxsbQukG/UwY0e0eEbI5mWvzQ7vixWtg0xfJOOepF
         mEktfUz+ouKKFjCnPPcpKhx5YMngC4Afwvf3KldvenhyxZl8O14X/9lQWNvdAxm/3WiC
         fKYJ2aexulEuhbYTiP8vhbwth09AgnOKKF1TxYWZBX3mY6/5eF0Xm18ydGu7OswoG8HD
         LJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SThu5bwmtfFPusLw0Y5Sj+vuteeu0Yy9Ury2lNRViaw=;
        b=doIKuJJxECKcaxb1BONwQAXmrMyhV3fHcMCfmCM7p+nLQHxn7gJaDD0yNU2OFVdM0q
         DvNTZoUToFoNJHy0/uFIcLnvr9Kqz7CrFBoVzvbsouaC73Mu8qiiE4k8+OzAT4GvZVyL
         kDNJjUW9Kdrk8ROx6wiksFB1xJ0y2bzfg3wHayUvKcBcUffznW9m3BQ6eycZYGZDWRl6
         vQ2Ur5/NUnZvaMKghqF9y+H1jLwcOke3/KPQ6i7zEhOdqNENVO5cJsx9+JYryp+WQN+s
         5GOWRa1ccNrfOxA9P8QbG8qM4Or+Sv0ZIg4cnJbSNUA1Q5eG6cQwGOFgrL8sqN6yCslQ
         /AFA==
X-Gm-Message-State: ALoCoQkG418XFFGpHkli5nqjZo/Z0Yeoe+s/oys6WHAchJhpgOBtp0c6kvYnynIFeiotF21NUJEG
X-Received: by 10.66.232.38 with SMTP id tl6mr369828pac.33.1400102250199;
        Wed, 14 May 2014 14:17:30 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id k43si145569yhq.3.2014.05.14.14.17.30
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:30 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 0187131C1F8;
	Wed, 14 May 2014 14:17:30 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B83DEE0973; Wed, 14 May 2014 14:17:29 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248973>

Since we only call update_ref_write from a single place and we only call it
with onerr==QUIET_ON_ERR we can just as well get rid of it and just call
write_ref_sha1 directly.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/refs.c b/refs.c
index 81ba33c..aa598ef 100644
--- a/refs.c
+++ b/refs.c
@@ -3244,25 +3244,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
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
@@ -3507,14 +3488,16 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.rc3.471.g2055d11.dirty
