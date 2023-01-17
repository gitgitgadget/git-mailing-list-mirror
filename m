Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1035C54EBE
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 00:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjAQAgr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 19:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbjAQAgq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 19:36:46 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9912A98A
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 16:36:45 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so19871703wma.1
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 16:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SDoOTS65eSo5MJOkf89cJNkXytPNtIAq/rkSMzbK0g=;
        b=ZinnHQEgWE/wVoOSoWf0u+D9fRfmN8KtoYZgKezBQdhjDrJM00wKahoaHVBuyL3jH/
         Fts9Qcw3+ndB0278y6P89t1OCA5stE0vR0p3ClwaLXKgexovDep0XEGsEH5PcBE8x4EE
         oeSgn3I6N7w+u8dzYK+gxK8hddO2Xeq9u0FMNRBtn0P3lATkuVL0q9WbGI08DLcRxMxh
         PW5Qn3mvrinWr9yFZCKdErOO5Wn/hEKOyovc8Azvxs+OYAyUaI2tnLkxhko81ZegGdjn
         ex/sl8x4fLydHdWVUr56tqA6JzJATEz8zszScD0VePFqwZ1rmZ4J+YRH+EbfAWCmlxDJ
         OW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SDoOTS65eSo5MJOkf89cJNkXytPNtIAq/rkSMzbK0g=;
        b=1NslLss0QTPb3v15koAFDHJ/XbqUxXYGcwY99aru+wC7L8aUTlZF8I8B3zmf1Xa7Zd
         Jm7M8tF7VUHbGDIqPw5i7fFvutK4hRlNrRHlu75NsUOJVOwi3nLpu51NkPOdyheAkwDe
         VQSSEtKDlQPPH/lpOJDKKEtDmFLxc6klqD/tOslcrYxkGs4/EO5o0D0A5Xw9SRiEhxxS
         ihEmrbiFJIuFRRU2LfGVw7bpdjgdFfxJfs1yeHEkxkBdvB0x1Gjs7cqYOxhbcOIeVrXm
         RQe3ZlxyklBqRWxzwDpFjfWOiOnt6HFDco6Xl9THB5B5WIzieRfGgbAW77ShhA9uB09q
         sY6g==
X-Gm-Message-State: AFqh2krqC3Eqwp7GwlQ/jMwNiLk15rIDgzGOJuxhR57e/LGmT+GVaKeA
        9oLSML3Faq77kgTloy668wTd0sJoQDg=
X-Google-Smtp-Source: AMrXdXtmA2jHd+wVa/mpwAEyeLQ46hUTqBgm359quNBJu4RrSU+ZgUdJFh6DWx/AN0ky6deNbz9jHw==
X-Received: by 2002:a05:600c:1ca4:b0:3da:f5b5:1401 with SMTP id k36-20020a05600c1ca400b003daf5b51401mr1124351wms.31.1673915803935;
        Mon, 16 Jan 2023 16:36:43 -0800 (PST)
Received: from [192.168.2.52] (94.red-88-14-213.dynamicip.rima-tde.net. [88.14.213.94])
        by smtp.gmail.com with ESMTPSA id i8-20020a05600c354800b003cf894dbc4fsm38338913wmq.25.2023.01.16.16.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 16:36:42 -0800 (PST)
To:     Git List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Subject: [PATCH] worktree: teach find_shared_symref to ignore current worktree
Message-ID: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
Date:   Tue, 17 Jan 2023 01:36:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We prevent some operations from being executed on a branch checked out
in a worktree other than the current one.  An example of this was
introduced in b5cabb4 (rebase: refuse to switch to branch already
checked out elsewhere, 2020-02-23).

"find_shared_symref()" is sometimes used to find the worktree in which a
branch is checked out.  It performs its search starting with the current
worktree.

As we allow to have the same branch checked out in multiple worktrees
simultaneously...

	$ git worktree add foo
	$ git worktree add -f bar foo
	$ git checkout --ignore-other-worktrees foo

