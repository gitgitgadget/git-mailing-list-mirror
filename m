From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 01/44] refs.c: constify the sha arguments for ref_transaction_create|delete|update
Date: Thu, 15 May 2014 16:14:58 -0700
Message-ID: <1400195741-22996-2-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:16:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4sZ-0003xd-Qq
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756057AbaEOXPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:15:46 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:44776 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755094AbaEOXPo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:44 -0400
Received: by mail-oa0-f74.google.com with SMTP id m1so390600oag.1
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=asIcwn3iNVmhwxwe6KTgPTWDR19j04ekquGBFrumW7w=;
        b=X/3Sq1UsTemnOXhRZ+0LfqH85axb2jx8q8bcO7KP0aYPIfsxxgQZPGmMVX2Mnuf+04
         saWIMo43jlnrE69kLcRBpKE/nd5u8xMUQIxqBLBfZniD6OmxuhFP7kvKKZya+euhmjZn
         II17kPJ45H3k+omqLPkQrm4ZNjali6IvpMU+fkNvdISfN2WLri888qUkDyYlXgoBBOLn
         MfnU06j9OqCdiZa2/gLJONioM63tLf3nAxw9Xgw75UIhqOCrXmlHNdcP37QydBMIdStN
         M11oJE/5gTXGhFUC//IAkkh2BQH/V2lqTWqWVzUBaC34E4Jbt6TT14ua6/Ah+4+tTUYT
         Sw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=asIcwn3iNVmhwxwe6KTgPTWDR19j04ekquGBFrumW7w=;
        b=VSYLUn7s4DTGwVR22K/Kv3CsH33RNPw6C8lVOJgLAlxohNvF6rwGe7U4w5YRs2Ostq
         NC7B7H48XU2NrsMCYRnMzOlBDj+xEvq7q1864e2JhBUb2xTmPJEziWyFiSp1pU8fquI9
         IudEZHjIjnT6ogZuiYrImJajnZsONREOpDpiZMQ/D+weo2GftLMZvUCYa5qz0SB2SuIf
         BabsVNnyJunp5YAib+6u8ezmuC7CyrE88z6+awGExuCpbakrvJwe1qLaH0QjOfsCF/eB
         LjK7ZIIxI2O9Ws101bGKFdLj7zYaz3jTiH53nnYHADfdOMXWDJegkilKNmkzSAe9MH4e
         OHzw==
X-Gm-Message-State: ALoCoQnV9iW8PE3rP1EJxb9fm3QxDKKAlOEFbRRO+VefwX3X5btvyKhzYDm55no0dekWj+4Gc0jk
X-Received: by 10.182.60.37 with SMTP id e5mr6580592obr.30.1400195744395;
        Thu, 15 May 2014 16:15:44 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r79si319186yhj.2.2014.05.15.16.15.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:44 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 408C431C1ED;
	Thu, 15 May 2014 16:15:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id DE47BE0475; Thu, 15 May 2014 16:15:43 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249222>

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
2.0.0.rc3.477.gffe78a2
