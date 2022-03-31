Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B32C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 01:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbiCaBOd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352264AbiCaBON (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 21:14:13 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2EC6661E
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:20 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i4so12715899wrb.5
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ESoi267A/ferITwtHSrviAQR83iPGxs6U8SoIDnYGu4=;
        b=Ss0kC0/lNNCqjK8xuh5hrGZDsl2q2iWV1JL/wCR7mPAUMUKbfaVemPFBtzFEt9pDI0
         9MY0zJX4h/R7u73oCO4F7EKG+9m7h1slWd59IIORU16x1kg90nWCgBIViH9qijKUVH9O
         1Xx/A6D1MHH34XcG384eTSSaplm0A0U7lcnRLq7NH0Mz1ZiYP+jiQ9VDvyiluZ1h/OFB
         pUWgpD1N6c/542QIG76a3ZxvyZue/YXgalINN0lwl0pPU4RUJ6otfooFUyi5pVG9+NRt
         tyj0IVXwqOeGXkEuxgvZySNleN1wBrOM93NhtGrisG/E+GYU3U9WVVWFdiHuO6x1tI6K
         AzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ESoi267A/ferITwtHSrviAQR83iPGxs6U8SoIDnYGu4=;
        b=E690jSMhs4XkEzp5Y5AzSbcu6S7fLDUc9ZtfZXLy6uvtHpyUMxthYb5JvNQWpJV07U
         cuj2qkAk2JMO5+TiWeXLiGZJe2C+27p+YTdlVdokjRoNCEQpE8k/QSDYEo80NKmQTOxi
         CUoQbgHA8XYDW8jiJrnpYSWscYPwwEmV9jEWk0WwwDfxx9wLGFH0pVFJZgTTbWc1q4ze
         GHAn6WbaJlXtur4AAjDR/PbeCaEoxEHQ3KM2mYujVlGd4hIG4Uo6gnN1MVtykFzEt0gD
         LYVkKOzTgkkOlFidRp3IjmbKiKIESXOO1YSKX/+aZusJTpStcPsVZ3zaCD3TyCWdHfbo
         bLdQ==
X-Gm-Message-State: AOAM533OK0NpZ4m1uPYT/X2NCfQsrBgKlQCQroD1oO9v9F+ocq+hzPEm
        rHc4lB6gnf6gPgRKwaQzi2N3PENsAluwxA==
X-Google-Smtp-Source: ABdhPJy/xH0rVzaxogciC0Sih3RYKglBnFgy0JC9TFniwBJfFwEEuyodiLEpXgXphm+3/QvfdKJ4cQ==
X-Received: by 2002:a5d:5041:0:b0:203:ecc8:47de with SMTP id h1-20020a5d5041000000b00203ecc847demr1951761wrt.240.1648689138541;
        Wed, 30 Mar 2022 18:12:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c26cb00b0037ff53511f2sm5789218wmv.31.2022.03.30.18.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 18:12:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 15/27] revisions API users: use release_revisions() for "prune_data" users
Date:   Thu, 31 Mar 2022 03:11:20 +0200
Message-Id: <patch-v4-15.27-c12b3d5a035-20220331T005325Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1557.g4e3e9cdb5e0
In-Reply-To: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com> <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
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
 builtin/add.c   | 1 +
 builtin/stash.c | 1 +
 diff-lib.c      | 1 +
 wt-status.c     | 1 +
 4 files changed, 4 insertions(+)

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
 
diff --git a/builtin/stash.c b/builtin/stash.c
index 76d162387e2..a6ee030d4bd 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1060,6 +1060,7 @@ static int check_changes_tracked_files(const struct pathspec *ps)
 
 done:
 	clear_pathspec(&rev.prune_data);
+	release_revisions(&rev);
 	return ret;
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
2.35.1.1557.g4e3e9cdb5e0