... if the branch checked out in the current worktree is also checked
out in another worktree, with "find_shared_symref()" we will not notice
this "other" working tree.

Let's teach "find_shared_symref()" to ignore the current worktree in the
search, based on the caller's needs.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 branch.c               | 4 ++--
 builtin/notes.c        | 2 +-
 builtin/receive-pack.c | 2 +-
 t/t3400-rebase.sh      | 3 +++
 worktree.c             | 6 +++++-
 worktree.h             | 3 ++-
 6 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/branch.c b/branch.c
index d182756827..2508e94add 100644
--- a/branch.c
+++ b/branch.c
@@ -822,8 +822,8 @@ void die_if_checked_out(const char *branch, int ignore_current_worktree)
 	struct worktree **worktrees = get_worktrees();
 	const struct worktree *wt;
 
-	wt = find_shared_symref(worktrees, "HEAD", branch);
-	if (wt && (!ignore_current_worktree || !wt->is_current)) {
+	wt = find_shared_symref(worktrees, "HEAD", branch, ignore_current_worktree);
+	if (wt) {
 		skip_prefix(branch, "refs/heads/", &branch);
 		die(_("'%s' is already checked out at '%s'"), branch, wt->path);
 	}
diff --git a/builtin/notes.c b/builtin/notes.c
index 80d9dfd25c..80326bdaab 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -869,7 +869,7 @@ static int merge(int argc, const char **argv, const char *prefix)
 		/* Store ref-to-be-updated into .git/NOTES_MERGE_REF */
 		worktrees = get_worktrees();
 		wt = find_shared_symref(worktrees, "NOTES_MERGE_REF",
-					default_notes_ref());
+					default_notes_ref(), 0);
 		if (wt)
 			die(_("a notes merge into %s is already in-progress at %s"),
 			    default_notes_ref(), wt->path);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a90af30363..18d400101c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1460,7 +1460,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	int do_update_worktree = 0;
 	struct worktree **worktrees = get_worktrees();
 	const struct worktree *worktree =
-		find_shared_symref(worktrees, "HEAD", name);
+		find_shared_symref(worktrees, "HEAD", name, 0);
 
 	/* only refs/... are allowed */
 	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index d5a8ee39fc..874cfff8fe 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -407,6 +407,9 @@ test_expect_success 'refuse to switch to branch checked out elsewhere' '
 	git checkout main &&
 	git worktree add wt &&
 	test_must_fail git -C wt rebase main main 2>err &&
+	test_i18ngrep "already checked out" err &&
+	git worktree add --force wt2 main &&
+	test_must_fail git rebase main main &&
 	test_i18ngrep "already checked out" err
 '
 
diff --git a/worktree.c b/worktree.c
index aa43c64119..3d686137ef 100644
--- a/worktree.c
+++ b/worktree.c
@@ -405,7 +405,8 @@ int is_worktree_being_bisected(const struct worktree *wt,
  */
 const struct worktree *find_shared_symref(struct worktree **worktrees,
 					  const char *symref,
-					  const char *target)
+					  const char *target,
+					  int ignore_current_worktree)
 {
 	const struct worktree *existing = NULL;
 	int i = 0;
@@ -416,6 +417,9 @@ const struct worktree *find_shared_symref(struct worktree **worktrees,
 		struct ref_store *refs;
 		int flags;
 
+		if (wt->is_current && ignore_current_worktree)
+			continue;
+
 		if (wt->is_bare)
 			continue;
 
diff --git a/worktree.h b/worktree.h
index 9dcea6fc8c..a9f35ee990 100644
--- a/worktree.h
+++ b/worktree.h
@@ -147,7 +147,8 @@ void free_worktrees(struct worktree **);
  */
 const struct worktree *find_shared_symref(struct worktree **worktrees,
 					  const char *symref,
-					  const char *target);
+					  const char *target,
+					  int ignore_current_worktree);
 
 /*
  * Similar to head_ref() for all HEADs _except_ one from the current
-- 
2.39.0
