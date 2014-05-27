From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 29/41] refs.c: remove the update_ref_write function
Date: Tue, 27 May 2014 13:25:48 -0700
Message-ID: <1401222360-21175-30-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:26:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNx4-00021g-Bf
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128AbaE0U0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:26:19 -0400
Received: from mail-ig0-f201.google.com ([209.85.213.201]:63170 "EHLO
	mail-ig0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753005AbaE0U0G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:06 -0400
Received: by mail-ig0-f201.google.com with SMTP id uq10so122557igb.4
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XxfZIja+PG0Ht1f5c+o71icLrhGCjuDw9/21xwvkbRs=;
        b=LrmCWYQ5FIopxLFYDeCVwMOhno7j/Hh+C9CeUD3fDAloM4Tm2TU1rig3Ry6KHfvSMM
         vLjqa/QAIWAt/lQ8L3ljJa2pxjfRLyl4uKR6RXkXeTCkyLbXQO5Sx4hNFNYx7GU4kZvD
         mT1OQfStigYsUrMOmNKwa2SIs45T7F3so/3SDeDMAzFnyJZpe7zEwelW0iS/KG2BZ5nz
         kMU6D0g4A+kNZ+7CyNusml56phfjuJQxQdwmu90oC0yxEPgFbclMtpeiMCWyYvEixm1d
         e4lXVab2AKYT/Fk4DQ+Z1vT5Go0UW0h/76Dv3rdvvLu/cUarI91POnKC5wL7y+we3BgN
         vkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XxfZIja+PG0Ht1f5c+o71icLrhGCjuDw9/21xwvkbRs=;
        b=iVu3F0jYsaaq2DcKI0rUL1X59mH92swu6XzxS9rKoBtroJ5AO3FJzClhE4v4v8gesJ
         f9S5pgUOWTB6n9iEY3xNb2RdbTnZUdbHLqbqsjvOOXcsz7pD0LBI3HYl2ah2QVb2h7Wz
         ZEPB6KtIlmg4utOquSaDCmZIaIV8d9jty66j9jcb0ZL1MkJrOoDWf7MKKgmqRjpB6liJ
         VdwJdLM79wNxVFcfLAnrqO9xeXOmc8BoJ83IGXEjL1RZnvObIxO7y1Opix6tIOidsifO
         uu94YDU4yzLdU+K/ovPwVZ1XRJt6v+ShyFO0M4bKwcMAqP4GpnlT/yJKYKBkTtr3X/+1
         bPqA==
X-Gm-Message-State: ALoCoQmtKD25ajJikF+1uat0eX21zxI7AxCzULEZuug1MVGPXGWvctmUv+7xrnXEpOPJS6I7sp/3
X-Received: by 10.50.1.35 with SMTP id 3mr6665075igj.0.1401222365267;
        Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id i65si1283654yhg.2.2014.05.27.13.26.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 1973637053C;
	Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E83DCE15EE; Tue, 27 May 2014 13:26:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250199>

Since we only call update_ref_write from a single place and we only call it
with onerr==QUIET_ON_ERR we can just as well get rid of it and just call
write_ref_sha1 directly. This changes the return status for _commit from
1 to -1 on failures when writing to the ref. Eventually we will want
_commit to start returning more detailed error conditions than the current
simple success/failure. For example if the commit failed due to name
conflicts etc.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/refs.c b/refs.c
index 0f82cdb..979b79a 100644
--- a/refs.c
+++ b/refs.c
@@ -3281,25 +3281,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
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
@@ -3552,14 +3533,16 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.rc3.474.g0203784
