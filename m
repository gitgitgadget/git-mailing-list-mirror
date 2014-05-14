From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 29/42] refs.c: remove the update_ref_lock function
Date: Wed, 14 May 2014 14:17:03 -0700
Message-ID: <1400102236-30082-30-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:19:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkgaf-0006Pz-IK
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604AbaENVTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:19:41 -0400
Received: from mail-yk0-f201.google.com ([209.85.160.201]:65150 "EHLO
	mail-yk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310AbaENVRa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:30 -0400
Received: by mail-yk0-f201.google.com with SMTP id 19so11521ykq.0
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VYjKv4JpGAr6At97RSQ+jFKugdouvS1XY3JM7VKerRc=;
        b=NRkRocKJ/LTVBAQ1AoAyWY/AOh1kPv3wjsLK8x0Eu07Hxnl/xzqYjJEOPTBonO3UnI
         EnuWHgiyHM7PVPi9QneBXiAMzMNkNnK/tjXU919EPtKPTN3vjZ3amQ9MHJiJBD87L7n7
         kvtQoEcmVr4bHlxbWEpU7eaYfSieM5Kc4q8gUjblB7cJRVx28Q8iHDKDgo0P9DK/1Ovb
         JEDwI4bFkx8D+Hc70ZoK2YhUzG+U/GG99hwunGtIWQbkSIdbamZ6GtN/7Mz2Rb0V/KM7
         v16vaP9tdvUTEa6Wi7ZUhxb0696vghLTFXNVCTUSu1hKRagmIojg28sTI2MmwZH5x9NL
         1GUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VYjKv4JpGAr6At97RSQ+jFKugdouvS1XY3JM7VKerRc=;
        b=aOGYBQFsuKQqhCobwaDr27zh0Lpvd5v3tg4MK++VHK6yRDDCXVthSkUCW+ZFv68kVu
         E6yUsX7s/Ie8XIYkjHT9/p1qnIWyg3whF/K9gle/uHjLRQQ2mRKeuAsX7UXuRnAwNrOK
         BagQEctWwBtBZaNpxrvagG9XeXMDJB6vPEcWyloGFGKgBG+k7a3Flm+0T718Bkc0BPFK
         j9vgMPt7GnuzrIOr1fvlZBnfg3TA1o9RFu8cJja0P8aRCELKxX3XCDneuRLCiAKG2Twh
         2rb1yVdnpt/p74BnboB1KTIhVoAaHMNODH5y2t4QsIcAKayWbNc2yiraAPSL2W+Hy+Y0
         qxjg==
X-Gm-Message-State: ALoCoQnoG/7b/I1u5JyxAjRewaelfr2Ihcs6HIdrkv8YNKOrsvXzKrXRj0oqB7PctdERwiCl/YjK
X-Received: by 10.58.106.229 with SMTP id gx5mr2937882veb.22.1400102249847;
        Wed, 14 May 2014 14:17:29 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id a44si144574yhb.6.2014.05.14.14.17.29
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:29 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id A48875A42DA;
	Wed, 14 May 2014 14:17:29 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 689DEE0CB6; Wed, 14 May 2014 14:17:29 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248972>

Since we now only call update_ref_lock with onerr==QUIET_ON_ERR we no longer
need this function and can replace it with just calling lock_any_ref_for_update
directly.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/refs.c b/refs.c
index 38193f1..81ba33c 100644
--- a/refs.c
+++ b/refs.c
@@ -3244,24 +3244,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
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
@@ -3505,12 +3487,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.rc3.471.g2055d11.dirty
