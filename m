Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD65CC6377B
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 00:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C250608FE
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 00:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbhGUX2h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 19:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhGUX2c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 19:28:32 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B39CC061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 17:09:08 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 42-20020a9d012d0000b02904b98d90c82cso3741152otu.5
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 17:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sXZ9gj/z/frAbn+U3wTThc7wjg5pEkPBNcsVYeS9iKo=;
        b=KXS0VbcqKlfNkoS3m8C86CLZ3CgHIttG7lY5iKdJF0d+Kim0zlsFrLfcEHrjB4n8q9
         xBIVN97w9Kq+hXmHxWNvI7d2edH+5UiIH16AaKFrfcLzFaPDgC61u3oQ+d77h5fobhOY
         nLYFI0/ZEFr6zubc9j+7a2p9X4/K9Cq56WPxPBeR4xXoHIw+6XHl77J+K0suH2ou+n9R
         Gca/izDskcoU1IkEGvEx8nl9kewa9xPHyyWGJ5K/ePLz19fnJfFJu9yatPHSAMplhHW+
         P0sK+rTsBgYwUVKorKJyYDG3/1k2s39g6KTvEJ/HVpoJKO27y+vgnfcmAJ23HP1CDcyx
         Op4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sXZ9gj/z/frAbn+U3wTThc7wjg5pEkPBNcsVYeS9iKo=;
        b=kP6vHmiOYKFU8d/O8c0S/ZKPOdbSClQ0KqBDDz5Pb212f0Fp8nike9Dva7L6AB7Lgu
         UrTiHEHZC7CV40pPwWsAkgCi6dWiIW5J7NHVgo0KgP4eC/FI4M8WkbMu9FF/Qw4EtRmL
         TjkTGI9joa8hBRh9t5Xkro/vjpunUimOQ9v+NkhgEiZjlwA6HWqHO6fLUROuN6o6g/Le
         6dLHktPZruSwFuTiV5ze++zsvgijiUFHLfeklCpeiS4bic6qy1ZNHV+1Eb8IPE8hSxsw
         T91HDN0WGKk1IPC176WRpLp/0ZK9raqfGea8K5+C3YSWmDJzlMK0+A5esCOn/isZpHJm
         F5Og==
X-Gm-Message-State: AOAM530VZPXjCktbcnsjUwUNMlEe/dV3GPU97s9mLhBS6kgDrWhuURUG
        G3+0E+9C1oi6Y3C2tTZgaKiYsTrVBHumUQ==
X-Google-Smtp-Source: ABdhPJx5nT57GTSEup9YPpX1eOz5QMczif9F8lHGAAjkF6uxpJ4g3xMU8Vkhfq6KS4hrOuUxqNusDw==
X-Received: by 2002:a9d:3a1:: with SMTP id f30mr28112444otf.195.1626912547326;
        Wed, 21 Jul 2021 17:09:07 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id r24sm4953458otg.14.2021.07.21.17.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 17:09:06 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, "Randall S . Becker" <rsbecker@nexbridge.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Denton Liu <liu.denton@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 5/7] fast-forward: add new builtin
Date:   Wed, 21 Jul 2021 19:08:52 -0500
Message-Id: <20210722000854.1899129-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.40.gb9b36f9b52
In-Reply-To: <20210722000854.1899129-1-felipe.contreras@gmail.com>
References: <20210722000854.1899129-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is one of the most common git operations, it makes sense it has its
own built-in.

Additionally it's more user friendly than `git merge` because by default
does --ff-only and thus shows the diverging advice.

Moreover, the documentation about fast-forwards is scattered, by having
a standalone command users can be referred to it very simply:

  git help fast-forward

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
index c7c46c017d..a05c309188 100644
--- a/Makefile
+++ b/Makefile
@@ -777,6 +777,7 @@ BUILT_INS += $(patsubst builtin/%.o,git-%$X,$(BUILTIN_OBJS))
 
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
index 2770dabf22..1836f98f82 100644
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
@@ -1742,3 +1751,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
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
index 4bdd27ddc8..ec00c20656 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1787,6 +1787,16 @@ _git_difftool ()
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
index 1cbc9715a8..9df1931236 100755
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
+	git fast-forward c3 &&
+	verify_head $c3
+'
+
 test_expect_success 'merges with merge.ff=only' '
 	git reset --hard c1 &&
 	test_tick &&
-- 
2.32.0.40.gb9b36f9b52

