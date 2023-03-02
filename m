Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05646C6FA8E
	for <git@archiver.kernel.org>; Thu,  2 Mar 2023 22:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjCBWD3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Mar 2023 17:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjCBWD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 17:03:26 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F80059E65
        for <git@vger.kernel.org>; Thu,  2 Mar 2023 14:03:05 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id x9-20020a1709028ec900b0019cad25ecf5so325118plo.10
        for <git@vger.kernel.org>; Thu, 02 Mar 2023 14:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ub7DW9x6qpUF2zPgVvwHVDQqvKzP7eX/hRfcTS2AcKU=;
        b=BvGakBEMnT/VRL5SSqcspWbmFPBgc++BZ541zlZE6A7IxzwsZcYXlbze2BCngmD2w2
         d2j8LFyeW3DNmJPQKaJ3algogZL+0VwZw4ki2wPhQXwl1aU4N5NurJOKCtFByxPJv+md
         3wynVroXy9wGLA13VdJikHzSCROqioi5egXPhNC73YJpEDeFppKPUu+fZpHyfMby7Ryx
         13rel8LejEe7LqhaP8yIwG0XAGzUI/898/9FhmcAxVCtypFkYeqIKqv9Gt/44yWMDuoU
         Xvz7VOabI6HrnkBhpFeuY9b76bE1+R7j1aeStOKLys+Ni8GC2QY98/RanD8Cn1enCpOw
         ueOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ub7DW9x6qpUF2zPgVvwHVDQqvKzP7eX/hRfcTS2AcKU=;
        b=5o1uJ7VB+EFhfT/kRxiJX2ju+ZYtbgA1dDWDVDG8p03Aljkt5gflAHpyQnLMxCg10p
         6v6L8F7q1dHP0edRaRd2hBylFJAUktdMETwz47eFssVX2GyA05y+GFIbjd1mXZgwbdDJ
         dvtSOo6IKyR5NJqfbS3PQje86b9Rm5rAF2DvUqOs8SksvjoJZeyDUvUILk1dp9oVeCqk
         uL/Op+JHpPmMs4uh3qTpp5bmuIOW4y5yD5CC6xydgwBL58Htz03gCcKGPBl9cqmmmFac
         n304+Oir1tbRmeI0LWKxlJjKcYdWl3f1oa+DoWR/k9tCNgxYf559Ux+Tt0tf+jj2WkLR
         MIYw==
X-Gm-Message-State: AO0yUKUALcdwktXselkpCC0+W049Nn0Tyt8gYK03w9zsk7/v8Wbv26Ca
        04hbYAeVG1AhSQ7JksyrAOW5LmitOvzd5GDXG3mRA+YaafDMU9O9oq7lmOWISG0CXikbIaloNx6
        uM/JYjleBeF2EUY1ZVdVSQ4g4k6XpKg2cY487CazopPELOGiIIBREzkw5QZ9IeXfVCQ==
X-Google-Smtp-Source: AK7set+eQk8TFpaj4iZC0gqPDX1eGLh/r6e1Wt71Upikfh0/CTp9327RHUJDZ+wlJ7NAArD0aMAeoYAElTFNPZg=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:903:2988:b0:19c:df4e:f3c2 with SMTP
 id lm8-20020a170903298800b0019cdf4ef3c2mr1655660plb.6.1677794579553; Thu, 02
 Mar 2023 14:02:59 -0800 (PST)
Date:   Thu,  2 Mar 2023 22:02:46 +0000
In-Reply-To: <20230302215237.1473444-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230209000212.1892457-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230302220251.1474923-1-calvinwan@google.com>
Subject: [PATCH v9 1/6] run-command: add on_stderr_output_fn to run_processes_parallel_opts
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, avarab@gmail.com,
        chooglen@google.com, newren@gmail.com, jonathantanmy@google.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add duplicate_output_fn as an optionally set function in
run_process_parallel_opts. If set, output from each child process is
copied and passed to the callback function whenever output from the
child process is buffered to allow for separate parsing.

Fix two items in pp_buffer_stderr:
 * strbuf_read_once returns a ssize_t but the variable it is set to is
   an int so fix that.
 * Add missing brackets to "else if" statement

