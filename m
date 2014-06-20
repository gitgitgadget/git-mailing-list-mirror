From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 03/48] refs.c: constify the sha arguments for ref_transaction_create|delete|update
Date: Fri, 20 Jun 2014 07:42:44 -0700
Message-ID: <1403275409-28173-4-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:44:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy02w-0001No-Pb
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468AbaFTOnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:43:41 -0400
Received: from mail-qg0-f73.google.com ([209.85.192.73]:50920 "EHLO
	mail-qg0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131AbaFTOnd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:33 -0400
Received: by mail-qg0-f73.google.com with SMTP id q107so168117qgd.2
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nBFbl5qSSJMVp6lWvnWRO7jhdv4hxxzz4G8KBJH66J8=;
        b=AlRRV2Rr5f9Uir04KNif2TLwIqIf1Ge844aGCLi5AElYkQL7Q4AzYME7pjDO/bMob+
         9YdTH9KcccAZbzh5RBTu2tHMjhVzt40JRnVqmfEGizbrDcT+boj6g9n/R98e/hBCLjqI
         7BWFsxrE7WrWOEVXB+HEROqcyS7zJu3gDTtzoqmQCfZn3IKCPSOMh9iuFv3IymRM/vhR
         qGITxpY+5aFlUHqNJCP5WLEZ39CHs28OmvTFLLhJkXh7UgKdrnnWSw4Ko6KWT62pdPkv
         0qAYQv5pMSAyHLYQ3JX4KbBT7nyHEJaS+YT7JUvfi/3jPyo4p7Ab2Y3htU5q5guApPp4
         SQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nBFbl5qSSJMVp6lWvnWRO7jhdv4hxxzz4G8KBJH66J8=;
        b=WeGHMSWSyGHKj+6+hShSQ2xkjBh4BS7WRi/t2lYjkWPmVfT0PQLthDB7oQUlp7Wg/u
         QJ9pR/JVhR4UC2uIalAFE5ndKNcoToTZNyz3CSA9613ru4oMOasB3OdCcQzUdR+ZTIjx
         D9S5kgARI9qOrFUD3hl4zoD/rfM2nTUEBxUEM33MY9+u3FJfTB+kIc/7UhHx5CcV0ojU
         cDm0drPJR2aV0ZGPzs38qoPZLaCh/NRW935jQG0UUmiA1G0JfvLmsAqNwthzxBSAk5qb
         JGmWf2QxlVtFglLPLwa7HvsDPoOwpEHPXT7sej8FKDX+XmO2QsrAKk25YLWrH0GqP5av
         H76Q==
X-Gm-Message-State: ALoCoQm59KOrnj8RmfprIm87lLY/PaTR2oNV0khhOFjWUCyWHA3mcH98HX8ZxuOnTt9qAcgxyVzM
X-Received: by 10.58.94.166 with SMTP id dd6mr1527660veb.12.1403275412072;
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id b39si187827yhj.0.2014.06.20.07.43.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id E7FB65A43E3;
	Fri, 20 Jun 2014 07:43:31 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 95FA9E0769; Fri, 20 Jun 2014 07:43:31 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252235>

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
2.0.0.420.g181e020.dirty
