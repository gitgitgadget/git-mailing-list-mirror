From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 03/12] refs.c: add an err argument to delete_ref_loose
Date: Wed, 16 Jul 2014 15:23:03 -0700
Message-ID: <1405549392-27306-4-git-send-email-sahlberg@google.com>
References: <1405549392-27306-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 00:23:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7Xbd-0004B9-Su
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 00:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754276AbaGPWXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 18:23:18 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:37577 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816AbaGPWXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 18:23:16 -0400
Received: by mail-ie0-f202.google.com with SMTP id rl12so476581iec.1
        for <git@vger.kernel.org>; Wed, 16 Jul 2014 15:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W9VnJG8GFkiZJG97quoHH0N0wd5X5ZE3hX0oHjQ06TE=;
        b=cfjWu1IbX/1pYo5tiscsYO2NEhbVd0UydXw7b4j0BV1wZvuJWANrwEcnQc98k91p8x
         M2dlqlXAhLPEEK0a1D/0AX60nZMX0UjswMRa1vBrtjKQx8ru/wJs5ebwGL1s9Hoe4vRB
         t0jBWAEyyZSmmXt/d7AuZlRVTdhDAtSM44CsXyBE58zRaYQp5rJKNQ9DQPkdBuUS8vSG
         3qDu8ucJ0S+KKAnnMZm3/ZacuF9Yz2RQX2udVrhNW5Fd7LVXQQi7O8ZjdkNMaVUFQX5e
         Dxd0KCQ1bMGVz5PPUmcdYqe9uU+mVc8J1Dfx2rpy9eHt+y6QCFkUw1HkPRmmZEyHXaEt
         RAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W9VnJG8GFkiZJG97quoHH0N0wd5X5ZE3hX0oHjQ06TE=;
        b=RtfsB9h1f5tFrxuhSKS/qv58rSGoTfghS8gdBgrIz/WPmVbd4VQwAVlkfvUGUaml5/
         xbH6jMfM5F/JMhGbcGfQgucnmr8HtRyDQzPlUI04hE4stWwQAEh6+Ss3AI8y0PkpXAq9
         1AyP/q5JJRfL4Idni9L+mczK9KFuhJpzNjc+OLVLc4UBlrWkjyt/jCmqMD/EbYaLb8cN
         0KndHMq6VysBmBdWMXsj6WHtwpsaM+O213CKJryq34IC+VJRbWXTyCFRanWGbm9jiOgR
         8i2XciG5rAl7AEXfa6/UWIJt+mIfreZwa1s50wX45u7VN2XbnQSwbwKOfJHACu2yEhtW
         PDRQ==
X-Gm-Message-State: ALoCoQkb6knJUuRzqx86b8DFcIs7kKdgMG87zzmmFimlArvg8jyzzb2ALuP5CQYOCRMuEonH0G9Z
X-Received: by 10.182.128.234 with SMTP id nr10mr16603562obb.0.1405549395712;
        Wed, 16 Jul 2014 15:23:15 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id v44si75896yhv.0.2014.07.16.15.23.15
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jul 2014 15:23:15 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 8E7A431C1A1;
	Wed, 16 Jul 2014 15:23:15 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 3D2B2E0700; Wed, 16 Jul 2014 15:23:15 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.527.gc6b782e
In-Reply-To: <1405549392-27306-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253701>

Add an err argument to delete_loose_ref so that we can pass a descriptive
error string back to the caller. Pass the err argument from transaction
commit to this function so that transaction users will have a nice error
string if the transaction failed due to delete_loose_ref.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 0017d9c..24f9546 100644
--- a/refs.c
+++ b/refs.c
@@ -2544,16 +2544,16 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 	return ret;
 }
 
-static int delete_ref_loose(struct ref_lock *lock, int flag)
+static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 {
 	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
 		/* loose */
-		int err, i = strlen(lock->lk->filename) - 5; /* .lock */
+		int res, i = strlen(lock->lk->filename) - 5; /* .lock */
 
 		lock->lk->filename[i] = 0;
-		err = unlink_or_warn(lock->lk->filename);
+		res = unlink_or_msg(lock->lk->filename, err);
 		lock->lk->filename[i] = '.';
-		if (err && errno != ENOENT)
+		if (res)
 			return 1;
 	}
 	return 0;
@@ -3602,7 +3602,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (update->lock) {
-			ret |= delete_ref_loose(update->lock, update->type);
+			ret |= delete_ref_loose(update->lock, update->type,
+						err);
 			if (!(update->flags & REF_ISPRUNING))
 				delnames[delnum++] = update->lock->ref_name;
 		}
-- 
2.0.1.527.gc6b782e