The ungroup/duplicate_output incompatibility check is nested to
prepare for future imcompatibles modes with ungroup.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 run-command.c               | 16 ++++++++++++---
 run-command.h               | 25 ++++++++++++++++++++++++
 t/helper/test-run-command.c | 20 +++++++++++++++++++
 t/t0061-run-command.sh      | 39 +++++++++++++++++++++++++++++++++++++
 4 files changed, 97 insertions(+), 3 deletions(-)

diff --git a/run-command.c b/run-command.c
index 756f1839aa..7eed4e98c2 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1526,6 +1526,11 @@ static void pp_init(struct parallel_processes *pp,
 	if (!opts->get_next_task)
 		BUG("you need to specify a get_next_task function");
 
+	if (opts->ungroup) {
+		if (opts->on_stderr_output)
+			BUG("on_stderr_output and ungroup are incompatible with each other");
+	}
+
 	CALLOC_ARRAY(pp->children, n);
 	if (!opts->ungroup)
 		CALLOC_ARRAY(pp->pfd, n);
@@ -1645,14 +1650,19 @@ static void pp_buffer_stderr(struct parallel_processes *pp,
 	for (size_t i = 0; i < opts->processes; i++) {
 		if (pp->children[i].state == GIT_CP_WORKING &&
 		    pp->pfd[i].revents & (POLLIN | POLLHUP)) {
-			int n = strbuf_read_once(&pp->children[i].err,
-						 pp->children[i].process.err, 0);
+			ssize_t n = strbuf_read_once(&pp->children[i].err,
+						     pp->children[i].process.err, 0);
 			if (n == 0) {
 				close(pp->children[i].process.err);
 				pp->children[i].state = GIT_CP_WAIT_CLEANUP;
-			} else if (n < 0)
+			} else if (n < 0) {
 				if (errno != EAGAIN)
 					die_errno("read");
+			} else if (opts->on_stderr_output) {
+				opts->on_stderr_output(&pp->children[i].err,
+					pp->children[i].err.len - n,
+					opts->data, pp->children[i].data);
+			}
 		}
 	}
 }
diff --git a/run-command.h b/run-command.h
index 072db56a4d..8f08e41fae 100644
--- a/run-command.h
+++ b/run-command.h
@@ -408,6 +408,25 @@ typedef int (*start_failure_fn)(struct strbuf *out,
 				void *pp_cb,
 				void *pp_task_cb);
 
+/**
+ * This callback is called whenever output from a child process is buffered
+ *
+ * See run_processes_parallel() below for a discussion of the "struct
+ * strbuf *out" parameter.
+ *
+ * The offset refers to the number of bytes originally in "out" before
+ * the output from the child process was buffered. Therefore, the buffer
+ * range, "out + buf" to the end of "out", would contain the buffer of
+ * the child process output.
+ *
+ * pp_cb is the callback cookie as passed into run_processes_parallel,
+ * pp_task_cb is the callback cookie as passed into get_next_task_fn.
+ *
+ * This function is incompatible with "ungroup"
+ */
+typedef void (*on_stderr_output_fn)(struct strbuf *out, size_t offset,
+				    void *pp_cb, void *pp_task_cb);
+
 /**
  * This callback is called on every child process that finished processing.
  *
@@ -461,6 +480,12 @@ struct run_process_parallel_opts
 	 */
 	start_failure_fn start_failure;
 
