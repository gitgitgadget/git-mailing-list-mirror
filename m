Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0B8C76196
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 16:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjDCQsN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 12:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbjDCQsL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 12:48:11 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9985019B7
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 09:48:10 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id o11so28660373ple.1
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 09:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680540490; x=1683132490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnHZeWkqbetH6gsplr89ZqzyyP+CjAoR903/ixwrhsM=;
        b=AQQziFMWPdADBnG6xReUdLe+WgnHzfyi1/0amko0opq+nnJ3zLY8rdM2uUARUrQK/4
         bHM6953V69UbbG0enDbKaWYyMLOzFg4rJ/WUD6+1mJReRPRY/0RICuIs0XCsJChaNcxq
         Tc3fzCk+0n5rEUHRPLI1VoNbY42cPsaa0ytOAHAoQ6qJLjwb1PYvP5MpNXg7xT6SOGOB
         TFMM3xH/XG3a4OLxrQzSExocRYhfNvXk3wQX8h4ZC++TuaBSMUgr42IDsc1ZTjwmNscO
         VHMWVWlxLaAKmXzMQIMJuQb9R9ckCSk3p84gr621e1EImBLCF0T36FRAr8A2HBuNKtQ/
         kJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680540490; x=1683132490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnHZeWkqbetH6gsplr89ZqzyyP+CjAoR903/ixwrhsM=;
        b=27xvamq+kFJEKi1rfMduh21LKM3IHUWiqBcSW/OrFs9ABaYgwtevhpAfhSt8LqLI/3
         52FCBWrB4z0xGIm3nbD1unHC+K15nt+2RIuZog8sofYWtOtoNIL81m7/9vpCPq9f6zyg
         F2jqLLHTG5P5dfQm72Z4zFTwhzNI9FxwhLr1QzwAPgbvLhf6dmFc7dpBnNABh/qW8VPV
         jzygtJ8HlM+LVrCtcGXsLh3YreIzen+PwSQUOfSjgwt+/pCt8NtO+AbvNurEAW6A9BOy
         Z0CnZOIaCTOpxhpC/ZMCII5Oc9tW1xcvBVcoWTVh8Xiyh/Ls++Zljm98qCd1BOe1FjJH
         H8Tw==
X-Gm-Message-State: AAQBX9flqntvXIwc60ewYCdN/1pmEOxIzAj06601VIa2dCOzjR230z97
        U/zSfiKaBs3fotN9NCTDUPt7/DVWgRnLvlFgv2I=
X-Google-Smtp-Source: AKy350Y+/+uMixXhowiRli2ZAFrNM/E7mJkdI8wiLuZjpGszKa0SDkLcv92O/4hizj+EMUTc8dh8bA==
X-Received: by 2002:a17:902:c94c:b0:1a2:6092:2193 with SMTP id i12-20020a170902c94c00b001a260922193mr16270110pla.4.1680540489498;
        Mon, 03 Apr 2023 09:48:09 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:e020:20ea:fb6f:c0b4:a709:2d74])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902934500b001994fc55998sm6816236plp.217.2023.04.03.09.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 09:48:09 -0700 (PDT)
From:   Raghul Nanth A <nanth.raghul@gmail.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, vdye@github.com, nanth.raghul@gmail.com
Subject: [GSOC][PATCH v5] describe: enable sparse index for describe
Date:   Mon,  3 Apr 2023 22:17:49 +0530
Message-Id: <20230403164749.246001-1-nanth.raghul@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230331182038.224892-1-nanth.raghul@gmail.com>
References: <20230331182038.224892-1-nanth.raghul@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git describe compares the index with the working tree when (and only
when) it is run with the "--dirty" flag. This is done by the
run_diff_index() function. The function has been made aware of the
sparse-index in the series that led to 8d2c3732 (Merge branch
'ld/sparse-diff-blame', 2021-12-21). Hence we can just set the
requires-full-index to false for "describe".

Performance metrics

  Test                                                     HEAD~1            HEAD
  -------------------------------------------------------------------------------------------------
  2000.2: git describe --dirty (full-v3)                   0.08(0.09+0.01)   0.08(0.06+0.03) +0.0%
  2000.3: git describe --dirty (full-v4)                   0.09(0.07+0.03)   0.08(0.05+0.04) -11.1%
  2000.4: git describe --dirty (sparse-v3)                 0.88(0.82+0.06)   0.02(0.01+0.05) -97.7%
  2000.5: git describe --dirty (sparse-v4)                 0.68(0.60+0.08)   0.02(0.02+0.04) -97.1%
  2000.6: echo >>new && git describe --dirty (full-v3)     0.08(0.04+0.05)   0.08(0.05+0.04) +0.0%
  2000.7: echo >>new && git describe --dirty (full-v4)     0.08(0.07+0.03)   0.08(0.05+0.04) +0.0%
  2000.8: echo >>new && git describe --dirty (sparse-v3)   0.75(0.69+0.07)   0.02(0.03+0.03) -97.3%
  2000.9: echo >>new && git describe --dirty (sparse-v4)   0.81(0.73+0.09)   0.02(0.01+0.05) -97.5%

Signed-off-by: Raghul Nanth A <nanth.raghul@gmail.com>
---

  * Removed describe tests not concerned with sparse index
  * Added performance metric to commit message
  * Moved tests to t1092.sh
  * Explained reason for changes in commit message
  * Added tests to validate behaviour in sparse and full indices

 builtin/describe.c                       |  2 ++
 t/perf/p2000-sparse-operations.sh        |  3 +++
 t/t1092-sparse-checkout-compatibility.sh | 25 ++++++++++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/builtin/describe.c b/builtin/describe.c
index 5b5930f5c8..7ff9b5e4b2 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -654,6 +654,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			int fd, result;
 
 			setup_work_tree();
+			prepare_repo_settings(the_repository);
+			the_repository->settings.command_requires_full_index = 0;
 			repo_read_index(the_repository);
 			refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED,
 				      NULL, NULL, NULL);
diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 3242cfe91a..db7887470f 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -43,6 +43,7 @@ test_expect_success 'setup repo and indexes' '
 	done &&
 
 	git sparse-checkout init --cone &&
+	git tag -a v1.0 -m "Final" &&
 	git sparse-checkout set $SPARSE_CONE &&
 	git checkout -b wide $OLD_COMMIT &&
 
@@ -125,5 +126,7 @@ test_perf_on_all git checkout-index -f --all
 test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
 test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
 test_perf_on_all git grep --cached --sparse bogus -- "f2/f1/f1/*"
+test_perf_on_all git describe --dirty
+test_perf_on_all 'echo >>new && git describe --dirty'
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 801919009e..51bebd4fa9 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1514,6 +1514,31 @@ test_expect_success 'sparse-index is not expanded: stash' '
 	ensure_not_expanded stash pop
 '
 
+test_expect_success 'describe tested on all' '
+	init_repos &&
+
+	# Add tag to be read by describe
+
+	run_on_all git tag -a v1.0 -m "Version 1" &&
+	test_all_match git describe --dirty &&
+	run_on_all rm g &&
+	test_all_match git describe --dirty
+'
+
+
+test_expect_success 'sparse-index is not expanded: describe' '
+	init_repos &&
+
+	# Add tag to be read by describe
+
+	git -C sparse-index tag -a v1.0 -m "Version 1" &&
+
+	ensure_not_expanded describe --dirty &&
+	echo "test" >>sparse-index/g &&
+	ensure_not_expanded describe --dirty &&
+	ensure_not_expanded describe
+'
+
 test_expect_success 'sparse index is not expanded: diff' '
 	init_repos &&
 
-- 
2.40.0

