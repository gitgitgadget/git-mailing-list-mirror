Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7FFC2D0F3
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 04:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D54520772
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 04:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWgWK2nW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731608AbgDAERx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 00:17:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35084 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgDAERx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 00:17:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id i19so5595646wmb.0
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 21:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Kcc3q4UbR2b6kZZXFJf+pUy099mojgzc0S7JNbD1A7M=;
        b=ZWgWK2nWE+SNE6U1e+gM8OUs27QKpNNuhcQ/WH2aYH2nFUPnXvq3//mdw9/eanrPWz
         wqs+cPnGLpsceJcldzdK0A5qmEt8Ah/tdcc1lTRfl84xgaYpjaYEbTdUzTiIzgxJhz/V
         Hu/ZLi6ZqyNfBa7Ysb4Nbv7Vxx/pomZSjXW/WMRQskBS22fUlW5byC/At7eUcj31BtFp
         a5uQv0pj+Nm2iP55G2ho6bAlJLCl2Kjv5SH343eqPurpJJAN+TdZfKTDkDnGIVWy0dWB
         rDUKox8uMWF7cyubvNnX/n1MDSCk3TgY7p1WBCEbPJHKCYouUNLs/ni9nl+ux/qsMVkB
         aSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Kcc3q4UbR2b6kZZXFJf+pUy099mojgzc0S7JNbD1A7M=;
        b=qROJQE5N/dW5pq6bpTQZmC69yc5e2oGGLUhYeYN9zwg6jDSyjK62QofyablMzF5l7+
         vSvsMap7S4cRoZ7uXf+ZRGKfxhW82t5QbFyy77cmn9P5uWYHGXyA41lk931l/b6e5tGE
         8X77pflmuKnwltOCbfdPH9CYEgQn1WmsIpOJSNRSM0gGxt2FH4qVgoRXrHmCb4j5VsL7
         S1jDaSHlwb5feiS/Dj+5SftlrNhSihCi5qI1pQgcfTNDmZENSrXjlet2UpTtaLi0SSFP
         n1sf0v1vDxC0qyRvBWJMDU6QM17pGHG4zVgbnfVQEzSY4FSRhw/9/CFe6jrIsL/C33TU
         LqEQ==
X-Gm-Message-State: AGi0PuYBXByw93dqrq4ZHRTZ8QVSCjuACy7InTqvPqISIHvqF/zuaZBO
        XtIdeh1ObUTRw07twC2xsVEcqSD7
X-Google-Smtp-Source: APiQypJDYAHJpO9ljLFBAGZ9QnnzjrH6wz8DaKe50kKXh8fxo7so6kCxlbhqX394obeceBrlk8vcvA==
X-Received: by 2002:a1c:196:: with SMTP id 144mr2220127wmb.100.1585714669649;
        Tue, 31 Mar 2020 21:17:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q9sm1267756wrp.84.2020.03.31.21.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 21:17:49 -0700 (PDT)
Message-Id: <e2704245854fb6f9a2daac9f2bd2ed97ad05b227.1585714667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.v5.git.git.1585714667.gitgitgadget@gmail.com>
References: <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com>
        <pull.700.v5.git.git.1585714667.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Apr 2020 04:17:35 +0000
Subject: [PATCH v5 01/12] t7063: more thorough status checking
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Martin Melka <martin.melka@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

It turns out the t7063 has some testcases that even without using the
untracked cache cover situations that nothing else in the testsuite
handles.  Checking the results of
  git status --porcelain
both with and without the untracked cache, and comparing both against
our expected results helped uncover a critical bug in some dir.c
restructuring.

Unfortunately, it's not easy to run status and tell it to ignore the
untracked cache; the only knob we have is core.untrackedCache=false,
which is used to instruct git to *delete* the untracked cache (which
might also ignore the untracked cache when it operates, but that isn't
specified in the docs).

Create a simple helper that will create a clone of the index that is
missing the untracked cache bits, and use it to compare that the results
with the untracked cache match the results we get without the untracked
cache.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7063-status-untracked-cache.sh | 52 +++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 190ae149cf3..69c39ff2e49 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -30,6 +30,30 @@ status_is_clean() {
 	test_must_be_empty ../status.actual
 }
 
+# Ignore_Untracked_Cache, abbreviated to 3 letters because then people can
+# compare commands side-by-side, e.g.
+#    iuc status --porcelain >expect &&
+#    git status --porcelain >actual &&
+#    test_cmp expect actual
+iuc () {
+	git ls-files -s >../current-index-entries
+	git ls-files -t | sed -ne s/^S.//p >../current-sparse-entries
+
+	GIT_INDEX_FILE=.git/tmp_index
+	export GIT_INDEX_FILE
+	git update-index --index-info <../current-index-entries
+	git update-index --skip-worktree $(cat ../current-sparse-entries)
+
+	git -c core.untrackedCache=false "$@"
+	ret=$?
+
+	rm ../current-index-entries
+	rm $GIT_INDEX_FILE
+	unset GIT_INDEX_FILE
+
+	return $ret
+}
+
 test_lazy_prereq UNTRACKED_CACHE '
 	{ git update-index --test-untracked-cache; ret=$?; } &&
 	test $ret -ne 1
@@ -95,6 +119,8 @@ test_expect_success 'status first time (empty cache)' '
 	: >../trace &&
 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
 	git status --porcelain >../actual &&
+	iuc status --porcelain >../status.iuc &&
+	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../actual &&
 	cat >../trace.expect <<EOF &&
 node creation: 3
@@ -115,6 +141,8 @@ test_expect_success 'status second time (fully populated cache)' '
 	: >../trace &&
 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
 	git status --porcelain >../actual &&
+	iuc status --porcelain >../status.iuc &&
+	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../actual &&
 	cat >../trace.expect <<EOF &&
 node creation: 0
