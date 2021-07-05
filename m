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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C203EC07E9B
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A22EC613AE
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhGEMfD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbhGEMfD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:35:03 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC329C06175F
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:32:25 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id l17-20020a9d6a910000b029048a51f0bc3cso6382766otq.13
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wjUg5qrCey4k1agU9PzN1PdkiiwmL6fLsr5SxRKwgWo=;
        b=FS6TTKA/SdlCyeuQM6NJ3XTYb8WWQvhSEi6WtGO4AzRBHDKOGY66a6DnJ8GpnyAP/P
         vPn4CaRsMkPtTX1lt9+r+Io3X2WqdnsFgNpzin14gfJ+4pQPz67o+S9BCWbd8C2cYM5D
         N30T/7W3mpMAH2Yh6aj+8Sz5ey7v3Vy7DzfCgBk+EeXyoYgmwEFsX1+srWB72c509Kbf
         FE3omwIjyoQ5uzbbR3H6bK275ML7eOairZszfxcgOMwcx9eK05ZjOmb1n7Hq9GE3GGZG
         nEllR2Te/MdGJn7QySbsqoIVblak9B+WaJ9tXx0ydlK3ZDCJYrNsNpmq/lCtKG/YGH6o
         AWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wjUg5qrCey4k1agU9PzN1PdkiiwmL6fLsr5SxRKwgWo=;
        b=a1RMMrlCzoY/z/Wybnb/O4K3lI2YlpUF0N1OS8y++wv40B1fdXNyKXu8C6Ki8hBaoP
         ++wdtMBMijQRIncWievFX9siz6+VGwga0w0KOYQ3x3dto7LiG6b5e6+GtvoHm5VzEL3E
         iKfkCDnK9sK3c5PkU4eqG3WsKbCUqqr4nwSJVU+Pex1Igdr0QNFO5vgDbhXcHx6YTl98
         m/Ew6UbmWguh/iGlFXRg4yZpf2uVLPMutmqCiqzIz1NGGW8mbUkAJkAlTHh67KRcQQ5H
         lc1L/TLeVYRsXF+p/ZLwNjg9xxMgXBeyys2CNutCNObosuCy5sxVwDfdDM4+OQ9vM955
         GTGg==
X-Gm-Message-State: AOAM533CV6595fdh0llqEbOM3kOvyLtMK7oXAimGiZag7OIZ2eJ87xaV
        bTEfgC7Yzyp+HfstSgxuPCTRMQ+MbFh93g==
X-Google-Smtp-Source: ABdhPJxMWGXbFtU/bFMmEpf3jRtIzNhE4g9PPjM+NaIKD1vG5fuOJT3hiyn8lH+UdLLHOIk0ktSqXA==
X-Received: by 2002:a05:6830:25cb:: with SMTP id d11mr5378642otu.56.1625488345002;
        Mon, 05 Jul 2021 05:32:25 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id 59sm2600403oto.3.2021.07.05.05.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:32:24 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 08/35] update: new built-in
Date:   Mon,  5 Jul 2021 07:31:42 -0500
Message-Id: <20210705123209.1808663-9-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210705123209.1808663-1-felipe.contreras@gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is basically `git fetch` + `git fast-forward`.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 .gitignore                             |  1 +
 Documentation/config.txt               |  2 ++
 Documentation/git-update.txt           | 32 +++++++++++++++++
 Makefile                               |  1 +
 builtin.h                              |  1 +
 builtin/update.c                       | 48 ++++++++++++++++++++++++++
 contrib/completion/git-completion.bash | 12 +++++++
 git.c                                  |  1 +
 t/t5563-update.sh                      | 45 ++++++++++++++++++++++++
 9 files changed, 143 insertions(+)
 create mode 100644 Documentation/git-update.txt
 create mode 100644 builtin/update.c
 create mode 100755 t/t5563-update.sh

diff --git a/.gitignore b/.gitignore
index 45703399b0..2a3bc43ef2 100644
--- a/.gitignore
+++ b/.gitignore
@@ -171,6 +171,7 @@
 /git-tag
 /git-unpack-file
 /git-unpack-objects
+/git-update
 /git-update-index
 /git-update-ref
 /git-update-server-info
diff --git a/Documentation/config.txt b/Documentation/config.txt
index bf82766a6a..fc4b49c0d4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -440,6 +440,8 @@ include::config/rerere.txt[]
 
 include::config/reset.txt[]
 
+include::config/update.txt[]
+
 include::config/sendemail.txt[]
 
 include::config/sequencer.txt[]
