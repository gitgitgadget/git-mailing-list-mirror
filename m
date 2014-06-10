From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 38/48] refs.c: remove lock_ref_sha1
Date: Tue, 10 Jun 2014 15:29:26 -0700
Message-ID: <1402439376-25839-39-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:39:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUZf-0005yY-3T
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:31:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754774AbaFJWa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:30:59 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:62192 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720AbaFJW3m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:42 -0400
Received: by mail-qc0-f202.google.com with SMTP id r5so428578qcx.5
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dnbiEFwXv/fB422AyEQ8N287BJ7P+UZmPRPTNTrWVig=;
        b=iwvwIpi5FonyyOsnJ6szJh6cOpmXZ+BpZFRpOIIlw7X6+8mj36ma2f4Bo8kpH11PYb
         PFadDR1VauTa89zl/xouaZg9IC++oQjkrMNaPVf1oGAyNssySo+zNnQRNcOeBpr9jBb6
         nPwWSZEqAnTbbV3SlYbWuEJe7gtgwKKMtTtZ128bEwS1e/ptlJLSXh2vhR7SVHaatKpC
         AgAeawD9K9ZP8C3pwpAIXL6r2RM57T2rWoc/hQ/wtyYsLZnSG1/nH/GwiF3KNSA5gRBH
         MCG5CDK99450jRGP5ePs30r4ZGmf62M5sAoqLpWnXMkKjsHkr5OKmCgPPj+UzW5O6Oy4
         AP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dnbiEFwXv/fB422AyEQ8N287BJ7P+UZmPRPTNTrWVig=;
        b=lFp8RGZ+CXzbFJYVj51YmL+9GmWs3pIX4l15fVCuMCvLttmXreU394mFTBLpbp59AA
         HLjjxq7QOb2X+erCc+inDgmf2cIrP7ObRBv3eS1ZrbfAEjliAUo3DPRCUYs2AKmVPys7
         AKi5sRZW3snzvVjmZhnpBr2BsJLde9BXitJmbN50BST0oR4Q5IxzqvnkOMzoNjmNQYbk
         g1tI7YOaraJ+rPfPHjX7R1wvtWG5vtYaD9NxRx/WM4Fv626Q/BetGD9p+EUnTIP7Ucjp
         e5y4myTCmcFeWm/lg1qOKxpAr1BLLyDaUJMXbEgmDWEATikh/M1pHcMt5xjYNH+DQy9X
         8/Nw==
X-Gm-Message-State: ALoCoQlPze5w7VjbXRm/3wOYHJKcFnC+CRul5Rmparu6yFxuvX74pwOOF6QbfZ03SQyojfI3ppgM
X-Received: by 10.58.187.44 with SMTP id fp12mr6957953vec.24.1402439381843;
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c22si1396569yhe.1.2014.06.10.15.29.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id AF36B5A472D;
	Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 8CD26E07FA; Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251308>

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
index 3e77cf8..4ea9a3e 100644
--- a/refs.c
+++ b/refs.c
@@ -2143,15 +2143,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
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
@@ -2361,8 +2352,12 @@ static void try_remove_empty_parents(char *name)
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
2.0.0.574.g30c2c5e
