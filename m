Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E79C433FE
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 00:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbiCRAfk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 20:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiCRAfd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 20:35:33 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF57E2467F1
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 17:34:14 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a1so8308317wrh.10
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 17:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CyWtVXGn6WnRp/Hq3UFmejuCjJIyra+FTQAh+1KvyMM=;
        b=ljKXcUT80ZS/8lJr730TGdCo5tpdW6kADrJDte4Q0WFgz/fD3lC8IQSGHGrLJDMGkG
         iv7y1oVa8WClqnyA7ckpoGMacincgczYge5H1bY8SQp/nM73U75aqVcLuS5QHEwK2o3G
         hKAMSGEymx7hivYjAYcVSYD3sGZXV9CCNyuHDHiAIRBYYHIEMC29CJWXPc/OKUBa8BwU
         +PR8nQDPEe3x5kVbd0STQMG1ML4ha/pK0bk0py63BFQJbd7ArvI7nRkd8C4c3PzvJctk
         k/R4f0dSPuIm74MgldlwRsmj+6ZtEBGRnLiKpm1YR2X4vcQQ/q8DmOa/boty9C9bjy4h
         85yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CyWtVXGn6WnRp/Hq3UFmejuCjJIyra+FTQAh+1KvyMM=;
        b=Xij7i2pigxBQAz5aPuxr33b8fKkkKFfUvfIXL2ucXjghUW2KJkGIkPnzvykEigOebD
         ZP0brnGTWjBuJciEA6sK8evbBXAFs8Ge8bTtk7RjkvoBrcbPmXMnSLoGmDJ3hBYUIDYI
         eGXgFIApi9eV86pHyM8TaB8MkQsP6o4QQMZxrNJ0OePOHNlJWdmYBywZ8TxWyN/jz8xR
         ma5Cu9DWQxc76TjCtp38pV2zE74S1NNCFp7Ig2Li+pRZY0IzJioHqzqvaomIMNOl7HF3
         sgw5P44bbxT9vYKdFLGx6S8Lqw5LM2+nvUD3830jF4g1vWwUwR6X//mWN+HvKoN5sxPg
         uSMA==
X-Gm-Message-State: AOAM533sd0wrE1JpDzb0RdNdXoysXHPr+KXsaTl2sxkF9CmfsfC7+suM
        YimT9HjPLSQ+Hnox04DqmCVPoucbKz1WjA==
X-Google-Smtp-Source: ABdhPJxl/wXLEAMY9+q1sFbg8L1WpU0yWa4wenUuyk3JNntmGdI6bn6r+hj47xqNWynD4/VUi2+W/g==
X-Received: by 2002:a05:6000:184e:b0:1f0:3569:ccac with SMTP id c14-20020a056000184e00b001f03569ccacmr6170604wri.680.1647563653146;
        Thu, 17 Mar 2022 17:34:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l4-20020adff484000000b00203dde8d82bsm5096548wro.88.2022.03.17.17.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 17:34:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/7] test-lib-functions: add and use a "todo_test_cmp" helper
Date:   Fri, 18 Mar 2022 01:33:59 +0100
Message-Id: <patch-4.7-25a4dadd5f3-20220318T002951Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1436.g756b814e59f
In-Reply-To: <cover-0.7-00000000000-20220318T002951Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20220318T002951Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a new "todo_test_cmp" for use with the new
"test_expect_todo" function. This is a thin wrapper around the
previously introduced "test_todo". Instead of the more verbose:

    test_todo test_cmp --want want --expect expect -- actual

We can now do:

    todo_test_cmp want expect actual

Since it uses "test_todo", this "test_cmp_todo" function will BUG()
out if "want" and "expect" are the same, and likewise if the "want" is
equivalent to "actual".

Let's convert most of the tests added in 45bde58ef8f (grep:
demonstrate bug with textconv attributes and submodules, 2021-09-29)
to use it, as well as a merge test added in
6d49de414f9 (t6023-merge-file.sh: fix and mark as broken invalid
tests, 2014-06-29).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6403-merge-file.sh              | 23 +++++++++++--
 t/t7814-grep-recurse-submodules.sh | 54 +++++++++++++++++++++---------
 t/test-lib-functions.sh            | 22 ++++++++++++
 3 files changed, 81 insertions(+), 18 deletions(-)

