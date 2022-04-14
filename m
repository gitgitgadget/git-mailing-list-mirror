Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA8BC433F5
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 05:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239960AbiDNF71 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 01:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239950AbiDNF7U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 01:59:20 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04333587B
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 22:56:56 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e21so5413143wrc.8
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 22:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VERvneIpLZwhKtxge8sEohbxnj5Qod5AZULvHoUTJhA=;
        b=bChQCCTjCt32vi5UK2TAM/0cQJafYfPTPV6O0ZocJ4fDeWIPCANwPwXzU5TixVCx7Y
         qHKPtGqVwHE78A5fsb0dZX6FD7lTOLqoKZVwbxzV9teiy0SHIVu83vYi//DwXBBfTXeD
         z/KY9/0D0CTMTmA/6D97by6AQhqM4ugqDACmYyF3evfHbcJGimediBPdZZnzT63HnXkX
         BZuFUSEAgaznrIZ7f2BLdqOhpeT2EkuHb1wfjmzXtizkVaFfpm8SHrh2mOKe+16pXGqq
         nPekSnOAps9aUnYoL0ixEaNDTql5agqtjMqQOzWQsK0tfd8FM1ZNu5jcevEX5yiwxobL
         cdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VERvneIpLZwhKtxge8sEohbxnj5Qod5AZULvHoUTJhA=;
        b=6q6VRe9S6Ewt8w0f2wuzmDn3JUeYTEtvfnZFZASf257f3Q6Q6Ysam6aaqFHVEpnZUK
         DZyWT1VvR1ZKQMSuwqUEvjEb3xDhVs5nHrpBNiMH30h1sZlUJoBN1uRKB1ZoN+uex7dC
         d3rTdsjzaE2guAZO5nSRBD6K0RHE5wnQBMBPieli7HNdjiRAMr34IlvRnN2/V66TzUb3
         qggsSHBmm3WxHrEvA630PEBD6dbHNlvRgidrzCPerrJh+eSj50GYtGWZ71PndVxtRfn6
         3sQM0rYXIe+fGHG4f5FrZLPjC5od9r0ggjPl1bCblTTvVmkUOnWBJycggJmP/sPN0+T7
         XsIg==
X-Gm-Message-State: AOAM533ad/i8iILntGlDO0i/KtHAo+VcIX9bNdmyQJg2xB2DS86OCxFo
        zv3R/bhY77naj1hbmCdGOnA1WbtI7PJnkQ==
X-Google-Smtp-Source: ABdhPJyYKj27dPVx1kuXk3VZfoB40DWzaM91Q+RSvRUQDLwq5BLDVa65KYpi5cII+eYf5czwJH0tTw==
X-Received: by 2002:a5d:658f:0:b0:207:9c0e:1364 with SMTP id q15-20020a5d658f000000b002079c0e1364mr751470wru.632.1649915815082;
        Wed, 13 Apr 2022 22:56:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l2-20020a05600c4f0200b0038e8fb63293sm960453wmq.22.2022.04.13.22.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 22:56:54 -0700 (PDT)
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
Subject: [PATCH v6 27/27] revisions API: add a TODO for diff_free(&revs->diffopt)
Date:   Thu, 14 Apr 2022 07:56:40 +0200
Message-Id: <patch-v6-27.27-3be672a8150-20220413T195935Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
References: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com> <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a TODO comment indicating that we should release "diffopt" in
release_revisions(). In a preceding commit we started releasing the
"pruning" member of the same type, but handling "diffopt" will require
us to untangle the "no_free" conditions I added in e900d494dcf (diff:
add an API for deferred freeing, 2021-02-11).

Let's leave a TODO comment to that effect, and so that we don't forget
refactor code that was changed to use release_revisions() in earlier
commits to stop using the "diffopt" member after a call to
release_revisions(). This works currently, but would become a logic
error as soon as we started freeing "diffopt". Doing that change now
doesn't harm anything, and future-proofs us against a later change to
release_revisions().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diff-lib.c  | 4 +++-
 revision.c  | 1 +
 wt-status.c | 6 ++++--
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 298265e5b54..7eb66a417aa 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -651,6 +651,7 @@ int index_differs_from(struct repository *r,
 {
 	struct rev_info rev;
 	struct setup_revision_opt opt;
+	unsigned has_changes;
 
 	repo_init_revisions(r, &rev, NULL);
 	memset(&opt, 0, sizeof(opt));
@@ -662,8 +663,9 @@ int index_differs_from(struct repository *r,
 		diff_flags_or(&rev.diffopt.flags, flags);
 	rev.diffopt.ita_invisible_in_index = ita_invisible_in_index;
 	run_diff_index(&rev, 1);
+	has_changes = rev.diffopt.flags.has_changes;
 	release_revisions(&rev);
-	return (rev.diffopt.flags.has_changes != 0);
+	return (has_changes != 0);
 }
 
 static struct strbuf *idiff_prefix_cb(struct diff_options *opt, void *data)
diff --git a/revision.c b/revision.c
index 0107ac1077a..58d6212221b 100644
--- a/revision.c
+++ b/revision.c
@@ -2956,6 +2956,7 @@ void release_revisions(struct rev_info *revs)
 	date_mode_release(&revs->date_mode);
 	release_revisions_mailmap(revs->mailmap);
 	free_grep_patterns(&revs->grep_filter);
+	/* TODO (need to handle "no_free"): diff_free(&revs->diffopt) */
 	diff_free(&revs->pruning);
 	reflog_walk_info_release(revs->reflog_info);
 	release_revisions_topo_walk_info(revs->topo_walk_info);
diff --git a/wt-status.c b/wt-status.c
index 61e0c1022f5..102d904adcb 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2545,8 +2545,9 @@ int has_unstaged_changes(struct repository *r, int ignore_submodules)
 	rev_info.diffopt.flags.quick = 1;
 	diff_setup_done(&rev_info.diffopt);
 	result = run_diff_files(&rev_info, 0);
+	result = diff_result_code(&rev_info.diffopt, result);
 	release_revisions(&rev_info);
-	return diff_result_code(&rev_info.diffopt, result);
+	return result;
 }
 
 /**
@@ -2578,8 +2579,9 @@ int has_uncommitted_changes(struct repository *r,
 
 	diff_setup_done(&rev_info.diffopt);
 	result = run_diff_index(&rev_info, 1);
+	result = diff_result_code(&rev_info.diffopt, result);
 	release_revisions(&rev_info);
-	return diff_result_code(&rev_info.diffopt, result);
+	return result;
 }
 
 /**
-- 
2.36.0.rc2.843.g193535c2aa7

