From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 37/48] refs.c: remove the update_ref_write function
Date: Mon, 16 Jun 2014 11:04:08 -0700
Message-ID: <1402941859-29354-38-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:04:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbGx-0003UV-Ui
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695AbaFPSEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:04:42 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:63029 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932661AbaFPSEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:25 -0400
Received: by mail-vc0-f201.google.com with SMTP id ij19so765412vcb.0
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W+zgD6LgVtVRnp2ZcZw/ScveWaLQFE4itlmlGqJ7E3Q=;
        b=m9u0gBWuw2i68gEuksQdema7bJEnQ3kkV54RC96Rdib3b/q2RtMl3sWS9qJRbVqbM4
         RD8pWurPgsLcJovCv9Nutv/wR8fJIkAkUaybWLt7jaY0XktsvOtoxQsDFQE2+g4XaivW
         d6r0XTgTorRez5Gd22rXPle98pSuDE2spZWJ83prOpF8xBxBC3HpHeTYOjmCSnkYz4aF
         qMMVX/bXteZT2KXq3kiwMeot0ztQw4uwJGA79m5YFxHPkHlrYqjloCxK5bbwHUMyuW84
         iRI8ZWbwUbOqdmbWVfvKCcbDBpya7nWJ10Y8LgmE94aOXD1GJXSGWG7GunJxZEUHfoH8
         QLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W+zgD6LgVtVRnp2ZcZw/ScveWaLQFE4itlmlGqJ7E3Q=;
        b=AG7pBnG8IlPfMq2SCxRBK2RbO1C8JoJKnOO0B5v75//nM7U2mDPMh/Rw276Lkb/8CM
         loxcFy0S2iNHlIXV3MkJxBqihl8qWqCOHN9NfOHcFdRxNYKY0p9VsGOGRwF0ZLEfe0n/
         852QcQ8XEfPukli0Vc88tEmJQfY589O5FwXkf/70bsX+k3gSUsMsy9+HbNejYkzzuIu/
         yC28UdqR4ICCmamcraR/gAQlk866vYjpVGsDje9Shc8zdkCba62ghI0k+MbalDt1/ZsN
         6GWLqJWflQswiI3EdhM+vTNpLP8hkiOfwQ3276Ri7uRp6rMju5kBF7dVJFqYZWIgs5u6
         I9CA==
X-Gm-Message-State: ALoCoQmnEfuYlP1vMHUa74zPpAVMiVOiIJRIftlIBTIj9abFz1Alu4W//VRoauHaDKwsSglOiYfT
X-Received: by 10.236.134.49 with SMTP id r37mr137423yhi.14.1402941863790;
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si997797yhb.3.2014.06.16.11.04.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id A3A3E5A490D;
	Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 820BFE0AF7; Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251743>

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
index 8fe7877..859f87b 100644
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
2.0.0.282.g3799eda.dirty
