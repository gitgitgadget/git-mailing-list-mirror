Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BC0C433DF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 17:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C45DF207FF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 17:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u0d3P7I6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgHSRRk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgHSRRN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 13:17:13 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2A6C061345
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 10:17:12 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c15so22249121wrs.11
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 10:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=r78Zz5GOXpIfgrcbYR+uGwBIYEgibxMJpGe9vnKEtPI=;
        b=u0d3P7I60MUKUu85YW5tARKcdguNa0TBEmMckBMm1+Jn9z2zEU3Z3oXqcAHfiiuZ/Z
         30T15AHNWmFyDL1h6l3TGu8o6F+Nprpfff2xOra53tZcceYq6mKJgstAN/TI1yQKmJgo
         sjrWON+9sTyh3bIQPjG/nV5dKa+ibwVKnfT4YQwGIiSOOcLaZns0erDUnnW/Xuimq0a9
         nJfIIivdqRr/JQOEKSXbQ11d6cB3W9tFe9ULulwG799cuWi/9CleRqnPQOfWqddIc7AI
         xZSdIhUjdLmYnz/IgmOwrLdvvf31adfgZ1td6UEZBL6rPAg6YGwQcNds9HK3Q6WSTCAT
         Jz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=r78Zz5GOXpIfgrcbYR+uGwBIYEgibxMJpGe9vnKEtPI=;
        b=VaQ5Uuo3MrjpQDLqemmPFou/cRmd0h7q6QEnD6RTFSmsLjmGuAg9JGOFmw/4WvSzxu
         TOBR7DVAkSw1eVRpTcIffH7LgtiGFtz3P1ELrPra9H4iAkvKfIBYIJ9x5VyyN44fYbQX
         s+pSUnjwMZVgikq4GDWLnlL7q1dqPYUqixjZtWrN2Dzx7AaTye64pmmWKpRDL57A0UlV
         nuqtZDWczlr9J9jONuzxayFiVE1AI1qa+iZtnLpI1M/HHKmy+vy6Y7Uun9/SDY+VtFbi
         9D8b+Nv1JagufMKguaO+morW5EDdY7gh1pT2VcfWiOHY2wNbNfrfJToajDz4iN4DI/rG
         WdUg==
X-Gm-Message-State: AOAM531hBk5G+1PTBJbWo+vegvh7AlZBIPiIJsKfiJcJYqFF8t8tbtke
        jE38ghhBbvBXSw3cQm+NGcf3JdubfNU=
X-Google-Smtp-Source: ABdhPJxTJqk1qVvPse0QsynljuXAJt9a7kF7V+mevcFZAIJzhIZjIJb01e9iPYEDx4Q3BHeX0+5TNg==
X-Received: by 2002:adf:f488:: with SMTP id l8mr4910302wro.123.1597857430582;
        Wed, 19 Aug 2020 10:17:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n18sm41631210wrp.58.2020.08.19.10.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 10:17:10 -0700 (PDT)
Message-Id: <2442071fd0581a221802e348182ed04267ef3044.1597857412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.680.git.1597857408.gitgitgadget@gmail.com>
References: <pull.680.git.1597857408.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Aug 2020 17:16:47 +0000
Subject: [PATCH 6/7] maintenance: add start/stop subcommands
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Add new subcommands to 'git maintenance' that start or stop background
maintenance using 'cron', when available. This integration is as simple
as I could make it, barring some implementation complications.

For now, the background maintenance is scheduled to run hourly via the
following cron table row (ignore line breaks):

	0 * * * * $p/git --exec-path=$p
		for-each-repo --config=maintenance.repo
		maintenance run --scheduled

Future extensions may want to add more complex schedules or some form of
logging. For now, hourly runs seem frequent enough to satisfy the needs
of tasks like 'prefetch' without being so frequent that users would
complain about many no-op commands.

Here, "$p" is a placeholder for the path to the current Git executable.
This is critical for systems with multiple versions of Git.
Specifically, macOS has a system version at '/usr/bin/git' while the
version that users can install resides at '/usr/local/bin/git' (symlinked
to '/usr/local/libexec/git-core/git'). This will also use your
locally-built version if you build and run this in your development
environment without installing first.

The GIT_TEST_CRONTAB environment variable is not intended for users to
edit, but instead as a way to mock the 'crontab [-l]' command. This
variable is set in test-lib.sh to avoid a future test from accidentally
running anything with the cron integration from modifying the user's
schedule. We use GIT_TEST_CRONTAB='test-tool crontab <file>' in our
tests to check how the schedule is modified in 'git maintenance
(start|stop)' commands.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-maintenance.txt |  11 +++
 Makefile                          |   1 +
 builtin/gc.c                      | 117 ++++++++++++++++++++++++++++++
 t/helper/test-crontab.c           |  35 +++++++++
 t/helper/test-tool.c              |   1 +
 t/helper/test-tool.h              |   1 +
 t/t7900-maintenance.sh            |  30 ++++++++
 t/test-lib.sh                     |   6 ++
 8 files changed, 202 insertions(+)
 create mode 100644 t/helper/test-crontab.c

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index ac6fcae678..600272caa5 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -45,6 +45,17 @@ run::
 	config options are true. By default, only `maintenance.gc.enabled`
 	is true.
 
