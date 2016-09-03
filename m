Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 027B11F6BF
	for <e@80x24.org>; Sat,  3 Sep 2016 23:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbcICXVc (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Sep 2016 19:21:32 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35956 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751689AbcICXVb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Sep 2016 19:21:31 -0400
Received: by mail-qk0-f193.google.com with SMTP id v123so10183525qkh.3
        for <git@vger.kernel.org>; Sat, 03 Sep 2016 16:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=mJPIuRiTa18y2RnHYS6luSVj8LJQQI/ZUnKgR8U1288=;
        b=gBs7mylF4mit+vpKDf6XGuCNmvUyMHQl9rVN5KKUS9RZNnCMvPzxlm1QWQgtOAQZ74
         7xX6ziFyyc01WQmG5lYDIbGzJe94pO1TYZ0oN7Gk4liteTwzShrhxz0qT2KfdVRYl/UV
         Du9X8wxzEb+gvsLU1aBkabY5S2veYUDirbfP5knvYcBIzcjAV4ewnx98GSPCwfoJw9O4
         vQrOeU0AV6AHNmWkwI0gf5qzz7USo8Rv+8wRgQjy2ET/mMg75zdXotoLYvX7Ntu/Z/Kx
         wLvwIEvyhb6H0i2OG6MoTWDRA3udC5rXRnQ1rVM9+ZdhBvaQYJ5GbRrZkjCikyBuqvJt
         sPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=mJPIuRiTa18y2RnHYS6luSVj8LJQQI/ZUnKgR8U1288=;
        b=bxZ4dMZ1lPiex5Z+SqGpnrICneYpQX6lhfF4U9FBd5ixL8AoLkKbMGEDRNOroXELEQ
         Pi5+ep4+QYUV7gfOAX64f2hlYTjHgejwYqAJE1ZY6yS+F+KM/Hsqy/aVRoacqNeUnlgX
         eyMCaIIrqG2GEVIpxK4GCUVFkkSWvM15S86o341mmANMq/PivTM++VGAPHdZNp0PmL6u
         wqid9UQE7GlTh1MLAn/aycNXJDlfcu4Gm7IwncxJ8DEkC4lUfy/422piYFxh2af4alhV
         +AIQytC6XpbRBJcuCc8ODI9Rvu2isgG5nw4vKMA531TRgWZklbwfPfXAb7BCpioxtYe0
         qiqg==
X-Gm-Message-State: AE9vXwOFCXqplUTaFfraeLaIc2mblEa05fMW8IKkBYqwCTR56SCyLGwJwq3ZW2zB+akoYQ==
X-Received: by 10.55.8.2 with SMTP id 2mr33146394qki.198.1472944890572;
        Sat, 03 Sep 2016 16:21:30 -0700 (PDT)
Received: from localhost.localdomain (cpe-66-67-97-212.nycap.res.rr.com. [66.67.97.212])
        by smtp.googlemail.com with ESMTPSA id j67sm10253117qkf.41.2016.09.03.16.21.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Sep 2016 16:21:29 -0700 (PDT)
Message-ID: <1472944878.19860.4.camel@gmail.com>
Subject: [PATCH] stash: allow ref of a stash by index
From:   Aaron M Watson <watsona4@gmail.com>
To:     git@vger.kernel.org
Cc:     Jon Seymour <jon.seymour@gmail.com>,
        David Caldwell <david@porkrind.org>,
        =?ISO-8859-1?Q?=D8ystein?= Walle <oystwa@gmail.com>,
        Jeff King <peff@peff.net>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>
Date:   Sat, 03 Sep 2016 19:21:18 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allows stashes to be referenced by index only. Instead of referencing
"stash@{n}" explicitly, it can simply be referenced as "n".

Signed-off-by: Aaron M Watson <watsona4@gmail.com>
---
 Documentation/git-stash.txt | 11 ++++---
 git-stash.sh                | 10 +++++-
 t/t3907-stash-index.sh      | 77
+++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+), 6 deletions(-)
 create mode 100755 t/t3907-stash-index.sh

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 92df596..af11cff 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -35,11 +35,12 @@ A stash is by default listed as "WIP on
'branchname' ...", but
 you can give a more descriptive message on the command line when
 you create one.
 
