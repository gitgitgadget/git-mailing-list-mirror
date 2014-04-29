From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v5 29/30] refs.c: remove the update_ref_lock function
Date: Tue, 29 Apr 2014 15:19:14 -0700
Message-ID: <1398809955-32008-30-git-send-email-sahlberg@google.com>
References: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 00:26:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGTz-0000SK-VH
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757385AbaD2W0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:26:32 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:64419 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899AbaD2W0b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:26:31 -0400
Received: by mail-qc0-f201.google.com with SMTP id c9so141975qcz.2
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rGYMr/YbVc/ijqUnt+3YK5iLTCUnvyguP7UOddOjFF4=;
        b=HW26JY+FYV55ksBcarGxbZh1IaNfjAXDgmE7Riys3aC4uAWp47zqZz3qackHQyISAl
         z2el03+TBJfMGhbusQr2TyvSNsQ+xogIJuiNXEoaUw6jHwoVZxUipMYihMdl6rZnjLkI
         MmOEjBcTJjjti54zhMpjR5HK9jBXsZ8pOuKU/69NT3LHN3X9S9zlr2VVNMY761s3BRJM
         qUzWWG4gr3qgUyzj502hNEvBTzqM9ULE1lOA8ZN0PuHiAIVnuh0MMzyVOw4j5J2ok4EF
         ia4OHuR9864F/97S1DWwtbzEz2RKLh9cDXPQuFMv4sVICpigATgDaxkydvDsG+wMxWqM
         qUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rGYMr/YbVc/ijqUnt+3YK5iLTCUnvyguP7UOddOjFF4=;
        b=AGxhsfaWJAX8CHCAsFOx3wfGD9JXRqN0ZuNhuZm/tydOB3v+oe4C3Sh/WvxwStHC7t
         5e9A5DROY/rapThVKmejEeR33MzR+DD4CPAqr4vn4OaZy9no7zKrQ4jt2nweV/LrZ0Xo
         CcJL/WxdAuz+e/mkBGGjvjU9Sk4jzOsbq1zIFcFRgSvfrNn8gZyhdal7QMMPXNG5/yCt
         kPTDYjwugTAqbSeSu63RIXw55VHOMBI7gh+t8w0n96nD0cuCrWptsWSf/59CH++taQ9R
         RBv+v40rvZl+sM1THB5JTOn1gY7vFbeKIR9bYn3EmKfWGxHtcW5hH3Xjnio5UWgaP2sf
         /Qww==
X-Gm-Message-State: ALoCoQkN7zPQ6dn5/kFTdEvOxIyi1RB2BMUcUUT1XE4hwPoAg4kC4iw7RFQ3qPSbeCnpck3e/5guyPgR39h4pOuUyxZSxE1aYQ6Qlefvk3mm5chDbuMAHHKY/tx7P314JQOD27gYZSB0rFXLnKXviaZ6QmJKdfEkm0fVy4LaC5bmHboJDGfNzofCCElnfDP548/GfH4Dl0yc
X-Received: by 10.58.22.70 with SMTP id b6mr310345vef.13.1398809969357;
        Tue, 29 Apr 2014 15:19:29 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id r79si2306163yhj.2.2014.04.29.15.19.29
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Apr 2014 15:19:29 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 377B95A4121;
	Tue, 29 Apr 2014 15:19:29 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id F0FCFE0A5B; Tue, 29 Apr 2014 15:19:28 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.532.gf8485a6
In-Reply-To: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247658>

Since we now only call update_ref_lock with onerr==QUIET_ON_ERR we no longer
need this function and can replace it with just calling lock_any_ref_for_update
directly.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/refs.c b/refs.c
index 206e1a2..9f5435d 100644
--- a/refs.c
+++ b/refs.c
@@ -3235,24 +3235,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
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
@@ -3496,12 +3478,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
 				strbuf_addf(err ,"Cannot lock the ref '%s'.",
-- 
1.9.1.532.gf8485a6
