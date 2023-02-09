Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEB5C05027
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 00:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjBIAC1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 19:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjBIACX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 19:02:23 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6151E9DD
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 16:02:19 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id k16-20020a635a50000000b0042986056df6so259351pgm.2
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 16:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FxncT6tBVMpHpysI0Lok4V117zXff9hUB75vrzmQTBI=;
        b=p9sTyu5VBXtid+XdpJCTdd9FsR3vXkoxUhxIg9gcpRPMOk4cIQ5RUhHa3JN5ey5gwL
         KmHBkEFwG99dZOL5+EYreoJ+nlBfi+E1jFlxdjD8lws0z2bibM5YS8q7HsyMRzb/beBu
         rUakrUze1v8JGHfHktQ/3AocSoSFLzu3I6cMBFwZrlrzFiy+9ITrgR7jSJw8r1TTP7WB
         m8gcU4mSu/HHRJ3G0x3/KFU0dJAbtnajGE0l0XgkpyGHpU4U4oIfnsl0c4enM8spILs9
         czrhKNabjvgMVr860KHVpfeMXpS7R8dJxwQFQpVSKZSZr3ISMhPo3AF8iTxCbxJZ36Jh
         L4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FxncT6tBVMpHpysI0Lok4V117zXff9hUB75vrzmQTBI=;
        b=3s+5g5aMdt63J/4pV3h1yZIZ52Yu9iUwt5aYlADq2OM+9zPvrKsrnVxD5ifRiBb41t
         PDA46RSZBlt5jl57SGgecZfeArvexDWQUOhRtJCsMUaitg3AxYe4J3Dck5UGfW6obGpC
         Pllv/8fCOLlAiTIQAAzzWsR2FPx632ygwK5B3HVJLUuS0i+ysqeVcDf2i5bJ2PAUCmBw
         SXis2Q+wax91N8j9iKqoCaMWdwFouuBuT5Ls2ZkTBYwWB2Kwhg3ZfIm3/LgVc0vJAvN7
         fQcHpBX+z9M9O7esWTBN/7Hm2/yPENdtAZK52+TmdOluGA4Rj7PnRQA2VCeMha4Kz0B5
         BUFw==
X-Gm-Message-State: AO0yUKUcJQMTqXxY1xEaAp/intk8ggxM6dySByv2NREDSkSMIdfV0fPr
        HqMBwfTwO2GXB1GRsZiMQX2bjnEJR9tuZl3aYdH4DiEKzzcK/7N19qXPjzdB2sHYWaiv6zgjNgY
        pq9AxZw5w0RkYfopVtAS5Vxi5kQElIzSWemCk0LhGjIdfqdpAWk3qkY9jhCEJsXzXuw==
X-Google-Smtp-Source: AK7set8Hz8d4UP+N+HeuLJ2ishXd8x4CvtVVxYTo8Ikj8eoYqfyo6ijDHpNPcHwOD8fpTmvgTvZXrUWhw1pxDMU=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a63:8f41:0:b0:4fb:1449:8b3d with SMTP id
 r1-20020a638f41000000b004fb14498b3dmr1663348pgn.86.1675900938748; Wed, 08 Feb
 2023 16:02:18 -0800 (PST)
Date:   Thu,  9 Feb 2023 00:02:07 +0000
In-Reply-To: <20230207181706.363453-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230207181706.363453-1-calvinwan@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230209000212.1892457-2-calvinwan@google.com>
Subject: [PATCH v8 1/6] run-command: add duplicate_output_fn to run_processes_parallel_opts
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
index 756f1839aa..50f741f2ab 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1526,6 +1526,11 @@ static void pp_init(struct parallel_processes *pp,
 	if (!opts->get_next_task)
 		BUG("you need to specify a get_next_task function");
 
+	if (opts->ungroup) {
+		if (opts->duplicate_output)
+			BUG("duplicate_output and ungroup are incompatible with each other");
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
+			} else if (opts->duplicate_output) {
+				opts->duplicate_output(&pp->children[i].err,
+					pp->children[i].err.len - n,
+					opts->data, pp->children[i].data);
+			}
 		}
 	}
 }
diff --git a/run-command.h b/run-command.h
index 072db56a4d..0c16d7f251 100644
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
+typedef void (*duplicate_output_fn)(struct strbuf *out, size_t offset,
+				    void *pp_cb, void *pp_task_cb);
+
 /**
  * This callback is called on every child process that finished processing.
  *
@@ -461,6 +480,12 @@ struct run_process_parallel_opts
 	 */
 	start_failure_fn start_failure;
 
