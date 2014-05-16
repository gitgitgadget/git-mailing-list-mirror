From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 33/44] refs.c: remove lock_ref_sha1
Date: Fri, 16 May 2014 10:37:21 -0700
Message-ID: <1400261852-31303-34-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:39:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM66-0001Ks-BB
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758127AbaEPRir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:38:47 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:38756 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757998AbaEPRhj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:39 -0400
Received: by mail-pb0-f73.google.com with SMTP id ma3so519458pbc.4
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pchERSoo0a4cpQsd0N2i4rq9CWp3JB02ZCM6ip6JJw8=;
        b=ah/Uag5ddjl9VTmLREvrJhZAXjEzXGITUZ5TQyTiUJUcc1rnAsNcwhNmWnimHbXeFR
         BVa/jQtNhCZHDlnIOaVRuhqhixHZZv3vlrDoidvt/uJNXRZUPqQlqLRQM14adgnOb1B3
         5nGcUrymbXus/ls2kt8qPTlQ6YVjmfz32shjFB4hiN82U3lF0t2/2Jeh5mAUS5IrhTSO
         VCxO/v08jZUKxAylYpcL+t5GBU+IKRN80+LoSeRI7F/E76MisP4ZEchOUZAqdmONDKqw
         wcMVtmOr1VeLhBkopuP44SKxh0eVrCUyqUwZNKibmx7F2T11lLHQ6nPjabBxkRtA4qeI
         UR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pchERSoo0a4cpQsd0N2i4rq9CWp3JB02ZCM6ip6JJw8=;
        b=RDiFeZvkfbgOWUeEieep6k3oDKZG4NR1i1W3eOp9pk2zMUpi34VeRxVZidKM9HHlAk
         eswxGFJDJtOn20G9T3M10mTY+Bq6mprGqaB2soHQMjNMiBAb5ITuXOt0G+A89JiG/NZa
         uqsPfYw89bRYQHuu5m0o/urf3/ae1V80Ok+klud+RqE2izDqGmI1DJBZ/EsOhHXSEclq
         elA4iE2ChgH2qAqrlyZ97ylEbbYt/tC3ycIJeZl0foEBxi1BTOinw6zkiwF8njnP2iad
         PiJzNXFfQQ+z3+N0B3BWr4iVt5GmPiXKEGzHbpACN/lLoHUimL5NQ1vG8uPpHu/RldtS
         q1XA==
X-Gm-Message-State: ALoCoQkDJqfA80GGTLiDBwMuKmJpAKeYRqnPN5wwzmM4wKUn7N5sd9tGBiVjVPijbudXQTtLqAeq
X-Received: by 10.66.190.202 with SMTP id gs10mr9223570pac.0.1400261858242;
        Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id h18si443264yhj.0.2014.05.16.10.37.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 1480031C211;
	Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E62C5E0EC6; Fri, 16 May 2014 10:37:37 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249376>

lock_ref_sha1 was only called from one place in refc.c and only provided
a check that the refname was sane before adding back the initial "refs/"
part of the ref path name, the initial "refs/" that this caller had already
stripped off before calling lock_ref_sha1.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index b1acf51..69623e4 100644
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
2.0.0.rc3.510.g20c254b
