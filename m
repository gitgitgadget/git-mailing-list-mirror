From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 01/42] refs.c: constify the sha arguments for ref_transaction_create|delete|update
Date: Wed, 14 May 2014 14:16:35 -0700
Message-ID: <1400102236-30082-2-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:21:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkgc1-0001Ck-0j
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752962AbaENVRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:17:23 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:45133 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770AbaENVRU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:20 -0400
Received: by mail-oa0-f74.google.com with SMTP id m1so40262oag.5
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ha+HFgJWqoUVaoTVwlpa6QI+8LrvQd3mEX+3PlqA0dQ=;
        b=TSY/uDItFhGmSqpfi4GehS34v+obWuGV6wRC8nE2/xdUE5hVgjmPPwgrNuMp8kC4UA
         EJuv+MDtSKkuF+n8lVmtFKv0Id8HN0QtbgxKn+b0Yfugz0Aa83WkluA+mpK7+CFpbGJO
         4iQ2Dtj6Kw0RxnC/WmyGRxCrjI8khfbiljvWYC0i3q52roHYdqRNFzfvkr0QQ3lXkPFV
         pfXVrnOFzicPlNY4MWAhziCg1/pU040b2o9O9mSLqYc5Vni6rttsoQv4GESTYsIcpZJ2
         GrBXW6636//0Dx/wZ1VM/07ibRTTaiJiKQhsAuEPsJpVdAXKsZ/sn8GrRD+UR1GKgDgA
         YbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ha+HFgJWqoUVaoTVwlpa6QI+8LrvQd3mEX+3PlqA0dQ=;
        b=Lwp+dceBdEaxQurC0VEnSPxv1pTR7Mns2kXsq6L5IOMqb++1B9zGltbt4YrcEeIojB
         kBAguM8qqcXs56yL1MLLIHLR+blFgQilJEDXa6L3UD10tjj/dfPRhI0Es1ANeICaoRAw
         ZQYdZn07QwI2oq8J14R5HE9TtoEjfQ7tpPF/fJ1WaQlGcMgU+r8i3uZV07xjFuZIxFib
         DijbC7jn5fpNT46ZuV589lEuk9F3FgpXi4N/ccBpYcXv9awxZCIml+eqBBNDqbfHO6st
         KmpGlEjhMDVDvwWmjbe3uKWklpkmRexsBv//dtlpeC/czzhjidqdV1uAi3Bc6mCSLiuo
         n3Qg==
X-Gm-Message-State: ALoCoQnmaAh/ogt4sEhJ6MiTQZ9n4NVZgvEqqfeXGOEO0oeKlfMoTroNyahXzgRYIAvlBH2CSHBF
X-Received: by 10.50.178.200 with SMTP id da8mr3453728igc.6.1400102239427;
        Wed, 14 May 2014 14:17:19 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si145188yhk.4.2014.05.14.14.17.19
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:19 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 179FF5A4292;
	Wed, 14 May 2014 14:17:19 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id CB0C5E0973; Wed, 14 May 2014 14:17:18 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248989>

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
2.0.0.rc3.471.g2055d11.dirty
