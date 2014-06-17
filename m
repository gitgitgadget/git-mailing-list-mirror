From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 37/48] refs.c: remove the update_ref_write function
Date: Tue, 17 Jun 2014 08:53:51 -0700
Message-ID: <1403020442-31049-38-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:55:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwviu-0004L4-7f
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933421AbaFQPy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:54:56 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:41268 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756342AbaFQPyH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:07 -0400
Received: by mail-vc0-f201.google.com with SMTP id ij19so962326vcb.0
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iZu5hj+9+Wr1Yl8TV2ybLFwgxugQIDsZkeXiUX1ckog=;
        b=hrfJWCzKe4jHO9FqQeojrInOrmdcCdxmrM7kICmGCYCT+yi7/lhFKMQi5+gq9KAGRx
         QC/5XBbzewFgMsb6M3JVJoUD+rpUaWDX/L7MvV/cxPKIHXi36BGS/JppcnpDHaMq52L2
         BVLkGwrKGwBjGDVbJ8fxTk6nD6pu5yjC2IVqm5GlsErls7j6CObP2N4zhTE1ZcbCL/Nd
         8FdSOsEiuCgGvbdNopVYa1JBsSbep2bAiHTMXu9IT4BubNQqRrFFnODqvcDB/mQ/XqGz
         UIXkgwR4tWIw5RaYo3L0UNO9OuAJl6YaSPkc9cnRF91IkUH9ITstcJovVoiwdqfnDjgQ
         j8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iZu5hj+9+Wr1Yl8TV2ybLFwgxugQIDsZkeXiUX1ckog=;
        b=C0UYVKxgkTCHwvzZOmf1PzgbQe/rEPFlsvRet/rZoSUyU4NtTPb8QhX+gFHp58o3Rl
         5T2DIzqOUs7I9zh/MsHIr5B9e/9bIHBGxA6VjKVaLNJ3TliOcDwynHCNnUrhYVlobfpR
         B0omQ7Qs1ydP2IYOO/6FD9LXT+WtbdM8u/QBjHu3KMqx2TCxmHW6rdhgMGz+wtuN1OY2
         cMC8aerCIMR+2mBxcWQhgPGaIQzOzJO8q9wCquiwxfuVNpEl5M0UsyOjoBkEGVcTgy4y
         1W6swqVZ1RZFV2sVyLdK7J2UhhRKkuUAOAb4xoLAEB/dNL9l7S3sylqwdnbZAwnCWB1z
         zCig==
X-Gm-Message-State: ALoCoQmd46xQWKoT9GemBwSr0il2s0dgcOIJsJuZSqSlGBVewXAYQ3Kvhy4qgJoAdbdJ6UcRGS+d
X-Received: by 10.52.186.132 with SMTP id fk4mr170607vdc.1.1403020445793;
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si1209163yhb.3.2014.06.17.08.54.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id A1D755A4367;
	Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 7C9D9E1354; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251886>

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
index f8e4300..7372729 100644
--- a/refs.c
+++ b/refs.c
@@ -3356,25 +3356,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
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
@@ -3625,14 +3606,16 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.438.gec92e5c
