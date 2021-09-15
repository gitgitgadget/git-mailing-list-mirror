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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91407C433FE
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 20:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73E4061155
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 20:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhIOUhq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 16:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbhIOUho (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 16:37:44 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34D6C0613C1
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 13:36:23 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id d207-20020a1c1dd8000000b00307e2d1ec1aso2936617wmd.5
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 13:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hrvC+HIqL2XOQTHkljqsU9Y1itYKqJ4zzmtZdhx3Zas=;
        b=RRtVTrQ1dSFAcA28vh9Utg7qGhzCpIEJCiR0sYmqrQNRyPT6M0o0d2gQJiyrWx6g64
         a1GRp5XEUyRG5DVINug5v8Je4wx56bZrTtrDGRmcP+/baEqYXHoM9BcfylOuJsV9CO2L
         KtULP54uD9qV6p74WpsdW8LNWYyUNwEPbZWcR9tOLbgETlSgSFq5lIsNytCRwH7ITwo2
         1cYW6IvhoIfPxX3TithGvLZgMrTgvq8y/dO7tJbHuCOJbrF9QM7CyE4fByQiKiSCLSki
         NoFkWq2Oxe9Hj2czz+xN9r6awdTV8PILYB0siMKxaJt0q+6Bsgjc6xW3txJQQ2HGrqXD
         9ryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hrvC+HIqL2XOQTHkljqsU9Y1itYKqJ4zzmtZdhx3Zas=;
        b=OMo/oOEqtoum1EO3y7MFVVuTWDNlNaKHtE/vpCU8EXqxED+070sSse52ds4O+Ew409
         ShRk94s2IUjzLEcDmE0V0Z1NB6Z3hxE00SO6CilS7QfHFJtixj2h6O2np+8U3VbuVNfQ
         WlY62nawf7rRsXl+/cTH5Bm/IAWRsgEt6zV3Gdgq47LPMwC0A87IsOegVku35YyY+XdV
         teuVRSjkpYGx3EU+Q11GL4Akn248I9mP8k4TGX8DCw7OGypC2nqPiG/DiivYoTmKu7TY
         ygs/aCpa8L+uqIGM6beirURifh5f5HBV+A2bTIwEa3OFwFZkXISn11f4TnhHcKMnW1XO
         9dQA==
X-Gm-Message-State: AOAM532PEZMSjseOXd8bvP2bfJisdXhWhwoO/Nog9PDzNyMWMnmgDw59
        Zk9r+d3OUhlyW1tJvKiLmRxaXGpaI/w=
X-Google-Smtp-Source: ABdhPJxFYH/d/b4Jkfn77F0OJSM6l7zryvkmvFlKpL2iqx/kR1pD5iiwrifAisO7jorZIOmjAf8r8A==
X-Received: by 2002:a7b:c385:: with SMTP id s5mr6341659wmj.149.1631738182413;
        Wed, 15 Sep 2021 13:36:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o24sm5108672wmm.11.2021.09.15.13.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 13:36:22 -0700 (PDT)
Message-Id: <f97038a563d889d740a7e968fcbdfaadb41e2008.1631738177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Sep 2021 20:36:16 +0000
Subject: [PATCH 6/7] run-command: create start_bg_command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create a variation of `run_command()` and `start_command()` to launch a command
into the background and optionally wait for it to become "ready" before returning.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 run-command.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++
 run-command.h |  48 ++++++++++++++++++++
 2 files changed, 171 insertions(+)

diff --git a/run-command.c b/run-command.c
index 3e4e082e94d..fe75fd08f74 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1901,3 +1901,126 @@ void prepare_other_repo_env(struct strvec *env_array, const char *new_git_dir)
 	}
 	strvec_pushf(env_array, "%s=%s", GIT_DIR_ENVIRONMENT, new_git_dir);
 }
