From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 03/48] refs.c: constify the sha arguments for ref_transaction_create|delete|update
Date: Thu, 12 Jun 2014 10:20:54 -0700
Message-ID: <1402593699-13983-4-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:21:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8hC-0006ic-F4
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756276AbaFLRVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:21:44 -0400
Received: from mail-pb0-f74.google.com ([209.85.160.74]:47452 "EHLO
	mail-pb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753117AbaFLRVn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:43 -0400
Received: by mail-pb0-f74.google.com with SMTP id rr13so186342pbb.3
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VXrT3ZGxha5zc6UUNayeA1KtPvsLG20NPYld2Z4Dwlc=;
        b=kGCGXfto3r2E25jc0asMgGo9Y0SiImyH8RXIutW2noXHJU/heRPmlV2R2p0Uxvxqs/
         bwtvmwOs264NPDYkzcBpRTe+tGTF6lWJSx5oeRN4vG8y4omMRc27e+1zxCfjWR9ddzKa
         xyMMXzIQrfMq6cajTAvg7qRPgcOF0BSTMOJQj1ml1tIBGyvfWxQV3zVpZIQ63Oqs+5Le
         Yt04RowokCHlQunpZoHGtgDgAsCYjZY9GExL5hdVYBoXVmXebfC3Uwj4wGp0/yFxOLXp
         r3N+uVBqigb44dabbtly/Rs3RnSF8x7PCbspkFgsc4dtTuFH4MtaO3cSEmZkgK2x83uz
         HSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VXrT3ZGxha5zc6UUNayeA1KtPvsLG20NPYld2Z4Dwlc=;
        b=CZushu6v/M+dud5Y0JwS/hb1xDcL9Czn3Armn+N1+WECiKvUIn/VHiaFOKWZD2vhdC
         2Glkz3PaiMloj5CmFwJapd7gHqUiWr9FjQoBCakjqa8tUtlhnWUreH8HTG1mi/x0PoWk
         68cvLxKcoyZ1acetaLYDwuN2WKi1d7md5YTmUJtO/K8/th45A8og0FuiFiCUdpoJPpuV
         JCNFfpaRQWsTRv9DIuyzmHUJfHkTnCN0sGg05iEFodCPg4Bd0oPVwoxkgA23ARda0HgL
         9xj+ga5Uclcg7Oe/HJR6MpV9XUVCShw+k5gJAHKKKsJ/z0qwVkpmnIqH2xmN1XIYaoC8
         3XZg==
X-Gm-Message-State: ALoCoQm1skR2AnkrhaTHP7FGXzhG2bKNR5aUeCfWg/FRishYOF/W5/osfM2V+Vm0aFEiwP8Ibh8c
X-Received: by 10.67.23.41 with SMTP id hx9mr4300548pad.8.1402593702842;
        Thu, 12 Jun 2014 10:21:42 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c22si113419yhe.1.2014.06.12.10.21.42
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:42 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id A6A665A4743;
	Thu, 12 Jun 2014 10:21:42 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 541B0E0961; Thu, 12 Jun 2014 10:21:42 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251417>

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
2.0.0.599.g83ced0e
