From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v5 30/30] refs.c: remove the update_ref_write function
Date: Tue, 29 Apr 2014 15:19:15 -0700
Message-ID: <1398809955-32008-31-git-send-email-sahlberg@google.com>
References: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 00:20:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGNf-00029w-D1
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:20:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965322AbaD2WT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:19:59 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:36829 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965293AbaD2WTa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:19:30 -0400
Received: by mail-ob0-f201.google.com with SMTP id vb8so206166obc.0
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=axHPzIWgEorANcnV68EsVJyhQugfMV9nnCPZRXcbgd8=;
        b=HHMAnBxUaC5z3rQFnDOK9ZX5+uTVTi2zvl3BF6EQxxdzNtgzRsLjIJ+1fklaYtp9gZ
         vClil4IjwPAeGZNZSEKWnI5utiZGX2P6F/CjBjnpgz2nBJUHQwCOauaIQzH3Yf1bTzlK
         rs4kW22qMJeTg/3GHkc+zZE9NfXvk8aI0slhb0O9JyvFZauFWP3j9mdfrKd4myd4vqWg
         oPeMzXQaA9PkNGZbXRc5ofVjMDCtJse5ySP3D+zZSXCV2kklijCAslA/GeZBGTEgRhHc
         AXnvjIgKMQetPg6RJhdzjK/gi0q+otBcvPYogcZYE0WKaPAC3C+p5I1bobr6zoHK8VDV
         a/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=axHPzIWgEorANcnV68EsVJyhQugfMV9nnCPZRXcbgd8=;
        b=ArtAFBhEVPt9BobPXAdBTGgkGnl9mlUEAHjNUjJpT8gtLcQCHU9bNGgCFLr4MQSlvR
         L6lL5VhtHwJoqmuiCsLWC34GV4Ox8T/yH5btTbCG+UMEr6CeEjFqDZrHHpSRoTkgW9qI
         NyQWbA+Eb/2q1oFMAIJdQ6NTwFqp4Ce29Xj3eHO4SG2etK7ZD1jC7zJ9OH59ejKCo8nf
         7yXfhNQnncubH7Cf89OdUGVhj4c7TJgldx+u7mkNC9HHrmW+PakgkNEzlU97QUFzM5Da
         94NqgeQizxga0oIGNvSXJA8Pqa0rgC5w3+Y8GYhqZX5am5IRIupLq1keakIcLtAO5l5v
         7ggw==
X-Gm-Message-State: ALoCoQlnTK4PheWYcY24FeYqE6xAYR7XQtoz8DQyXh8TZPFnZVweLtHBxN6lBEfDe0wNbTXvxOH2lDv5PWWVMz2neVFj4oY0b4I65eDVU7RBhM14iXRNNyulfCs0lr2pvpLQSutoSqJDP0+YR3e3a6tbe6kSVe/P1VBSs0X/hdSj35jDZBitNbw3FV55x70gzw2qUBwQ09eY
X-Received: by 10.43.18.133 with SMTP id qg5mr267823icb.13.1398809970147;
        Tue, 29 Apr 2014 15:19:30 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si1813146yhl.7.2014.04.29.15.19.30
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Apr 2014 15:19:30 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id F3E595A4121;
	Tue, 29 Apr 2014 15:19:29 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B83BDE0A5B; Tue, 29 Apr 2014 15:19:29 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.532.gf8485a6
In-Reply-To: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247635>

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
1.9.1.532.gf8485a6
