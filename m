From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 01/44] refs.c: constify the sha arguments for ref_transaction_create|delete|update
Date: Thu, 15 May 2014 10:29:16 -0700
Message-ID: <1400174999-26786-2-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:30:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzU4-0006RQ-Ec
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755726AbaEORaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:30:11 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:47775 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755234AbaEORaG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:06 -0400
Received: by mail-oa0-f74.google.com with SMTP id m1so290390oag.1
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ECv8bXf9CRAIruHbpVClU8qCCrDSh6xwbJEzef8QQXw=;
        b=Sx+2CraC3SQeFocwF6rbHphhZlH7yFWkzMmP3xqgirUAKPedbco661+XR/NNMRu9wB
         57NJqTpuul7tICUuh2CnF1dgwOTwhEkOtgkzxcceJ9cRzNtSViFeCSJCJGaKRGXKKGbd
         7f5XQsG63zi+nAIRd6Fb1m/TsGp6Je0yBKD7GbHHOv0diY9XQGpXywGjjwtgDRG6tM4G
         xdG4QFFQDC60w6OJiz1RnMwTEYmdsmRJ3mFnC6ZYKgu/t/J6Imi9J/Xufo4zwYNQbfIN
         TKXtZ6kIsmV8l61XfvK9pBfpKSSq22fuCnSw5+wO6E3nAq3rGGf8kzB9ONub6nlCz3ml
         V+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ECv8bXf9CRAIruHbpVClU8qCCrDSh6xwbJEzef8QQXw=;
        b=RLera3vWb+LYd+0SdXEPqY5ZiTT4bF0MP3e/rTTGpd0Uy27VSvt6vEc9hlUhlTNlrl
         MMryMp3lb1T9BjOHlyu4PYO+j1lqSo66OMJIYwVIk0NtUWe1smY+MpMzp9aLTQePk9vb
         laNArbWWoBLbTgbKtkxU8tZ05sSv7CZfVXdGXPgZ5bthVDfoRObLVlvd3aZKU3WLd3bK
         IgHSe90W3Or837/aFEU36RaeA7Fm9XE1tzwGyyQOygreoZ4XGLgGmJpUo5LeT2v6gTU4
         pfMS7sPLt5hG6WwactuOjPHkA2Q2NK4Gi7LaIf8GKr6DilOQF4V/7oztFH+YJBIBOLFK
         lHVA==
X-Gm-Message-State: ALoCoQn3bShmGg76qNJh7/GzeDkqes9ND4yUFDygk0rizM8zAwdR9zJApLSbLj1O4Gf09uONCJof
X-Received: by 10.182.128.234 with SMTP id nr10mr5657442obb.0.1400175005883;
        Thu, 15 May 2014 10:30:05 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id h18si274172yhj.0.2014.05.15.10.30.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id B192F5A42E3;
	Thu, 15 May 2014 10:30:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 5F78BE11CC; Thu, 15 May 2014 10:30:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249122>

ref_transaction_create|delete|update has no need to modify the sha1
arguments passed to it so it should use const unsigned char* instead
of unsigned char*.

Some functions, such as fast_forward_to(), already have its old/new
sha1 arguments as consts. This function will at some point need to
use ref_transaction_update() in which case this change is required.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 7 ++++---
 refs.h | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 6898263..2114748 100644
--- a/refs.c
+++ b/refs.c
@@ -3338,7 +3338,8 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
 
 void ref_transaction_update(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *new_sha1, unsigned char *old_sha1,
+			    const unsigned char *new_sha1,
+			    const unsigned char *old_sha1,
 			    int flags, int have_old)
 {
 	struct ref_update *update = add_update(transaction, refname);
@@ -3352,7 +3353,7 @@ void ref_transaction_update(struct ref_transaction *transaction,
 
 void ref_transaction_create(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *new_sha1,
+			    const unsigned char *new_sha1,
 			    int flags)
 {
 	struct ref_update *update = add_update(transaction, refname);
@@ -3366,7 +3367,7 @@ void ref_transaction_create(struct ref_transaction *transaction,
 
 void ref_transaction_delete(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *old_sha1,
+			    const unsigned char *old_sha1,
 			    int flags, int have_old)
 {
 	struct ref_update *update = add_update(transaction, refname);
diff --git a/refs.h b/refs.h
index 09ff483..6d97700 100644
--- a/refs.h
+++ b/refs.h
@@ -245,7 +245,8 @@ void ref_transaction_rollback(struct ref_transaction *transaction);
  */
 void ref_transaction_update(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *new_sha1, unsigned char *old_sha1,
+			    const unsigned char *new_sha1,
+			    const unsigned char *old_sha1,
 			    int flags, int have_old);
 
 /*
@@ -256,7 +257,7 @@ void ref_transaction_update(struct ref_transaction *transaction,
  */
 void ref_transaction_create(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *new_sha1,
+			    const unsigned char *new_sha1,
 			    int flags);
 
 /*
@@ -266,7 +267,7 @@ void ref_transaction_create(struct ref_transaction *transaction,
  */
 void ref_transaction_delete(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *old_sha1,
+			    const unsigned char *old_sha1,
 			    int flags, int have_old);
 
 /*
-- 
2.0.0.rc3.477.g0f8edf7
