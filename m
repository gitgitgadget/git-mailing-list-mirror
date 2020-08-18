Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C73AC433DF
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A994207DA
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/TuJxg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgHROZw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgHROZk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 10:25:40 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4757C061345
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:25:38 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a14so18481650wra.5
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ry0hpw+x89x8hU9nQ5fnnsze4ID6eAXp+p+08m26Kb4=;
        b=a/TuJxg/UZGoUCckP1EHoQcPNyW00NSB4S10YX3bcQCSusVhBfD+ZArqJF5piCp4aF
         c+5nITGJxBJCsR7jNOyvjFZYDE6LsIcROOorLvImIkI+GL32qP3wjmliu+eQSPkK2rwL
         EJVYE8BRlUQT8D3LXUNnYguwjn1v8uCVPfRDI1SdbRPbm+ruoyi8gsEvySMThCg44pap
         ry2QUByQkxCCmRf8qQYuuC/4BA04rtRcAgKxyXHwNPCVnfOrC9yProMZLnnB4/3PAwzg
         TeakPQ0ATNrPm/UHNChzuJ5/QC0oLkj09+Y8q/B/Y5Y9I3S2KZnhotHWfk5IIkAXrKdR
         +bvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ry0hpw+x89x8hU9nQ5fnnsze4ID6eAXp+p+08m26Kb4=;
        b=MxxyvQpqiYY3Qej6ZbzIDNkAXZyPbJ7liYqCyFwCwzTYi7UFOW6RRb2qw9m9dCsEyP
         wRtpUCYJSxr7YWZ+cuzR1ofmbwNReVXSd3Kd3TkoOzxu4VHqSxETMwhF4S0fLPD3EA3S
         RUr7JMSRYXYm06QpR0zDoHB3bxu2bTJJAPXMgvBII7iFUKdttGBfkbxry+nSXTjtGm+h
         nncHWkRF3N8u5PHGtkkOCAGj7c1yrtp+nn0A5DtbeJ5rOWu3R2BQrXxJbLSiPyaLz9Mx
         237ogwLSFQFJGPBdE5cMNM+mwpXNkhZ9hwvqWYR5AJGomsSWM0GFyhKo7lZCpOKSer5l
         81nw==
X-Gm-Message-State: AOAM532mgM2PJIBq26i2p4QD1+I92mnsausdR/Ydl3NLr4lZwAm5Ydep
        Lao3bEljb7DI1wIztJI4F1xZI36oiW4=
X-Google-Smtp-Source: ABdhPJxfDuS0Nq9kZjwuGCfdmaXSTcbDH5HbZLbFfAnhYnzGuv77/+8/xK3pXddMe7rQste1L7OcMQ==
X-Received: by 2002:adf:82d5:: with SMTP id 79mr19906597wrc.282.1597760737405;
        Tue, 18 Aug 2020 07:25:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h10sm35055514wro.57.2020.08.18.07.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 07:25:36 -0700 (PDT)
Message-Id: <0ee2434bdbabc6f3ed6e80402aa3a19bf9626fc6.1597760730.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.696.v2.git.1597760730.gitgitgadget@gmail.com>
References: <pull.696.git.1596731424.gitgitgadget@gmail.com>
        <pull.696.v2.git.1597760730.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Aug 2020 14:25:26 +0000
Subject: [PATCH v2 5/9] midx: enable core.multiPackIndex by default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
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