+	/**
+	 * duplicate_output: See duplicate_output_fn() above. Unless you need
+	 * to capture output from child processes, leave this as NULL.
+	 */
+	duplicate_output_fn duplicate_output;
+
 	/**
 	 * task_finished: See task_finished_fn() above. This can be
 	 * NULL to omit any special handling.
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 3ecb830f4a..4596ba68a8 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -52,6 +52,20 @@ static int no_job(struct child_process *cp,
 	return 0;
 }
 
+static void duplicate_output(struct strbuf *out,
+			size_t offset,
+			void *pp_cb UNUSED,
+			void *pp_task_cb UNUSED)
+{
+	struct string_list list = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+
+	string_list_split(&list, out->buf + offset, '\n', -1);
+	for_each_string_list_item(item, &list)
+		fprintf(stderr, "duplicate_output: %s\n", item->string);
+	string_list_clear(&list, 0);
+}
+
 static int task_finished(int result,
 			 struct strbuf *err,
 			 void *pp_cb,
@@ -439,6 +453,12 @@ int cmd__run_command(int argc, const char **argv)
 		opts.ungroup = 1;
 	}
 
+	if (!strcmp(argv[1], "--duplicate-output")) {
+		argv += 1;
+		argc -= 1;
+		opts.duplicate_output = duplicate_output;
+	}
+
 	jobs = atoi(argv[2]);
 	strvec_clear(&proc.args);
 	strvec_pushv(&proc.args, (const char **)argv + 3);
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index e2411f6a9b..31f1db96fc 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -135,6 +135,15 @@ test_expect_success 'run_command runs in parallel with more jobs available than
 	test_cmp expect actual
 '
 
+test_expect_success 'run_command runs in parallel with more jobs available than tasks --duplicate-output' '
+	test-tool run-command --duplicate-output run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
+	test_must_be_empty out &&
+	test 4 = $(grep -c "duplicate_output: Hello" err) &&
+	test 4 = $(grep -c "duplicate_output: World" err) &&
+	sed "/duplicate_output/d" err >err1 &&
+	test_cmp expect err1
+'
+
 test_expect_success 'run_command runs ungrouped in parallel with more jobs available than tasks' '
 	test-tool run-command --ungroup run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
 	test_line_count = 8 out &&
@@ -147,6 +156,15 @@ test_expect_success 'run_command runs in parallel with as many jobs as tasks' '
 	test_cmp expect actual
 '
 
+test_expect_success 'run_command runs in parallel with as many jobs as tasks --duplicate-output' '
+	test-tool run-command --duplicate-output run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
+	test_must_be_empty out &&
+	test 4 = $(grep -c "duplicate_output: Hello" err) &&
+	test 4 = $(grep -c "duplicate_output: World" err) &&
+	sed "/duplicate_output/d" err >err1 &&
+	test_cmp expect err1
+'
+
 test_expect_success 'run_command runs ungrouped in parallel with as many jobs as tasks' '
 	test-tool run-command --ungroup run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
 	test_line_count = 8 out &&
@@ -159,6 +177,15 @@ test_expect_success 'run_command runs in parallel with more tasks than jobs avai
 	test_cmp expect actual
 '
 
+test_expect_success 'run_command runs in parallel with more tasks than jobs available --duplicate-output' '
+	test-tool run-command --duplicate-output run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
+	test_must_be_empty out &&
+	test 4 = $(grep -c "duplicate_output: Hello" err) &&
+	test 4 = $(grep -c "duplicate_output: World" err) &&
+	sed "/duplicate_output/d" err >err1 &&
+	test_cmp expect err1
+'
+
 test_expect_success 'run_command runs ungrouped in parallel with more tasks than jobs available' '
 	test-tool run-command --ungroup run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
 	test_line_count = 8 out &&
@@ -180,6 +207,12 @@ test_expect_success 'run_command is asked to abort gracefully' '
 	test_cmp expect actual
 '
 
+test_expect_success 'run_command is asked to abort gracefully --duplicate-output' '
+	test-tool run-command --duplicate-output run-command-abort 3 false >out 2>err &&
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
 
+test_expect_success 'run_command outputs --duplicate-output' '
+	test-tool run-command --duplicate-output run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
+	test_must_be_empty out &&
+	test_cmp expect err
+'
+
 test_expect_success 'run_command outputs (ungroup) ' '
 	test-tool run-command --ungroup run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
 	test_must_be_empty out &&
-- 
2.39.1.519.gcb327c4b5f-goog

