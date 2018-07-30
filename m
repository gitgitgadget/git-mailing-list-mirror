Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C1E81F597
	for <e@80x24.org>; Mon, 30 Jul 2018 16:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731857AbeG3SFb (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 14:05:31 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37093 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeG3SFa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 14:05:30 -0400
Received: by mail-ed1-f66.google.com with SMTP id b10-v6so4397299eds.4
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 09:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N9cz8Q16mkuShO4OlTNSbO504BEVpJH3ZpdG4tA+SXA=;
        b=B9QhZU6ekZlHMv+y6/UskAPCOxER5tD4jANq79/INEh6Uxi9XMYxzUUN7J4PcBKlVp
         BxRGsYiIRgSXSTXj41VyQhhKbYiNlKKxjbzUADqT9M9vXT6bHfBMeYAEQQP3m/pStLm7
         mISvBT66+/x8GaV/lLazG0bbaJtmdlzBN0AA5xtDMYglWpXELAM6DIjFKTLU1cZ7QAJ8
         W6h2272AEB+/5IOixOyukyTNPOtN4IxiA11gvrcSU3wZ1YokLzCyOpsoxs/lj8MQmmKY
         52NJN9rRJsVmS97GxIt8k7mkMDQfIQw/I9nDwXFi0PUHxC/D947a3kFEF6VwShGUGBdj
         PJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N9cz8Q16mkuShO4OlTNSbO504BEVpJH3ZpdG4tA+SXA=;
        b=txrZb7QcXdlxo4vy49iEBxslujp/cURenJuKqnGP+I/H3qacEszqmxgUj0Fu2ncLeP
         W3vRokChQb1jNmoDqkNjNBscuHctHcMP2ujou8nBHSluvqrpyxPNFh+Swl5NY2YktM2n
         AWFeMdFESc16s6UODt3AimU+7zpykxfFPAs1UcnKTnGAVhCVxVeeyn+QBVU/aXo87vqK
         73hxzaSD1Uz7nmDOAX1HyxhveipJbqOfpDD7lSX9TgGos5ycD2z8SsfTg0z58rNpBTEN
         eqxyr1L+4MuQhGK88oaZ8nKJLwf/PA+JfdV8X4v5RW1hETeH20gorA2MR9sNeLvySxiP
         RnvA==
X-Gm-Message-State: AOUpUlHg5uwLbCY+kYxG0kgTV+9p33/jbxyfKhKqgfyyzHSr58psvsfR
        qaerr7PD9qUFEAsHEgQpPaPXKh6ppp0=
X-Google-Smtp-Source: AAOMgpfYI2/AKfe3A+pV4vXExczHyCo5uWeAx3SqAgRl913uI5nUDu9V0zmVopPtXyA7LQ6FZHK42g==
X-Received: by 2002:a50:aec9:: with SMTP id f9-v6mr8747324edd.72.1532968183532;
        Mon, 30 Jul 2018 09:29:43 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.81])
        by smtp.gmail.com with ESMTPSA id a13-v6sm2880906edf.84.2018.07.30.09.29.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 09:29:42 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        rybak.a.v@gmail.com, dev+git@drbeat.li, pclouds@gmail.com,
        sunshine@sunshineco.com, Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH v5 1/3] rebase: start implementing it as a builtin
Date:   Mon, 30 Jul 2018 22:14:18 +0545
Message-Id: <20180730162920.20318-2-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180730162920.20318-1-predatoramigo@gmail.com>
References: <20180708180104.17921-1-predatoramigo@gmail.com>
 <20180730162920.20318-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit imitates the strategy that was used to convert the
difftool to a builtin. We start by renaming the shell script
`git-rebase.sh` to `git-legacy-rebase.sh` and introduce a
`builtin/rebase.c` that simply executes the shell script version,
unless the config setting `rebase.useBuiltin` is set to `true`.

The motivation behind this is to rewrite all the functionality of the
shell script version in the aforementioned `rebase.c`, one by one and
be able to conveniently test new features by configuring
`rebase.useBuiltin`.

In the original difftool conversion, if sane_execvp() that attempts to
run the legacy scripted version returned with non-negative status, the
command silently exited without doing anything with success, but
sane_execvp() should not return with non-negative status in the first
place, so we use die() to notice such an abnormal case.

We intentionally avoid reading the config directly to avoid
messing up the GIT_* environment variables when we need to fall back to
exec()ing the shell script. The test of builtin rebase can be done by
`git -c rebase.useBuiltin=true rebase ...`

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 .gitignore                            |  1 +
 Makefile                              |  3 +-
 builtin.h                             |  1 +
 builtin/rebase.c                      | 58 +++++++++++++++++++++++++++
 git-rebase.sh => git-legacy-rebase.sh |  0
 git.c                                 |  6 +++
 6 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 builtin/rebase.c
 rename git-rebase.sh => git-legacy-rebase.sh (100%)

