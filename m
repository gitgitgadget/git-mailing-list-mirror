Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C30C433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiCYTkl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbiCYTiz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:38:55 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8483124A880
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:19:21 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n35so4973264wms.5
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x/x5a5mQdRnOhZMFOTIoDYdHye9mTeJs2yQUdXtB5ZI=;
        b=jiibVSf/70j2i+NrPaNElUb05GQ2SPkAYqNCAxKy2JgxQurELLenW1yEIX+9RVdh/a
         gtKYV0VFiRkUd7rV88IlaIVuFIE4XkJfq3i+2SzKjomVqbrxiZL09PxNSh1qmg5DgH4O
         jnQqj9LCA8D6hQ10f2+L6UnYvYc5UE2xWdVczNa/yzCAG8ePdTC9/U/yyhJ8I4sjEcsm
         5N4RhWDGP1C0FusG4ksSDVt/WQ9t/HNVoKTB8beFcLz+ef/lD1ZJLk1JIS3WOkMRggAx
         aaadD8dMhwawerpNYKFl1PKkEpno9G4X9BhVGNHzWpSBmiZUYk1Yy6UvJj3jY1KjnUcX
         J4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x/x5a5mQdRnOhZMFOTIoDYdHye9mTeJs2yQUdXtB5ZI=;
        b=EosFKWUH5LqF69uZapB7VhAXmib4ho2VMPw2zWsujUpG2lLXjAbfTQ5CAAI64HVp6C
         Z0dyyMjhNsvEjNetsl0Cfg3A9erEkjvuziFgzNcGpb8uqWiIm6Ft6/u8AjZvme16z4zP
         ywcQ0iuM4MorIWkuYOwjvVegjuUF7cY/17dyKtQEe08RxZPKncpt8laEA/y2HVHd3Vti
         xwHzsps/RX6Zwa0uPlYveaNrGMvL0Q4qtMTXwNx7pS/wLLpBO6CIO2POsMfA7SnvHvLM
         E4TEvYJiJeDmP+BlKnJ2Gw1FWyMrn41p76txjxQCghhtZpQrZdhv6Fu3k8aKbg3lMh4W
         wx/w==
X-Gm-Message-State: AOAM532Q/vfN6PDIf7/Lfww2vgqAEctB0yCs3bcOK+oEMxtvJ6bupzMV
        G9OGCyZSIZ1hin2f/VGDZiXlbvreX14c4w==
X-Google-Smtp-Source: ABdhPJyfHfKEOyP350HzjuefmJggPH56iH2r6s22jCoehiEO+t8j/Qr5BIlyW4kK46jrkfYEUAOLPw==
X-Received: by 2002:a7b:cd88:0:b0:38c:9d04:d794 with SMTP id y8-20020a7bcd88000000b0038c9d04d794mr10749681wmj.140.1648228785872;
        Fri, 25 Mar 2022 10:19:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm7554165wru.99.2022.03.25.10.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:19:45 -0700 (PDT)
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
Subject: [PATCH v3 15/27] revisions API users: use release_revisions() for "prune_data" users
Date:   Fri, 25 Mar 2022 18:18:39 +0100
Message-Id: <patch-v3-15.27-f8e0eb52957-20220325T171340Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1509.ge4eeb5bd39e
In-Reply-To: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
References: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com> <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
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
2.35.1.1509.ge4eeb5bd39e

