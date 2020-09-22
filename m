Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C5CC2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61D6D2076E
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="RiTup3yW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgIVWv0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 18:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgIVWv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 18:51:26 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC8AC061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:51:26 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id n10so17091314qtv.3
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ouj7gAWcoUbIXmBibCkI6L4lTEIRs9mmTaNaQx0X8Nk=;
        b=RiTup3yWJ4IBimKYGMmLHYGTGSDEieChPvyjoA0ZQo5xDQJc7AZe3R/CLsK475BxXs
         L2QmsvyCC0n2W2vPMrwfx/KDfLzPS9uIxdXDJS7XGHx6Go08ltu5N3a86CtHjlEDGDoN
         5UFw8TZ5DBKyApXBDUDqgJ4mj4ndXfUEReAbLpODsyf+hCxcjYRP/BLcM3JMbb9gAXaC
         hbijNItOMiiq4TRdPd0DlfQkogZj2dlc7icgZrmf3CSovgrwFSKkLtrFF5qL1nUt7Cpx
         XXgKwc4UZ5aWDbo5Vv0TKdpiyHf0rVyphpeL2mMYl1Lt+OMyDndNZMNEzWsBxjOor36q
         PPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ouj7gAWcoUbIXmBibCkI6L4lTEIRs9mmTaNaQx0X8Nk=;
        b=GU/yHT32ferrIdIWsXwZCPiuUyLe7zrzFB5GlBaaGYxUbZNJGIfChIsXYqXkX8/AL+
         1VISuqgHntDmcY7Fo5Kiw/5WQ8JUAKxLbtHM1bsDGGNjBzwT1nS9JrAeajl5NQNUOejF
         E8pDYfohJqlj253iBlw7DVgmtoT4fDARMGHwjNZvGVKNkI3oqwc7s2d1i0qZ1IkGKn0V
         ZIh1ssPclZMwQth9IUDlcfAuMSTkMs5CxsEq1XWb+DmzgZ1w9XTvMW5xJPIQPzEStfkQ
         hISCkhnGW9bxiGRM0ylUrVJpAW+8UHuBO1zUvEUwVRlCRc54BZNDwHjxeaaSYgaE+Abh
         ilLA==
X-Gm-Message-State: AOAM530W70JM+PSnkOA6b3nv5VF4d93UPtgHDHUz7TG95QyfH1HG4Tmz
        gRjJjaRVVGUmjnYwsKwVEAkgkgormZYPGg==
X-Google-Smtp-Source: ABdhPJxFSJZUN1tzcUiXF22ATxXaUPhxr+0qrQVzmVdo3w7BXQ8AzSsOjELEjKQdHAzrlSb0zVffHg==
X-Received: by 2002:ac8:7650:: with SMTP id i16mr7319303qtr.268.1600815084949;
        Tue, 22 Sep 2020 15:51:24 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.96.45])
        by smtp.gmail.com with ESMTPSA id p187sm12342359qkd.129.2020.09.22.15.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 15:51:24 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, chriscool@tuxfamily.org, peff@peff.net,
        t.gummerer@gmail.com, newren@gmail.com
Subject: [PATCH v2 17/19] parallel-checkout: add tests related to clone collisions
Date:   Tue, 22 Sep 2020 19:49:31 -0300
Message-Id: <70708d3e31b49f55b1eae6077d5386bb63ce617d.1600814153.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600814153.git.matheus.bernardino@usp.br>
References: <cover.1600814153.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests to confirm that path collisions are properly reported during a
clone operation using parallel-checkout.

Original-patch-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/t2081-parallel-checkout-collisions.sh | 115 ++++++++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100755 t/t2081-parallel-checkout-collisions.sh

