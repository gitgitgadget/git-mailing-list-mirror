Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0975C433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 14:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E16264E20
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 14:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhBZOvW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 09:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhBZOvT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 09:51:19 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFC5C06174A
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 06:50:39 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k66so8046904wmf.1
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 06:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=Y6u1X1WRl1SaqC9UcFVX+G/55EKkViU1Ql5GX5HMfGE=;
        b=HVu0+4RXcEGOQ6fIkm1wJX73+4nnrGjOuTgMa9QcB8my3It3r6IW4lyYioQgYG9LJw
         PdI6YozED/xSsDw6eK6asKfMVlnYqLN1XI40DlbFw670pFQUrCmZz4RLT73ShmBP1Qcy
         9ImgME5Vo6RV8F8ZBIMZVWQQJB1JyfkqBCRWWAedNX52XahXtjkuK+5C1GZJ+6V9F+GL
         PHg38U/cbmIH1EXRIYkBR+qa1e+GfdHDHtbeBoRmSYSK0/vtPAdl4Jk6is0thP/oFO5h
         bndkqQIrUzqQx07OUJYPdeutzZ6vPOo9MLvOr84lWsK7mYZ0bfjch8YrO1CdI0xTaPCP
         ICnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Y6u1X1WRl1SaqC9UcFVX+G/55EKkViU1Ql5GX5HMfGE=;
        b=EdTnwsGdoDpe9KKhT+s7pFtxirdg/oXl9d2zc9BV5TPEEowgazz4+VV0x1i8Oftc7/
         pGcpqdGT3OOh08AEQg4a+Bu3HIMM6I/+EMmPiBlUxdf+O2kK0Xo91fxdcrLetrFanRIj
         lF/j7ooUzj1oHRKsci114gFZ02fzqWnlFHwWORx8MKAKPdXibhPZ2BAQymTTLnCueYat
         uVA1xACVtl8HKZqAsVFbQgI050veq+KBi1s8X7ReTeLFsZmrXKTuyGS6UovLdS+V2hc5
         FLrmnjYBhzouGzLNIQ/HZK/oDQ4U9PenMaMGizylU44R5cIy3csw3AApmsbhrP1oJGXV
         7/Bg==
X-Gm-Message-State: AOAM532JA0mmLEzR/2MM7nnWK931ti8Kb95OnQDdi7GZ5jJZuquPxw1B
        Su4nmsNx9KF9vIhyaU0ONlNzVRm6gA8=
X-Google-Smtp-Source: ABdhPJzzGPfzWxLkJm4WR/W9vpSCxX+sECw1ZtIyEmYt7Hlu3Z4G8ytAjhA4QtNGiX+l985unkwIVg==
X-Received: by 2002:a7b:c119:: with SMTP id w25mr3186155wmi.127.1614351037819;
        Fri, 26 Feb 2021 06:50:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f2sm10518624wrq.34.2021.02.26.06.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 06:50:37 -0800 (PST)
Message-Id: <pull.888.git.1614351036334.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Feb 2021 14:50:35 +0000
Subject: [PATCH] commit-graph: warn about incompatibilities only when trying
 to write
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In c85eec7fc37 (commit-graph: when incompatible with graphs, indicate
why, 2021-02-11), we started warning the user if they tried to write a
commit-graph in a shallow repository, or one containing replace objects.

However, this patch was a bit overzealous, as Git now _also_ warns when
merely checking whether there _is_ a usable commit graph, not only when
writing one.

Let's suppress that warning unless we want to write a commit-graph.

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    commit-graph: warn about incompatibilities only when trying to write
    
    As pointed out by Ævar in
    https://lore.kernel.org/git/87pn0o6y1e.fsf@evledraar.gmail.com, my
    recent patch to trigger warnings in repositories that are incompatible
    with the commit-graph was a bit too overzealous. Here is a fix for that.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-888%2Fdscho%2Fwarn-a-little-less-if-commit-graph-is-skipped-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-888/dscho/warn-a-little-less-if-commit-graph-is-skipped-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/888

 commit-graph.c          | 20 ++++++++++++--------
 t/t5318-commit-graph.sh | 13 +++++++++++++
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 8fd480434353..245b7108e0d1 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -198,7 +198,7 @@ static struct commit_graph *alloc_commit_graph(void)
 
 extern int read_replace_refs;
 
-static int commit_graph_compatible(struct repository *r)
+static int commit_graph_compatible(struct repository *r, int quiet)
 {
 	if (!r->gitdir)
 		return 0;
@@ -206,8 +206,9 @@ static int commit_graph_compatible(struct repository *r)
 	if (read_replace_refs) {
 		prepare_replace_object(r);
 		if (hashmap_get_size(&r->objects->replace_map->map)) {
-			warning(_("repository contains replace objects; "
-			       "skipping commit-graph"));
+			if (!quiet)
+				warning(_("repository contains replace "
+					  "objects; skipping commit-graph"));
 			return 0;
 		}
 	}
@@ -215,12 +216,15 @@ static int commit_graph_compatible(struct repository *r)
 	prepare_commit_graft(r);
 	if (r->parsed_objects &&
 	    (r->parsed_objects->grafts_nr || r->parsed_objects->substituted_parent)) {
-		warning(_("repository contains (deprecated) grafts; "
-		       "skipping commit-graph"));
+		if (!quiet)
+			warning(_("repository contains (deprecated) grafts; "
+			       "skipping commit-graph"));
 		return 0;
 	}
 	if (is_repository_shallow(r)) {
-		warning(_("repository is shallow; skipping commit-graph"));
+		if (!quiet)
+			warning(_("repository is shallow; skipping "
+				  "commit-graph"));
 		return 0;
 	}
 
@@ -652,7 +656,7 @@ static int prepare_commit_graph(struct repository *r)
 		 */
 		return 0;
 
-	if (!commit_graph_compatible(r))
+	if (!commit_graph_compatible(r, 1))
 		return 0;
 
 	prepare_alt_odb(r);
@@ -2123,7 +2127,7 @@ int write_commit_graph(struct object_directory *odb,
 		warning(_("attempting to write a commit-graph, but 'core.commitGraph' is disabled"));
 		return 0;
 	}
-	if (!commit_graph_compatible(the_repository))
+	if (!commit_graph_compatible(the_repository, 0))
 		return 0;
 
 	ctx = xcalloc(1, sizeof(struct write_commit_graph_context));
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 2ed0c1544da1..2699c55e9a93 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -741,4 +741,17 @@ test_expect_success 'corrupt commit-graph write (missing tree)' '
 	)
 '
 
+test_expect_success 'warn about incompatibilities (only) when writing' '
+	git init warn &&
+	test_commit -C warn initial &&
+	test_commit -C warn second &&
+	git -C warn replace --graft second &&
+	test_config -C warn gc.writecommitgraph true &&
+
+	git -C warn gc 2>err &&
+	test_i18ngrep "skipping commit-graph" err &&
+	git -C warn rev-list -1 second 2>err &&
+	test_i18ngrep ! "skipping commit-graph" err
+'
+
 test_done

base-commit: c85eec7fc37e1ca79072f263ae6ea1ee305ba38c
-- 
gitgitgadget
