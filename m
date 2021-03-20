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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FD4C433E4
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 00:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75D606198D
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 00:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhCTAEm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 20:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhCTAEC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 20:04:02 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980C5C061760
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 17:04:02 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e9so10741197wrw.10
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 17:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XXkada0tjiFQqfS5wUUxv6rDq4t4jraSD+9f2/tJEHk=;
        b=I1uYj36ygVoeGoLxiyWLDBuK6QcAuwzvZk3PejbKI7/1cgQvp05WVFyZkZuPQm8c7q
         K6qSMjhm59fws14cOppQBHqh3qQNEBOpNBkul63AvZoUiVyfIdzbvRqqZu642xwBnq0v
         oamFaR+gvWwpTOk1piTLysR11dBu7jztzlPeMRAuW9rXlYYAtSX07vdetKhS7K2pSWYK
         5TEtViLbbtSsCn79DJw0IKiivBvCovqWtFZBLareoT4LdjoigvBoDZkc/y1OOx8XImWK
         gkdG98Uu9+fn+fW2Zi0G5+kI8gLRZjcFlBpHTUIlXkhkUIGeXmochKaWDSk7k/Y4aJ1G
         6TNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XXkada0tjiFQqfS5wUUxv6rDq4t4jraSD+9f2/tJEHk=;
        b=IpNJ0KJwzc+fXmkWIlo7ep4vJwc/MR1oimXPAHMGyIAq6Vxa8xnrErb1Kiz/StTQVE
         NjOtZg45TVV2/QHjgLtJoCJApBrjwihLPqKYI3jen1QMQ+DFBElWfcCn0Wo5wIa8oZPm
         9FQsPeRtQ4Hyn+z6L1+AbKCg35bbLj6cfJux8AfEKdzmYzbFpMPO64vUUh+H4OUNkCLn
         zI/GsmEOapG2UOplqam0FcFPCBove+phHj2vhs23M800AUrM8yRSC0U+XWMblyClZE+R
         hSh3uoSkcSdzrubVjMaEHQOMcO/22nk0BZcSMC94OWHS+fEyE6e0aZFFcIQb94YIPVMa
         lVCw==
X-Gm-Message-State: AOAM533UMUHggInHp7Sv7ACZGK18BOv3hZZ7iRbWEXc222VO9KtKIyu/
        qdjO7SfLdXOa1ZuCwIrC+KbAn82QFRE=
X-Google-Smtp-Source: ABdhPJzQ4bpsnqk7Sb4bxkyW1IGXI65cIJEOMugwLm9HVNzDgFGUC86k49738XtrxVa6/eYK5Byrpg==
X-Received: by 2002:adf:fb05:: with SMTP id c5mr7200274wrr.302.1616198641452;
        Fri, 19 Mar 2021 17:04:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c8sm8044049wmb.34.2021.03.19.17.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 17:04:01 -0700 (PDT)
Message-Id: <6aec1f499b8068329b81fb1221717c2ee336fd8d.1616198636.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.905.v3.git.1616198636.gitgitgadget@gmail.com>
References: <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
        <pull.905.v3.git.1616198636.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 20 Mar 2021 00:03:49 +0000
Subject: [PATCH v3 06/13] t6428: new test for SKIP_WORKTREE handling and
 conflicts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
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