diff --git a/.gitignore b/.gitignore
index 3284a1e9b1..ec23959014 100644
--- a/.gitignore
+++ b/.gitignore
@@ -78,6 +78,7 @@
 /git-init-db
 /git-interpret-trailers
 /git-instaweb
+/git-legacy-rebase
 /git-log
 /git-ls-files
 /git-ls-remote
diff --git a/Makefile b/Makefile
index 08e5c54549..a0c410b7d6 100644
--- a/Makefile
+++ b/Makefile
@@ -609,7 +609,7 @@ SCRIPT_SH += git-merge-one-file.sh
 SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-quiltimport.sh
-SCRIPT_SH += git-rebase.sh
+SCRIPT_SH += git-legacy-rebase.sh
 SCRIPT_SH += git-remote-testgit.sh
 SCRIPT_SH += git-request-pull.sh
 SCRIPT_SH += git-stash.sh
@@ -1059,6 +1059,7 @@ BUILTIN_OBJS += builtin/prune.o
 BUILTIN_OBJS += builtin/pull.o
 BUILTIN_OBJS += builtin/push.o
 BUILTIN_OBJS += builtin/read-tree.o
+BUILTIN_OBJS += builtin/rebase.o
 BUILTIN_OBJS += builtin/rebase--helper.o
 BUILTIN_OBJS += builtin/receive-pack.o
 BUILTIN_OBJS += builtin/reflog.o
diff --git a/builtin.h b/builtin.h
index 0362f1ce25..44651a447f 100644
--- a/builtin.h
+++ b/builtin.h
@@ -202,6 +202,7 @@ extern int cmd_prune_packed(int argc, const char **argv, const char *prefix);
 extern int cmd_pull(int argc, const char **argv, const char *prefix);
 extern int cmd_push(int argc, const char **argv, const char *prefix);
 extern int cmd_read_tree(int argc, const char **argv, const char *prefix);
+extern int cmd_rebase(int argc, const char **argv, const char *prefix);
 extern int cmd_rebase__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_receive_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_reflog(int argc, const char **argv, const char *prefix);
diff --git a/builtin/rebase.c b/builtin/rebase.c
new file mode 100644
index 0000000000..c44addb2a4
--- /dev/null
+++ b/builtin/rebase.c
@@ -0,0 +1,58 @@
+/*
+ * "git rebase" builtin command
+ *
+ * Copyright (c) 2018 Pratik Karki
+ */
+
+#include "builtin.h"
+#include "run-command.h"
+#include "exec-cmd.h"
+#include "argv-array.h"
+#include "dir.h"
+
+static int use_builtin_rebase(void)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf out = STRBUF_INIT;
+	int ret;
+
+	argv_array_pushl(&cp.args,
+			 "config", "--bool", "rebase.usebuiltin", NULL);
+	cp.git_cmd = 1;
+	if (capture_command(&cp, &out, 6)) {
+		strbuf_release(&out);
+		return 0;
+	}
+
+	strbuf_trim(&out);
+	ret = !strcmp("true", out.buf);
+	strbuf_release(&out);
+	return ret;
+}
+
+int cmd_rebase(int argc, const char **argv, const char *prefix)
+{
+	/*
+	 * NEEDSWORK: Once the builtin rebase has been tested enough
+	 * and git-legacy-rebase.sh is retired to contrib/, this preamble
+	 * can be removed.
+	 */
+
+	if (!use_builtin_rebase()) {
+		const char *path = mkpath("%s/git-legacy-rebase",
+					  git_exec_path());
+
+		if (sane_execvp(path, (char **)argv) < 0)
+			die_errno(_("could not exec %s"), path);
+		else
+			BUG("sane_execvp() returned???");
+	}
+
+	if (argc != 2)
+		die(_("Usage: %s <base>"), argv[0]);
+	prefix = setup_git_directory();
+	trace_repo_setup(prefix);
+	setup_work_tree();
+
+	die("TODO");
+}
diff --git a/git-rebase.sh b/git-legacy-rebase.sh
similarity index 100%
rename from git-rebase.sh
rename to git-legacy-rebase.sh
diff --git a/git.c b/git.c
index 3fded74519..d28ad90e31 100644
--- a/git.c
+++ b/git.c
@@ -518,6 +518,12 @@ static struct cmd_struct commands[] = {
 	{ "pull", cmd_pull, RUN_SETUP | NEED_WORK_TREE },
 	{ "push", cmd_push, RUN_SETUP },
 	{ "read-tree", cmd_read_tree, RUN_SETUP | SUPPORT_SUPER_PREFIX},
+	/*
+	 * NEEDSWORK: Until the rebase is independent and needs no redirection
+	 * to rebase shell script this is kept as is, then should be changed to
+	 * RUN_SETUP | NEED_WORK_TREE
+	 */
+	{ "rebase", cmd_rebase },
 	{ "rebase--helper", cmd_rebase__helper, RUN_SETUP | NEED_WORK_TREE },
 	{ "receive-pack", cmd_receive_pack },
 	{ "reflog", cmd_reflog, RUN_SETUP },
-- 
2.18.0

