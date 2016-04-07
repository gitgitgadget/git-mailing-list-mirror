From: David Turner <dturner@twopensource.com>
Subject: [PATCH 16/24] Inline resolve_ref_1() into resolve_ref_unsafe()
Date: Thu,  7 Apr 2016 15:03:03 -0400
Message-ID: <1460055791-23313-17-git-send-email-dturner@twopensource.com>
References: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Apr 07 21:04:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoFEE-0007fu-I2
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 21:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbcDGTDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 15:03:43 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:33192 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932215AbcDGTDi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 15:03:38 -0400
Received: by mail-qg0-f54.google.com with SMTP id j35so71760433qge.0
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 12:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=7fYCj1b7RbU6n05rCx0Ay78ObB+ES2rEdBuuVSFfJ+Y=;
        b=oF4avLkpxSWYz+rQ/HDoXYag7j9CG9kEoIF595WhJUS66YC+iTsdrMNWguEgLcqr95
         G7hp2JZMYb5B1omcK+G3A8DQljlW3Z7NrtjpUs3XRyFJJqOtYI0xzaDagERDr0N+elZa
         /IiU/PIJLhjCrNdkUFOvCw3Vz08TteXx3Irpz7zMUkkgaPU+SxfQP5jBeL4E+Qqaa7rd
         5PAbLxPm4pp9RnEEJXDNFWwAXDZWyDaPsdOJkGT8+KtxJjewtNdqAqQ6lU9tnMtmyzGY
         vGgLkrc9xWkC6x4Yd42mCGvsSZTjU1LABsqZ8yzKDO4FJhmg+p+8V5ShUFfwki1dSnuQ
         1gcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=7fYCj1b7RbU6n05rCx0Ay78ObB+ES2rEdBuuVSFfJ+Y=;
        b=PtQd42wNnFr0e4u0Al3xqeRC3XLbysyDZjz/ICREMasommVgYFEPNay9DyeOOgXQzC
         DPkaW9xMTTRWxrW0vI7Tm3oz5P4jtE0WL+z+a/XWDbW9G9vizTD3F7ay7zrj5FgujhaP
         F6+Hjto6mZfPnSSyyqVK6ysYrij+DYZdAFfN2u/NSqrrtPcr441y2wa1y1DXuWQVsxQu
         dCR0zmGS1/BWr90uaC1TJiq5DvEUag4uT06G5zyrMlutbPzU3RBrVPv43lV4tMDpyvEs
         xoLjxaR8pT5FnrRu5Ao+maUzvxjNOAeJ3i/gKOzOvhQNOtw2kMLK91dEUXm9+WG9E45Q
         Wc5w==
X-Gm-Message-State: AD7BkJJa3gOBqNe07oOY6akTyHXmEqAt/QHPDwC/e5Q8SlD25AoIYnDJtZAfiOFcCi5WRA==
X-Received: by 10.140.140.16 with SMTP id 16mr6231772qhm.60.1460055817602;
        Thu, 07 Apr 2016 12:03:37 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e11sm3959273qkb.39.2016.04.07.12.03.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2016 12:03:36 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290968>

From: Michael Haggerty <mhagger@alum.mit.edu>

resolve_ref_unsafe() wasn't doing anything useful anymore.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index f752568..120b2dd 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1539,14 +1539,16 @@ out:
 }
 
 /* This function needs to return a meaningful errno on failure */
-static const char *resolve_ref_1(const char *refname,
-				 int resolve_flags,
-				 unsigned char *sha1,
-				 int *flags,
-				 struct strbuf *sb_refname)
+const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
+			       unsigned char *sha1, int *flags)
 {
+	static struct strbuf sb_refname = STRBUF_INIT;
+	int unused_flags;
 	int symref_count;
 
+	if (!flags)
+		flags = &unused_flags;
+
 	*flags = 0;
 
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
@@ -1570,7 +1572,7 @@ static const char *resolve_ref_1(const char *refname,
 	for (symref_count = 0; symref_count < MAXDEPTH; symref_count++) {
 		int read_flags = 0;
 
-		if (read_raw_ref(refname, sha1, sb_refname, &read_flags)) {
+		if (read_raw_ref(refname, sha1, &sb_refname, &read_flags)) {
 			*flags |= read_flags;
 			if (errno != ENOENT || (resolve_flags & RESOLVE_REF_READING))
 				return NULL;
@@ -1590,7 +1592,7 @@ static const char *resolve_ref_1(const char *refname,
 			return refname;
 		}
 
-		refname = sb_refname->buf;
+		refname = sb_refname.buf;
 		if (resolve_flags & RESOLVE_REF_NO_RECURSE) {
 			hashclr(sha1);
 			return refname;
@@ -1610,21 +1612,6 @@ static const char *resolve_ref_1(const char *refname,
 	return NULL;
 }
 
-const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
-			       unsigned char *sha1, int *flags)
-{
-	static struct strbuf sb_refname = STRBUF_INIT;
-	int unused_flags;
-	const char *ret;
-
-	if (!flags)
-		flags = &unused_flags;
-
-	ret = resolve_ref_1(refname, resolve_flags, sha1, flags,
-			    &sb_refname);
-	return ret;
-}
-
 /*
  * Peel the entry (if possible) and return its new peel_status.  If
  * repeel is true, re-peel the entry even if there is an old peeled
-- 
2.4.2.767.g62658d5-twtrsrc
