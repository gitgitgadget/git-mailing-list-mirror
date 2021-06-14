Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B65C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 17:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7858661241
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 17:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbhFNRVV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 13:21:21 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:44920 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhFNRVT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 13:21:19 -0400
Received: by mail-wr1-f51.google.com with SMTP id f2so15347237wri.11
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 10:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=meSApZtDOMGSRAaAZYplr9ZafpWDiFGSQpePwPKLjcQ=;
        b=WSnYxc45C121vz6HAAAdKGUDc9saU/dtYetHMK420Q14ru4XUE2tFUoNawNPZnIe83
         UUQ6mcGfYq5V96ZLUDBg/0XZjhgV9HDbAuiQbjxKmxdb6Q0qaXeqLzddcglqdT3W95xh
         IGxr0CoRBCcuIeWVHJEkMXFPuxeED5c2SWGZAQvZBJm4gvHIlVpvd9HPP0UAwvmHovPN
         eB+ePYItEW1rRjiFrUNGroZc8vGGhUEYT339DBYB1T83kGJhfYHcSTVe/UzFnxhvuc/f
         pypgYUb5x/xk2NczpzdWPS1Uu+9ohjGMcYdAtZiqBqRsaeqOv8HnOAkLPI6+drei7/hk
         pmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=meSApZtDOMGSRAaAZYplr9ZafpWDiFGSQpePwPKLjcQ=;
        b=oGh0C42Sm412uaKIhkXNgcLrJsWWGNZGEyppu/6ePTkO0TVPRhMAPGPL9Gd4TWWWZm
         bFaUbONWBqtjtPbcOdBDr1fs9mFYYGTqJtWJhkMlPJ49cix8weIAAp7e/XI38ZVhi3Vd
         tLisqIHTs5q47lGb/YRxVOIqnQ3VryyLH/q97XuL4UbIYtdeTR8TSuiiJ/rt03SPJGCk
         SUtG4A+eKFPDDKWaK9zBqdAxiVJOHsvs5hVeQBRUC5UrbKbBC7yr3aQOhvCUTJAHl64C
         i3ATug37L+TxahhLd3Fn1QvfReAu4lPfU5dnrFkBVIg/b8oV7VbIHdqLdXY/CcCQKLnt
         fQcw==
X-Gm-Message-State: AOAM532cVOlumWwo+szW5ddKiypH6AJnkEWwTR5kHB/0pM5NsbWzPrPR
        V/6Iehy/42AjSG6RW52MeoSkyMUMcEoCBA==
X-Google-Smtp-Source: ABdhPJzgShiOWL8+OibIBN1BqKeo2FNnNyZ0pRLVf9065jZV/GU8g+6oHiPtvJuRj3asrGhPm0KMdA==
X-Received: by 2002:a5d:538c:: with SMTP id d12mr19539391wrv.116.1623691095058;
        Mon, 14 Jun 2021 10:18:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i6sm83816wmb.15.2021.06.14.10.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:18:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael J Gruber <git@grubix.eu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/4] show-branch tests: modernize test code
Date:   Mon, 14 Jun 2021 19:18:08 +0200
Message-Id: <patch-2.4-27f94abaede-20210614T171626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.555.g0268d380f7b
In-Reply-To: <cover-0.4-00000000000-20210614T171626Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210614T171626Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Modernize test code added in ce567d1867a (Add test to show that
show-branch misses out the 8th column, 2008-07-23) and
11ee57bc4c4 (sort_in_topological_order(): avoid setting a commit flag,
2008-07-23) to use test helpers.

I'm renaming "out" to "actual" for consistency with other tests, and
introducing a "branches.sorted" file in the setup, to make it clear
that it's important that the list be sorted in this particular way.

The "show-branch" output is indented with spaces, which would cause
complaints under "git show --check" with an indented here-doc
block. Let's prefix the lines with "> " to work around that, and to
make it clear that the leading whitespace is important.

We can also get rid of the hardcoding of "main" added here in
334afbc76fb (tests: mark tests relying on the current default for
`init.defaultBranch`, 2020-11-18). For this test we're setting up an
"initial" commit anyway, and now that we've moved over to test_commit
we can reference that instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3202-show-branch.sh | 92 ++++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 52 deletions(-)

diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
index 8cfbbf79c1b..7b06048905a 100755
--- a/t/t3202-show-branch.sh
+++ b/t/t3202-show-branch.sh
@@ -2,69 +2,57 @@
 
 test_description='test show-branch'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
-export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
-
 . ./test-lib.sh
 
-numbers="1 2 3 4 5 6 7 8 9 10"
-
 test_expect_success 'setup' '
-
-	> file &&
-	git add file &&
-	test_tick &&
-	git commit -m initial &&
-
-	for i in $numbers
+	test_commit initial &&
+	for i in $(test_seq 1 10)
 	do
-		git checkout -b branch$i main &&
-		> file$i &&
-		git add file$i &&
-		test_tick &&
-		git commit -m branch$i || return 1
-	done
-
+		git checkout -b branch$i initial &&
+		test_commit --no-tag branch$i
+	done &&
+	git for-each-ref \
+		--sort=version:refname \
+		--format="%(refname:strip=2)" \
+		"refs/heads/branch*" >branches.sorted &&
+	sed "s/^> //" >expect <<-\EOF
+	> ! [branch1] branch1
+	>  ! [branch2] branch2
+	>   ! [branch3] branch3
+	>    ! [branch4] branch4
+	>     ! [branch5] branch5
+	>      ! [branch6] branch6
+	>       ! [branch7] branch7
+	>        ! [branch8] branch8
+	>         ! [branch9] branch9
+	>          * [branch10] branch10
+	> ----------
+	>          * [branch10] branch10
+	>         +  [branch9] branch9
+	>        +   [branch8] branch8
+	>       +    [branch7] branch7
+	>      +     [branch6] branch6
+	>     +      [branch5] branch5
+	>    +       [branch4] branch4
+	>   +        [branch3] branch3
+	>  +         [branch2] branch2
+	> +          [branch1] branch1
+	> +++++++++* [branch10^] initial
+	EOF
 '
 
-cat > expect << EOF
-! [branch1] branch1
- ! [branch2] branch2
-  ! [branch3] branch3
-   ! [branch4] branch4
-    ! [branch5] branch5
-     ! [branch6] branch6
-      ! [branch7] branch7
-       ! [branch8] branch8
-        ! [branch9] branch9
-         * [branch10] branch10
-----------
-         * [branch10] branch10
-        +  [branch9] branch9
-       +   [branch8] branch8
-      +    [branch7] branch7
-     +     [branch6] branch6
-    +      [branch5] branch5
-   +       [branch4] branch4
-  +        [branch3] branch3
- +         [branch2] branch2
-+          [branch1] branch1
-+++++++++* [branch10^] initial
-EOF
-
 test_expect_success 'show-branch with more than 8 branches' '
-
-	git show-branch $(for i in $numbers; do echo branch$i; done) > out &&
-	test_cmp expect out
-
+	git show-branch $(cat branches.sorted) >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'show-branch with showbranch.default' '
-	for i in $numbers; do
-		git config --add showbranch.default branch$i
+	for branch in $(cat branches.sorted)
+	do
+		test_config showbranch.default $branch --add
 	done &&
-	git show-branch >out &&
-	test_cmp expect out
+	git show-branch >actual &&
+	test_cmp expect actual
 '
 
 test_done
-- 
2.32.0.555.g0268d380f7b

