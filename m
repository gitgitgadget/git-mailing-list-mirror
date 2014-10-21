From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 14/15] refs.c: remove lock_any_ref_for_update
Date: Tue, 21 Oct 2014 12:24:21 -0700
Message-ID: <1413919462-3458-15-git-send-email-sahlberg@google.com>
References: <1413919462-3458-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 21:31:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xgf9m-0003hd-BT
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 21:31:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932934AbaJUTbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 15:31:41 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:38156 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932744AbaJUTbk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 15:31:40 -0400
Received: by mail-pd0-f201.google.com with SMTP id y10so345122pdj.0
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 12:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XMagjyEiMoB5ImPlQNTWy0fSycgghHeGCl1ywuJO378=;
        b=UGPqnSDoqbGUavK8v89+ZN3OfEUdlR4U2vAF2z2kWALU8ZCCZOhRkzsVzUYzbrmR1i
         nZgvtpyb04L8FmsWnty8G+X9WgGcS9e2PUXxtUwBbPfwc1yvTf3gcyyvHYn4EgX9NQqi
         zYF3ruXfjQ4gHu//akKO3WkkNLzHot+fqKy+8agoWJkWav7KKF5nwooGXRnymXMT+wEH
         LkrpVZT6dsPvVQtiTt4S137zKOu0wSFlvZ0rgnQ7mMQQo9C/Eqiyr6UaF+4QT711cU2q
         ieHQnyyDfAvFK6Wp23PveQA2PLaAwmHEVM1oYFctvagDhI62t3RpC5qaKrarbx0tR5kq
         3iVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XMagjyEiMoB5ImPlQNTWy0fSycgghHeGCl1ywuJO378=;
        b=eNth4z0QuU5riA7IDgEKkzVJa6SEfi9dfxCLDuqsUJ71nNm1oPxeAgWvROLP53e3cm
         C/WCgG1GEU0kM5UHCa47VyP3lefdM8WHk4Pgjw+4WeWD0eC6rU29v65xzmKG1yB4GAPn
         U+fi8ZHaHKhwVtsu/S657PovMSTAzyJUeQeZCALnAsLX7fmURiB81E/cZuDo4Jc4Sf/8
         rv8JdDYsdL4itueXJeAHPRct3rRJB5lR9kssJqv5O8AexUiwv4nBgIsPjpPWFT2bvWj7
         Mme0zIYktNC3Quvg+lnmkpRUieA6hUxOjZ7llB6VGHoXx4tRgy68jYDXiUbMwDooLp18
         OISA==
X-Gm-Message-State: ALoCoQnH3NnFUAFCOdmBNPvseXnvr3cDHsNzGt2oHDXPx314y2V51ogQalBkx/92bVcrORsVcTvF
X-Received: by 10.66.65.133 with SMTP id x5mr779739pas.37.1413919899707;
        Tue, 21 Oct 2014 12:31:39 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id n22si586424yhd.1.2014.10.21.12.31.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 12:31:39 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id O8DCkOP4.1; Tue, 21 Oct 2014 12:31:39 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B7651E1272; Tue, 21 Oct 2014 12:24:34 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.728.g406752a
In-Reply-To: <1413919462-3458-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

commit 3a2f55c247ff290943fd552674e226062c13fd00 upstream.

No one is using this function so we can delete it.

Change-Id: I524dac239da500e5d4432328b997ed8ab34f6803
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 7 -------
 refs.h | 9 +--------
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/refs.c b/refs.c
index 5e5f066..5bd6d62 100644
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
