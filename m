From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 33/44] refs.c: remove lock_ref_sha1
Date: Thu, 15 May 2014 10:29:48 -0700
Message-ID: <1400174999-26786-34-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:32:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzVY-0001sq-AC
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755521AbaEORbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:31:45 -0400
Received: from mail-yk0-f202.google.com ([209.85.160.202]:51713 "EHLO
	mail-yk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755684AbaEORaK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:10 -0400
Received: by mail-yk0-f202.google.com with SMTP id 9so80217ykp.5
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZUCvE8+lMzH+5cXXeQzQ8qTU4RurYcYEDh4tU3Fv72k=;
        b=UxrxljY//k+KRVspTQctmP/ZlwM0RTT4LIGQW2WQITyXWpEKgKtAoy7ky1siMxPvFe
         3TrozfZJd0FDoRrrmKePCiyTzgmGrOxkmFPOG9Lwuo7lf5OwP+R/MIa1plEBBvWaiebO
         e7bHILRJ/QEVl8/+GkRBfCQiAPAh/to+4UodlFHeUyUqzm8VYFijK1n3fsZFt4AaLgWi
         g5uW8uv67aLjcXVaphQeFkj+QCPLjDmaKeOz9NoRgKDmDeuHa9WyPgMl4mijL5fHzmrO
         A3USQkIZK9xJDuAF2TvSjRxi8rzYEPc932lWzN/11b9D7E1q5a18gv8O/XfhXwPtO0rD
         x1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZUCvE8+lMzH+5cXXeQzQ8qTU4RurYcYEDh4tU3Fv72k=;
        b=FhPfK4Ks8SyjbNj9CksjynuTlKg2GKA9GsSUB7ktkfiF4hesHyCt+V9lsZd1+Tam3D
         HHkbEx8doWDr2NBwQ8kTAF/Hwfd1D8Zaqu/vv7twkGl9BgSJThDGiCVwwq90wjDSJFvP
         gF/N7iVT34QR0GbDV97b+7yZeBxvDCFFrBDxpr3qHSn960yeEtJNTHMn489NDJHhkOeh
         7o1hdj4uIVWKf8G9eIn4MkNKKofwGTA1rE74UiwsbrPV1kr2dkwCDkzXbSZUrQUFohAK
         4LOD/Vhe+K1Fyd6D8fShgxK67HMsxsGknvCs096zmD8srzqtJS7o322bWvwzFchtpSfg
         1ffw==
X-Gm-Message-State: ALoCoQnhgdKZUybJEadZqciK0lohftsI0vRnEaKyR5qKmmfosYFcvzB6WbyyBHZgPt8HwNXtYqpC
X-Received: by 10.58.112.97 with SMTP id ip1mr5422427veb.32.1400175007179;
        Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id k43si273454yhq.3.2014.05.15.10.30.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 0CAF531C2D6;
	Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id DC8D5E1129; Thu, 15 May 2014 10:30:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249150>

lock_ref_sha1 was only called from one place in refc.c and only provided
a check that the refname was sane before adding back the initial "refs/"
part of the ref path name, the initial "refs/" that this caller had already
stripped off before calling lock_ref_sha1.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 7aa5512..f1ef940 100644
--- a/refs.c
+++ b/refs.c
@@ -2126,15 +2126,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
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
@@ -2335,8 +2326,12 @@ static void try_remove_empty_parents(char *name)
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
2.0.0.rc3.477.g0f8edf7
