Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF21C433E0
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 20:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE4A5206E6
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 20:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWUA4myk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgFDUId (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgFDUId (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 16:08:33 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE3BC08C5C0
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 13:08:32 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h5so7464685wrc.7
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 13:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1e1SVdh11oF55BndZqWMPRP80f9rBPFfJQXczpSsUKs=;
        b=sWUA4mykjMoBlEwZSf6qulU5Xh0g5H+h6NpjqH762ooy3dq1sSX/3tPQx85HRIl0BW
         0URrUiYR8Nv89G2xYLLTNqQB/BOeT6zoz+QDNh30RPP6yY09zDV8wc+TC9p+8W1Oveux
         GcMJVbAJOQymoF7HcyiPdNGknIuYdVnfDtFK3L8nGveOuSYvXfGbCroVubcRpdlRQT/X
         wpTtKwG0GAlYQhw4EOBT4KDJnlWTYVwnyZp6gcNSI6UwsJJo/V3nWH8KTuhVmX0FeYqY
         JwmCk8LmoX6jfN5JVSUgy9bS7MIXs+5m5ySwr4FYNyxL68/dY0LyGxdEnVO1qChMEQ3/
         Wf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1e1SVdh11oF55BndZqWMPRP80f9rBPFfJQXczpSsUKs=;
        b=KMOQCgeD29He7SZbw1x4WwbW50CAZ3k7bjgZDAVBj1WmtoQZDCAOH8G4FJ3bblqDpL
         e4jDYDy/SnZblJQInzWcwzoDtbss9KosiiNJeujk+bDV7eT7+3vHSD/tC6ZtdJMqzEmN
         Wgi3xJWB+J3UtD23WFpbdMvD2OijIhm7oVn1Rmxux0tq4rkIqujZZR/6Pb+XXfWNlQ0O
         1mCGoidDibS3LALMWzes/wUd+Ksg9w0PG32xLSyQ+JLaj8YRov5qf3Hz9fscod6rTU3c
         2MVIXJGNtphtuccMt83Qh5M2iN/OBFkIAZSlDYPUoZrd1jBjkhETeIUBUuzMOnQaEZu6
         vdNA==
X-Gm-Message-State: AOAM5331oO/QdA2vwWwV/aLI0oHAmDzG+DCLi4q8W/7ku47cqmaE4gFL
        lwh1Da6aTWg4jnJN6TLu3+cWghSV
X-Google-Smtp-Source: ABdhPJx0JmRhbfdMF3/897C5wm7Sz9bAkhsZrtv2IYAq+kfnhB2LyNrAb3Bv4h1A48hDwEOk9PaYcg==
X-Received: by 2002:a5d:440c:: with SMTP id z12mr6172612wrq.241.1591301310665;
        Thu, 04 Jun 2020 13:08:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i10sm9132178wrw.51.2020.06.04.13.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 13:08:30 -0700 (PDT)
Message-Id: <pull.797.v2.git.git.1591301309308.gitgitgadget@gmail.com>
In-Reply-To: <pull.797.git.git.1591039202561.gitgitgadget@gmail.com>
References: <pull.797.git.git.1591039202561.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Jun 2020 20:08:29 +0000
Subject: [PATCH v2] clone/fetch: anonymize URLs in the reflog
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Even if we strongly discourage putting credentials into the URLs passed
via the command-line, there _is_ support for that, and users _do_ do
that.

Let's scrub them before writing them to the reflog.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Anonymize URLs in the reflog
    
    This came up in an internal audit, but we do not consider this to be a
    big deal: the reflog is local and not really shared with anybody.
    
    Changes since v1:
    
     * Changed the if...else if...else cadence to move the die() to the last
       arm
     * Stopped the memory leak of display_repo (allocated by 
       transport_anonymize_url())

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-797%2Fdscho%2Fanonymize-clone-reflog-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-797/dscho/anonymize-clone-reflog-v2
Pull-Request: https://github.com/git/git/pull/797

Range-diff vs v1:

 1:  11c0d47c95e ! 1:  933a7353847 clone/fetch: anonymize URLs in the reflog
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## builtin/clone.c ##
     -@@ builtin/clone.c: static int path_exists(const char *path)
     - int cmd_clone(int argc, const char **argv, const char *prefix)
     +@@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       {
       	int is_bundle = 0, is_local;
     --	const char *repo_name, *repo, *work_tree, *git_dir;
     -+	const char *repo_name, *repo, *display_repo, *work_tree, *git_dir;
     - 	char *path, *dir;
     + 	const char *repo_name, *repo, *work_tree, *git_dir;
     +-	char *path, *dir;
     ++	char *path, *dir, *display_repo = NULL;
       	int dest_exists;
       	const struct ref *refs, *remote_head;
     + 	const struct ref *remote_head_points_at;
      @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
     - 
       	path = get_repo_path(repo_name, &is_bundle);
       	if (path)
     --		repo = absolute_pathdup(repo_name);
     -+		display_repo = repo = absolute_pathdup(repo_name);
     - 	else if (!strchr(repo_name, ':'))
     - 		die(_("repository '%s' does not exist"), repo_name);
     + 		repo = absolute_pathdup(repo_name);
     +-	else if (!strchr(repo_name, ':'))
     +-		die(_("repository '%s' does not exist"), repo_name);
      -	else
     -+	else {
     ++	else if (strchr(repo_name, ':')) {
       		repo = repo_name;
      +		display_repo = transport_anonymize_url(repo);
     -+	}
     ++	} else
     ++		die(_("repository '%s' does not exist"), repo_name);
       
       	/* no need to be strict, transport_set_option() will validate it again */
       	if (option_depth && atoi(option_depth) < 1)
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       			"an empty directory."), dir);
       
      -	strbuf_addf(&reflog_msg, "clone: from %s", repo);
     -+	strbuf_addf(&reflog_msg, "clone: from %s", display_repo);
     ++	strbuf_addf(&reflog_msg, "clone: from %s",
     ++		    display_repo ? display_repo : repo);
     ++	free(display_repo);
       
       	if (option_bare)
       		work_tree = NULL;


 builtin/clone.c            | 13 ++++++++-----
 builtin/fetch.c            |  9 +++++++--
 t/t5541-http-push-smart.sh | 15 +++++++++++++++
 3 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 1ad26f4d8c8..002d23ab0a2 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -939,7 +939,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int is_bundle = 0, is_local;
 	const char *repo_name, *repo, *work_tree, *git_dir;
-	char *path, *dir;
+	char *path, *dir, *display_repo = NULL;
 	int dest_exists;
 	const struct ref *refs, *remote_head;
 	const struct ref *remote_head_points_at;
@@ -994,10 +994,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	path = get_repo_path(repo_name, &is_bundle);
 	if (path)
 		repo = absolute_pathdup(repo_name);
-	else if (!strchr(repo_name, ':'))
-		die(_("repository '%s' does not exist"), repo_name);
-	else
+	else if (strchr(repo_name, ':')) {
 		repo = repo_name;
+		display_repo = transport_anonymize_url(repo);
+	} else
+		die(_("repository '%s' does not exist"), repo_name);
 
 	/* no need to be strict, transport_set_option() will validate it again */
 	if (option_depth && atoi(option_depth) < 1)
@@ -1014,7 +1015,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		die(_("destination path '%s' already exists and is not "
 			"an empty directory."), dir);
 
-	strbuf_addf(&reflog_msg, "clone: from %s", repo);
+	strbuf_addf(&reflog_msg, "clone: from %s",
+		    display_repo ? display_repo : repo);
+	free(display_repo);
 
 	if (option_bare)
 		work_tree = NULL;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index bf6bab80fab..d58b7572114 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1765,8 +1765,13 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 	/* Record the command line for the reflog */
 	strbuf_addstr(&default_rla, "fetch");
-	for (i = 1; i < argc; i++)
-		strbuf_addf(&default_rla, " %s", argv[i]);
+	for (i = 1; i < argc; i++) {
+		/* This handles non-URLs gracefully */
+		char *anon = transport_anonymize_url(argv[i]);
+
+		strbuf_addf(&default_rla, " %s", anon);
+		free(anon);
+	}
 
 	fetch_config_from_gitmodules(&submodule_fetch_jobs_config,
 				     &recurse_submodules);
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 23be8ce92d6..2d60381a5e7 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -456,6 +456,21 @@ test_expect_success 'push status output scrubs password' '
 	grep "^To $HTTPD_URL/smart/test_repo.git" status
 '
 
+test_expect_success 'clone/fetch scrubs password from reflogs' '
+	cd "$ROOT_PATH" &&
+	git clone "$HTTPD_URL_USER_PASS/smart/test_repo.git" \
+		reflog-test &&
+	cd reflog-test &&
+	test_commit prepare-for-force-fetch &&
+	git switch -c away &&
+	git fetch "$HTTPD_URL_USER_PASS/smart/test_repo.git" \
+		+master:master &&
+	# should have been scrubbed down to vanilla URL
+	git log -g master >reflog &&
+	grep "$HTTPD_URL" reflog &&
+	! grep "$HTTPD_URL_USER_PASS" reflog
+'
+
 test_expect_success 'colorize errors/hints' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	test_must_fail git -c color.transport=always -c color.advice=always \

base-commit: af6b65d45ef179ed52087e80cb089f6b2349f4ec
-- 
gitgitgadget