diff --git a/Documentation/git-update.txt b/Documentation/git-update.txt
new file mode 100644
index 0000000000..54c49c5d12
--- /dev/null
+++ b/Documentation/git-update.txt
@@ -0,0 +1,32 @@
+git-update(1)
+=============
+
+NAME
+----
+git-update - Update the current branch to the latest remote
+
+SYNOPSIS
+--------
+[verse]
+'git update'
+
+DESCRIPTION
+-----------
+
+Incorporates changes from a remote repository into the current branch.
+
+`git update` runs `git fetch` and then tries to advance the current branch to
+the remote branch with `git fast-forward`. If you don't have any extra changes
+the update operation is straight-forward, but if you do a further `git merge` or
+`git rebase` will be needed.
+
+THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOUR MAY CHANGE.
+
+SEE ALSO
+--------
+linkgit:git-fetch[1], linkgit:git-fast-forward[1],
+linkgit:git-merge[1], linkgit:git-rebase[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index cf42162a07..6450574feb 100644
--- a/Makefile
+++ b/Makefile
@@ -1161,6 +1161,7 @@ BUILTIN_OBJS += builtin/symbolic-ref.o
 BUILTIN_OBJS += builtin/tag.o
 BUILTIN_OBJS += builtin/unpack-file.o
 BUILTIN_OBJS += builtin/unpack-objects.o
+BUILTIN_OBJS += builtin/update.o
 BUILTIN_OBJS += builtin/update-index.o
 BUILTIN_OBJS += builtin/update-ref.o
 BUILTIN_OBJS += builtin/update-server-info.o
diff --git a/builtin.h b/builtin.h
index 601e438c9b..7d18897682 100644
--- a/builtin.h
+++ b/builtin.h
@@ -229,6 +229,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix);
 int cmd_tar_tree(int argc, const char **argv, const char *prefix);
 int cmd_unpack_file(int argc, const char **argv, const char *prefix);
 int cmd_unpack_objects(int argc, const char **argv, const char *prefix);
+int cmd_update(int argc, const char **argv, const char *prefix);
 int cmd_update_index(int argc, const char **argv, const char *prefix);
 int cmd_update_ref(int argc, const char **argv, const char *prefix);
 int cmd_update_server_info(int argc, const char **argv, const char *prefix);
diff --git a/builtin/update.c b/builtin/update.c
new file mode 100644
index 0000000000..51e45b453d
--- /dev/null
+++ b/builtin/update.c
@@ -0,0 +1,48 @@
+/*
+ * Copyright (C) 2021 Felipe Contreras
+ */
+
+#include "builtin.h"
+#include "run-command.h"
+#include "dir.h"
+
+static int run_fetch(void)
+{
+	struct strvec args = STRVEC_INIT;
+	int ret;
+
+	strvec_pushl(&args, "fetch", "--update-head-ok", NULL);
+
+	ret = run_command_v_opt(args.v, RUN_GIT_CMD);
+	strvec_clear(&args);
+	return ret;
+}
+
+static int run_fast_forward(void)
+{
+	struct strvec args = STRVEC_INIT;
+	int ret;
+
+	strvec_pushl(&args, "fast-forward", "FETCH_HEAD", NULL);
+
+	ret = run_command_v_opt(args.v, RUN_GIT_CMD);
+	strvec_clear(&args);
+	return ret;
+}
+
+int cmd_update(int argc, const char **argv, const char *prefix)
+{
+	if (!getenv("GIT_REFLOG_ACTION"))
+		setenv("GIT_REFLOG_ACTION", "update", 0);
+
+	if (repo_read_index_unmerged(the_repository))
+		die_resolve_conflict("update");
+
+	if (file_exists(git_path_merge_head(the_repository)))
+		die_conclude_merge();
+
+	if (run_fetch())
+		return 1;
+
+	return run_fast_forward();
+}
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index cfaee3aaeb..c5214d9856 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3257,6 +3257,18 @@ _git_tag ()
 	esac
 }
 
+_git_update ()
+{
+	case "$cur" in
+	--*)
+		__gitcomp_builtin update
+
+		return
+		;;
+	esac
+	__git_complete_remote_or_refspec
+}
+
 _git_whatchanged ()
 {
 	_git_log
diff --git a/git.c b/git.c
index 6ab1fb9251..0156ea81a4 100644
--- a/git.c
+++ b/git.c
@@ -610,6 +610,7 @@ static struct cmd_struct commands[] = {
 	{ "tag", cmd_tag, RUN_SETUP | DELAY_PAGER_CONFIG },
 	{ "unpack-file", cmd_unpack_file, RUN_SETUP | NO_PARSEOPT },
 	{ "unpack-objects", cmd_unpack_objects, RUN_SETUP | NO_PARSEOPT },
+	{ "update", cmd_update, RUN_SETUP | NEED_WORK_TREE },
 	{ "update-index", cmd_update_index, RUN_SETUP },
 	{ "update-ref", cmd_update_ref, RUN_SETUP },
 	{ "update-server-info", cmd_update_server_info, RUN_SETUP },
diff --git a/t/t5563-update.sh b/t/t5563-update.sh
new file mode 100755
index 0000000000..951df41ac4
--- /dev/null
+++ b/t/t5563-update.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+
+test_description='update'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo one > file &&
+	git add file &&
+	git commit -a -m one &&
+	echo two > file &&
+	git commit -a -m two
+'
+
+test_expect_success 'basic update' '
+	test_when_finished "rm -rf test" &&
+	(
+	git clone . test &&
+	cd test &&
+	git reset --hard @^ &&
+	git update &&
+	test_cmp_rev master origin/master
+	)
+'
+
+test_expect_success 'non-fast-forward update' '
+	test_when_finished "rm -rf test" &&
+	(
+	git clone . test &&
+	cd test &&
+	git checkout -b other master^ &&
+	>new &&
+	git add new &&
+	git commit -m new &&
+	git checkout -b test -t other &&
+	git reset --hard master &&
+	test_must_fail git update &&
+	test_cmp_rev @ master
+	)
+'
+
+test_done
-- 
2.32.0.36.g70aac2b1aa

