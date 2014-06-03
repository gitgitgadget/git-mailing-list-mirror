From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 30/41] refs.c: remove lock_ref_sha1
Date: Tue,  3 Jun 2014 14:37:48 -0700
Message-ID: <1401831479-3388-31-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:41:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwSo-0007fk-NR
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965395AbaFCVlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:41:14 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:50506 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934286AbaFCViJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:09 -0400
Received: by mail-oa0-f74.google.com with SMTP id m1so1536725oag.3
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=av1d9wrpswg6f2JD5BNCKR4LPZ21yEiEzMCT9dshJE8=;
        b=bFS9nzuAWXR4ehjzz6qfQ78jE5X2uPuABdBrb4TrD0LAzKLL+S4S8XaFYmKBhVllZw
         5bmzI69R3zmk3qIjUOl94S5XrpECe3f4SpIxAHNnFMRlu57HdzAt8VErWKCoPiGv8zdR
         FiWQ58ASFO6IFnLlQLPQ5o8433LsGyYM65bHD4wLoLJLHHF1i7z0x+HO+853R1zGTNSp
         PhYwxCQo+PRM/wd+K+hVgjdJr4ejp9JJd2sgepw+o8ybTuASkEnYAfSalPwD36FNZSWT
         w+x3iBduu7CdsGwwpOhgn+tlHcUywargnwgXoiHVGytTG9g9IZ/PLAkpiJOOY0rgygPX
         WyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=av1d9wrpswg6f2JD5BNCKR4LPZ21yEiEzMCT9dshJE8=;
        b=KOn8xW9XGl4FYUBgCaEdz854SbQoEZkin6Mk33Hvc7ENXQDLNgYhFE4Xw7lUTLcEvh
         CB1LqCtKiR91it0PrPMNPu0T0o0fSVcc4IXpCtmD9CiQQ7x6baItfqOYBrrzNveDP9+C
         vJ/Pnd56/bpP34+7S/4s1rfKDRbOENZNeOIl+0G9ecuvuBEaaHfZY8qV9ne4f5oMRAj/
         o9OD6BHYxw9B3AJUiB6KMI+B38+eAbbFmQRf6yBk9zi0Wmxmn4CJNAZoPjYTlPfjsWVE
         3m4mzV8Xea0DNZgWNB/uLfHtbBqKHwL3Su+13h4JkESWpDEtui3d8C/72yNE8JAGcHet
         m+MQ==
X-Gm-Message-State: ALoCoQkVxJY08DJema+DeNcVwlpEFfX2U7/ezfIyVwHRt9jX4yCmjlKxe5Igq8jceuuIS3DYqAVN
X-Received: by 10.50.35.229 with SMTP id l5mr10831929igj.0.1401831488302;
        Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si30041yhb.3.2014.06.03.14.38.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 2614A31C435;
	Tue,  3 Jun 2014 14:38:08 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 04767E05F1; Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250675>

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
index 245c540..bc750f4 100644
--- a/refs.c
+++ b/refs.c
@@ -2139,15 +2139,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
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
@@ -2356,8 +2347,12 @@ static void try_remove_empty_parents(char *name)
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
2.0.0.567.g64a7adf
