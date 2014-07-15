From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 16/20] refs.c: remove the update_ref_lock function
Date: Tue, 15 Jul 2014 16:34:14 -0700
Message-ID: <1405467258-24102-17-git-send-email-sahlberg@google.com>
References: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 01:39:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7CJx-00056L-Cp
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 01:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbaGOXjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 19:39:39 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:38153 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933937AbaGOXjg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 19:39:36 -0400
Received: by mail-oa0-f73.google.com with SMTP id g18so36015oah.2
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 16:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DGA86wTzfQpCtRhxN0sP8A2V78Jxw0e3CzlZ8nVy2vI=;
        b=g2ic5F5+2HjdD2zJlTiIxhpCtdubAC7YbW67TdqYU6AkDcN+p5XkTgiYy9FClAJnk/
         fioh4122sq6ccUwA7CLMw5dNNy70a+7YcJxBES/E5+Yo1rPDY7wDQJF+UDqc3vLT1UEu
         31raUNB6me7N2g73gcEB/ofasCv/d0GjkqmBntkGg00HGU5wMAySxMqNEqlvwdYx23ve
         87zNmguJzS/MDvd3sn1r9doQ5Ez4Ino3F3VevUzKBq+94H/yVmV17E1aZcwfU/94terH
         HSypV6cpn1+jabzOUYsD3Ie0yIZpNWqimag+o8uIGMskvPmLMFqz7YBKSeriAPpXVXqw
         CxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DGA86wTzfQpCtRhxN0sP8A2V78Jxw0e3CzlZ8nVy2vI=;
        b=AFcUG32R4F9LuWy5qqn4Tgv9FOOia2CgW5lGTK19E7Kb3y/jThx+3xnHPPRGZAtxbc
         UXIA/987kmLT6TPUOSPijiggPlHG7Q9c16ShgwQ5cBrQ2o4aAmlUTrR5MPkYwipddk/5
         CGOS1oaEo9q7yMwQI+DgN8gmgg9BclNixnh2Yg/zomDbqN2zE+CAABlK4WF/tKN2HQCK
         6UanJmNVKkU3H01VUkwwCwNluGnntY6Cd6wTIBiZ88bmn2XNADCLMcqGfFYSHbnL6eQv
         dbnhIVO3ZoHKa2zmjLIaO6jf9N0d3sr/25VKj6I3wAZZSequaoPWCF+GihtdDIhJ9UhR
         wfMw==
X-Gm-Message-State: ALoCoQnFlmI6tEXP46ZGs5dO/V4u9yEWq8d5P6e1qLvuKMAS0zYqtWxgP+TIhbYt3MqKEK/azemJ
X-Received: by 10.50.73.35 with SMTP id i3mr4084315igv.2.1405467270004;
        Tue, 15 Jul 2014 16:34:30 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id o69si1059120yhp.6.2014.07.15.16.34.29
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jul 2014 16:34:29 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id CD7C331C2EA;
	Tue, 15 Jul 2014 16:34:24 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 973CAE0CE0; Tue, 15 Jul 2014 16:34:24 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.481.gb244468
In-Reply-To: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253647>

Since we now only call update_ref_lock with onerr==QUIET_ON_ERR we no longer
need this function and can replace it with just calling lock_any_ref_for_update
directly.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/refs.c b/refs.c
index 10cea87..091c343 100644
--- a/refs.c
+++ b/refs.c
@@ -3333,24 +3333,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
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
@@ -3602,12 +3584,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.1.442.g7fe6834.dirty
