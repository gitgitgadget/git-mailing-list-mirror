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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607F3C6377A
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E4CD6100C
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhGUXNB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 19:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhGUXNA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 19:13:00 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EBBC061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:53:35 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o5-20020a1c4d050000b02901fc3a62af78so473683wmh.3
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tbAAt8Sh1S30E7vrcxFCRZZKq2JuGKiJ9DI8BPLMt6M=;
        b=UC+dwSXKeTMrEMV12oWEBS7DT7HLfXWRIrFVMVIYiEZYgbOBaOqdYwH1CeQLUn8s51
         OYKl0/z65S+kavQ73awUyv38ZKmYBbYwV6km2XWwZoa+UO4sKd6nBgbozwYulVUM+4B0
         quv6Pgj7SFMXErMk6cZ1JDl3RgER3m/DaXUO4w/7gskNikLSvZ2K5EaZCP8wfrQpxZPs
         ipeEw+mpDfwqkaVOICAxTco9de+xlm1WuxThguYMmVP7h4n9HLioRtCYJsPY5LZNdFvF
         lGjn1D5lqbM1yZW6f26t5t2+YH9sA27cCEltNz/55lQfINqobLPSMZzW72PBdhWGzH0i
         hJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tbAAt8Sh1S30E7vrcxFCRZZKq2JuGKiJ9DI8BPLMt6M=;
        b=SJABFNS2tsuSgOUC9hapF5HW9pBj+iixox+Vbm1bOMH5m8939G2IjZNRHZV82GjX1/
         yjcGCA17n9b5Tn5fL52BqZpMNuVjWZdgNUyJfRkpMHes1zyIiOnJ0J+Ong4yXijC+Np2
         VVMDKnPAyuuvlpvQpVQW8nSaGT7/QD77QVdldeaVRTsXd7dnkboeRBTLRAzsO9vSd6IM
         wijLZUG4mQ0my5vHQrrnmmOYGqgT/0GgfYscyeYuZWLU3rM3SC4IWpIfRx4jQ/0rON3X
         KrrqPbkCQQQE4bunxqw6dXvWwiXYlZk5+x6dMBThzx6mHmHyzzX/issMUM37u2RBkaFb
         fMjA==
X-Gm-Message-State: AOAM533c92UiGsm1+c5e1SenJnaFMMCqsZrAqa3vyUENezs+Fvp9oEY9
        5i3LSUM79B4Pfb0p6J0DjGvb3BoBBHn6VQ==
X-Google-Smtp-Source: ABdhPJwevZNdSRZLAZKTublAe537eH6Y3adVMY3P4CAICGKyhbnxzg+Dw8rvszJi0Uq56AbRZjncug==
X-Received: by 2002:a05:600c:4ca7:: with SMTP id g39mr23045751wmp.72.1626911613908;
        Wed, 21 Jul 2021 16:53:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y12sm11342674wmc.12.2021.07.21.16.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 16:53:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/2] bundle tests: use test_cmp instead of grep
Date:   Thu, 22 Jul 2021 01:53:29 +0200
Message-Id: <patch-2.2-d5504fd764c-20210721T235251Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.955.ge7c5360f7e7
In-Reply-To: <cover-0.2-00000000000-20210721T235251Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20210720T115052Z-avarab@gmail.com> <cover-0.2-00000000000-20210721T235251Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the bundle tests to fully compare the expected "git ls-remote"
or "git bundle list-heads" output, instead of merely grepping it.

This avoids subtle regressions in the tests. In
f62e0a39b6 (t5704 (bundle): add tests for bundle --stdin, 2010-04-19)
the "bundle --stdin <rev-list options>" test was added to make sure we
didn't include the tag.

But since the --stdin mode didn't work until 5bb0fd2cab (bundle:
arguments can be read from stdin, 2021-01-11) our grepping of
"master" (later "main") missed the important part of the test.

Namely that we should not include the "refs/tags/tag" tag in that
case. Since the test only grepped for "main" in the output we'd miss a
regression in that code.

So let's use test_cmp instead, and also in the other nearby tests
where it's easy.

This does make things a bit more verbose in the case of the test
that's checking the bundle header, since it's different under SHA1 and
SHA256. I think this makes test easier to follow.

