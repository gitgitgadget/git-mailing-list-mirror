Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3545AC433FE
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 15:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241131AbiBOQAB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 11:00:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241085AbiBOP7y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 10:59:54 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C0CBDE4E
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:42 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id v12so32949656wrv.2
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zRljM25kO7hXvbxx8zIAQyZPmbHLjyw9d9EA8U8Zs3g=;
        b=TMrZx3EmKC1ALXwZZnZYoU3C+m0ItdBDOziHLVrgQSIA60Qf4mFJtbqkgTOVLkKex4
         PxQexj1RJlgXtXEES2eUOmhoVJRTxzzzy+bQCERQVEXL6bnFz3a3oa3P+FA6fM0N6K1A
         H8aTJVIHQAlmqbzMiMoUe0itwBcWEIlbPf7x4nnlDq/AOh+y6b51FSq7hYjWGA27DVeX
         CRlZOqFSDY8EcUqbO6ArbpbF9AHAW/1cRCH2xJsraKeUUdTo9p0AXrWzdWQW54bus91a
         Zgu+3yNkM/M7ncwCYW0vR7HbL2wYAZSDv+mMsBBMC/m+LMKylwA1DpZtaHg6UlqanTnz
         p2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zRljM25kO7hXvbxx8zIAQyZPmbHLjyw9d9EA8U8Zs3g=;
        b=5p/optac3boKhoytyeJvhXXx92uxzLvpK3M/wUdw1elSygAV03G+NzDPjyFuJDQDHQ
         rWfJ1FL1MxK+LgeOCKqjJrfp8j1Cm8fyDkGCvZH9WsP2mup8dqYSn86Ku75klf6cHB8r
         HwbPxIxnl2jDX3twcwnbCR0M4WF6hvDPoeVpDlCIutcfVDPokwGqyHxmqbesJ6ImB1bK
         wrO9hhByYnr1L+aW0/1/71jTc3Q+6zPiAi/0Z0Ih5kCvih3Q/33T2wwmGjSmHtT+gDAc
         ozCi5MhvMa9lz0c6YejO0nKjJRbINSL0A2ALubsTdiuA/Lql5i4tkCDgDTcQVhcngAtn
         49oA==
X-Gm-Message-State: AOAM533v3W5IErC+gcKBE+YpHDrciFGpiqMayWhF662vRMgGKXXf15VV
        NYKiqBflEhIwuhLDXmffwRypfeO1Fhs=
X-Google-Smtp-Source: ABdhPJxyRYKbIAL0YxW/Ae5sX+5VKE66NW5Fdy7HaiyIK1rLAANUmTPwu+pSupu9OrBLZYAj1/Jsrg==
X-Received: by 2002:a05:6000:1542:: with SMTP id 2mr3827524wry.607.1644940781253;
        Tue, 15 Feb 2022 07:59:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bd20sm1524793wmb.20.2022.02.15.07.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 07:59:40 -0800 (PST)
Message-Id: <44cc61e186cb65fa6b2c1d5a0f080fc0b2265e57.1644940773.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Feb 2022 15:59:15 +0000
Subject: [PATCH 05/23] fsmonitor-settings: bare repos are incompatible with
 FSMonitor
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

