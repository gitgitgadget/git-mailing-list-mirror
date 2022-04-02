Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663CFC433F5
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 10:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354724AbiDBKwz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 06:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354592AbiDBKwh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 06:52:37 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B98141D8F
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 03:50:13 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id u26so5645244eda.12
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 03:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sFIt85kmYnkDXzfebX0SbmisLvN8wznrd7mU8m0hAFw=;
        b=HadnxJMTk7xBCHpcMOgLn8+l5QpuwrVQWDpWDTChV22o3QEqAag9R0Q1E8HMuhoRik
         L8kX0x1FYej5hFRiOSuwULmWYvHGWs+IWwiwwyJ6yRyaKGO1WRMOdu2IUki/PjQ7827R
         S524fiBVKti+Bj0poLNtTo+CujN2ysSQhA6jAS+32GPcqwmEKoMeonnmR2sNoQJQcvL3
         bCd4qn1pm4vCk58VTj+Q4hG7lzkBiExQhAgJR59OMK2QAosrdd59iGiKb84Xgzmkna/e
         BmUBhMqB2Xzc0+U/rDPnXVVVfDGEgm+QPJiQHDjAm8NiB0hODbuYzukHFfY8dMz2CvyG
         20/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sFIt85kmYnkDXzfebX0SbmisLvN8wznrd7mU8m0hAFw=;
        b=PV2dpVUOTB0lvGgBvaxSgQwp6L491bkIiqbvWcI25xsONuQMZ+qA31OoAwBawISHnL
         j72P9PFRYb2KIFdX6LKJAiWXWeC4A6h1XfX+tIESPjHWf19gM52Dv91zgXwsomQjCL9G
         94du8yM2ZKW7joQBTV4YIPzq9V8fhNSleRIGkE65YbSJwrJoL3dD6RPQMbmzpLMfyJzK
         UpjrC3jBtclTDJeEeT78eA/jPL0DJFaxwVUtENXl0MRepNMUI41oKcm12CFgA9o3EAms
         HCCfoWfwuMMzFYw8KmNeTHk5baMdf0zml8f/TBZeeRUWFl5nMROoqAQyY62A1eXmNoLp
         R03Q==
X-Gm-Message-State: AOAM5306GAdDaVDgke2Zqljxf4iuOa55WVZeTS7tkr+gApJXVhlnsWrE
        0vDM5kcaGDTpDRAFSCUk3nN8pOQwMdJmZg==
X-Google-Smtp-Source: ABdhPJxOKijtIOwRF+7qp9pIp1I4+AhzlGMdWKmsIjaGSVqDjVQKGlUEUUgVOT1+aa9jEok4vQffGA==
X-Received: by 2002:a05:6402:26c8:b0:419:2e54:9262 with SMTP id x8-20020a05640226c800b004192e549262mr24532709edd.61.1648896611371;
        Sat, 02 Apr 2022 03:50:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r23-20020a056402235700b00419171bc571sm2366137eda.59.2022.04.02.03.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:50:10 -0700 (PDT)
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
Subject: [PATCH v5 27/27] revisions API: add a TODO for diff_free(&revs->diffopt)
Date:   Sat,  2 Apr 2022 12:49:41 +0200
Message-Id: <patch-v5-27.27-ec2c77ce869-20220402T102002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1584.g2aeb20a6519
In-Reply-To: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com> <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
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
index 28c3c3ff9b4..812bf709bc3 100644
--- a/revision.c
+++ b/revision.c
@@ -2958,6 +2958,7 @@ void release_revisions(struct rev_info *revs)
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
2.35.1.1585.gd85f8dcb745

