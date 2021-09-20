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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CD3C433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 15:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80136610A3
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 15:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237821AbhITPh7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 11:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237285AbhITPhw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 11:37:52 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828B5C061762
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 08:36:25 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q11so30913500wrr.9
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 08:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IAw+cfXd7Fqp1Ld/tYY65l9gNk65pIHul9bcKmgli2Y=;
        b=bENUrUHbIbLXUCIiT708ay0qz/G+khF4HihJ03/i86CeOACPjZAgzu2avn4JW5M9FL
         O52CprXJHUti51c2cKL5h9JnCIAbey6T+DLOpEZBwe8QR4joEWW/LSZ01VI1OXKCN6vY
         3MGCFZMAWbB8+K7AcVbOFgpoZ/U3Y+g3w9+AAopFoDNICquc+Y+OYFajozh3IcZQgZ43
         LBGxCNjDqPevNWeIb2zZbFwajvpHZfJgjpRt+HjZdeFt7IWYRjoFiCyLdiAKFLJDlfAx
         TonKoCMwYck+AjZtQdyqDmFp5Pf03NKOVx6AdOR5mdy84/5RolkbNS4odGWN39/5hZeb
         kQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IAw+cfXd7Fqp1Ld/tYY65l9gNk65pIHul9bcKmgli2Y=;
        b=skljWRIGAP7YYHpj+yJ1LEHKVfWmyrPRLcyotfRrH3lmUpjHQtUdHlsnMH8PQnjvxF
         KGnNYTkNwdADg3X7uJq+Po3xXLgiopUq4wcAiC9u3c6xJLmrc3YTyjaXiXKIo2Oa9O5l
         ++xH4XY1iyXjX4kf23hsRmRFk+1Px9eevyqN6wkRA25ifTHukEVXXJ9M4iHzKKkJY2tZ
         MQiZrPzLu1KYB3B7B1C/OK+AKUVguKS98cY5hMfbVuVkkKmsbuhdEUrCe1fNroH/g4kn
         suLd5SCkDa1J3dftCdrXUz2+UC4YTC1oW71nEeLsXImfs+83G0uDasE2Iv7Npa/3oZ3a
         esow==
X-Gm-Message-State: AOAM530LFF5dsJy5X5oA4v5YaAcG8GOe5iH3rjZSmcM4jbbhtnhIUIDD
        2Jcb2OpCcD1diJRUCSBjnZL1IBc4EXo=
X-Google-Smtp-Source: ABdhPJw85pYbK1hiKIchitTMOlmijpUXLIVI9MlIDWR5G50LR30SuzxVTygB6F+gXFeXVLv3Ock6SQ==
X-Received: by 2002:a1c:7515:: with SMTP id o21mr25261149wmc.150.1632152184105;
        Mon, 20 Sep 2021 08:36:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i18sm16284652wrn.64.2021.09.20.08.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 08:36:23 -0700 (PDT)
Message-Id: <0822118c4b50ddd3668ded97a89cab2c47895078.1632152178.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
        <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 15:36:17 +0000
Subject: [PATCH v2 6/7] run-command: create start_bg_command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Carlo Arenas <carenas@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create a variation of `run_command()` and `start_command()` to launch a command
into the background and optionally wait for it to become "ready" before returning.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 run-command.c | 129 ++++++++++++++++++++++++++++++++++++++++++++++++++
 run-command.h |  57 ++++++++++++++++++++++
 2 files changed, 186 insertions(+)

diff --git a/run-command.c b/run-command.c
index 3e4e082e94d..76bbef9d96d 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1901,3 +1901,132 @@ void prepare_other_repo_env(struct strvec *env_array, const char *new_git_dir)
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
+	 * We do not allow clean-on-exit because the child process
+	 * should persist in the background and possibly/probably
+	 * after this process exits.  So we don't want to kill the
+	 * child during our atexit routine.
+	 */
+	if (cmd->clean_on_exit)
+		BUG("start_bg_command() does not allow non-zero clean_on_exit");
+
+	if (!cmd->trace2_child_class)
+		cmd->trace2_child_class = "background";
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
+	if (!pid_seen) {
+		/*
+		 * The child is currently running.  Ask the callback
+		 * if the child is ready to do work or whether we
+		 * should keep waiting for it to boot up.
+		 */
+		ret = (*wait_cb)(cmd, cb_data);
+		if (!ret) {
+			/*
+			 * The child is running and "ready".
+			 */
+			trace2_child_ready(cmd, "ready");
+			sbgr = SBGR_READY;
+			goto done;
+		} else if (ret > 0) {
+			/*
+			 * The callback said to give it more time to boot up
+			 * (subject to our timeout limit).
+			 */
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
+			 */
+			trace2_child_ready(cmd, "timeout");
+			sbgr = SBGR_TIMEOUT;
+			goto done;
+		} else {
+			/*
+			 * The cb gave up on this child.  It is still running,
+			 * but our cb got an error trying to probe it.
+			 */
+			trace2_child_ready(cmd, "error");
+			sbgr = SBGR_CB_ERROR;
+			goto done;
+		}
+	}
+
+	else if (pid_seen == cmd->pid) {
+		int child_code = -1;
+
+		/*
+		 * The child started, but exited or was terminated
+		 * before becoming "ready".
+		 *
+		 * We try to match the behavior of `wait_or_whine()`
+		 * WRT the handling of WIFSIGNALED() and WIFEXITED()
+		 * and convert the child's status to a return code for
+		 * tracing purposes and emit the `trace2_child_exit()`
+		 * event.
+		 *
+		 * We do not want the wait_or_whine() error message
+		 * because we will be called by client-side library
+		 * routines.
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
+	else if (pid_seen < 0 && errno == EINTR)
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
index af1296769f9..17b1b80c3d7 100644
--- a/run-command.h
+++ b/run-command.h
@@ -496,4 +496,61 @@ int run_processes_parallel_tr2(int n, get_next_task_fn, start_failure_fn,
  */
 void prepare_other_repo_env(struct strvec *env_array, const char *new_git_dir);
 
+/**
+ * Possible return values for start_bg_command().
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
+ * Callback used by start_bg_command() to ask whether the
+ * child process is ready or needs more time to become "ready".
+ *
+ * The callback will receive the cmd and cb_data arguments given to
+ * start_bg_command().
+ *
+ * Returns 1 is child needs more time (subject to the requested timeout).
+ * Returns 0 if child is "ready".
+ * Returns -1 on any error and cause start_bg_command() to also error out.
+ */
+typedef int(start_bg_wait_cb)(const struct child_process *cmd, void *cb_data);
+
+/**
+ * Start a command in the background.  Wait long enough for the child
+ * to become "ready" (as defined by the provided callback).  Capture
+ * immediate errors (like failure to start) and any immediate exit
+ * status (such as a shutdown/signal before the child became "ready")
+ * and return this like start_command().
+ *
+ * We run a custom wait loop using the provided callback to wait for
+ * the child to start and become "ready".  This is limited by the given
+ * timeout value.
+ *
+ * If the child does successfully start and become "ready", we orphan
+ * it into the background.
+ *
+ * The caller must not call finish_command().
+ *
+ * The opaque cb_data argument will be forwarded to the callback for
+ * any instance data that it might require.  This may be NULL.
+ */
+enum start_bg_result start_bg_command(struct child_process *cmd,
+				      start_bg_wait_cb *wait_cb,
+				      void *cb_data,
+				      unsigned int timeout_sec);
+
 #endif
-- 
gitgitgadget

