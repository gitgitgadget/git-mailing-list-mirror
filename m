From: David Turner <dturner@twopensource.com>
Subject: [PATCH 15/43] refs.c: move prettify_refname to the common code
Date: Wed,  2 Sep 2015 21:54:45 -0400
Message-ID: <1441245313-11907-16-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:57:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJm9-000768-3c
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbbICB5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:57:13 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34679 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756195AbbICBzl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:55:41 -0400
Received: by qkfq186 with SMTP id q186so15071542qkf.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RG/8+52MA48c+50wthO5KPqtJyacwRqfA+rtNGPDe3c=;
        b=HLdZ7RZU5fltty8oGaLZ4BWZMyJTT37CMdr8pRa7RZKZYkqgGa1cPv0kk8GALLoMF9
         7QVWqDUHmfZd6EQ80125lvOEFG0iP3x9wWpCigFOhfu0Z80XKogyUbexJCnpxEEyHX8F
         jIXMpPbwNC7iIgk/u9j6uVvq+ofndm5ukoRMdQfLd8O1uIRC/+lzMeoE9pxOfMVbo0rA
         nskEOxN5ud9kEVEMSFme8YD1iexlGqnCtcNIVAIxjTp1deLswTPwCxDnly8JsWTwRkVb
         ey+1VYG2RAMbP71tFSm+hLvapt6awwoJ+/WoRfhPHIgOc0EmUIOchznWDrEE3k3+bujt
         FufQ==
X-Gm-Message-State: ALoCoQnFBmKl/5x6qXqsBfxHsizyXF7PDpo7vuYhqJ7D8RlHWczLRMu3BzD74d+l8nP8OQkOCCrA
X-Received: by 10.55.24.8 with SMTP id j8mr34022748qkh.93.1441245340432;
        Wed, 02 Sep 2015 18:55:40 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.55.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:55:39 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277169>

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-be-files.c | 9 ---------
 refs.c          | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index a346629..6b5b290 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2062,15 +2062,6 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
-const char *prettify_refname(const char *name)
-{
-	return name + (
-		starts_with(name, "refs/heads/") ? 11 :
-		starts_with(name, "refs/tags/") ? 10 :
-		starts_with(name, "refs/remotes/") ? 13 :
-		0);
-}
-
 static void unlock_ref(struct ref_lock *lock)
 {
 	/* Do not free lock->lk -- atexit() still looks at them */
diff --git a/refs.c b/refs.c
index bc8750c..44ee4f4 100644
--- a/refs.c
+++ b/refs.c
@@ -772,3 +772,12 @@ int is_branch(const char *refname)
 {
 	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
 }
+
+const char *prettify_refname(const char *name)
+{
+	return name + (
+		starts_with(name, "refs/heads/") ? 11 :
+		starts_with(name, "refs/tags/") ? 10 :
+		starts_with(name, "refs/remotes/") ? 13 :
+		0);
+}
-- 
2.0.4.315.gad8727a-twtrsrc
