Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4CEC433ED
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 14:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80B806128B
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 14:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhDYORF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 10:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbhDYORE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Apr 2021 10:17:04 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B4BC06175F
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 07:16:24 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id y204so27142265wmg.2
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 07:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1WXyZDq5u1ON4ki7kVTGWTuwGUZchGrEtVmXJ+CkXXc=;
        b=Cckts4uSlu2ygt8CvJc+hHkGTHNg33ePYT7S1bXOc6wuUWkoIJEiuVynbLBZYFSErR
         5nQmOJDc54Fcb3Y9ygqB5d3fYSR9/OvhG4UAH2E8mV7pCBVJNfRt0Ae9Hrk4oJwf7WJV
         w4dLudWIHx07MXVkhNVBXlWrA9H6avHJ9b9ja5hzGZ1VqA7VXIe9RkMyfScfQgZup89d
         Jyt90L4JnvxqrRUCfB/H38TnjF2EpETompm2E39CTRQMQAotvW5YhFW3b26p2K7ZYUrg
         2sTVGLl4QHcxDBUlcf/fS9gS4IdZmHIGe3tgeI+eqn4WNFIHoaNdplwBkNig55lvtvZH
         qjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1WXyZDq5u1ON4ki7kVTGWTuwGUZchGrEtVmXJ+CkXXc=;
        b=VKrXsXS6Fi8vTYfJ6phRqt0RrT9lL6A5Zo/WlOYyitq3gM+HXKT8nYpjDUcjNgZiZE
         0BZTOgqkxlCSoOg4JJ2OSVUWTljfRraDWWkeEgTmNSYW3lPtKX20x5xYEIshkoMPB8VQ
         F705UeL+7uKxVFrRZMK8oavM8XoH6xwyG1VBhGcGD8OG7ooLVAr52JLr4bF//NoVPDhL
         wVdrX+OVxd5I0cY88UHgAjFFYg4vNhFtuqJvMqCB2/DloHhlkHrzEmgX+7DHLxEITSRW
         IojTveiROhkrA3Mmia/+AeIUKas7+ZxiY3Qx+2oZ7rT3dKd+tYyF0GQX6Jx81c2ZIphm
         Xjzw==
X-Gm-Message-State: AOAM530r6Z/YKLdvchbkFPQiNxpLneeGNhwNYXjXrXLqLFsfYTrIuApn
        Uo0uVZMBCWSH8usO7bC/993+v+6WdRY=
X-Google-Smtp-Source: ABdhPJy9RiDwrsB9ZCtOts6g+HNXYLAMd8GoN65gMQWX/XFDJx+MsZPR27hH0B0lE4asdka0LSQh/Q==
X-Received: by 2002:a1c:c3d4:: with SMTP id t203mr14696526wmf.32.1619360182987;
        Sun, 25 Apr 2021 07:16:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f6sm15399523wrt.19.2021.04.25.07.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 07:16:22 -0700 (PDT)
Message-Id: <9ad3d8e3fbf4ebb0622f3b68b13ae34908ac5b87.1619360180.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.v2.git.1619360180.gitgitgadget@gmail.com>
References: <pull.929.git.1617994052.gitgitgadget@gmail.com>
        <pull.929.v2.git.1619360180.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 25 Apr 2021 14:16:09 +0000
Subject: [PATCH v2 02/12] wt-status: fix multiple small leaks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

rev.prune_data is populated (in multiple functions) via copy_pathspec,
and therefore needs to be cleared after running the diff in those
functions.

rev(_info).pending is populated indirectly via setup_revisions, and also
needs to be cleared once diffing is done.

These leaks were found while running t0008 or t0021. The rev.prune_data
leaks are small (80B) but noisy, hence I won't bother including their
logs - the rev.pending leaks are bigger, and can happen early in the
course of other commands, and therefore possibly more valuable to fix -
see example log from a rebase below:

