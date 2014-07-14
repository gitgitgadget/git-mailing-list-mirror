From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v21 03/19] refs.c: constify the sha arguments for ref_transaction_create|delete|update
Date: Mon, 14 Jul 2014 13:58:45 -0700
Message-ID: <1405371541-32121-4-git-send-email-sahlberg@google.com>
References: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 22:59:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6nLB-0002qo-PO
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 22:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757021AbaGNU7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 16:59:08 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:49218 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756734AbaGNU7G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 16:59:06 -0400
Received: by mail-pd0-f201.google.com with SMTP id v10so1031055pde.2
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J1ey/hXebJQY3TKRP1/8KLbV2AS2M1BHJ6QO//el81g=;
        b=NOrIONTTNZcFcuhD6gJ0DD7FutS6+5UsNEJ9I9+LmDf9SsLC3D72EaRuojOodvgw/+
         3FffPIsH4SkFZ7TRKfBg2wkAzPNUs2zeHeUw2JiL/G03JrnebTzsaz5g5mUy6zL5MOy9
         9ppOQj7c9RxbS7piEm37jaoEWjNS4liZehbgmEY3dxS2cRn3xwWXf2FyxJS5n5wwzPka
         G2xSH41XAsvUzM0S37AOkPireRPXz90OYNEr2zQjhV54YvIBUREMa3KglWk2QBI9Oi7D
         AuIhNaHNzieSbngMHgnCTEocrlvYnpMDt5rgiJS0WVL8YPPhKGEezAGvkKLhAacFueOR
         HQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J1ey/hXebJQY3TKRP1/8KLbV2AS2M1BHJ6QO//el81g=;
        b=LiDiTUnajVdaGp8lj3ToH3OTzS3tGUFkb7txc01jvgbQe0Da6nyvKijIdorNe8Fdw6
         ZpnjrSxnDRb9KXrKLJaL/RZvZ4RRIMUjiEC3fyvrpkmqKMT8CqJO8/kbmmCkteCP+3Zp
         cs+TyTDyRMzfDZBLWwG1X4+G9SpBd1jqWA0uaFKiRe6vmgIAzVhsv+RRvnsXTbDttktF
         wOSEfasDIFKvL0rMlM8bJ6DBDM91Kq8vMZ7CM61UkbmGilcqL3RyeVG6q1zh3Nu/WwaX
         o1t0ku1m9sZPvPWYsiuooDRkpA5ufoU0RXdKfnr0Cyy4XMsKqTvVEmIbMrbawQpOm39x
         xZtg==
X-Gm-Message-State: ALoCoQkeCMnEwI/vK6yO+H0DzMO7XCk3a0Qt80vXnL7i1JzzS8JfQlkcHRGLHtIIw3U65bgugx/V
X-Received: by 10.66.231.68 with SMTP id te4mr8933021pac.29.1405371545512;
        Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id v12si822282yhe.2.2014.07.14.13.59.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 51F495A43D4;
	Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 00F1CE07FA; Mon, 14 Jul 2014 13:59:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.546.gf603308
In-Reply-To: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253516>

ref_transaction_create|delete|update has no need to modify the sha1
arguments passed to it so it should use const unsigned char* instead
of unsigned char*.

Some functions, such as fast_forward_to(), already have its old/new
sha1 arguments as consts. This function will at some point need to
use ref_transaction_update() in which case this change is required.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
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
2.0.1.546.gf603308
