Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AB7C4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 13:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3118320848
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 13:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eP9LyA3f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgJENER (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 09:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgJENEK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 09:04:10 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79385C0613B5
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 05:57:22 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l15so5838648wmh.1
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 05:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fa90TYFI5LjZNfWJEszlEKRKMQdHQSZaM6H+f7lq+KY=;
        b=eP9LyA3f5gVw1KS2pnPwy67Yk4CHR+yKMEkR6wcnEeCucGrjiGR13UKIhBxdR+uBit
         Kv9/aI/vTmV2mXdmX5WK8gEBBCcxLkFYV7betbten5QtLD2cBmXI2zKLSCjcAw35WF/5
         7Fo88eNw/j77MDNzatK1D617EdusagTgjK3Jh9AS3a+x5odARW+ggogzmKo1LQO0eo4B
         9QNbklKGoUl0Dv3ouDX7VzGSs6LxmYxjRkR5Fmi/IatD9g0MXufgID5ikS4dARdHpeqq
         PY2EpJHK08xZb6gWSwGx28J9Gf2eLXxsyHE+k6hL7P1vSt7QKdJmDtEb/OX17LgYCYiE
         3Sqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fa90TYFI5LjZNfWJEszlEKRKMQdHQSZaM6H+f7lq+KY=;
        b=Rml4grR/i0h1JBvbl9qqgHJPsvkOnGf0GueKeF06lOeC2xfZFPdSY/p2GR7yXnChTM
         m4UmBALdWTJYRhcuv2xPcXlpP2N9Z2EzRsGay93CWiX7o7Jb38uO1jT6a9E0Km3qhTue
         fH5j30Nd1ddt7d6ke8cyv/srX5C0e2+iBf+dP0iW60I/X8CyMOqLyKihTDCObTWD+zMF
         pndkZo5T9uzuGGp+HFCeLicyLm6If085pyGpyXhNknMIrkAsgVTk7/WE1Pjxd0QwTpga
         fMTp4JcWcZQsdcCThaaiOmTXzifvHUtnDkLsKP5Tv0ldrzbdiaa0Qgbt3uYWpx/0oODM
         m+RQ==
X-Gm-Message-State: AOAM533OY9v4mYi5vYLMUXiAv/rO6JKFQhuugFy7AzcLuEmtcedbyYQ8
        7OFhFgMgL2qyJlqjHnvF8U331QZwqEw=
X-Google-Smtp-Source: ABdhPJwjv2+6kCKPcNL9nHGvX8e+U00HylPTXUWssUKPlvvGETcW0nrzXOAaXfedNqrESc4IZvThug==
X-Received: by 2002:a1c:9a0c:: with SMTP id c12mr17313088wme.85.1601902640663;
        Mon, 05 Oct 2020 05:57:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z11sm9327168wrh.70.2020.10.05.05.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 05:57:20 -0700 (PDT)
Message-Id: <5194f6b1facbd14cc17eea0337c0cc397a2a51fc.1601902635.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.724.v3.git.1601902635.gitgitgadget@gmail.com>
References: <pull.724.v2.git.1599846560.gitgitgadget@gmail.com>
        <pull.724.v3.git.1601902635.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Oct 2020 12:57:12 +0000
Subject: [PATCH v3 5/7] maintenance: add start/stop subcommands
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, jonathantanmy@google.com, sluongng@gmail.com,
        congdanhqx@gmail.com,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Add new subcommands to 'git maintenance' that start or stop background
maintenance using 'cron', when available. This integration is as simple
as I could make it, barring some implementation complications.

The schedule is laid out as follows:

  0 1-23 * * *   $cmd maintenance run --schedule=hourly
  0 0    * * 1-6 $cmd maintenance run --schedule=daily
  0 0    * * 0   $cmd maintenance run --schedule=weekly

where $cmd is a properly-qualified 'git for-each-repo' execution:

$cmd=$path/git --exec-path=$path for-each-repo --config=maintenance.repo

where $path points to the location of the Git executable running 'git
maintenance start'. This is critical for systems with multiple versions
of Git. Specifically, macOS has a system version at '/usr/bin/git' while
the version that users can install resides at '/usr/local/bin/git'
(symlinked to '/usr/local/libexec/git-core/git'). This will also use
your locally-built version if you build and run this in your development
environment without installing first.

This conditional schedule avoids having cron launch multiple 'git
for-each-repo' commands in parallel. Such parallel commands would likely
lead to the 'hourly' and 'daily' tasks competing over the object
database lock. This could lead to to some tasks never being run! Since
the --schedule=<frequency> argument will run all tasks with _at least_
the given frequency, the daily runs will also run the hourly tasks.
Similarly, the weekly runs will also run the daily and hourly tasks.

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
 builtin/gc.c                      | 124 ++++++++++++++++++++++++++++++
 t/helper/test-crontab.c           |  35 +++++++++
 t/helper/test-tool.c              |   1 +
 t/helper/test-tool.h              |   1 +
 t/t7900-maintenance.sh            |  28 +++++++
 t/test-lib.sh                     |   6 ++
 8 files changed, 207 insertions(+)
 create mode 100644 t/helper/test-crontab.c

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 1c59fd0cb5..7628a6d157 100644
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
index edf1d35ce5..a387f46585 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -31,6 +31,7 @@
 #include "refs.h"
 #include "remote.h"
 #include "object-store.h"
+#include "exec-cmd.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -1456,6 +1457,125 @@ static int maintenance_unregister(void)
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
+		struct strbuf line_format = STRBUF_INIT;
+		const char *exec_path = git_exec_path();
+
+		fprintf(cron_in, "%s\n", BEGIN_LINE);
+		fprintf(cron_in,
+			"# The following schedule was created by Git\n");
+		fprintf(cron_in, "# Any edits made in this region might be\n");
+		fprintf(cron_in,
+			"# replaced in the future by a Git command.\n\n");
+
+		strbuf_addf(&line_format,
+			    "%%s %%s * * %%s \"%s/git\" --exec-path=\"%s\" for-each-repo --config=maintenance.repo maintenance run --schedule=%%s\n",
+			    exec_path, exec_path);
+		fprintf(cron_in, line_format.buf, "0", "1-23", "*", "hourly");
+		fprintf(cron_in, line_format.buf, "0", "0", "1-6", "daily");
+		fprintf(cron_in, line_format.buf, "0", "0", "0", "weekly");
+		strbuf_release(&line_format);
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
 static const char builtin_maintenance_usage[] =	N_("git maintenance <subcommand> [<options>]");
 
 int cmd_maintenance(int argc, const char **argv, const char *prefix)
@@ -1466,6 +1586,10 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
 
 	if (!strcmp(argv[1], "run"))
 		return maintenance_run(argc - 1, argv + 1, prefix);
+	if (!strcmp(argv[1], "start"))
+		return maintenance_start();
+	if (!strcmp(argv[1], "stop"))
+		return maintenance_stop();
 	if (!strcmp(argv[1], "register"))
 		return maintenance_register();
 	if (!strcmp(argv[1], "unregister"))
diff --git a/t/helper/test-crontab.c b/t/helper/test-crontab.c
new file mode 100644
index 0000000000..e7c0137a47
--- /dev/null
+++ b/t/helper/test-crontab.c
@@ -0,0 +1,35 @@
+#include "test-tool.h"
+#include "cache.h"
+
+/*
+ * Usage: test-tool cron <file> [-l]
+ *
+ * If -l is specified, then write the contents of <file> to stdout.
+ * Otherwise, write from stdin into <file>.
+ */
+int cmd__crontab(int argc, const char **argv)
+{
+	int a;
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
index 8f383d01d9..7715e40391 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -315,4 +315,32 @@ test_expect_success 'register and unregister' '
 	test_cmp before actual
 '
 
+test_expect_success 'start from empty cron table' '
+	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance start &&
+
+	# start registers the repo
+	git config --get --global maintenance.repo "$(pwd)" &&
+
+	grep "for-each-repo --config=maintenance.repo maintenance run --schedule=daily" cron.txt &&
+	grep "for-each-repo --config=maintenance.repo maintenance run --schedule=hourly" cron.txt &&
+	grep "for-each-repo --config=maintenance.repo maintenance run --schedule=weekly" cron.txt
+'
+
+test_expect_success 'stop from existing schedule' '
+	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance stop &&
+
+	# stop does not unregister the repo
+	git config --get --global maintenance.repo "$(pwd)" &&
+
+	# Operation is idempotent
+	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance stop &&
+	test_must_be_empty cron.txt
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

