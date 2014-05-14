From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 27/31] refs.c: remove the function lock_any_ref_for_update
Date: Wed, 14 May 2014 15:13:26 -0700
Message-ID: <1400105610-21194-28-git-send-email-sahlberg@google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 00:14:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhR2-0006WZ-NA
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580AbaENWNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:13:50 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:44307 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753484AbaENWNm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:13:42 -0400
Received: by mail-qc0-f201.google.com with SMTP id l6so47430qcy.2
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SQaKGZg/2X5xu/NT4LPASIZLARsMjik93A6Is+bYxyg=;
        b=pV1r+j9XTYN8KI4AsnhSmWtca4Q6yaRKz1GMybc4CxH6HN5BLX01PhcUslxWTrQwcq
         3zIV+EIN3NJfuLUw77pbwwCTE7bfk7flagIav0mTJOtrRvoiPaRX84JC4Wh3Ey95ZlM4
         vbvfw45hih28PFzF3023RSzfGe3PulnW4O9tPN5MVgeTDISRaUf8lTl+u/+zg3mpW8JI
         LjADx7D6dlPi8OL3M6VQjSJC8luv3elsDOx2fhTMf9TO08SltMjMetWEn+zMraAk/i3N
         6puFmwbUmLoi9S7RgCcBHYC+DQJqYiMQ4zrgCCZjI/EK0vRSWmfyZvsx62xX8oXRlOVu
         sruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SQaKGZg/2X5xu/NT4LPASIZLARsMjik93A6Is+bYxyg=;
        b=NQr7DY/ZSu77gZ4KOGk5HKeBBe6ZsMugmHn5E8WOTH5mGzT5091/d0PvZPoz7Sx6Py
         nqdZI88l1l4jeSaWThejebV9awF49ws70SxsOUfTuw0d8D3k+vH3xPNfF9vfMX1XrVxv
         ZOz9qe0UUz0BG5hbOhkrSYrWDm17DS8eUA1MU0VbB695y0pDx56icZ/Pne5pNkE+Gp1o
         Yb9/wK2w/AtMXUb9ZZWJ4u5FCqOGclbDWDpPlenz1iqZoRMd9Vyk1+XB1zEPKH4b9KQy
         Q6YFC19SpSxflSG9vYXDHihZyOKRflrNqXWB2YmoarQ2wpKz7yu+BKyOdIRzxWyb07u2
         1JGQ==
X-Gm-Message-State: ALoCoQlS9pfrexu7xqZ/Elc44MUvC4dlobcoglf0T2rINqUHMGRLze9sWYgSqCbzsrdcsVnoKG68
X-Received: by 10.58.38.199 with SMTP id i7mr1394950vek.6.1400105621683;
        Wed, 14 May 2014 15:13:41 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id h18si153009yhj.0.2014.05.14.15.13.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 15:13:41 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 884F95A41E5;
	Wed, 14 May 2014 15:13:41 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4D45DE038E; Wed, 14 May 2014 15:13:41 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.506.g3739a35
In-Reply-To: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249017>

We no longer need the function lock_any_ref_for_update so lets remove it.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 7 -------
 refs.h | 4 ----
 2 files changed, 11 deletions(-)

diff --git a/refs.c b/refs.c
index 0cb4ae8..918cda3 100644
--- a/refs.c
+++ b/refs.c
@@ -2167,13 +2167,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
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
index 289558c..1e89187 100644
--- a/refs.h
+++ b/refs.h
@@ -135,10 +135,6 @@ extern int peel_ref(const char *refname, unsigned char *sha1);
 /** Locks any ref (for 'HEAD' type refs). */
 #define REF_NODEREF	0x01
 
-extern struct ref_lock *lock_any_ref_for_update(const char *refname,
-						const unsigned char *old_sha1,
-						int flags, int *type_p);
-
 /** Setup reflog before using. **/
 int log_ref_setup(const char *refname, char *logfile, int bufsize);
 
-- 
2.0.0.rc3.506.g3739a35
