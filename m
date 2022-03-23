Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BBCC433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 18:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343944AbiCWSEk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 14:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343942AbiCWSEj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 14:04:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62FD193C7
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 11:03:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b12-20020a056902030c00b0061d720e274aso1738997ybs.20
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 11:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=FTlLrjtJosXkVvihT0NtFgmDWG44Q+izdXH/XTLZ9fU=;
        b=JGpKZREipj9sX2BEFr9ozKfgkzb618rd4uQJs+RcFZyYcLFZzXeqLdtQkTzebic/ts
         DuhEXpAd1bekRcrHs9RQZiEWKpEDfAcMfVcXi0vzNixDBI79REmk3oc5yfGtkf4ogGDd
         kkNLEQ9R6GQB/U0ut2OBByhdI9Pf76Y6HGhAR5Kk+LK6DOcpHd0l9CRlzOVozjBEKB2f
         TttkAkK/kAIxsWvdz3Kr1xC5npdkRCvNZqyj4QCR+NOEmBjCSlRwbDcQCfVVGofdDU6a
         R6A3S38Y7HLqIKMamrrBcToFq53AanH7u3FuIBH3A/MDdAA1K/wXMmN6/iNI5umlX+Zm
         FPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=FTlLrjtJosXkVvihT0NtFgmDWG44Q+izdXH/XTLZ9fU=;
        b=x/7PDof06HH+qvjyTtk1tCTwvL7vvgkAhd80+PNLTJo1VONcEE7kOuyDhS/Wt3CV5E
         ZJrDG5csSN7fDrTgisQbnhKEKUXxiZuQWzy9DDnynHO1BvDrzfVaPuVen/hv+4Yq8HPW
         4BBpFQpYElJ0rU0gKQPT+wKb8z7PBzepjBAUdwXQpaf7HyG+BD7e/fEE6LuWm7+bXIOl
         Vvrg/YWYGgy6MwuaFHkZ72xGuCQvFAi1ZXjxrbRUSIPsNtB9voi/CmU0GyrmsSVaiMWb
         H6Snr7iRST5hgPENbJHbJpcWnL38kbG6wMRSqwDYruq+fk91Bipnj600zFcR3fbsdYNf
         /4Tg==
X-Gm-Message-State: AOAM533K6smLIsT0IDqeGeoHrX2iMlzGqVGdffbWTARW0jb2HFfIK7fm
        jUFDk2u3Ugm9HNtTB5ZXDx4vZkQY0/hldr/2q/ti5BtqrHFOC28xR5/RZdL96m1uuJSVSsQ/YKw
        tGBo2EAXct8MC4WySEBPK5moGVl4gGg2JMckwubOrRFgI/md558B1Ji2cqF1LqCA=
X-Google-Smtp-Source: ABdhPJwM0hGK5Z+qlDF3bY9dLEZNtMN3UhvbDDqfa9+Vq9wQ2Zhy9KBfK3Yh7dLH1UpXV4F759ypxvnLpBqHRA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:713a:4212:eb25:f4d7])
 (user=steadmon job=sendgmr) by 2002:a0d:e80d:0:b0:2dc:8c0:df1f with SMTP id
 r13-20020a0de80d000000b002dc08c0df1fmr1212345ywe.52.1648058586827; Wed, 23
 Mar 2022 11:03:06 -0700 (PDT)
Date:   Wed, 23 Mar 2022 11:03:05 -0700
Message-Id: <1b27e0b115f858a422e0a2891688227be8f3db01.1648055915.git.steadmon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [RFC PATCH] repo-settings: set defaults even when not in a repo
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     lessleydennington@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

prepare_repo_settings() initializes a `struct repository` with various
default config options and settings read from a repository-local config
file. In 44c7e62 (2021-12-06, repo-settings:prepare_repo_settings only
in git repos), prepare_repo_settings was changed to issue a BUG() if it
is called by a process whose CWD is not a Git repository. This approach
was suggested in [1].