Direct leak of 2048 byte(s) in 1 object(s) allocated from:
    #0 0x49ab79 in realloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
    #1 0x9ac2a6 in xrealloc wrapper.c:126:8
    #2 0x83da03 in add_object_array_with_path object.c:337:3
    #3 0x8f5d8a in add_pending_object_with_path revision.c:329:2
    #4 0x8ea50b in add_pending_object_with_mode revision.c:336:2
    #5 0x8ea4fd in add_pending_object revision.c:342:2
    #6 0x8ea610 in add_head_to_pending revision.c:354:2
    #7 0x9b55f5 in has_uncommitted_changes wt-status.c:2474:2
    #8 0x9b58c4 in require_clean_work_tree wt-status.c:2553:6
    #9 0x606bcc in cmd_rebase builtin/rebase.c:1970:6
    #10 0x4cd91d in run_builtin git.c:467:11
    #11 0x4cb5f3 in handle_builtin git.c:719:3
    #12 0x4ccf47 in run_argv git.c:808:4
    #13 0x4caf49 in cmd_main git.c:939:19
    #14 0x69dc0e in main common-main.c:52:11
    #15 0x7f2d18909349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Indirect leak of 5 byte(s) in 1 object(s) allocated from:
    #0 0x486834 in strdup ../projects/compiler-rt/lib/asan/asan_interceptors.cpp:452:3
    #1 0x9ac048 in xstrdup wrapper.c:29:14
    #2 0x83da8d in add_object_array_with_path object.c:349:17
    #3 0x8f5d8a in add_pending_object_with_path revision.c:329:2
    #4 0x8ea50b in add_pending_object_with_mode revision.c:336:2
    #5 0x8ea4fd in add_pending_object revision.c:342:2
    #6 0x8ea610 in add_head_to_pending revision.c:354:2
    #7 0x9b55f5 in has_uncommitted_changes wt-status.c:2474:2
    #8 0x9b58c4 in require_clean_work_tree wt-status.c:2553:6
    #9 0x606bcc in cmd_rebase builtin/rebase.c:1970:6
    #10 0x4cd91d in run_builtin git.c:467:11
    #11 0x4cb5f3 in handle_builtin git.c:719:3
    #12 0x4ccf47 in run_argv git.c:808:4
    #13 0x4caf49 in cmd_main git.c:939:19
    #14 0x69dc0e in main common-main.c:52:11
    #15 0x7f2d18909349 in __libc_start_main (/lib64/libc.so.6+0x24349)

SUMMARY: AddressSanitizer: 2053 byte(s) leaked in 2 allocation(s).

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
 wt-status.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/wt-status.c b/wt-status.c
index 1aed68c43c26..34886655dbcc 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -616,6 +616,7 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
 	rev.diffopt.rename_score = s->rename_score >= 0 ? s->rename_score : rev.diffopt.rename_score;
 	copy_pathspec(&rev.prune_data, &s->pathspec);
 	run_diff_files(&rev, 0);
+	clear_pathspec(&rev.prune_data);
 }
 
 static void wt_status_collect_changes_index(struct wt_status *s)
@@ -652,6 +653,8 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	rev.diffopt.rename_score = s->rename_score >= 0 ? s->rename_score : rev.diffopt.rename_score;
 	copy_pathspec(&rev.prune_data, &s->pathspec);
 	run_diff_index(&rev, 1);
+	object_array_clear(&rev.pending);
+	clear_pathspec(&rev.prune_data);
 }
 
 static void wt_status_collect_changes_initial(struct wt_status *s)
@@ -2480,6 +2483,7 @@ int has_uncommitted_changes(struct repository *r,
 
 	diff_setup_done(&rev_info.diffopt);
 	result = run_diff_index(&rev_info, 1);
+	object_array_clear(&rev_info.pending);
 	return diff_result_code(&rev_info.diffopt, result);
 }
 
-- 
gitgitgadget

