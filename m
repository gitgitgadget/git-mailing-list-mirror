Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6006C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 03:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8764F60EE9
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 03:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239100AbhINDk0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 23:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238848AbhINDkO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 23:40:14 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122E2C061764
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 20:38:51 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id y132so8071352wmc.1
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 20:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Vrb0Jnn5ImSQtleFZTqPwnJj+nFf4VQvZpqsrSdQ7Xc=;
        b=Akd2msZUT+YUxLAZD8/sVtZfIcPKSHDlTPe7xIgaCq367LLYRaJodPMAaRqdq4g808
         HAt6etOISC6DOXPrScu3IcVDtnxP2DOzFjBXYiVPycSnoJBIM746f5cryJJAfOrY4fJO
         0ctgLUOUVusjJJCcZ4t/dugm5I/JB8xRM+LPXfp3lgCFcY2Jy1LE0o9EOGJfFNpRNp1G
         OTbtvLIbOLIr715o+2pDGlW8UHVwbe+ncUr67aWs5Q+1m/VMUHaGIcB3YckdCQwWIt8F
         Mo55RnmGrY+KYNQSjYz45XKNcQf+q6LgozY3IVAAtcofF0Z2OCtmuKHO6ikrSxfjeswa
         E0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Vrb0Jnn5ImSQtleFZTqPwnJj+nFf4VQvZpqsrSdQ7Xc=;
        b=Z6DLpBdybX6gAtO1e5e03Y0+RHbV/h7y264z/tna/lemb+VudtQkQHAUjhLvRhn3vG
         jIvNoOAbkkM3Jlc5W9MsUAqbO6++8oowb4ZaEnTHeHodvPWrUqKB3kjQ6j/4gMdiWvA7
         OQLfe8V1apzWavle4sAjrFRt5P/M5nWP6W1GpKmWx1e6+cGpIRZiKis2NVM6XASXxoEe
         4v/UO0cjWXQAQlZO6Do7kcjNqriqU9Gkv7NexQm1+tqQto06AGjby7Lr0hFe9ofD6nTU
         w9e8CVKDKOMFUGVDCM54XqKlDnilulp6b4q1jZ58DRdNiHVMl0MRSDd1rWHg4Mnf7RQV
         nqZQ==
X-Gm-Message-State: AOAM530UNpnXyZ/4kPKqKDUcPP43dRENa8I4YkdwJ+yReXzCCir8xQnI
        TK919ccX5+WA+lchTMQtNCdQSR7j5HI=
X-Google-Smtp-Source: ABdhPJwRP45tDHI2aRHsT/Je7sMccSWEqPN2MRRsM5JPdpVfDIznu/t6JiuXaQbZex+BMynr09OZcQ==
X-Received: by 2002:a1c:149:: with SMTP id 70mr14331981wmb.187.1631590729627;
        Mon, 13 Sep 2021 20:38:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 129sm8346796wmz.26.2021.09.13.20.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 20:38:49 -0700 (PDT)
Message-Id: <b7ca3ba9302dbf4b2bde87fdd5f663f7790720f0.1631590725.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
References: <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com>
        <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Sep 2021 03:38:44 +0000
Subject: [PATCH v3 5/6] core.fsyncobjectfiles: performance tests for add and
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

