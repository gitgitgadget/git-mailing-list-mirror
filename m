From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 30/41] refs.c: remove lock_ref_sha1
Date: Tue, 27 May 2014 13:25:49 -0700
Message-ID: <1401222360-21175-31-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:28:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNyf-0004zy-Rb
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559AbaE0U1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:27:34 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:49210 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752979AbaE0U0F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:05 -0400
Received: by mail-pa0-f74.google.com with SMTP id rd3so1510606pab.1
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2a/pvOv4bw/RsN6ZwZ111U2RXkan0TAGkYJ4T4OIGI0=;
        b=UNrGDXgLBkdil8NBZbPJpwyoeEIW5RyaHUxfSIoP378dE59b4bLJ9JygPQ2mhhWGep
         gB7TfwWUyYhGnq8N3RGakBuknTuSHjuCejmwTrZ8llH94LTZOsq06LbSOe7G2HOLbVwj
         nRQ70LcjD2YYg8b9EHj6EXxz6NwjC7S2x12YfDhmHVqFWW2jxu8/vN9/tMICttIQq5WG
         xFZxKOLanRMi24hhZhnwdtPj1R34GNbM3AzIfvNn1a0IQrWf4l5O7Dr6UwKmZIY3nFEK
         yAW0EwhODI1j/EbrVYJ1eoaI4UEfCWhYyAhBOHZBXpemGSG286sgLwR3TChLSNsn+hlO
         PA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2a/pvOv4bw/RsN6ZwZ111U2RXkan0TAGkYJ4T4OIGI0=;
        b=OUe/Ld2cShv7ZUZx2LwR0Z42QDTKtkBszWcNWV8fn2JNrcIzOPPuQ/xvPJ2ern950X
         9o0aOEEsBIO57uhwLKiSL9+iTAmrgxniu1XJKeg+QMJQxWxXdOuuLp0h9iPS1cGlluUm
         w+c4UpEXrU5mohKTTx7NJ5XFMv/Q2EHDW9CEGzMyjag3LWU6f6ETS8DVhGynTHQ2REoG
         1xd2yNHqhKE70Nx9qyyxua48RR7TK8tob9JoPwzi2dZ4sUpZo6O//ZLWcx62CPsqSr6a
         6OLKhDmNh43Bcec4a6ZgOF8nRkdUdXmG5GCmltQmMTXPlgtas4dvBxItliDHjFgaeR0e
         FDvA==
X-Gm-Message-State: ALoCoQmBxGSbkyaKllNPf2ZxWJLFItx5BcRUmr1RkSVfpmF1bcvvMIZZ8GWLEO5els/Vka+LSE6V
X-Received: by 10.66.138.17 with SMTP id qm17mr14103632pab.34.1401222365118;
        Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id h13si137572yhj.0.2014.05.27.13.26.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id E6E9D370568;
	Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C30A3E0D62; Tue, 27 May 2014 13:26:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250229>

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
index 979b79a..4ca84f7 100644
--- a/refs.c
+++ b/refs.c
@@ -2124,15 +2124,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
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
@@ -2337,8 +2328,12 @@ static void try_remove_empty_parents(char *name)
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
2.0.0.rc3.474.g0203784
