Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFA7C49361
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 319AB613DB
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhFQKzz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbhFQKzv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:55:51 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E44BC061760
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:53:44 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l7-20020a05600c1d07b02901b0e2ebd6deso3421574wms.1
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qa+8BrREZ5p34Qum5gowxCQYlOXGRE6v3YY/LmwYUqk=;
        b=nFnSLWvd39E/8Vo8WYElMBgFzporc2OlyYGr0losINlgCjuH2V2ZbgFfVrSG61GSX/
         KWlx9+ue6IBt5ZOFlueQ0AjmoW0aXwK2WqzI2jeikBrQKuHTeWe5GYFMf98Q41wEH28+
         HSpoJ/rMh1q3ZTKvX1QRphvyeiQrqmunha7SBM9qJUUZWLJL3VtNqeqxPV84c7iwXjGw
         ceGfLSaphypdIDBpb2TDExSNM8BHTi/hGPOdqAPq1JpN0lHpmjgDU341IBbOVEfypPkr
         gx+6N5G18NRPTgHcNnQ4aUm3W4HSaUGF3hdgpFqcq91ARcHz/sB0jQK7R9RQZ2CxQ7pi
         paZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qa+8BrREZ5p34Qum5gowxCQYlOXGRE6v3YY/LmwYUqk=;
        b=TWJDuzZKPnwIjM0HP4f1+LJjK/8Xen+2YDbeveU+jq6bG/8DdHyoa8azydY806Rt3k
         Wxz3YJ3/o65voZ/UrR6/IBKhORUw5IQ5LWX0R2sFHry59YjpKO4W5mXJKLmGqBpY/Obc
         GU6fSvAEyOXEldiL1hN9/4+xDLtATw+z20pCDjufqTP/HN6T7L1H/LVKxuhZkDEsokmd
         2xDFO2K1ag2V4EOYXPW/oN1Z6HqD/7k/wtcrB08crMhtz02aP1LTaJ469tIRbG2sDaBG
         ks0YFtcL2gu/4QJLndVL4FmXqbv+zVbSChVoUPd6S+VufFKHG5hwwteQOFny3hAofyKw
         CebA==
X-Gm-Message-State: AOAM531XGvcV/Zr0JjYzdMGZ/2evsMLgfV5u3M/cDulvNUpFrqlapuu3
        LTPtQLomyV87646Ofgy9X7LUi0b7HueTLA==
X-Google-Smtp-Source: ABdhPJwnvccRpkjHgoBDksfIIIIvUrMa30sWf8/II8YNndY+KE8lcikPWkUJCvpHEE/30DqlDlI31A==
X-Received: by 2002:a05:600c:1546:: with SMTP id f6mr4416761wmg.47.1623927222406;
        Thu, 17 Jun 2021 03:53:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 61sm5409586wrp.4.2021.06.17.03.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:53:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael J Gruber <git@grubix.eu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/4] show-branch tests: modernize test code
Date:   Thu, 17 Jun 2021 12:53:36 +0200
Message-Id: <patch-2.4-27f94abaed-20210617T105245Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.571.gdba276db2c
In-Reply-To: <cover-0.4-0000000000-20210617T105245Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210614T171626Z-avarab@gmail.com> <cover-0.4-0000000000-20210617T105245Z-avarab@gmail.com>
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
index 8cfbbf79c1..7b06048905 100755
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
2.32.0.571.gdba276db2c

