Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF7FC433E0
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 19:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 558E12073B
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 19:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCGmq+FW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgFATUH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 15:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgFATUG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 15:20:06 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A2BC061A0E
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 12:20:05 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t18so954173wru.6
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 12:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=K9xPkergh4ImEuNxAbdsLiXdbg6zL12bJ/cvJNvY6OM=;
        b=rCGmq+FWdc+dUVKvMzc0ceYPssNUsUbric5UylT4XBAH2X9O08gjnz/Bg0THZz5dAb
         8lKwBvoAEFBiKgIVKLSeVzqW8ldP/L7xQo9hel6aK6jmrMyYIppukLdv0gg1aJr+nIaq
         DKPJR/N3YKgBBhoWcSWLll6jZwS1IYLNRo7wO14+bMw4rbo+iMLf0g0oBqymCPokcSZN
         7imc4/VCe197V7BDBe7Th5JI90qZVAwedxVwg4MZKDPlCPUrwZo9WndqU3acovR9+RKi
         s7NdNoP29SxJt34yo37EEflRpdYW2MVT0gIMxYvJkk1vB9gbMf9VLna8/iZMZqKD3CzV
         +CrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=K9xPkergh4ImEuNxAbdsLiXdbg6zL12bJ/cvJNvY6OM=;
        b=AUJ6fC0NnDLdpxoOt6PGcCPUINsgGios1t5A0rH5m1ZDpKcYwE8BGUiKKR5Ahkl9Y+
         T6ZdJShP6kfk18Mx70G173kDDJHJfr62e0rsuRWje66C7XtibmiPaN0Zolpar1VR+cUQ
         OzwGqa5d+GRmXC08GOEhlgtXPvHJmC7mMIOhmJWi8+/vey6NwALzHXUgr0esmz5b1e2S
         78g9ZPm8AIR+Xy+FhPVKwvrxoiqvHMuykxmaHiyHOfiM6tyq0R5chcPFAfHdhhynswOL
         JsNECAhm3L8S1Dwtgd+4KyEI8Kmm8pq4xUTuh4Cim/sA84mp+cNKBX9aTMGN61NFruGd
         kFcA==
X-Gm-Message-State: AOAM531Jf2b7DUzebL3aZFELq7B/VMnvDlVrCxVvWH+16UrOdGIV66ES
        Z2A5S1OftgL7bFv3x7NcGStY1B0p
X-Google-Smtp-Source: ABdhPJxEoibUDHhh0xYid/U6wSetYVjNEpYyyr/1dEWrASaM95cQiRs6ZYL3Qsdc9YJO9LDEeJKB+g==
X-Received: by 2002:adf:fe07:: with SMTP id n7mr15156616wrr.240.1591039203662;
        Mon, 01 Jun 2020 12:20:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k16sm523606wrp.66.2020.06.01.12.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 12:20:03 -0700 (PDT)
Message-Id: <pull.797.git.git.1591039202561.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Jun 2020 19:20:02 +0000
Subject: [PATCH] clone/fetch: anonymize URLs in the reflog
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-797%2Fdscho%2Fanonymize-clone-reflog-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-797/dscho/anonymize-clone-reflog-v1
Pull-Request: https://github.com/git/git/pull/797

 builtin/clone.c            | 10 ++++++----
 builtin/fetch.c            |  9 +++++++--
 t/t5541-http-push-smart.sh | 15 +++++++++++++++
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 1ad26f4d8c8..5fe637a6702 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -938,7 +938,7 @@ static int path_exists(const char *path)
 int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int is_bundle = 0, is_local;
-	const char *repo_name, *repo, *work_tree, *git_dir;
+	const char *repo_name, *repo, *display_repo, *work_tree, *git_dir;
 	char *path, *dir;
 	int dest_exists;
 	const struct ref *refs, *remote_head;
@@ -993,11 +993,13 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	path = get_repo_path(repo_name, &is_bundle);
 	if (path)
-		repo = absolute_pathdup(repo_name);
+		display_repo = repo = absolute_pathdup(repo_name);
 	else if (!strchr(repo_name, ':'))
 		die(_("repository '%s' does not exist"), repo_name);
-	else
+	else {
 		repo = repo_name;
+		display_repo = transport_anonymize_url(repo);
+	}
 
 	/* no need to be strict, transport_set_option() will validate it again */
 	if (option_depth && atoi(option_depth) < 1)
@@ -1014,7 +1016,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		die(_("destination path '%s' already exists and is not "
 			"an empty directory."), dir);
 
-	strbuf_addf(&reflog_msg, "clone: from %s", repo);
+	strbuf_addf(&reflog_msg, "clone: from %s", display_repo);
 
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
