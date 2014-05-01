From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 30/42] refs.c: remove the update_ref_write function
Date: Thu,  1 May 2014 13:37:30 -0700
Message-ID: <1398976662-6962-31-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:39:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfxl7-0001wU-9v
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbaEAUit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:38:49 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:61408 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434AbaEAUh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:57 -0400
Received: by mail-ve0-f202.google.com with SMTP id sa20so429389veb.5
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XZjSQffSUIkD7Pa85Qy/NOFsIb5Go0iKNfoiYsBxEYw=;
        b=AdSrLnnFd1D5cD2cPA/kbim5pQCV0u3v4WxkXJ0haNeIaYdozxFw76hoeDq63lin6C
         3rVph9oRNV/DtRjpJk1zp9b1u7mMoWvZH62Lcbfzi3fTarxM9ITAiUT4xub7aSVGoF9n
         ZfqTUGV5OfYUF4ovKLOH6lXiSNP6tw4v0zt62VHqec96IZAgVKXtBOMjmAADtOCDpQBR
         y8LBqe2f9RJ/X9e4cL5GOvf2EpdUYUg4Z8VttFqtwHNkdUFs+lbDKOC3OIshsODtytmx
         G+Y4jAE1JZb7rHWOXkfJDwchPxW791ma89LEeYZpiJWP255Y//CZ/aTWHBWedMSfyW1F
         +USA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XZjSQffSUIkD7Pa85Qy/NOFsIb5Go0iKNfoiYsBxEYw=;
        b=muXDt37ZMXcpeaoIJJ3kDHciIRLsze/135vWyeNxWkCBPLYAPg5o8dKeCTxQmFhyqY
         ixiON7vbltskvOmnDZLdG4CJt/BAwL/bfFKPhFq0Ln/lxedhT+9ZbkZXKkY82ZUtG2Th
         XDHzqRsgsMbyO/e38WB6ZZyJWoVglU7Sqx6MM9K1oh8GTVAnoGLtF9li05k5QjOvVL0e
         tDEUVwz3SoGz9cmxaC411YlQgSFLjJFqBP+tYCAuSlm1519mvcrzw97k0ty4oGVSLXMV
         GzMfF/ZID2THe4RnxaDTvKC5dqD+Sc1dqznnmONOg0HJgoWXMHxLk49gpt6AQxfmA5jE
         A5kA==
X-Gm-Message-State: ALoCoQndiOYlh9rXONVjOa2LsG0ViFrwxylY0aXEekf+kgx5CIPDTL5M5qNhtizlExeQtncVO6A0
X-Received: by 10.58.22.166 with SMTP id e6mr7060706vef.6.1398976677155;
        Thu, 01 May 2014 13:37:57 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r64si2198374yhh.0.2014.05.01.13.37.57
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:57 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 0768631C1CC;
	Thu,  1 May 2014 13:37:57 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C069DE097F; Thu,  1 May 2014 13:37:56 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247857>

Since we only call update_ref_write from a single place and we only call it
with onerr==QUIET_ON_ERR we can just as well get rid of it and just call
write_ref_sha1 directly.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/refs.c b/refs.c
index 9f5435d..875178b 100644
--- a/refs.c
+++ b/refs.c
@@ -3235,25 +3235,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
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
@@ -3498,14 +3479,16 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.rc1.351.g4d2c8e4
