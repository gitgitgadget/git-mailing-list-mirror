Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221F5C433FE
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 01:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350857AbiCaBOz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352308AbiCaBOW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 21:14:22 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856BB66F94
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:30 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u3so31592311wrg.3
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CXd/umGDj59fvN24zAsxlfmyIW6P6RPMcMiWiaBRwNA=;
        b=UT7ZP3gPlU5pxEVOdJMxMJbhMznxeG04Qet9zYcA9RJEu3LLxnrelr6B5fu+v6yg1Z
         HRMSd4ouBI1t8pliLAiG1h+2OvV0zQ2OxtPkmO6m/RFZN0H/qIRtcz7okHAsxTCDgMXz
         PulLnkiZb8NSNA52qU9PW3hRpoiBQKp9u3eFQt1CbOr1j6HW8llie1VFZsnBY43oSbd8
         U/S/yo9hvSXQXsNU3DUXiiPVYxQ2WI1d/rjD9gU0lRBJrWFvHWDMu71iEg7YQ+4KUg/K
         4dzgQnj9ly3Sp+7KNUbNihw5T9zsVWFmcV1EQV7yHQTTe1VRBjhfUDY+vv4FjlwF0Rc9
         UYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CXd/umGDj59fvN24zAsxlfmyIW6P6RPMcMiWiaBRwNA=;
        b=AK/CNeaLC4ObZmfb40AFT9ic30apbGjC3UD96TjnBOA5wadqoJjQJkXY3OodY5Yd6w
         NppDAJ1563zPwtUgXYJsX4UBd699HZjvpKRk44+AAxnxdXIMtsqYmi64C1MEytc/Ktx2
         TdS++bygPNARCCJVPc9O+cbPVb/oUUOiDy2gKNYGov8G+ejgg00Cul6E21iJqSb7mrvG
         ipymKmjZNWHCx6+T2fZbm2yaJ/5Lsh9N6er9CpXsd5kU/2k6whqYEaQGCWc1HYyqHR0Q
         GP0FkazhV0gzZZLgSMpy+imrihrK1HTrDc3bnp6VFOUqycc0+JEzCkrytMCLCUTWxq9C
         wPNQ==
X-Gm-Message-State: AOAM531cGJkYKMAa5bmewOhTRZ/ENbf/mDLW2HotwEbk4nHqM6YAX+T2
        cDkWuDfptH/dakEY3aIr1rp8C3DvAaABBQ==
X-Google-Smtp-Source: ABdhPJzTlSTggADkW07hx1+lHPKQWs+J9KlS9ssjn9xBKlcCkBb1Uv2GgaAHSHasykLrlmC+SJmYoQ==
X-Received: by 2002:adf:f089:0:b0:203:f2e2:1980 with SMTP id n9-20020adff089000000b00203f2e21980mr2002453wro.167.1648689148766;
        Wed, 30 Mar 2022 18:12:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c26cb00b0037ff53511f2sm5789218wmv.31.2022.03.30.18.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 18:12:28 -0700 (PDT)
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
Subject: [PATCH v4 27/27] revisions API: add a TODO for diff_free(&revs->diffopt)
Date:   Thu, 31 Mar 2022 03:11:32 +0200
Message-Id: <patch-v4-27.27-b02cb8fcded-20220331T005325Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1557.g4e3e9cdb5e0
In-Reply-To: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com> <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
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
index 33a458d7c0c..6235946a34e 100644
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
2.35.1.1557.g4e3e9cdb5e0

