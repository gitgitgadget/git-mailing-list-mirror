Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE1FC1F428
	for <e@80x24.org>; Wed,  3 Jan 2018 03:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751614AbeACDFm (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 22:05:42 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34526 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbeACDFk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 22:05:40 -0500
Received: by mail-pf0-f194.google.com with SMTP id a90so224191pfk.1
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 19:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=JYaqmPMtAvvrbbfdWqHVLBy6UI8+jSEeDUhox9Qn7G8=;
        b=VCmf+ENflZShsHyJfn01eLZPgW/qNNbHVi+1GUYpyNWDw2gyuBTiX+KuBM3xi17QFj
         zVTJaL5Aij8sL3uztNIFhfzN89hH+JQe+De2m8H5WyAJjomESjn/4LeajHcOF+BoEV82
         rR11YhLGhft7ciB5+smSeUShWOBLN02gIs3uY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=JYaqmPMtAvvrbbfdWqHVLBy6UI8+jSEeDUhox9Qn7G8=;
        b=q+ymPzXfDmlL5Jnh3XfMSR5MDp7xv38SiQ+VZmjTV04I5M7eJaXjvX+pL4AaUJ+UCv
         iWmJhippG7Vf3yc/ht5WeLASRKsa4AMBrz4HuwhhQSpZsW4ZJqkx+nDMoQqgKRGXl8GO
         OWxf3dRUTIenyflp9rSuQlPKFKI4GhMdIAb60GpNgft2eDacGydeyQr0AsOOtqmMs30k
         /Aq0O0qx0Or9ng5ioZhR+oMfdlyxRWUZAEyVgl+P8b5yoXEn0ItmjOs3s8DwBH6HDxEH
         lqJ60MrMp7woHjdpD6L50GpdBXOTZlqaCveUQebasmzEmI8WZjBJmtChZR+OZjqk+Rav
         n1kQ==
X-Gm-Message-State: AKGB3mJknl63VfoJem/xcLxJ4ocE+fYQA27rV0RA4qDd+VLjfBBEWEVs
        mlWbM7h8TciKdmEk+fGuqcAYMC//52U=
X-Google-Smtp-Source: ACJfBotammTR+9G1ddDi7K2MUShu8CZJcTYLveqD5teaC8Yy8vHfLMyePubk4W0QoSIwLZb2HVaPrw==
X-Received: by 10.99.108.4 with SMTP id h4mr92446pgc.113.1514948739156;
        Tue, 02 Jan 2018 19:05:39 -0800 (PST)
Received: from alexmv-linux.corp.dropbox.com (V160-vrrp.corp.dropbox.com. [205.189.0.161])
        by smtp.gmail.com with ESMTPSA id 82sm107742pfm.136.2018.01.02.19.05.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 19:05:38 -0800 (PST)
From:   Alex Vandiver <alexmv@dropbox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: [PATCH 6/6] fsmonitor: Use fsmonitor data in `git diff`
Date:   Tue,  2 Jan 2018 19:04:56 -0800
Message-Id: <121828fc14bc6f3096d16005feffb58bf68f070a.1514948078.git.alexmv@dropbox.com>
X-Mailer: git-send-email 2.15.1.31.gddce0adfe
In-Reply-To: <20180103030456.8181-1-alexmv@dropbox.com>
References: <20180103030456.8181-1-alexmv@dropbox.com>
In-Reply-To: <023b0090bc7dc0ff9c3bee1efce8c85fdba27de3.1514948078.git.alexmv@dropbox.com>
References: <023b0090bc7dc0ff9c3bee1efce8c85fdba27de3.1514948078.git.alexmv@dropbox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes use of the fsmonitor extension to skip lstat() calls on
files that fsmonitor judged as unmodified.  We skip use of the
fsmonitor extension when called by "add" because the format_callback
in such cases expects to be called even when the file is believed to
be "up to date" with the index.

Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
---
 builtin/add.c | 2 +-
 diff-lib.c    | 6 ++++++
 diff.h        | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index bf01d89e2..bba20b46e 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -119,7 +119,7 @@ int add_files_to_cache(const char *prefix,
 	rev.diffopt.format_callback_data = &data;
 	rev.diffopt.flags.override_submodule_config = 1;
 	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
-	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
+	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED | DIFF_SKIP_FSMONITOR);
 	clear_pathspec(&rev.prune_data);
 	return !!data.add_errors;
 }
diff --git a/diff-lib.c b/diff-lib.c
index 8104603a3..13ff00d81 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -95,6 +95,9 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 
 	diff_set_mnemonic_prefix(&revs->diffopt, "i/", "w/");
 
+	if (!(option & DIFF_SKIP_FSMONITOR))
+		refresh_fsmonitor(&the_index);
+
 	if (diff_unmerged_stage < 0)
 		diff_unmerged_stage = 2;
 	entries = active_nr;
@@ -197,6 +200,9 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		if (ce_uptodate(ce) || ce_skip_worktree(ce))
 			continue;
 
+		if (ce->ce_flags & CE_FSMONITOR_VALID && !(option & DIFF_SKIP_FSMONITOR))
+			continue;
+
 		/* If CE_VALID is set, don't look at workdir for file removal */
 		if (ce->ce_flags & CE_VALID) {
 			changed = 0;
diff --git a/diff.h b/diff.h
index 7cf276f07..5cf5866bd 100644
--- a/diff.h
+++ b/diff.h
@@ -392,6 +392,8 @@ extern const char *diff_aligned_abbrev(const struct object_id *sha1, int);
 #define DIFF_SILENT_ON_REMOVED 01
 /* report racily-clean paths as modified */
 #define DIFF_RACY_IS_MODIFIED 02
+/* skip loading the fsmonitor data */
+#define DIFF_SKIP_FSMONITOR 04
 extern int run_diff_files(struct rev_info *revs, unsigned int option);
 extern int run_diff_index(struct rev_info *revs, int cached);
 
-- 
2.15.1.31.gddce0adfe

