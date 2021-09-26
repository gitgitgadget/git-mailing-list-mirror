Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0391EC433F5
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 19:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEA3160EE4
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 19:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhIZTFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 15:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhIZTFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 15:05:16 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0DBC06176A
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 12:03:39 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v17so2015754wrv.9
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 12:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cGhk1Vgzr6nEX1gRTci2F0gc3WPAGl9wU0rY8Mqh1OA=;
        b=GnzEa54zGqjpjx3WB4oVulf/Fw0lNzLqO7Qak4WAx50hbnGBGl+njz1FN8O5k642y9
         GDFRURVhCuyny3MVJkCf6zgs0XaaJXjQGxBSpVsLiflN3Lx7/y9Z3lKVirdJkk5BBuMu
         sWo1ZL4F73o+znCOaHbGYxCXaOYrzJtZcYF3K0FBFTzobBFTSnSwHYoK7VefeRlLCY4h
         5QN2tO6eu5Z06AQ73rpAT8qoC9ZXAx0VMGXPrP7M8u/MkcZHyJI4Ej4xNIYc/K6MUBRG
         CdfRklZ7ulXqQUmfuXwKkHDRakdlD0cB2c11sbO1UZVDtMyeWSe0w6cmcM194SY5sJrS
         vMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cGhk1Vgzr6nEX1gRTci2F0gc3WPAGl9wU0rY8Mqh1OA=;
        b=7MKfFkBA5H4dPN1OfuAJ/Zy74Kp6JgYCDPnKf6jrUt3TnnuhTAP60EjX0Le4aQXL9a
         +WbaeoZC4DLomnNyBvhyDl8+TYS4sevvfaqbzKkXl0ILoZ//vXi9gbo0JUgcrAoD81HF
         TMhA4MXruGtK/8lkq0k9hJUBi/FNruwPpcLhnvMXVxb4COeDHwwKxQktBCpoobRVUTJu
         7HUSWEgyxyr/I4nRDkUBQV76zIs30cZ7KBk6BvkP+OxBWffn7/oJtYd+Tzh5Cgb0v8Qu
         V4ciZAjdYA8tJo4WyqEVkkuoHl0FsR+L4NK/XO8TOM/iXqwo9gKcQqS/3ShLfAeDx7CR
         TVlQ==
X-Gm-Message-State: AOAM532zJVQAeEEP8CruFzYC6kMWy7EBaSVQQul3/Uy7d6G5UR5r0M4F
        NzdelhZgF2mB96ODQooxjPjgxY/sg2gGSw==
X-Google-Smtp-Source: ABdhPJworu0/h4FOi7dnLP+ColgBGfs+DduPvX7hR6bNN+Q6N17e4W7DlMJyt2UghyGCkevOh0m9/g==
X-Received: by 2002:a7b:c453:: with SMTP id l19mr12210725wmi.7.1632683017887;
        Sun, 26 Sep 2021 12:03:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v20sm14691523wra.73.2021.09.26.12.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 12:03:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 7/8] hook.c users: use "hook_exists()" instead of "find_hook()"
Date:   Sun, 26 Sep 2021 21:03:28 +0200
Message-Id: <patch-v2-7.8-6237a1a5549-20210926T185800Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1291.g8857a6a91ac
In-Reply-To: <cover-v2-0.8-00000000000-20210926T185800Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20210926T185800Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the new hook_exists() function instead of find_hook() where the
latter was called in boolean contexts. This make subsequent changes in
a series where we further refactor the hook API clearer, as we won't
conflate wanting to get the path of the hook with checking for its
existence.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit.c       | 2 +-
 builtin/merge.c        | 2 +-
 builtin/receive-pack.c | 2 +-
 sequencer.c            | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 5359d961d22..883c16256c8 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1052,7 +1052,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		return 0;
 	}
 
-	if (!no_verify && find_hook("pre-commit")) {
+	if (!no_verify && hook_exists("pre-commit")) {
 		/*
 		 * Re-read the index as pre-commit hook could have updated it,
 		 * and write it out as a tree.  We must do this before we invoke
diff --git a/builtin/merge.c b/builtin/merge.c
index fe664f6a863..956b6259f21 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -849,7 +849,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	 * and write it out as a tree.  We must do this before we invoke
 	 * the editor and after we invoke run_status above.
 	 */
-	if (find_hook("pre-merge-commit"))
+	if (hook_exists("pre-merge-commit"))
 		discard_cache();
 	read_cache_from(index_file);
 	strbuf_addbuf(&msg, &merge_msg);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e3895aec622..25cc0c907e1 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1464,7 +1464,7 @@ static const char *update_worktree(unsigned char *sha1, const struct worktree *w
 
 	strvec_pushf(&env, "GIT_DIR=%s", absolute_path(git_dir));
 
-	if (!find_hook(push_to_checkout_hook))
+	if (!hook_exists(push_to_checkout_hook))
 		retval = push_to_deploy(sha1, &env, work_tree);
 	else
 		retval = push_to_checkout(sha1, &env, work_tree);
diff --git a/sequencer.c b/sequencer.c
index 8ee6c4ac240..e501945796d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1460,7 +1460,7 @@ static int try_to_commit(struct repository *r,
 		}
 	}
 
-	if (find_hook("prepare-commit-msg")) {
+	if (hook_exists("prepare-commit-msg")) {
 		res = run_prepare_commit_msg_hook(r, msg, hook_commit);
 		if (res)
 			goto out;
-- 
2.33.0.1291.g8857a6a91ac

