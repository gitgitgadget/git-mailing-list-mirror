From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 03/48] refs.c: constify the sha arguments for ref_transaction_create|delete|update
Date: Thu, 19 Jun 2014 08:52:45 -0700
Message-ID: <1403193210-6028-4-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:53:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxeej-00062z-KC
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758091AbaFSPxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:53:37 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:64314 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757478AbaFSPxd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:33 -0400
Received: by mail-oa0-f73.google.com with SMTP id eb12so694419oac.2
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tZiXSfbFUsSFEtnEnEH8RudEow6CikM0bxwtVQq9NY0=;
        b=G5jHOM1xMIYccYYdzwlQ9z4Y6Z4zPhE7PhFoBkZMP16eQYW5FzWrmy4aCj5FmT+2vI
         GbbCGny1bYhaecgEGe4V0PYf/VeKTfAj40bV/7x3aIx9rd3eyK9Pi33IPpK4dp1nW31J
         tw47XAPTl4/TqI1F0pjrBWkl3Pkp5bK2JwFCNuhBFBj7sgMWTfur2VvlaeuwLeVTPklA
         Gk7DfB94hesKl7dCqhpsqIUpYu9cFslhr2naEF3Fo3CD5sTCRC7/wRhJ6kzIOc7nNJXn
         JwnqF0j7yGT/xEqkvBnaWv0i6v+GCJT5gJ0/gfc2Yy0qJjnuoCJmOupWCCMlf3NXp3uz
         q3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tZiXSfbFUsSFEtnEnEH8RudEow6CikM0bxwtVQq9NY0=;
        b=N8NQ2Jjf2HcnrAKxX/RaP9kzoi3zKozo00HSJgI0BTL9Q32I5Xu/NJoFdIZXuDluaH
         kKtbcxAC2oR2WKd6xxRM5F4OXr0NbvPQMCeRevaXD+skWX3qYQ/z9VfWDxITEE59ymym
         K5u2n5wZptqqQzymkDlVd+5XLa0lCjVz4ol406AGjPvynOwYcg5ifHq+m15sNJqhXWGr
         8nMgpfKXmEjxtrzA8iVf3jjCrrz01CEoGa5z7moLUYhAFlK9lDx2KXKen5OWCIs5hImH
         5PFYKT4SWQg4O7fI1Q31K+KWZwohrDqpIXhxUU86fEUQIXga99hOOkATi+DPDuaanHY2
         trQg==
X-Gm-Message-State: ALoCoQlPet4/4XsCBho3c5DfAKhOhQHD9f3LEpMmDBv1scKPf3/G9oHAhZ79O8bTZsrOtCd5JV7z
X-Received: by 10.182.130.169 with SMTP id of9mr2700911obb.27.1403193212831;
        Thu, 19 Jun 2014 08:53:32 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si419895yhb.3.2014.06.19.08.53.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:32 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id A8AED5A42EE;
	Thu, 19 Jun 2014 08:53:32 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 52BE8E0734; Thu, 19 Jun 2014 08:53:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252116>

ref_transaction_create|delete|update has no need to modify the sha1
arguments passed to it so it should use const unsigned char* instead
of unsigned char*.

Some functions, such as fast_forward_to(), already have its old/new
sha1 arguments as consts. This function will at some point need to
use ref_transaction_update() in which case this change is required.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 7 ++++---
 refs.h | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index d9cac6d..21ed465 100644
--- a/refs.c
+++ b/refs.c
@@ -3359,7 +3359,8 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
 
 void ref_transaction_update(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *new_sha1, unsigned char *old_sha1,
+			    const unsigned char *new_sha1,
+			    const unsigned char *old_sha1,
 			    int flags, int have_old)
 {
 	struct ref_update *update = add_update(transaction, refname);
@@ -3373,7 +3374,7 @@ void ref_transaction_update(struct ref_transaction *transaction,
 
 void ref_transaction_create(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *new_sha1,
+			    const unsigned char *new_sha1,
 			    int flags)
 {
 	struct ref_update *update = add_update(transaction, refname);
@@ -3387,7 +3388,7 @@ void ref_transaction_create(struct ref_transaction *transaction,
 
 void ref_transaction_delete(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *old_sha1,
+			    const unsigned char *old_sha1,
 			    int flags, int have_old)
 {
 	struct ref_update *update = add_update(transaction, refname);
diff --git a/refs.h b/refs.h
index 7d946f6..8c7f9c4 100644
--- a/refs.h
+++ b/refs.h
@@ -240,7 +240,8 @@ struct ref_transaction *ref_transaction_begin(void);
  */
 void ref_transaction_update(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *new_sha1, unsigned char *old_sha1,
+			    const unsigned char *new_sha1,
+			    const unsigned char *old_sha1,
 			    int flags, int have_old);
 
 /*
@@ -251,7 +252,7 @@ void ref_transaction_update(struct ref_transaction *transaction,
  */
 void ref_transaction_create(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *new_sha1,
+			    const unsigned char *new_sha1,
 			    int flags);
 
 /*
@@ -261,7 +262,7 @@ void ref_transaction_create(struct ref_transaction *transaction,
  */
 void ref_transaction_delete(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *old_sha1,
+			    const unsigned char *old_sha1,
 			    int flags, int have_old);
 
 /*
-- 
2.0.0.438.g337c581
