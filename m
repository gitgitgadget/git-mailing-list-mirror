From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 06/44] refs.c: add an err argument ro delete_loose_ref
Date: Thu, 15 May 2014 10:29:21 -0700
Message-ID: <1400174999-26786-7-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:34:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzYD-0005cv-T4
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755835AbaEORc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:32:26 -0400
Received: from mail-yk0-f202.google.com ([209.85.160.202]:46021 "EHLO
	mail-yk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755347AbaEORaH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:07 -0400
Received: by mail-yk0-f202.google.com with SMTP id 9so80440ykp.3
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5ucSLbZUIcCQPrlLAzks7xNLqeUe71t1KDO9Dq8Qil4=;
        b=IpOPj88ur6EtW5wIPYb2GLjc89BZppgz/sjrChu13ZPthw3dUI7cSuAIudPlSZdi2S
         /tYxy8T9x4hvSvyMjFgxl1IRowaggOXYHKKYPEZ83X4EU9acOVdRxhMhFbCpKOPPtVQd
         zO2KraeIpyO8MTKtbJ2Q9IatI9i15IN1JgJej13YQ5A/0qVJNieJ2t9v2FIQeQXdnBEg
         qhxbz/zfTaVo7XfsWznWW8lHpT/P16nsM1MiC+A2+6VNSfgwlv6gotS1onKhNcLcPU8R
         a2GWHF+EuBsFSKdXoiPZnS61dmNHkqUpkv6aDHzvZThzxJJFhbZDotaY1UzF9lSGYiKr
         SRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5ucSLbZUIcCQPrlLAzks7xNLqeUe71t1KDO9Dq8Qil4=;
        b=iWzYtGRLRHaszb+p/nGTj6QGJyNRGN/ZvpEjGbiIX0u3uuainuRll+yrAKGS5W3Adh
         p3QXM1DeZqGNRU/U0XpJiD/RCSng1LIUfZjZsPe+tU0fBSwp3TsVxsXvY20T1BhK6h4g
         OwH+T+Ogjx6aEQnpUCTFvI1Izm3UlWhfC9W0qJU470ZVAl8hGSNXsBZvst/6xnHbhJPL
         X+TVzlmzlP63S2/IOSYYhm6zu6SuxADZ6+uZrOYOvo8lLcpAdY1UmU/2BSJMWw+Btb38
         oDencEUjLR7DSkYvemgpCFfBGmHW3JwFiw3jfC8Q1X3eApfgw6dvaAGRipamgyRJuY9N
         DKNg==
X-Gm-Message-State: ALoCoQlMngzrUVkB4V5xydQDoQFdQlJq0npH4zWbMULIdweThgfgJ2901wy8xy1P1iz2EA2PC0Zj
X-Received: by 10.58.152.37 with SMTP id uv5mr5527960veb.0.1400175006151;
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si273160yhk.4.2014.05.15.10.30.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 05FBB5A428A;
	Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 8AA27E1207; Thu, 15 May 2014 10:30:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249164>

Add an err argument to delete_loose_ref so that we can pass a descriptive
error string back to the caller. Pass the err argument from transaction
commit to this function so that transaction users will have a nice error
string if the transaction failed due to delete_loose_ref failing.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 072e3e9..a150520 100644
--- a/refs.c
+++ b/refs.c
@@ -2484,17 +2484,22 @@ static int repack_without_ref(const char *refname)
 	return repack_without_refs(&refname, 1, NULL);
 }
 
-static int delete_ref_loose(struct ref_lock *lock, int flag)
+static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 {
 	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
 		/* loose */
-		int err, i = strlen(lock->lk->filename) - 5; /* .lock */
+		int res, i = strlen(lock->lk->filename) - 5; /* .lock */
 
 		lock->lk->filename[i] = 0;
-		err = unlink_or_warn(lock->lk->filename);
+		res = unlink_or_warn(lock->lk->filename);
 		lock->lk->filename[i] = '.';
-		if (err && errno != ENOENT)
+		if (res && errno != ENOENT) {
+			if (err)
+				strbuf_addf(err,
+					    "failed to delete loose ref '%s'",
+					    lock->lk->filename);
 			return 1;
+		}
 	}
 	return 0;
 }
@@ -2507,7 +2512,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 	lock = lock_ref_sha1_basic(refname, sha1, delopt, &flag);
 	if (!lock)
 		return 1;
-	ret |= delete_ref_loose(lock, flag);
+	ret |= delete_ref_loose(lock, flag, NULL);
 
 	/* removing the loose one could have resurrected an earlier
 	 * packed one.  Also, if it was not loose we need to repack
@@ -3492,7 +3497,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 		if (update->lock) {
 			delnames[delnum++] = update->lock->ref_name;
-			ret |= delete_ref_loose(update->lock, update->type);
+			ret |= delete_ref_loose(update->lock, update->type,
+						err);
 		}
 	}
 
-- 
2.0.0.rc3.477.g0f8edf7
