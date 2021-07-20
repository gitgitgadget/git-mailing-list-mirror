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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D9CC07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 11:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB4A86113B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 11:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237665AbhGTLMT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 07:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237659AbhGTLLh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 07:11:37 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD9DC061766
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 04:52:15 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id dj21so28194636edb.0
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 04:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZpUQMg1NkFRlLpfV/thpMPW1/TwsBxXvRJYmbHaAGKQ=;
        b=bqw9bEucKSfO4prqSh5k4GOJeTxhRqXz9b2xblAUFU6dhUDblf20wUSScrScKfvd/0
         HVoiEFjyHQNbtMP9ysepLWEpZg0BcqwhSeE3p2qYVz2DKUK52JvxJ1mwdH/5mViW5b60
         KtcG4mkvzllzE3GsXSaDoLEOYufVqEPURqlE4WbvwXAERkMRXEkn+wz6tIwTHjX+IWrB
         ijrUeep2IJUC3MpYadgE1M/9aF2SlyeQCA2m4BTrXFWcthjEAQhkp9daYPTzs9Ly3RVK
         hM2H9DCZOQrEn+fF+wRBJ/bSPO3M049R/BZShJIka5rmfq7JKw6UVyc2RbdQdDS8a93l
         hziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZpUQMg1NkFRlLpfV/thpMPW1/TwsBxXvRJYmbHaAGKQ=;
        b=dYhK/VslXUCI3xLK53Sa7/uBpSVphPAMLS0X7NoR+vMjYnGD2XaCvUDo8bCsv+MYkB
         g26AzNUnKyXnalsxniAd7wvZNJaAseEk9bI7RpUmhhUyGdEIuroDu+0YO4C16PLXrGZx
         iq4TXt1+bn293DlQeZ2gPmvnFdg3TocfGvUf1JnXN3uAeqktaFi+jpzVeKoTsMBVxbg/
         4NPtoJODd7CJfPWnrlEH3O03zuhpeBQ7BqERRd0gHqDkgHpBXoYU/Pq8lFz+GGoBR/yS
         0joooy9PkZmKrG0R8NVCvk7RtzaeRp7lWhr41u5d/9BRFrAP2gsDFLUqjFrbxXPnoa1w
         c6Ng==
X-Gm-Message-State: AOAM532WV6CcvjvTRBrRbrVuD8N1miFHSa6Dor9qLz/WRQOIEvnYR1ma
        4R/v51qHpPQWswXb89fsH17nZOBamEI+8Q==
X-Google-Smtp-Source: ABdhPJza38d61qKCm/boi0C69HQVi3KQL0+/v5q9vd16xmth5b6Qxs3kDaVFv4kYAKst2LhjZvgOOQ==
X-Received: by 2002:a05:6402:1d2d:: with SMTP id dh13mr22318445edb.90.1626781934085;
        Tue, 20 Jul 2021 04:52:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i11sm9100409edu.97.2021.07.20.04.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 04:52:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] bundle tests: use test_cmp instead of grep
Date:   Tue, 20 Jul 2021 13:52:09 +0200
Message-Id: <patch-2.2-062f34abf1a-20210720T115052Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.ge7a9d58bfcf
In-Reply-To: <cover-0.2-00000000000-20210720T115052Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20210720T115052Z-avarab@gmail.com>
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
 t/t5607-clone-bundle.sh | 68 +++++++++++++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 13 deletions(-)

diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index c9323a08fe8..a7f18407e32 100755
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
@@ -67,11 +83,33 @@ test_expect_success 'ridiculously long subject in boundary' '
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
+	cat >expect.common <<-EOF &&
+	-$(git log --pretty=format:"%H %s" -1 HEAD^)
+	$(git rev-parse HEAD) HEAD
+	EOF
+	if test_have_prereq SHA1
+	then
+		cp expect.common expect
+	else
+		echo @object-format=sha256 >expect
+		cat expect.common >>expect
+	fi &&
+	if test_have_prereq SHA1
+	then
+		head -n 3 long-subject-bundle.bdl >bundle-header
+	else
+		head -n 4 long-subject-bundle.bdl >bundle-header
+	fi &&
+	grep -v "^#" bundle-header >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'prerequisites with an empty commit message' '
@@ -103,7 +141,11 @@ test_expect_success 'fetch SHA-1 from bundle' '
 
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
2.32.0.874.ge7a9d58bfcf

