From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 03/48] refs.c: constify the sha arguments for ref_transaction_create|delete|update
Date: Tue, 17 Jun 2014 08:53:17 -0700
Message-ID: <1403020442-31049-4-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:58:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwvlz-0008RR-I7
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933628AbaFQP6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:58:05 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:37081 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756164AbaFQPyF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:05 -0400
Received: by mail-qc0-f201.google.com with SMTP id c9so1026714qcz.4
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+X7PnZ9zfORPEv80A5adDDnegFL90sY+Gk8TBRe832Y=;
        b=WwhI+2DjpP1gys6C9NDyfL4IVjeVAUDy97KYUo8SQJ9+Zfu8kUfQVlrI+E79q3DWiV
         HEnDfwZhaLTKcFH74xSNaHZWmvWB0/CHGoKUb6OSyVazJ4tafnrUj/wYDK2E8N8elz4t
         I8aNdeVXxbFxhjEpKdS4KikaFmFRP0g/W3bizU6ihpjm7K+Br03STp3vkkzNVEyz+D03
         h054MyN9mQuqpHOOrbR6+N8Jf5KBNm941cYVXmSalqPQeKFWfnOBpfhO+h6gZ+Zk0F64
         jKpZ863zbbUTekg2REmBBO92cRoZ6jirfsdRG0TD5MUsUDVmGsqXSlK53kTihgIQwjqb
         S+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+X7PnZ9zfORPEv80A5adDDnegFL90sY+Gk8TBRe832Y=;
        b=AG4J7cBD0bGKjBYlIqUc/akJSU6ZEZ60syZgFlONOQDjfBCXkL9uPb8WCSa0Bjaf3U
         2NzV3JnoQAcSoXdA9THviKKLGpS/vuxxmXGwoij5qFHgswNWwMijx3MJOwYJmoXBwLeV
         ebu4wNucLxFEz6RvdkQh2CGk6OBtUKrmuxVsHya4WHwkT4zIT5nnCseCafnLK3d91TqF
         X8/6Xsts9Pxk73c6yD/2555yzJ7PoP3UXk+fQYksNpYumIkmwJ28Fd8E5GuLitVZWSqS
         IQOdAh/0PCXLb8x7HcyKBObHJ+dbotwKfT9Fq4avD94AAYRejvh6PqW03AKiPBhLbstp
         t2iw==
X-Gm-Message-State: ALoCoQnLR2tLcvdCKvAwHi9LEKz8PoUhxwJHwYWW1l+ojpgTctFQgiy8pkcLjJKA5MClxKKQfV6r
X-Received: by 10.224.70.10 with SMTP id b10mr68078qaj.8.1403020444463;
        Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si1209152yhb.3.2014.06.17.08.54.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 4CD1D31C76B;
	Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id DE376E10DE; Tue, 17 Jun 2014 08:54:03 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251916>

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
2.0.0.438.gec92e5c
