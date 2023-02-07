Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C642C636D3
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 18:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjBGSSb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 13:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjBGSRo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 13:17:44 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B833E60A
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 10:17:24 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id x3-20020a654143000000b004f2f2dafb21so5932971pgp.0
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 10:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UTXNmyRG9NzKoSWvWYTY4/IA2uob49GSwxXBgqWy+Mk=;
        b=ZmqRARlbakQ0MqP+VqGksXrURUd4BGdFhbM0RITepbAYAmJNObGDD2EJfU2lT6UzkV
         QiBvFktkRgAT/aqUspKyO9NddzU7QP9KNEiOre6xIcBWBqIAzEmiPZ0ywrxo6sPNMtOc
         rnd33QeP6Kw9Y2wUd5lhzDC3eAY1hTE6h/e4dbVUNGOSRknySazegpNA50ab8Pfzsh60
         5NbHmlC4J4BBB6YXifUOLIoyVhzMKW8F77729QSY0DwvMiE4YfXIl/JUj7Wo39t04J+i
         f6tfybgbZJY6YOrE45qgRSL3+nV4pmVONUP8MCTdENI3vMZNvAsWT1/Z38Qrz7l7ybnO
         a+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UTXNmyRG9NzKoSWvWYTY4/IA2uob49GSwxXBgqWy+Mk=;
        b=00cUP03JVeXcLc7bql5SnNhFFcu+jKJczFQV9sRHbOwac7QYckFQHZw5yqKB0v1IXC
         +n8RHFrot8H7chjJmbulfrAttLQhJ/V/Hdi0DQLFC4TBS2vBwna5ZmLqRqC2RYkSeG0m
         UbpQTH4yVDSFd3DsvD98l9fWkEMcRl/NYTMu9UjgSRmffXx5STF4Dj5rjxZUUKC4eenf
         /BQRq+b7lny96Kn4FBSZ+h0HcxTfW3jqSH4Lgl+xoigZHiUGfp3BiElabYaw95QZhQyZ
         C810mGgngyuKf5fY2aexIuRjBAyCPRd5M+j/AiST9SH+TMC7PnQLC6W8a2hAv1BjMqDa
         rOCw==
X-Gm-Message-State: AO0yUKVmLz7VTRYBVVF7rJ8ZbZg8IhmjVYDXeT0claE4LR7PovXmZmfB
        unZ1rZCrQDReqFwqg7FALJ4O8cLX1Fe+ruO4O4b/yXEcvIWLPbt8htQx++LOthnfJFbWuLmcaMZ
        ybg7+mnsRc93ApQM6HQPGUMrE3vHm1zjHESClrxeOH8F8B687thpGNCCptQIPxZsZQw==
X-Google-Smtp-Source: AK7set+eGLNYRZCNv4cDhy1epV4VUrb06FHgVDWWTC5OY7PQHJtZw6dJTjGAdMn4hQCtMdwFzEsAaCI2R+Un4WQ=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90a:f684:b0:230:ddd8:869b with SMTP
 id cl4-20020a17090af68400b00230ddd8869bmr1366563pjb.87.1675793842549; Tue, 07
 Feb 2023 10:17:22 -0800 (PST)
Date:   Tue,  7 Feb 2023 18:17:03 +0000
In-Reply-To: <20230117193041.708692-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230117193041.708692-1-calvinwan@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230207181706.363453-5-calvinwan@google.com>
Subject: [PATCH v7 4/7] submodule: refactor is_submodule_modified()
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, avarab@gmail.com,
        chooglen@google.com, newren@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor out submodule status logic and error messages that will be
used in a future patch.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 submodule.c | 65 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/submodule.c b/submodule.c
index 768d4b4cd7..d88aa2c573 100644
--- a/submodule.c
+++ b/submodule.c
@@ -28,6 +28,10 @@ static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
 static int initialized_fetch_ref_tips;
 static struct oid_array ref_tips_before_fetch;
 static struct oid_array ref_tips_after_fetch;
+static const char *status_porcelain_start_error =
+	N_("could not run 'git status --porcelain=2' in submodule %s");
+static const char *status_porcelain_fail_error =
+	N_("'git status --porcelain=2' failed in submodule %s");
 
 /*
  * Check if the .gitmodules file is unmerged. Parsing of the .gitmodules file
@@ -1870,6 +1874,40 @@ int fetch_submodules(struct repository *r,
 	return spf.result;
 }
 
+static int verify_submodule_git_directory(const char *path)
+{
+	const char *git_dir;
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_addf(&buf, "%s/.git", path);
+	git_dir = read_gitfile(buf.buf);
+	if (!git_dir)
+		git_dir = buf.buf;
+	if (!is_git_directory(git_dir)) {
+		if (is_directory(git_dir))
+			die(_("'%s' not recognized as a git repository"), git_dir);
+		strbuf_release(&buf);
+		/* The submodule is not checked out, so it is not modified */
+		return 0;
+	}
+	strbuf_release(&buf);
+	return 1;
+}
+
+static void prepare_status_porcelain(struct child_process *cp,
+			     const char *path, int ignore_untracked)
+{
+	strvec_pushl(&cp->args, "status", "--porcelain=2", NULL);
+	if (ignore_untracked)
+		strvec_push(&cp->args, "-uno");
+
+	prepare_submodule_repo_env(&cp->env);
+	cp->git_cmd = 1;
+	cp->no_stdin = 1;
+	cp->out = -1;
+	cp->dir = path;
+}
+
 static int parse_status_porcelain(char *str, size_t len,
 				  unsigned *dirty_submodule,
 				  int ignore_untracked)
@@ -1915,33 +1953,14 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	struct strbuf buf = STRBUF_INIT;
 	FILE *fp;
 	unsigned dirty_submodule = 0;
-	const char *git_dir;
 	int ignore_cp_exit_code = 0;
 
-	strbuf_addf(&buf, "%s/.git", path);
-	git_dir = read_gitfile(buf.buf);
-	if (!git_dir)
-		git_dir = buf.buf;
-	if (!is_git_directory(git_dir)) {
-		if (is_directory(git_dir))
-			die(_("'%s' not recognized as a git repository"), git_dir);
-		strbuf_release(&buf);
-		/* The submodule is not checked out, so it is not modified */
+	if (!verify_submodule_git_directory(path))
 		return 0;
-	}
-	strbuf_reset(&buf);
-
-	strvec_pushl(&cp.args, "status", "--porcelain=2", NULL);
-	if (ignore_untracked)
-		strvec_push(&cp.args, "-uno");
 
-	prepare_submodule_repo_env(&cp.env);
-	cp.git_cmd = 1;
-	cp.no_stdin = 1;
-	cp.out = -1;
-	cp.dir = path;
+	prepare_status_porcelain(&cp, path, ignore_untracked);
 	if (start_command(&cp))
-		die(_("Could not run 'git status --porcelain=2' in submodule %s"), path);
+		die(_(status_porcelain_start_error), path);
 
 	fp = xfdopen(cp.out, "r");
 	while (strbuf_getwholeline(&buf, fp, '\n') != EOF) {
@@ -1956,7 +1975,7 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	fclose(fp);
 
 	if (finish_command(&cp) && !ignore_cp_exit_code)
-		die(_("'git status --porcelain=2' failed in submodule %s"), path);
+		die(_(status_porcelain_fail_error), path);
 
 	strbuf_release(&buf);
 	return dirty_submodule;
-- 
2.39.1.519.gcb327c4b5f-goog

