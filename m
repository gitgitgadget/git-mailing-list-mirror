From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 12/44] refs.c: move resolve_refdup to common
Date: Mon, 12 Oct 2015 17:51:32 -0400
Message-ID: <1444686725-27660-13-git-send-email-dturner@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 12 23:52:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zll1F-0004N7-0F
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:52:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231AbbJLVw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 17:52:27 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:32865 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702AbbJLVw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:52:26 -0400
Received: by qgeb31 with SMTP id b31so28256998qge.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B6DHPVRp8tepu/SMPrWFtwliw5FshLXZJWm0irTxxsY=;
        b=KkTjFWJOPL/nJHGpPHKs1V4LopWyEy7ezomVjTzGBZ0M7hANpHLTzVBYqEBgqPc2+A
         bZbwgZKWEBiVvdnD3xAhM9o6TMM51QcP26NiBl4NyewPKPZ6shyjz2m/vlGvfEpma512
         NG1nTDMpaIko10PKhj5VLVDoRIhh/vrM36SMdUx2N0KPWdBPNFtpe7Pn4p9f3vANppHJ
         YTY2/5HfiOFswtMSl41OBSg0R8M77kfbVq6hsGiaRVXYn9r0e5qLS4jJ8lb/JWJCfYBt
         Pjsz6G82n3WNJNJnHMcgoF9tz2B1rRO8d1rUhP4r4FffoUjwx78LfyN8uv4TdhLhMbAC
         6UPQ==
X-Gm-Message-State: ALoCoQkpfSbV0va26dlikLPCC/PLxP2ErQ9I3rdgH2hT0OOSoxv9ugMGMY/zX26ZTxMIeXE0p+Uh
X-Received: by 10.140.104.202 with SMTP id a68mr16224177qgf.94.1444686745921;
        Mon, 12 Oct 2015 14:52:25 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id q140sm7865647qha.5.2015.10.12.14.52.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 14:52:25 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279427>

From: Ronnie Sahlberg <sahlberg@google.com>

This function can be shared across all refs backends so move it
to the common code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 7 -------
 refs.c          | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index bd0dbb5..045bf09 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1777,13 +1777,6 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 	return ret;
 }
 
-char *resolve_refdup(const char *refname, int resolve_flags,
-		     unsigned char *sha1, int *flags)
-{
-	return xstrdup_or_null(resolve_ref_unsafe(refname, resolve_flags,
-						  sha1, flags));
-}
-
 /* The argument to filter_refs */
 struct ref_filter {
 	const char *pattern;
diff --git a/refs.c b/refs.c
index 242f66d..039e5c0 100644
--- a/refs.c
+++ b/refs.c
@@ -651,3 +651,10 @@ int ref_exists(const char *refname)
 	unsigned char sha1[20];
 	return !!resolve_ref_unsafe(refname, RESOLVE_REF_READING, sha1, NULL);
 }
+
+char *resolve_refdup(const char *refname, int resolve_flags,
+		     unsigned char *sha1, int *flags)
+{
+	return xstrdup_or_null(resolve_ref_unsafe(refname, resolve_flags,
+						  sha1, flags));
+}
-- 
2.4.2.644.g97b850b-twtrsrc
