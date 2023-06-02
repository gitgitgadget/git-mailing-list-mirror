Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D908CC7EE29
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 10:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbjFBK2O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 06:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbjFBK1z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 06:27:55 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B6DE45
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 03:26:09 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f606912ebaso19139945e9.3
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 03:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685701552; x=1688293552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18RgXSbFuZYyfYUKIIuyTGEfhKGNz7QPk5fQDftbOIo=;
        b=OorkxhT6WFWXlsS9VVRchvpMA2UWFeQkYGyDcDIO2ywjPV9IGT1cJWvZYilI3af1gn
         ghK8UKLgKJlo9lNm2U96nT1xQynfKaCewIZv8VZjm32dNuCXJ/ROyuQ67GVziaNe/iUh
         a9Cm2o2BiYN0rqYzUfI+mYFSHaR77XPtfTU/edfy8vwIx6I24mfmluZC/ktSZ6iukO/k
         r44OVSrRzpeMVaHf9EqEAMqnkIeQjfLDwApU+NiB5XpFi2AuvXEVlMCX1KgaHoMauJxe
         ovH+iE+sSKHMMYN2o+TkGvLNGgtOvXsVCEXt/EmALU4g7tckYXSpoaIoig5xA1LPva9Z
         UFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685701552; x=1688293552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18RgXSbFuZYyfYUKIIuyTGEfhKGNz7QPk5fQDftbOIo=;
        b=c5e2BPskJKqPQUZPdG1npMrecwAzE7jgLAgrLV9I3o1LpNiBPlIh3vTaFWyoqUKeF+
         5mwOp6rFbwjQgdCjSuNNN4r2s8IIGDh6/sfaBtP0jUtskInUStGLKx002lRd/QOpZVZx
         7fi1ZYrRSF4Fph+p2i4RBOKeSW4/IUgb01Y1U9d7DfqV4Yg8lI+byEUUZ19T+ngBEgP3
         HpC9HBinNAGDHBZCWrKjGomqG9g1r6NylrZpRYupCvvvQpnbiNf5CwVrlVR27i+RQL+J
         fEEGa/Dm8jIItuxquMlghePYy56gaxRFw5fcw7hLlsvGD5wBSQr8MccYfO0RN30XOumr
         d+7Q==
X-Gm-Message-State: AC+VfDwa324AulomA/ByYUAw6r/RCIzw+aOtFMuRuQmJTxwiSgJX97+C
        I7I4LElWMZv0K6ZOrZnp83wXQeNf/xIwHw==
X-Google-Smtp-Source: ACHHUZ5o2ZO7cd0MjWn9sHtt/3Ifx7tn+iKMXbmgUrC/jrjvDhiNhMqAM6MYoO8mArh58c7w3H2ryQ==
X-Received: by 2002:a7b:c395:0:b0:3f1:979f:a734 with SMTP id s21-20020a7bc395000000b003f1979fa734mr1566776wmj.11.1685701551483;
        Fri, 02 Jun 2023 03:25:51 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:1169:70dc:520b:5de9:c23d:7cde])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c029200b003f601a31ca2sm1468035wmk.33.2023.06.02.03.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 03:25:51 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 01/15] t6429: remove switching aspects of fast-rebase
Date:   Fri,  2 Jun 2023 12:25:19 +0200
Message-ID: <20230602102533.876905-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.15.ga6d88fc8f0
In-Reply-To: <20230602102533.876905-1-christian.couder@gmail.com>
References: <20230509175347.1714141-1-christian.couder@gmail.com>
 <20230602102533.876905-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

At the time t6429 was written, merge-ort was still under development,
did not have quite as many tests, and certainly was not widely deployed.
Since t6429 was exercising some codepaths just a little differently, we
thought having them also test the "merge_switch_to_result()" bits of
merge-ort was useful even though they weren't intrinsic to the real
point of these tests.

