Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DC9C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 22:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbhKVWpw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 17:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbhKVWpu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 17:45:50 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2031CC061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 14:42:43 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id u18so35488313wrg.5
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 14:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zrat1o9DQDxUklWklG5AjpqXcgx5ylwZ/LFbnaN2Yug=;
        b=mtnwbpwAFXPzR+HlW8yrIv+U9xmh8PMAaC1Lnes/vzqwTIYM7zUTIr5jbiz1iRSkyv
         cGDJQiVNoeOhYodqYiw6rh+xIP9ub2NbFJ7rjIL3mpwFkeQ9yHXVYWLqg+Z4VaiXJhDZ
         4dHGZanQ+62sPFNfrHIA4e9bnKVlvKXJ/eSasfY0njP/lkkte9V9dqtBb24CRUUYvLB3
         9C+uhiTeUX48virEkPSJoPlni2RlFsfr+erpLFfeXedzGGb4ZZOlvINkz6LWScHCZuz1
         qbLeKsKEibS7YfhtHjn74RGXaLMJPqQtSlClJeek5klBa10Ek2mRgAp28gxDPkka2fZm
         4Hgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zrat1o9DQDxUklWklG5AjpqXcgx5ylwZ/LFbnaN2Yug=;
        b=plhUBU4r0iBqEfvzkCkwriFWaL3A1upOBBT9SBFLIMIaQarBgRgWn2oNPAF+dTmbNV
         NYTeTk51Ks2vGwCx4FLhCnN+dZyWe+EkNvHhSDyT+cY5LaK005LlPvGfe2pMOK/PlWJU
         huuZ9uiE+//2Jtn/VTnH9IST5MUtDe8SuzdKiuKW/xDz5OP/Hm9bxUfGLQnofCshakVN
         UDTLrdYYXZ9qn7+bWOyM2PhbGW2PIPJ3UH5xfCBGlxIy0KZ7VD9rTLSbKyudXiY/Ucge
         loqxkdee6GeL51uAJhZ1xPmT6xdcrmf9tu92zrvULKPe8hw/YfNsZ+6pt0yiSDlSaqWT
         KCVA==
X-Gm-Message-State: AOAM532T2u4xb4WUGXxYuGbpQuDaSIYF3W9lIO8BzRxTt4IhYAu5lMZE
        QAbqHZjc/PhIQa+qLlkAY2Xjb4Ga4HA=
X-Google-Smtp-Source: ABdhPJxKnKEA5gu7phSaFpNEzttK06VaqF3otTK1bJ7tJlsRyM/mpXELj8EMdjQg6vPtWzwej8hrng==
X-Received: by 2002:a05:6000:181:: with SMTP id p1mr1086790wrx.292.1637620961609;
        Mon, 22 Nov 2021 14:42:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f15sm12895941wmg.30.2021.11.22.14.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 14:42:41 -0800 (PST)
Message-Id: <81e208cf454b61c761fa66e4f43a464ed439ba59.1637620958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
References: <pull.1050.v3.git.1635802069.gitgitgadget@gmail.com>
        <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Nov 2021 22:42:35 +0000
Subject: [PATCH v4 1/4] sparse index: enable only for git repos
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lessley Dennington <lessleydennington@gmail.com>

Check whether git dir exists before adding any repo settings. If it
does not exist, BUG with the message that one cannot add settings for an
uninitialized repository. If it does exist, proceed with adding repo
settings.

Additionally, ensure the above BUG is not triggered when users pass the -h
flag by adding a check for the repository to the checkout and pack-objects
builtins.

Finally, ensure the above BUG is not triggered for commit-graph by
returning early if the git directory does not exist.

Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
---
 builtin/checkout.c     | 6 ++++--
 builtin/pack-objects.c | 9 ++++++---
 commit-graph.c         | 5 ++++-
 repo-settings.c        | 3 +++
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8c69dcdf72a..31632b07888 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1588,8 +1588,10 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 
 	git_config(git_checkout_config, opts);
 
-	prepare_repo_settings(the_repository);
-	the_repository->settings.command_requires_full_index = 0;
+	if (startup_info->have_repository) {
+		prepare_repo_settings(the_repository);
+		the_repository->settings.command_requires_full_index = 0;
+	}
 
 	opts->track = BRANCH_TRACK_UNSPECIFIED;
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1a3dd445f83..45dc2258dc7 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3976,9 +3976,12 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	read_replace_refs = 0;
 
 	sparse = git_env_bool("GIT_TEST_PACK_SPARSE", -1);
-	prepare_repo_settings(the_repository);
-	if (sparse < 0)
-		sparse = the_repository->settings.pack_use_sparse;
+
+	if (startup_info->have_repository) {
+		prepare_repo_settings(the_repository);
+		if (sparse < 0)
+			sparse = the_repository->settings.pack_use_sparse;
+	}
 
 	reset_pack_idx_option(&pack_idx_opts);
 	git_config(git_pack_config, NULL);
diff --git a/commit-graph.c b/commit-graph.c
index 2706683acfe..265c010122e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -632,10 +632,13 @@ static int prepare_commit_graph(struct repository *r)
 	struct object_directory *odb;
 
 	/*
+	 * Early return if there is no git dir or if the commit graph is
+	 * disabled.
+	 *
 	 * This must come before the "already attempted?" check below, because
 	 * we want to disable even an already-loaded graph file.
 	 */
-	if (r->commit_graph_disabled)
+	if (!r->gitdir || r->commit_graph_disabled)
 		return 0;
 
 	if (r->objects->commit_graph_attempted)
diff --git a/repo-settings.c b/repo-settings.c
index b93e91a212e..00ca5571a1a 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -17,6 +17,9 @@ void prepare_repo_settings(struct repository *r)
 	char *strval;
 	int manyfiles;
 
+	if (!r->gitdir)
+		BUG("Cannot add settings for uninitialized repository");
+
 	if (r->settings.initialized++)
 		return;
 
-- 
gitgitgadget

