Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F86C07E9B
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A683613F7
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhGEMey (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhGEMey (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:34:54 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52739C061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:32:17 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 10so5848211oiq.9
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ShncCEzb904+ld7csdG90aCPqjvRvNsnnj5DwuWPp2E=;
        b=YZAltohmcXKIuVS5BGECvfvk5rlseh6f0yRHll8TNGjhfoDPsEG/MIvW1j0v1zFppW
         HygnIlVfW+4GLdcOFvaXRfj7kWdlgFJjTLmvDOsMomxCpUkyOBbXeqRytBiDe7E/P5oB
         LRcyj77oJWqshd7NiBAQoxLDRGfhTySvVt7dZbpKB9avO4efqf6BcYSuxNN7mAztT45W
         Av7Y/0W4qKf9Q55uh6B0N/qIG2P7ZQxhoyU/gKFd34+D0phpL+5o9RZ1+2Uu4ZaDj9SY
         TTxjTqFKgs7OhJw55tYxo0MZG2bQJAkhbWkEyceaAIHJPqOc4Jj2fbQzISQ8q689Gzb0
         0ngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ShncCEzb904+ld7csdG90aCPqjvRvNsnnj5DwuWPp2E=;
        b=h7ljHzVxBwA58jvd4Yj4Sce7e8gAy5vTzd18APf8YaMB7ZKWGTx838eSSWc71HgqJ8
         1a4uyRmxXuJmHEmetnGF0SJJ7M2zIECV603f3fQwh4d9JZ0deHO0xcecGoPWoy/9KMUo
         s854DPxIlsnTPpV8vdMdJxI7ePNVUCIqyVyR/ioteUnJTj64Gw3B8/hpg/wkePTNLEbV
         qsdwitReV3wG83fKZuHtYfDb6wtYpQ/M4aAGgw5cK+SmYIEF1b+HcNhXolyrDS12A2+3
         L5GzPv2HnGi2TvqHMQjyCvwGhsAaEqLWanhbhEVP20aUBmpQEqw0Nw05Wxdv8tq624Ye
         GSug==
X-Gm-Message-State: AOAM532HTo9lO9KZDD5j+FJx12+3VzY3yPUR0ccQxcjy6vshJ76C+jrp
        gYefn3kB8XId59l3eonN9sDZPCa/9/62ew==
X-Google-Smtp-Source: ABdhPJzaCpXM/u7WqH0duJ8bgYrIte35u+1TJ/2i0LKiyMH/Dq1K74XeacvaXV0FRf2sZXuCznrFGA==
X-Received: by 2002:a05:6808:1309:: with SMTP id y9mr9677800oiv.112.1625488336461;
        Mon, 05 Jul 2021 05:32:16 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id p26sm811596otp.59.2021.07.05.05.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:32:16 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 03/35] fast-forward: add new builtin
Date:   Mon,  5 Jul 2021 07:31:37 -0500
Message-Id: <20210705123209.1808663-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210705123209.1808663-1-felipe.contreras@gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is one of the most common git operations, it makes sense it has its
own built-in.

This is basically the same as `git merge --ff-only` (for now).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 .gitignore                             |  1 +
 Documentation/git-fast-forward.txt     | 26 ++++++++++++++++++++++++++
 Makefile                               |  1 +
 builtin.h                              |  1 +
 builtin/merge.c                        | 15 +++++++++++++++
 contrib/completion/git-completion.bash | 10 ++++++++++
 git.c                                  |  1 +
 t/t7600-merge.sh                       | 21 +++++++++++++++++++++
 8 files changed, 76 insertions(+)
 create mode 100644 Documentation/git-fast-forward.txt

diff --git a/.gitignore b/.gitignore
index 311841f9be..45703399b0 100644
--- a/.gitignore
+++ b/.gitignore
@@ -62,6 +62,7 @@
 /git-describe
 /git-env--helper
 /git-fast-export
+/git-fast-forward
 /git-fast-import
 /git-fetch
 /git-fetch-pack
diff --git a/Documentation/git-fast-forward.txt b/Documentation/git-fast-forward.txt
new file mode 100644
index 0000000000..d457022629
--- /dev/null
+++ b/Documentation/git-fast-forward.txt
@@ -0,0 +1,26 @@
+git-fast-forward(1)
+===================
+
+NAME
+----
+git-fast-forward - Advance the branch pointer
+
+SYNOPSIS
+--------
+[verse]
+'git fast-forward' [<commit>]
+
+DESCRIPTION
+-----------
+Incorporates changes into the current branch. By default the upstream branch is
+used, but a different commit can be specified in the arguments.
+
+THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOUR MAY CHANGE.
+
+SEE ALSO
+--------
+linkgit:git-merge[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index c3565fc0f8..cf42162a07 100644
--- a/Makefile
+++ b/Makefile
@@ -772,6 +772,7 @@ BUILT_INS += $(patsubst builtin/%.o,git-%$X,$(BUILTIN_OBJS))
 
 BUILT_INS += git-cherry$X
 BUILT_INS += git-cherry-pick$X
+BUILT_INS += git-fast-forward$X
 BUILT_INS += git-format-patch$X
 BUILT_INS += git-fsck-objects$X
 BUILT_INS += git-init$X
diff --git a/builtin.h b/builtin.h
index 16ecd5586f..601e438c9b 100644
--- a/builtin.h
+++ b/builtin.h
@@ -151,6 +151,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix);
 int cmd_difftool(int argc, const char **argv, const char *prefix);
 int cmd_env__helper(int argc, const char **argv, const char *prefix);
 int cmd_fast_export(int argc, const char **argv, const char *prefix);
+int cmd_fast_forward(int argc, const char **argv, const char *prefix);
 int cmd_fast_import(int argc, const char **argv, const char *prefix);
 int cmd_fetch(int argc, const char **argv, const char *prefix);
 int cmd_fetch_pack(int argc, const char **argv, const char *prefix);
diff --git a/builtin/merge.c b/builtin/merge.c
index 9c944f5f0f..e396943d37 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -61,6 +61,11 @@ static const char * const builtin_merge_usage[] = {
 	NULL
 };
 
+static const char * const builtin_ff_usage[] = {
+	N_("git fast-forward [<commit>]"),
+	NULL
+};
+
 static int show_diffstat = 1, shortlog_len = -1, squash;
 static int option_commit = -1;
 static int option_edit = -1;
@@ -304,6 +309,10 @@ static struct option builtin_merge_options[] = {
 	OPT_END()
 };
 
+static struct option builtin_ff_options[] = {
+	OPT_END()
+};
+
 static int save_state(struct object_id *stash)
 {
 	int len;
@@ -1740,3 +1749,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 {
 	return merge_common(argc, argv, prefix, builtin_merge_options, builtin_merge_usage);
 }
+
+int cmd_fast_forward(int argc, const char **argv, const char *prefix)
+{
+	fast_forward = FF_ONLY;
+	return merge_common(argc, argv, prefix, builtin_ff_options, builtin_ff_usage);
+}
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b50c5d0ea3..cfaee3aaeb 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1786,6 +1786,16 @@ _git_difftool ()
 	__git_complete_revlist_file
 }
 
+_git_fast_forward ()
+{
+	case "$cur" in
+	--*)
+		__gitcomp_builtin fast-forward
+		return
+	esac
+	__git_complete_refs
+}
+
 __git_fetch_recurse_submodules="yes on-demand no"
 
 _git_fetch ()
