Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F84C761A6
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 15:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjCaPn4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 11:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbjCaPnz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 11:43:55 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD88B775
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 08:43:54 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so25808678pjp.1
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 08:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680277434; x=1682869434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iy7rFsyFGSuV21M2ANIDCBJ2HInd04X0eIKBpCpmouQ=;
        b=kJ+LK9esbx2L3Vtfc958517Bzewyfw2G+gsZD02rEqjIWq5vHNHCMJb2B1cwoWrYKg
         JBoVud3Tw6q4GasgBZWRq3nNVYoqDeMLufYmZGkk24xTXB8CNR/FBXmp8kioKkdcL5dx
         5u0n6xkN7BDT/10QfKUIR0Seim6c8IziixcSC4BNr03/2RScj5YODoBwdTSAgOt636PH
         Gp8lNcyDmPhM/3exAfhPHTNLgRDelY5tCpEk7H/FWTh8t4O39IGRe/w0yhLJTZJyIx9B
         Z1bH4p9GTHixGFKWnqR3f3Ga+KbnEzWePZCZsG7KKWuSeR+W8SU9fS3vV5Q/kbAYeHUg
         gp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680277434; x=1682869434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iy7rFsyFGSuV21M2ANIDCBJ2HInd04X0eIKBpCpmouQ=;
        b=s+RCIOFJCLZ/2TW8EpkSITCdGW9tFtMjheZYSLcvvuTYtrOa+iSfTTlVoVQxO3mH7u
         eGCx4p9kL87aD+rEEAdc57PCm8FEqirk0ZOKuX63oBXHiP/WVrGa8UVOysNDj/scgLam
         gwwfRzoqX5e7lKufVlh0LmlvGk6ErH05FDb++0PbMh5RysRlR3cEFyjQWYnNhT3JJ3m9
         RgQcEeesvqR3bQFwzLYs6+8975ZoxT+5R2HsxzPZFcG4Srl79f/D40cytLgofP2QeJRn
         d6BCRQt47aU2LbbOC8KrGbidWaHJMQIOReTZeeKsdBwzRwyuDKpk6inbRm0VI9bi+jDP
         9kzg==
X-Gm-Message-State: AAQBX9eK7ge0fpklM6N22eJZha3M3NuDWHXrHpqfJJxVG7SQQXfu2RbG
        0Ie3AKnxZ3zchY3RzMVzQl0=
X-Google-Smtp-Source: AKy350YQQpvklOFqic2RKeD9Hxu2NoBj1y/zZo61LtGKEv6X5g1+g6NMB70khwzzgmpjNDY7Ot91BQ==
X-Received: by 2002:a17:902:7c0d:b0:1a0:7663:731b with SMTP id x13-20020a1709027c0d00b001a07663731bmr23937481pll.5.1680277433607;
        Fri, 31 Mar 2023 08:43:53 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:e020:20ea:fb6f:c0b4:a709:2d74])
        by smtp.gmail.com with ESMTPSA id k11-20020a170902694b00b001a076568da9sm1709077plt.216.2023.03.31.08.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 08:43:53 -0700 (PDT)
From:   Raghul Nanth A <nanth.raghul@gmail.com>
To:     vdye@github.com
Cc:     derrickstolee@github.com, git@vger.kernel.org,
        nanth.raghul@gmail.com
Subject: [GSOC][PATCH] describe: enable sparse index for describe
Date:   Fri, 31 Mar 2023 21:13:29 +0530
Message-Id: <20230331154329.121958-1-nanth.raghul@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <4f2fda36-111d-5bac-2322-1ebb3e508e4d@github.com>
References: <4f2fda36-111d-5bac-2322-1ebb3e508e4d@github.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add usage and performance tests for describe

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
 builtin/describe.c                       |  2 ++
 t/perf/p2000-sparse-operations.sh        |  3 +++
 t/t1092-sparse-checkout-compatibility.sh | 30 ++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

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
index 801919009e..2b46fb2a48 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1514,6 +1514,36 @@ test_expect_success 'sparse-index is not expanded: stash' '
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
+	echo "v1.0-dirty" >actual &&
+
+	# Check describe on dirty work tree
+
+	test_cmp sparse-index-out actual &&
+	ensure_not_expanded describe
+'
+
 test_expect_success 'sparse index is not expanded: diff' '
 	init_repos &&
 
-- 
2.40.0

As for the previous questions, yes I am intereseted in GSOC. I had
missed the part regarding the micro projects when I was going through
the requirements. Sorry about that. Would I be required to make one now?