+	/**
+	 * on_stderr_output: See on_stderr_output_fn() above. Unless you need
+	 * to capture output from child processes, leave this as NULL.
+	 */
+	on_stderr_output_fn on_stderr_output;
+
 	/**
 	 * task_finished: See task_finished_fn() above. This can be
 	 * NULL to omit any special handling.
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 3ecb830f4a..a2fac6f762 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -52,6 +52,20 @@ static int no_job(struct child_process *cp,
 	return 0;
 }
 
+static void on_stderr_output(struct strbuf *out,
+			size_t offset,
+			void *pp_cb UNUSED,
+			void *pp_task_cb UNUSED)
+{
+	struct string_list list = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+
+	string_list_split(&list, out->buf + offset, '\n', -1);
+	for_each_string_list_item(item, &list)
+		fprintf(stderr, "on_stderr_output: %s\n", item->string);
+	string_list_clear(&list, 0);
+}
+
 static int task_finished(int result,
 			 struct strbuf *err,
 			 void *pp_cb,
@@ -439,6 +453,12 @@ int cmd__run_command(int argc, const char **argv)
 		opts.ungroup = 1;
 	}
 
+	if (!strcmp(argv[1], "--on-stderr-output")) {
+		argv += 1;
+		argc -= 1;
+		opts.on_stderr_output = on_stderr_output;
+	}
+
 	jobs = atoi(argv[2]);
 	strvec_clear(&proc.args);
 	strvec_pushv(&proc.args, (const char **)argv + 3);
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index e2411f6a9b..883d871dfb 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -135,6 +135,15 @@ test_expect_success 'run_command runs in parallel with more jobs available than
 	test_cmp expect actual
 '
 
+test_expect_success 'run_command runs in parallel with more jobs available than tasks --on-stderr-output' '
+	test-tool run-command --on-stderr-output run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
+	test_must_be_empty out &&
+	test 4 = $(grep -c "on_stderr_output: Hello" err) &&
+	test 4 = $(grep -c "on_stderr_output: World" err) &&
+	sed "/on_stderr_output/d" err >err1 &&
+	test_cmp expect err1
+'
+
 test_expect_success 'run_command runs ungrouped in parallel with more jobs available than tasks' '
 	test-tool run-command --ungroup run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
 	test_line_count = 8 out &&
@@ -147,6 +156,15 @@ test_expect_success 'run_command runs in parallel with as many jobs as tasks' '
 	test_cmp expect actual
 '
 
+test_expect_success 'run_command runs in parallel with as many jobs as tasks --on-stderr-output' '
+	test-tool run-command --on-stderr-output run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
+	test_must_be_empty out &&
+	test 4 = $(grep -c "on_stderr_output: Hello" err) &&
+	test 4 = $(grep -c "on_stderr_output: World" err) &&
+	sed "/on_stderr_output/d" err >err1 &&
+	test_cmp expect err1
+'
+
 test_expect_success 'run_command runs ungrouped in parallel with as many jobs as tasks' '
 	test-tool run-command --ungroup run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
 	test_line_count = 8 out &&
@@ -159,6 +177,15 @@ test_expect_success 'run_command runs in parallel with more tasks than jobs avai
 	test_cmp expect actual
 '
 
+test_expect_success 'run_command runs in parallel with more tasks than jobs available --on-stderr-output' '
+	test-tool run-command --on-stderr-output run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
+	test_must_be_empty out &&
+	test 4 = $(grep -c "on_stderr_output: Hello" err) &&
+	test 4 = $(grep -c "on_stderr_output: World" err) &&
+	sed "/on_stderr_output/d" err >err1 &&
+	test_cmp expect err1
+'
+
 test_expect_success 'run_command runs ungrouped in parallel with more tasks than jobs available' '
 	test-tool run-command --ungroup run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
 	test_line_count = 8 out &&
@@ -180,6 +207,12 @@ test_expect_success 'run_command is asked to abort gracefully' '
 	test_cmp expect actual
 '
 
+test_expect_success 'run_command is asked to abort gracefully --on-stderr-output' '
+	test-tool run-command --on-stderr-output run-command-abort 3 false >out 2>err &&
+	test_must_be_empty out &&
+	test_cmp expect err
+'
+
 test_expect_success 'run_command is asked to abort gracefully (ungroup)' '
 	test-tool run-command --ungroup run-command-abort 3 false >out 2>err &&
 	test_must_be_empty out &&
@@ -196,6 +229,12 @@ test_expect_success 'run_command outputs ' '
 	test_cmp expect actual
 '
 
+test_expect_success 'run_command outputs --on-stderr-output' '
+	test-tool run-command --on-stderr-output run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
+	test_must_be_empty out &&
+	test_cmp expect err
+'
+
 test_expect_success 'run_command outputs (ungroup) ' '
 	test-tool run-command --ungroup run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
 	test_must_be_empty out &&
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

