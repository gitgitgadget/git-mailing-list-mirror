From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 23/26] initdb: move safe_create_dir into common code
Date: Tue, 27 Oct 2015 22:14:24 -0400
Message-ID: <1445998467-11511-24-git-send-email-dturner@twopensource.com>
References: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Oct 28 03:15:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrGGw-0001Nm-8D
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 03:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755275AbbJ1CPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 22:15:25 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34794 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755252AbbJ1CPV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 22:15:21 -0400
Received: by igpw7 with SMTP id w7so19303210igp.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 19:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d9CI152u3vxlA1hh8e0gqJHbh2hiOAfdefzr8n4RK1I=;
        b=HwCtxCrc9VD4TISSGQ+3v+/KUZpxtnwYeUVJqpidbEq5BkItoTXf+OkmjH4QDW89Rr
         iUbXn3C0D64xtd4A9LQSWdaTIC2uoRhUcYHjCPYusZIwIn+qW0M/3v47RF8PBFUe9VJ1
         wSLj3yJtI5rsJ/QNcoDf14PQJnLhhFGmB8ZOXumCQiwKq3YQQ6V/pZN8rukFriH0vxEG
         3GB3Q6ulLP8vtwqRzxgyv8ELHijsijbVsU4yeWCdSE0rD1AbNpuhcBCUbsG7wGDZt5/g
         PUc+RG4IPmAt2/DIfSnGrcvEEV3vo8FtrUnddjwYqS9pW3UdbuXZW7cc4AfvuecywwdM
         pTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d9CI152u3vxlA1hh8e0gqJHbh2hiOAfdefzr8n4RK1I=;
        b=Bt4tHlgiZpwWOe1l/l82Nr74lfjXt2CMKcQWqnA3NGFWM8dvRujhO0/OS2ENK/EX+W
         ShxYu3WXOXtacpeMmqK1C7u5I7LXVemN+nMy6N+ZBK7+yYdinscxtF2vSrXhNNoltm6O
         FEwnoDzPMRjFbLnhpH7/XMh9tcm/QklpKyStBUKxdw+OVgLq4FyC3vByS2sLKXDmD3EE
         bZHmSwRLvfy9jCWRaKKNopR1o7ZE6WWE9uDUnuN4nfftB7mgQmjYssnaSzv4GfRvrHal
         zTRP6Divu+P/NUSJyUe3iLHLOM/Zf8vWggubqfNa5cYMrm73HCU1NI56oVi1Rz8COBw2
         fwtA==
X-Gm-Message-State: ALoCoQnd+HznkLteEYPLINns2zRjWvJjomAOLFzUO+5Ml8h9TPXv3jHM/V+C8agP19YEJxmaeW6c
X-Received: by 10.50.32.69 with SMTP id g5mr341168igi.35.1445998520599;
        Tue, 27 Oct 2015 19:15:20 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id lo2sm9240077igb.17.2015.10.27.19.15.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Oct 2015 19:15:20 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.658.g6d8523e-twtrsrc
In-Reply-To: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280341>

In a moment, we'll create initdb functions for ref backends, and code
from initdb that calls this function needs to move into the files
backend.  So this function needs to be public.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/init-db.c | 12 ------------
 cache.h           |  7 +++++++
 path.c            | 12 ++++++++++++
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index f59f407..07229d6 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -24,18 +24,6 @@ static int init_shared_repository = -1;
 static const char *init_db_template_dir;
 static const char *git_link;
 
-static void safe_create_dir(const char *dir, int share)
-{
-	if (mkdir(dir, 0777) < 0) {
-		if (errno != EEXIST) {
-			perror(dir);
-			exit(1);
-		}
-	}
-	else if (share && adjust_shared_perm(dir))
-		die(_("Could not make %s writable by group"), dir);
-}
-
 static void copy_templates_1(struct strbuf *path, struct strbuf *template,
 			     DIR *dir)
 {
diff --git a/cache.h b/cache.h
index 9a905a8..28b9896 100644
--- a/cache.h
+++ b/cache.h
@@ -1737,4 +1737,11 @@ void stat_validity_update(struct stat_validity *sv, int fd);
 int versioncmp(const char *s1, const char *s2);
 void sleep_millisec(int millisec);
 
+/*
+ * Create a directory and (if share is nonzero) adjust its permissions
+ * according to the shared_repository setting. Only use this for
+ * directories under $GIT_DIR.  Don't use it for working tree
+ * directories.
+ */
+void safe_create_dir(const char *dir, int share);
 #endif /* CACHE_H */
diff --git a/path.c b/path.c
index 212695a..9e0283c 100644
--- a/path.c
+++ b/path.c
@@ -723,6 +723,18 @@ int adjust_shared_perm(const char *path)
 	return 0;
 }
 
+void safe_create_dir(const char *dir, int share)
+{
+	if (mkdir(dir, 0777) < 0) {
+		if (errno != EEXIST) {
+			perror(dir);
+			exit(1);
+		}
+	}
+	else if (share && adjust_shared_perm(dir))
+		die(_("Could not make %s writable by group"), dir);
+}
+
 static int have_same_root(const char *path1, const char *path2)
 {
 	int is_abs1, is_abs2;
-- 
2.4.2.658.g6d8523e-twtrsrc