+
+enum start_bg_result start_bg_command(struct child_process *cmd,
+				      start_bg_wait_cb *wait_cb,
+				      void *cb_data,
+				      unsigned int timeout_sec)
+{
+	enum start_bg_result sbgr = SBGR_ERROR;
+	int ret;
+	int wait_status;
+	pid_t pid_seen;
+	time_t time_limit;
+
+	/*
+	 * Silently disallow child cleanup -- even if requested.
+	 * The child process should persist in the background
+	 * and possibly/probably after this process exits.  That
+	 * is, don't kill the child during our atexit routine.
+	 */
+	cmd->clean_on_exit = 0;
+
+	ret = start_command(cmd);
+	if (ret) {
+		/*
+		 * We assume that if `start_command()` fails, we
+		 * either get a complete `trace2_child_start() /
+		 * trace2_child_exit()` pair or it fails before the
+		 * `trace2_child_start()` is emitted, so we do not
+		 * need to worry about it here.
+		 *
+		 * We also assume that `start_command()` does not add
+		 * us to the cleanup list.  And that it calls
+		 * calls `child_process_clear()`.
+		 */
+		sbgr = SBGR_ERROR;
+		goto done;
+	}
+
+	time(&time_limit);
+	time_limit += timeout_sec;
+
+wait:
+	pid_seen = waitpid(cmd->pid, &wait_status, WNOHANG);
+
+	if (pid_seen == 0) {
+		/*
+		 * The child is currently running.  Ask the callback
+		 * if the child is ready to do work or whether we
+		 * should keep waiting for it to boot up.
+		 */
+		ret = (*wait_cb)(cb_data, cmd);
+		if (!ret) {
+			/*
+			 * The child is running and "ready".
+			 *
+			 * NEEDSWORK: As we prepare to orphan (release to
+			 * the background) this child, it is not appropriate
+			 * to emit a `trace2_child_exit()` event.  Should we
+			 * create a new event for this case?
+			 */
+			sbgr = SBGR_READY;
+			goto done;
+		} else if (ret > 0) {
+			time_t now;
+
+			time(&now);
+			if (now < time_limit)
+				goto wait;
+
+			/*
+			 * Our timeout has expired.  We don't try to
+			 * kill the child, but rather let it continue
+			 * (hopefully) trying to startup.
+			 *
+			 * NEEDSWORK: Like the "ready" case, should we
+			 * log a custom child-something Trace2 event here?
+			 */
+			sbgr = SBGR_TIMEOUT;
+			goto done;
+		} else {
+			/*
+			 * The cb gave up on this child.
+			 *
+			 * NEEDSWORK: Like above, should we log a custom
+			 * Trace2 child-something event here?
+			 */
+			sbgr = SBGR_CB_ERROR;
+			goto done;
+		}
+	}
+
+	if (pid_seen == cmd->pid) {
+		int child_code = -1;
+
+		/*
+		 * The child started, but exited or was terminated
+		 * before becoming "ready".
+		 *
+		 * We try to match the behavior of `wait_or_whine()`
+		 * and convert the child's status to a return code for
+		 * tracing purposes and emit the `trace2_child_exit()`
+		 * event.
+		 */
+		if (WIFEXITED(wait_status))
+			child_code = WEXITSTATUS(wait_status);
+		else if (WIFSIGNALED(wait_status))
+			child_code = WTERMSIG(wait_status) + 128;
+		trace2_child_exit(cmd, child_code);
+
+		sbgr = SBGR_DIED;
+		goto done;
+	}
+
+	if (pid_seen < 0 && errno == EINTR)
+		goto wait;
+
+	trace2_child_exit(cmd, -1);
+	sbgr = SBGR_ERROR;
+
+done:
+	child_process_clear(cmd);
+	invalidate_lstat_cache();
+	return sbgr;
+}
diff --git a/run-command.h b/run-command.h
index af1296769f9..58065197d1b 100644
--- a/run-command.h
+++ b/run-command.h
@@ -496,4 +496,52 @@ int run_processes_parallel_tr2(int n, get_next_task_fn, start_failure_fn,
  */
 void prepare_other_repo_env(struct strvec *env_array, const char *new_git_dir);
 
+/**
+ * Possible return values for `start_bg_command()`.
+ */
+enum start_bg_result {
+	/* child process is "ready" */
+	SBGR_READY = 0,
+
+	/* child process could not be started */
+	SBGR_ERROR,
+
+	/* callback error when testing for "ready" */
+	SBGR_CB_ERROR,
+
+	/* timeout expired waiting for child to become "ready" */
+	SBGR_TIMEOUT,
+
+	/* child process exited or was signalled before becomming "ready" */
+	SBGR_DIED,
+};
+
+/**
+ * Callback used by `start_bg_command()` to ask whether the
+ * child process is ready or needs more time to become ready.
+ *
+ * Returns 1 is child needs more time (subject to the requested timeout).
+ * Returns 0 if child is ready.
+ * Returns -1 on any error and cause `start_bg_command()` to also error out.
+ */
+typedef int(start_bg_wait_cb)(void *cb_data,
+			      const struct child_process *cmd);
+
+/**
+ * Start a command in the background.  Wait long enough for the child to
+ * become "ready".  Capture immediate errors (like failure to start) and
+ * any immediate exit status (such as a shutdown/signal before the child
+ * became "ready").
+ *
+ * This is a combination of `start_command()` and `finish_command()`, but
+ * with a custom `wait_or_whine()` that allows the caller to define when
+ * the child is "ready".
+ *
+ * The caller does not need to call `finish_command()`.
+ */
+enum start_bg_result start_bg_command(struct child_process *cmd,
+				      start_bg_wait_cb *wait_cb,
+				      void *cb_data,
+				      unsigned int timeout_sec);
+
 #endif
-- 
gitgitgadget

