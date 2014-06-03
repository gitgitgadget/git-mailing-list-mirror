From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 03/41] refs.c: constify the sha arguments for ref_transaction_create|delete|update
Date: Tue,  3 Jun 2014 14:37:21 -0700
Message-ID: <1401831479-3388-4-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:38:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwPP-0005MX-R1
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934333AbaFCViM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:38:12 -0400
Received: from mail-pd0-f202.google.com ([209.85.192.202]:45274 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934040AbaFCViH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:07 -0400
Received: by mail-pd0-f202.google.com with SMTP id fp1so706323pdb.5
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/GC4cP7EMpkdK8o0KGA6riNOVIXwLCH0vMTv1c5xrNc=;
        b=MGguTrUqDrcGVNolphhKShVxlc/3Ht/dtbb44r90NF1g9RP06pcuur5t2d2n0LgNkQ
         WuCSGMq/NqhI45liVCRuaamMuNBPDBb9bUNsmrdkHnNaZvg/JLbuyit7S4Cubv2GJfz+
         TOOWbARn5aH9btFC+KNtKJ74E7NilOdefuXKYv8P0+1hgw9VQsLOCjwzdQbzSdW97BN8
         29p2tLl28QdQbgewt2UEMZZjoibdoFu1HfAWyf87ydgeFemi0Col2E1pmvyj21SlrwcR
         N2GcEzK23tCgCeKl9ppqOOJ4HIoiikHDScXJV6Iwj6nPol+RblLOcDQEbr+27aq8i6zE
         BhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/GC4cP7EMpkdK8o0KGA6riNOVIXwLCH0vMTv1c5xrNc=;
        b=irM1D9yRUtbrn77+Jp/wSxYssxMpusQMah+FgTvUsn9nW+F/xMz6RXa/Gy5CBAF5wv
         rE+xf4gOByprUMFglL4KFcjqSlkthMkFDJWZbkcrUSVvCb2U1OmZko8oIXVCWoCaRkiQ
         1eMTKs02jzw9MN+djQZxQ4Jjxcpd5ICkFEVfbj78J19vdYA4yMD1IZap8Tv5KP40raN2
         qoNTE4s3fCJydy3ggkeTxFVKlwe1G1f0z/aOnnWuxQjqOSAIvrkPb2Hvh5l2nHNVkFh/
         c7/mEBVj2mEekMoo+Xkmk3UvZUJ9qWyMXUYm17awIqQ7k0JaNslVIgwqH4tnUJ5FRlO6
         P3MQ==
X-Gm-Message-State: ALoCoQns3nBp7+5nz+wfiKekIzKnNH7B6SvyEoiu2kaaEpaQNFMQM2w5W9F370yNIfPj6EwDInup
X-Received: by 10.68.133.138 with SMTP id pc10mr17442684pbb.5.1401831486941;
        Tue, 03 Jun 2014 14:38:06 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c22si30640yhe.1.2014.06.03.14.38.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id BBA7431C425;
	Tue,  3 Jun 2014 14:38:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6B99EE043A; Tue,  3 Jun 2014 14:38:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250649>

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
index 33541f4..a767ef6 100644
--- a/refs.c
+++ b/refs.c
@@ -3333,7 +3333,8 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
 
 void ref_transaction_update(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *new_sha1, unsigned char *old_sha1,
+			    const unsigned char *new_sha1,
+			    const unsigned char *old_sha1,
 			    int flags, int have_old)
 {
 	struct ref_update *update = add_update(transaction, refname);
@@ -3347,7 +3348,7 @@ void ref_transaction_update(struct ref_transaction *transaction,
 
 void ref_transaction_create(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *new_sha1,
+			    const unsigned char *new_sha1,
 			    int flags)
 {
 	struct ref_update *update = add_update(transaction, refname);
@@ -3361,7 +3362,7 @@ void ref_transaction_create(struct ref_transaction *transaction,
 
 void ref_transaction_delete(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *old_sha1,
+			    const unsigned char *old_sha1,
 			    int flags, int have_old)
 {
 	struct ref_update *update = add_update(transaction, refname);
diff --git a/refs.h b/refs.h
index 306d833..b893838 100644
--- a/refs.h
+++ b/refs.h
@@ -237,7 +237,8 @@ struct ref_transaction *ref_transaction_begin(void);
  */
 void ref_transaction_update(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *new_sha1, unsigned char *old_sha1,
+			    const unsigned char *new_sha1,
+			    const unsigned char *old_sha1,
 			    int flags, int have_old);
 
 /*
@@ -248,7 +249,7 @@ void ref_transaction_update(struct ref_transaction *transaction,
  */
 void ref_transaction_create(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *new_sha1,
+			    const unsigned char *new_sha1,
 			    int flags);
 
 /*
@@ -258,7 +259,7 @@ void ref_transaction_create(struct ref_transaction *transaction,
  */
 void ref_transaction_delete(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *old_sha1,
+			    const unsigned char *old_sha1,
 			    int flags, int have_old);
 
 /*
-- 
2.0.0.567.g64a7adf
