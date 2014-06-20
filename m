From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 36/48] refs.c: remove the update_ref_write function
Date: Fri, 20 Jun 2014 07:43:17 -0700
Message-ID: <1403275409-28173-37-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:46:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy04s-0003ML-N2
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754097AbaFTOpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:45:44 -0400
Received: from mail-pb0-f74.google.com ([209.85.160.74]:63013 "EHLO
	mail-pb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325AbaFTOne (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:34 -0400
Received: by mail-pb0-f74.google.com with SMTP id rq2so451042pbb.3
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gAnZIzB/6OVfCWMKJNmzDCzQ+R/y4beGkjBvDSx8TCc=;
        b=iwUMa79zk1XvncHlfkce2VVNPcjGf21hjGL79y1G7km4rxWrsydhFnuONhh1s7Z78S
         +B1yP9wZ5SvZCqTOx2dzyya6BcKimmRRVuQLrTC/y78ULq/x1rirOAhLUNH8AZQIJceS
         RsWcrYINBnnkPxIxdwy0ifZLzx5vsMzskctWZfjGX2tl3h9G9xBCBKiP6eJ4O3AK7wFQ
         +lx81FzYfCv1w1SYs3aFQ4a1jocPuC18FKxQ6sRlKoeDLd5ahF/JMwMOZTMNouoDViQt
         XyeeafJiR5vdEpPsloi0i7bR3M0cD3BAHiBZSwic0qO3uuJ6L/hlZNLmfe+je+fqDgLB
         c9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gAnZIzB/6OVfCWMKJNmzDCzQ+R/y4beGkjBvDSx8TCc=;
        b=h7tGZN4o1JDUs8ZAWGRT6B46sfokme3mEVEKmAE0mgTUNyv013A9hJv3F3xz8s+3LT
         w17/3KoTJaUYhFMcl/9vD7Nz0lbUq+1DRfb6tDl6fDxeH0wkKfs4yyKSb0vF7Tkqr1Gq
         W5ktabgQ7J3igcsxQ/CYw+9JBNczJO88DSZkzBc9e55OUeOdWtJJwOQ7tUUzcAsoYRCj
         GzKFGlj0XY16WRgbWSHJJz5h0wJnU7flbug9wRNzkHlenzLKEH9BRx+RK5CkRrYhbBWN
         leDGMFVImLSaX9ELvnYzJBfWWjdQeL9HunSj3COf7wJwHle/MC2+CRrkGB+E/cXQO4ao
         2XKA==
X-Gm-Message-State: ALoCoQlX/7qmEP+h/9fFbGUtcYkzDb9DfCm9H7VNJQAtVi+QTf0oD24ZMM74U8hW0L4Su0JUgBeM
X-Received: by 10.68.137.99 with SMTP id qh3mr1520925pbb.2.1403275413590;
        Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id j5si665236yhi.1.2014.06.20.07.43.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 69AD931C6B4;
	Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 47D17E114E; Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252251>

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
index 8fb0a9e..7113843 100644
--- a/refs.c
+++ b/refs.c
@@ -3333,25 +3333,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
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
@@ -3605,14 +3586,16 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.420.g181e020.dirty
