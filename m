Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E076C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbiCWUei (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344738AbiCWUeV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:34:21 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8181F8CCE6
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:41 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d7so3777927wrb.7
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=to6LA9v0QpfoVQHqW9H5FU9iYM0ubdYNuvZ9qt8NDyA=;
        b=E56IJGL5761BW+/IzDxLA/prk4koVWV9jkbpSxssoeY/4XMbGr4roUrV0VL0vqxV2L
         tYPNWnwb9gzB5r8UwBZfHletgxlv7UUUbucor173sTkpdjXt9x6GD9hfXuDK9flZe9eO
         0EGv0snDCEhs7su11SiLBmK9uP9srYhMIO+P48invT/2Xi3nq9S46J1s9vVzkFvUwVry
         zblB+VdxokYuaPop8ZcVmyWyJl3hxfcVGp6JcC2bQC5/M0leM5Sfvk+Udje3OjYRn3ZN
         4/axuLYpEXwxdO8AESRflx9oFM1/fH+/Wbb8Lb4JdpRDdIbwyi1awy+pLC0MQ/t9pTxc
         kXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=to6LA9v0QpfoVQHqW9H5FU9iYM0ubdYNuvZ9qt8NDyA=;
        b=7WsnVrU9t9OaaNtUvWu4I5Kk2o1wQTwIeL4/PBsspYzGlgRLOog+fjSAE+/uAG5wV7
         PPz6KMX1T3bRj/yxPA2z2nTTbCRO7VTkb46Bzsv+G52G7D9kS185WU6VklVd1AjXDRjz
         eyWLnBWl2ddqne1aOX4/Quc3/IqBJX/7t7tiNvssNCM6Na2BbEF72yATQhFS63HyhQme
         GOJTBQ5D/Mk7PG4o6oa5kbELvmjBoWQtHl/pWHnzazXa0FNTqw2TmEpI9khYowAbbC00
         ZjMxwF6BNxsfsl+dO44pGQDCP2NDPaFiJRvOUdo+tY4EMpcx+6kcD26omaTR9q0NWESI
         MtWg==
X-Gm-Message-State: AOAM530T1X4zteu/g10ocMtcfykG1xzWDKMgLzgbVX5wBqV/miuMz+Ok
        opqkK3b0c5dk30bsAHmH8LLRIRigT53EsA==
X-Google-Smtp-Source: ABdhPJwQwFjTXC7HSzOVo9FVXAjL8l6WT62CPzoT0JVFiRKvsznyKGUcJpdThxGZ3CprdzxKlzRVrA==
X-Received: by 2002:adf:e241:0:b0:203:f56e:51e3 with SMTP id bl1-20020adfe241000000b00203f56e51e3mr1516957wrb.473.1648067559820;
        Wed, 23 Mar 2022 13:32:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d6dac000000b00204119d37d0sm849843wrs.26.2022.03.23.13.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:32:39 -0700 (PDT)
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
Subject: [PATCH v2 15/27] revisions API users: use release_revisions() for "prune_data" users
Date:   Wed, 23 Mar 2022 21:32:05 +0100
Message-Id: <patch-v2-15.27-566b739ac6c-20220323T203149Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1452.ga7cfc89151f
In-Reply-To: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com> <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
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
index 4fc717d5578..878eaf2e125 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1061,6 +1061,7 @@ static int check_changes_tracked_files(const struct pathspec *ps)
 
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
2.35.1.1452.ga7cfc89151f