I've got some WIP changes to extend the "git bundle" command to dump
parts of the header out, which are easier to understand if we test the
output explicitly like this.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5607-clone-bundle.sh | 66 +++++++++++++++++++++++++++++++++--------
 1 file changed, 53 insertions(+), 13 deletions(-)

diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index c9323a08fe8..ed0d911e953 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -29,11 +29,21 @@ test_expect_success '"verify" needs a worktree' '
 
 test_expect_success 'annotated tags can be excluded by rev-list options' '
 	git bundle create bundle --all --since=7.Apr.2005.15:14:00.-0700 &&
-	git ls-remote bundle > output &&
-	grep tag output &&
+	cat >expect <<-EOF &&
+	$(git rev-parse HEAD)	HEAD
+	$(git rev-parse tag)	refs/tags/tag
+	$(git rev-parse main)	refs/heads/main
+	EOF
+	git ls-remote bundle >actual &&
+	test_cmp expect actual &&
+
 	git bundle create bundle --all --since=7.Apr.2005.15:16:00.-0700 &&
-	git ls-remote bundle > output &&
-	! grep tag output
+	cat >expect <<-EOF &&
+	$(git rev-parse HEAD)	HEAD
+	$(git rev-parse main)	refs/heads/main
+	EOF
+	git ls-remote bundle >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'die if bundle file cannot be created' '
@@ -43,14 +53,20 @@ test_expect_success 'die if bundle file cannot be created' '
 
 test_expect_success 'bundle --stdin' '
 	echo main | git bundle create stdin-bundle.bdl --stdin &&
-	git ls-remote stdin-bundle.bdl >output &&
-	grep main output
+	cat >expect <<-EOF &&
+	$(git rev-parse main)	refs/heads/main
+	EOF
+	git ls-remote stdin-bundle.bdl >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'bundle --stdin <rev-list options>' '
 	echo main | git bundle create hybrid-bundle.bdl --stdin tag &&
-	git ls-remote hybrid-bundle.bdl >output &&
-	grep main output
+	cat >expect <<-EOF &&
+	$(git rev-parse main)	refs/heads/main
+	EOF
+	git ls-remote stdin-bundle.bdl >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'empty bundle file is rejected' '
@@ -67,11 +83,31 @@ test_expect_success 'ridiculously long subject in boundary' '
 	printf "%01200d\n" 0 | git commit -F - &&
 	test_commit fifth &&
 	git bundle create long-subject-bundle.bdl HEAD^..HEAD &&
-	git bundle list-heads long-subject-bundle.bdl >heads &&
-	test -s heads &&
+	cat >expect <<-EOF &&
+	$(git rev-parse main) HEAD
+	EOF
+	git bundle list-heads long-subject-bundle.bdl >actual &&
+	test_cmp expect actual &&
+
 	git fetch long-subject-bundle.bdl &&
-	sed -n "/^-/{p;q;}" long-subject-bundle.bdl >boundary &&
-	grep "^-$OID_REGEX " boundary
+
+	if ! test_have_prereq SHA1
+	then
+		echo "@object-format=sha256"
+	fi >expect &&
+	cat >>expect <<-EOF &&
+	-$(git log --pretty=format:"%H %s" -1 HEAD^)
+	$(git rev-parse HEAD) HEAD
+	EOF
+
+	if test_have_prereq SHA1
+	then
+		head -n 3 long-subject-bundle.bdl
+	else
+		head -n 4 long-subject-bundle.bdl
+	fi | grep -v "^#" >actual &&
+
+	test_cmp expect actual
 '
 
 test_expect_success 'prerequisites with an empty commit message' '
@@ -103,7 +139,11 @@ test_expect_success 'fetch SHA-1 from bundle' '
 
 test_expect_success 'git bundle uses expected default format' '
 	git bundle create bundle HEAD^.. &&
-	head -n1 bundle | grep "^# v$(test_oid version) git bundle$"
+	cat >expect <<-EOF &&
+	# v$(test_oid version) git bundle
+	EOF
+	head -n1 bundle >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'git bundle v3 has expected contents' '
-- 
2.32.0.955.ge7c5360f7e7

