Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791A5C433E0
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C758E206B2
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhTCqHcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgHFRxP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbgHFQbT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 12:31:19 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E51C00217E
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 09:30:31 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f1so44063452wro.2
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 09:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ry0hpw+x89x8hU9nQ5fnnsze4ID6eAXp+p+08m26Kb4=;
        b=JhTCqHcQJN9+rBmpPTXUdSoGO1XV13mDljs8/ngrKiMxbVwE3MBw7k3e7dhO0c4R31
         kqxmjg46RMfUTX0zhDhkfZXfF2Dl6cMd65hRJ89d5Q0oDePRHPud421e51XEW6FvrvFs
         s4P7nyJ/yOf2afCIfq1suxRBmPyJgGErJjqHl/SoxqQowIAUX/Ey8sVIM9OLWTZxXZuW
         MknAcuiuBSfFUEYz4fK/f5qzl5Z+opsFwWnBUlYf5/upqhbKMeYAYriJPFl6kwj6RUC2
         ClLfFNZ9TGe2ZCNqP1O58zuZsITZdcBX6zSMAdYS74IK++Jw/zN+usADqoOMSXv+eenY
         BAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ry0hpw+x89x8hU9nQ5fnnsze4ID6eAXp+p+08m26Kb4=;
        b=HnjbL/fEvvAiTJwCLw9h3e16akBv0/gPL/uaCSij2ddIJlxxZqX21flwNgsKyEvsJu
         d8TfbNt8byMkVaXtASxHl+tN8AU2Xw+I8fPc+06fmxhHEQ+Rb5Hb7BqvNMFtY7OTeHGL
         Oa/68XJZ4fpjdaM9SVG2K3srtZ/rf9OylLOnWOUIXMjo8+AxMCWCtVM4Oh3FF4DRfXCd
         Q9O8MSgTthEmlN2lrUR4ow2SCvNQ7ypK3vcdmhguao0MJQ6dJdaSXpeK1p7vYckcfll8
         Tovv0KTmI4ik281Z56sG5p2Du46NYmQUCe/lZJhnK6cZ5csFiLElpdKD8zu08DbPutRM
         qnsQ==
X-Gm-Message-State: AOAM531lmp+l2+jrpwSlSSpRLWRpUObKl6HURN0CYkV8LePNSMCSnRki
        vg6XS14rpIXFaHPsxctLC4V0HCdD
X-Google-Smtp-Source: ABdhPJwW5uUNBshwTd7iboOhA3et+FhT7GhVegj7EU8qCVSQ4aCvfCRaZGJsVDBKvhBJC9QbwMJMqg==
X-Received: by 2002:a5d:43c4:: with SMTP id v4mr8518848wrr.426.1596731430070;
        Thu, 06 Aug 2020 09:30:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z207sm7267979wmc.2.2020.08.06.09.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 09:30:29 -0700 (PDT)
Message-Id: <37e59b1a8de378c5d7f23cb3f5630be7990bc3ff.1596731425.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.696.git.1596731424.gitgitgadget@gmail.com>
References: <pull.696.git.1596731424.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Aug 2020 16:30:20 +0000
Subject: [PATCH 5/9] midx: enable core.multiPackIndex by default
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

