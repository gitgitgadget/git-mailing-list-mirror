From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 37/48] refs.c: remove lock_ref_sha1
Date: Thu, 19 Jun 2014 08:53:19 -0700
Message-ID: <1403193210-6028-38-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:55:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxeg7-0007mr-US
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933279AbaFSPyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:54:53 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:60216 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758077AbaFSPxf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:35 -0400
Received: by mail-qc0-f202.google.com with SMTP id x13so332356qcv.1
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=//cB5pYqq5wiuHUksR6HwNXXPJ5bxlJ6+0rUEvyZk6U=;
        b=i9rQ1DTsdxPQDJTI0C7rv2SAkleh0IoRqdvLnFsJNJiG4w5vfwz2LXOuSCB/s+IzQI
         qq2x9LlDKvVjPVmfJaXaceE/Eb3dw3M1pcmeClc6RXD5m8eb5ml0gszHZS1Dy456u5TG
         uK70Xh3syhCgJp92rTdLbTClnnOp33Fno87TrwPabdKBgJucmpBO0qp6ZXQgLfNU02M4
         xTR3FNe0JwY/lklX2Ce4LKzxBNA4fSFdwz27gCDni1dTHpYPKDp4L0Bg6kav0gGOajKW
         D3W1cpHb9yEjqvmb41MqYpAsmi9WuYd53rolu5CzUBLh0xX+MD72sd/v33ZBs/KNkcYc
         Qb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=//cB5pYqq5wiuHUksR6HwNXXPJ5bxlJ6+0rUEvyZk6U=;
        b=OeiN8Qj0L8vzJ682xyZZbN29HWikK0AKmcA5WZMBK+QJLtjKelDPk4sHI0ddeiswU4
         ykV09o3dwiG8NBMxiu4YSCCBljCJkVWKh/YvIfKTSm/+/vyiKGr2Fya6LPrSlywNE0S1
         7zd7HdYhs9QWtoB5JUnyi4zay6kowvwAlgTUZs12G513AAnu2Ma8tg/PtAfVM05i5mol
         X4MQRYUMuTm+ZXerZCcC19UZRMz4J1MJPZKfzuGJ01MTvs/BUk0GnOpPuFlAyH39QCoq
         XN9jOU+D1FmBHljnxrBOkFV9OPj/2kKRntCLsp/ogTQ0SAS6rlI+/zwDzauiMXaJeYbo
         5uKg==
X-Gm-Message-State: ALoCoQmj+lyIKpIm8y6d30IwpVyYdsM/RfHdDh8bqb++SSnDuU4WocWqzWH4gXlyOdXXH8oCQjDm
X-Received: by 10.236.144.136 with SMTP id n8mr2318299yhj.22.1403193214386;
        Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id o69si418787yhp.6.2014.06.19.08.53.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 3F3E731C3F5;
	Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 1BA92E1106; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252135>

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
index 6792938..441c0bc 100644
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
2.0.0.438.g337c581