diff --git a/git.c b/git.c
index 18bed9a996..6ab1fb9251 100644
--- a/git.c
+++ b/git.c
@@ -524,6 +524,7 @@ static struct cmd_struct commands[] = {
 	{ "difftool", cmd_difftool, RUN_SETUP_GENTLY },
 	{ "env--helper", cmd_env__helper },
 	{ "fast-export", cmd_fast_export, RUN_SETUP },
+	{ "fast-forward", cmd_fast_forward, RUN_SETUP | NEED_WORK_TREE },
 	{ "fast-import", cmd_fast_import, RUN_SETUP | NO_PARSEOPT },
 	{ "fetch", cmd_fetch, RUN_SETUP },
 	{ "fetch-pack", cmd_fetch_pack, RUN_SETUP | NO_PARSEOPT },
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 1cbc9715a8..10f8956665 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -205,6 +205,16 @@ test_expect_success 'merge c0 with c1 with --ff-only' '
 
 test_debug 'git log --graph --decorate --oneline --all'
 
+test_expect_success 'fast-forward c0 with c1' '
+	git reset --hard c0 &&
+	git fast-forward c1 &&
+	git fast-forward HEAD c0 c1 &&
+	verify_merge file result.1 &&
+	verify_head "$c1"
+'
+
+test_debug 'git log --graph --decorate --oneline --all'
+
 test_expect_success 'merge from unborn branch' '
 	git checkout -f main &&
 	test_might_fail git branch -D kid &&
@@ -322,6 +332,17 @@ test_expect_success 'merges with --ff-only' '
 	verify_head $c3
 '
 
+test_expect_success 'fast-forward' '
+	git reset --hard c1 &&
+	test_tick &&
+	test_must_fail git fast-forward c2 &&
+	test_must_fail git fast-forward c3 &&
+	test_must_fail git fast-forward c2 c3 &&
+	git reset --hard c0 &&
+	git merge c3 &&
+	verify_head $c3
+'
+
 test_expect_success 'merges with merge.ff=only' '
 	git reset --hard c1 &&
 	test_tick &&
-- 
2.32.0.36.g70aac2b1aa

