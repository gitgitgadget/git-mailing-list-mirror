Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65CAC76196
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 07:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjDCHfo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 03:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjDCHfn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 03:35:43 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80913903C
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 00:35:42 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so29554400pjt.5
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 00:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680507341; x=1683099341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RZlmNH4bu7PMVJkqtlrK4KnmzVqVg/wN9d0w4N7qUs=;
        b=JaRx62l7RNW6XLmKVsa+Zh9VM/xpEWhb3GS9kortk8Xl/egkrz64fnCjImzQehjISI
         dFvpZOrF1AuNQHDVZ1R+aIg7hKYhgQmwVgkUvjs0UFggqXM+/wuEpAeoOBN0OAZ4Sk2/
         NEr3Y9iAXOgfbjTsyP85vJpnjoug1ERqqwZAghGL0t4CCegn+xSWMUkcpYuKLnq2wshJ
         2JST7J7ekUSG849X5VmdZqiznFKLRmqOWu5FHr7O39U9Ms/z4VAmbMeYhcU/DAzJwghW
         UnV1iARm4Mn2Y2YfE1YmQ7fp5Q8/UVtIPNI/LyPpgCIyCKdQPO8y9MJBYyFoxUY8l2d+
         DrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680507341; x=1683099341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RZlmNH4bu7PMVJkqtlrK4KnmzVqVg/wN9d0w4N7qUs=;
        b=wNiKcHXBMBI2oEC4I2ATMVurUcuOFYNB27dkfgL6WPNd3TJppa4Yxo29pbV80sNYFC
         MtszA8M/VBG0tvA9s/rXXzL4x2Mb4h6b4JeJBaqc9fhmme/8NRlwF7k9qKIg91qQ/Brn
         JkSx/UdFw6Ni0doFSQErsZvqoL/PJesIaI51vckfNZtneNcDrcwANF+mNFLIE2Tr9e4O
         jRMGnij8leM854l9xRBjcnFf0yrdMBldnw3j0zG0RMQYuLAhaCqCn/1l6ELsGcGMqzLj
         v4EUPQdm0hsy8k28E7bbHFUl+jet7s/4zXUrWaaQ+9pK1ezxRxpnaCGOuvX0uM346cRX
         rRSA==
X-Gm-Message-State: AAQBX9cHnHtuYtxQvlPisTU3wcd6NaIdt8TmHEQk8XMOj2tiXnno83My
        iG+L75GqkKMym5fYUKqDSbSRr4fMQa50GOfDYYA=
X-Google-Smtp-Source: AKy350Yi/JTUAGViN6turFJkF5yd9OhCAdvFX4o4p+2ooyytVHwmn/SrEmaDLyZzqBOD7ZMzqSzJyQ==
X-Received: by 2002:a17:902:da88:b0:19d:2a3:f019 with SMTP id j8-20020a170902da8800b0019d02a3f019mr14699984plx.1.1680507341385;
        Mon, 03 Apr 2023 00:35:41 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:e020:20ea:fb6f:c0b4:a709:2d74])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709027b8100b0019f3cc463absm5991124pll.0.2023.04.03.00.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 00:35:40 -0700 (PDT)
From:   Raghul Nanth A <nanth.raghul@gmail.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, nanth.raghul@gmail.com, vdye@github.com
Subject: [PATCH v4] describe: enable sparse index for describe
Date:   Mon,  3 Apr 2023 13:05:25 +0530
Message-Id: <20230403073525.227363-1-nanth.raghul@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <pull.1480.v3.git.git.1680155957146.gitgitgadget@gmail.com>
References: <pull.1480.v3.git.git.1680155957146.gitgitgadget@gmail.com>
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

