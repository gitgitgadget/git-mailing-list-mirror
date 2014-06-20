From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 37/48] refs.c: remove lock_ref_sha1
Date: Fri, 20 Jun 2014 07:43:18 -0700
Message-ID: <1403275409-28173-38-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:45:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy04e-00037i-1x
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754066AbaFTOpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:45:41 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:45599 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753334AbaFTOne (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:34 -0400
Received: by mail-pd0-f201.google.com with SMTP id v10so446327pde.2
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g9gRjrg3ioxCY8eEFo8Lbg7oJJB8jPHdxum7exyC+nE=;
        b=cWPmJF8ipFSHd5j++OFWz+/iv//AqgAABfuR1Wpb+jlBx5l2QirkcVeaxSr0pRysHa
         ZI8skWFics1RhX6vzn0wh8Aka4uarkEonEkxNVEXGiXQFn/vKvkszEogqygE+TW3aKU6
         4ukjaHBcWoWTQCz5/8/NP2TIINyhcxvsvKH4BYNPOfou3HS2KrEA/T2dvAPTSdjCaqB8
         AziLzhegyA/uymerNnfgroW6a6qmIqbvn0+7VswKG48iaK4YJ0Pu4X16jC0U0WUVWTBq
         6Ctc3LQcBA/GwZSE3BabIx6XiKF3JU5ANjeCjmqTOpbowgDdcj91L7BWM3FM6cA5jZXZ
         LJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g9gRjrg3ioxCY8eEFo8Lbg7oJJB8jPHdxum7exyC+nE=;
        b=i94CdTS6TMKn+Zn4g6JNt6LjvrpOeDb8Hxrj+lbnRBHYkVwuSd5g6TuOBhTz7AoWMP
         3wNUag7h2spdofhsKnSZmmz1wE0xKTZ1tlOkSgoGw2UJcjDzzoWI1VgB2ej1m7c7K9wg
         i7rjqe3NhAEKypqARm5ehx5bgTTjkHMOcWa8nnywwPV3PJ2S8X5L420v01eS1Xjr9+9Q
         7k3jcV7jEJ+n19YJILy3hFKJ5P3zVm+1x0mKFmCeMH0B6F9dhXhKviBZ2/P7hjFYILdd
         p7En38q5Pi+wgJlqgUWn021GnD4o26f7CbKLmci6NdRBIs7HJFtswCY177E87jgW35zk
         s2Lg==
X-Gm-Message-State: ALoCoQnkxQUfWDpMMuiKZkt7KS4rrYXtW0O7zRJ3I4omooQNkLN5JdEzDGp1mQR+1Uq4OL+pRBG1
X-Received: by 10.67.5.163 with SMTP id cn3mr1471905pad.25.1403275413759;
        Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id j5si665237yhi.1.2014.06.20.07.43.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 917DA5A43E3;
	Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 71A7AE0ABA; Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252250>

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
index 7113843..699f1f6 100644
--- a/refs.c
+++ b/refs.c
@@ -2170,15 +2170,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
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
@@ -2388,8 +2379,12 @@ static void try_remove_empty_parents(char *name)
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
2.0.0.420.g181e020.dirty
