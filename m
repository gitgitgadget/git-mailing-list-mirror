Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1980CC433FE
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 23:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E82AB60F9D
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 23:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240715AbhIRXQ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 19:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240684AbhIRXQy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 19:16:54 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF4DC061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 16:15:29 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id z184-20020a1c7ec1000000b003065f0bc631so12777875wmc.0
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 16:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=F0pVzr0KpoBWpnOg7Y2znbxx72Wd3oBvoI/ST7c8rEw=;
        b=WdX2sTEbjgaZxOns72cV+gv1f97WyWaqjL92BOs0t5FNsPfIGD2hTTs8IUslfnJnZ9
         2a1Q9R6Btn6RpgHhl0y3aWt4wkbraPhjGNnIvxO+9Dniy+nVAgVMaE027+LDgyNZ3PZp
         Tfy6eedIY0XaBedQ0qrIiLOLSqwhLnagmn4pxnNEcFZlJ4UdJg3h1JTS6+p48AjyOp4q
         vmmOz4r5wr1kDVhIK2Oxk2aITWwngOWXC4Vb/2MEeWe8vsryWOQZ0O/HXTZYPppNgtYZ
         DVnISK/ybMKIAjOt7vLQcwnZeIiFNgL2wPx3DQAqmJc3ZWhz5PSi4enj/Wl2NPL3I66p
         /oyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=F0pVzr0KpoBWpnOg7Y2znbxx72Wd3oBvoI/ST7c8rEw=;
        b=VNwPkeVrYooxrQToXnZWAnfPj3lYlrsyTeRdWCaXvZUcy4c98o+cOr19c5NoLLNgi5
         VgsUdhdmL8ptQpRU7I5AAf/RzGp8EF8KgA2lTbd4kuk7tb/3/dUJilk0bnqksZe3zGTg
         hyr6tC+zRQ5m/cPP3tGL+uA7RoXUQ0+p+oQusswnofoSAl7zv1XYZ6D/r6bUeG1xwEW9
         jOxoJ6BA0MeiF2VHX78c2M65iYuzPPH9uG3NRmJn+7JTl/Nd1VOnxETb7HZVWcw/RbqD
         Re8s0AGo4DhGir9M00miXgbZCbVZJddRIqT9F58R31sSnvPLckH+Om1egdcWoQVf4rI7
         Ik6w==
X-Gm-Message-State: AOAM5320Cf3ZDQ3X55uHH7RNiD/5MInW0wixrIu/Vv84011c6HrsJJ9Z
        MKwO5kurgPOAwM7ZIjQb8tu4jT6bpMs=
X-Google-Smtp-Source: ABdhPJwjNUqPnYp3CTvY7ndC293mGVBlVixU70JOGay+qfGISZlYJmkD3oaXKzQbsXSiWYwzXHESGg==
X-Received: by 2002:a05:600c:35d2:: with SMTP id r18mr1462843wmq.97.1632006928579;
        Sat, 18 Sep 2021 16:15:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w9sm10266606wmc.19.2021.09.18.16.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 16:15:28 -0700 (PDT)
Message-Id: <60c5d6b4615a6ac4179ec6c10e17cca480bc147a.1632006924.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
References: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Sep 2021 23:15:22 +0000
Subject: [PATCH 5/6] Comment important codepaths regarding nuking untracked
 files/dirs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fedor Biryukov <fedor.birjukov@gmail.com>,
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
index 4ceb3581b47..ce5e0364c68 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1519,6 +1519,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
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

