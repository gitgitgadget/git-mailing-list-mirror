Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47A5C433EF
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 00:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiCRAfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 20:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiCRAfb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 20:35:31 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EB32467CF
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 17:34:13 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n31-20020a05600c3b9f00b003898fc06f1eso5911362wms.1
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 17:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=60lYNLgXDR1VpAaQlIPQzOIjeiPOvnQlqILkoJSkk8o=;
        b=q7RqiUqB2PW7F8tjj0yXTA5TJRHLLcLIDnq3KFhHxlLW0MzTCLGZBsRXwR6A2H74SZ
         cuGi62EVUAOEe/iZbqLmPTgrC25DcApMeWhARqJ4FCvMTsnqgNp4X2Po42ejS64soeu7
         wBElZ9SuGI2XTrtTPJnj9MIxdtec3ZEV0kmBSlFkXYAZD7STkCNzP9ab+d6ETK5BCWu+
         8R3Wuhdsbcno3ZtY6ws+gemIE/TGtq+N2ZkLpb/ojEHpJolRacLSwfvDlMRuYZOWjAuf
         KJy+Z4UKZLgOd9Ml//9K3QqJIkE9FeU0lXuikdItAbuP6SdllC7jCBzPfAESWScKRWwn
         0OzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=60lYNLgXDR1VpAaQlIPQzOIjeiPOvnQlqILkoJSkk8o=;
        b=I5b1o4Uhy9bntv1oJQNHxGaZJhm+0rhUE/ytDs7/y6/nWeXQlJQjjL55k7rxAdQsLL
         fXzcYw1NcHcEikdGaq3vJlJwgpXhpZNTJv4YprI4/JmhEphfxx9vhhTZ9QzAibt8c7J9
         1zvBDLvGXnw6DLWSh3X1Vny6Fj/UuWvoAPpXyCNiMd/t/eYe998+XxHJTdFpqE1lRGft
         s7k6stajiHI3fInLfL86WSaxhRFtK8l9Axr/VX47VeWYSmbjVF4z0mlXQvlZY0i4kFFS
         vADyDG2+L+pRu6D4Q4MwTTh19V9n7Oqa0KnO8y/3fKM/qNFOKRUkmu1wLWEnhCZRC5Ol
         ziHA==
X-Gm-Message-State: AOAM530Lbc/oWJgYohraNgyr4UgUDucsWy+7ifAwGavjTtaECNGIqbWR
        pXJcshi0pFcYN5CtyBEj1ll0vhc9yCxDXA==
X-Google-Smtp-Source: ABdhPJy4hVQU5wPfqWf79pbdKgeLK6+VJYIKvDyKqg+dRTVFWTeIgzfjPB7wILNIghdmWQutQd68Mg==
X-Received: by 2002:a1c:6a14:0:b0:383:a58c:3635 with SMTP id f20-20020a1c6a14000000b00383a58c3635mr13778567wmc.129.1647563651185;
        Thu, 17 Mar 2022 17:34:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l4-20020adff484000000b00203dde8d82bsm5096548wro.88.2022.03.17.17.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 17:34:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/7] test-lib-functions: add and use a "test_todo" helper
