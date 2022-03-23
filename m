Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B900BC433FE
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344767AbiCWUfT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344800AbiCWUe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:34:59 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9417F8EB42
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:52 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h4so3751257wrc.13
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G4Zz+2oOnC438dO9qIKPRwe1dITsnovqwRvO9m9OUyE=;
        b=AQr2RajaYD7wAV6wQSQVXgWHIhz/WEep+OF8f1y8m0KkOgQ2LvfNb6HdWU9DKu94h+
         z8xCDfu9qw/zd/SATkqPyNmxxKIgFIRGAhKPpkWoIekZlJKeBPkszHCW1ldisbU3rSQS
         Je4kcYr65OIiUzOrlDGEmtRvz3XCdsFEjjH0kvg6TXJtfzhsbksCGay/ml8E2UOMrPm9
         4+AmdxA5IVe8/98S9CiXXFYNV7vyXLVpKRkMDevlraZ4UZpsJNnogHh2bZGEGKY5PJmU
         72MdJM+Nfg63v6ljbX6a2/i3JPsBjkruphSMWa9aBBrFvHt7ji5hS2F4+PD+mpoNbtVL
         xEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G4Zz+2oOnC438dO9qIKPRwe1dITsnovqwRvO9m9OUyE=;
        b=3FoFmGK+I9e12QriUTZqZOQSa+NftVN/au2JNFUx8Q1MWJZyMcQ0HpYgoi7mxjSfNS
         qh9B6FLihl63iFQycWL6Hg1/zXRGdzvcAiViy129qa069nrftk4i0uuIb/tb6hvxiz4E
         6JBWwH9k/DW5kBe9ehWCiC+MCjJ91f0fZTQyvl/w4Nq7Ss8Oq49T6Nv+P4i1re4KKrVc
         gzycDdIbNeLqLWPOyK4WE/V4S8RFDFWc/ec/epr/gMZjaXTkFV4l8230BXuuQVduhhy2
         v2wx5lhWZoebS4x7CBM1qkjfy9wE9eY0jMI/ilvnS8bX/I76emBDsEVX+8y+Ih9owv+s
         ipqA==
X-Gm-Message-State: AOAM533k4Ug+FkPVJdm0a0ap2aoEtGBDCBaNfZqV/x21ezGgksLL11Fi
        g9L6vrPebpgTiyMXRvljYIjhHxRMjaBy4A==
X-Google-Smtp-Source: ABdhPJyX6T8K9T2bwokU1BpgBZBrXmVuDABEqq//BJpTcPS0PKpG2KEoRm3ETWWRqfxVPYRzfNr9Mg==
X-Received: by 2002:a05:6000:1846:b0:204:fb91:a603 with SMTP id c6-20020a056000184600b00204fb91a603mr1612270wri.258.1648067570710;
        Wed, 23 Mar 2022 13:32:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d6dac000000b00204119d37d0sm849843wrs.26.2022.03.23.13.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:32:50 -0700 (PDT)
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
Subject: [PATCH v2 27/27] revisions API: add a TODO for diff_free(&revs->diffopt)
Date:   Wed, 23 Mar 2022 21:32:17 +0100
Message-Id: <patch-v2-27.27-2a4d50a0ec8-20220323T203149Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1452.ga7cfc89151f
In-Reply-To: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com> <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
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
index ab570ac754c..ebcb87acaa0 100644
--- a/revision.c
+++ b/revision.c
@@ -2967,6 +2967,7 @@ void release_revisions(struct rev_info *revs)
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
2.35.1.1452.ga7cfc89151f

