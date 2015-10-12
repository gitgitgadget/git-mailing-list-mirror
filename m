From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 15/44] refs.c: move prettify_refname to the common code
Date: Mon, 12 Oct 2015 17:51:35 -0400
Message-ID: <1444686725-27660-16-git-send-email-dturner@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 12 23:52:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zll1M-0004UF-Oi
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbbJLVwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 17:52:31 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33095 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254AbbJLVw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:52:29 -0400
Received: by qkas79 with SMTP id s79so63028057qka.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o/e3SxPMG2m2ozJSia9shgVx/AVdBY0TBjR0JLF9Sdk=;
        b=XiMmatdiTTekvsEk5N5CygpQvVsgaRBbuBom/Yo13OIflXc/x3IWkoxtI3jsJ1Xa61
         hDr+R7HM0HCHd1wkyNviHqP4AsU3f/ES28WJcADnxa0HMgrlrZShUfSrjBt42aOyPn/g
         CNQhkiBjI8vW0BOoJzvfkyjFvMf/wOYffSIiaCBSdhHxfLlYGqiqPR+vlT7yk5CbtPPK
         8B/stNxFJY4DLYWocXlrfcB4hcWfFsr4s2PR3pWqj+IYwF4UN+tSeewC8Ef6fbBJRz8S
         1opZ2q25HghmQ99LnBH3DqtQ215CPf1HkZTMHCDdfJaTtHgbY+5XKtgEKJgzzqxunoHf
         Dnxw==
X-Gm-Message-State: ALoCoQmc75/ygRxOsBqDrUmpyxzB/IJ65fUQGLjX9jsCsXNux/fs2YWCqcP03yu6KRWlKgXksibx
X-Received: by 10.55.201.16 with SMTP id q16mr35624311qki.6.1444686748772;
        Mon, 12 Oct 2015 14:52:28 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id q140sm7865647qha.5.2015.10.12.14.52.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 14:52:27 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279428>

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-be-files.c | 9 ---------
 refs.c          | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 1214d9e..ecf2b33 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2052,15 +2052,6 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
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
2.4.2.644.g97b850b-twtrsrc
