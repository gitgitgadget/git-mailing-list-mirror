From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 18/20] refs.c: remove lock_ref_sha1
Date: Tue, 15 Jul 2014 16:34:16 -0700
Message-ID: <1405467258-24102-19-git-send-email-sahlberg@google.com>
References: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 01:35:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7CFm-0003aH-1I
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 01:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965124AbaGOXfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 19:35:00 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:43779 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934318AbaGOXeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 19:34:25 -0400
Received: by mail-yh0-f73.google.com with SMTP id f73so21130yha.4
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 16:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qh2GnrPMcduMmy5UW4XE85FuDvcja19pR0nhXTZ3yLo=;
        b=gJiikg/LiWGXDOznjifjLxM0iFEQYUVFfgy9gmHlZF78mD2L6D6pY4VjflAhmOSsLH
         MEy0KxXW8T7wCg3vT6YA0VcfdlSJWKMuayVy14wvwE8gSwprGeFkrENTYd/70gdG7XOX
         ptDOP4kJcgZSmisA2nCBAlqJdITlxz0Li4hlFAVvEnX4MNqOOqgMCjBdN8jFt/5+m+Xi
         hhKd0j8gTUtBqaRZM/SnzoBEN4ixzsqopaJCYkjziW0/MNAbzV9U9RURUpVzKabR2Dxy
         uBgx+theQDYwBvCDpYrkbD0IJ2VzDbvsyuUpU4bZb+Aa7hEFzHizI5cSXzS2HJHkI4Mh
         im+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qh2GnrPMcduMmy5UW4XE85FuDvcja19pR0nhXTZ3yLo=;
        b=PX3WiDa+0unBiNRJTkkWq+QKEs7QA/9j9C8O3mPsQ12iUDkEa4yDfAbVo8ka58XDUV
         qeC9IWG/uuj6satlCY0IwdpCD2vi5KwED1VWmhvmIZtECP0HSeLMEiIx4Td6f/o2dimb
         MxyuUef8gUvyncUapDWC0ECOY3f/e7elfecUzE9lVMA7C0//635h1IuRbYXm8sdViDed
         oSXRBqngV0ltcRjunyJYRtTjMxNqQWhiP941urifLOxYAhOdqJksFlrCjiMTVwdXATvj
         6QAQgsbESG6tM40sT04xun7s9B4DCF15DcXzuViTfjKcO8R0RVS7VusBYZg/70pTwoYk
         mMzQ==
X-Gm-Message-State: ALoCoQnJUCEV19llkU19EHedRpEFaitjAl4yjRJnrtMs9OOn9cgmcJ7vJjBVFPUHGLKm6e8ObHWa
X-Received: by 10.52.116.241 with SMTP id jz17mr1271766vdb.9.1405467265087;
        Tue, 15 Jul 2014 16:34:25 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id v12si1060892yhe.2.2014.07.15.16.34.25
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jul 2014 16:34:25 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id EA3B631C2D7;
	Tue, 15 Jul 2014 16:34:24 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C8920E0B6B; Tue, 15 Jul 2014 16:34:24 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.481.gb244468
In-Reply-To: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253639>

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
index 27c629f..dbf6af9 100644
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
2.0.1.442.g7fe6834.dirty
