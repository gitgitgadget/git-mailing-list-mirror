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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377CDC2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 08:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CEBB6128A
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 08:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhFVIHJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 04:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhFVIHC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 04:07:02 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4007C06175F
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 01:04:45 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id j11-20020a05600c1c0bb02901e23d4c0977so476281wms.0
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 01:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0rornULiPb4aocIuNRBO1gWiUJldsp1W22PEYrTdgX0=;
        b=ItkxamHaUUwTF7yPECt8T3yNNcdALaUVs+DJbY8/wxkEcXNNxXy+hPuXksKHyKZMyr
         9wHui+0ZGykYGi0oO6vqum+mkYrmvtUcIEjzSoiEFaOoOgAwRN7FqQPnnFGKkehSllBQ
         Ev4GLV5RRMs33S5d3epT/mlV8p8oU5cdoG9d0Wzqept/BPOkD/pYCeTodAzDm0Ps0a7i
         aIWm8LaKGjfp5+Eb8h2j4T+FVSQjTj1U4uPAJX86oJ/8yg+EX17V9ZbKvXy4/tRhIBzN
         6glAhQgRHjwssOkuXr4Dc8hDaAUty0d6Zsj1M9w7VlsJuNqYG4Zaa+O/I/5aPwepd11v
         vfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0rornULiPb4aocIuNRBO1gWiUJldsp1W22PEYrTdgX0=;
        b=EIsnfkMDTHrZPp0LsdQx7tCgymOYocXdkOTWiu3udA5t0Mv6oNKpy3Jt8zHByjoBBz
         WDOW0z6tHVZYj2kmwXSu4VM6n5wADXTGf4lM+YMAtUKb1Wbbq09JBpMcjJ8Qp+91mkRN
         vFNdZjWqQ1JmSzPq7NZoqF4uW2zMK7oOq8jMmHWtL6Y2V++Q7KCFB2tVh4DbA1tdynoS
         2phM1E6M/1W9ec2uYJfRYa86jkMVyhXInRgb+Fsl2IYMJ5+5KcGG7sTMDi7ksUL5PRO5
         NsllGLZihK+evHmm953O+NSCEn9V/zAwXUfnoIO0k2ZNv8yWo0ZR8nSdYHGPaJ5JFRSj
         gknA==
X-Gm-Message-State: AOAM5300icTTH31j6Ho4oQ+fhQahlKGGmzNrngmLlHOJrmjvg5UfYVvE
        vRfUk5m8s4sm9msgk7NZ3yd3zjRH7s8=
X-Google-Smtp-Source: ABdhPJztpNkZKLDEf7e6yAWiNblWaL4BzE8MTs0e+nySBjFnubovIPIwqGOpEHsDW9lFa09JP7wIyA==
X-Received: by 2002:a05:600c:190f:: with SMTP id j15mr2806742wmq.37.1624349084386;
        Tue, 22 Jun 2021 01:04:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q11sm20283168wrx.80.2021.06.22.01.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 01:04:44 -0700 (PDT)
Message-Id: <4796e096fdb4f4ef8513c0e9214754d41b4db5d7.1624349082.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.969.v3.git.1624349082.gitgitgadget@gmail.com>
References: <pull.969.v2.git.1623796907.gitgitgadget@gmail.com>
        <pull.969.v3.git.1624349082.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Jun 2021 08:04:38 +0000
Subject: [PATCH v3 2/5] t6421: add tests checking for excessive object
 downloads during merge
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6421-merge-partial-clone.sh | 440 +++++++++++++++++++++++++++++++++
 1 file changed, 440 insertions(+)
 create mode 100755 t/t6421-merge-partial-clone.sh

