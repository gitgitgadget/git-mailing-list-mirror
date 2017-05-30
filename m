Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFA0A20D0A
	for <e@80x24.org>; Tue, 30 May 2017 00:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750908AbdE3Ac5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 20:32:57 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35608 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbdE3Ac4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 20:32:56 -0400
Received: by mail-pf0-f195.google.com with SMTP id u26so14069178pfd.2
        for <git@vger.kernel.org>; Mon, 29 May 2017 17:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2L8XvXBAB3s99/Xgf29lsGcvpgVeGmVRfBrl0uL7lvw=;
        b=vLhb7mOdusTC/u7c01hMCix7kCP6mdxD6UO3PfKW1cTN6cmZPBBPAyYq1+IK6SuxJo
         cx5Tzk3DzP23qKEmRHCOBKKYinbGRN0b9Vy5ldH9GI4xk8pkvvaW7rXj2xMG/n8g4wq1
         j7+nL+mI62QDcACL4+cI+2F7ZAgJMXW75iEh2kSrb5kiUcfDnxiDFuh8gHzqXT55C5X3
         wZRqrnoe8BaDTpUmk/Q6IK5sBrarzaK55KbvdSYBb3n+FIeo8Fo+zxqjEQGHhNAfVsfj
         q59IHlP5Mr1KG4zaHkZpCtdk4DcUp6N46lCjO5jXWTzn2X4dvZmFrE9mwYBaRv7scvAA
         3F7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2L8XvXBAB3s99/Xgf29lsGcvpgVeGmVRfBrl0uL7lvw=;
        b=YWWz7LwjrlJjIe+27RbiByUziPGgw+uoGIKkOsTIDoEdC5rP4sxt8H01I3FCu0Uqh7
         xyqoop/f6b+6nQkpnGMKy9FSqWhemw7pGHw13zIZjSan25g6dF8g2a+ueTMHooTUH9/f
         JkRGngeGviGG2r9bLLLx7ac/B+RwWpA100eh7S1PuRcz4Z0/h/pmll+DT8K8Kl7Jz/ML
         m/Yyd7btB2Fn8mtS6+yObqelqgFGJkZJS8CApgzQckqGWL19+7cU4d2OaHctZcokTIqF
         C8EN2SW1uGu93mNGnU1lJnTovuejnzjjz9FHaWE3CQhqRc+k9Xa5Tut5ErFNhhG4rDYI
         cakQ==
X-Gm-Message-State: AODbwcCUZeLNtd8KpXsPnREUZI1aYOeuBZDaZ/6atvQp/EQDgc2YssbK
        oYobrb91/HIowGzfktU=
X-Received: by 10.99.104.199 with SMTP id d190mr7105141pgc.185.1496104375997;
        Mon, 29 May 2017 17:32:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f830:fc5f:a16b:f475])
        by smtp.gmail.com with ESMTPSA id w76sm15259778pfd.76.2017.05.29.17.32.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 May 2017 17:32:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] treewide: use is_missing_file_error() where ENOENT and  ENOTDIR are checked
References: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
        <20170526033510.1793-1-gitster@pobox.com>
        <20170526033510.1793-13-gitster@pobox.com>
        <xmqqefv7famk.fsf_-_@gitster.mtv.corp.google.com>
