From: David Turner <dturner@twopensource.com>
Subject: [PATCH 27/43] refs.c: move should_autocreate_reflog to common code
Date: Wed,  2 Sep 2015 21:54:57 -0400
Message-ID: <1441245313-11907-28-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:57:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJly-0006yC-GY
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbbICB4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:56:07 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34998 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932367AbbICB4C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:56:02 -0400
Received: by qkcj187 with SMTP id j187so15701352qkc.2
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E28EZKJyeA5NoOxJxRClQZS7vyaH0M1UBaZQYYliNTI=;
        b=RGYtYliowyaNBXZM0tgj9nSaTXSB7+IamJtma7VnbqcwSrNDcClVzapE6BEIyGeign
         el89I+armOaTIryjVkIzjRqEFE+SBWa4EZgS9lLPVwBl2yLj/4mpZNqHP04Kui5cSXKh
         pbwdOyCKE9NEWo9IJxa5pyDJmvmLSAjIx89win6XNJ87ZVQg5eQ+qQ3h+0+0wQK0IL6P
         DiT/83tGAgZhp5TRmDyWAZVBU65SKtXWkzVVr+j4Przp25IYS5OZ/AbcbKl1+Blx3l3W
         zzCxyPQY0dDuZkYRQXHgW48IGku+oVWHVq/i1xqtpEyIhm+U4d30hrxTyovkWOpDYIjC
         fZlA==
X-Gm-Message-State: ALoCoQlaOUAdua5y68z3JtLCvnJZqdgxpjYpxi40YT3k29v/ILOoDCf1KfYyNqhJSnETroNxbx3/
X-Received: by 10.55.48.67 with SMTP id w64mr34316208qkw.32.1441245362212;
        Wed, 02 Sep 2015 18:56:02 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.56.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:56:01 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277165>

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 10 ----------
 refs.c          | 10 ++++++++++
 refs.h          |  2 ++
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 657b58f..3138624 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2616,16 +2616,6 @@ static int commit_ref(struct ref_lock *lock)
 	return 0;
 }
 
-static int should_autocreate_reflog(const char *refname)
-{
-	if (!log_all_ref_updates)
-		return 0;
-	return starts_with(refname, "refs/heads/") ||
-		starts_with(refname, "refs/remotes/") ||
-		starts_with(refname, "refs/notes/") ||
-		!strcmp(refname, "HEAD");
-}
-
 static int files_verify_refname_available(const char *newname,
 					  struct string_list *extra,
 					  struct string_list *skip,
diff --git a/refs.c b/refs.c
index 77aa51d..a9e6ca1 100644
--- a/refs.c
+++ b/refs.c
@@ -685,6 +685,16 @@ char *resolve_refdup(const char *refname, int resolve_flags,
 						  sha1, flags));
 }
 
+int should_autocreate_reflog(const char *refname)
+{
+	if (!log_all_ref_updates)
+		return 0;
+	return starts_with(refname, "refs/heads/") ||
+		starts_with(refname, "refs/remotes/") ||
+		starts_with(refname, "refs/notes/") ||
+		!strcmp(refname, "HEAD");
+}
+
 /*
  * How to handle various characters in refnames:
  * 0: An acceptable character for refs
diff --git a/refs.h b/refs.h
index 0eab5e2..7204a56 100644
--- a/refs.h
+++ b/refs.h
@@ -58,6 +58,8 @@ extern const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 extern char *resolve_refdup(const char *refname, int resolve_flags,
 			    unsigned char *sha1, int *flags);
 
+extern int should_autocreate_reflog(const char *refname);
+
 extern int read_ref_full(const char *refname, int resolve_flags,
 			 unsigned char *sha1, int *flags);
 extern int read_ref(const char *refname, unsigned char *sha1);
-- 
2.0.4.315.gad8727a-twtrsrc
