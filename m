Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67223C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 06:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B21660F48
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 06:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244221AbhIXGi4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 02:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244211AbhIXGis (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 02:38:48 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B99DC061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 23:37:15 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t8so24198355wri.1
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 23:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oWmvQ0iUWjoTjuPbS0PbRrMEoD8s5Dcu009eM9zwhDQ=;
        b=JF4uUWQzueHdhe2tkwF1WHsQ7fwBTTsR1pvvy+zzf7irq6QKyKI+cvo4hJA4+JzsM6
         zzrcKM1XcEVWrR2lYTC7NQGmGxIOhhMZtoFYf1JAM7WjpEuAiaNl/sN8mAcZH1yTCWbU
         zpRyxGVu3BChWJs+Y9RTeP/L7iAlmrnZ7yLRrNLKYBpZLMxIP9xZrdJzHwIBU0LeEpAx
         9WaDYKFlgo6zB5C+krTrIbl+aifkpqRiGQ3GpXgAqh3JnXV5kPyiFe1f8WbWRSkx3vV8
         eTZfLW7ytz0vHhraR+3YasqViHOGOcaF/v7dvDSfR03ZgVyr/bQjkGQiGfU2SdJ68V//
         eSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oWmvQ0iUWjoTjuPbS0PbRrMEoD8s5Dcu009eM9zwhDQ=;
        b=T0d4CLvy9o4UWPmMrEuGwr4E/TgSfKRDSq+zeZQiMivD97GDNGDfF6QIRp7iWzAruE
         CTCIPdaPedsbQ5HCxMATN2sL8iOxPFcMSlw9r2biP4L/VIi6GrfMV0THKX/B8JugEh/Y
         4IrzSiwGz/SoIa7KsySfxvHvNIZVIqez5uED9Gp26EhhXfXmwoTUPJzz3v/cgLz50rRm
         /HDlTLCMfY8NhQNc2npuVzVNQxefdNmjdw1hgLWi77unbBHRNMUH+c4FYAyt09bNZVy5
         K+XAa+CwelmiOVnZhA2no/aqXjiPovHgSiaBiJIde3kDzYo8AvA3jSkI2BiDVgRi6/D8
         aFcQ==
X-Gm-Message-State: AOAM532Ndcb6FQFR8I11D5RYee/Xhphm0mljGNJdXz84tefk7fmkt04h
        qCeoNQ1I+nz8bhai11dh8Izd/rYK4tk=
X-Google-Smtp-Source: ABdhPJzgGNHH1TJb6m5KQmu22wXZ+zx409jPG7521mkkbFWKqWaf8PM9wwzbyjb3B6ewKVQrBWGUOg==
X-Received: by 2002:adf:d1c5:: with SMTP id b5mr9562794wrd.252.1632465433930;
        Thu, 23 Sep 2021 23:37:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i6sm1644543wrx.61.2021.09.23.23.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 23:37:13 -0700 (PDT)
Message-Id: <4b78a526d2acfbcd85d6e4cb94894725ea0350aa.1632465429.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
References: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
        <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 06:37:08 +0000
Subject: [PATCH v2 5/6] Comment important codepaths regarding nuking untracked
 files/dirs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In the last few commits we focused on code in unpack-trees.c that
mistakenly removed untracked files or directories.  There may be more of
those, but in this commit we change our focus: callers of toplevel
commands that are expected to remove untracked files or directories.

As noted previously, we have toplevel commands that are expected to
delete untracked files such as 'read-tree --reset', 'reset --hard', and
'checkout --force'.  However, that does not mean that other highlevel
commands that happen to call these other commands thought about or
conveyed to users the possibility that untracked files could be removed.
Audit the code for such callsites, and add comments near existing
callsites to mention whether these are safe or not.

My auditing is somewhat incomplete, though; it skipped several cases:
  * git-rebase--preserve-merges.sh: is in the process of being
    deprecated/removed, so I won't leave a note that there are
    likely more bugs in that script.
  * contrib/git-new-workdir: why is the -f flag being used in a new
    empty directory??  It shouldn't hurt, but it seems useless.
  * git-p4.py: Don't see why -f is needed for a new dir (maybe it's
    not and is just superfluous), but I'm not at all familiar with
    the p4 stuff
  * git-archimport.perl: Don't care; arch is long since dead
  * git-cvs*.perl: Don't care; cvs is long since dead

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/stash.c             | 1 +
 builtin/submodule--helper.c | 4 ++++
 builtin/worktree.c          | 5 +++++
 contrib/rerere-train.sh     | 2 +-
 submodule.c                 | 1 +
 5 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 563f590afbd..0d071183eba 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1532,6 +1532,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 		} else {
 			struct child_process cp = CHILD_PROCESS_INIT;
 			cp.git_cmd = 1;
+			/* BUG: this nukes untracked files in the way */
 			strvec_pushl(&cp.args, "reset", "--hard", "-q",
 				     "--no-recurse-submodules", NULL);
 			if (run_command(&cp)) {
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ef2776a9e45..a49242d15ae 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2864,6 +2864,10 @@ static int add_submodule(const struct add_data *add_data)
 		prepare_submodule_repo_env(&cp.env_array);
 		cp.git_cmd = 1;
 		cp.dir = add_data->sm_path;
+		/*
+		 * NOTE: we only get here if add_data->force is true, so
+		 * passing --force to checkout is reasonable.
+		 */
 		strvec_pushl(&cp.args, "checkout", "-f", "-q", NULL);
 
 		if (add_data->branch) {
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 0d0a80da61f..383947ff54f 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -356,6 +356,11 @@ static int add_worktree(const char *path, const char *refname,
 	if (opts->checkout) {
 		cp.argv = NULL;
 		strvec_clear(&cp.args);
+		/*
+		 * NOTE: reset --hard is okay here, because 'worktree add'
+		 * refuses to work in an extant non-empty directory, so there
+		 * is no risk of deleting untracked files.
+		 */
 		strvec_pushl(&cp.args, "reset", "--hard", "--no-recurse-submodules", NULL);
 		if (opts->quiet)
 			strvec_push(&cp.args, "--quiet");
diff --git a/contrib/rerere-train.sh b/contrib/rerere-train.sh
index eeee45dd341..75125d6ae00 100755
--- a/contrib/rerere-train.sh
+++ b/contrib/rerere-train.sh
@@ -91,7 +91,7 @@ do
 		git checkout -q $commit -- .
 		git rerere
 	fi
-	git reset -q --hard
+	git reset -q --hard  # Might nuke untracked files...
 done
 
 if test -z "$branch"
diff --git a/submodule.c b/submodule.c
index 8e611fe1dbf..a9b71d585cf 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1866,6 +1866,7 @@ static void submodule_reset_index(const char *path)
 
 	strvec_pushf(&cp.args, "--super-prefix=%s%s/",
 		     get_super_prefix_or_empty(), path);
+	/* TODO: determine if this might overwright untracked files */
 	strvec_pushl(&cp.args, "read-tree", "-u", "--reset", NULL);
 
 	strvec_push(&cp.args, empty_tree_oid_hex());
-- 
gitgitgadget

