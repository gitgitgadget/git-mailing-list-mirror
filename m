From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 33/44] refs.c: remove lock_ref_sha1
Date: Thu, 15 May 2014 16:15:30 -0700
Message-ID: <1400195741-22996-34-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:16:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4tH-0005pX-ID
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756244AbaEOXQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:16:23 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:52252 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756089AbaEOXPr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:47 -0400
Received: by mail-ve0-f202.google.com with SMTP id pa12so325918veb.5
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xU37VfKysWXfAy+Jbk63cIkv3pDRaaFIKFxUG0kvsmI=;
        b=Ink3dGWM8v7COcVe0GwunfZD12ib9MJSQgkny4HPObaHb7GtGB0scYOugozk7nqFxI
         Vm8B+P+35jCZtN5nYwZv+PwGpQQXbErlx3jYwfY40x1v/X5DSAP5nZFWuCAXuS+UE8As
         6T93DfaqBV49xi79jQslu+swuGB5BYcgOJ2ueLP0OkCrjxxiiqqaMOMQxYngDiBIrDH/
         nRS4ZZKbbT3n3QACzWD8ie8vv23fA0M8PDN2GB7cGEkjmklhtBsbGjjZbkN9FeE0tfmw
         Qzin0t9fnzQv6/fSOO+tYi1J9e9iGRA1E3j89IOC09ORhgtZ8kzj9l5Iqh/EHHRgOS18
         DVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xU37VfKysWXfAy+Jbk63cIkv3pDRaaFIKFxUG0kvsmI=;
        b=bmwA1MaxECKSJEinnnCehaJaRgHz8lqwBXvyrUYyTGyIo87w6s/yayFRwIJdXl5Xg2
         YuQjm2EmNqfGqwZcQwcSZ5pJqTmTuVrTeO3Ap1iyQEgzqhjOQd2LymSD5klL2DscuR1Q
         bkBeTDkqFMj6G/eFQKLQE1RT+nK0pnzL1t1SaL02IT9lRrS/+eSgFCBP0u/ZJlqRTTqi
         4fXYYvG2ucBrxf+gXt1CturU+u2xbWYZ9VxHOOGY+d6jpZBHer169HAs+JUVlMwAhkP5
         6s/tEtZx+O5JGaHzg3TqG4kkzB/LsoHJE34PYC2OXkV8gttH61nd3kWWUehWcZ+oaihT
         455Q==
X-Gm-Message-State: ALoCoQk2hC0lQQA6YfGdunT4oYDZjJGCnPC+gUmI/6UDhkhbor5GYATm8d7DViaD1DG5ZTfk6kAA
X-Received: by 10.236.36.33 with SMTP id v21mr5511290yha.53.1400195746148;
        Thu, 15 May 2014 16:15:46 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si244842yhj.5.2014.05.15.16.15.46
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:46 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 0570431C259;
	Thu, 15 May 2014 16:15:46 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D5F9CE0764; Thu, 15 May 2014 16:15:45 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249236>

lock_ref_sha1 was only called from one place in refc.c and only provided
a check that the refname was sane before adding back the initial "refs/"
part of the ref path name, the initial "refs/" that this caller had already
stripped off before calling lock_ref_sha1.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 1857e61..99b110f 100644
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
@@ -2339,8 +2330,12 @@ static void try_remove_empty_parents(char *name)
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
2.0.0.rc3.477.gffe78a2