diff --git a/t/t6403-merge-file.sh b/t/t6403-merge-file.sh
index 12b334af85c..d466360c41a 100755
--- a/t/t6403-merge-file.sh
+++ b/t/t6403-merge-file.sh
@@ -92,8 +92,27 @@ test_expect_todo "merge without conflict (missing LF at EOF)" '
 		git merge-file test2.txt orig.txt new4.txt
 '
 
-test_expect_failure "merge result added missing LF" '
-	test_cmp test.txt test2.txt
+test_expect_todo "merge result added missing LF" '
+	cat >expect <<-\EOF &&
+	Dominus regit me, et nihil mihi deerit.
+	In loco pascuae ibi me collocavit,
+	super aquam refectionis educavit me;
+	animam meam convertit,
+	deduxit me super semitas jusitiae,
+	<<<<<<< test2.txt
+	<<<<<<< test2.txt
+	propter nomen suum.
+	Nam et si ambulavero in medio umbrae mortis,
+	non timebo mala, quoniam tu mecum es:
+	virga tua et baculus tuus ipsa me consolata sunt.
+	=======
+	propter nomen suum.
+	>>>>>>> new4.txt
+	=======
+	propter nomen suum.
+	>>>>>>> new4.txt
+	EOF
+	todo_test_cmp test.txt expect test2.txt
 '
 
 test_expect_success "merge without conflict (missing LF at EOF, away from change in the other file)" '
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index a4476dc4922..8d9b53ccfed 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -442,77 +442,98 @@ test_expect_success 'grep --recurse-submodules with --cached ignores worktree mo
 	test_must_be_empty actual
 '
 
-test_expect_failure 'grep --textconv: superproject .gitattributes does not affect submodules' '
+test_expect_todo 'grep --textconv: superproject .gitattributes does not affect submodules' '
 	reset_and_clean &&
 	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
 	echo "a diff=d2x" >.gitattributes &&
 
+	cat >want <<-\EOF &&
+	a:(1|2)x(3|4)
+	EOF
 	cat >expect <<-\EOF &&
 	a:(1|2)x(3|4)
+	submodule/a:(1|2)x(3|4)
+	submodule/sub/a:(1|2)x(3|4)
 	EOF
 	git grep --textconv --recurse-submodules x >actual &&
-	test_cmp expect actual
+	todo_test_cmp want expect actual
 '
 
-test_expect_failure 'grep --textconv: superproject .gitattributes (from index) does not affect submodules' '
+test_expect_todo 'grep --textconv: superproject .gitattributes (from index) does not affect submodules' '
 	reset_and_clean &&
 	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
 	echo "a diff=d2x" >.gitattributes &&
 	git add .gitattributes &&
 	rm .gitattributes &&
 
+	cat >want <<-\EOF &&
+	a:(1|2)x(3|4)
+	EOF
 	cat >expect <<-\EOF &&
 	a:(1|2)x(3|4)
+	submodule/a:(1|2)x(3|4)
+	submodule/sub/a:(1|2)x(3|4)
 	EOF
 	git grep --textconv --recurse-submodules x >actual &&
-	test_cmp expect actual
+	todo_test_cmp want expect actual
 '
 
-test_expect_failure 'grep --textconv: superproject .git/info/attributes does not affect submodules' '
+test_expect_todo 'grep --textconv: superproject .git/info/attributes does not affect submodules' '
 	reset_and_clean &&
 	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
 	super_attr="$(git rev-parse --git-path info/attributes)" &&
 	test_when_finished "rm -f \"$super_attr\"" &&
 	echo "a diff=d2x" >"$super_attr" &&
 
+	cat >want <<-\EOF &&
+	a:(1|2)x(3|4)
+	EOF
 	cat >expect <<-\EOF &&
 	a:(1|2)x(3|4)
