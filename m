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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE28C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E336660F9D
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347726AbhIUCVl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236465AbhIUBuT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:50:19 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A620BC07E5C3
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 15:15:17 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q11so33730118wrr.9
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 15:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NNnWulhxCRafjPQevx0rNtqzkNiEkXLvwc0u772NMxI=;
        b=YcVRueMKaRiK5nUlZZU/WNFojgmM8pKgEAzazrTM3XLijWubSxPp7TryIPKLtisa4w
         2cKFAu6ujwsUVmP7XkwC8ywuwLJuiHlcIDB9SMsYy86qY8fuR7yKC+YrwNF0f59yQcSM
         DUa/LRl7z+pHSeRlh6FlshC9LyKf8i4z3TAmlTrB1vHgk77M94sRdzPmRTzviqmsRAP/
         9vk+vZbno+6M3pLiXg96d306ikVa5iq3urOOdsIgvecF7ddgenWdDDnXX6h9qGZZbJsn
         64yUuQO6WCBfi7E38jQgiSE91El3D4FuTwxbkkHFBKKxrNF/WO2CA1x1YOIS7hA0qWEx
         5b+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NNnWulhxCRafjPQevx0rNtqzkNiEkXLvwc0u772NMxI=;
        b=o0h07OMGeBtuPFjnAtFOHNF8Wmlj2+OJgfzVyGSg89WwIZHUCy9PKaHyf8PZdm2RH4
         n0VYBv1e6BqY1U+QonwTw5gqAMmpsaFBn/k1/xYSdCPZvGzlzTyCIrCIX6heIul8kQ2T
         dODAUhgZKfFA+jS/zKJWPOJZknxtUikQJAwQEP7lO9YbcWIhfLiJuBnaU4MEi5On/7T2
         dAewUURxRijRdhMn5eQtlxD+DxGSYBKH1ziKblTID3tOfB6YhHGZMRblSXRbTtJbgh53
         txYYzkjJAfq3HSj4LsomZJe2rg90eUc3dFagel2f6rdlto7ob8uRWXPg0iX/b6OOpxYI
         G6kQ==
X-Gm-Message-State: AOAM531p15cO/0L1BbjtMQAX6FKZgvcyMIm++VHeZbSSkLYovlANvGs2
        V1REs8q/FjHGn6KT188qM7GBjBKXfsc=
X-Google-Smtp-Source: ABdhPJzHFXZs+BGv2YbWCRgaSFvU16KUtodfD1/0A1cMGua9joKYLbliSVogVlEt1SqUES1TM2z9FA==
X-Received: by 2002:a7b:c014:: with SMTP id c20mr1207390wmb.81.1632176116319;
        Mon, 20 Sep 2021 15:15:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o1sm17009773wru.91.2021.09.20.15.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 15:15:15 -0700 (PDT)
Message-Id: <afb0028e79648c1f7be8d77df5c6d675bd27d983.1632176111.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v4.git.git.1632176111.gitgitgadget@gmail.com>
References: <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
        <pull.1076.v4.git.git.1632176111.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 22:15:10 +0000
Subject: [PATCH v4 5/6] core.fsyncobjectfiles: tests for batch mode
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

Add test cases to exercise batch mode for 'git add'
and 'git stash'. These tests ensure that the added
data winds up in the object database.

I verified the tests by introducing an incorrect rename
in do_sync_and_rename.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 t/lib-unique-files.sh | 34 ++++++++++++++++++++++++++++++++++
 t/t3700-add.sh        | 11 +++++++++++
 t/t3903-stash.sh      | 14 ++++++++++++++
 3 files changed, 59 insertions(+)
 create mode 100644 t/lib-unique-files.sh

diff --git a/t/lib-unique-files.sh b/t/lib-unique-files.sh
new file mode 100644
index 00000000000..a8a25eba61d
--- /dev/null
+++ b/t/lib-unique-files.sh
@@ -0,0 +1,34 @@
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
+#				    each in the specified directory, all
+#				    with unique contents.
+
+test_create_unique_files() {
+	test "$#" -ne 3 && BUG "3 param"
+
+	local dirs=$1
+	local files=$2
+	local basedir=$3
+
+	rm -rf $basedir >/dev/null
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
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 4086e1ebbc9..2122acc3e9e 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -7,6 +7,8 @@ test_description='Test of git add, including the -- option.'
 
 . ./test-lib.sh
 
+. $TEST_DIRECTORY/lib-unique-files.sh
+
 # Test the file mode "$1" of the file "$2" in the index.
 test_mode_in_index () {
 	case "$(git ls-files -s "$2")" in
@@ -33,6 +35,15 @@ test_expect_success \
     'Test that "git add -- -q" works' \
     'touch -- -q && git add -- -q'
 
+test_expect_success 'git add: core.fsyncobjectfiles=batch' "
+	test_create_unique_files 2 4 fsync-files &&
+	git -c core.fsyncobjectfiles=batch add -- ./fsync-files/ &&
+	rm -f fsynced_files &&
+	git ls-files --stage fsync-files/ > fsynced_files &&
+	test_line_count = 8 fsynced_files &&
+	cat fsynced_files | awk '{print \$2}' | xargs -n1 git cat-file -e
+"
+
 test_expect_success \
 	'git add: Test that executable bit is not used if core.filemode=0' \
 	'git config core.filemode 0 &&
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 873aa56e359..0b4e8bb55b8 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -9,6 +9,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
+. $TEST_DIRECTORY/lib-unique-files.sh
 
 diff_cmp () {
 	for i in "$1" "$2"
@@ -1293,6 +1294,19 @@ test_expect_success 'stash handles skip-worktree entries nicely' '
 	git rev-parse --verify refs/stash:A.t
 '
 
+test_expect_success 'stash with core.fsyncobjectfiles=batch' "
+	test_create_unique_files 2 4 fsync-files &&
+	git -c core.fsyncobjectfiles=batch stash push -u -- ./fsync-files/ &&
+	rm -f fsynced_files &&
+
+	# The files were untracked, so use the third parent,
+	# which contains the untracked files
+	git ls-tree -r stash^3 -- ./fsync-files/ > fsynced_files &&
+	test_line_count = 8 fsynced_files &&
+	cat fsynced_files | awk '{print \$3}' | xargs -n1 git cat-file -e
+"
+
+
 test_expect_success 'stash -c stash.useBuiltin=false warning ' '
 	expected="stash.useBuiltin support has been removed" &&
 
-- 
gitgitgadget