-The latest stash you created is stored in `refs/stash`; older
-stashes are found in the reflog of this reference and can be named using
-the usual reflog syntax (e.g. `stash@{0}` is the most recently
-created stash, `stash@{1}` is the one before it, `stash@{2.hours.ago}`
-is also possible).
+The latest stash you created is stored in `refs/stash`; older stashes
+are found in the reflog of this reference and can be named using the
+usual reflog syntax (e.g. `stash@{0}` is the most recently created
+stash, `stash@{1}` is the one before it, `stash@{2.hours.ago}` is also
+possible). Stashes may also be references by specifying just the stash
+index (e.g. the integer `n` is equivalent to `stash@{n}`).
 
 OPTIONS
 -------
diff --git a/git-stash.sh b/git-stash.sh
index 826af18..a0c7f12 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # Copyright (c) 2007, Nanako Shiraishi
 
 dashless=$(basename "$0" | sed -e 's/-/ /')
@@ -371,6 +371,14 @@ parse_flags_and_rev()
 	test "$PARSE_CACHE" = "$*" && return 0 # optimisation
 	PARSE_CACHE="$*"
 
+	args=()
+	for arg
+	do
+		[[ $arg =~ ^[0-9]+$ ]] && arg="stash@{$arg}"
+		args+=("$arg")
+	done
+	set -- "${args[@]}"
+
 	IS_STASH_LIKE=
 	IS_STASH_REF=
 	INDEX_OPTION=
diff --git a/t/t3907-stash-index.sh b/t/t3907-stash-index.sh
new file mode 100755
index 0000000..72a1838
--- /dev/null
+++ b/t/t3907-stash-index.sh
@@ -0,0 +1,77 @@
+#!/bin/sh
+#
+# Copyright (c) 2016 Aaron M. Watson
+#
+
+test_description='Test git stash with index ref specification'
+
+. ./test-lib.sh
+
+test_expect_success 'stash some dirty working directory' '
+	echo 1 > file &&
+	git add file &&
+	echo unrelated >other-file &&
+	git add other-file &&
+	test_tick &&
+	git commit -m initial &&
+	echo 2 > file &&
+	git add file &&
+	echo 3 > file &&
+	test_tick &&
+	git stash &&
+	git diff-files --quiet &&
+	git diff-index --cached --quiet HEAD
+'
+
+cat > expect << EOF
+diff --git a/file b/file
+index 0cfbf08..00750ed 100644
+--- a/file
++++ b/file
+@@ -1 +1 @@
+-2
++3
+EOF
+
+test_expect_success 'applying bogus stash does nothing' '
+	test_must_fail git stash apply 1 &&
+	echo 1 >expect &&
+	test_cmp expect file
+'
+
+test_expect_success 'drop middle stash' '
+	git reset --hard &&
+	echo 8 > file &&
+	git stash &&
+	echo 9 > file &&
+	git stash &&
+	git stash drop 1 &&
+	test 2 = $(git stash list | wc -l) &&
+	git stash apply &&
+	test 9 = $(cat file) &&
+	test 1 = $(git show :file) &&
+	test 1 = $(git show HEAD:file) &&
+	git reset --hard &&
+	git stash drop &&
+	git stash apply &&
+	test 3 = $(cat file) &&
+	test 1 = $(git show :file) &&
+	test 1 = $(git show HEAD:file)
+'
+
+test_expect_success 'invalid ref of the form "n", where n >= N' '
+	git stash clear &&
+	test_must_fail git stash drop 0 &&
+	echo bar5 > file &&
+	echo bar6 > file2 &&
+	git add file2 &&
+	git stash &&
+	test_must_fail git stash drop 1 &&
+	test_must_fail git stash pop 1 &&
+	test_must_fail git stash apply 1 &&
+	test_must_fail git stash show 1 &&
+	test_must_fail git stash branch tmp 1 &&
+	git stash drop
+'
+
+test_done
-- 
2.7.4
