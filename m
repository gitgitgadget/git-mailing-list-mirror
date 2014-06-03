From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 29/41] refs.c: remove the update_ref_write function
Date: Tue,  3 Jun 2014 14:37:47 -0700
Message-ID: <1401831479-3388-30-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:41:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwSQ-0007P1-60
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965379AbaFCVlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:41:10 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:45007 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934287AbaFCViJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:09 -0400
Received: by mail-pd0-f201.google.com with SMTP id y10so705722pdj.4
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Drd525YGupqIUxeNkzWuvjIvGPUtAT+TrmSb3w+Kj78=;
        b=ey1pFgUYpU6XfJb+cfZXBC+Sp8GHQo1ohAOQTrxFZYOFinT1mC0Lo9urduwmZ/eMc6
         SN4ddi6fUpRRgOyK2tttI6KFCDqdQ2vcY14XoKAK365JMo4rDXAS74TH9JXkPwU2QW0H
         E45OwWBQdITGxSYaadkDs19wh6eTx6c91OAdFnzN0yRuBAo/OOGMaEmowWaT5awj/qMn
         nvHHCUfLEeT5gfW2iweJ/XcPHpHgYI3ywBkKDkIuYEpKjuZRxJkMjE/C6shORsqoI54V
         bGIU7KVYhUZOdvDXi3GVchLOGwu6fviCkp3SbWVfMhB2gtK44j8zZ/khkFwqJdSZbN9j
         MVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Drd525YGupqIUxeNkzWuvjIvGPUtAT+TrmSb3w+Kj78=;
        b=eo0RuTkRSsS6cIJ0a7hD+Me91hO0SVBRV4+EyaQdILMOSOrBerGjE7e0f0SCl5czdX
         Pe3AK/wdcgCjCA0loujyLjS/9cPre6BlywOmd7Um9VgW51vjrbC+Rc41vPLoC+e82nCz
         SzaxEJQfPT2ibSVVw52Q4ytN9YtWxh4VreRAKMXlwYxTjssx9zjlksyVJpPaM2KgTPQS
         UmFiwAo+JO9NW8vUJrBpf+aERGm9aYMaGLZp1hpgWJBPP7KUW4gJ9Ew6mMJ+4Yn4Tu0n
         zHm9oQkxC9rJ5bHkPhRxUAQp/WeesYS9binYUntcD2YL0mThaLTTmoX3nNqikWa18BRV
         4CBw==
X-Gm-Message-State: ALoCoQnwQiCpi1ytNlQROUw4eKn6eR4h8fSW/hHG22Hb0HVZGcFsJdBJAlgYqKUjngAG7SAjV4hR
X-Received: by 10.68.197.73 with SMTP id is9mr17685330pbc.0.1401831488217;
        Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c22si30647yhe.1.2014.06.03.14.38.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 0D6F331C4B6;
	Tue,  3 Jun 2014 14:38:08 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id DDCF1E0CC8; Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250668>

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
index 3796957..245c540 100644
--- a/refs.c
+++ b/refs.c
@@ -3323,25 +3323,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
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
@@ -3592,14 +3573,16 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.567.g64a7adf