+start::
+	Start running maintenance on the current repository. This performs
+	the same config updates as the `register` subcommand, then updates
+	the background scheduler to run `git maintenance run --scheduled`
+	on an hourly basis.
+
+stop::
+	Halt the background maintenance schedule. The current repository
+	is not removed from the list of maintained repositories, in case
+	the background maintenance is restarted later.
+
 unregister::
 	Remove the current repository from background maintenance. This
 	only removes the repository from the configured list. It does not
diff --git a/Makefile b/Makefile
index 7c588ff036..c39b39bd7d 100644
--- a/Makefile
+++ b/Makefile
@@ -690,6 +690,7 @@ TEST_BUILTINS_OBJS += test-advise.o
 TEST_BUILTINS_OBJS += test-bloom.o
 TEST_BUILTINS_OBJS += test-chmtime.o
 TEST_BUILTINS_OBJS += test-config.o
+TEST_BUILTINS_OBJS += test-crontab.o
 TEST_BUILTINS_OBJS += test-ctype.o
 TEST_BUILTINS_OBJS += test-date.o
 TEST_BUILTINS_OBJS += test-delta.o
diff --git a/builtin/gc.c b/builtin/gc.c
index eb8a0a52ab..b09287f0fc 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -32,6 +32,7 @@
 #include "remote.h"
 #include "midx.h"
 #include "object-store.h"
+#include "exec-cmd.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -1494,6 +1495,118 @@ static int maintenance_unregister(void)
 	return run_command(&config_unset);
 }
 
