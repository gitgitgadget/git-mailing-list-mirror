From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 14/14] refs.c: remove lock_any_ref_for_update
Date: Wed, 18 Jun 2014 10:09:06 -0700
Message-ID: <1403111346-18466-15-git-send-email-sahlberg@google.com>
References: <1403111346-18466-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 19:09:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxJMj-0007A7-CR
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 19:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753464AbaFRRJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 13:09:23 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:47210 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753095AbaFRRJL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 13:09:11 -0400
Received: by mail-ve0-f201.google.com with SMTP id jz11so143592veb.0
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 10:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BwsOetHbkUY1Wxy6PmJiKJshmM/9Q56cFOHTrLpML9o=;
        b=Z9JDtFtbao0QXUEbinGDHO8Z2lJsZVkgO5Vh7/d8u9p6m+daVRmGEmVwYVF+6E/JUF
         pyIasYmmmFANixXeEcxoAKVW/uy5+Tf0c/mEGZwI/UiqND/siKUq5yEsRO6cwxhCljGK
         /M0iL2YdPnXjEiMrBGC5E4CPrSm95i+RKwAYD+VPj+se1hSH9fD+xyjgvs0vKWmYzp+Z
         bfyHEpRlSNjTgryjwnR51gWlXho7wZOp6p/0BiAJXZxS1jxxw5Eth3y+dmE5pmN1Sxap
         Ej3Jm6q8RKS0cImhpXXxIzNx7bXbFLyYm7KqhciqhxLOlVMecHxwVPttjOQycInS/mBG
         dV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BwsOetHbkUY1Wxy6PmJiKJshmM/9Q56cFOHTrLpML9o=;
        b=NFJJ5uINOM0HkOcW5vFTzp/gG7PD4i1TXnR4JDhmNble/C0w0migRFiNDV+JlDwA+E
         XbuvvHrFL1vGixayG/k0B+2veI4tW9REtHceKY0U3dVYjNE/Gn0hrWGX2IGcCsXcLKOu
         2uq89QtpRQazFaWo7awsnUZkHNSdsBb42Ohe6A428LO/FZRjtim1D3fHbtu8VbljhrZT
         qZHoFPoyJSzycbt9BpXKxuLTfgmS1Vl5rYF44L5W1VZzC0fxVgN9VZbYa3ajH5USicmJ
         03+U+Z+jAtWOORJigMC69gVJMbvuC9FY+mHtVdVGi2Zw/OjNh1X9R/XBYb2WNgIw927H
         I+Zw==
X-Gm-Message-State: ALoCoQmi6uxJ1o2wdVLpJQxnJiJroM+wHZgZapCmhhFCYiX4slB20OmXkFReph5hJ+3cqQjxvVZX
X-Received: by 10.236.164.106 with SMTP id b70mr22363yhl.1.1403111350239;
        Wed, 18 Jun 2014 10:09:10 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si172924yhj.5.2014.06.18.10.09.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jun 2014 10:09:10 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 1BA6E31C810;
	Wed, 18 Jun 2014 10:09:10 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C806DE0A43; Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.467.g08c0633
In-Reply-To: <1403111346-18466-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251996>

No one is using this function so we can delete it.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c |  7 -------
 refs.h | 10 +---------
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index ff98682..95c3eb8 100644
--- a/refs.c
+++ b/refs.c
@@ -2205,13 +2205,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
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
index 5054388..b674c20 100644
--- a/refs.h
+++ b/refs.h
@@ -178,21 +178,13 @@ extern int ref_exists(const char *);
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
2.0.0.467.g08c0633
