From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 01/11] refs.c: constify the sha arguments for ref_transaction_create|delete|update
Date: Thu, 17 Apr 2014 12:46:17 -0700
Message-ID: <1397763987-4453-2-git-send-email-sahlberg@google.com>
References: <1397763987-4453-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 17 21:46:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WasGi-000379-AI
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 21:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbaDQTqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 15:46:40 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:32774 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbaDQTqe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 15:46:34 -0400
Received: by mail-pb0-f73.google.com with SMTP id rp16so110028pbb.2
        for <git@vger.kernel.org>; Thu, 17 Apr 2014 12:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G6PtrVcIdRoiV6YJJBIHwH20s73++6UzYxpDbo+VjN4=;
        b=Bq92guBjPnB3IK4Nejrw054ii1VPBkTq4BHOujhB/K1vbEZqh0xYLDeKhIpmc8Zut1
         fjaSWgAEtaZk/8qlgvz4Hq5+EzG0GGzcjI9quVRazzS9FTH4r3BHx0Q8hECeNsaJUYQ8
         5TP6uQRTf3Q9xo5k1eYw0JXt1jPhQ3kpXf9wr3/7F6xqfQ/WyIbdZNc2LKMV7dJq5bDS
         8bFEGBVApvWJ6jmLoCDZiQFnqibjpfNONMNP3ss3TTMvbfvcy2S583y+w546aNB1P+4o
         bbAOdd/KPrvLcr1rEOJOkQa+Y7dDU+lHUflXrBSeB8RDQxy8DAhHoHC1XgNsIUH2qEFn
         fPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G6PtrVcIdRoiV6YJJBIHwH20s73++6UzYxpDbo+VjN4=;
        b=W4ysNuwaOihCa6xk9Y8VhdJTx1LbtLGBoic+oEvAth0L8Ci2/BanZ0ezpkaolI9j9h
         6yV0Esi9NDieY2Ijp0MZiUZUECrZdsJLliWFDApCQ+m9c5NDnKEpAmzd65wTfkAUmet7
         HXcGfbwDGuDpjIjSpHylt2ZTmihXvRGpry+gpRHMetnch/7S7XWelv7S7000skjhA6K2
         MtVx+1qY/qRCeqaNPBhy/L0e2Gqg5sqYcT0vtbMxQpdbltUWuPUzBt21URuqkWtYQwnj
         zBM8pn49JvLG1XFwW0rOUtAW9NgFw7HxR6s/wK6pmNjAjtIommlGsveP/oZPgkifBgvt
         Z2hg==
X-Gm-Message-State: ALoCoQnvJppE3XpQWUnD9+uiRjiBfyXZ30wV8u9ka/CGI5i3M+AuaOY0n0v76Stfk6tfX+oR1ovpo+c8xB+6x2QjNkkX8Y8sOx/ox36u3UiUfn8qpQwQjc5kD+6RZ41rPX7dbI236xmrWkehjRlKw85gu0Lx7KEjhcYly7iXgzcHS3edtcm6J5bivyTZ1Z4YEBjupC2yQwTN
X-Received: by 10.66.251.70 with SMTP id zi6mr4517602pac.37.1397763993547;
        Thu, 17 Apr 2014 12:46:33 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id x22si3653219yhd.5.2014.04.17.12.46.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Apr 2014 12:46:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 5C7FA5A4252;
	Thu, 17 Apr 2014 12:46:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 1918BE0967; Thu, 17 Apr 2014 12:46:33 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.513.gd486896
In-Reply-To: <1397763987-4453-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246438>

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
index 728a761..138ab70 100644
--- a/refs.c
+++ b/refs.c
@@ -3329,7 +3329,8 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
 
 void ref_transaction_update(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *new_sha1, unsigned char *old_sha1,
+			    const unsigned char *new_sha1,
+			    const unsigned char *old_sha1,
 			    int flags, int have_old)
 {
 	struct ref_update *update = add_update(transaction, refname);
@@ -3343,7 +3344,7 @@ void ref_transaction_update(struct ref_transaction *transaction,
 
 void ref_transaction_create(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *new_sha1,
+			    const unsigned char *new_sha1,
 			    int flags)
 {
 	struct ref_update *update = add_update(transaction, refname);
@@ -3357,7 +3358,7 @@ void ref_transaction_create(struct ref_transaction *transaction,
 
 void ref_transaction_delete(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *old_sha1,
+			    const unsigned char *old_sha1,
 			    int flags, int have_old)
 {
 	struct ref_update *update = add_update(transaction, refname);
diff --git a/refs.h b/refs.h
index 0f08def..892c5b6 100644
--- a/refs.h
+++ b/refs.h
@@ -239,7 +239,8 @@ void ref_transaction_rollback(struct ref_transaction *transaction);
  */
 void ref_transaction_update(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *new_sha1, unsigned char *old_sha1,
+			    const unsigned char *new_sha1,
+			    const unsigned char *old_sha1,
 			    int flags, int have_old);
 
 /*
@@ -250,7 +251,7 @@ void ref_transaction_update(struct ref_transaction *transaction,
  */
 void ref_transaction_create(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *new_sha1,
+			    const unsigned char *new_sha1,
 			    int flags);
 
 /*
@@ -260,7 +261,7 @@ void ref_transaction_create(struct ref_transaction *transaction,
  */
 void ref_transaction_delete(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *old_sha1,
+			    const unsigned char *old_sha1,
 			    int flags, int have_old);
 
 /*
-- 
1.9.1.513.gd486896
