From: Elijah Newren <newren@gmail.com>
Subject: [RFC/PATCH 15/18] merge: Pass --index-only along to external merge strategy programs
Date: Thu,  7 Apr 2016 23:58:43 -0700
Message-ID: <1460098726-5958-16-git-send-email-newren@gmail.com>
References: <1460098726-5958-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 09:00:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoQOh-0002y6-2I
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 09:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932676AbcDHG7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 02:59:32 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35469 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932632AbcDHG7P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 02:59:15 -0400
Received: by mail-pa0-f65.google.com with SMTP id zy2so8473230pac.2
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 23:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m04yekYn2niMire5GJq9jR/Fa1SbJgqbn8R9NoG6o7U=;
        b=MMtl9U0jPGD0NMnfLoNuPy8AP+M46Asu4F0BauC0tTWifSzDnZ6mmNmTVs2McLCOnK
         QiXc1wC92QUbUNlZDkOJoBJvK7DCnRe7QJMBvEquPYSwtHjLBgNfe3ogD87fOLL5zjVj
         ud6O9dHi9IWS8f7cEL+vEFPhRb7LabDYlqoWniNfS3wmAaphw7L4xQZPWCy9r0WVMbEH
         +0C11/Cj68F/vDodyhpSkmH59ZGKno0W4xI+dqXlK71iqsEsJsuQI6JanlG+5Fkr1Yet
         E0vGOZKXgn7WtBRUE8xTHetxCCqZ9fnul2wKrDFhQbztm7bCOjj/DtZZnOgM1SkRJGQP
         0SZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m04yekYn2niMire5GJq9jR/Fa1SbJgqbn8R9NoG6o7U=;
        b=VKozm+894GEf10fGUsRvODP4rdY1vahtmc2iRl4NfjL3MKTj22Xf9mUpp2zH7ziHiJ
         1ExT6Pqs5twxhkc9QxYMrPiJiyOvxNwx9DdBDSYqReDRsxgW+j7Yb0k0wIhW5Hb1J/1Q
         YyITa2xCEvQYy4KpKZUuHjoF05xsMBRlCHLpjO0Zr+eGLQKZ6J1rU/dTglhWyxDqhJKA
         yOetr2eXoSdREmJ3jAnZm4FeG+T7U4Ke/Ls+rAKTEYEUMYetWaryzMq7CXlL5R0QKFhA
         wz09XKBLMnqwXp94u6SikS2mLY0b43mTerkgKiz3cu+H5dqKysML3W5Vcze4SCJdBDcS
         gTkA==
X-Gm-Message-State: AD7BkJJxUM/zgB45z+LUHPNzpRJO1kkepxrkXn+HVhBACkMqsgv+x2oT1hunx6Y+g/hmjw==
X-Received: by 10.66.232.4 with SMTP id tk4mr3769283pac.103.1460098754292;
        Thu, 07 Apr 2016 23:59:14 -0700 (PDT)
Received: from unknownB8F6B118D3EB.attlocal.net ([2602:30a:2c28:20f0:baf6:b1ff:fe18:d3eb])
        by smtp.gmail.com with ESMTPSA id w62sm16371973pfa.79.2016.04.07.23.59.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Apr 2016 23:59:13 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.18.gc685494
In-Reply-To: <1460098726-5958-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291011>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge-index.c | 9 ++++++++-
 builtin/merge.c       | 2 +-
 cache.h               | 2 +-
 merge.c               | 4 +++-
 sequencer.c           | 2 +-
 5 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 1c3427c..53cc285 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -4,14 +4,17 @@
 static const char *pgm;
 static int one_shot, quiet;
 static int err;
+static int index_only;
 
 static int merge_entry(int pos, const char *path)
 {
 	int found;
-	const char *arguments[] = { pgm, "", "", "", path, "", "", "", NULL };
+	const char *arguments[] = { pgm, "", "", "", path, "", "", "", "--index-only", NULL };
 	char hexbuf[4][GIT_SHA1_HEXSZ + 1];
 	char ownbuf[4][60];
 
+	if (!index_only)
+		arguments[8] = NULL;
 	if (pos >= active_nr)
 		die("git merge-index: %s not in the cache", path);
 	found = 0;
@@ -96,6 +99,10 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 				force_file = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--index-only")) {
+				index_only = 1;
+				continue;
+			}
 			if (!strcmp(arg, "-a")) {
 				merge_all();
 				continue;
diff --git a/builtin/merge.c b/builtin/merge.c
index b791702..d1fe3f9 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -690,7 +690,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		rollback_lock_file(&lock);
 		return clean ? 0 : 1;
 	} else {
-		return try_merge_command(strategy, xopts_nr, xopts,
+		return try_merge_command(strategy, index_only, xopts_nr, xopts,
 						common, head_arg, remoteheads);
 	}
 }
diff --git a/cache.h b/cache.h
index d51fcbc..d017155 100644
--- a/cache.h
+++ b/cache.h
@@ -1780,7 +1780,7 @@ extern struct startup_info *startup_info;
 
 /* merge.c */
 struct commit_list;
-int try_merge_command(const char *strategy, size_t xopts_nr,
+int try_merge_command(const char *strategy, int index_only, size_t xopts_nr,
 		const char **xopts, struct commit_list *common,
 		const char *head_arg, struct commit_list *remotes);
 int checkout_fast_forward(const unsigned char *from,
diff --git a/merge.c b/merge.c
index a40307c..705a8d7 100644
--- a/merge.c
+++ b/merge.c
@@ -15,7 +15,7 @@ static const char *merge_argument(struct commit *commit)
 		return EMPTY_TREE_SHA1_HEX;
 }
 
-int try_merge_command(const char *strategy, size_t xopts_nr,
+int try_merge_command(const char *strategy, int index_only, size_t xopts_nr,
 		      const char **xopts, struct commit_list *common,
 		      const char *head_arg, struct commit_list *remotes)
 {
@@ -24,6 +24,8 @@ int try_merge_command(const char *strategy, size_t xopts_nr,
 	struct commit_list *j;
 
 	argv_array_pushf(&args, "merge-%s", strategy);
+	if (index_only)
+		argv_array_pushf(&args, "--index-only");
 	for (i = 0; i < xopts_nr; i++)
 		argv_array_pushf(&args, "--%s", xopts[i]);
 	for (j = common; j; j = j->next)
diff --git a/sequencer.c b/sequencer.c
index 1b772fb..2fa1101 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -570,7 +570,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 
 		commit_list_insert(base, &common);
 		commit_list_insert(next, &remotes);
-		res = try_merge_command(opts->strategy, opts->xopts_nr, opts->xopts,
+		res = try_merge_command(opts->strategy, 0, opts->xopts_nr, opts->xopts,
 					common, sha1_to_hex(head), remotes);
 		free_commit_list(common);
 		free_commit_list(remotes);
-- 
2.8.0.18.gc685494