This breaks fuzz-commit-graph, which attempts to parse arbitrary
fuzzing-engine-provided bytes as a commit graph file.
commit-graph.c:parse_commit_graph() calls prepare_repo_settings(), but
since we run the fuzz tests without a valid repository, we are hitting
the BUG() from 44c7e62 for every test case.

Fix this by refactoring prepare_repo_settings() such that it sets
default options unconditionally; if its process is in a Git repository,
it will also load settings from the local config. This eliminates the
need for a BUG() when not in a repository.

Concerns:

Are any callers strictly dependent on having a BUG() here? I suspect
that the worst that would happen is that rather than this BUG(), the
caller would later hit its own BUG() or die(), so I do not think this is
a blocker. Additionally, every builtin that directly calls
prepare_repo_settings is either marked as RUN_SETUP, which means we
would die() prior to calling it anyway, or checks on its own before
calling it (builtin/diff.c). There are several callers in library code,
though, and I have not tracked down how all of those are used.

Alternatives considered:

Setting up a valid repository for fuzz testing would avoid triggering
this bug, but would unacceptably slow down the test cases.

Refactoring parse_commit_graph() in such a way that the fuzz test has an
alternate entry point that avoids calling prepare_repo_settings() might
be possible, but would be a much larger change than this one. It would
also run the risk that the changes would be so extensive that the fuzzer
would be merely testing its own custom commit-graph implementation,
rather than the one that's actually used in the real world.

[1]: https://lore.kernel.org/git/xmqqcznh8913.fsf@gitster.g/

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 repo-settings.c | 111 ++++++++++++++++++++++++------------------------
 1 file changed, 55 insertions(+), 56 deletions(-)

diff --git a/repo-settings.c b/repo-settings.c
index b4fbd16cdc..d154b37007 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -17,9 +17,6 @@ void prepare_repo_settings(struct repository *r)
 	char *strval;
 	int manyfiles;
 
-	if (!r->gitdir)
-		BUG("Cannot add settings for uninitialized repository");
-
 	if (r->settings.initialized++)
 		return;
 
@@ -28,27 +25,63 @@ void prepare_repo_settings(struct repository *r)
 	r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;
 	r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_CONSECUTIVE;
 
