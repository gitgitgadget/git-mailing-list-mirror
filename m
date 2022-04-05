Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8D7C433EF
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 05:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiDEFWr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 01:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiDEFWf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 01:22:35 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE161026
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 22:20:38 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fu5so5074895pjb.1
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 22:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FaHm2PjShw23uX42jtCzBJNUpGzDjDOvaNnkifLp9w8=;
        b=U9oJrsdToyYDBnBZWRgBnmip2Df3FZXwFxu3v94iZ+UD4ldrxNz0aSnYJeqLvEcxxB
         RxUJNjWVtGH3a8cZgswpl3VSszliX8sTnYJtGvfEFRfjpJ2/pS17CmKGJxARK1x8CI7Q
         oAjVtiDenwhTyrkWqGfNR9LkEq+WVwb0tyyPaZ6QseDx1jZTkAjdApHJfvXWMJZKw7D4
         6PqNaZjjCRWhJWGzP8Q1wrujSCMBW53jjaMV/yzJl6PgKc3oDjJIr34442OmPLrZOEXV
         BXKn70UEWQhTpUpyDapK0XJ/onqqQIV5/1F8IuXb80F3Mk80PoFzqyDzWyAzQt/ajP5R
         75CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FaHm2PjShw23uX42jtCzBJNUpGzDjDOvaNnkifLp9w8=;
        b=qJVLGnaR4PK9YVeCC8wzTgNGuZ6A+HEDt/1hOMxRzeWu3Fs4ihEyZALYB22Zv7bn52
         6fiu6oy8xRt8Ken7nhjKNkJyUQ8cPSIFE6+kbCrr4JfOfo8FTZHxYIcnK3ciz3KestDD
         h2fYG/1pHAIc7FNqURiwHNwxW5RURWmhm3B0UrwSwfJjSFQyhoX73JRqcTKRinmtLHp2
         27f0+pM0XEXS9dZU4cTtOqT/hVHswus2jdDxLb7ltu+rGmZjW45esMB04+kaD7KQF76J
         1nwGeCrQQ9FITuLh/cHI7tEuOG4XOsZDuun6fnj95jKQdcxi6RfoIn+xgUeqCUhNl8Tp
         tdHA==
X-Gm-Message-State: AOAM531Z6NeesKEI/wXHTQCaM7pNniYoBE5Xa9jkngtdbyb/oxzUwkAF
        BdF6kvzIoqEh3HFEkKcKjx0=
X-Google-Smtp-Source: ABdhPJy+yTOiiQBEgnlokJTkK8Q/sbL+2MIsQpCWBV6IyvaP70wiIL/EHBiKt8wfN9CFI5LLOQucyg==
X-Received: by 2002:a17:90a:1697:b0:1ca:526a:5dcd with SMTP id o23-20020a17090a169700b001ca526a5dcdmr2099677pja.143.1649136037591;
        Mon, 04 Apr 2022 22:20:37 -0700 (PDT)
Received: from neerajsi-x1.localdomain (c-24-56-226-231.customer.broadstripe.net. [24.56.226.231])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090a708300b001c7e8ae7637sm808859pjk.8.2022.04.04.22.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 22:20:37 -0700 (PDT)
From:   nksingh85@gmail.com
X-Google-Original-From: neerajsi@microsoft.com
To:     gitgitgadget@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, bagasdotme@gmail.com,
        git@vger.kernel.org, jeffhost@microsoft.com,
        neerajsi@microsoft.com, nksingh85@gmail.com, ps@pks.im,
        worldhello.net@gmail.com
Subject: [PATCH v6 12/12] core.fsyncmethod: performance tests for batch mode
Date:   Mon,  4 Apr 2022 22:20:18 -0700
Message-Id: <20220405052018.11247-13-neerajsi@microsoft.com>
X-Mailer: git-send-email 2.34.1.78.g86e39b8f8d
In-Reply-To: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
References: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Add basic performance tests for git commands that can add data to the
object database. We cover:
* git add
* git stash
* git update-index (via git stash)
* git unpack-objects
* git commit --all

We cover all currently available fsync methods as well.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 t/perf/p0008-odb-fsync.sh | 82 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100755 t/perf/p0008-odb-fsync.sh

diff --git a/t/perf/p0008-odb-fsync.sh b/t/perf/p0008-odb-fsync.sh
new file mode 100755
index 00000000000..b3a90f30eba
--- /dev/null
+++ b/t/perf/p0008-odb-fsync.sh
@@ -0,0 +1,82 @@
+#!/bin/sh
+#
+# This test measures the performance of adding new files to the object
+# database. The test was originally added to measure the effect of the
+# core.fsyncMethod=batch mode, which is why we are testing different values of
+# that setting explicitly and creating a lot of unique objects.
+
+test_description="Tests performance of adding things to the object database"
+
+. ./perf-lib.sh
+
+. $TEST_DIRECTORY/lib-unique-files.sh
+
+test_perf_fresh_repo
+test_checkout_worktree
+
+dir_count=10
+files_per_dir=50
+total_files=$((dir_count * files_per_dir))
+
+populate_files () {
+	test_create_unique_files $dir_count $files_per_dir files
+}
+
+setup_repo () {
+	(rm -rf .git || 1) &&
+	git init &&
+	test_commit first &&
+	populate_files
+}
+
+test_perf_fsync_cfgs () {
+	local method &&
+	local cfg &&
+	for method in none fsync batch writeout-only
+	do
+		case $method in
+		none)
+			cfg="-c core.fsync=none"
+			;;
+		*)
+			cfg="-c core.fsync=loose-object -c core.fsyncMethod=$method"
+		esac &&
+
+		# Set GIT_TEST_FSYNC=1 explicitly since fsync is normally
+		# disabled by t/test-lib.sh.
+		if ! test_perf "$1 (fsyncMethod=$method)" \
+						--setup "$2" \
+						"GIT_TEST_FSYNC=1 git $cfg $3"
+		then
+			break
+		fi
+	done
+}
+
+test_perf_fsync_cfgs "add $total_files files" \
+	"setup_repo" \
+	"add -- files"
+
+test_perf_fsync_cfgs "stash $total_files files" \
+	"setup_repo" \
+	"stash push -u -- files"
+
+test_perf_fsync_cfgs "unpack $total_files files" \
+	"
+	setup_repo &&
+	git -c core.fsync=none add -- files &&
+	git -c core.fsync=none commit -q -m second &&
+	echo HEAD | git pack-objects -q --stdout --revs >test_pack.pack &&
+	setup_repo
+	" \
+	"unpack-objects -q <test_pack.pack"
+
+test_perf_fsync_cfgs "commit $total_files files" \
+	"
+	setup_repo &&
+	git -c core.fsync=none add -- files &&
+	populate_files
+	" \
+	"commit -q -a -m test"
+
+test_done
-- 
2.34.1.78.g86e39b8f8d

