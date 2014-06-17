From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 38/48] refs.c: remove lock_ref_sha1
Date: Tue, 17 Jun 2014 08:53:52 -0700
Message-ID: <1403020442-31049-39-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:56:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwvkB-00064r-Q4
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933522AbaFQPzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:55:51 -0400
Received: from mail-pb0-f74.google.com ([209.85.160.74]:57914 "EHLO
	mail-pb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756341AbaFQPyH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:07 -0400
Received: by mail-pb0-f74.google.com with SMTP id rq2so536847pbb.1
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GzcioLk15f+LTieg8MenNumg9OWeba02Q0XUFwPt/7Y=;
        b=lQYnkMo/ECpB3kfuOC3C/X6JpbBcz5KkcbTEPYqrCy4t19id0nZ5KdRpf9vYhZIZF7
         yUAwxmTuR9p6QWPgnpnu3XMlwYPUIDXkai2q0podQ+QVjukrUUWPKkhRuCKuiylar3lO
         lduuCLUKmypTYFYy0mR7gwv+V9Jyae6tkbbH2rN7bVx5O34b2YeMg3FY3L4wJ6ew4gcc
         UsAdoakvR62rYtphH/OVBoYN/IkqWTpmidckR3IiwQIWNGMdqHKT/BXGMAvm+FmQgEXn
         eHDBRZuM2u/YnUm11LXBbe/NpTKrlTA6Je4+4RHUT91LLGImqIYXQZLGKib90UxyJ3DK
         SqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GzcioLk15f+LTieg8MenNumg9OWeba02Q0XUFwPt/7Y=;
        b=eIdHS0fPY4dIkZRXDEOQT9VmMKLB/aUmCX5u19tJd5rTZ6lFNxiUjNojSJnOKoqlz3
         xhIO9096fdY1jVfnFJI4HVPw1FR+2RCJrMWP4+CkC3l3un/NES6ZJ4kjVlSQXXY/Dulw
         rvfQoVf2mfuEZpxEK4MhvooOgTkEH1WGnl55mzjpDJVOKjfxePFbOLXCztvx+PeNNtWn
         Bm4m6QNflFh3D204kFrNscBzh1XZ6UetpMgApCSq0z11pKatbqaobayu6DhMFoC9Mk1y
         me9gevvNpvhBq+ktLg/ejXO4po9fahjQjWfc9d0vw8c8c3haNc6VK5T+ZEpxd1xKT61B
         yPGQ==
X-Gm-Message-State: ALoCoQnICBR7aV1Qz/ynfuaAPT+DZNUZuvXjwbwFbqtdvVzGmzBHDQrAq7vqjffS3BRdWA4ipXa+
X-Received: by 10.66.216.130 with SMTP id oq2mr3637052pac.44.1403020445870;
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si1209164yhb.3.2014.06.17.08.54.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id ACC175A43E2;
	Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 89045E0F10; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251901>

lock_ref_sha1 was only called from one place in refc.c and only provided
a check that the refname was sane before adding back the initial "refs/"
part of the ref path name, the initial "refs/" that this caller had already
stripped off before calling lock_ref_sha1.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 7372729..e8118de 100644
--- a/refs.c
+++ b/refs.c
@@ -2171,15 +2171,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	return NULL;
 }
 
-static struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1)
-{
-	char refpath[PATH_MAX];
-	if (check_refname_format(refname, 0))
-		return NULL;
-	strcpy(refpath, mkpath("refs/%s", refname));
-	return lock_ref_sha1_basic(refpath, old_sha1, 0, NULL);
-}
-
 struct ref_lock *lock_any_ref_for_update(const char *refname,
 					 const unsigned char *old_sha1,
 					 int flags, int *type_p)
@@ -2389,8 +2380,12 @@ static void try_remove_empty_parents(char *name)
 /* make sure nobody touched the ref, and unlink */
 static void prune_ref(struct ref_to_prune *r)
 {
-	struct ref_lock *lock = lock_ref_sha1(r->name + 5, r->sha1);
+	struct ref_lock *lock;
+
+	if (check_refname_format(r->name + 5, 0))
+		return;
 
+	lock = lock_ref_sha1_basic(r->name, r->sha1, 0, NULL);
 	if (lock) {
 		unlink_or_warn(git_path("%s", r->name));
 		unlock_ref(lock);
-- 
2.0.0.438.gec92e5c
