Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83E0C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D3032074D
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCI8Zgl4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgHYSkc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgHYSkR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 14:40:17 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38127C061756
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:40:14 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id t2so3630257wma.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7rrg2QEevl+XyyeHkHjnyuPdQSrw3GebymizIEuEhcY=;
        b=LCI8Zgl4muqJFZiVz9gNMHzfgueCZFkGuY36ayOGgByQtAi+CkgZPb8myeu4iZvVmd
         /CngHurNdinezdxMFLtZ0VHXP3b8ctlGiMEWGkDTluDl1bMImPk41c/h06o7Y3pSmXMu
         FWjWyGz6RzCTefyrf0KBJgd352z9BRD1tS2KYSBtIayYlIbFTqtfR5xej+waXXDLCASK
         LkiaYvMu4EQ+U0N7UDynQGUSDrrVv04Iewd1ixHAhgAV7Ib4rSG2J7s67GAhjE3dkiEP
         WJZ0XLhV4C2sMA/N/3W+Jl9XVwh9+fPqOJIaKK5bpphiYcYPk5GxeTiO7BiGq3gRpUat
         dCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7rrg2QEevl+XyyeHkHjnyuPdQSrw3GebymizIEuEhcY=;
        b=nuqWzYF+wtW1lIE9tx7s2v1ECmI8GY+Hd+uTlaUcqDWYVvBtevIZDBIP1/Vm8pyYVg
         mIoUCmr9xPURrw4Qn1KewuVBlvFaRU4mm6H+VVGfdkutlHh8/52wtWH1unWh7VerFzKL
         JgE+c53muebmPqntvbh5nCJGSxnof5XCArGhHmAH5cDpUinJWiQP5+pAdH5rMkqlxdRF
         epY0Il87ediuboKqDWbpeBnGzmXgs/rEhmfgSIUfzvGYKtv0Z6ZBkMESXTgasOK21WlB
         XVw1mDY7urQGs0ME06inmFL9wxkT1JNrC0q3G1T19bzEvKbA24pdIHo3ebIsRfL9VPLQ
         rpLA==
X-Gm-Message-State: AOAM5305Ali1R2QCwTzGuBQuZaXizgOfa1bKMrcXtMkKVaVfqsLtN6dH
        RRkogjRmfoC24KZkOYVXjEJD5QyaDos=
X-Google-Smtp-Source: ABdhPJxUaqbhlwfXVpn+cgF8DZI+4qXNzpM52R0fXy4GrQP/xr9+5h0hNOvEKbxDj3+qqzOGRJ0lwQ==
X-Received: by 2002:a1c:b4c1:: with SMTP id d184mr3441708wmf.26.1598380811536;
        Tue, 25 Aug 2020 11:40:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p14sm36183979wrg.96.2020.08.25.11.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 11:40:10 -0700 (PDT)
Message-Id: <8a7c34035ac8a86c82dc2bdeee8a9a76fc5626ed.1598380805.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.680.v2.git.1598380805.gitgitgadget@gmail.com>
References: <pull.680.git.1597857408.gitgitgadget@gmail.com>
        <pull.680.v2.git.1598380805.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Aug 2020 18:40:03 +0000
Subject: [PATCH v2 6/7] maintenance: add start/stop subcommands
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
index c42a176a95..d0316db5ae 100644
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
index 5218d52cb7..d97af4e546 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -32,6 +32,7 @@
 #include "remote.h"
 #include "midx.h"
 #include "object-store.h"
+#include "exec-cmd.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -1463,6 +1464,118 @@ static int maintenance_unregister(void)
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
 static const char builtin_maintenance_usage[] =	N_("git maintenance <subcommand> [<options>]");
 
 int cmd_maintenance(int argc, const char **argv, const char *prefix)
@@ -1472,6 +1585,10 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
 
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

