From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 38/48] refs.c: remove lock_ref_sha1
Date: Mon, 16 Jun 2014 11:04:09 -0700
Message-ID: <1402941859-29354-39-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:06:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbI5-0004n2-KB
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932752AbaFPSF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:05:27 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:59379 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932659AbaFPSEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:25 -0400
Received: by mail-oa0-f74.google.com with SMTP id i7so1128393oag.3
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nmpEn/HcPQZHdayto6ncExs5P8DJZCNdKMjgql8oPCI=;
        b=Gvw66/oNQJBsFom5ipSlsj2XhPs38QH6UbQk6P86vqFb5kS0zeoRnSpgGKXxEw98Si
         jmlGUTE1DnIDXaQbm4AG5LKju1nH45QKhF8Ml2WLctWUkhA0oOZM5n7hgf2WremIr/4p
         Ij0MxxWiDW2gAMU2JBOzhBq5pSNfybKNbPV2UhcPVKNatIHlMbWlVEocghOOqi6WAa1W
         ZFdXf6rNUEc1rcNciKPBsNX0Cx7QUfViT2sg5SsDxqipB92hHMLFLfq2Rc5gEIelWcod
         t+eYezkGhtb3BaiIYSSzHL2sLKM91lCuLWFt5l2ojoBVVJ+A91E0wh7ZC8Q24BTwqevd
         ziGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nmpEn/HcPQZHdayto6ncExs5P8DJZCNdKMjgql8oPCI=;
        b=XCjHpg9+2iyKG0YpajpezLw9w1JXsw9WEEiTKxf5NrH5wlEGTgWXvUCIGS3SeBFAcF
         B78sPG7qRrmmHOVGDxHm0Fiq/+cIZwZwDPiORoKPjne0J3zrk/0rWJ/7ZY7LVj1XHZDz
         lHtSaja+XwjtYzUVSdsTs8zqQYc2/Ok8LC6Ehvm1yiSV1oE0xdl0JkKpIfaynOvbbeOz
         sf0yQOBzTWm/eibJxtytk2I9/fx0xqavmhrAtZmxnoJpdTjNWSdO/rxwHDUOCw9DhIaR
         RoYf9osvFCDPrjGixxJt0IfDGN5xBwqRtUrgxqpmMaT0/PwuHpmEktMkev8aDOZV6sQ0
         yJgA==
X-Gm-Message-State: ALoCoQmNN4rvi5bbZJI9LzHbURYR/RIbBa/vGXA6AyxIBEV6TKtNJcjHVaz7oWTVyYpJDtMEvWxA
X-Received: by 10.43.114.138 with SMTP id fa10mr3056342icc.17.1402941863900;
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id i65si998067yhg.2.2014.06.16.11.04.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id B63DD5A4914;
	Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 94BA7E0A0A; Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251756>

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
index 859f87b..6c3e34c 100644
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
2.0.0.282.g3799eda.dirty