+	submodule/a:(1|2)x(3|4)
+	submodule/sub/a:(1|2)x(3|4)
 	EOF
 	git grep --textconv --recurse-submodules x >actual &&
-	test_cmp expect actual
+	todo_test_cmp want expect actual
 '
 
 # Note: what currently prevents this test from passing is not that the
 # .gitattributes file from "./submodule" is being ignored, but that it is being
 # propagated to the nested "./submodule/sub" files.
 #
-test_expect_failure 'grep --textconv correctly reads submodule .gitattributes' '
+test_expect_todo 'grep --textconv correctly reads submodule .gitattributes' '
 	reset_and_clean &&
 	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
 	echo "a diff=d2x" >submodule/.gitattributes &&
 
+	cat >want <<-\EOF &&
+	submodule/a:(1|2)x(3|4)
+	EOF
 	cat >expect <<-\EOF &&
 	submodule/a:(1|2)x(3|4)
+	submodule/sub/a:(1|2)x(3|4)
 	EOF
 	git grep --textconv --recurse-submodules x >actual &&
-	test_cmp expect actual
+	todo_test_cmp want expect actual
 '
 
-test_expect_failure 'grep --textconv correctly reads submodule .gitattributes (from index)' '
+test_expect_todo 'grep --textconv correctly reads submodule .gitattributes (from index)' '
 	reset_and_clean &&
 	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
 	echo "a diff=d2x" >submodule/.gitattributes &&
 	git -C submodule add .gitattributes &&
 	rm submodule/.gitattributes &&
 
-	cat >expect <<-\EOF &&
+	cat >want <<-\EOF &&
 	submodule/a:(1|2)x(3|4)
 	EOF
-	git grep --textconv --recurse-submodules x >actual &&
-	test_cmp expect actual
+	>expect &&
+
+	test_might_fail git grep --textconv --recurse-submodules x >actual &&
+	todo_test_cmp want expect actual
 '
 
-test_expect_failure 'grep --textconv correctly reads submodule .git/info/attributes' '
+test_expect_todo 'grep --textconv correctly reads submodule .git/info/attributes' '
 	reset_and_clean &&
 	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
 
@@ -520,11 +541,12 @@ test_expect_failure 'grep --textconv correctly reads submodule .git/info/attribu
 	test_when_finished "rm -f \"$submodule_attr\"" &&
 	echo "a diff=d2x" >"$submodule_attr" &&
 
-	cat >expect <<-\EOF &&
+	cat >want <<-\EOF &&
 	submodule/a:(1|2)x(3|4)
 	EOF
-	git grep --textconv --recurse-submodules x >actual &&
-	test_cmp expect actual
+	>expect &&
+	test_might_fail git grep --textconv --recurse-submodules x >actual &&
+	todo_test_cmp want expect actual
 '
 
 test_expect_failure 'grep saves textconv cache in the appropriate repository' '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 64b9580f2bc..4d1eca380e8 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1263,6 +1263,28 @@ test_cmp () {
 	eval "$GIT_TEST_CMP" '"$@"'
 }
 
+# todo_test_cmp is a "test_cmp" for use in conjunction with
+# "test_expect_todo".
+#
+# It takes a mandatory extra first argument of "want", indicating the
+# output we'd like to have once we turn that "test_expect_todo" into a
+# "test_expect_success":
+#
+#	test_expect_todo 'foo still doesn't work' '
+#		echo yay >want &&
+#		echo error >expect &&
+#		foo >actual &&
+#		test_cmp want expect actual
+#	'
+todo_test_cmp () {
+	test "$#" -ne 3 && BUG "3 param, not $#"
+	local want=$1 &&
+	local expect=$2 &&
+	local actual=$3 &&
+
+	test_todo test_cmp --want "$want" --expect "$expect" -- "$actual"
+}
+
 # Check that the given config key has the expected value.
 #
 #    test_cmp_config [-C <dir>] <expected-value>
-- 
2.35.1.1436.g756b814e59f

