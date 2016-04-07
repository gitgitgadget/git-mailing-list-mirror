From: David Turner <dturner@twopensource.com>
Subject: [PATCH 09/24] resolve_ref_unsafe(): use for loop to count up to MAXDEPTH
Date: Thu,  7 Apr 2016 15:02:56 -0400
Message-ID: <1460055791-23313-10-git-send-email-dturner@twopensource.com>
References: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Apr 07 21:04:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoFEa-0007wR-K1
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 21:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbcDGTDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 15:03:33 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:34974 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932219AbcDGTDb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 15:03:31 -0400
Received: by mail-qg0-f48.google.com with SMTP id f105so47943110qge.2
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 12:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=yskC0bgC1diwKqqn4xwkiPvPX5MC4w06Q15YjyusbIQ=;
        b=xPLLLlKEUqCG7Iah/5EVlRwh7mWHuHEVTwJ/zOMpbxi2LWsXdPVA/QE42Kn/UIsn6s
         1x4mPjGNkJfBWLznKtujMI2lQXOZPFKcL00jypmQGzsaPkzYxyx7bPSn4KseL7vFGyz4
         egmcTSQdhd5fDF/vs8wJCa52ZYyW+aBuhHvX2AeMzVBIgBZrnRoQkV12T5oxL75VMxD6
         C0EEjkEhR8tdxhHAckY+qcflcPXL521u5bZGbXMixFevhT79uMRqP5VpOh7kH1BfRkXU
         vPg2KKtTx8u6ja4yswoUyamZhNkeEgP/sUwB1usDdGsihONIqcSFTXI8EdYPEpXoIkpN
         JBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=yskC0bgC1diwKqqn4xwkiPvPX5MC4w06Q15YjyusbIQ=;
        b=g/TCWStyM4Qr37XFoMGF2Z4A+JcJs9ELCb3f+YNGLbZ9+Qg+fiXxmXXXdalFwX7yj0
         fxrR8D60TfBP3phz3z9Wv3thjIwUtf+/Feh6nq72JRQ/R3oKRfV3k8+bhYwV8hcT6VdH
         wymG5a+eqNs7JhLspBvYqrGziKZDGxTlodh3dovp7AOM0N9GKFsdna8uYNr3o1VlD9Dp
         oDEQSsxxN3hewXgx7pM5PxYxMqZentJaw36BkRXuD2/3YrLvIFRXat4VUi6MVPobl9Tj
         /6ss//9J78+D4Yp9xgxxJi5LqjTR62tQVWyJ81OgJZMJ2NnwPkh3Phu2UX1JaT2GkdY7
         9OdQ==
X-Gm-Message-State: AD7BkJJquauzJMwzfQdiSHFb8EEjbNBqwYo8+GOq2oo/34CzJP8mR+54CALAwncocHsleQ==
X-Received: by 10.140.19.211 with SMTP id 77mr6092857qgh.43.1460055810670;
        Thu, 07 Apr 2016 12:03:30 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e11sm3959273qkb.39.2016.04.07.12.03.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2016 12:03:30 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290973>

From: Michael Haggerty <mhagger@alum.mit.edu>

The loop's there anyway; we might as well use it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index c0cf6fd..101abba 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1400,8 +1400,8 @@ static const char *resolve_ref_1(const char *refname,
 				 struct strbuf *sb_path,
 				 struct strbuf *sb_contents)
 {
-	int depth = MAXDEPTH;
 	int bad_name = 0;
+	int symref_count;
 
 	if (flags)
 		*flags = 0;
@@ -1425,17 +1425,13 @@ static const char *resolve_ref_1(const char *refname,
 		 */
 		bad_name = 1;
 	}
-	for (;;) {
+
+	for (symref_count = 0; symref_count < MAXDEPTH; symref_count++) {
 		const char *path;
 		struct stat st;
 		char *buf;
 		int fd;
 
-		if (--depth < 0) {
-			errno = ELOOP;
-			return NULL;
-		}
-
 		strbuf_reset(sb_path);
 		strbuf_git_path(sb_path, "%s", refname);
 		path = sb_path->buf;
@@ -1566,6 +1562,9 @@ static const char *resolve_ref_1(const char *refname,
 			bad_name = 1;
 		}
 	}
+
+	errno = ELOOP;
+	return NULL;
 }
 
 const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
-- 
2.4.2.767.g62658d5-twtrsrc
