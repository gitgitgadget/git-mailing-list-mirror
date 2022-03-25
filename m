Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ED9C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 01:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354502AbiCYB6i (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 21:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238577AbiCYB6h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 21:58:37 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EF99E9D7
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 18:57:03 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r4-20020a1c4404000000b0038ccb70e239so397255wma.3
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 18:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Uef0p8UPfw5E+8m95GwAeAK8jHDMFCm8OQPYke9eLWQ=;
        b=j5pUa91+PotOpCL1/Ap2mDvjUwWUfMzstiUTHxhIhlUWvH2nbFuzyh5WPqxtY8O2Tg
         wMaZYvGmcJ1VR0XNt5kZZSlHKZvAfyKI40soNPzk/XQc6oK9SUpQxGRWiIq18wKfkdnr
         +Lj8GbZdk7kf6lS+ycINmfjx44NEWnHXwYE4A2iwG5CpkIsiXiO2f/G1Z8o3b/S+inE4
         vC3cWP3skbBEOouAIRniER4RLfWoXQJ4MGR6xMHOdgT0IHEXD4FdnhTOqEMtizzabV+R
         sg7ObTjnnwddjV/F27Bdzm5oKzQFLaZScXWfG8vsLUuvKH2rgS/kBxYbO4rlUwEjf3K7
         Gibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Uef0p8UPfw5E+8m95GwAeAK8jHDMFCm8OQPYke9eLWQ=;
        b=fPMlgkkrAhxhJONYN/0FEzT/IOWHL6lzO30PFjF9w33FFRE6e5GJaPjb38SoamwzZr
         ePJ83X5CFZ1sOH5lo47qvhIJG5KFnA40ZxkGM5QSe1j/0ZnoqTaQ18m9HnhI7wSG0gaf
         Ul51uWpdcOieGvUTqF8XV8gofciJuJ156I4jUhCUNTuZBQQ0yzUWLGj/kMChzW7WtBdK
         iWArf6v0+1+PKmNkendHUOT1z/ubT4pZI2Lgn82rH74wh7rzIJShS8/cYDH5eAtQy9Wk
         mAnPS5EjPkuVlEcPOJfSnt3e7zf/Ik/klS0dz3PpqEzY5KSbfAYbAv/y5yR6oMy1b65p
         BbTQ==
X-Gm-Message-State: AOAM530gC6fEXLMthqtbQYwXjLAjOnaTPq1xnrceTjtMI2Wdt1TOvhnr
        1xivy5fZEPCXByH7CRXNdMIRuMw6qY0=
X-Google-Smtp-Source: ABdhPJxPcVlthpqzDKx2mrq0uMkXBXoqrh5OV9UxA4qLthKZjnqP0/mp/qK7WZYuuVNZIq7Y2EuTiQ==
X-Received: by 2002:a05:600c:3c9a:b0:38c:837e:e450 with SMTP id bg26-20020a05600c3c9a00b0038c837ee450mr16713719wmb.194.1648173421751;
        Thu, 24 Mar 2022 18:57:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c4f4900b00389e8184edcsm7419228wmq.35.2022.03.24.18.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 18:57:00 -0700 (PDT)
Message-Id: <pull.1187.git.1648173419533.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Mar 2022 01:56:59 +0000
Subject: [PATCH] mv: refresh stat info for moved entry
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     reichemn@icloud.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add 'refresh_cache_entry()' after moving the index entry in
'rename_index_entry_at()'. Internally, 'git mv' uses
'rename_index_entry_at()' to move the source index entry to the destination,
overwriting the old entry if '-f' is specified. However, it does not refresh
the stat information on destination index entry, making its 'CE_UPTODATE'
flag out-of-date until the index is refreshed (e.g., by 'git status').

Some commands, such as 'git reset', assume the 'CE_UPTODATE' information
they read from the index is accurate, and use that information to determine
whether the operation can be done successfully or not. In order to ensure
the index is correct for commands such as these, explicitly refresh the
destination index entry in 'git mv' before exiting.

Reported-by: Maximilian Reichel <reichemn@icloud.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
    mv: refresh stat info for moved entry
    
    This patch fixes a bug [1] encountered when executing 'git reset --merge
    HEAD' immediately after 'git mv -f' overwrites an existing index entry.
    Because the 'CE_UPTODATE' flag is not refreshed on the destination entry
    (and therefore incorrectly appeared to not be "up-to-date"), 'git reset
    --merge HEAD' fails when it should otherwise succeed.
    
    To avoid exiting 'git mv' with a stale index that may affect subsequent
    commands, 'rename_index_entry_at()' (used internally by 'git mv') is
    updated to refresh the destination index entry's stat information after
    the move is complete.
    
    [1]
    https://lore.kernel.org/git/84FF8F9A-3A9A-4F2A-8D8E-5D50F2F06203@icloud.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1187%2Fvdye%2Freset%2Fmerge-inconsistency-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1187/vdye/reset/merge-inconsistency-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1187

 read-cache.c  |  1 +
 t/t7001-mv.sh | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 1ad56d02e1d..2c5ccc48d6c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -148,6 +148,7 @@ void rename_index_entry_at(struct index_state *istate, int nr, const char *new_n
 	untracked_cache_remove_from_index(istate, old_entry->name);
 	remove_index_entry_at(istate, nr);
 	add_index_entry(istate, new_entry, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
+	refresh_cache_entry(istate, new_entry, CE_MATCH_REFRESH);
 }
 
 void fill_stat_data(struct stat_data *sd, struct stat *st)
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 963356ba5f9..ab8607678e7 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -4,6 +4,17 @@ test_description='git mv in subdirs'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff-data.sh
 
+test_expect_success 'mv -f refreshes updated index entry' '
+	echo test >bar &&
+	git add bar &&
+	git commit -m test &&
+
+	echo foo >foo &&
+	git add foo &&
+	git mv -f foo bar &&
+	git reset --merge HEAD
+'
+
 test_expect_success 'prepare reference tree' '
 	mkdir path0 path1 &&
 	COPYING_test_data >path0/COPYING &&

base-commit: a68dfadae5e95c7f255cf38c9efdcbc2e36d1931
-- 
gitgitgadget
