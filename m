Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE65BC4741F
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 12:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7942021D7A
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 12:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u6HcbF4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgIYMdr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 08:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbgIYMdq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 08:33:46 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E66C0613D3
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 05:33:45 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e2so3122853wme.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 05:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ry0hpw+x89x8hU9nQ5fnnsze4ID6eAXp+p+08m26Kb4=;
        b=u6HcbF4XKdonJ1XI5R/6EizjwMO8eshPL09M5E2dzkXDUJGP2KUjIUOVYo3CZ0EXbV
         cJon2C9YpyBBnO8DIFZeuywV8kKJxzpdZbvA34+GMjJ2sA0CqimXg6Uvz8CFxj3IZPJA
         ti685QhKSVdxFpF6dSWp5bte/cznDKqSaq/zLzXiZ3hWH3EipfPvSt72B/PY7lCsOgnc
         PGZs19FgHu4Qy1iRZ3ZfWvVb7dfRjalnNZq5RegMaIZmNap1f/vv6LoNvZaVB0o9h5jl
         8hLbfOBI9DUzB6NqNSMi3x5a8knEy9mYXhwC7tS/eo2wM/3LPQ8CGaxG6K2NP3LyXtIR
         m8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ry0hpw+x89x8hU9nQ5fnnsze4ID6eAXp+p+08m26Kb4=;
        b=YQgYZobhv+8N6bZ8zAZDRmjRHMVLaHDlnRpVlB/8H6Z6mQqPMOypwSVtDPkCp5FzNQ
         4cHm4RGO7SUR+PIXqZOjNKLDDlRiF8DhhQ+DN4UgnvVpO9h5trRWIK29Zc53BrwxHZXY
         KSHBqkYdiz3LWrrRzHSSeojy1xA+ir110+Jtf0Q6KxgF5QMFL0ySPRTjeJ1nZAfWzwj7
         19VGLd2Eo6vcNWffqscSTr0j1O7JUb1mv+oUVW4u44TosHW4LboIJ+fmEp9WX778XeW/
         MHUfhiVhIfSvwxtLPaTu5F2ERh3VzhEbX3Ap+5r1i+tfmxQPoZ+wJhoNcnGR5FT6/xLx
         1mKA==
X-Gm-Message-State: AOAM531uzfy4gh8bsOnmFvSzQRl1N+V3mOgX9U4AwGUdwazGGoQukCAl
        ibcmXg2/exOsHrvFsvHF2Ezm0gvB13g=
X-Google-Smtp-Source: ABdhPJyKs3XseOdT0AvXCrXPqML4A9gjm1+WGPdPRYhIHSpGHjYlrOMcLhL2fhpJPb3R1RyAMRWZ0g==
X-Received: by 2002:a1c:4d4:: with SMTP id 203mr3005614wme.102.1601037224344;
        Fri, 25 Sep 2020 05:33:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y1sm2826009wmi.36.2020.09.25.05.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 05:33:43 -0700 (PDT)
Message-Id: <0fe2036aa84794a3c592f294eceb8df76a637207.1601037218.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.696.v4.git.1601037218.gitgitgadget@gmail.com>
References: <pull.696.v3.git.1598380599.gitgitgadget@gmail.com>
        <pull.696.v4.git.1601037218.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Sep 2020 12:33:34 +0000
Subject: [PATCH v4 4/8] midx: enable core.multiPackIndex by default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The core.multiPackIndex setting has been around since c4d25228ebb
(config: create core.multiPackIndex setting, 2018-07-12), but has been
disabled by default. If a user wishes to use the multi-pack-index
feature, then they must enable this config and run 'git multi-pack-index
write'.

The multi-pack-index feature is relatively stable now, so make the
config option true by default. For users that do not use a
multi-pack-index, the only extra cost will be a file lookup to see if a
multi-pack-index file exists (once per process, per object directory).

Also, this config option will be referenced by an upcoming
"incremental-repack" task in the maintenance builtin, so move the config
option into the repository settings struct. Note that if
GIT_TEST_MULTI_PACK_INDEX=1, then we want to ignore the config option
and treat core.multiPackIndex as enabled.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/core.txt |  4 ++--
 midx.c                        | 11 +++--------
 repo-settings.c               |  6 ++++++
 repository.h                  |  2 ++
 4 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 74619a9c03..86c91d5381 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -606,8 +606,8 @@ core.useReplaceRefs::
 
 core.multiPackIndex::
 	Use the multi-pack-index file to track multiple packfiles using a
-	single index. See link:technical/multi-pack-index.html[the
-	multi-pack-index design document].
+	single index. See linkgit:git-multi-pack-index[1] for more
+	information. Defaults to true.
 
 core.sparseCheckout::
 	Enable "sparse checkout" feature. See linkgit:git-sparse-checkout[1]
diff --git a/midx.c b/midx.c
index a5fb797ede..ef499cf504 100644
--- a/midx.c
+++ b/midx.c
@@ -10,6 +10,7 @@
 #include "progress.h"
 #include "trace2.h"
 #include "run-command.h"
+#include "repository.h"
 
 #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
 #define MIDX_VERSION 1
@@ -384,15 +385,9 @@ int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, i
 {
 	struct multi_pack_index *m;
 	struct multi_pack_index *m_search;
-	int config_value;
-	static int env_value = -1;
 
-	if (env_value < 0)
-		env_value = git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0);
-
-	if (!env_value &&
-	    (repo_config_get_bool(r, "core.multipackindex", &config_value) ||
-	    !config_value))
+	prepare_repo_settings(r);
+	if (!r->settings.core_multi_pack_index)
 		return 0;
 
 	for (m_search = r->objects->multi_pack_index; m_search; m_search = m_search->next)
diff --git a/repo-settings.c b/repo-settings.c
index 0918408b34..5bd2c22726 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "repository.h"
+#include "midx.h"
 
 #define UPDATE_DEFAULT_BOOL(s,v) do { if (s == -1) { s = v; } } while(0)
 
@@ -47,6 +48,11 @@ void prepare_repo_settings(struct repository *r)
 		r->settings.pack_use_sparse = value;
 	UPDATE_DEFAULT_BOOL(r->settings.pack_use_sparse, 1);
 
+	value = git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0);
+	if (value || !repo_config_get_bool(r, "core.multipackindex", &value))
+		r->settings.core_multi_pack_index = value;
+	UPDATE_DEFAULT_BOOL(r->settings.core_multi_pack_index, 1);
+
 	if (!repo_config_get_bool(r, "feature.manyfiles", &value) && value) {
 		UPDATE_DEFAULT_BOOL(r->settings.index_version, 4);
 		UPDATE_DEFAULT_BOOL(r->settings.core_untracked_cache, UNTRACKED_CACHE_WRITE);
diff --git a/repository.h b/repository.h
index 3c1f7d54bd..3901ce0b65 100644
--- a/repository.h
+++ b/repository.h
@@ -37,6 +37,8 @@ struct repo_settings {
 
 	int pack_use_sparse;
 	enum fetch_negotiation_setting fetch_negotiation_algorithm;
+
+	int core_multi_pack_index;
 };
 
 struct repository {
-- 
gitgitgadget