Date:   Tue, 30 May 2017 09:32:54 +0900
In-Reply-To: <xmqqefv7famk.fsf_-_@gitster.mtv.corp.google.com> (Junio
        C. Hamano's message of "Tue, 30 May 2017 09:31:47 +0900")
Message-ID: <xmqqa85vfakp.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using the is_missing_file_error() helper introduced in the previous
step, update all hits from

  $ git grep -e ENOENT --and -e ENOTDIR

There are codepaths that only check ENOENT, and it is possible that
some of them should be checking both.  Updating them is kept out of
this step deliberately, as we do not want to change behaviour in this
step.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 apply.c                | 2 +-
 builtin/rm.c           | 2 +-
 builtin/update-index.c | 2 +-
 diff-lib.c             | 2 +-
 dir.c                  | 2 +-
 setup.c                | 2 +-
 sha1_name.c            | 4 ++--
 wrapper.c              | 4 ++--
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/apply.c b/apply.c
index 0e2caeab9c..59bb3497de 100644
--- a/apply.c
+++ b/apply.c
@@ -3741,7 +3741,7 @@ static int check_to_create(struct apply_state *state,
 			return 0;
 
 		return EXISTS_IN_WORKTREE;
-	} else if ((errno != ENOENT) && (errno != ENOTDIR)) {
+	} else if (!is_missing_file_error(errno)) {
 		return error_errno("%s", new_name);
 	}
 	return 0;
diff --git a/builtin/rm.c b/builtin/rm.c
index fb79dcab18..30c4332c68 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -129,7 +129,7 @@ static int check_local_mod(struct object_id *head, int index_only)
 		ce = active_cache[pos];
 
 		if (lstat(ce->name, &st) < 0) {
-			if (errno != ENOENT && errno != ENOTDIR)
+			if (!is_missing_file_error(errno))
 				warning_errno(_("failed to stat '%s'"), ce->name);
 			/* It already vanished from the working tree */
 			continue;
diff --git a/builtin/update-index.c b/builtin/update-index.c
index d530e89368..4e9402984a 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -253,7 +253,7 @@ static int remove_one_path(const char *path)
  */
 static int process_lstat_error(const char *path, int err)
 {
-	if (err == ENOENT || err == ENOTDIR)
+	if (is_missing_file_error(err))
 		return remove_one_path(path);
 	return error("lstat(\"%s\"): %s", path, strerror(err));
 }
diff --git a/diff-lib.c b/diff-lib.c
index 52447466b5..88fc71e89e 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -29,7 +29,7 @@
 static int check_removed(const struct cache_entry *ce, struct stat *st)
 {
 	if (lstat(ce->name, st) < 0) {
-		if (errno != ENOENT && errno != ENOTDIR)
+		if (!is_missing_file_error(errno))
 			return -1;
 		return 1;
 	}
diff --git a/dir.c b/dir.c
index aeeb5ce104..98efe9d1c5 100644
--- a/dir.c
+++ b/dir.c
@@ -2235,7 +2235,7 @@ int remove_path(const char *name)
 {
 	char *slash;
 
-	if (unlink(name) && errno != ENOENT && errno != ENOTDIR)
+	if (unlink(name) && !is_missing_file_error(errno))
 		return -1;
 
 	slash = strrchr(name, '/');
diff --git a/setup.c b/setup.c
index 8f64fbdfb2..bb6a2c1beb 100644
--- a/setup.c
+++ b/setup.c
@@ -147,7 +147,7 @@ int check_filename(const char *prefix, const char *arg)
 		name = arg;
 	if (!lstat(name, &st))
 		return 1; /* file exists */
-	if (errno == ENOENT || errno == ENOTDIR)
+	if (is_missing_file_error(errno))
 		return 0; /* file does not exist */
 	die_errno("failed to stat '%s'", arg);
 }
diff --git a/sha1_name.c b/sha1_name.c
index 26ceec1d79..af7500037d 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1406,7 +1406,7 @@ static void diagnose_invalid_sha1_path(const char *prefix,
 	if (file_exists(filename))
 		die("Path '%s' exists on disk, but not in '%.*s'.",
 		    filename, object_name_len, object_name);
-	if (errno == ENOENT || errno == ENOTDIR) {
+	if (is_missing_file_error(errno)) {
 		char *fullname = xstrfmt("%s%s", prefix, filename);
 
 		if (!get_tree_entry(tree_sha1, fullname,
@@ -1471,7 +1471,7 @@ static void diagnose_invalid_index_path(int stage,
 
 	if (file_exists(filename))
 		die("Path '%s' exists on disk, but not in the index.", filename);
-	if (errno == ENOENT || errno == ENOTDIR)
+	if (is_missing_file_error(errno))
 		die("Path '%s' does not exist (neither on disk nor in the index).",
 		    filename);
 
diff --git a/wrapper.c b/wrapper.c
index 0542fc7582..2fbbd81359 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -583,8 +583,8 @@ void warn_on_inaccessible(const char *path)
 
 static int access_error_is_ok(int err, unsigned flag)
 {
-	return err == ENOENT || err == ENOTDIR ||
-		((flag & ACCESS_EACCES_OK) && err == EACCES);
+	return (is_missing_file_error(err) ||
+		((flag & ACCESS_EACCES_OK) && err == EACCES));
 }
 
 int access_or_warn(const char *path, int mode, unsigned flag)
-- 
2.13.0-496-ga689fffbe2

