From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 28/40] refs.c: remove the update_ref_lock function
Date: Fri,  6 Jun 2014 15:29:06 -0700
Message-ID: <1402093758-3162-29-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:31:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2f6-00033e-Di
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbaFFWan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:30:43 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:42108 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527AbaFFW3X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:23 -0400
Received: by mail-qa0-f73.google.com with SMTP id hw13so680835qab.2
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+REjMw99nFmY4dtXvb8bEKhpUfKrZl4jNTgqI0kfvsY=;
        b=P3LXDWm0nv8Ks59i6+7x+UTlqBPiXy3SKXvfIwAl8Vobhv3JqMp1QZxG0S9DJswLZC
         2NhWWFSouWaOT3TrCubgLvV/syMZKhTtpfEcO2afNAL958nTwZkCRd9vAE6uJZayZkYk
         EyJK5EOiG78f//YKVCmuoOAKC8g5qKqMmcDW/HBpsobydDC+4FW60m8AnzTFf/QHHGw+
         2SYKxdXQl3XOe5v2a6/DAcK260IbNf++pFU57vR9pDA/Oc+jCycwme/d4U/1kgnN8ep4
         mog+OvqgJQLaAB/Njy7WgyfiyylIh1R44pdBYS4m11Sc5zw8zfAYukzaX0BKN9OKXrMw
         OBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+REjMw99nFmY4dtXvb8bEKhpUfKrZl4jNTgqI0kfvsY=;
        b=W5spnNxQtKc8tfU2Df5hw1Q+BMJt4cuCH3brFliMbx2irk8USYvL84/d5SW/YZLyHR
         9jISkejbDZbpasfjz5js6wtvpYk+auCFO1f552bQO2BoYmhdzm+JQR3sQ8myxZZ0kORQ
         O8EvG7QkSr2aeIv7A+X4DPzlS2pDB73EGZ+2B3eyTjwL9QBK9XvOEsnVIojCPV5q3KGH
         FPzTPU49L+J0Y6Cj7lvIg/shonlJNbcnOgEAcYSjo4x3LUdlXsh3lTTG1aUHrOrxSBaj
         SwSjuNvvqgkKF77R77AaP02IhkoMVJwj6PDGTo9/w2yRVH3x3JUxtsDqzH/7gatWEdi0
         WicQ==
X-Gm-Message-State: ALoCoQl4AiXXb2++SbUpdWjXiymqgGxYD085WE+6mpTJYemjzVXm5d+4pQwb8nV3ZzcLzXPdoygW
X-Received: by 10.58.127.66 with SMTP id ne2mr5249872veb.27.1402093762809;
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id pr8si750960vdb.1.2014.06.06.15.29.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 917DA31C62C;
	Fri,  6 Jun 2014 15:29:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6DBEDE047D; Fri,  6 Jun 2014 15:29:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250998>

Since we now only call update_ref_lock with onerr==QUIET_ON_ERR we no longer
need this function and can replace it with just calling lock_any_ref_for_update
directly.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/refs.c b/refs.c
index d2fd419..3796957 100644
--- a/refs.c
+++ b/refs.c
@@ -3323,24 +3323,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
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
@@ -3590,12 +3572,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.582.ge25c160