@@ -136,6 +164,7 @@ test_expect_success 'modify in root directory, one dir invalidation' '
 	: >../trace &&
 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
 	git status --porcelain >../actual &&
+	iuc status --porcelain >../status.iuc &&
 	cat >../status.expect <<EOF &&
 A  done/one
 A  one
@@ -145,6 +174,7 @@ A  two
 ?? four
 ?? three
 EOF
+	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../actual &&
 	cat >../trace.expect <<EOF &&
 node creation: 0
@@ -183,6 +213,7 @@ test_expect_success 'new .gitignore invalidates recursively' '
 	: >../trace &&
 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
 	git status --porcelain >../actual &&
+	iuc status --porcelain >../status.iuc &&
 	cat >../status.expect <<EOF &&
 A  done/one
 A  one
@@ -192,6 +223,7 @@ A  two
 ?? dtwo/
 ?? three
 EOF
+	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../actual &&
 	cat >../trace.expect <<EOF &&
 node creation: 0
@@ -230,6 +262,7 @@ test_expect_success 'new info/exclude invalidates everything' '
 	: >../trace &&
 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
 	git status --porcelain >../actual &&
+	iuc status --porcelain >../status.iuc &&
 	cat >../status.expect <<EOF &&
 A  done/one
 A  one
@@ -237,6 +270,7 @@ A  two
 ?? .gitignore
 ?? dtwo/
 EOF
+	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../actual &&
 	cat >../trace.expect <<EOF &&
 node creation: 0
@@ -286,6 +320,7 @@ test_expect_success 'status after the move' '
 	: >../trace &&
 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
 	git status --porcelain >../actual &&
+	iuc status --porcelain >../status.iuc &&
 	cat >../status.expect <<EOF &&
 A  done/one
 A  one
@@ -293,6 +328,7 @@ A  one
 ?? dtwo/
 ?? two
 EOF
+	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../actual &&
 	cat >../trace.expect <<EOF &&
 node creation: 0
@@ -343,6 +379,7 @@ test_expect_success 'status after the move' '
 	: >../trace &&
 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
 	git status --porcelain >../actual &&
+	iuc status --porcelain >../status.iuc &&
 	cat >../status.expect <<EOF &&
 A  done/one
 A  one
@@ -350,6 +387,7 @@ A  two
 ?? .gitignore
 ?? dtwo/
 EOF
+	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../actual &&
 	cat >../trace.expect <<EOF &&
 node creation: 0
@@ -390,10 +428,12 @@ test_expect_success 'status after commit' '
 	: >../trace &&
 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
 	git status --porcelain >../actual &&
+	iuc status --porcelain >../status.iuc &&
 	cat >../status.expect <<EOF &&
 ?? .gitignore
 ?? dtwo/
 EOF
+	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../actual &&
 	cat >../trace.expect <<EOF &&
 node creation: 0
@@ -447,12 +487,14 @@ test_expect_success 'test sparse status with untracked cache' '
 	avoid_racy &&
 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
 	git status --porcelain >../status.actual &&
+	iuc status --porcelain >../status.iuc &&
 	cat >../status.expect <<EOF &&
  M done/two
 ?? .gitignore
 ?? done/five
 ?? dtwo/
 EOF
+	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../status.actual &&
 	cat >../trace.expect <<EOF &&
 node creation: 0
@@ -487,12 +529,14 @@ test_expect_success 'test sparse status again with untracked cache' '
 	: >../trace &&
 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
 	git status --porcelain >../status.actual &&
+	iuc status --porcelain >../status.iuc &&
 	cat >../status.expect <<EOF &&
  M done/two
 ?? .gitignore
 ?? done/five
 ?? dtwo/
 EOF
+	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../status.actual &&
 	cat >../trace.expect <<EOF &&
 node creation: 0
@@ -514,6 +558,7 @@ test_expect_success 'test sparse status with untracked cache and subdir' '
 	: >../trace &&
 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
 	git status --porcelain >../status.actual &&
+	iuc status --porcelain >../status.iuc &&
 	cat >../status.expect <<EOF &&
  M done/two
 ?? .gitignore
@@ -521,6 +566,7 @@ test_expect_success 'test sparse status with untracked cache and subdir' '
 ?? done/sub/
 ?? dtwo/
 EOF
+	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../status.actual &&
 	cat >../trace.expect <<EOF &&
 node creation: 2
@@ -560,6 +606,8 @@ test_expect_success 'test sparse status again with untracked cache and subdir' '
 	: >../trace &&
 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
 	git status --porcelain >../status.actual &&
+	iuc status --porcelain >../status.iuc &&
+	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../status.actual &&
 	cat >../trace.expect <<EOF &&
 node creation: 0
@@ -573,6 +621,7 @@ EOF
 test_expect_success 'move entry in subdir from untracked to cached' '
 	git add dtwo/two &&
 	git status --porcelain >../status.actual &&
+	iuc status --porcelain >../status.iuc &&
 	cat >../status.expect <<EOF &&
  M done/two
 A  dtwo/two
@@ -580,12 +629,14 @@ A  dtwo/two
 ?? done/five
 ?? done/sub/
 EOF
+	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../status.actual
 '
 
 test_expect_success 'move entry in subdir from cached to untracked' '
 	git rm --cached dtwo/two &&
 	git status --porcelain >../status.actual &&
+	iuc status --porcelain >../status.iuc &&
 	cat >../status.expect <<EOF &&
  M done/two
 ?? .gitignore
@@ -593,6 +644,7 @@ test_expect_success 'move entry in subdir from cached to untracked' '
 ?? done/sub/
 ?? dtwo/
 EOF
+	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../status.actual
 '
 
-- 
gitgitgadget