-	/* Booleans config or default, cascades to other settings */
-	repo_cfg_bool(r, "feature.manyfiles", &manyfiles, 0);
-	repo_cfg_bool(r, "feature.experimental", &experimental, 0);
+	if (r->gitdir) {
+		/* Booleans config or default, cascades to other settings */
+		repo_cfg_bool(r, "feature.manyfiles", &manyfiles, 0);
+		repo_cfg_bool(r, "feature.experimental", &experimental, 0);
 
-	/* Defaults modified by feature.* */
-	if (experimental) {
-		r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
-	}
-	if (manyfiles) {
-		r->settings.index_version = 4;
-		r->settings.core_untracked_cache = UNTRACKED_CACHE_WRITE;
-	}
+		/* Defaults modified by feature.* */
+		if (experimental) {
+			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
+		}
+		if (manyfiles) {
+			r->settings.index_version = 4;
+			r->settings.core_untracked_cache = UNTRACKED_CACHE_WRITE;
+		}
+
+		/* Boolean config or default, does not cascade (simple)  */
+		repo_cfg_bool(r, "core.commitgraph", &r->settings.core_commit_graph, 1);
+		repo_cfg_bool(r, "commitgraph.readchangedpaths", &r->settings.commit_graph_read_changed_paths, 1);
+		repo_cfg_bool(r, "gc.writecommitgraph", &r->settings.gc_write_commit_graph, 1);
+		repo_cfg_bool(r, "fetch.writecommitgraph", &r->settings.fetch_write_commit_graph, 0);
+		repo_cfg_bool(r, "pack.usesparse", &r->settings.pack_use_sparse, 1);
+		repo_cfg_bool(r, "core.multipackindex", &r->settings.core_multi_pack_index, 1);
+		repo_cfg_bool(r, "index.sparse", &r->settings.sparse_index, 0);
 
-	/* Boolean config or default, does not cascade (simple)  */
-	repo_cfg_bool(r, "core.commitgraph", &r->settings.core_commit_graph, 1);
-	repo_cfg_bool(r, "commitgraph.readchangedpaths", &r->settings.commit_graph_read_changed_paths, 1);
-	repo_cfg_bool(r, "gc.writecommitgraph", &r->settings.gc_write_commit_graph, 1);
-	repo_cfg_bool(r, "fetch.writecommitgraph", &r->settings.fetch_write_commit_graph, 0);
-	repo_cfg_bool(r, "pack.usesparse", &r->settings.pack_use_sparse, 1);
-	repo_cfg_bool(r, "core.multipackindex", &r->settings.core_multi_pack_index, 1);
-	repo_cfg_bool(r, "index.sparse", &r->settings.sparse_index, 0);
+		/*
+		 * Non-boolean config
+		 */
+		if (!repo_config_get_int(r, "index.version", &value))
+			r->settings.index_version = value;
+
+		if (!repo_config_get_string(r, "core.untrackedcache", &strval)) {
+			int v = git_parse_maybe_bool(strval);
+
+			/*
+			 * If it's set to "keep", or some other non-boolean
+			 * value then "v < 0". Then we do nothing and keep it
+			 * at the default of UNTRACKED_CACHE_KEEP.
+			 */
+			if (v >= 0)
+				r->settings.core_untracked_cache = v ?
+					UNTRACKED_CACHE_WRITE : UNTRACKED_CACHE_REMOVE;
+			free(strval);
+		}
+
+		if (!repo_config_get_string(r, "fetch.negotiationalgorithm", &strval)) {
+			int fetch_default = r->settings.fetch_negotiation_algorithm;
+			if (!strcasecmp(strval, "skipping"))
+				r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
+			else if (!strcasecmp(strval, "noop"))
+				r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_NOOP;
+			else if (!strcasecmp(strval, "consecutive"))
+				r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_CONSECUTIVE;
+			else if (!strcasecmp(strval, "default"))
+				r->settings.fetch_negotiation_algorithm = fetch_default;
+			else
+				die("unknown fetch negotiation algorithm '%s'", strval);
+		}
+	}
 
 	/*
 	 * The GIT_TEST_MULTI_PACK_INDEX variable is special in that
@@ -60,40 +93,6 @@ void prepare_repo_settings(struct repository *r)
 	if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0))
 		r->settings.core_multi_pack_index = 1;
 
-	/*
-	 * Non-boolean config
-	 */
-	if (!repo_config_get_int(r, "index.version", &value))
-		r->settings.index_version = value;
-
-	if (!repo_config_get_string(r, "core.untrackedcache", &strval)) {
-		int v = git_parse_maybe_bool(strval);
-
-		/*
-		 * If it's set to "keep", or some other non-boolean
-		 * value then "v < 0". Then we do nothing and keep it
-		 * at the default of UNTRACKED_CACHE_KEEP.
-		 */
-		if (v >= 0)
-			r->settings.core_untracked_cache = v ?
-				UNTRACKED_CACHE_WRITE : UNTRACKED_CACHE_REMOVE;
-		free(strval);
-	}
-
-	if (!repo_config_get_string(r, "fetch.negotiationalgorithm", &strval)) {
-		int fetch_default = r->settings.fetch_negotiation_algorithm;
-		if (!strcasecmp(strval, "skipping"))
-			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
-		else if (!strcasecmp(strval, "noop"))
-			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_NOOP;
-		else if (!strcasecmp(strval, "consecutive"))
-			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_CONSECUTIVE;
-		else if (!strcasecmp(strval, "default"))
-			r->settings.fetch_negotiation_algorithm = fetch_default;
-		else
-			die("unknown fetch negotiation algorithm '%s'", strval);
-	}
-
 	/*
 	 * This setting guards all index reads to require a full index
 	 * over a sparse index. After suitable guards are placed in the

base-commit: 715d08a9e51251ad8290b181b6ac3b9e1f9719d7
-- 
2.35.1.894.gb6a874cedc-goog

