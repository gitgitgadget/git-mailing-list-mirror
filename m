Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A94C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8419E6126A
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347858AbhIUCWa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236453AbhIUBuU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:50:20 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533DAC07E5C4
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 15:15:18 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w17so25599961wrv.10
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 15:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=THp3oyYMQZ0IyvYbWDVtqI55HStotyepThNgwaAMuqY=;
        b=idDtJXXLboCwldv4igpDXn8uT6iaEPaKO+U9r3LsTAyDvQXnhvCKndKFkl2dBwsped
         mRUITE6tgknc/a/9j7P5m9lEesuLEASzYiDJUMxrpZTZKF2gaACfUjSP9aFIyeoiEnLW
         DrSINIWScn+AiPhH7Mkw2qpaH0OBqN0/silfT6C9yiT7E/+7vttdb9tHvvF8KuaT9GaN
         P9Etzm07H7nwjzsVA3jMt9fKC4qOsSipNd9tqISnCbuA2ocYo5M1f2I2RnlPwPlBpjyB
         3mrmAyZJuXUBSidHN5pFywk90dy523E4b42icSYbV9nnGc3+crJHeL8QNJqYiCDUs4kN
         l9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=THp3oyYMQZ0IyvYbWDVtqI55HStotyepThNgwaAMuqY=;
        b=L0ImBESicHiFF+8F7o6aZRe5LZCyXGOpOf/9eVkVZJ7B/8NFfizAH6U+H+PUO0acAB
         VKXEqt3eO0ymWvQ9DxwWIsblmKIhtoloAsy945koFTS6AZmHubAsfYc+XJseYAedlIBX
         U0AcaHM6skWvyouKQduglWQwQCdhsGSkNdM7mn/IPEYFt5wXr43vSgJ0r64Y+Ke8jcHu
         sNNrAYLKaYaQb9l0Npg8AaVTYz8+s9uJTx9c/v/kb+Lu0hv+4jJExhWQx5D6huawkkfo
         6UHJXkJjmeCQcURNpjfgCVNXqjeFezAfErg9oyrrrXE8QZDUD1+1IJgvQzjXEYQP/5p0
         VSZQ==
X-Gm-Message-State: AOAM533CLhOIklYC3vGia2wutC1iwaZW8GFnr4rSYeVGa0pEuYUe+047
        4r+JlIxX/p0QFFXejMN/fTfVlgaw0LY=
X-Google-Smtp-Source: ABdhPJzM3v0bI9Fc+/QzAcDiVE67CIgqlLa1ZXNplVAlF7NeAVEOaNWygz6mewNHjpyJO29A5qwQ7A==
X-Received: by 2002:a05:600c:350f:: with SMTP id h15mr1252387wmq.144.1632176116913;
        Mon, 20 Sep 2021 15:15:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v21sm12242098wrv.3.2021.09.20.15.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 15:15:16 -0700 (PDT)
Message-Id: <3e6b80b5fa25c5f1dfdbe299e088323c86dc8587.1632176111.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v4.git.git.1632176111.gitgitgadget@gmail.com>
References: <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
        <pull.1076.v4.git.git.1632176111.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 22:15:11 +0000
Subject: [PATCH v4 6/6] core.fsyncobjectfiles: performance tests for add and
 stash
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Add a basic performance test for "git add" and "git stash" of a lot of
new objects with various fsync settings.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 t/perf/p3700-add.sh   | 43 ++++++++++++++++++++++++++++++++++++++++
 t/perf/p3900-stash.sh | 46 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)
 create mode 100755 t/perf/p3700-add.sh
 create mode 100755 t/perf/p3900-stash.sh

diff --git a/t/perf/p3700-add.sh b/t/perf/p3700-add.sh
new file mode 100755
index 00000000000..e93c08a2e70
--- /dev/null
+++ b/t/perf/p3700-add.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+#
+# This test measures the performance of adding new files to the object database
+# and index. The test was originally added to measure the effect of the
+# core.fsyncObjectFiles=batch mode, which is why we are testing different values
+# of that setting explicitly and creating a lot of unique objects.
+
+test_description="Tests performance of add"
+
+. ./perf-lib.sh
+
+. $TEST_DIRECTORY/lib-unique-files.sh
+
+test_perf_default_repo
+test_checkout_worktree
+
+dir_count=10
+files_per_dir=50
+total_files=$((dir_count * files_per_dir))
+
+# We need to create the files each time we run the perf test, but
+# we do not want to measure the cost of creating the files, so run
+# the tet once.
+if test "${GIT_PERF_REPEAT_COUNT-1}" -ne 1
+then
+	echo "warning: Setting GIT_PERF_REPEAT_COUNT=1" >&2
+	GIT_PERF_REPEAT_COUNT=1
+fi
+
+for m in false true batch
+do
+	test_expect_success "create the files for core.fsyncObjectFiles=$m" '
+		git reset --hard &&
+		# create files across directories
+		test_create_unique_files $dir_count $files_per_dir files
+	'
+
+	test_perf "add $total_files files (core.fsyncObjectFiles=$m)" "
+		git -c core.fsyncobjectfiles=$m add files
+	"
+done
+
+test_done
diff --git a/t/perf/p3900-stash.sh b/t/perf/p3900-stash.sh
new file mode 100755
index 00000000000..c9fcd0c03eb
--- /dev/null
+++ b/t/perf/p3900-stash.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+#
+# This test measures the performance of adding new files to the object database
+# and index. The test was originally added to measure the effect of the
+# core.fsyncObjectFiles=batch mode, which is why we are testing different values
+# of that setting explicitly and creating a lot of unique objects.
+
+test_description="Tests performance of stash"
+
+. ./perf-lib.sh
+
+. $TEST_DIRECTORY/lib-unique-files.sh
+
+test_perf_default_repo
+test_checkout_worktree
+
+dir_count=10
+files_per_dir=50
+total_files=$((dir_count * files_per_dir))
+
+# We need to create the files each time we run the perf test, but
+# we do not want to measure the cost of creating the files, so run
+# the tet once.
+if test "${GIT_PERF_REPEAT_COUNT-1}" -ne 1
+then
+	echo "warning: Setting GIT_PERF_REPEAT_COUNT=1" >&2
+	GIT_PERF_REPEAT_COUNT=1
+fi
+
+for m in false true batch
+do
+	test_expect_success "create the files for core.fsyncObjectFiles=$m" '
+		git reset --hard &&
+		# create files across directories
+		test_create_unique_files $dir_count $files_per_dir files
+	'
+
+	# We only stash files in the 'files' subdirectory since
+	# the perf test infrastructure creates files in the
+	# current working directory that need to be preserved
+	test_perf "stash 500 files (core.fsyncObjectFiles=$m)" "
+		git -c core.fsyncobjectfiles=$m stash push -u -- files
+	"
+done
+
+test_done
-- 
gitgitgadget