Bare repos do not have a worktree, so there is nothing for the
daemon watch.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c | 11 +++++++
 builtin/update-index.c      |  9 ++++++
 fsmonitor-settings.c        | 62 +++++++++++++++++++++++++++++++++++++
 fsmonitor-settings.h        | 11 +++++++
 t/t7519-status-fsmonitor.sh | 26 ++++++++++++++++
 5 files changed, 119 insertions(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 6011fe42ee0..899355c55aa 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1424,6 +1424,17 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 		die(_("invalid 'ipc-threads' value (%d)"),
 		    fsmonitor__ipc_threads);
 
+	prepare_repo_settings(the_repository);
+	fsm_settings__set_ipc(the_repository);
+
+	if (fsm_settings__get_mode(the_repository) == FSMONITOR_MODE_INCOMPATIBLE) {
+		struct strbuf buf_reason = STRBUF_INIT;
+		fsm_settings__get_reason(the_repository, &buf_reason);
+		error("%s '%s'", buf_reason.buf, xgetcwd());
+		strbuf_release(&buf_reason);
+		return -1;
+	}
+
 	if (!strcmp(subcmd, "start"))
 		return !!try_to_start_background_daemon();
 
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 1232f0d214e..9a2c45f2e56 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1215,6 +1215,15 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
 	if (fsmonitor > 0) {
 		enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
+
+		if (fsm_mode == FSMONITOR_MODE_INCOMPATIBLE) {
+			struct strbuf buf_reason = STRBUF_INIT;
+			fsm_settings__get_reason(r, &buf_reason);
+			error("%s", buf_reason.buf);
+			strbuf_release(&buf_reason);
+			return -1;
+		}
+
 		if (fsm_mode == FSMONITOR_MODE_DISABLED) {
 			advise(_("core.fsmonitor is unset; "
 				 "set it if you really want to "
diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index eb4d661c81e..0fc5566eb8a 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -9,9 +9,33 @@
  */
 struct fsmonitor_settings {
 	enum fsmonitor_mode mode;
+	enum fsmonitor_reason reason;
 	char *hook_path;
 };
 
+static void set_incompatible(struct repository *r,
+			     enum fsmonitor_reason reason)
+{
+	struct fsmonitor_settings *s = r->settings.fsmonitor;
+
+	s->mode = FSMONITOR_MODE_INCOMPATIBLE;
+	s->reason = reason;
+}
+
+static int check_for_incompatible(struct repository *r)
+{
+	if (!r->worktree) {
+		/*
+		 * Bare repositories don't have a working directory and
+		 * therefore have nothing to watch.
+		 */
+		set_incompatible(r, FSMONITOR_REASON_BARE);
+		return 1;
+	}
+
+	return 0;
+}
+
 static void lookup_fsmonitor_settings(struct repository *r)
 {
 	struct fsmonitor_settings *s;
@@ -78,6 +102,9 @@ void fsm_settings__set_ipc(struct repository *r)
 {
 	lookup_fsmonitor_settings(r);
 
+	if (check_for_incompatible(r))
+		return;
+
 	r->settings.fsmonitor->mode = FSMONITOR_MODE_IPC;
 	FREE_AND_NULL(r->settings.fsmonitor->hook_path);
 }
@@ -86,6 +113,9 @@ void fsm_settings__set_hook(struct repository *r, const char *path)
 {
 	lookup_fsmonitor_settings(r);
 
+	if (check_for_incompatible(r))
+		return;
+
 	r->settings.fsmonitor->mode = FSMONITOR_MODE_HOOK;
 	FREE_AND_NULL(r->settings.fsmonitor->hook_path);
 	r->settings.fsmonitor->hook_path = strdup(path);
@@ -96,5 +126,37 @@ void fsm_settings__set_disabled(struct repository *r)
 	lookup_fsmonitor_settings(r);
 
 	r->settings.fsmonitor->mode = FSMONITOR_MODE_DISABLED;
+	r->settings.fsmonitor->reason = FSMONITOR_REASON_ZERO;
 	FREE_AND_NULL(r->settings.fsmonitor->hook_path);
 }
+
+static void create_reason_message(struct repository *r,
+				  struct strbuf *buf_reason)
+{
+	struct fsmonitor_settings *s = r->settings.fsmonitor;
+
+	switch (s->reason) {
+	case FSMONITOR_REASON_ZERO:
+		return;
+
+	case FSMONITOR_REASON_BARE:
+		strbuf_addstr(buf_reason,
+			      _("bare repos are incompatible with fsmonitor"));
+		return;
+
+	default:
+		BUG("Unhandled case in create_reason_message '%d'", s->reason);
+	}
+}
+
+enum fsmonitor_reason fsm_settings__get_reason(struct repository *r,
+					       struct strbuf *buf_reason)
+{
+	lookup_fsmonitor_settings(r);
+
+	strbuf_reset(buf_reason);
+	if (r->settings.fsmonitor->mode == FSMONITOR_MODE_INCOMPATIBLE)
+		create_reason_message(r, buf_reason);
+
+	return r->settings.fsmonitor->reason;
+}
diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
index a4c5d7b4889..e5f145a2f79 100644
--- a/fsmonitor-settings.h
+++ b/fsmonitor-settings.h
@@ -4,17 +4,28 @@
 struct repository;
 
 enum fsmonitor_mode {
+	FSMONITOR_MODE_INCOMPATIBLE = -1, /* see _reason */
 	FSMONITOR_MODE_DISABLED = 0,
 	FSMONITOR_MODE_HOOK = 1, /* core.fsmonitor=<hook_path> */
 	FSMONITOR_MODE_IPC = 2,  /* core.fsmonitor=<true> */
 };
 
+/*
+ * Incompatibility reasons.
+ */
+enum fsmonitor_reason {
+	FSMONITOR_REASON_ZERO = 0,
+	FSMONITOR_REASON_BARE = 1,
+};
+
 void fsm_settings__set_ipc(struct repository *r);
 void fsm_settings__set_hook(struct repository *r, const char *path);
 void fsm_settings__set_disabled(struct repository *r);
 
 enum fsmonitor_mode fsm_settings__get_mode(struct repository *r);
 const char *fsm_settings__get_hook_path(struct repository *r);
+enum fsmonitor_reason fsm_settings__get_reason(struct repository *r,
+					       struct strbuf *buf_reason);
 
 struct fsmonitor_settings;
 
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index f488d930dfd..3c4e6f5f89c 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -55,6 +55,32 @@ test_lazy_prereq UNTRACKED_CACHE '
 	test $ret -ne 1
 '
 
+# Test that we detect and disallow repos that are incompatible with FSMonitor.
+test_expect_success 'incompatible bare repo' '
+	test_when_finished "rm -rf ./bare-clone actual expect" &&
+	git init --bare bare-clone &&
+	cat >expect <<-\EOF &&
+	error: bare repos are incompatible with fsmonitor
+	EOF
+
+	test_must_fail \
+		git -C ./bare-clone -c core.fsmonitor=foo \
+			update-index --fsmonitor 2>actual &&
+	test_cmp expect actual &&
+
+	test_must_fail \
+		git -C ./bare-clone -c core.fsmonitor=true \
+			update-index --fsmonitor 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success FSMONITOR_DAEMON 'run fsmonitor-daemon in bare repo' '
+	test_when_finished "rm -rf ./bare-clone actual" &&
+	git init --bare bare-clone &&
+	test_must_fail git -C ./bare-clone fsmonitor--daemon run 2>actual &&
+	grep "bare repos are incompatible with fsmonitor" actual
+'
+
 test_expect_success 'setup' '
 	mkdir -p .git/hooks &&
 	: >tracked &&
-- 
gitgitgadget

