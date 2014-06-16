From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 14/14] refs.c: remove lock_any_ref_for_update
Date: Mon, 16 Jun 2014 09:51:45 -0700
Message-ID: <1402937505-6091-15-git-send-email-sahlberg@google.com>
References: <1402937505-6091-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 18:52:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwa97-00035X-Cf
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 18:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbaFPQwD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 12:52:03 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:43522 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932255AbaFPQvw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 12:51:52 -0400
Received: by mail-pb0-f73.google.com with SMTP id ma3so599620pbc.2
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 09:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eOhg9AvcsNDyM9cFEuyMUNXIbgU/BRT2N9SmTp2fDag=;
        b=YmUxIS/pZtkfiRUsYTePzvKTQmdhR5+PiDxT6WJmkCeuw7uvsk2yS0e1MBciSJzj3B
         GjLq5uBzoSkY4BmyJcUVhVQ5rahxvuEsZ0mMXmYuR3X6rKGVNj1CPz35AknQsi8/zjZo
         zhBWT7zuaPTkjWFNmnbC3Ax0K/3V4PvG5sNqck3zayx4OUOYwFYWc2F0jlknXCMDbNoz
         +GmKOzcffk4/pTUWtuJyjsJTq2FMP3UeM5dN2ys8Z+GCvxsF9T5LvKZSppbaeAXgLOLO
         A6YYetnJ1YKannA7tqQC+qrf0SeaMwf7A2YHDrJpn/KC5OPkSPuEWqQFiQsf/NuQZsQm
         GT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eOhg9AvcsNDyM9cFEuyMUNXIbgU/BRT2N9SmTp2fDag=;
        b=A+qlsWKnb72RaJzgs5oWBbFyesMLIlT8ve2mEV0zDVtjvoF5UcLacDmAl0mHGS7JAd
         uHwpHRNC83MjToFpeQglDnXsG8zMi4iJVfkWV7GZ6wVhy9JvHgM8b4ZOyIO9KuDLOzs2
         JlHNkv2Jew/wkvFAU6i7xovhcOOxuahkBTZ9c2DCuV8TWAoeVMrv34No/jSJLP8cuodV
         sUIel6p/P5ADVVHM+7AaElv23UipDqfKsNAAow09NwDzXGyUxarZbrBAJNbCZqMBYyXp
         6gsye49QN8GTLfl5WAEygTh2DtcZB5B7kTvIjhPaTdne48Gj30JdHnzhBJq0ARGpqI4M
         Xprw==
X-Gm-Message-State: ALoCoQlNprkZgtYIl+t1x5AE3+GbM0I9WKiVuOn4fDeSBTtBUjxlgi5TkjQqf5VWqxK0DYQeKkzW
X-Received: by 10.66.216.130 with SMTP id oq2mr560122pac.44.1402937510017;
        Mon, 16 Jun 2014 09:51:50 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id t4si984634yhm.0.2014.06.16.09.51.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id D1B7831C68A;
	Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6B077E16B4; Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.770.gd892650.dirty
In-Reply-To: <1402937505-6091-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251729>

No one is using this function so we can delete it.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c |  7 -------
 refs.h | 10 +---------
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index 3f16445..a2c3630 100644
--- a/refs.c
+++ b/refs.c
@@ -2207,13 +2207,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	return NULL;
 }
 
-struct ref_lock *lock_any_ref_for_update(const char *refname,
-					 const unsigned char *old_sha1,
-					 int flags, int *type_p)
-{
-	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p, NULL, 0);
-}
-
 /*
  * Write an entry to the packed-refs file for the specified refname.
  * If peeled is non-NULL, write it as the entry's peeled value.
diff --git a/refs.h b/refs.h
index 2025b96..d076d69 100644
--- a/refs.h
+++ b/refs.h
@@ -177,21 +177,13 @@ extern int ref_exists(const char *);
 extern int peel_ref(const char *refname, unsigned char *sha1);
 
 /*
- * Flags controlling lock_any_ref_for_update(), transaction_update_sha1(),
- * transaction_create_sha1(), etc.
+ * Flags controlling transaction_update_sha1(), transaction_create_sha1(), etc.
  * REF_NODEREF: act on the ref directly, instead of dereferencing
  *              symbolic references.
  *
  * Flags >= 0x100 are reserved for internal use.
  */
 #define REF_NODEREF	0x01
-/*
- * Locks any ref (for 'HEAD' type refs) and sets errno to something
- * meaningful on failure.
- */
-extern struct ref_lock *lock_any_ref_for_update(const char *refname,
-						const unsigned char *old_sha1,
-						int flags, int *type_p);
 
 /** Reads log for the value of ref during at_time. **/
 extern int read_ref_at(const char *refname, unsigned long at_time, int cnt,
-- 
2.0.0.770.gd892650.dirty