diff --git a/t/t2081-parallel-checkout-collisions.sh b/t/t2081-parallel-checkout-collisions.sh
new file mode 100755
index 0000000000..3ce195b892
--- /dev/null
+++ b/t/t2081-parallel-checkout-collisions.sh
@@ -0,0 +1,115 @@
+#!/bin/sh
+
+test_description='parallel-checkout collisions'
+
+. ./test-lib.sh
+
+# When there are pathname collisions during a clone, Git should report a warning
+# listing all of the colliding entries. The sequential code detects a collision
+# by calling lstat() before trying to open(O_CREAT) the file. Then, to find the
+# colliding pair of an item k, it searches cache_entry[0, k-1].
+#
+# This is not sufficient in parallel-checkout mode since colliding files may be
+# created in a racy order. The tests in this file make sure the collision
+# detection code is extended for parallel-checkout. This is done in two parts:
+#
+# - First, two parallel workers create four colliding files racily.
+# - Then this exercise is repeated but forcing the colliding pair to appear in
+#   the second half of the cache_entry's array.
+#
+# The second item uses the fact that files with clean/smudge filters are not
+# parallel-eligible; and that they are processed sequentially *before* any
+# worker is spawned. We set a filter attribute to the last entry in the
+# cache_entry[] array, making it non-eligible, so that it is populated first.
+# This way, we can test if the collision detection code is correctly looking
+# for collision pairs in the second half of the array.
+
+test_expect_success CASE_INSENSITIVE_FS 'setup' '
+	file_hex=$(git hash-object -w --stdin </dev/null) &&
+	file_oct=$(echo $file_hex | hex2oct) &&
+
+	attr_hex=$(echo "file_x filter=logger" | git hash-object -w --stdin) &&
+	attr_oct=$(echo $attr_hex | hex2oct) &&
+
+	printf "100644 FILE_X\0${file_oct}" >tree &&
+	printf "100644 FILE_x\0${file_oct}" >>tree &&
+	printf "100644 file_X\0${file_oct}" >>tree &&
+	printf "100644 file_x\0${file_oct}" >>tree &&
+	printf "100644 .gitattributes\0${attr_oct}" >>tree &&
+
+	tree_hex=$(git hash-object -w -t tree --stdin <tree) &&
+	commit_hex=$(git commit-tree -m collisions $tree_hex) &&
+	git update-ref refs/heads/collisions $commit_hex &&
+
+	write_script logger_script <<-\EOF
+	echo "$@" >>filter.log
+	EOF
+'
+
+clone_and_check_collision()
+{
+	id=$1 workers=$2 threshold=$3 expected_workers=$4 filter=$5 &&
+
+	filter_opts=
+	if test "$filter" -eq "use_filter"
+	then
+		# We use `core.ignoreCase=0` so that only `file_x`
+		# matches the pattern in .gitattributes.
+		#
+		filter_opts='-c filter.logger.smudge="../logger_script %f" -c core.ignoreCase=0'
+	fi &&
+
+	test_path_is_missing $id.trace &&
+	GIT_TRACE2="$(pwd)/$id.trace" git \
+		-c checkout.workers=$workers \
+		-c checkout.thresholdForParallelism=$threshold \
+		$filter_opts clone --branch=collisions -- . r_$id 2>$id.warning &&
+
+	# Check that checkout spawned the right number of workers
+	workers_in_trace=$(grep "child_start\[.\] git checkout--helper" $id.trace | wc -l) &&
+	test $workers_in_trace -eq $expected_workers &&
+
+	if test $filter -eq "use_filter"
+	then
+		#  Make sure only 'file_x' was filtered
+		test_path_is_file r_$id/filter.log &&
+		echo file_x >expected.filter.log &&
+		test_cmp r_$id/filter.log expected.filter.log
+	else
+		test_path_is_missing r_$id/filter.log
+	fi &&
+
+	grep FILE_X $id.warning &&
+	grep FILE_x $id.warning &&
+	grep file_X $id.warning &&
+	grep file_x $id.warning &&
+	test_i18ngrep "the following paths have collided" $id.warning
+}
+
+test_expect_success CASE_INSENSITIVE_FS 'collision detection on parallel clone' '
+	clone_and_check_collision parallel 2 0 2
+'
+
+test_expect_success CASE_INSENSITIVE_FS 'collision detection on fallback to sequential clone' '
+	git ls-tree --name-only -r collisions >files &&
+	nr_files=$(wc -l <files) &&
+	threshold=$(($nr_files + 1)) &&
+	clone_and_check_collision sequential 2 $threshold 0
+'
+
+# The next two tests don't work on Windows because, on this system, collision
+# detection uses strcmp() (when core.ignoreCase=0) to find the colliding pair.
+# But they work on OSX, where collision detection uses inode.
+
+test_expect_success CASE_INSENSITIVE_FS,!MINGW,!CYGWIN 'collision detection on parallel clone w/ filter' '
+	clone_and_check_collision parallel-with-filter 2 0 2 use_filter
+'
+
+test_expect_success CASE_INSENSITIVE_FS,!MINGW,!CYGWIN 'collision detection on fallback to sequential clone w/ filter' '
+	git ls-tree --name-only -r collisions >files &&
+	nr_files=$(wc -l <files) &&
+	threshold=$(($nr_files + 1)) &&
+	clone_and_check_collision sequential-with-filter 2 $threshold 0 use_filter
+'
+
+test_done
-- 
2.28.0

