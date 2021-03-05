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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B6CC433DB
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 00:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AC3E6500A
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 00:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbhCEAzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 19:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhCEAzp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 19:55:45 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AD6C061762
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 16:55:44 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id f12so227558wrx.8
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 16:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XXkada0tjiFQqfS5wUUxv6rDq4t4jraSD+9f2/tJEHk=;
        b=VtiUjj6o/39d0dJgZ0CcYycu5U3CU+IslD65EiPU7nhOrnw6KANyGodCaiCKMZqeb0
         BVrE9n9LhlOfBsCRy8sFTsdI5IGiCEDIZWiecX3CINPW7belopR/Zxtn0lbN74f4r0Ee
         MmIxf15+1dAtigGUEqTNJcrpJYiBXDx/PI9SQ+JVvMSOmyDkC0qJ2HZDtqYRZ//Djnr7
         76kHvDZj3oxJ73M0LpKPi3LtYWJI7jmXZQjrj5pguPHEeb3t9bmB0TBZsn+LcPzT3fAS
         cc5vBCcyMSLcSphg+0MEi4omA1ud3MHWd+sycwIEHtgKC+N/DcgkP1P+uUZ7bR7Iy7fQ
         wsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XXkada0tjiFQqfS5wUUxv6rDq4t4jraSD+9f2/tJEHk=;
        b=qKA/iLIWEFD5KRbWs/cXjoBk6PfRYaxGXeB416RxhyLZvMZVafWe4GLRuarEo6c/Rk
         aGrejdOODqEJMFzB8c4NgggGdDvwzv7J20rZl5DbnU3j1kPiv08pwt44EZAHQs0zA+hp
         QTI6rGxToMw1gyR8cBNtm7ipttDztSQVHU2fx0xjhtWMp7joXSB9PIIyAHHcAkQLkjhQ
         jZZ/+mlMMrvMCTsAeLqiF1DB5Q2fd31Vm1l+9rIgsv7i57ogtw/aluV/BERUY0950jq/
         0T5/Od67zmdPqv7AkWa7OB6lhFqO9Id+gfvve7VIVVptsctYJbjEfgoOiFdudhu29HCA
         RDsw==
X-Gm-Message-State: AOAM530IBcTOHOQ6VAlUfWkMj8jSyEwLtRGz7Y8xqiIVcICCs1qZV5pQ
        jRDoNNwhb8gtfhezOAo6b5oe/pdbRYQ=
X-Google-Smtp-Source: ABdhPJwMVw3C7RZQkYO+v0Wt+5XZkTRwxQ+of2cGa9Y4Hsw0V2YTOhStkBsJO7uAAZq+GVg/yGRK3w==
X-Received: by 2002:adf:f905:: with SMTP id b5mr6305896wrr.129.1614905743160;
        Thu, 04 Mar 2021 16:55:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i26sm1825621wmb.18.2021.03.04.16.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 16:55:42 -0800 (PST)
Message-Id: <6ccb24b557fc9c9d8e3d307d3e142d8393920414.1614905738.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Mar 2021 00:55:33 +0000
Subject: [PATCH 07/11] t6428: new test for SKIP_WORKTREE handling and
 conflicts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

If there is a conflict during a merge for a SKIP_WORKTREE entry, we
expect that file to be written to the working copy and have the
SKIP_WORKTREE bit cleared in the index.  If the user had manually
created a file in the working tree despite SKIP_WORKTREE being set, we
do not want to clobber their changes to that file, but want to move it
out of the way.  Add tests that check for these behaviors.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6428-merge-conflicts-sparse.sh | 158 ++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)
 create mode 100755 t/t6428-merge-conflicts-sparse.sh

diff --git a/t/t6428-merge-conflicts-sparse.sh b/t/t6428-merge-conflicts-sparse.sh
new file mode 100755
index 000000000000..1bb52ff6f38c
--- /dev/null
+++ b/t/t6428-merge-conflicts-sparse.sh
@@ -0,0 +1,158 @@
+#!/bin/sh
+
+test_description="merge cases"
+
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
+
+# Testcase basic, conflicting changes in 'numerals'
+
+test_setup_numerals () {
+	test_create_repo numerals_$1 &&
+	(
+		cd numerals_$1 &&
+
+		>README &&
+		test_write_lines I II III >numerals &&
+		git add README numerals &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		test_write_lines I II III IIII >numerals &&
+		git add numerals &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		test_write_lines I II III IV >numerals &&
+		git add numerals &&
+		test_tick &&
+		git commit -m "B" &&
+
+		cat <<-EOF >expected-index &&
+		H README
+		M numerals
+		M numerals
+		M numerals
+		EOF
+
+		cat <<-EOF >expected-merge
+		I
+		II
+		III
+		<<<<<<< HEAD
+		IIII
+		=======
+		IV
+		>>>>>>> B^0
+		EOF
+
+	)
+}
+
+test_expect_merge_algorithm success failure 'conflicting entries written to worktree even if sparse' '
+	test_setup_numerals plain &&
+	(
+		cd numerals_plain &&
+
+		git checkout A^0 &&
+
+		test_path_is_file README &&
+		test_path_is_file numerals &&
+
+		git sparse-checkout init &&
+		git sparse-checkout set README &&
+
+		test_path_is_file README &&
+		test_path_is_missing numerals &&
+
+		test_must_fail git merge -s recursive B^0 &&
+
+		git ls-files -t >index_files &&
+		test_cmp expected-index index_files &&
+
+		test_path_is_file README &&
+		test_path_is_file numerals &&
+
+		test_cmp expected-merge numerals &&
+
+		# 4 other files:
+		#   * expected-merge
+		#   * expected-index
+		#   * index_files
+		#   * others
+		git ls-files -o >others &&
+		test_line_count = 4 others
+	)
+'
+
+test_expect_merge_algorithm failure failure 'present-despite-SKIP_WORKTREE handled reasonably' '
+	test_setup_numerals in_the_way &&
+	(
+		cd numerals_in_the_way &&
+
+		git checkout A^0 &&
+
+		test_path_is_file README &&
+		test_path_is_file numerals &&
+
+		git sparse-checkout init &&
+		git sparse-checkout set README &&
+
+		test_path_is_file README &&
+		test_path_is_missing numerals &&
+
+		echo foobar >numerals &&
+
+		test_must_fail git merge -s recursive B^0 &&
+
+		git ls-files -t >index_files &&
+		test_cmp expected-index index_files &&
+
+		test_path_is_file README &&
+		test_path_is_file numerals &&
+
+		test_cmp expected-merge numerals &&
+
+		# There should still be a file with "foobar" in it
+		grep foobar * &&
+
+		# 5 other files:
+		#   * expected-merge
+		#   * expected-index
+		#   * index_files
+		#   * others
+		#   * whatever name was given to the numerals file that had
+		#     "foobar" in it
+		git ls-files -o >others &&
+		test_line_count = 5 others
+	)
+'
+
+test_done
-- 
gitgitgadget