diff --git a/t/t6421-merge-partial-clone.sh b/t/t6421-merge-partial-clone.sh
new file mode 100755
index 000000000000..3dcffc15f801
--- /dev/null
+++ b/t/t6421-merge-partial-clone.sh
@@ -0,0 +1,440 @@
+#!/bin/sh
+
+test_description="limiting blob downloads when merging with partial clones"
+# Uses a methodology similar to
+#   t6042: corner cases with renames but not criss-cross merges
+#   t6036: corner cases with both renames and criss-cross merges
+#   t6423: directory rename detection
+#
+# The setup for all of them, pictorially, is:
+#
+#      A
+#      o
+#     / \
+#  O o   ?
+#     \ /
+#      o
+#      B
+#
+# To help make it easier to follow the flow of tests, they have been
+# divided into sections and each test will start with a quick explanation
+# of what commits O, A, and B contain.
+#
+# Notation:
+#    z/{b,c}   means  files z/b and z/c both exist
+#    x/d_1     means  file x/d exists with content d1.  (Purpose of the
+#                     underscore notation is to differentiate different
+#                     files that might be renamed into each other's paths.)
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-merge.sh
+
+test_setup_repo () {
+	test -d server && return
+	test_create_repo server &&
+	(
+		cd server &&
+
+		git config uploadpack.allowfilter 1 &&
+		git config uploadpack.allowanysha1inwant 1 &&
+
+		mkdir -p general &&
+		test_seq 2 9 >general/leap1 &&
+		cp general/leap1 general/leap2 &&
+		echo leap2 >>general/leap2 &&
+
+		mkdir -p basename &&
+		cp general/leap1 basename/numbers &&
+		cp general/leap1 basename/sequence &&
+		cp general/leap1 basename/values &&
+		echo numbers >>basename/numbers &&
+		echo sequence >>basename/sequence &&
+		echo values >>basename/values &&
+
+		mkdir -p dir/unchanged &&
+		mkdir -p dir/subdir/tweaked &&
+		echo a >dir/subdir/a &&
+		echo b >dir/subdir/b &&
+		echo c >dir/subdir/c &&
+		echo d >dir/subdir/d &&
+		echo e >dir/subdir/e &&
+		cp general/leap1 dir/subdir/Makefile &&
+		echo toplevel makefile >>dir/subdir/Makefile &&
+		echo f >dir/subdir/tweaked/f &&
+		echo g >dir/subdir/tweaked/g &&
+		echo h >dir/subdir/tweaked/h &&
+		echo subdirectory makefile >dir/subdir/tweaked/Makefile &&
+		for i in $(test_seq 1 88)
+		do
+			echo content $i >dir/unchanged/file_$i
+		done &&
+		git add . &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B-single &&
+		git branch B-dir &&
+		git branch B-many &&
+
+		git switch A &&
+
+		git rm general/leap* &&
+		mkdir general/ &&
+		test_seq 1 9 >general/jump1 &&
+		cp general/jump1 general/jump2 &&
+		echo leap2 >>general/jump2 &&
+
+		rm basename/numbers basename/sequence basename/values &&
+		mkdir -p basename/subdir/
+		cp general/jump1 basename/subdir/numbers &&
+		cp general/jump1 basename/subdir/sequence &&
+		cp general/jump1 basename/subdir/values &&
+		echo numbers >>basename/subdir/numbers &&
+		echo sequence >>basename/subdir/sequence &&
+		echo values >>basename/subdir/values &&
+
+		git rm dir/subdir/tweaked/f &&
+		echo more >>dir/subdir/e &&
+		echo more >>dir/subdir/Makefile &&
+		echo more >>dir/subdir/tweaked/Makefile &&
+		mkdir dir/subdir/newsubdir &&
+		echo rust code >dir/subdir/newsubdir/newfile.rs &&
+		git mv dir/subdir/e dir/subdir/newsubdir/ &&
+		git mv dir folder &&
+		git add . &&
+		git commit -m "A" &&
+
+		git switch B-single &&
+		echo new first line >dir/subdir/Makefile &&
+		cat general/leap1 >>dir/subdir/Makefile &&
+		echo toplevel makefile >>dir/subdir/Makefile &&
+		echo perl code >general/newfile.pl &&
+		git add . &&
+		git commit -m "B-single" &&
+
+		git switch B-dir &&
+		echo java code >dir/subdir/newfile.java &&
+		echo scala code >dir/subdir/newfile.scala &&
+		echo groovy code >dir/subdir/newfile.groovy &&
+		git add . &&
+		git commit -m "B-dir" &&
+
+		git switch B-many &&
+		test_seq 2 10 >general/leap1 &&
+		rm general/leap2 &&
+		cp general/leap1 general/leap2 &&
+		echo leap2 >>general/leap2 &&
+
+		rm basename/numbers basename/sequence basename/values &&
+		mkdir -p basename/subdir/
+		cp general/leap1 basename/subdir/numbers &&
+		cp general/leap1 basename/subdir/sequence &&
+		cp general/leap1 basename/subdir/values &&
+		echo numbers >>basename/subdir/numbers &&
+		echo sequence >>basename/subdir/sequence &&
+		echo values >>basename/subdir/values &&
+
+		mkdir dir/subdir/newsubdir/ &&
+		echo c code >dir/subdir/newfile.c &&
+		echo python code >dir/subdir/newsubdir/newfile.py &&
+		git add . &&
+		git commit -m "B-many" &&
+
+		git switch A
+	)
+}
+
+# Testcase: Objects downloaded for single relevant rename
+#   Commit O:
+#              general/{leap1_O, leap2_O}
+#              basename/{numbers_O, sequence_O, values_O}
+#              dir/subdir/{a,b,c,d,e_O,Makefile_TOP_O}
+#              dir/subdir/tweaked/{f,g,h,Makefile_SUB_O}
+#              dir/unchanged/<LOTS OF FILES>
+#   Commit A:
+#     (Rename leap->jump, rename basename/ -> basename/subdir/, rename dir/
+#      -> folder/, move e into newsubdir, add newfile.rs, remove f, modify
+#      both both Makefiles and jumps)
+#              general/{jump1_A, jump2_A}
+#              basename/subdir/{numbers_A, sequence_A, values_A}
+#              folder/subdir/{a,b,c,d,Makefile_TOP_A}
+#              folder/subdir/newsubdir/{e_A,newfile.rs}
+#              folder/subdir/tweaked/{g,h,Makefile_SUB_A}
+#              folder/unchanged/<LOTS OF FILES>
+#   Commit B(-single):
+#     (add newfile.pl, tweak Makefile_TOP)
+#              general/{leap1_O, leap2_O,newfile.pl}
+#              basename/{numbers_O, sequence_O, values_O}
+#              dir/{a,b,c,d,e_O,Makefile_TOP_B}
+#              dir/tweaked/{f,g,h,Makefile_SUB_O}
+#              dir/unchanged/<LOTS OF FILES>
+#   Expected:
+#              general/{jump1_A, jump2_A,newfile.pl}
+#              basename/subdir/{numbers_A, sequence_A, values_A}
+#              folder/subdir/{a,b,c,d,Makefile_TOP_Merged}
+#              folder/subdir/newsubdir/{e_A,newfile.rs}
+#              folder/subdir/tweaked/{g,h,Makefile_SUB_A}
+#              folder/unchanged/<LOTS OF FILES>
+#
+# Objects that need to be fetched:
+#   Rename detection:
+#     Side1 (O->A):
+#       Basename-matches rename detection only needs to fetch these objects:
+#         Makefile_TOP_O, Makefile_TOP_A
+#         (Despite many renames, all others are content irrelevant.  They
+#          are also location irrelevant because newfile.rs was added on
+#          the side doing the directory rename, and newfile.pl was added to
+#          a directory that was not renamed on either side.)
+#       General rename detection only needs to fetch these objects:
+#         <None>
+#          (Even though newfile.rs, jump[12], basename/subdir/*, and e
+#          could all be used as destinations in rename detection, the
+#          basename detection for Makefile matches up all relevant
+#          sources, so these other files never end up needing to be
+#          used)
+#     Side2 (O->B):
+#       Basename-matches rename detection only needs to fetch these objects:
+#         <None>
+#         (there are no deleted files, so no possible sources)
+#       General rename detection only needs to fetch these objects:
+#         <None>
+#         (there are no deleted files, so no possible sources)
+#   Merge:
+#     3-way content merge needs to grab these objects:
+#       Makefile_TOP_B
+#   Nothing else needs to fetch objects
+#
+#   Summary: 2 fetches (1 for 2 objects, 1 for 1 object)
+#
+test_expect_merge_algorithm failure failure 'Objects downloaded for single relevant rename' '
+	test_setup_repo &&
+	git clone --sparse --filter=blob:none "file://$(pwd)/server" objects-single &&
+	(
+		cd objects-single &&
+
+		git rev-list --objects --all --missing=print |
+			grep "^?" | sort >missing-objects-before &&
+
+		git checkout -q origin/A &&
+
+		GIT_TRACE2_PERF="$(pwd)/trace.output" git \
+			-c merge.directoryRenames=true merge --no-stat \
+			--no-progress origin/B-single &&
+
+		# Check the number of objects we reported we would fetch
+		cat >expect <<-EOF &&
+		fetch_count:2
+		fetch_count:1
+		EOF
+		grep fetch_count trace.output | cut -d "|" -f 9 | tr -d " ." >actual &&
+		test_cmp expect actual &&
+
+		# Check the number of fetch commands exec-ed
+		grep d0.*fetch.negotiationAlgorithm trace.output >fetches &&
+		test_line_count = 2 fetches &&
+
+		git rev-list --objects --all --missing=print |
+			grep "^?" | sort >missing-objects-after &&
+		comm -2 -3 missing-objects-before missing-objects-after >old &&
+		comm -1 -3 missing-objects-before missing-objects-after >new &&
+		# No new missing objects
+		test_must_be_empty new &&
+		# Fetched 2 + 1 = 3 objects
+		test_line_count = 3 old
+	)
+'
+
+# Testcase: Objects downloaded for directory rename
+#   Commit O:
+#              general/{leap1_O, leap2_O}
+#              basename/{numbers_O, sequence_O, values_O}
+#              dir/subdir/{a,b,c,d,e_O,Makefile_TOP_O}
+#              dir/subdir/tweaked/{f,g,h,Makefile_SUB_O}
+#              dir/unchanged/<LOTS OF FILES>
+#   Commit A:
+#     (Rename leap->jump, rename basename/ -> basename/subdir/, rename dir/ ->
+#      folder/, move e into newsubdir, add newfile.rs, remove f, modify
+#      both Makefiles and jumps)
+#              general/{jump1_A, jump2_A}
+#              basename/subdir/{numbers_A, sequence_A, values_A}
+#              folder/subdir/{a,b,c,d,Makefile_TOP_A}
+#              folder/subdir/newsubdir/{e_A,newfile.rs}
+#              folder/subdir/tweaked/{g,h,Makefile_SUB_A}
+#              folder/unchanged/<LOTS OF FILES>
+#   Commit B(-dir):
+#     (add dir/subdir/newfile.{java,scala,groovy}
+#              general/{leap1_O, leap2_O}
+#              basename/{numbers_O, sequence_O, values_O}
+#              dir/subdir/{a,b,c,d,e_O,Makefile_TOP_O,
+#                          newfile.java,newfile.scala,newfile.groovy}
+#              dir/subdir/tweaked/{f,g,h,Makefile_SUB_O}
+#              dir/unchanged/<LOTS OF FILES>
+#   Expected:
+#              general/{jump1_A, jump2_A}
+#              basename/subdir/{numbers_A, sequence_A, values_A}
+#              folder/subdir/{a,b,c,d,Makefile_TOP_A,
+#                             newfile.java,newfile.scala,newfile.groovy}
+#              folder/subdir/newsubdir/{e_A,newfile.rs}
+#              folder/subdir/tweaked/{g,h,Makefile_SUB_A}
+#              folder/unchanged/<LOTS OF FILES>
+#
+# Objects that need to be fetched:
+#   Makefile_TOP_O, Makefile_TOP_A
+#   Makefile_SUB_O, Makefile_SUB_A
+#   e_O, e_A
+#   * Despite A's rename of jump->leap, those renames are irrelevant.
+#   * Despite A's rename of basename/ -> basename/subdir/, those renames are
+#     irrelevant.
+#   * Because of A's rename of dir/ -> folder/ and B-dir's addition of
+#     newfile.* into dir/subdir/, we need to determine directory renames.
+#     (Technically, there are enough exact renames to determine directory
+#      rename detection, but the current implementation always does
+#      basename searching before directory rename detection.  Running it
+#      also before basename searching would mean doing directory rename
+#      detection twice, but it's a bit expensive to do that and cases like
+#      this are not all that common.)
+#   Summary: 1 fetches for 6 objects
+#
+test_expect_merge_algorithm failure failure 'Objects downloaded when a directory rename triggered' '
+	test_setup_repo &&
+	git clone --sparse --filter=blob:none "file://$(pwd)/server" objects-dir &&
+	(
+		cd objects-dir &&
+
+		git rev-list --objects --all --missing=print |
+			grep "^?" | sort >missing-objects-before &&
+
+		git checkout -q origin/A &&
+
+		GIT_TRACE2_PERF="$(pwd)/trace.output" git \
+			-c merge.directoryRenames=true merge --no-stat \
+			--no-progress origin/B-dir &&
+
+		# Check the number of objects we reported we would fetch
+		cat >expect <<-EOF &&
+		fetch_count:6
+		EOF
+		grep fetch_count trace.output | cut -d "|" -f 9 | tr -d " ." >actual &&
+		test_cmp expect actual &&
+
+		# Check the number of fetch commands exec-ed
+		grep d0.*fetch.negotiationAlgorithm trace.output >fetches &&
+		test_line_count = 1 fetches &&
+
+		git rev-list --objects --all --missing=print |
+			grep "^?" | sort >missing-objects-after &&
+		comm -2 -3 missing-objects-before missing-objects-after >old &&
+		comm -1 -3 missing-objects-before missing-objects-after >new &&
+		# No new missing objects
+		test_must_be_empty new &&
+		# Fetched 6 objects
+		test_line_count = 6 old
+	)
+'
+
+# Testcase: Objects downloaded with lots of renames and modifications
+#   Commit O:
+#              general/{leap1_O, leap2_O}
+#              basename/{numbers_O, sequence_O, values_O}
+#              dir/subdir/{a,b,c,d,e_O,Makefile_TOP_O}
+#              dir/subdir/tweaked/{f,g,h,Makefile_SUB_O}
+#              dir/unchanged/<LOTS OF FILES>
+#   Commit A:
+#     (Rename leap->jump, rename basename/ -> basename/subdir/, rename dir/
+#      -> folder/, move e into newsubdir, add newfile.rs, remove f, modify
+#      both both Makefiles and jumps)
+#              general/{jump1_A, jump2_A}
+#              basename/subdir/{numbers_A, sequence_A, values_A}
+#              folder/subdir/{a,b,c,d,Makefile_TOP_A}
+#              folder/subdir/newsubdir/{e_A,newfile.rs}
+#              folder/subdir/tweaked/{g,h,Makefile_SUB_A}
+#              folder/unchanged/<LOTS OF FILES>
+#   Commit B(-minimal):
+#     (modify both leaps, rename basename/ -> basename/subdir/, add
+#      newfile.{c,py})
+#              general/{leap1_B, leap2_B}
+#              basename/subdir/{numbers_B, sequence_B, values_B}
+#              dir/{a,b,c,d,e_O,Makefile_TOP_O,newfile.c}
+#              dir/tweaked/{f,g,h,Makefile_SUB_O,newfile.py}
+#              dir/unchanged/<LOTS OF FILES>
+#   Expected:
+#              general/{jump1_Merged, jump2_Merged}
+#              basename/subdir/{numbers_Merged, sequence_Merged, values_Merged}
+#              folder/subdir/{a,b,c,d,Makefile_TOP_A,newfile.c}
+#              folder/subdir/newsubdir/e_A
+#              folder/subdir/tweaked/{g,h,Makefile_SUB_A,newfile.py}
+#              folder/unchanged/<LOTS OF FILES>
+#
+# Objects that need to be fetched:
+#   Rename detection:
+#     Side1 (O->A):
+#       Basename-matches rename detection only needs to fetch these objects:
+#         numbers_O, numbers_A
+#         sequence_O, sequence_A
+#         values_O, values_A
+#         Makefile_TOP_O, Makefile_TOP_A
+#         Makefile_SUB_O, Makefile_SUB_A
+#         e_O, e_A
+#       General rename detection only needs to fetch these objects:
+#         leap1_O, leap2_O
+#         jump1_A, jump2_A, newfile.rs
+#         (only need remaining relevant sources, but any relevant sources need
+#          to be matched against all possible unpaired destinations)
+#     Side2 (O->B):
+#       Basename-matches rename detection only needs to fetch these objects:
+#         numbers_B
+#         sequence_B
+#         values_B
+#       (because numbers_O, sequence_O, and values_O already fetched above)
+#       General rename detection only needs to fetch these objects:
+#         <None>
+#   Merge:
+#     3-way content merge needs to grab these objects:
+#       leap1_B
+#       leap2_B
+#   Nothing else needs to fetch objects
+#
+#   Summary: 4 fetches (1 for 6 objects, 1 for 8, 1 for 3, 1 for 2)
+#
+test_expect_merge_algorithm failure failure 'Objects downloaded with lots of renames and modifications' '
+	test_setup_repo &&
+	git clone --sparse --filter=blob:none "file://$(pwd)/server" objects-many &&
+	(
+		cd objects-many &&
+
+		git rev-list --objects --all --missing=print |
+			grep "^?" | sort >missing-objects-before &&
+
+		git checkout -q origin/A &&
+
+		GIT_TRACE2_PERF="$(pwd)/trace.output" git \
+			-c merge.directoryRenames=true merge --no-stat \
+			--no-progress origin/B-many &&
+
+		# Check the number of objects we reported we would fetch
+		cat >expect <<-EOF &&
+		fetch_count:12
+		fetch_count:5
+		fetch_count:3
+		fetch_count:2
+		EOF
+		grep fetch_count trace.output | cut -d "|" -f 9 | tr -d " ." >actual &&
+		test_cmp expect actual &&
+
+		# Check the number of fetch commands exec-ed
+		grep d0.*fetch.negotiationAlgorithm trace.output >fetches &&
+		test_line_count = 4 fetches &&
+
+		git rev-list --objects --all --missing=print |
+			grep "^?" | sort >missing-objects-after &&
+		comm -2 -3 missing-objects-before missing-objects-after >old &&
+		comm -1 -3 missing-objects-before missing-objects-after >new &&
+		# No new missing objects
+		test_must_be_empty new &&
+		# Fetched 12 + 5 + 3 + 2 = 22 objects
+		test_line_count = 22 old
+	)
+'
+
+test_done
-- 
gitgitgadget

