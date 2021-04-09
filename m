Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F54C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8375A6115B
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbhDISry (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbhDISrv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:47:51 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B75CC061765
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:47:37 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id w4so2829543wrt.5
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1WXyZDq5u1ON4ki7kVTGWTuwGUZchGrEtVmXJ+CkXXc=;
        b=KplY/RnUIb3KeB+3OL8247GFEAAUvN0gq+AxG8vDeOVP0zh1tsmRGy8sivEw3VYA5J
         qOCXuXbYZrRqS5uYxxEih/+2jVSmkkeVyALRklMP07+pDyu03SzJLb5RRKZi+nH8Tqa3
         Z40lHKIke5ijHk1iOu1fpbUItn9tfPOJRri5q6l7+v16EzmjyiryukXYXw7kWpsQDFFw
         Xw2xUbRKmtDrn+YBuTo6d8hnfRL5tc3ufv1Kn8q3OEB5EQ2BjzMiubSbu9i5Uz34rvWD
         pxBw81bHItbm7EGUCTaJDmNtDQP/jD/dyjvad/nyYeHBY7LSKkwHHYZ9oNxTNOfTP0me
         0wVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1WXyZDq5u1ON4ki7kVTGWTuwGUZchGrEtVmXJ+CkXXc=;
        b=S60BZWVFZwnXd8iJzMUTFuAwA8klQJRHg2osO3/j5DexYURBu+uyZVvpI7J1sX4ukK
         hPbv2bMmzvS0DvHlf5Tl3CEt5pnU85tuRlpkgufCky3hOC9bHcBKTtePrEWNFFhtCO4n
         aI3vffXDKy4ZaSSuUWAd075I5mutkRojG/IFA6AZX3HDvsXblvVBG53a0TW9VNjyE9Cz
         g3W/sWkZD7M/fADjgxmYdDD4+/59l+yolxXsF12BNyBcoRMwJxZ+2+E044+YzoZUBoHi
         wDp1mj/Mn1+76Zn1TKZ3tE1fsREw0EzUh2tm3NKe6bXmcmOcaAwF0WazAdSjsv8WX35o
         MstQ==
X-Gm-Message-State: AOAM531myW2CoteFQF1mfKTrDyZpr6vpTdAbJLH+LWDm20AEM/0VrrsU
        U6fulxmiJbDJLCxrO4h4w4ly80vBN+g=
X-Google-Smtp-Source: ABdhPJwiEpjW2WM93RmUVIE6FczeqJVLs/ncml1Vtn2XLa6oD5Z0gEt3giA/G9J8mGInCw9a3Bo1MA==
X-Received: by 2002:adf:a406:: with SMTP id d6mr18898840wra.74.1617994054933;
        Fri, 09 Apr 2021 11:47:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m25sm4998386wmi.33.2021.04.09.11.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:47:34 -0700 (PDT)
Message-Id: <716a21b4ef73391cd7b242b4a63005777c13e1a7.1617994052.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.git.1617994052.gitgitgadget@gmail.com>
References: <pull.929.git.1617994052.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Apr 2021 18:47:21 +0000
Subject: [PATCH 02/12] wt-status: fix multiple small leaks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andrzej Hunt <andrzej@ahunt.org>, Andrzej Hunt <ajrhunt@google.com>
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

