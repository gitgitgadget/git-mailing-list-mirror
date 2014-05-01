From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 01/42] refs.c: constify the sha arguments for ref_transaction_create|delete|update
Date: Thu,  1 May 2014 13:37:01 -0700
Message-ID: <1398976662-6962-2-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:37:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfxjs-0000Sy-G5
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752237AbaEAUhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:37:48 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:42108 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990AbaEAUhp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:45 -0400
Received: by mail-qc0-f201.google.com with SMTP id c9so545753qcz.2
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VHeFUH4QOy8gZXe3tV0DA2F74LRIySWF3Mv1JET/Y+E=;
        b=hUIIdESRKb5bHeL9B0g28EO8A5DHSldc2clOMau6VytQENRDLj+X8Va60lRaZKdo+4
         qtQA7fjAZnxQdJ57DuFEF5rx4+ZfsdpRIPZdvM/65K5wEQ4zmGWGJVVblWgwrVuWbQtg
         6nIWykZH/hkRO0F9iQ9W4xmtibQ4+FNd86Y/fzThOdGfavit+KVtCWyCviCr04wAgpvo
         wVY34wVighpO/ZPf4fLxcwwIxK3ZMlgmuuEDxwXhhv65Ryc77z5VAhakdn3G3R/bwPIa
         LkS5pSoPjGjtsHbvXgiC5pH35yplBCy6bMNVVJAiRagLaUQu1jQdcVVNO/E9mFBfmjZR
         kpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VHeFUH4QOy8gZXe3tV0DA2F74LRIySWF3Mv1JET/Y+E=;
        b=W8L9LgYemRkXozsuEvqTutqQgS3xjMLhq6j1yyuPcQAODMD9oo3j/WjfbSw7p0mu5o
         3U6h7e0Iu9mrzENHcWdb2haEbD78stArXtUDyDCPJE4u2uyr5wRqxaWojAK2bVT5sN2J
         VYUcVFXcJMnusFj1fRRHEzZeB21gY5Wm1moWv+njKgFvD0p1QraEQpBoneMVHLQqEmSW
         IxJGKtt+VPKRW4lCACqntSOmSjLWO586fKOEpAF6Rw0vx2chdIiM8M5vjdZ0+U9JnVZv
         GBxjx3khc+L7XfeRu/7tODVMn5Wra/IQXd/PyHhD9U0ZdKUCTlF3AfkbeCs29klXMu5T
         AMIw==
X-Gm-Message-State: ALoCoQn/ME7Z1b7kd401oZRUYl7ZmhNnLU/aDpGP18I5cxvszWCv3CL4edFS4A7z5ppLndJSwm9v
X-Received: by 10.236.128.112 with SMTP id e76mr6225234yhi.38.1398976664958;
        Thu, 01 May 2014 13:37:44 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si3537613yhk.4.2014.05.01.13.37.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:44 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id CAC3D31C1CC;
	Thu,  1 May 2014 13:37:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 744F2E0A5B; Thu,  1 May 2014 13:37:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247837>

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
2.0.0.rc1.351.g4d2c8e4
