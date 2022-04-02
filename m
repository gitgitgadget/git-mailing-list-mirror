Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062D4C433F5
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 10:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354521AbiDBKwN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 06:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354514AbiDBKv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 06:51:59 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63738140754
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 03:50:01 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y10so5682314edv.7
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 03:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P1sTAUu5Atuw13TSGFlVIp0Oo+YGkAJEDZ3Gigm/BVA=;
        b=pewyRpG2zvxdlf5ExS+r20hJyq2mlgsjFcShLvfRA6T0rWf9pFB4IzQ3mmfNLFLaZO
         Cl/pKq7A3yOzv4YAxciuPTUkzMsTPPpO1s3ScPGIfRn8huPvsFFjSt691g2LWN9lTNif
         D/eSnSaWisrcSX2HsHoNuZIWnMVKMQVjjW2GwZwi/ty7jRHX0SPqqNm6894li/zHXBIC
         Dqc6j6aiVO/VEhDwKHPYG3T2OBEq2MNdz3OqsSRFThuPbZ+K7IP1F4AftOxeipqtCuae
         7yb0QxD6qI7DZgMMu1gUQe3+EeXtTwhmYllt+SNssQZWXgoJrETUFa2R1BBWQhf4eTw8
         uTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P1sTAUu5Atuw13TSGFlVIp0Oo+YGkAJEDZ3Gigm/BVA=;
        b=QY3sPXaiT2XQ3Eoc252LUyFu2UMXkBrGihFgcRYbNQ1erlLNV4DgPI5z4OSu1y94iw
         ZaPQ0pE1k/QZiEw8La8wZml06HT7o2boy5vom05CmTbd1j1LH1VrjA4G0ZsEzy9utLn/
         IXQzrn+hUnafwN6G5G7QC4oJfrY8CDcIMGXfBnZbDIZMDWUscR0zoWVJ9n5Rvsw/PeEA
         NvmHgYxKqmUF50yrD19OCq0cBePTB+dxz6vduapzmD1wM1+I4GUweQSDcg5VUuMOHGdp
         UPofos1ZsEDagizDwdZLF1s4bbhptHR1LyRsoCDcbBQydSWSvTGXVQF15TutvWwOOkcI
         olfA==
X-Gm-Message-State: AOAM5335o+0mb45K9Ed5iRT1i5JJCZ0rTL6qaRJuxOXNyY54oTZzlIg+
        hN9sggQ4sxgOiFcJSWGLXRmrUWfCsXH2Bw==
X-Google-Smtp-Source: ABdhPJw4hZEritC2GX8Aj7cN0FvnAFJCJOKtVxS4dG0nlq45mF7PtwvA5ysDNDdRRkeE1Jg86DI1sw==
X-Received: by 2002:aa7:c683:0:b0:418:f5f3:9684 with SMTP id n3-20020aa7c683000000b00418f5f39684mr24896724edq.184.1648896599644;
        Sat, 02 Apr 2022 03:49:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r23-20020a056402235700b00419171bc571sm2366137eda.59.2022.04.02.03.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:49:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 15/27] revisions API users: use release_revisions() for "prune_data" users
Date:   Sat,  2 Apr 2022 12:49:29 +0200
Message-Id: <patch-v5-15.27-03e9bd73d4b-20220402T102002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1584.g2aeb20a6519
In-Reply-To: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com> <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use release_revisions() for users of "struct rev_list" that reach into
the "struct rev_info" and clear the "prune_data" already.

In a subsequent commit we'll teach release_revisions() to clear this
itself, but in the meantime let's invoke release_revisions() here to
clear anything else we may have missed, and for reasons of having
consistent boilerplate.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/add.c | 1 +
 diff-lib.c    | 1 +
 wt-status.c   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/builtin/add.c b/builtin/add.c
index f507d2191cd..115a26ea633 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -143,6 +143,7 @@ int add_files_to_cache(const char *prefix,
 	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
 	clear_pathspec(&rev.prune_data);
+	release_revisions(&rev);
 	return !!data.add_errors;
 }
 
diff --git a/diff-lib.c b/diff-lib.c
index d6800274bd5..0f16281253f 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -642,6 +642,7 @@ int do_diff_cache(const struct object_id *tree_oid, struct diff_options *opt)
 	if (diff_cache(&revs, tree_oid, NULL, 1))
 		exit(128);
 	clear_pathspec(&revs.prune_data);
+	release_revisions(&revs);
 	return 0;
 }
 
diff --git a/wt-status.c b/wt-status.c
index f9100621375..a14fad1e03a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -617,6 +617,7 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
 	copy_pathspec(&rev.prune_data, &s->pathspec);
 	run_diff_files(&rev, 0);
 	clear_pathspec(&rev.prune_data);
+	release_revisions(&rev);
 }
 
 static void wt_status_collect_changes_index(struct wt_status *s)
-- 
2.35.1.1585.gd85f8dcb745

