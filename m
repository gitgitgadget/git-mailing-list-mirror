From: David Turner <dturner@twopensource.com>
Subject: [PATCH 13/24] resolve_ref_1(): eliminate local variable "bad_name"
Date: Thu,  7 Apr 2016 15:03:00 -0400
Message-ID: <1460055791-23313-14-git-send-email-dturner@twopensource.com>
References: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Apr 07 21:03:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoFDW-0007CX-D0
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 21:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbcDGTDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 15:03:39 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:33147 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932302AbcDGTDf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 15:03:35 -0400
Received: by mail-qg0-f43.google.com with SMTP id j35so71759112qge.0
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 12:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=TeeiX6bkm4kruqVa/aKJtnV3H8ScMQS8fKPvaaJL8rY=;
        b=rrqygWt9Ltjpqa9FYzbBl9ZEaPOHg1ebaek1tZRXiVHAM3/rvam/1HMg5kg7PqzRm4
         7Fj21eXQ9o9DbMXxaw9o6RsS/u8y6S5w4EdPqn5LAcSdVt+Y3Bq7muQb0vAgiRGJZBcC
         yVMWXsd7iUzkhGsmvkw6DnsOyoHKczP6ACtAzegypop4TEOPuPzNj1+GxFGqcE5mv+oP
         jrm5jBmkocmiQU2IiE/2EmVT00FN5autgQo16gRqLuRGdPKS2dSdLVuPliD7e0ak/M+0
         fJgBvf4pLhm0FBtZMM74Zi4B2uGLFhmKlUz1SByznHWSqWeoU9Pxzz4kHw4l7SL+Ohf0
         37Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=TeeiX6bkm4kruqVa/aKJtnV3H8ScMQS8fKPvaaJL8rY=;
        b=HfuQ6zD/GQIS2qB67Pcwydp+uB9IYZ1akEAR5Vp3nXz/uL31BMk4BfXwUJXxAObzfq
         CJZNgJn0InbEKkVzC4E8x06uXcbnscpeh7wvYWwcRqRxVg8ga1KEm+GtWw+JagusxPDR
         +ZlhqBOSOOEUXfCfG8Tg23sQQkW743SJtw2/FOk+JCs2xukAvkWOfPuKGmx5uMAP3nLV
         S54MpgDmx+mD54OhHEZS8lwgMubIWO3kzVQpy+Kzf7H0lSQBlu8i415wLEXDaKUzsBLH
         43qPlw8wPAmenEcgCQ4kboasnMaamDHlOvIUGj7oQyi3l8dKB7w3/QSSr+rsmd7Ta9v/
         jMlQ==
X-Gm-Message-State: AD7BkJJ9muy3hrd4ZEMnf8/Juuppjyd9Voaaaa9aZBpZ97rd6nV7lV0FC753DJ9TxdL70Q==
X-Received: by 10.140.170.70 with SMTP id q67mr6543761qhq.8.1460055814425;
        Thu, 07 Apr 2016 12:03:34 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e11sm3959273qkb.39.2016.04.07.12.03.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2016 12:03:33 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290961>

From: Michael Haggerty <mhagger@alum.mit.edu>

We can use (*flags & REF_BAD_NAME) for that purpose.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 60f1493..b865ba5 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1399,19 +1399,17 @@ static const char *resolve_ref_1(const char *refname,
 				 struct strbuf *sb_path,
 				 struct strbuf *sb_contents)
 {
-	int bad_name = 0;
 	int symref_count;
 
 	*flags = 0;
 
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
-		*flags |= REF_BAD_NAME;
-
 		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
 		    !refname_is_safe(refname)) {
 			errno = EINVAL;
 			return NULL;
 		}
+
 		/*
 		 * dwim_ref() uses REF_ISBROKEN to distinguish between
 		 * missing refs and refs that were present but invalid,
@@ -1420,7 +1418,7 @@ static const char *resolve_ref_1(const char *refname,
 		 * We don't know whether the ref exists, so don't set
 		 * REF_ISBROKEN yet.
 		 */
-		bad_name = 1;
+		*flags |= REF_BAD_NAME;
 	}
 
 	for (symref_count = 0; symref_count < MAXDEPTH; symref_count++) {
@@ -1452,7 +1450,7 @@ static const char *resolve_ref_1(const char *refname,
 				}
 				hashclr(sha1);
 			}
-			if (bad_name) {
+			if (*flags & REF_BAD_NAME) {
 				hashclr(sha1);
 				*flags |= REF_ISBROKEN;
 			}
@@ -1524,7 +1522,7 @@ static const char *resolve_ref_1(const char *refname,
 				errno = EINVAL;
 				return NULL;
 			}
-			if (bad_name) {
+			if (*flags & REF_BAD_NAME) {
 				hashclr(sha1);
 				*flags |= REF_ISBROKEN;
 			}
@@ -1548,8 +1546,7 @@ static const char *resolve_ref_1(const char *refname,
 				return NULL;
 			}
 
-			*flags |= REF_ISBROKEN;
-			bad_name = 1;
+			*flags |= REF_ISBROKEN | REF_BAD_NAME;
 		}
 	}
 
-- 
2.4.2.767.g62658d5-twtrsrc
