Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF5AC4332E
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 12:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6212076E
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 12:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxxUBbPf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgCTMiR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:38:17 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42540 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgCTMiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 08:38:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id b21so6913412edy.9
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 05:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=a/RJ3B19GrtdA1cBnNvBYv1VPg4liq+Psbi8N0DPvLM=;
        b=QxxUBbPfk2eRdodQwZ9FhJvnMwrfjYb9AjckLx2JO9YGzw1L0alkdyPjjGWLcoc+PL
         dqIVrVI7xkNVbxKR2aDRtMVP2zz512Kiv8HQDFGOr8fQVi0Ie5ZZLw/ISQBWF2s+J9ja
         0VnKNGxItMXTL5lh1rEQMuHU8pPJwzmeq0DbC+5fWi2KtFzZeyoTfo3blV9tO3onNLBJ
         CY+fPMBpK1Z14mm1GDzPe3aKaBxhpNXsXIIg5MFujUkQCS2k+IgYmLtnY64+lKX0YWGz
         Yx6LbsmKT1sgSLn11xERWfM8d1OziD1D0r/ig1QzGDVdGCNmUdnSQVCXxT45hptac0/T
         hpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=a/RJ3B19GrtdA1cBnNvBYv1VPg4liq+Psbi8N0DPvLM=;
        b=cD02zMLhKDgYh7c2UUJ2eCRckrU9kCbGcAN/ELL6wezJxDa7iMkIkDuSjBj0khEgqq
         esy+iRLWWpVyhAEBxjlMHACdCv7diJlxLHuCkqz9svmkvYAU4DfF/xJYyCVNEeZUQizD
         IDVodmJW4JaAg0IH1bGpEGfBvGJ4sh/LwTvGWqh2VlP6JA41W4KKMTTbYfBWM4RP9mm7
         OwSqOvQcElcPGL//L3P2cku48f3OTknDHxTwsmyQbK56vGPTcBMOLB2UeDtzMqA5lS/4
         lEAjOhZOtAhYmx4dBjqQN0wEmCcPbCAM/Pbuup4e5B8C+7jyyobIBmAUs5XGKcWAIJRN
         jADA==
X-Gm-Message-State: ANhLgQ1fVaINzX7E0KSZwQlEKY+Ds2Mvjb8dbzKfxFILc74bUM+O5FCK
        GiQWD/Wv9oafJ8C+z5BUtoveMCni
X-Google-Smtp-Source: ADFU+vuV8BA5kY61Ujrs6M+6SGcPcKfyBxX7gvnl/jFyRiD8C/WEE+qooIE4K/lCEQxV/vTn6Def3g==
X-Received: by 2002:a50:9e45:: with SMTP id z63mr7527542ede.338.1584707893582;
        Fri, 20 Mar 2020 05:38:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ny24sm361067ejb.50.2020.03.20.05.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 05:38:13 -0700 (PDT)
Message-Id: <908d5c77c96feeeda74144447586ccdc2be4665e.1584707890.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.585.v3.git.1584707890.gitgitgadget@gmail.com>
References: <pull.585.v2.git.1584707247753.gitgitgadget@gmail.com>
        <pull.585.v3.git.1584707890.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Mar 2020 12:38:10 +0000
Subject: [PATCH v3 2/2] pack-objects: flip the use of GIT_TEST_PACK_SPARSE
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, jrnieder@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The environment variable GIT_TEST_PACK_SPARSE was previously used
to allow testing the --sparse option for "git pack-objects" in
the test suite. This allowed interesting cases of "git push" to
also test this algorithm.

Since pack.useSparse is now true by default, we do not need this
variable to _enable_ the --sparse option, but instead to _disable_
it. This flips how we work with the variable a bit.

When checking for the variable, default to a value of -1 for
"unset". If unset, then take the default from the repo settings,
which is currently 1. Then, the --[no-]sparse command-line option
will override either of these settings.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/pack-objects.c         | 4 ++--
 t/README                       | 6 +++---
 t/t5322-pack-objects-sparse.sh | 1 +
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 02aa6ee4808..eff9542f09f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3469,9 +3469,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 
 	read_replace_refs = 0;
 
-	sparse = git_env_bool("GIT_TEST_PACK_SPARSE", 0);
+	sparse = git_env_bool("GIT_TEST_PACK_SPARSE", -1);
 	prepare_repo_settings(the_repository);
-	if (!sparse && the_repository->settings.pack_use_sparse != -1)
+	if (sparse < 0)
 		sparse = the_repository->settings.pack_use_sparse;
 
 	reset_pack_idx_option(&pack_idx_opts);
diff --git a/t/README b/t/README
index 9afd61e3ca0..99ebb18829f 100644
--- a/t/README
+++ b/t/README
@@ -386,9 +386,9 @@ GIT_TEST_INDEX_VERSION=<n> exercises the index read/write code path
 for the index version specified.  Can be set to any valid version
 (currently 2, 3, or 4).
 
-GIT_TEST_PACK_SPARSE=<boolean> if enabled will default the pack-objects
-builtin to use the sparse object walk. This can still be overridden by
-the --no-sparse command-line argument.
+GIT_TEST_PACK_SPARSE=<boolean> if disabled will default the pack-objects
+builtin to use the non-sparse object walk. This can still be overridden by
+the --sparse command-line argument.
 
 GIT_TEST_PRELOAD_INDEX=<boolean> exercises the preload-index code path
 by overriding the minimum number of cache entries required per thread.
diff --git a/t/t5322-pack-objects-sparse.sh b/t/t5322-pack-objects-sparse.sh
index 6e5d6bdb0a7..a581eaf5293 100755
--- a/t/t5322-pack-objects-sparse.sh
+++ b/t/t5322-pack-objects-sparse.sh
@@ -107,6 +107,7 @@ test_expect_success 'non-sparse pack-objects' '
 
 # --sparse is enabled by default by pack.useSparse
 test_expect_success 'sparse pack-objects' '
+	GIT_TEST_PACK_SPARSE=-1 &&
 	git rev-parse			\
 		topic1			\
 		topic1^{tree}		\
-- 
gitgitgadget
