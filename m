Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613B9EC873E
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 16:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243319AbjIGQth (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 12:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243361AbjIGQtf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 12:49:35 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3753B1BC9
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 09:49:11 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bd0a5a5abbso20759671fa.0
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 09:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694105285; x=1694710085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLXvhxvAcTubTLZoUT0um1y8VxTvyJPDq+F3ZZGAb2A=;
        b=GOHv/HMu7z3/tCBb5JYMYTMllllzW5TMDQpZfr2i9iHE14+EqrO6fIWZZhA911I4qi
         AxLgc6UOHqXGIjZKpyagYOp+17Y+K61/aMajoRSc+Jh01XbiuM6wp6ld4voQf9Sp4Fh4
         lJPD07FJRzPtJSusLdYnucxc6bVhXvlr8B0on/PrZH0lmoa78PCAOzKX/Wu9h31+XRUv
         K9Ce0FKp1YgrXaETezaBDHR5EVH3kUoHYrrrTRzqlixAGAY87DTkAtsAQBhGxCFpLoge
         njkHP/8f8BIArS9bOGNLhOZmyRr7PXyi5p7q6H7EaTvxVWwVjVh9zYu8k6KqG7raMZcH
         BJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694105285; x=1694710085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLXvhxvAcTubTLZoUT0um1y8VxTvyJPDq+F3ZZGAb2A=;
        b=Pw5fQThuxMuh2fNs97VXscqpTq0IfEz/sFV8sOAD+fzivosnyA6xt1SRLFyv8cz5p8
         /lA5ldhuGMSGs7R2/DjmBGjQZyoLjjHnNZGmzXOQmoGeHISGFaWbYtEnp3SEkHafP1tO
         bjSDLuUNO8USZPQHKkKgxXNSMR3PtMP2sZHpuWmHWiFQclP6+CiEJ1pq39witLtPLPv7
         UrstvuGDYLcmV4+4lZSBquEtiCdsm73B6cE5UYydbRsp+0g+mvszbd5ErmoNsX7UBNbo
         mbZQ/BsA1CaTM6vU8ygwuukALOZje+xCGfM0W+4BzKnfUX05JB20D5aBOpLfUwnACNlt
         fS1Q==
X-Gm-Message-State: AOJu0YzxAbgJvn2WEYRmjxW4e8KF1SVR/YrskURJoTlheQ1/yJx6tcQg
        I3tH++qNWq2+rKHJ0yyCZQFxAYNrKYA=
X-Google-Smtp-Source: AGHT+IGAZOilvgLi/Z/EGWtqKTBeWm5+oI8p6m/oHdBIJfZR1QLljx/EmyF2eSmGIDRW4Onab9/rLw==
X-Received: by 2002:a5d:4a4a:0:b0:31a:d2f9:7372 with SMTP id v10-20020a5d4a4a000000b0031ad2f97372mr4272313wrs.29.1694078771131;
        Thu, 07 Sep 2023 02:26:11 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:3385:ce2d:69dd:303e])
        by smtp.gmail.com with ESMTPSA id y8-20020adff148000000b00317c742ca9asm22491522wro.43.2023.09.07.02.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 02:26:10 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 01/15] t6429: remove switching aspects of fast-rebase
Date:   Thu,  7 Sep 2023 11:25:07 +0200
Message-ID: <20230907092521.733746-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.126.gcf8c984877
In-Reply-To: <20230907092521.733746-1-christian.couder@gmail.com>
References: <20230602102533.876905-1-christian.couder@gmail.com>
 <20230907092521.733746-1-christian.couder@gmail.com>
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
index cac20a72b3..2bfab66b1b 100644
--- a/t/helper/test-fast-rebase.c
+++ b/t/helper/test-fast-rebase.c
@@ -194,7 +194,7 @@ int cmd__fast_rebase(int argc, const char **argv)
 		last_commit = create_commit(result.tree, commit, last_commit);
 	}
 
-	merge_switch_to_result(&merge_opt, head_tree, &result, 1, !result.clean);
+	merge_finalize(&merge_opt, &result);
 
 	if (result.clean < 0)
 		exit(128);
@@ -213,9 +213,6 @@ int cmd__fast_rebase(int argc, const char **argv)
 		}
 		if (create_symref("HEAD", branch_name.buf, reflog_msg.buf) < 0)
 			die(_("unable to update HEAD"));
-
-		prime_cache_tree(the_repository, the_repository->index,
-				 result.tree);
 	} else {
 		fprintf(stderr, "\nAborting: Hit a conflict.\n");
 		strbuf_addf(&reflog_msg, "rebase progress up to %s",
@@ -228,10 +225,6 @@ int cmd__fast_rebase(int argc, const char **argv)
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
2.42.0.126.gcf8c984877

