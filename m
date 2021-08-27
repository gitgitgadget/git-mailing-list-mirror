Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D75C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 23:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB28A60EBA
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 23:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbhH0Xui (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 19:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbhH0Xuc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 19:50:32 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3521FC0617A8
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 16:49:43 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u9so12720228wrg.8
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 16:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Vrb0Jnn5ImSQtleFZTqPwnJj+nFf4VQvZpqsrSdQ7Xc=;
        b=gic9i+lb7ojJT7ZZ8akkE1I3PL4OwIOPclcBkcGN5KGuRr1CrLnawlYA5WoeT+TQlp
         EcdbPRFEjtECK2e0Br/VfZcP7TXH6ITS9N7ni57Fr36ZrU2xXd2h0HVq/7KGvNLr7SkZ
         PeTlWvTd/d+ME4RTXdNZmJMGbDlSsZwlW/0hRyX05x7x6+1qYbfv9EWMnaepXIZ7Pp+P
         to/JVPPZdNYOpzwsNbMagEEKIjEhfLDPtviQtbS5aYGztP8j32XdNi3KHrHFV1G/Iq35
         LE0VSiDOT0yaueSbO1p44dGx0JIoUBXzU5lcA6NH9fEU3EJxPvVGTGF/7XpxfvMiOnbs
         viJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Vrb0Jnn5ImSQtleFZTqPwnJj+nFf4VQvZpqsrSdQ7Xc=;
        b=IUyVkeV9jTVeaDoHQnctGOqYalC9x9kS18adqhKtOSQaJy8HaOqU9Ef2W07umL2Nzh
         mYa87Puq0qqu0DnUBdmglGvWnQd65HOazPCNToPdQD9a7pjD+MFkU3d1lIcUIHEQ1Wgo
         AtSWVzzY8aFBOUUrafYzBLyXMA75fmhI7xgHa8Ny/IxvkSp8W/7qcnpmaVzBh0GEqs66
         5RVcZI6Nfn3GXEp9RyciiPJAC4g7RpE0YNZdWsqS6kfdwAUQdrw3ne3zRmwV2sxCof5m
         hw0I2wJrMAzkUWWnUshc6xmli5eTAiE5ge0MWdiDESyujUz2lEwautX3nUOdSooe/lyO
         UiDA==
X-Gm-Message-State: AOAM530JFVr2/Q6U9CONAefoh0w1nPiY474icXnKTWKRfY8Nr5SdRR5c
        MZ6g/YNoIO43WN7tO9WekhKEfZIEAGE=
X-Google-Smtp-Source: ABdhPJymuqcMtyKIzdKyfUraRl7PvBgdqrirPsMiZBHgI2hNdWEng9M1qgJBN0EtD+YB6VtgKQ213A==
X-Received: by 2002:adf:b35c:: with SMTP id k28mr12898671wrd.169.1630108181771;
        Fri, 27 Aug 2021 16:49:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o12sm7476313wmr.2.2021.08.27.16.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 16:49:41 -0700 (PDT)
Message-Id: <73b5d41be94d6e5571cbe5b8dd0d0f74edc4b474.1630108177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com>
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com>
        <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Aug 2021 23:49:37 +0000
Subject: [PATCH v2 6/6] core.fsyncobjectfiles: performance tests for add and
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
        <avarab@gmail.com>, "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Add a basic performance test for "git add" and "git stash" of a lot of
new objects with various fsync settings.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 t/perf/lib-unique-files.sh | 32 ++++++++++++++++++++++++++
 t/perf/p3700-add.sh        | 43 +++++++++++++++++++++++++++++++++++
 t/perf/p3900-stash.sh      | 46 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+)
 create mode 100644 t/perf/lib-unique-files.sh
 create mode 100755 t/perf/p3700-add.sh
 create mode 100755 t/perf/p3900-stash.sh

diff --git a/t/perf/lib-unique-files.sh b/t/perf/lib-unique-files.sh
new file mode 100644
index 00000000000..10083395ae5
--- /dev/null
+++ b/t/perf/lib-unique-files.sh
@@ -0,0 +1,32 @@
+# Helper to create files with unique contents
+
+test_create_unique_files_base__=$(date -u)
+test_create_unique_files_counter__=0
+
+# Create multiple files with unique contents. Takes the number of
+# directories, the number of files in each directory, and the base
+# directory.
+#
+# test_create_unique_files 2 3 . -- Creates 2 directories with 3 files
+#				    each in the current directory, all
+#				    with unique contents.
+
+test_create_unique_files() {
+	test "$#" -ne 3 && BUG "3 param"
+
+	local dirs=$1
+	local files=$2
+	local basedir=$3
+
+	for i in $(test_seq $dirs)
+	do
+		local dir=$basedir/dir$i
+
+		mkdir -p "$dir" > /dev/null
+		for j in $(test_seq $files)
+		do
+			test_create_unique_files_counter__=$((test_create_unique_files_counter__ + 1))
+			echo "$test_create_unique_files_base__.$test_create_unique_files_counter__"  >"$dir/file$j.txt"
+		done
+	done
+}
diff --git a/t/perf/p3700-add.sh b/t/perf/p3700-add.sh
new file mode 100755
index 00000000000..4ca3224f364
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
+. $TEST_DIRECTORY/perf/lib-unique-files.sh
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
+if test "$GIT_PERF_REPEAT_COUNT" -ne 1
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
index 00000000000..407b95c104b
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
+. $TEST_DIRECTORY/perf/lib-unique-files.sh
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
+if test "$GIT_PERF_REPEAT_COUNT" -ne 1
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
