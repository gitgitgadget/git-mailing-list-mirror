From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 14/15] refs.c: remove lock_any_ref_for_update
Date: Mon,  3 Nov 2014 08:55:56 -0800
Message-ID: <1415033757-9539-15-git-send-email-sahlberg@google.com>
References: <1415033757-9539-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 18:04:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlL3F-0006Gf-Er
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 18:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665AbaKCRES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 12:04:18 -0500
Received: from mail-vc0-f202.google.com ([209.85.220.202]:33640 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324AbaKCRER (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 12:04:17 -0500
Received: by mail-vc0-f202.google.com with SMTP id hy10so821836vcb.5
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 09:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ei4JikTOjpnIV1rUu65ZoLMNqYIlcHScc1bnGTHQB/k=;
        b=Tdhik0LkJhd+3/9HYExaSvaQZwRra+o/gmdHc2u0NeNIt0zyAR1vKikL9e+s1hYBAN
         FlpBses/fu5x7oRYYn7U0jOZ0V8BSVKCE1raIrDiqWOrUSCCQ7e2D4slwy6G+wiavCxu
         xAeZVuBzyftB7t9pQ/agVUqTOlb9VTMWbKzGRoPx0POxwPostXgX9BbzcaM6p3MtoQGK
         niVZ2Lp3TYcC37cHRZyxXHaHgPixLan2yJ05W+Gcg0e1F1bN0luGF+TImo45AKivMMzH
         Wafa7oOHMLjVnULMKrAIFj6Pq3sjtq+KhBiBFhGGU9YUijtmrMZEWsJL+BmP0NVbx6rN
         XASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ei4JikTOjpnIV1rUu65ZoLMNqYIlcHScc1bnGTHQB/k=;
        b=fKKGRJaO+2LDqj9+XvuM9kRkBUbcHosSunFGCRzlzipp1u9xaI9Vxd21vRDCXixEJv
         zk6BleGPhYN97ADtMcMirQZOPhuiQXU5+XytoNXz49UKZcgN03V/UA4D42SATlCksgSB
         iVSVrl9DnakkcDW2Ffdn9PeJvs8LKZiB06LWFTTPK0usvalggQzADmH3vtH+FJbKv+rr
         Hwjbcxhl6+TANEvyBgDf/vbG8h6BlZ7iBXVpZJFMOa0R13eEhYUr/oBnd3M++1d27vmH
         C4MUwTeftJCG97EsrE2dXs0QqL69pODOq8JB/dPx2HMiv6tV58786hVJ9Inr90k13Q1W
         wAZw==
X-Gm-Message-State: ALoCoQk+ou57ytL4Yw5XTWwsI81+C4OhVU4GS8bC9KFhfcKjXHczFfOq3pL78H3SVK78FrrIev6q
X-Received: by 10.236.228.202 with SMTP id f70mr26082217yhq.28.1415033764180;
        Mon, 03 Nov 2014 08:56:04 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id 5si150666yhd.6.2014.11.03.08.56.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 08:56:04 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id gn2vF0Xp.2; Mon, 03 Nov 2014 08:56:04 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id ABC78E10E3; Mon,  3 Nov 2014 08:56:02 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
In-Reply-To: <1415033757-9539-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No one is using this function so we can delete it.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 7 -------
 refs.h | 9 +--------
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/refs.c b/refs.c
index e4ad4f4..6d50a32 100644
--- a/refs.c
+++ b/refs.c
@@ -2352,13 +2352,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	return NULL;
 }
 
-struct ref_lock *lock_any_ref_for_update(const char *refname,
-					 const unsigned char *old_sha1,
-					 int flags, int *type_p)
-{
-	return lock_ref_sha1_basic(refname, old_sha1, NULL, flags, type_p);
-}
-
 /*
  * Write an entry to the packed-refs file for the specified refname.
  * If peeled is non-NULL, write it as the entry's peeled value.
diff --git a/refs.h b/refs.h
index 025e2cb..721e21f 100644
--- a/refs.h
+++ b/refs.h
@@ -181,8 +181,7 @@ extern int is_branch(const char *refname);
 extern int peel_ref(const char *refname, unsigned char *sha1);
 
 /*
- * Flags controlling lock_any_ref_for_update(), transaction_update_ref(),
- * transaction_create_ref(), etc.
+ * Flags controlling transaction_update_ref(), transaction_create_ref(), etc.
  * REF_NODEREF: act on the ref directly, instead of dereferencing
  *              symbolic references.
  * REF_DELETING: tolerate broken refs
@@ -191,12 +190,6 @@ extern int peel_ref(const char *refname, unsigned char *sha1);
  */
 #define REF_NODEREF	0x01
 #define REF_DELETING	0x02
-/*
- * This function sets errno to something meaningful on failure.
- */
-extern struct ref_lock *lock_any_ref_for_update(const char *refname,
-						const unsigned char *old_sha1,
-						int flags, int *type_p);
 
 /** Reads log for the value of ref during at_time. **/
 extern int read_ref_at(const char *refname, unsigned int flags,
-- 
2.1.0.rc2.206.gedb03e5