Date:   Fri, 18 Mar 2022 01:33:57 +0100
Message-Id: <patch-2.7-0834a3ed049-20220318T002951Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1436.g756b814e59f
In-Reply-To: <cover-0.7-00000000000-20220318T002951Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20220318T002951Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a new "test_todo" function for use with the new
"test_expect_todo" function, and convert a couple of tests to use it,
including one added in aecad374ae7 (reflog-walk: don't segfault on
non-commit sha1's in the reflog, 2016-01-05).

A good thing about "test_expect_failure" is that it allowed for
writing the sort of tests added in aecad374ae7, where we declare what
we'd like to eventually get, but just mark that we're still failing to
get that.

For cases like the one-line "t7815-grep-binary.sh" test adjusted in
the preceding commit to use "test_expect_todo" it's obvious what we'd
eventually like to do, to remove the "test_must_fail" and convert
"test_expect_todo" to "test_expect_success".

But in the cases being adjusted here it would be a regression to
simply remove the "test_line_count", as the "expect" part of it is
what we'd eventually like to have pass.

By introducing a "test_todo" we can both assert how something
currently fails, and how it should behave once the relevant feature is
implemented (or a bug is fixed).

The "test_todo" function will always run the check for what we
eventually want, and BUG() out if it succeeds. We'll also BUG() out if
neither succeed.

This way we can ensure that unlike "test_expect_failure" blocks the
assertions aren't dead or broken code. A few uses of
"test_expect_failure" in the test suite (not altered here) are
hopelessly broken, and could never pass even if a bug was fixed or a
given feature was implemented.

We just haven't noticed because we've been treating all failures in
"test_expect_failure" equally, using "test_expect_todo" with this
"test_todo" helper is a better way forward.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0000-basic.sh        | 37 ++++++++++++++++++++
 t/t1410-reflog.sh       |  4 +--
 t/t6403-merge-file.sh   |  9 +++--
 t/test-lib-functions.sh | 77 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 123 insertions(+), 4 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index e46638f1f7b..bbe48d63b16 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -204,6 +204,43 @@ test_expect_success 'subtest: mixed results: a mixture of all possible results'
 	EOF
 '
 
+test_expect_success 'subtest: test_expect_todo with test_todo' '
+	write_and_run_sub_test_lib_test test-expect-todo <<-\EOF &&
+	test_expect_todo "command not implemented yet" "
+		test_todo \
+			--want \"git unimplemented\" \
+			--expect \"test_must_fail git unimplemented\"
+	"
+	test_done
+	EOF
+	check_sub_test_lib_test test-expect-todo <<-\EOF
+	> not ok 1 - command not implemented yet # TODO known breakage
+	> # still have 1 known breakage(s)
+	> 1..1
+	EOF
+'
+
+test_expect_success 'subtest: test_expect_todo with test_todo: prefix + suffix arguments' '
+	write_and_run_sub_test_lib_test test-expect-todo-pfx <<-\EOF &&
+	test_expect_todo "prefix argument for test_todo" "
+		echo x >want &&
+		echo y >expect &&
+		cp expect actual &&
+		test_todo test_cmp \
+			--want want \
+			--expect expect \
+			-- \
+			actual
+	"
+	test_done
+	EOF
+	check_sub_test_lib_test test-expect-todo-pfx <<-\EOF
+	> not ok 1 - prefix argument for test_todo # TODO known breakage
+	> # still have 1 known breakage(s)
+	> 1..1
+	EOF
+'
+
 test_expect_success 'subtest: --verbose option' '
 	write_and_run_sub_test_lib_test_err t1234-verbose --verbose <<-\EOF &&
 	test_expect_success "passing test" true
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 68f69bb5431..fcd5ff4e313 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -369,9 +369,9 @@ test_expect_success 'no segfaults for reflog containing non-commit sha1s' '
 	git reflog refs/tests/tree-in-reflog
 '
 
-test_expect_failure 'reflog with non-commit entries displays all entries' '
+test_expect_todo 'reflog with non-commit entries displays all entries' '
 	git reflog refs/tests/tree-in-reflog >actual &&
-	test_line_count = 3 actual
+	test_todo test_line_count --want "= 3" --expect "= 2" -- actual
 '
 
 # This test takes a lock on an individual ref; this is not supported in
diff --git a/t/t6403-merge-file.sh b/t/t6403-merge-file.sh
index 2f421d967ab..12b334af85c 100755
--- a/t/t6403-merge-file.sh
+++ b/t/t6403-merge-file.sh
@@ -82,9 +82,14 @@ test_expect_success "merge without conflict (--quiet)" '
 	git merge-file --quiet test.txt orig.txt new2.txt
 '
 
-test_expect_failure "merge without conflict (missing LF at EOF)" '
+test_expect_todo "merge without conflict (missing LF at EOF)" '
 	cp new1.txt test2.txt &&
-	git merge-file test2.txt orig.txt new4.txt
+	test_todo \
+		test_expect_code \
+		--expect 1 \
+		--want 0 \
+		-- \
+		git merge-file test2.txt orig.txt new4.txt
 '
 
 test_expect_failure "merge result added missing LF" '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index a219b126d93..53335393b9b 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -959,6 +959,83 @@ test_path_is_missing () {
 	fi
 }
 
+# Usage: test_todo [<common-prefix>] <options> [-- <common-suffix>...]
+#	--want <want>
+#		The condition we'd like. Injected between
+#		<common-prefix> and <common-suffix> arguments.
+#	--expect <expect>
+#		The condition we have now. Injected in the same way as
+#		the arguments to --want.
+#
+# test_todo is a wrapper for use with "test_expect_todo". It declares
+# an outcome we want, and one we currently expect:
+#
+#	test_todo --want true --expect false
+#
+# It can also take a <common-prefix> prefix along with
+# <common-suffix>... parameters after a "--", e.g.:
+#
+#	# We want 1 line, not 2
+# 	test_todo test_line_count --want "= 1" --expect "= 2" -- actual
+#
+# Here both variants of the "test_line_count" will be run to assert
+# that the "want" variant doesn't pass yet, and that the "expect"
+# variant describes the current behavior.
+#
+# Because we run both neither of them can mutate the test
+# state. I.e. they must be read-only commands such as "wc -l", and not
+# a state-altering command such as "rm".
+test_todo () {
+	local common_fn= &&
+	local have_want= &&
+	local want= &&
+	local expect= &&
+	local have_expect= &&
+	while test $# != 0
+	do
+		case "$1" in
+		--want)
+			want="$2" &&
+			have_want=t &&
+			shift
+			;;
+		--expect)
+			expect="$2" &&
+			have_expect=t &&
+			shift
+			;;
+		--)
+			shift &&
+			break
+			;;
+		*)
+			if test -n "$common_fn"
+			then
+				BUG "the <common-fn> can only be given once" &&
+				return 1
+			fi &&
+			common_fn="$1"
+			;;
+		esac
+		shift
+	done &&
+	if test "$have_want$have_expect" != "tt"
+	then
+		BUG "test_todo must get a --want <want> and --expect <expect>"
+	fi &&
+
+	if $common_fn $want "$@"
+	then
+		BUG "a test_todo succeeded with --want ('$want').  Turn it into a test_expect_success + $@ $want?" &&
+		return 1
+	elif $common_fn $expect "$@"
+	then
+		say "a test_todo will succeed with --expect ('$expect'), we eventually want '$want' instead" >&3 &&
+		return 0
+	fi &&
+	BUG "a test_todo didn't pass with either --want ('$want') or --expect ('$expect')"
+}
+
 # test_line_count checks that a file has the number of lines it
 # ought to. For example:
 #
-- 
2.35.1.1436.g756b814e59f

