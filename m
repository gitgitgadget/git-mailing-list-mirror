From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 14/15] refs.c: remove lock_any_ref_for_update
Date: Wed, 23 Jul 2014 10:03:54 -0700
Message-ID: <1406135035-26441-15-git-send-email-sahlberg@google.com>
References: <1406135035-26441-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 19:04:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9zyG-0004nO-Q7
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 19:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbaGWREg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 13:04:36 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:37053 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932490AbaGWRD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 13:03:59 -0400
Received: by mail-qa0-f74.google.com with SMTP id j15so259851qaq.5
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 10:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2hfzQqA7G5c3MnXFyMnSSjm0TfMlktj2Z3lRgOjQiiE=;
        b=dfawdUdQdoP9nkBpCKVT2FEszucSSJEJnlOTAeQqRoSq3NNG8sh3JHfYLnj2Tjmbi3
         ObwLX5vqi+zjdmfgexJGed5AcOFEaX2IGNgLtIdquJ1dyS5FUqPAiFBogemTa5+1wYDJ
         LHYzqEnmdKsevRIdjdZSWeQdztg7vNBa/xhpctd1jVCO8l/okF52tvkyrAhrIlgs/OEI
         nUzo5blmW35bHuXSePhIXjZDhZjE9sNPaRniA4qbRGUh9+Kx1X1K8KbUY0qt0AThsu9Q
         xjOytNgEnlBE7K1myvn6LvRTHtpneI0QYJ2ZFqb5JF6vbwu1P8dEvWvh0E3E7vkRS8VX
         9slg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2hfzQqA7G5c3MnXFyMnSSjm0TfMlktj2Z3lRgOjQiiE=;
        b=Hd5omLVbT/5slEYid+aV7wRrcJgVZTsh9AsFjpyMrJHRIGK/c65n0VZDWhPt556ieS
         IYECQYB4OkLwxECP+VLYY47ep1TVV16B+iUBRAp1nWbA2mCPwRxDXIxHvdEQF9GA2/dM
         tD6fRDj85lkPI9rCUSx5WBmNTBtTnhp0z+ntPTFgahrsw+l58tckqihDkxiU72CM4VHw
         1sLth3/sHZJUQ5HaZcXrtHkqwyyYmunv4PMKcDb7yHY+Uaubc4Rt4DChZak983sryHTQ
         ubeb5QWilXBu28GATSpX1EPv2PKdBq5+83dKOgi8O/0+QSsQsnUSsZExBnlRE5vtUunR
         Gotg==
X-Gm-Message-State: ALoCoQknxGO+UCo97kAMgPBqQt+0eKfjzm8IJL1choSEjEfH9A04qHt6ZZzHsMlVrQVy99GhV9g/
X-Received: by 10.236.124.100 with SMTP id w64mr61863yhh.57.1406135038999;
        Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si487015yhk.4.2014.07.23.10.03.58
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id D656031C350;
	Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id AEFE6E03D9; Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.508.g763ab16
In-Reply-To: <1406135035-26441-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254089>

No one is using this function so we can delete it.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c |  7 -------
 refs.h | 10 +---------
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index b74e5ff..0ead11f 100644
--- a/refs.c
+++ b/refs.c
@@ -2222,13 +2222,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
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
index 65d6360..712fc32 100644
--- a/refs.h
+++ b/refs.h
@@ -171,21 +171,13 @@ extern int ref_exists(const char *);
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
2.0.1.508.g763ab16