+#define BEGIN_LINE "# BEGIN GIT MAINTENANCE SCHEDULE"
+#define END_LINE "# END GIT MAINTENANCE SCHEDULE"
+
+static int update_background_schedule(int run_maintenance)
+{
+	int result = 0;
+	int in_old_region = 0;
+	struct child_process crontab_list = CHILD_PROCESS_INIT;
+	struct child_process crontab_edit = CHILD_PROCESS_INIT;
+	FILE *cron_list, *cron_in;
+	const char *crontab_name;
+	struct strbuf line = STRBUF_INIT;
+	struct lock_file lk;
+	char *lock_path = xstrfmt("%s/schedule", the_repository->objects->odb->path);
+
+	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0)
+		return error(_("another process is scheduling background maintenance"));
+
+	crontab_name = getenv("GIT_TEST_CRONTAB");
+	if (!crontab_name)
+		crontab_name = "crontab";
+
+	strvec_split(&crontab_list.args, crontab_name);
+	strvec_push(&crontab_list.args, "-l");
+	crontab_list.in = -1;
+	crontab_list.out = dup(lk.tempfile->fd);
+	crontab_list.git_cmd = 0;
+
+	if (start_command(&crontab_list)) {
+		result = error(_("failed to run 'crontab -l'; your system might not support 'cron'"));
+		goto cleanup;
+	}
+
+	/* Ignore exit code, as an empty crontab will return error. */
+	finish_command(&crontab_list);
+
+	/*
+	 * Read from the .lock file, filtering out the old
+	 * schedule while appending the new schedule.
+	 */
+	cron_list = fdopen(lk.tempfile->fd, "r");
+	rewind(cron_list);
+
+	strvec_split(&crontab_edit.args, crontab_name);
+	crontab_edit.in = -1;
+	crontab_edit.git_cmd = 0;
+
+	if (start_command(&crontab_edit)) {
+		result = error(_("failed to run 'crontab'; your system might not support 'cron'"));
+		goto cleanup;
+	}
+
+	cron_in = fdopen(crontab_edit.in, "w");
+	if (!cron_in) {
+		result = error(_("failed to open stdin of 'crontab'"));
+		goto done_editing;
+	}
+
+	while (!strbuf_getline_lf(&line, cron_list)) {
+		if (!in_old_region && !strcmp(line.buf, BEGIN_LINE))
+			in_old_region = 1;
+		if (in_old_region)
+			continue;
+		fprintf(cron_in, "%s\n", line.buf);
+		if (in_old_region && !strcmp(line.buf, END_LINE))
+			in_old_region = 0;
+	}
+
+	if (run_maintenance) {
+		const char *exec_path = git_exec_path();
+
+		fprintf(cron_in, "\n%s\n", BEGIN_LINE);
+		fprintf(cron_in, "# The following schedule was created by Git\n");
+		fprintf(cron_in, "# Any edits made in this region might be\n");
+		fprintf(cron_in, "# replaced in the future by a Git command.\n\n");
+
+		fprintf(cron_in,
+			"0 * * * * \"%s/git\" --exec-path=\"%s\" for-each-repo --config=maintenance.repo maintenance run --scheduled\n",
+			exec_path, exec_path);
+
+		fprintf(cron_in, "\n%s\n", END_LINE);
+	}
+
+	fflush(cron_in);
+	fclose(cron_in);
+	close(crontab_edit.in);
+
+done_editing:
+	if (finish_command(&crontab_edit)) {
+		result = error(_("'crontab' died"));
+		goto cleanup;
+	}
+	fclose(cron_list);
+
+cleanup:
+	rollback_lock_file(&lk);
+	return result;
+}
+
+static int maintenance_start(void)
+{
+	if (maintenance_register())
+		warning(_("failed to add repo to global config"));
+
+	return update_background_schedule(1);
+}
+
+static int maintenance_stop(void)
+{
+	return update_background_schedule(0);
+}
+
 int cmd_maintenance(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -1539,6 +1652,10 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
 		return maintenance_register();
 	if (!strcmp(argv[0], "run"))
 		return maintenance_run(&opts);
+	if (!strcmp(argv[0], "start"))
+		return maintenance_start();
+	if (!strcmp(argv[0], "stop"))
+		return maintenance_stop();
 	if (!strcmp(argv[0], "unregister"))
 		return maintenance_unregister();
 
diff --git a/t/helper/test-crontab.c b/t/helper/test-crontab.c
new file mode 100644
index 0000000000..f5db6319c6
--- /dev/null
+++ b/t/helper/test-crontab.c
@@ -0,0 +1,35 @@
+#include "test-tool.h"
+#include "cache.h"
+
+/*
+ * Usage: test-tool cron <file> [-l]
+ *
+ * If -l is specified, then write the contents of <file> to stdou.
+ * Otherwise, write from stdin into <file>.
+ */
+int cmd__crontab(int argc, const char **argv)
+{
+	char a;
+	FILE *from, *to;
+
+	if (argc == 3 && !strcmp(argv[2], "-l")) {
+		from = fopen(argv[1], "r");
+		if (!from)
+			return 0;
+		to = stdout;
+	} else if (argc == 2) {
+		from = stdin;
+		to = fopen(argv[1], "w");
+	} else
+		return error("unknown arguments");
+
+	while ((a = fgetc(from)) != EOF)
+		fputc(a, to);
+
+	if (argc == 3)
+		fclose(from);
+	else
+		fclose(to);
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 590b2efca7..432b49d948 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -18,6 +18,7 @@ static struct test_cmd cmds[] = {
 	{ "bloom", cmd__bloom },
 	{ "chmtime", cmd__chmtime },
 	{ "config", cmd__config },
+	{ "crontab", cmd__crontab },
 	{ "ctype", cmd__ctype },
 	{ "date", cmd__date },
 	{ "delta", cmd__delta },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index ddc8e990e9..7c3281e071 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -8,6 +8,7 @@ int cmd__advise_if_enabled(int argc, const char **argv);
 int cmd__bloom(int argc, const char **argv);
 int cmd__chmtime(int argc, const char **argv);
 int cmd__config(int argc, const char **argv);
+int cmd__crontab(int argc, const char **argv);
 int cmd__ctype(int argc, const char **argv);
 int cmd__date(int argc, const char **argv);
 int cmd__delta(int argc, const char **argv);
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index b20ee2d542..6491031be8 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -309,4 +309,34 @@ test_expect_success 'register and unregister' '
 	test_cmp before actual
 '
 
+test_expect_success 'start from empty cron table' '
+	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance start &&
+
+	# start registers the repo
+	git config --get --global maintenance.repo "$(pwd)" &&
+
+	grep "for-each-repo --config=maintenance.repo maintenance run --scheduled" cron.txt
+'
+
+test_expect_success 'stop from existing schedule' '
+	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance stop &&
+
+	# stop does not unregister the repo
+	git config --get --global maintenance.repo "$(pwd)" &&
+
+	# The newline is preserved
+	echo >empty &&
+	test_cmp empty cron.txt &&
+
+	# Operation is idempotent
+	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance stop &&
+	test_cmp empty cron.txt
+'
+
+test_expect_success 'start preserves existing schedule' '
+	echo "Important information!" >cron.txt &&
+	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance start &&
+	grep "Important information!" cron.txt
+'
+
 test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index ef31f40037..4a60d1ed76 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1702,3 +1702,9 @@ test_lazy_prereq SHA1 '
 test_lazy_prereq REBASE_P '
 	test -z "$GIT_TEST_SKIP_REBASE_P"
 '
+
+# Ensure that no test accidentally triggers a Git command
+# that runs 'crontab', affecting a user's cron schedule.
+# Tests that verify the cron integration must set this locally
+# to avoid errors.
+GIT_TEST_CRONTAB="exit 1"
-- 
gitgitgadget

