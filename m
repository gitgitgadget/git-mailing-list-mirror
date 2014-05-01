From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 31/42] refs.c: remove lock_ref_sha1
Date: Thu,  1 May 2014 13:37:31 -0700
Message-ID: <1398976662-6962-32-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:39:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfxlE-00028v-Su
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473AbaEAUis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:38:48 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:38907 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435AbaEAUh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:57 -0400
Received: by mail-ie0-f201.google.com with SMTP id rd18so797742iec.4
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=THEFLhkGcUdNVfQQEmBJQmG3RZYHJ7nyCd8duJ2WMCg=;
        b=ifRsgKm2wV/fmUCdgEfTTuDQofFJYLDYjmjCn/GEIqWQhemkU8JuCd4kRO/1avOEtR
         kG7m9rcnwAAMZ9TXqbmotd7Mq2oVSsoihzAOKKiOrLl92548FHEerDyiNmty/x6fMiKq
         dZ2O2HTzdTDiHVN6LFr/DRddKf8exIrr5apvq5WR23Fhfq4smgOfPiADva64jTHPPcpe
         kEOBgq/TNIrS68eVoPe9Ln+OIcmh+PeZooJT0H9ElgcigpGkwzhgi3HA5g+QrihpMmHv
         SnAfhB2yP2nDMSZXbJ1AG3zKuALnIywX43FlfQR8vQW/Y1ceEfSIBXXHVuKKmMaTvCcd
         0sgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=THEFLhkGcUdNVfQQEmBJQmG3RZYHJ7nyCd8duJ2WMCg=;
        b=UlTjUMc0xCzG/bIOSreDwtg4sL1vj3hWwda5mBMYgWOi0c4Kc9L2Q5O0zVsaJGe56B
         HYHBM+lNkUHmpKL7WUY8+voeXJ5/p6gyOrkESVLD8AaCMmBc0E9C6Gew0prjLfTiHyg5
         Imv3MiH6iF1pbV8eSbU9UyZU+H00AuFjdS8hiCfrm8i3k0ebF1lOtaYLr5o9nahnytva
         pYjoAN1p4b+vcRnQI5DzlAgIkHq9usa1k0WygSKIqNWYxkpSEkLZB+82vJOeVXoTXIOf
         sF45YQCFbON7bavflt2Aej+uk3qFwYuOnC837WhRyp9nFEwg/NFxiEjqJJKA6llO8QH4
         XBWA==
X-Gm-Message-State: ALoCoQlg9RP19We2TiQXcs3Vgry2RQxjtPHI6dc7bu+AQ1N5LfqBaQ00qeFi1pAK8hZed5d5dwHe
X-Received: by 10.50.73.74 with SMTP id j10mr2455600igv.1.1398976677558;
        Thu, 01 May 2014 13:37:57 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id g21si3538089yhe.3.2014.05.01.13.37.57
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:57 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 6631431C1CC;
	Thu,  1 May 2014 13:37:57 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 280A2E097F; Thu,  1 May 2014 13:37:57 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247860>

lock_ref_sha1 was only called from one place in refc.c and only provided
a check that the refname was sane before adding back the initial "refs/"
part of the ref path name, the initial "refs/" that this caller had already
stripped off before calling lock_ref_sha1.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 875178b..a55cc38 100644
--- a/refs.c
+++ b/refs.c
@@ -2130,15 +2130,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
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
2.0.0.rc1.351.g4d2c8e4
