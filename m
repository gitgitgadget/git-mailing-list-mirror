Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BF2C433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 04:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356703AbiFVEVd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 00:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356711AbiFVEVb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 00:21:31 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16427654
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 21:21:30 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j24so881419wrb.11
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 21:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XitRwais8ji78kTDLUZRsP+0BnKtCqLis4kGkc144SI=;
        b=LzC1YvuVIXh/dI++pCeYQfqCFSOolbkFSglYlKqC2cwDCTq8oB+HM8Ad4DYEr946GK
         LQ27Z+BmpOm5d8C60eSROrMO9MbYUNfCmgGHbLWpAMHwF3bkW9ddAcDSBHaQk7HBiSV+
         jmg27Psev0Igzu1PP090FipdDCGgPHuCDbQtRyReBSkMBdW3ecekywSgKklVvLS/o9iC
         vwXFqTTdhBCSjCOB2ufSXFRUG2YUxfEZgvwXpwzrfHbryq5S1B3Vput/nAKq3Cxb26hK
         eovyWjfo6ggGDNAvB6GJ6ubVgS34hLRGobABXto5pEp76mjD6hS03lT7bf0w9aprURpy
         qnsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XitRwais8ji78kTDLUZRsP+0BnKtCqLis4kGkc144SI=;
        b=dSUqBSYlVX88qWnRim/k8nGZx1Cz0gvkv5o0wkxmswtyykTg1RCwLDxmXPk8ldFqgD
         LOaEX42Ac72Po/sZjEgSm/x5raED4S1ucFkPCoHEFJBXVTJihkNCs0zGq4Zhiwzlmnir
         QhKvAKOXIrGrQ9HKtNdOB8A8AM9Jla6CWM7JpoFt4U2aFIqkqo4ez+8LB5APiS5fsrs6
         qLzBJdkXfnBWpiP/yz+H0im+7jM/+NSLxJceqXz4y2lEsCK3HTQD457mk5KJLe9WfD0n
         eStU9VGboDuEfkq3ysx7ukn/L9q8VNHoyJyaP9aL8CToqNMkk0nhgEj7+jep9EXClb4L
         h5Kw==
X-Gm-Message-State: AJIora/RwqEqQMm4d2nYmNAswlktoY3YAab7e+evIhyoaXJBUGJs49K+
        Pci/He4dTQn/zVMemDeYOEmeaTI6Izdkkw==
X-Google-Smtp-Source: AGRyM1szDWdbsvnJ3f+A3jwgoVrKVOUmG2YsLL2fGiDgTsUNlUjK3QuIbpxy3AgGLUng4Ijw/qwl6g==
X-Received: by 2002:a5d:5e92:0:b0:21a:278c:b901 with SMTP id ck18-20020a5d5e92000000b0021a278cb901mr1132995wrb.461.1655871688995;
        Tue, 21 Jun 2022 21:21:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n37-20020a05600c502500b0039c5cecf206sm21027877wmr.4.2022.06.21.21.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 21:21:19 -0700 (PDT)
Message-Id: <69d6204184363e491acb68f744ded0991be63a47.1655871652.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1268.git.1655871651.gitgitgadget@gmail.com>
References: <pull.1268.git.1655871651.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Jun 2022 04:20:49 +0000
Subject: [PATCH 1/3] t6423: add tests of dual directory rename plus add/add
 conflict
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This is an attempt at minimalizing a testcase reported by Glen Choo
with tensorflow where merge-ort would report an assertion failure:

    Assertion failed: (ci->filemask == 2 || ci->filemask == 4), function apply_directory_rename_modifications, file merge-ort.c, line 2410

reversing the direction of the merge provides a different error:

    error: cache entry has null sha1: ...
    fatal: unable to write .git/index

so we add testcases for both.  With these new testcases, the
recursive strategy differs in that it returns the latter error for
both merge directions.

These testcases are somehow a little different than Glen's original
tensorflow testcase in that these ones trigger a bug with the recursive
algorithm whereas his testcase didn't.  I figure that means these
testcases somehow manage to be more comprehensive.

Reported-by: Glen Choo <chooglen@google.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6423-merge-rename-directories.sh | 102 ++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 479db32cd62..296c04f8046 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -5199,6 +5199,108 @@ test_expect_success '12k: Directory rename with sibling causes rename-to-self' '
 	)
 '
 
+# Testcase 12l, Both sides rename a directory into the other side, both add
+#   a file with after directory renames are the same filename
+#   Commit O: sub1/file,                 sub2/other
+#   Commit A: sub3/file,                 sub2/{other, new_add_add_file_1}
+#   Commit B: sub1/{file, newfile}, sub1/sub2/{other, new_add_add_file_2}
+#
+#   In words:
+#     A: sub1/ -> sub3/, add sub2/new_add_add_file_1
+#     B: sub2/ -> sub1/sub2, add sub1/newfile, add sub1/sub2/new_add_add_file_2
+#
+#   Expected: sub3/{file, newfile, sub2/other}
+#             CONFLICT (add/add): sub3/sub2/new_add_add_file
+
+test_setup_12l () {
+	test_create_repo 12l_$1 &&
+	(
+		cd 12l_$1 &&
+
+		mkdir -p sub1 sub2
+		echo file >sub1/file &&
+		echo other >sub2/other &&
+		git add sub1 sub2 &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv sub1 sub3 &&
+		echo conflicting >sub2/new_add_add_file &&
+		git add sub2 &&
+		test_tick &&
+		git add -u &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		echo dissimilar >sub2/new_add_add_file &&
+		echo brand >sub1/newfile &&
+		git add sub1 sub2 &&
+		git mv sub2 sub1 &&
+		test_tick &&
+		git commit -m "B"
+	)
+}
+
+test_expect_merge_algorithm failure failure '12l (B into A): Rename into each other + add/add conflict' '
+	test_setup_12l BintoA &&
+	(
+		cd 12l_BintoA &&
+
+		git checkout -q A^0 &&
+
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 &&
+
+		git ls-files -s >out &&
+		test_line_count = 5 out &&
+
+		git rev-parse >actual \
+			:0:sub3/file :0:sub3/newfile :0:sub3/sub2/other \
+			:2:sub1/sub2/new_add_add_file \
+			:3:sub1/sub2/new_add_add_file &&
+		git rev-parse >expect \
+			O:sub1/file  B:sub1/newfile O:sub2/other \
+			A:sub2/new_add_add_file \
+			B:sub1/sub2/new_add_add_file &&
+		test_cmp expect actual &&
+
+		git ls-files -o >actual &&
+		test_write_lines actual expect out >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_merge_algorithm failure failure '12l (A into B): Rename into each other + add/add conflict' '
+	test_setup_12l AintoB &&
+	(
+		cd 12l_AintoB &&
+
+		git checkout -q B^0 &&
+
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive A^0 &&
+
+		git ls-files -s >out &&
+		test_line_count = 5 out &&
+
+		git rev-parse >actual \
+			:0:sub3/file :0:sub3/newfile :0:sub3/sub2/other \
+			:2:sub1/sub2/new_add_add_file \
+			:3:sub1/sub2/new_add_add_file &&
+		git rev-parse >expect \
+			O:sub1/file  B:sub1/newfile O:sub2/other \
+			B:sub1/sub2/new_add_add_file \
+			A:sub2/new_add_add_file &&
+		test_cmp expect actual &&
+
+		git ls-files -o >actual &&
+		test_write_lines actual expect out >expect &&
+		test_cmp expect actual
+	)
+'
+
 ###########################################################################
 # SECTION 13: Checking informational and conflict messages
 #
-- 
gitgitgadget