However, the value provided by doing extra testing of the
"merge_switch_to_result()" bits has decreased a bit over time, and it's
actively making it harder to refactor `test-tool fast-rebase` into `git
replay`, which we are going to do in following commits.  Dispense with
these bits.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/helper/test-fast-rebase.c              | 9 +--------
 t/t6429-merge-sequence-rename-caching.sh | 9 +++++++--
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/t/helper/test-fast-rebase.c b/t/helper/test-fast-rebase.c
index d1d63feaa9..403bdf8e75 100644
--- a/t/helper/test-fast-rebase.c
+++ b/t/helper/test-fast-rebase.c
@@ -193,7 +193,7 @@ int cmd__fast_rebase(int argc, const char **argv)
 		last_commit = create_commit(result.tree, commit, last_commit);
 	}
 
-	merge_switch_to_result(&merge_opt, head_tree, &result, 1, !result.clean);
+	merge_finalize(&merge_opt, &result);
 
 	if (result.clean < 0)
 		exit(128);
@@ -212,9 +212,6 @@ int cmd__fast_rebase(int argc, const char **argv)
 		}
 		if (create_symref("HEAD", branch_name.buf, reflog_msg.buf) < 0)
 			die(_("unable to update HEAD"));
-
-		prime_cache_tree(the_repository, the_repository->index,
-				 result.tree);
 	} else {
 		fprintf(stderr, "\nAborting: Hit a conflict.\n");
 		strbuf_addf(&reflog_msg, "rebase progress up to %s",
@@ -227,10 +224,6 @@ int cmd__fast_rebase(int argc, const char **argv)
 			die("Failed to update %s", argv[4]);
 		}
 	}
-	if (write_locked_index(&the_index, &lock,
-			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
-		die(_("unable to write %s"), get_index_file());
-
 	ret = (result.clean == 0);
 cleanup:
 	strbuf_release(&reflog_msg);
diff --git a/t/t6429-merge-sequence-rename-caching.sh b/t/t6429-merge-sequence-rename-caching.sh
index d02fa16614..75d3fd2dba 100755
--- a/t/t6429-merge-sequence-rename-caching.sh
+++ b/t/t6429-merge-sequence-rename-caching.sh
@@ -72,6 +72,7 @@ test_expect_success 'caching renames does not preclude finding new ones' '
 		git switch upstream &&
 
 		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		git reset --hard topic &&
 		#git cherry-pick upstream~1..topic
 
 		git ls-files >tracked-files &&
@@ -200,6 +201,7 @@ test_expect_success 'rename same file identically, then reintroduce it' '
 		export GIT_TRACE2_PERF &&
 
 		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		git reset --hard topic &&
 		#git cherry-pick upstream~1..topic &&
 
 		git ls-files >tracked &&
@@ -277,6 +279,7 @@ test_expect_success 'rename same file identically, then add file to old dir' '
 		export GIT_TRACE2_PERF &&
 
 		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		git reset --hard topic &&
 		#git cherry-pick upstream~1..topic &&
 
 		git ls-files >tracked &&
@@ -356,8 +359,6 @@ test_expect_success 'cached dir rename does not prevent noticing later conflict'
 		test_must_fail test-tool fast-rebase --onto HEAD upstream~1 topic >output &&
 		#git cherry-pick upstream..topic &&
 
-		grep CONFLICT..rename/rename output &&
-
 		grep region_enter.*diffcore_rename trace.output >calls &&
 		test_line_count = 2 calls
 	)
@@ -456,6 +457,7 @@ test_expect_success 'dir rename unneeded, then add new file to old dir' '
 		export GIT_TRACE2_PERF &&
 
 		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		git reset --hard topic &&
 		#git cherry-pick upstream..topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
@@ -522,6 +524,7 @@ test_expect_success 'dir rename unneeded, then rename existing file into old dir
 		export GIT_TRACE2_PERF &&
 
 		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		git reset --hard topic &&
 		#git cherry-pick upstream..topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
@@ -624,6 +627,7 @@ test_expect_success 'caching renames only on upstream side, part 1' '
 		export GIT_TRACE2_PERF &&
 
 		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		git reset --hard topic &&
 		#git cherry-pick upstream..topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
@@ -682,6 +686,7 @@ test_expect_success 'caching renames only on upstream side, part 2' '
 		export GIT_TRACE2_PERF &&
 
 		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		git reset --hard topic &&
 		#git cherry-pick upstream..topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
-- 
2.41.0.15.ga6d88fc8f0

