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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22ECC48BE5
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 03:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66D95613E2
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 03:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhFQDTq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 23:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhFQDTo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 23:19:44 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A15BC061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 20:17:37 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id o88-20020a17090a0a61b029016eeb2adf66so5061127pjo.4
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 20:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oSKUFQ1vYuG2jSfxNl+2KWKA1AfbLn3DVEYjeCncEo4=;
        b=Mi9pVU6o/3yln5PlrD0u7Ryff4Ma5+9z5A2yY+RWBGH5T2+/DvL3ztskZ0TrSTAxt3
         rrGrWjh1tQmoI662E8pios5jEj7mOjgE7LUZNfhKZJpYXlPl7f/ZGDyq/P91kdg9ZEbO
         /CdBQW6zgwbwuLT47lI68p2GTi/CVgojzoKkuTDwy88DAWBeqwA3OvWt7+IkVrqFFwMp
         A41B7UZCst5BblFtHWE4ODsxdf6ntxqMbuyWpJ5qhNl6GIG+COncU2a8Os5XB0Is2zGr
         NIdt81zWMAtnBxIqftnkFGRo6np50zlcZN+e7yFWeIlkl9FMaijwejL9W9unxvhhHf+B
         h+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oSKUFQ1vYuG2jSfxNl+2KWKA1AfbLn3DVEYjeCncEo4=;
        b=IsGAWpNxLpACaSZQKn0h/JawU6bvKMrd711Uh8AhHy7kkxxXVgqpr4YFJaHisR5nOl
         nDMiYfuJq0Ab2FEeE+jpafYkrTwnrLaYsdfiGyBGp+z8RAMEmiTpcWy14+Kky3CsSvD0
         9CWgN6138/E+7q0MIOmkibyrWmJmegv2GxwHMy+Nq2+UxEivbUegziX9+qyBSswEcsc0
         yIV9AsX81/qgwKuLstxMB0QT0r3sMrw0/W4mFPgyzqPA2IK7gyzI6M3WgKJrufpQCuR5
         /4j/3KyVTFPSY1o7lUZYVq/2BHp9HI3RJK/h/+hM+HBO93nFiVOutGe+lUl0dmHNspC4
         Mchg==
X-Gm-Message-State: AOAM533r8gBLB4HRxrIDknis5PfLndLZ89JVKU+Ookr+MtQUpw3CdTuH
        0yuqe/4G28QpXsifnTzSUK8=
X-Google-Smtp-Source: ABdhPJyfuKENB2t+c6YWxD+qs8wYM6AbpZghb0jhmPX1vb6crX1Ud1F/ghpMKPszfFO6ZwG4gvztuQ==
X-Received: by 2002:a17:902:7085:b029:114:eb3f:fe29 with SMTP id z5-20020a1709027085b0290114eb3ffe29mr2586503plk.40.1623899855815;
        Wed, 16 Jun 2021 20:17:35 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.151])
        by smtp.gmail.com with ESMTPSA id ei10sm3301726pjb.8.2021.06.16.20.17.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jun 2021 20:17:35 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH 2/4] test: compare raw output, not mangle tabs and spaces
Date:   Thu, 17 Jun 2021 11:17:25 +0800
Message-Id: <20210617031727.81105-2-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc0.27.g7b1e85181b
In-Reply-To: <20210617031727.81105-1-zhiyou.jx@alibaba-inc.com>
References: <20210617031727.81105-1-zhiyou.jx@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before comparing with the expect file, we used to call function
"make_user_friendly_and_stable_output" to filter out trailing spaces in
output.  Ævar recommends using pattern "s/Z$//" to prepare expect file,
and then compare it with raw output.

Since we have fixed the issue of occasionally missing the clear-to-eol
suffix when displaying sideband #2 messages, it is safe and stable to
test against raw output.

Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5411/common-functions.sh                   |   9 +-
 t/t5411/test-0000-standard-git-push.sh        |  82 +++----
 .../test-0001-standard-git-push--porcelain.sh |  90 ++++----
 ...st-0003-pre-receive-declined--porcelain.sh |   8 +-
 t/t5411/test-0011-no-hook-error.sh            |  40 ++--
 t/t5411/test-0012-no-hook-error--porcelain.sh |  42 ++--
 t/t5411/test-0013-bad-protocol.sh             |  62 +++---
 t/t5411/test-0014-bad-protocol--porcelain.sh  |  80 +++----
 t/t5411/test-0020-report-ng.sh                |  32 +--
 t/t5411/test-0021-report-ng--porcelain.sh     |  36 ++--
 t/t5411/test-0022-report-unexpect-ref.sh      |  26 +--
 ...est-0023-report-unexpect-ref--porcelain.sh |  28 +--
 t/t5411/test-0024-report-unknown-ref.sh       |  18 +-
 ...test-0025-report-unknown-ref--porcelain.sh |  20 +-
 t/t5411/test-0026-push-options.sh             |  58 ++---
 t/t5411/test-0027-push-options--porcelain.sh  |  62 +++---
 t/t5411/test-0030-report-ok.sh                |  20 +-
 t/t5411/test-0031-report-ok--porcelain.sh     |  22 +-
 t/t5411/test-0032-report-with-options.sh      | 186 ++++++++--------
 ...est-0033-report-with-options--porcelain.sh | 200 +++++++++---------
 t/t5411/test-0034-report-ft.sh                |  22 +-
 t/t5411/test-0035-report-ft--porcelain.sh     |  24 +--
 ...t-0036-report-multi-rewrite-for-one-ref.sh | 132 ++++++------
 ...rt-multi-rewrite-for-one-ref--porcelain.sh | 138 ++++++------
 t/t5411/test-0038-report-mixed-refs.sh        |  74 +++----
 .../test-0039-report-mixed-refs--porcelain.sh |  76 +++----
 t/t5411/test-0040-process-all-refs.sh         |  80 +++----
 .../test-0041-process-all-refs--porcelain.sh  |  82 +++----
 ...t-0050-proc-receive-refs-with-modifiers.sh |  90 ++++----
 t/t5548-push-porcelain.sh                     |  54 ++---
 t/t6020-bundle-misc.sh                        |  45 ++--
 31 files changed, 972 insertions(+), 966 deletions(-)

diff --git a/t/t5411/common-functions.sh b/t/t5411/common-functions.sh
index 6694858e18..6c347b4caa 100644
--- a/t/t5411/common-functions.sh
+++ b/t/t5411/common-functions.sh
@@ -33,17 +33,14 @@ create_commits_in () {
 
 # Format the output of git-push, git-show-ref and other commands to make a
 # user-friendly and stable text.  We can easily prepare the expect text
-# without having to worry about future changes of the commit ID and spaces
+# without having to worry about changes of the commit ID (full or abbrev.)
 # of the output.  Single quotes are replaced with double quotes, because
 # it is boring to prepare unquoted single quotes in expect text.  We also
 # remove some locale error messages. The emitted human-readable errors are
 # redundant to the more machine-readable output the tests already assert.
 make_user_friendly_and_stable_output () {
 	sed \
-		-e "s/  *\$//" \
-		-e "s/  */ /g" \
 		-e "s/'/\"/g" \
-		-e "s/	/    /g" \
 		-e "s/$A/<COMMIT-A>/g" \
 		-e "s/$B/<COMMIT-B>/g" \
 		-e "s/$TAG/<TAG-v123>/g" \
@@ -59,6 +56,10 @@ filter_out_user_friendly_and_stable_output () {
 		sed -n ${1+"$@"}
 }
 
+format_and_save_expect () {
+	sed -e 's/^> //' -e 's/Z$//' >expect
+}
+
 test_cmp_refs () {
 	indir=
 	if test "$1" = "-C"
diff --git a/t/t5411/test-0000-standard-git-push.sh b/t/t5411/test-0000-standard-git-push.sh
index e1e0175c12..d8aafc235c 100644
--- a/t/t5411/test-0000-standard-git-push.sh
+++ b/t/t5411/test-0000-standard-git-push.sh
@@ -7,16 +7,16 @@ test_expect_success "git-push ($PROTOCOL)" '
 		HEAD:refs/heads/next \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	remote: # post-receive hook
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	To <URL/of/upstream.git>
-	 <OID-A>..<OID-B> <COMMIT-B> -> main
-	 * [new branch] HEAD -> next
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/main        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next        Z
+	> To <URL/of/upstream.git>
+	>    <OID-A>..<OID-B>  <COMMIT-B> -> main
+	>  * [new branch]      HEAD -> next
 	EOF
 	test_cmp expect actual &&
 
@@ -38,10 +38,10 @@ test_expect_success "git-push --atomic ($PROTOCOL)" '
 		-e "/^To / { p; }" \
 		-e "/^ ! / { p; }" \
 		<out-$test_count >actual &&
-	cat >expect <<-EOF &&
-	To <URL/of/upstream.git>
-	 ! [rejected] main -> main (non-fast-forward)
-	 ! [rejected] <COMMIT-B> -> next (atomic push failed)
+	format_and_save_expect <<-EOF &&
+	> To <URL/of/upstream.git>
+	>  ! [rejected]        main -> main (non-fast-forward)
+	>  ! [rejected]        <COMMIT-B> -> next (atomic push failed)
 	EOF
 	test_cmp expect actual &&
 
@@ -63,14 +63,14 @@ test_expect_success "non-fast-forward git-push ($PROTOCOL)" '
 		$B:refs/heads/next \
 		>out-$test_count 2>&1 &&
 	make_user_friendly_and_stable_output <out-$test_count >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/next
-	remote: # post-receive hook
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/next
-	To <URL/of/upstream.git>
-	 <OID-A>..<OID-B> <COMMIT-B> -> next
-	 ! [rejected] main -> main (non-fast-forward)
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/next        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/next        Z
+	> To <URL/of/upstream.git>
+	>    <OID-A>..<OID-B>  <COMMIT-B> -> next
+	>  ! [rejected]        main -> main (non-fast-forward)
 	EOF
 	test_cmp expect actual &&
 
@@ -92,25 +92,25 @@ test_expect_success "git-push -f ($PROTOCOL)" '
 		HEAD:refs/heads/a/b/c \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <COMMIT-B> <COMMIT-A> refs/heads/main
-	remote: pre-receive< <COMMIT-B> <ZERO-OID> refs/heads/next
-	remote: pre-receive< <ZERO-OID> <TAG-v123> refs/tags/v123
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/review/main/topic
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/a/b/c
-	remote: # post-receive hook
-	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/heads/main
-	remote: post-receive< <COMMIT-B> <ZERO-OID> refs/heads/next
-	remote: post-receive< <ZERO-OID> <TAG-v123> refs/tags/v123
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/main/topic
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/a/b/c
-	To <URL/of/upstream.git>
-	 + <OID-B>...<OID-A> main -> main (forced update)
-	 - [deleted] next
-	 * [new tag] v123 -> v123
-	 * [new reference] main -> refs/review/main/topic
-	 * [new branch] HEAD -> a/b/c
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <COMMIT-B> <COMMIT-A> refs/heads/main        Z
+	> remote: pre-receive< <COMMIT-B> <ZERO-OID> refs/heads/next        Z
+	> remote: pre-receive< <ZERO-OID> <TAG-v123> refs/tags/v123        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/review/main/topic        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/a/b/c        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <COMMIT-B> <COMMIT-A> refs/heads/main        Z
+	> remote: post-receive< <COMMIT-B> <ZERO-OID> refs/heads/next        Z
+	> remote: post-receive< <ZERO-OID> <TAG-v123> refs/tags/v123        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/main/topic        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/a/b/c        Z
+	> To <URL/of/upstream.git>
+	>  + <OID-B>...<OID-A> main -> main (forced update)
+	>  - [deleted]         next
+	>  * [new tag]         v123 -> v123
+	>  * [new reference]   main -> refs/review/main/topic
+	>  * [new branch]      HEAD -> a/b/c
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0001-standard-git-push--porcelain.sh b/t/t5411/test-0001-standard-git-push--porcelain.sh
index bcbda72341..2078d0a027 100644
--- a/t/t5411/test-0001-standard-git-push--porcelain.sh
+++ b/t/t5411/test-0001-standard-git-push--porcelain.sh
@@ -7,17 +7,17 @@ test_expect_success "git-push ($PROTOCOL/porcelain)" '
 		HEAD:refs/heads/next \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	remote: # post-receive hook
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	To <URL/of/upstream.git>
-	     <COMMIT-B>:refs/heads/main    <OID-A>..<OID-B>
-	*    HEAD:refs/heads/next    [new branch]
-	Done
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/main        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next        Z
+	> To <URL/of/upstream.git>
+	>  	<COMMIT-B>:refs/heads/main	<OID-A>..<OID-B>
+	> *	HEAD:refs/heads/next	[new branch]
+	> Done
 	EOF
 	test_cmp expect actual &&
 
@@ -38,12 +38,12 @@ test_expect_success "git-push --atomic ($PROTOCOL/porcelain)" '
 	filter_out_user_friendly_and_stable_output \
 		-e "s/^# GETTEXT POISON #//" \
 		-e "/^To / { p; }" \
-		-e "/^! / { p; }" \
+		-e "/^!/ { p; }" \
 		<out-$test_count >actual &&
-	cat >expect <<-EOF &&
-	To <URL/of/upstream.git>
-	!    refs/heads/main:refs/heads/main    [rejected] (non-fast-forward)
-	!    <COMMIT-B>:refs/heads/next    [rejected] (atomic push failed)
+	format_and_save_expect <<-EOF &&
+	> To <URL/of/upstream.git>
+	> !	refs/heads/main:refs/heads/main	[rejected] (non-fast-forward)
+	> !	<COMMIT-B>:refs/heads/next	[rejected] (atomic push failed)
 	EOF
 	test_cmp expect actual &&
 
@@ -65,15 +65,15 @@ test_expect_success "non-fast-forward git-push ($PROTOCOL/porcelain)" '
 		$B:refs/heads/next \
 		>out-$test_count 2>&1 &&
 	make_user_friendly_and_stable_output <out-$test_count >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/next
-	remote: # post-receive hook
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/next
-	To <URL/of/upstream.git>
-	     <COMMIT-B>:refs/heads/next    <OID-A>..<OID-B>
-	!    refs/heads/main:refs/heads/main    [rejected] (non-fast-forward)
-	Done
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/next        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/next        Z
+	> To <URL/of/upstream.git>
+	>  	<COMMIT-B>:refs/heads/next	<OID-A>..<OID-B>
+	> !	refs/heads/main:refs/heads/main	[rejected] (non-fast-forward)
+	> Done
 	EOF
 	test_cmp expect actual &&
 
@@ -95,26 +95,26 @@ test_expect_success "git-push -f ($PROTOCOL/porcelain)" '
 		HEAD:refs/heads/a/b/c \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <COMMIT-B> <COMMIT-A> refs/heads/main
-	remote: pre-receive< <COMMIT-B> <ZERO-OID> refs/heads/next
-	remote: pre-receive< <ZERO-OID> <TAG-v123> refs/tags/v123
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/review/main/topic
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/a/b/c
-	remote: # post-receive hook
-	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/heads/main
-	remote: post-receive< <COMMIT-B> <ZERO-OID> refs/heads/next
-	remote: post-receive< <ZERO-OID> <TAG-v123> refs/tags/v123
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/main/topic
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/a/b/c
-	To <URL/of/upstream.git>
-	+    refs/heads/main:refs/heads/main    <OID-B>...<OID-A> (forced update)
-	-    :refs/heads/next    [deleted]
-	*    refs/tags/v123:refs/tags/v123    [new tag]
-	*    refs/heads/main:refs/review/main/topic    [new reference]
-	*    HEAD:refs/heads/a/b/c    [new branch]
-	Done
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <COMMIT-B> <COMMIT-A> refs/heads/main        Z
+	> remote: pre-receive< <COMMIT-B> <ZERO-OID> refs/heads/next        Z
+	> remote: pre-receive< <ZERO-OID> <TAG-v123> refs/tags/v123        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/review/main/topic        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/a/b/c        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <COMMIT-B> <COMMIT-A> refs/heads/main        Z
+	> remote: post-receive< <COMMIT-B> <ZERO-OID> refs/heads/next        Z
+	> remote: post-receive< <ZERO-OID> <TAG-v123> refs/tags/v123        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/main/topic        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/a/b/c        Z
+	> To <URL/of/upstream.git>
+	> +	refs/heads/main:refs/heads/main	<OID-B>...<OID-A> (forced update)
+	> -	:refs/heads/next	[deleted]
+	> *	refs/tags/v123:refs/tags/v123	[new tag]
+	> *	refs/heads/main:refs/review/main/topic	[new reference]
+	> *	HEAD:refs/heads/a/b/c	[new branch]
+	> Done
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0003-pre-receive-declined--porcelain.sh b/t/t5411/test-0003-pre-receive-declined--porcelain.sh
index e9c9db5d1f..2393b04ad9 100644
--- a/t/t5411/test-0003-pre-receive-declined--porcelain.sh
+++ b/t/t5411/test-0003-pre-receive-declined--porcelain.sh
@@ -14,10 +14,10 @@ test_expect_success "git-push is declined ($PROTOCOL/porcelain)" '
 		HEAD:refs/heads/next \
 		>out-$test_count 2>&1 &&
 	make_user_friendly_and_stable_output <out-$test_count >actual &&
-	cat >expect <<-EOF &&
-	To <URL/of/upstream.git>
-	!    <COMMIT-B>:refs/heads/main    [remote rejected] (pre-receive hook declined)
-	!    HEAD:refs/heads/next    [remote rejected] (pre-receive hook declined)
+	format_and_save_expect <<-EOF &&
+	> To <URL/of/upstream.git>
+	> !	<COMMIT-B>:refs/heads/main	[remote rejected] (pre-receive hook declined)
+	> !	HEAD:refs/heads/next	[remote rejected] (pre-receive hook declined)
 	Done
 	EOF
 	test_cmp expect actual &&
diff --git a/t/t5411/test-0011-no-hook-error.sh b/t/t5411/test-0011-no-hook-error.sh
index 3ef136e6ef..d35002b1f0 100644
--- a/t/t5411/test-0011-no-hook-error.sh
+++ b/t/t5411/test-0011-no-hook-error.sh
@@ -7,16 +7,16 @@ test_expect_success "proc-receive: no hook, fail to push special ref ($PROTOCOL)
 		HEAD:refs/for/main/topic \
 		>out-$test_count 2>&1 &&
 	make_user_friendly_and_stable_output <out-$test_count >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: error: cannot find hook "proc-receive"
-	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	To <URL/of/upstream.git>
-	 * [new branch] HEAD -> next
-	 ! [remote rejected] HEAD -> refs/for/main/topic (fail to run proc-receive hook)
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: error: cannot find hook "proc-receive"        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next        Z
+	> To <URL/of/upstream.git>
+	>  * [new branch]      HEAD -> next
+	>  ! [remote rejected] HEAD -> refs/for/main/topic (fail to run proc-receive hook)
 	EOF
 	test_cmp expect actual &&
 
@@ -41,16 +41,16 @@ test_expect_success "proc-receive: no hook, all failed for atomic push ($PROTOCO
 		HEAD:next \
 		HEAD:refs/for/main/topic >out-$test_count 2>&1 &&
 	make_user_friendly_and_stable_output <out-$test_count >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: error: cannot find hook "proc-receive"
-	To <URL/of/upstream.git>
-	 ! [remote rejected] <COMMIT-B> -> main (fail to run proc-receive hook)
-	 ! [remote rejected] HEAD -> next (fail to run proc-receive hook)
-	 ! [remote rejected] HEAD -> refs/for/main/topic (fail to run proc-receive hook)
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: error: cannot find hook "proc-receive"        Z
+	> To <URL/of/upstream.git>
+	>  ! [remote rejected] <COMMIT-B> -> main (fail to run proc-receive hook)
+	>  ! [remote rejected] HEAD -> next (fail to run proc-receive hook)
+	>  ! [remote rejected] HEAD -> refs/for/main/topic (fail to run proc-receive hook)
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0012-no-hook-error--porcelain.sh b/t/t5411/test-0012-no-hook-error--porcelain.sh
index 19f66fbd7d..04468b5018 100644
--- a/t/t5411/test-0012-no-hook-error--porcelain.sh
+++ b/t/t5411/test-0012-no-hook-error--porcelain.sh
@@ -7,16 +7,16 @@ test_expect_success "proc-receive: no hook, fail to push special ref ($PROTOCOL/
 		HEAD:refs/for/main/topic \
 		>out-$test_count 2>&1 &&
 	make_user_friendly_and_stable_output <out-$test_count >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: error: cannot find hook "proc-receive"
-	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	To <URL/of/upstream.git>
-	*    HEAD:refs/heads/next    [new branch]
-	!    HEAD:refs/for/main/topic    [remote rejected] (fail to run proc-receive hook)
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: error: cannot find hook "proc-receive"        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next        Z
+	> To <URL/of/upstream.git>
+	> *	HEAD:refs/heads/next	[new branch]
+	> !	HEAD:refs/for/main/topic	[remote rejected] (fail to run proc-receive hook)
 	Done
 	EOF
 	test_cmp expect actual &&
@@ -42,17 +42,17 @@ test_expect_success "proc-receive: no hook, all failed for atomic push ($PROTOCO
 		HEAD:next \
 		HEAD:refs/for/main/topic >out-$test_count 2>&1 &&
 	make_user_friendly_and_stable_output <out-$test_count >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: error: cannot find hook "proc-receive"
-	To <URL/of/upstream.git>
-	!    <COMMIT-B>:refs/heads/main    [remote rejected] (fail to run proc-receive hook)
-	!    HEAD:refs/heads/next    [remote rejected] (fail to run proc-receive hook)
-	!    HEAD:refs/for/main/topic    [remote rejected] (fail to run proc-receive hook)
-	Done
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: error: cannot find hook "proc-receive"        Z
+	> To <URL/of/upstream.git>
+	> !	<COMMIT-B>:refs/heads/main	[remote rejected] (fail to run proc-receive hook)
+	> !	HEAD:refs/heads/next	[remote rejected] (fail to run proc-receive hook)
+	> !	HEAD:refs/for/main/topic	[remote rejected] (fail to run proc-receive hook)
+	> Done
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0013-bad-protocol.sh b/t/t5411/test-0013-bad-protocol.sh
index 095e613f6f..c08a00ded2 100644
--- a/t/t5411/test-0013-bad-protocol.sh
+++ b/t/t5411/test-0013-bad-protocol.sh
@@ -29,8 +29,8 @@ test_expect_success "proc-receive: bad protocol (unknown version, $PROTOCOL)" '
 	# message ("remote: fatal: the remote end hung up unexpectedly") which
 	# is different from the remote HTTP server with different locale settings.
 	grep "^remote: error:" <actual >actual-error &&
-	cat >expect <<-EOF &&
-	remote: error: proc-receive version "2" is not supported
+	format_and_save_expect <<-EOF &&
+	> remote: error: proc-receive version "2" is not supported        Z
 	EOF
 	test_cmp expect actual-error &&
 
@@ -208,17 +208,17 @@ test_expect_success "proc-receive: bad protocol (no report, $PROTOCOL)" '
 		HEAD:refs/heads/next \
 		HEAD:refs/for/main/topic >out-$test_count 2>&1 &&
 	make_user_friendly_and_stable_output <out-$test_count >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	To <URL/of/upstream.git>
-	 * [new branch] HEAD -> next
-	 ! [remote rejected] HEAD -> refs/for/main/topic (proc-receive failed to report status)
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next        Z
+	> To <URL/of/upstream.git>
+	>  * [new branch]      HEAD -> next
+	>  ! [remote rejected] HEAD -> refs/for/main/topic (proc-receive failed to report status)
 	EOF
 	test_cmp expect actual &&
 
@@ -251,15 +251,15 @@ test_expect_success "proc-receive: bad protocol (no ref, $PROTOCOL)" '
 		HEAD:refs/for/main/topic\
 		>out-$test_count 2>&1 &&
 	make_user_friendly_and_stable_output <out-$test_count >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive> ok
-	remote: error: proc-receive reported incomplete status line: "ok"
-	To <URL/of/upstream.git>
-	 ! [remote rejected] HEAD -> refs/for/main/topic (proc-receive failed to report status)
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive> ok        Z
+	> remote: error: proc-receive reported incomplete status line: "ok"        Z
+	> To <URL/of/upstream.git>
+	>  ! [remote rejected] HEAD -> refs/for/main/topic (proc-receive failed to report status)
 	EOF
 	test_cmp expect actual &&
 
@@ -284,15 +284,15 @@ test_expect_success "proc-receive: bad protocol (unknown status, $PROTOCOL)" '
 			HEAD:refs/for/main/topic \
 			>out-$test_count 2>&1 &&
 	make_user_friendly_and_stable_output <out-$test_count >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive> xx refs/for/main/topic
-	remote: error: proc-receive reported bad status "xx" on ref "refs/for/main/topic"
-	To <URL/of/upstream.git>
-	 ! [remote rejected] HEAD -> refs/for/main/topic (proc-receive failed to report status)
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive> xx refs/for/main/topic        Z
+	> remote: error: proc-receive reported bad status "xx" on ref "refs/for/main/topic"        Z
+	> To <URL/of/upstream.git>
+	>  ! [remote rejected] HEAD -> refs/for/main/topic (proc-receive failed to report status)
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0014-bad-protocol--porcelain.sh b/t/t5411/test-0014-bad-protocol--porcelain.sh
index a44649789c..3eaa597e0f 100644
--- a/t/t5411/test-0014-bad-protocol--porcelain.sh
+++ b/t/t5411/test-0014-bad-protocol--porcelain.sh
@@ -20,7 +20,7 @@ test_expect_success "proc-receive: bad protocol (unknown version, $PROTOCOL/porc
 		<actual >actual-report &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
-	!    HEAD:refs/for/main/topic    [remote rejected] (fail to run proc-receive hook)
+	!	HEAD:refs/for/main/topic	[remote rejected] (fail to run proc-receive hook)
 	Done
 	EOF
 	test_cmp expect actual-report &&
@@ -29,8 +29,8 @@ test_expect_success "proc-receive: bad protocol (unknown version, $PROTOCOL/porc
 	# message ("remote: fatal: the remote end hung up unexpectedly") which
 	# is different from the remote HTTP server with different locale settings.
 	grep "^remote: error:" <actual >actual-error &&
-	cat >expect <<-EOF &&
-	remote: error: proc-receive version "2" is not supported
+	format_and_save_expect <<-EOF &&
+	> remote: error: proc-receive version "2" is not supported        Z
 	EOF
 	test_cmp expect actual-error &&
 
@@ -58,7 +58,7 @@ test_expect_success "proc-receive: bad protocol (hook --die-read-version, $PROTO
 		<out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
-	!    HEAD:refs/for/main/topic    [remote rejected] (fail to run proc-receive hook)
+	!	HEAD:refs/for/main/topic	[remote rejected] (fail to run proc-receive hook)
 	Done
 	EOF
 	test_cmp expect actual &&
@@ -89,7 +89,7 @@ test_expect_success "proc-receive: bad protocol (hook --die-write-version, $PROT
 		<out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
-	!    HEAD:refs/for/main/topic    [remote rejected] (fail to run proc-receive hook)
+	!	HEAD:refs/for/main/topic	[remote rejected] (fail to run proc-receive hook)
 	Done
 	EOF
 	test_cmp expect actual &&
@@ -120,7 +120,7 @@ test_expect_success "proc-receive: bad protocol (hook --die-read-commands, $PROT
 		<out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
-	!    HEAD:refs/for/main/topic    [remote rejected] (fail to run proc-receive hook)
+	!	HEAD:refs/for/main/topic	[remote rejected] (fail to run proc-receive hook)
 	Done
 	EOF
 	test_cmp expect actual &&
@@ -152,7 +152,7 @@ test_expect_success "proc-receive: bad protocol (hook --die-read-push-options, $
 		<out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
-	!    HEAD:refs/for/main/topic    [remote rejected] (fail to run proc-receive hook)
+	!	HEAD:refs/for/main/topic	[remote rejected] (fail to run proc-receive hook)
 	Done
 	EOF
 	test_cmp expect actual &&
@@ -182,7 +182,7 @@ test_expect_success "proc-receive: bad protocol (hook --die-write-report, $PROTO
 		<out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
-	!    HEAD:refs/for/main/topic    [remote rejected] (fail to run proc-receive hook)
+	!	HEAD:refs/for/main/topic	[remote rejected] (fail to run proc-receive hook)
 	Done
 	EOF
 	test_cmp expect actual &&
@@ -208,18 +208,18 @@ test_expect_success "proc-receive: bad protocol (no report, $PROTOCOL/porcelain)
 		HEAD:refs/heads/next \
 		HEAD:refs/for/main/topic >out-$test_count 2>&1 &&
 	make_user_friendly_and_stable_output <out-$test_count >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	To <URL/of/upstream.git>
-	*    HEAD:refs/heads/next    [new branch]
-	!    HEAD:refs/for/main/topic    [remote rejected] (proc-receive failed to report status)
-	Done
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next        Z
+	> To <URL/of/upstream.git>
+	> *	HEAD:refs/heads/next	[new branch]
+	> !	HEAD:refs/for/main/topic	[remote rejected] (proc-receive failed to report status)
+	> Done
 	EOF
 	test_cmp expect actual &&
 
@@ -251,16 +251,16 @@ test_expect_success "proc-receive: bad protocol (no ref, $PROTOCOL/porcelain)" '
 		HEAD:refs/for/main/topic\
 		>out-$test_count 2>&1 &&
 	make_user_friendly_and_stable_output <out-$test_count >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive> ok
-	remote: error: proc-receive reported incomplete status line: "ok"
-	To <URL/of/upstream.git>
-	!    HEAD:refs/for/main/topic    [remote rejected] (proc-receive failed to report status)
-	Done
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive> ok        Z
+	> remote: error: proc-receive reported incomplete status line: "ok"        Z
+	> To <URL/of/upstream.git>
+	> !	HEAD:refs/for/main/topic	[remote rejected] (proc-receive failed to report status)
+	> Done
 	EOF
 	test_cmp expect actual &&
 
@@ -285,16 +285,16 @@ test_expect_success "proc-receive: bad protocol (unknown status, $PROTOCOL/porce
 			HEAD:refs/for/main/topic \
 			>out-$test_count 2>&1 &&
 	make_user_friendly_and_stable_output <out-$test_count >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive> xx refs/for/main/topic
-	remote: error: proc-receive reported bad status "xx" on ref "refs/for/main/topic"
-	To <URL/of/upstream.git>
-	!    HEAD:refs/for/main/topic    [remote rejected] (proc-receive failed to report status)
-	Done
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive> xx refs/for/main/topic        Z
+	> remote: error: proc-receive reported bad status "xx" on ref "refs/for/main/topic"        Z
+	> To <URL/of/upstream.git>
+	> !	HEAD:refs/for/main/topic	[remote rejected] (proc-receive failed to report status)
+	> Done
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0020-report-ng.sh b/t/t5411/test-0020-report-ng.sh
index ad2c8f6535..e915dbc28d 100644
--- a/t/t5411/test-0020-report-ng.sh
+++ b/t/t5411/test-0020-report-ng.sh
@@ -14,14 +14,14 @@ test_expect_success "proc-receive: fail to update (ng, no message, $PROTOCOL)" '
 		HEAD:refs/for/main/topic \
 		>out-$test_count 2>&1 &&
 	make_user_friendly_and_stable_output <out-$test_count >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive> ng refs/for/main/topic
-	To <URL/of/upstream.git>
-	 ! [remote rejected] HEAD -> refs/for/main/topic (failed)
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive> ng refs/for/main/topic        Z
+	> To <URL/of/upstream.git>
+	>  ! [remote rejected] HEAD -> refs/for/main/topic (failed)
 	EOF
 	test_cmp expect actual &&
 
@@ -46,14 +46,14 @@ test_expect_success "proc-receive: fail to update (ng, with message, $PROTOCOL)"
 		HEAD:refs/for/main/topic \
 		>out-$test_count 2>&1 &&
 	make_user_friendly_and_stable_output <out-$test_count >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive> ng refs/for/main/topic error msg
-	To <URL/of/upstream.git>
-	 ! [remote rejected] HEAD -> refs/for/main/topic (error msg)
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive> ng refs/for/main/topic error msg        Z
+	> To <URL/of/upstream.git>
+	>  ! [remote rejected] HEAD -> refs/for/main/topic (error msg)
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0021-report-ng--porcelain.sh b/t/t5411/test-0021-report-ng--porcelain.sh
index d8ae9d3414..2a392e099b 100644
--- a/t/t5411/test-0021-report-ng--porcelain.sh
+++ b/t/t5411/test-0021-report-ng--porcelain.sh
@@ -14,15 +14,15 @@ test_expect_success "proc-receive: fail to update (ng, no message, $PROTOCOL/por
 		HEAD:refs/for/main/topic \
 		>out-$test_count 2>&1 &&
 	make_user_friendly_and_stable_output <out-$test_count >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive> ng refs/for/main/topic
-	To <URL/of/upstream.git>
-	!    HEAD:refs/for/main/topic    [remote rejected] (failed)
-	Done
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive> ng refs/for/main/topic        Z
+	> To <URL/of/upstream.git>
+	> !	HEAD:refs/for/main/topic	[remote rejected] (failed)
+	> Done
 	EOF
 	test_cmp expect actual &&
 
@@ -47,15 +47,15 @@ test_expect_success "proc-receive: fail to update (ng, with message, $PROTOCOL/p
 		HEAD:refs/for/main/topic \
 		>out-$test_count 2>&1 &&
 	make_user_friendly_and_stable_output <out-$test_count >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive> ng refs/for/main/topic error msg
-	To <URL/of/upstream.git>
-	!    HEAD:refs/for/main/topic    [remote rejected] (error msg)
-	Done
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive> ng refs/for/main/topic error msg        Z
+	> To <URL/of/upstream.git>
+	> !	HEAD:refs/for/main/topic	[remote rejected] (error msg)
+	> Done
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0022-report-unexpect-ref.sh b/t/t5411/test-0022-report-unexpect-ref.sh
index dbed467186..a2ce7ebdf6 100644
--- a/t/t5411/test-0022-report-unexpect-ref.sh
+++ b/t/t5411/test-0022-report-unexpect-ref.sh
@@ -15,19 +15,19 @@ test_expect_success "proc-receive: report unexpected ref ($PROTOCOL)" '
 		HEAD:refs/for/main/topic \
 		>out-$test_count 2>&1 &&
 	make_user_friendly_and_stable_output <out-$test_count >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive> ok refs/heads/main
-	remote: error: proc-receive reported status on unexpected ref: refs/heads/main
-	remote: # post-receive hook
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
-	To <URL/of/upstream.git>
-	 <OID-A>..<OID-B> <COMMIT-B> -> main
-	 ! [remote rejected] HEAD -> refs/for/main/topic (proc-receive failed to report status)
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive> ok refs/heads/main        Z
+	> remote: error: proc-receive reported status on unexpected ref: refs/heads/main        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/main        Z
+	> To <URL/of/upstream.git>
+	>    <OID-A>..<OID-B>  <COMMIT-B> -> main
+	>  ! [remote rejected] HEAD -> refs/for/main/topic (proc-receive failed to report status)
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0023-report-unexpect-ref--porcelain.sh b/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
index e89096fa13..4e56b163f8 100644
--- a/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
+++ b/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
@@ -15,20 +15,20 @@ test_expect_success "proc-receive: report unexpected ref ($PROTOCOL/porcelain)"
 		HEAD:refs/for/main/topic \
 		>out-$test_count 2>&1 &&
 	make_user_friendly_and_stable_output <out-$test_count >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive> ok refs/heads/main
-	remote: error: proc-receive reported status on unexpected ref: refs/heads/main
-	remote: # post-receive hook
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
-	To <URL/of/upstream.git>
-	     <COMMIT-B>:refs/heads/main    <OID-A>..<OID-B>
-	!    HEAD:refs/for/main/topic    [remote rejected] (proc-receive failed to report status)
-	Done
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive> ok refs/heads/main        Z
+	> remote: error: proc-receive reported status on unexpected ref: refs/heads/main        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/main        Z
+	> To <URL/of/upstream.git>
+	>  	<COMMIT-B>:refs/heads/main	<OID-A>..<OID-B>
+	> !	HEAD:refs/for/main/topic	[remote rejected] (proc-receive failed to report status)
+	> Done
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0024-report-unknown-ref.sh b/t/t5411/test-0024-report-unknown-ref.sh
index 77204244b8..af055aa086 100644
--- a/t/t5411/test-0024-report-unknown-ref.sh
+++ b/t/t5411/test-0024-report-unknown-ref.sh
@@ -14,15 +14,15 @@ test_expect_success "proc-receive: report unknown reference ($PROTOCOL)" '
 		HEAD:refs/for/a/b/c/my/topic \
 		>out-$test_count 2>&1 &&
 	make_user_friendly_and_stable_output <out-$test_count >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
-	remote: proc-receive> ok refs/for/main/topic
-	remote: error: proc-receive reported status on unknown ref: refs/for/main/topic
-	To <URL/of/upstream.git>
-	 ! [remote rejected] HEAD -> refs/for/a/b/c/my/topic (proc-receive failed to report status)
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: error: proc-receive reported status on unknown ref: refs/for/main/topic        Z
+	> To <URL/of/upstream.git>
+	>  ! [remote rejected] HEAD -> refs/for/a/b/c/my/topic (proc-receive failed to report status)
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0025-report-unknown-ref--porcelain.sh b/t/t5411/test-0025-report-unknown-ref--porcelain.sh
index eeb1ce6b2c..99601ca321 100644
--- a/t/t5411/test-0025-report-unknown-ref--porcelain.sh
+++ b/t/t5411/test-0025-report-unknown-ref--porcelain.sh
@@ -14,16 +14,16 @@ test_expect_success "proc-receive: report unknown reference ($PROTOCOL/porcelain
 		HEAD:refs/for/a/b/c/my/topic \
 		>out-$test_count 2>&1 &&
 	make_user_friendly_and_stable_output <out-$test_count >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
-	remote: proc-receive> ok refs/for/main/topic
-	remote: error: proc-receive reported status on unknown ref: refs/for/main/topic
-	To <URL/of/upstream.git>
-	!    HEAD:refs/for/a/b/c/my/topic    [remote rejected] (proc-receive failed to report status)
-	Done
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: error: proc-receive reported status on unknown ref: refs/for/main/topic        Z
+	> To <URL/of/upstream.git>
+	> !	HEAD:refs/for/a/b/c/my/topic	[remote rejected] (proc-receive failed to report status)
+	> Done
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0026-push-options.sh b/t/t5411/test-0026-push-options.sh
index 1ec2cb95bc..fec5f95793 100644
--- a/t/t5411/test-0026-push-options.sh
+++ b/t/t5411/test-0026-push-options.sh
@@ -52,19 +52,19 @@ test_expect_success "proc-receive: ignore push-options for version 0 ($PROTOCOL)
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive> ok refs/for/main/topic
-	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	To <URL/of/upstream.git>
-	 * [new branch] HEAD -> next
-	 * [new reference] HEAD -> refs/for/main/topic
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> To <URL/of/upstream.git>
+	>  * [new branch]      HEAD -> next
+	>  * [new reference]   HEAD -> refs/for/main/topic
 	EOF
 	test_cmp expect actual &&
 
@@ -101,22 +101,22 @@ test_expect_success "proc-receive: push with options ($PROTOCOL)" '
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive: atomic push_options
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive< issue=123
-	remote: proc-receive< reviewer=user1
-	remote: proc-receive> ok refs/for/main/topic
-	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	To <URL/of/upstream.git>
-	 * [new branch] HEAD -> next
-	 * [new reference] HEAD -> refs/for/main/topic
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive: atomic push_options        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive< issue=123        Z
+	> remote: proc-receive< reviewer=user1        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> To <URL/of/upstream.git>
+	>  * [new branch]      HEAD -> next
+	>  * [new reference]   HEAD -> refs/for/main/topic
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0027-push-options--porcelain.sh b/t/t5411/test-0027-push-options--porcelain.sh
index 447fbfec0c..8fb75a8789 100644
--- a/t/t5411/test-0027-push-options--porcelain.sh
+++ b/t/t5411/test-0027-push-options--porcelain.sh
@@ -54,20 +54,20 @@ test_expect_success "proc-receive: ignore push-options for version 0 ($PROTOCOL/
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive> ok refs/for/main/topic
-	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	To <URL/of/upstream.git>
-	*    HEAD:refs/heads/next    [new branch]
-	*    HEAD:refs/for/main/topic    [new reference]
-	Done
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> To <URL/of/upstream.git>
+	> *	HEAD:refs/heads/next	[new branch]
+	> *	HEAD:refs/for/main/topic	[new reference]
+	> Done
 	EOF
 	test_cmp expect actual &&
 
@@ -105,23 +105,23 @@ test_expect_success "proc-receive: push with options ($PROTOCOL/porcelain)" '
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive: atomic push_options
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive< issue=123
-	remote: proc-receive< reviewer=user1
-	remote: proc-receive> ok refs/for/main/topic
-	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	To <URL/of/upstream.git>
-	*    HEAD:refs/heads/next    [new branch]
-	*    HEAD:refs/for/main/topic    [new reference]
-	Done
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive: atomic push_options        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive< issue=123        Z
+	> remote: proc-receive< reviewer=user1        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> To <URL/of/upstream.git>
+	> *	HEAD:refs/heads/next	[new branch]
+	> *	HEAD:refs/for/main/topic	[new reference]
+	> Done
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0030-report-ok.sh b/t/t5411/test-0030-report-ok.sh
index 8acb4f204f..a3a6278213 100644
--- a/t/t5411/test-0030-report-ok.sh
+++ b/t/t5411/test-0030-report-ok.sh
@@ -14,16 +14,16 @@ test_expect_success "proc-receive: ok ($PROTOCOL)" '
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive> ok refs/for/main/topic
-	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	To <URL/of/upstream.git>
-	 * [new reference] HEAD -> refs/for/main/topic
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> To <URL/of/upstream.git>
+	>  * [new reference]   HEAD -> refs/for/main/topic
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0031-report-ok--porcelain.sh b/t/t5411/test-0031-report-ok--porcelain.sh
index a967718046..0e175388b6 100644
--- a/t/t5411/test-0031-report-ok--porcelain.sh
+++ b/t/t5411/test-0031-report-ok--porcelain.sh
@@ -14,17 +14,17 @@ test_expect_success "proc-receive: ok ($PROTOCOL/porcelain)" '
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive> ok refs/for/main/topic
-	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	To <URL/of/upstream.git>
-	*    HEAD:refs/for/main/topic    [new reference]
-	Done
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> To <URL/of/upstream.git>
+	> *	HEAD:refs/for/main/topic	[new reference]
+	> Done
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0032-report-with-options.sh b/t/t5411/test-0032-report-with-options.sh
index 437ade012d..cd4f213a7d 100644
--- a/t/t5411/test-0032-report-with-options.sh
+++ b/t/t5411/test-0032-report-with-options.sh
@@ -15,16 +15,16 @@ test_expect_success "proc-receive: report option without matching ok ($PROTOCOL)
 		HEAD:refs/for/main/topic \
 		>out-$test_count 2>&1 &&
 	make_user_friendly_and_stable_output <out-$test_count >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive> option refname refs/pull/123/head
-	remote: proc-receive> option old-oid <COMMIT-B>
-	remote: error: proc-receive reported "option" without a matching "ok/ng" directive
-	To <URL/of/upstream.git>
-	 ! [remote rejected] HEAD -> refs/for/main/topic (proc-receive failed to report status)
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive> option refname refs/pull/123/head        Z
+	> remote: proc-receive> option old-oid <COMMIT-B>        Z
+	> remote: error: proc-receive reported "option" without a matching "ok/ng" directive        Z
+	> To <URL/of/upstream.git>
+	>  ! [remote rejected] HEAD -> refs/for/main/topic (proc-receive failed to report status)
 	EOF
 	test_cmp expect actual
 '
@@ -46,17 +46,17 @@ test_expect_success "proc-receive: report option refname ($PROTOCOL)" '
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive> ok refs/for/main/topic
-	remote: proc-receive> option refname refs/pull/123/head
-	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head
-	To <URL/of/upstream.git>
-	 * [new reference] HEAD -> refs/pull/123/head
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: proc-receive> option refname refs/pull/123/head        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head        Z
+	> To <URL/of/upstream.git>
+	>  * [new reference]   HEAD -> refs/pull/123/head
 	EOF
 	test_cmp expect actual
 '
@@ -78,18 +78,18 @@ test_expect_success "proc-receive: report option refname and forced-update ($PRO
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive> ok refs/for/main/topic
-	remote: proc-receive> option refname refs/pull/123/head
-	remote: proc-receive> option forced-update
-	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head
-	To <URL/of/upstream.git>
-	 * [new reference] HEAD -> refs/pull/123/head
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: proc-receive> option refname refs/pull/123/head        Z
+	> remote: proc-receive> option forced-update        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head        Z
+	> To <URL/of/upstream.git>
+	>  * [new reference]   HEAD -> refs/pull/123/head
 	EOF
 	test_cmp expect actual
 '
@@ -112,18 +112,18 @@ test_expect_success "proc-receive: report option refname and old-oid ($PROTOCOL)
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive> ok refs/for/main/topic
-	remote: proc-receive> option refname refs/pull/123/head
-	remote: proc-receive> option old-oid <COMMIT-B>
-	remote: # post-receive hook
-	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/123/head
-	To <URL/of/upstream.git>
-	 <OID-B>..<OID-A> HEAD -> refs/pull/123/head
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: proc-receive> option refname refs/pull/123/head        Z
+	> remote: proc-receive> option old-oid <COMMIT-B>        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/123/head        Z
+	> To <URL/of/upstream.git>
+	>    <OID-B>..<OID-A>  HEAD -> refs/pull/123/head
 	EOF
 	test_cmp expect actual
 '
@@ -145,17 +145,17 @@ test_expect_success "proc-receive: report option old-oid ($PROTOCOL)" '
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive> ok refs/for/main/topic
-	remote: proc-receive> option old-oid <COMMIT-B>
-	remote: # post-receive hook
-	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/main/topic
-	To <URL/of/upstream.git>
-	 <OID-B>..<OID-A> HEAD -> refs/for/main/topic
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: proc-receive> option old-oid <COMMIT-B>        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/main/topic        Z
+	> To <URL/of/upstream.git>
+	>    <OID-B>..<OID-A>  HEAD -> refs/for/main/topic
 	EOF
 	test_cmp expect actual
 '
@@ -178,18 +178,18 @@ test_expect_success "proc-receive: report option old-oid and new-oid ($PROTOCOL)
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive> ok refs/for/main/topic
-	remote: proc-receive> option old-oid <COMMIT-A>
-	remote: proc-receive> option new-oid <COMMIT-B>
-	remote: # post-receive hook
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/main/topic
-	To <URL/of/upstream.git>
-	 <OID-A>..<OID-B> HEAD -> refs/for/main/topic
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: proc-receive> option old-oid <COMMIT-A>        Z
+	> remote: proc-receive> option new-oid <COMMIT-B>        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/main/topic        Z
+	> To <URL/of/upstream.git>
+	>    <OID-A>..<OID-B>  HEAD -> refs/for/main/topic
 	EOF
 	test_cmp expect actual
 '
@@ -219,31 +219,31 @@ test_expect_success "proc-receive: report with multiple rewrites ($PROTOCOL)" '
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive> ok refs/for/a/b/c/topic
-	remote: proc-receive> ok refs/for/next/topic
-	remote: proc-receive> option refname refs/pull/123/head
-	remote: proc-receive> ok refs/for/main/topic
-	remote: proc-receive> option refname refs/pull/124/head
-	remote: proc-receive> option old-oid <COMMIT-B>
-	remote: proc-receive> option forced-update
-	remote: proc-receive> option new-oid <COMMIT-A>
-	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
-	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/124/head
-	To <URL/of/upstream.git>
-	 * [new reference] HEAD -> refs/pull/123/head
-	 * [new reference] HEAD -> refs/for/a/b/c/topic
-	 + <OID-B>...<OID-A> HEAD -> refs/pull/124/head (forced update)
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive> ok refs/for/a/b/c/topic        Z
+	> remote: proc-receive> ok refs/for/next/topic        Z
+	> remote: proc-receive> option refname refs/pull/123/head        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: proc-receive> option refname refs/pull/124/head        Z
+	> remote: proc-receive> option old-oid <COMMIT-B>        Z
+	> remote: proc-receive> option forced-update        Z
+	> remote: proc-receive> option new-oid <COMMIT-A>        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic        Z
+	> remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/124/head        Z
+	> To <URL/of/upstream.git>
+	>  * [new reference]   HEAD -> refs/pull/123/head
+	>  * [new reference]   HEAD -> refs/for/a/b/c/topic
+	>  + <OID-B>...<OID-A> HEAD -> refs/pull/124/head (forced update)
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0033-report-with-options--porcelain.sh b/t/t5411/test-0033-report-with-options--porcelain.sh
index 11486720ee..7433870e40 100644
--- a/t/t5411/test-0033-report-with-options--porcelain.sh
+++ b/t/t5411/test-0033-report-with-options--porcelain.sh
@@ -15,17 +15,17 @@ test_expect_success "proc-receive: report option without matching ok ($PROTOCOL/
 		HEAD:refs/for/main/topic \
 		>out-$test_count 2>&1 &&
 	make_user_friendly_and_stable_output <out-$test_count >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive> option refname refs/pull/123/head
-	remote: proc-receive> option old-oid <COMMIT-B>
-	remote: error: proc-receive reported "option" without a matching "ok/ng" directive
-	To <URL/of/upstream.git>
-	!    HEAD:refs/for/main/topic    [remote rejected] (proc-receive failed to report status)
-	Done
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive> option refname refs/pull/123/head        Z
+	> remote: proc-receive> option old-oid <COMMIT-B>        Z
+	> remote: error: proc-receive reported "option" without a matching "ok/ng" directive        Z
+	> To <URL/of/upstream.git>
+	> !	HEAD:refs/for/main/topic	[remote rejected] (proc-receive failed to report status)
+	> Done
 	EOF
 	test_cmp expect actual
 '
@@ -47,18 +47,18 @@ test_expect_success "proc-receive: report option refname ($PROTOCOL/porcelain)"
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive> ok refs/for/main/topic
-	remote: proc-receive> option refname refs/pull/123/head
-	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head
-	To <URL/of/upstream.git>
-	*    HEAD:refs/pull/123/head    [new reference]
-	Done
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: proc-receive> option refname refs/pull/123/head        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head        Z
+	> To <URL/of/upstream.git>
+	> *	HEAD:refs/pull/123/head	[new reference]
+	> Done
 	EOF
 	test_cmp expect actual
 '
@@ -81,19 +81,19 @@ test_expect_success "proc-receive: report option refname and forced-update ($PRO
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive> ok refs/for/main/topic
-	remote: proc-receive> option refname refs/pull/123/head
-	remote: proc-receive> option forced-update
-	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head
-	To <URL/of/upstream.git>
-	*    HEAD:refs/pull/123/head    [new reference]
-	Done
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: proc-receive> option refname refs/pull/123/head        Z
+	> remote: proc-receive> option forced-update        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head        Z
+	> To <URL/of/upstream.git>
+	> *	HEAD:refs/pull/123/head	[new reference]
+	> Done
 	EOF
 	test_cmp expect actual
 '
@@ -116,19 +116,19 @@ test_expect_success "proc-receive: report option refname and old-oid ($PROTOCOL/
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive> ok refs/for/main/topic
-	remote: proc-receive> option refname refs/pull/123/head
-	remote: proc-receive> option old-oid <COMMIT-B>
-	remote: # post-receive hook
-	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/123/head
-	To <URL/of/upstream.git>
-	     HEAD:refs/pull/123/head    <OID-B>..<OID-A>
-	Done
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: proc-receive> option refname refs/pull/123/head        Z
+	> remote: proc-receive> option old-oid <COMMIT-B>        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/123/head        Z
+	> To <URL/of/upstream.git>
+	>  	HEAD:refs/pull/123/head	<OID-B>..<OID-A>
+	> Done
 	EOF
 	test_cmp expect actual
 '
@@ -150,18 +150,18 @@ test_expect_success "proc-receive: report option old-oid ($PROTOCOL/porcelain)"
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive> ok refs/for/main/topic
-	remote: proc-receive> option old-oid <COMMIT-B>
-	remote: # post-receive hook
-	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/main/topic
-	To <URL/of/upstream.git>
-	     HEAD:refs/for/main/topic    <OID-B>..<OID-A>
-	Done
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: proc-receive> option old-oid <COMMIT-B>        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/main/topic        Z
+	> To <URL/of/upstream.git>
+	>  	HEAD:refs/for/main/topic	<OID-B>..<OID-A>
+	> Done
 	EOF
 	test_cmp expect actual
 '
@@ -184,19 +184,19 @@ test_expect_success "proc-receive: report option old-oid and new-oid ($PROTOCOL/
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive> ok refs/for/main/topic
-	remote: proc-receive> option old-oid <COMMIT-A>
-	remote: proc-receive> option new-oid <COMMIT-B>
-	remote: # post-receive hook
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/main/topic
-	To <URL/of/upstream.git>
-	     HEAD:refs/for/main/topic    <OID-A>..<OID-B>
-	Done
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: proc-receive> option old-oid <COMMIT-A>        Z
+	> remote: proc-receive> option new-oid <COMMIT-B>        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/main/topic        Z
+	> To <URL/of/upstream.git>
+	>  	HEAD:refs/for/main/topic	<OID-A>..<OID-B>
+	> Done
 	EOF
 	test_cmp expect actual
 '
@@ -227,32 +227,32 @@ test_expect_success "proc-receive: report with multiple rewrites ($PROTOCOL/porc
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive> ok refs/for/a/b/c/topic
-	remote: proc-receive> ok refs/for/next/topic
-	remote: proc-receive> option refname refs/pull/123/head
-	remote: proc-receive> ok refs/for/main/topic
-	remote: proc-receive> option refname refs/pull/124/head
-	remote: proc-receive> option old-oid <COMMIT-B>
-	remote: proc-receive> option forced-update
-	remote: proc-receive> option new-oid <COMMIT-A>
-	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
-	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/124/head
-	To <URL/of/upstream.git>
-	*    HEAD:refs/pull/123/head    [new reference]
-	*    HEAD:refs/for/a/b/c/topic    [new reference]
-	+    HEAD:refs/pull/124/head    <OID-B>...<OID-A> (forced update)
-	Done
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive> ok refs/for/a/b/c/topic        Z
+	> remote: proc-receive> ok refs/for/next/topic        Z
+	> remote: proc-receive> option refname refs/pull/123/head        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: proc-receive> option refname refs/pull/124/head        Z
+	> remote: proc-receive> option old-oid <COMMIT-B>        Z
+	> remote: proc-receive> option forced-update        Z
+	> remote: proc-receive> option new-oid <COMMIT-A>        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic        Z
+	> remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/124/head        Z
+	> To <URL/of/upstream.git>
+	> *	HEAD:refs/pull/123/head	[new reference]
+	> *	HEAD:refs/for/a/b/c/topic	[new reference]
+	> +	HEAD:refs/pull/124/head	<OID-B>...<OID-A> (forced update)
+	> Done
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0034-report-ft.sh b/t/t5411/test-0034-report-ft.sh
index 6e0d08b327..73a47d1ffd 100644
--- a/t/t5411/test-0034-report-ft.sh
+++ b/t/t5411/test-0034-report-ft.sh
@@ -15,17 +15,17 @@ test_expect_success "proc-receive: fall throught, let receive-pack to execute ($
 		$B:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-B> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-B> refs/for/main/topic
-	remote: proc-receive> ok refs/for/main/topic
-	remote: proc-receive> option fall-through
-	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-B> refs/for/main/topic
-	To <URL/of/upstream.git>
-	 * [new reference] <COMMIT-B> -> refs/for/main/topic
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-B> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-B> refs/for/main/topic        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: proc-receive> option fall-through        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-B> refs/for/main/topic        Z
+	> To <URL/of/upstream.git>
+	>  * [new reference]   <COMMIT-B> -> refs/for/main/topic
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0035-report-ft--porcelain.sh b/t/t5411/test-0035-report-ft--porcelain.sh
index 81bae9f2ec..c350201107 100644
--- a/t/t5411/test-0035-report-ft--porcelain.sh
+++ b/t/t5411/test-0035-report-ft--porcelain.sh
@@ -15,18 +15,18 @@ test_expect_success "proc-receive: fall throught, let receive-pack to execute ($
 		$B:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-B> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-B> refs/for/main/topic
-	remote: proc-receive> ok refs/for/main/topic
-	remote: proc-receive> option fall-through
-	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-B> refs/for/main/topic
-	To <URL/of/upstream.git>
-	*    <COMMIT-B>:refs/for/main/topic    [new reference]
-	Done
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-B> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-B> refs/for/main/topic        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: proc-receive> option fall-through        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-B> refs/for/main/topic        Z
+	> To <URL/of/upstream.git>
+	> *	<COMMIT-B>:refs/for/main/topic	[new reference]
+	> Done
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh b/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
index be9b18b2b6..e3f456ca5a 100644
--- a/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
+++ b/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
@@ -39,30 +39,30 @@ test_expect_success "proc-receive: multiple rewrite for one ref, no refname for
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive> ok refs/for/main/topic
-	remote: proc-receive> option old-oid <COMMIT-A>
-	remote: proc-receive> option new-oid <COMMIT-B>
-	remote: proc-receive> ok refs/for/main/topic
-	remote: proc-receive> option refname refs/changes/24/124/1
-	remote: proc-receive> option old-oid <ZERO-OID>
-	remote: proc-receive> option new-oid <COMMIT-A>
-	remote: proc-receive> ok refs/for/main/topic
-	remote: proc-receive> option refname refs/changes/25/125/1
-	remote: proc-receive> option old-oid <COMMIT-A>
-	remote: proc-receive> option new-oid <COMMIT-B>
-	remote: # post-receive hook
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/main/topic
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/24/124/1
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/25/125/1
-	To <URL/of/upstream.git>
-	 <OID-A>..<OID-B> HEAD -> refs/for/main/topic
-	 * [new reference] HEAD -> refs/changes/24/124/1
-	 <OID-A>..<OID-B> HEAD -> refs/changes/25/125/1
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: proc-receive> option old-oid <COMMIT-A>        Z
+	> remote: proc-receive> option new-oid <COMMIT-B>        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: proc-receive> option refname refs/changes/24/124/1        Z
+	> remote: proc-receive> option old-oid <ZERO-OID>        Z
+	> remote: proc-receive> option new-oid <COMMIT-A>        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: proc-receive> option refname refs/changes/25/125/1        Z
+	> remote: proc-receive> option old-oid <COMMIT-A>        Z
+	> remote: proc-receive> option new-oid <COMMIT-B>        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/main/topic        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/24/124/1        Z
+	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/25/125/1        Z
+	> To <URL/of/upstream.git>
+	>    <OID-A>..<OID-B>  HEAD -> refs/for/main/topic
+	>  * [new reference]   HEAD -> refs/changes/24/124/1
+	>    <OID-A>..<OID-B>  HEAD -> refs/changes/25/125/1
 	EOF
 	test_cmp expect actual &&
 
@@ -113,31 +113,31 @@ test_expect_success "proc-receive: multiple rewrites for one ref, no refname for
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive> ok refs/for/main/topic
-	remote: proc-receive> option refname refs/changes/24/124/1
-	remote: proc-receive> option old-oid <ZERO-OID>
-	remote: proc-receive> option new-oid <COMMIT-A>
-	remote: proc-receive> ok refs/for/main/topic
-	remote: proc-receive> option old-oid <COMMIT-A>
-	remote: proc-receive> option new-oid <COMMIT-B>
-	remote: proc-receive> ok refs/for/main/topic
-	remote: proc-receive> option refname refs/changes/25/125/1
-	remote: proc-receive> option old-oid <COMMIT-B>
-	remote: proc-receive> option new-oid <COMMIT-A>
-	remote: proc-receive> option forced-update
-	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/24/124/1
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/main/topic
-	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/changes/25/125/1
-	To <URL/of/upstream.git>
-	 * [new reference] HEAD -> refs/changes/24/124/1
-	 <OID-A>..<OID-B> HEAD -> refs/for/main/topic
-	 + <OID-B>...<OID-A> HEAD -> refs/changes/25/125/1 (forced update)
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: proc-receive> option refname refs/changes/24/124/1        Z
+	> remote: proc-receive> option old-oid <ZERO-OID>        Z
+	> remote: proc-receive> option new-oid <COMMIT-A>        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: proc-receive> option old-oid <COMMIT-A>        Z
+	> remote: proc-receive> option new-oid <COMMIT-B>        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: proc-receive> option refname refs/changes/25/125/1        Z
+	> remote: proc-receive> option old-oid <COMMIT-B>        Z
+	> remote: proc-receive> option new-oid <COMMIT-A>        Z
+	> remote: proc-receive> option forced-update        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/24/124/1        Z
+	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/main/topic        Z
+	> remote: post-receive< <COMMIT-B> <COMMIT-A> refs/changes/25/125/1        Z
+	> To <URL/of/upstream.git>
+	>  * [new reference]   HEAD -> refs/changes/24/124/1
+	>    <OID-A>..<OID-B>  HEAD -> refs/for/main/topic
+	>  + <OID-B>...<OID-A> HEAD -> refs/changes/25/125/1 (forced update)
 	EOF
 	test_cmp expect actual &&
 
@@ -182,23 +182,23 @@ test_expect_success "proc-receive: multiple rewrites for one ref ($PROTOCOL)" '
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive> ok refs/for/main/topic
-	remote: proc-receive> option refname refs/changes/23/123/1
-	remote: proc-receive> ok refs/for/main/topic
-	remote: proc-receive> option refname refs/changes/24/124/2
-	remote: proc-receive> option old-oid <COMMIT-A>
-	remote: proc-receive> option new-oid <COMMIT-B>
-	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/23/123/1
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/24/124/2
-	To <URL/of/upstream.git>
-	 * [new reference] HEAD -> refs/changes/23/123/1
-	 <OID-A>..<OID-B> HEAD -> refs/changes/24/124/2
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: proc-receive> option refname refs/changes/23/123/1        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: proc-receive> option refname refs/changes/24/124/2        Z
+	> remote: proc-receive> option old-oid <COMMIT-A>        Z
+	> remote: proc-receive> option new-oid <COMMIT-B>        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/23/123/1        Z
+	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/24/124/2        Z
+	> To <URL/of/upstream.git>
+	>  * [new reference]   HEAD -> refs/changes/23/123/1
+	>    <OID-A>..<OID-B>  HEAD -> refs/changes/24/124/2
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh b/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
index 95fb89c031..7786079ba5 100644
--- a/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
+++ b/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
@@ -24,31 +24,31 @@ test_expect_success "proc-receive: multiple rewrite for one ref, no refname for
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive> ok refs/for/main/topic
-	remote: proc-receive> option old-oid <COMMIT-A>
-	remote: proc-receive> option new-oid <COMMIT-B>
-	remote: proc-receive> ok refs/for/main/topic
-	remote: proc-receive> option refname refs/changes/24/124/1
-	remote: proc-receive> option old-oid <ZERO-OID>
-	remote: proc-receive> option new-oid <COMMIT-A>
-	remote: proc-receive> ok refs/for/main/topic
-	remote: proc-receive> option refname refs/changes/25/125/1
-	remote: proc-receive> option old-oid <COMMIT-A>
-	remote: proc-receive> option new-oid <COMMIT-B>
-	remote: # post-receive hook
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/main/topic
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/24/124/1
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/25/125/1
-	To <URL/of/upstream.git>
-	     HEAD:refs/for/main/topic    <OID-A>..<OID-B>
-	*    HEAD:refs/changes/24/124/1    [new reference]
-	     HEAD:refs/changes/25/125/1    <OID-A>..<OID-B>
-	Done
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: proc-receive> option old-oid <COMMIT-A>        Z
+	> remote: proc-receive> option new-oid <COMMIT-B>        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: proc-receive> option refname refs/changes/24/124/1        Z
+	> remote: proc-receive> option old-oid <ZERO-OID>        Z
+	> remote: proc-receive> option new-oid <COMMIT-A>        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: proc-receive> option refname refs/changes/25/125/1        Z
+	> remote: proc-receive> option old-oid <COMMIT-A>        Z
+	> remote: proc-receive> option new-oid <COMMIT-B>        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/main/topic        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/24/124/1        Z
+	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/25/125/1        Z
+	> To <URL/of/upstream.git>
+	>  	HEAD:refs/for/main/topic	<OID-A>..<OID-B>
+	> *	HEAD:refs/changes/24/124/1	[new reference]
+	>  	HEAD:refs/changes/25/125/1	<OID-A>..<OID-B>
+	> Done
 	EOF
 	test_cmp expect actual &&
 
@@ -84,32 +84,32 @@ test_expect_success "proc-receive: multiple rewrites for one ref, no refname for
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive> ok refs/for/main/topic
-	remote: proc-receive> option refname refs/changes/24/124/1
-	remote: proc-receive> option old-oid <ZERO-OID>
-	remote: proc-receive> option new-oid <COMMIT-A>
-	remote: proc-receive> ok refs/for/main/topic
-	remote: proc-receive> option old-oid <COMMIT-A>
-	remote: proc-receive> option new-oid <COMMIT-B>
-	remote: proc-receive> ok refs/for/main/topic
-	remote: proc-receive> option refname refs/changes/25/125/1
-	remote: proc-receive> option old-oid <COMMIT-B>
-	remote: proc-receive> option new-oid <COMMIT-A>
-	remote: proc-receive> option forced-update
-	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/24/124/1
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/main/topic
-	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/changes/25/125/1
-	To <URL/of/upstream.git>
-	*    HEAD:refs/changes/24/124/1    [new reference]
-	     HEAD:refs/for/main/topic    <OID-A>..<OID-B>
-	+    HEAD:refs/changes/25/125/1    <OID-B>...<OID-A> (forced update)
-	Done
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: proc-receive> option refname refs/changes/24/124/1        Z
+	> remote: proc-receive> option old-oid <ZERO-OID>        Z
+	> remote: proc-receive> option new-oid <COMMIT-A>        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: proc-receive> option old-oid <COMMIT-A>        Z
+	> remote: proc-receive> option new-oid <COMMIT-B>        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: proc-receive> option refname refs/changes/25/125/1        Z
+	> remote: proc-receive> option old-oid <COMMIT-B>        Z
+	> remote: proc-receive> option new-oid <COMMIT-A>        Z
+	> remote: proc-receive> option forced-update        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/24/124/1        Z
+	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/main/topic        Z
+	> remote: post-receive< <COMMIT-B> <COMMIT-A> refs/changes/25/125/1        Z
+	> To <URL/of/upstream.git>
+	> *	HEAD:refs/changes/24/124/1	[new reference]
+	>  	HEAD:refs/for/main/topic	<OID-A>..<OID-B>
+	> +	HEAD:refs/changes/25/125/1	<OID-B>...<OID-A> (forced update)
+	> Done
 	EOF
 	test_cmp expect actual &&
 
@@ -139,24 +139,24 @@ test_expect_success "proc-receive: multiple rewrites for one ref ($PROTOCOL/porc
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive> ok refs/for/main/topic
-	remote: proc-receive> option refname refs/changes/23/123/1
-	remote: proc-receive> ok refs/for/main/topic
-	remote: proc-receive> option refname refs/changes/24/124/2
-	remote: proc-receive> option old-oid <COMMIT-A>
-	remote: proc-receive> option new-oid <COMMIT-B>
-	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/23/123/1
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/24/124/2
-	To <URL/of/upstream.git>
-	*    HEAD:refs/changes/23/123/1    [new reference]
-	     HEAD:refs/changes/24/124/2    <OID-A>..<OID-B>
-	Done
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: proc-receive> option refname refs/changes/23/123/1        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: proc-receive> option refname refs/changes/24/124/2        Z
+	> remote: proc-receive> option old-oid <COMMIT-A>        Z
+	> remote: proc-receive> option new-oid <COMMIT-B>        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/23/123/1        Z
+	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/24/124/2        Z
+	> To <URL/of/upstream.git>
+	> *	HEAD:refs/changes/23/123/1	[new reference]
+	>  	HEAD:refs/changes/24/124/2	<OID-A>..<OID-B>
+	> Done
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0038-report-mixed-refs.sh b/t/t5411/test-0038-report-mixed-refs.sh
index 5e005299cc..0990a3f76a 100644
--- a/t/t5411/test-0038-report-mixed-refs.sh
+++ b/t/t5411/test-0038-report-mixed-refs.sh
@@ -26,43 +26,43 @@ test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL)" '
 		HEAD:refs/for/next/topic3 \
 		>out-$test_count 2>&1 &&
 	make_user_friendly_and_stable_output <out-$test_count >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic1
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic3
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic1
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic3
-	remote: proc-receive> ok refs/for/next/topic2
-	remote: proc-receive> ng refs/for/next/topic1 fail to call Web API
-	remote: proc-receive> ok refs/for/main/topic
-	remote: proc-receive> option refname refs/for/main/topic
-	remote: proc-receive> option old-oid <COMMIT-A>
-	remote: proc-receive> option new-oid <COMMIT-B>
-	remote: # post-receive hook
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/main/topic
-	To <URL/of/upstream.git>
-	 <OID-A>..<OID-B> <COMMIT-B> -> main
-	 * [new branch] HEAD -> bar
-	 * [new branch] HEAD -> baz
-	 * [new reference] HEAD -> refs/for/next/topic2
-	 * [new branch] HEAD -> foo
-	 <OID-A>..<OID-B> HEAD -> refs/for/main/topic
-	 ! [remote rejected] HEAD -> refs/for/next/topic1 (fail to call Web API)
-	 ! [remote rejected] HEAD -> refs/for/next/topic3 (proc-receive failed to report status)
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic1        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic3        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic1        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic3        Z
+	> remote: proc-receive> ok refs/for/next/topic2        Z
+	> remote: proc-receive> ng refs/for/next/topic1 fail to call Web API        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: proc-receive> option refname refs/for/main/topic        Z
+	> remote: proc-receive> option old-oid <COMMIT-A>        Z
+	> remote: proc-receive> option new-oid <COMMIT-B>        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/main        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo        Z
+	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/main/topic        Z
+	> To <URL/of/upstream.git>
+	>    <OID-A>..<OID-B>  <COMMIT-B> -> main
+	>  * [new branch]      HEAD -> bar
+	>  * [new branch]      HEAD -> baz
+	>  * [new reference]   HEAD -> refs/for/next/topic2
+	>  * [new branch]      HEAD -> foo
+	>    <OID-A>..<OID-B>  HEAD -> refs/for/main/topic
+	>  ! [remote rejected] HEAD -> refs/for/next/topic1 (fail to call Web API)
+	>  ! [remote rejected] HEAD -> refs/for/next/topic3 (proc-receive failed to report status)
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0039-report-mixed-refs--porcelain.sh b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
index 8f891c5385..7e4d08a939 100644
--- a/t/t5411/test-0039-report-mixed-refs--porcelain.sh
+++ b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
@@ -26,44 +26,44 @@ test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL/porcel
 		HEAD:refs/for/next/topic3 \
 		>out-$test_count 2>&1 &&
 	make_user_friendly_and_stable_output <out-$test_count >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic1
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic3
-	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic1
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic3
-	remote: proc-receive> ok refs/for/next/topic2
-	remote: proc-receive> ng refs/for/next/topic1 fail to call Web API
-	remote: proc-receive> ok refs/for/main/topic
-	remote: proc-receive> option refname refs/for/main/topic
-	remote: proc-receive> option old-oid <COMMIT-A>
-	remote: proc-receive> option new-oid <COMMIT-B>
-	remote: # post-receive hook
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/main/topic
-	To <URL/of/upstream.git>
-	     <COMMIT-B>:refs/heads/main    <OID-A>..<OID-B>
-	*    HEAD:refs/heads/bar    [new branch]
-	*    HEAD:refs/heads/baz    [new branch]
-	*    HEAD:refs/for/next/topic2    [new reference]
-	*    HEAD:refs/heads/foo    [new branch]
-	     HEAD:refs/for/main/topic    <OID-A>..<OID-B>
-	!    HEAD:refs/for/next/topic1    [remote rejected] (fail to call Web API)
-	!    HEAD:refs/for/next/topic3    [remote rejected] (proc-receive failed to report status)
-	Done
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic1        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic3        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic1        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic3        Z
+	> remote: proc-receive> ok refs/for/next/topic2        Z
+	> remote: proc-receive> ng refs/for/next/topic1 fail to call Web API        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: proc-receive> option refname refs/for/main/topic        Z
+	> remote: proc-receive> option old-oid <COMMIT-A>        Z
+	> remote: proc-receive> option new-oid <COMMIT-B>        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/main        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo        Z
+	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/main/topic        Z
+	> To <URL/of/upstream.git>
+	>  	<COMMIT-B>:refs/heads/main	<OID-A>..<OID-B>
+	> *	HEAD:refs/heads/bar	[new branch]
+	> *	HEAD:refs/heads/baz	[new branch]
+	> *	HEAD:refs/for/next/topic2	[new reference]
+	> *	HEAD:refs/heads/foo	[new branch]
+	>  	HEAD:refs/for/main/topic	<OID-A>..<OID-B>
+	> !	HEAD:refs/for/next/topic1	[remote rejected] (fail to call Web API)
+	> !	HEAD:refs/for/next/topic3	[remote rejected] (proc-receive failed to report status)
+	> Done
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0040-process-all-refs.sh b/t/t5411/test-0040-process-all-refs.sh
index fdcdcc7c2e..f67cb2a7b3 100644
--- a/t/t5411/test-0040-process-all-refs.sh
+++ b/t/t5411/test-0040-process-all-refs.sh
@@ -50,46 +50,46 @@ test_expect_success "proc-receive: process all refs ($PROTOCOL)" '
 		HEAD:refs/for/next/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar
-	remote: pre-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo
-	remote: pre-receive< <COMMIT-B> <COMMIT-A> refs/heads/main
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar
-	remote: proc-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo
-	remote: proc-receive< <COMMIT-B> <COMMIT-A> refs/heads/main
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
-	remote: proc-receive> ok refs/heads/main
-	remote: proc-receive> option fall-through
-	remote: proc-receive> ok refs/heads/foo
-	remote: proc-receive> option fall-through
-	remote: proc-receive> ok refs/heads/bar
-	remote: proc-receive> option fall-through
-	remote: proc-receive> ok refs/for/main/topic
-	remote: proc-receive> option refname refs/pull/123/head
-	remote: proc-receive> option old-oid <COMMIT-A>
-	remote: proc-receive> option new-oid <COMMIT-B>
-	remote: proc-receive> ok refs/for/next/topic
-	remote: proc-receive> option refname refs/pull/124/head
-	remote: proc-receive> option old-oid <COMMIT-B>
-	remote: proc-receive> option new-oid <COMMIT-A>
-	remote: proc-receive> option forced-update
-	remote: # post-receive hook
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar
-	remote: post-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo
-	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/heads/main
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/pull/123/head
-	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/124/head
-	To <URL/of/upstream.git>
-	 <OID-A>..<OID-B> <COMMIT-B> -> bar
-	 - [deleted] foo
-	 + <OID-B>...<OID-A> HEAD -> main (forced update)
-	 <OID-A>..<OID-B> HEAD -> refs/pull/123/head
-	 + <OID-B>...<OID-A> HEAD -> refs/pull/124/head (forced update)
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar        Z
+	> remote: pre-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo        Z
+	> remote: pre-receive< <COMMIT-B> <COMMIT-A> refs/heads/main        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar        Z
+	> remote: proc-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo        Z
+	> remote: proc-receive< <COMMIT-B> <COMMIT-A> refs/heads/main        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic        Z
+	> remote: proc-receive> ok refs/heads/main        Z
+	> remote: proc-receive> option fall-through        Z
+	> remote: proc-receive> ok refs/heads/foo        Z
+	> remote: proc-receive> option fall-through        Z
+	> remote: proc-receive> ok refs/heads/bar        Z
+	> remote: proc-receive> option fall-through        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: proc-receive> option refname refs/pull/123/head        Z
+	> remote: proc-receive> option old-oid <COMMIT-A>        Z
+	> remote: proc-receive> option new-oid <COMMIT-B>        Z
+	> remote: proc-receive> ok refs/for/next/topic        Z
+	> remote: proc-receive> option refname refs/pull/124/head        Z
+	> remote: proc-receive> option old-oid <COMMIT-B>        Z
+	> remote: proc-receive> option new-oid <COMMIT-A>        Z
+	> remote: proc-receive> option forced-update        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar        Z
+	> remote: post-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo        Z
+	> remote: post-receive< <COMMIT-B> <COMMIT-A> refs/heads/main        Z
+	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/pull/123/head        Z
+	> remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/124/head        Z
+	> To <URL/of/upstream.git>
+	>    <OID-A>..<OID-B>  <COMMIT-B> -> bar
+	>  - [deleted]         foo
+	>  + <OID-B>...<OID-A> HEAD -> main (forced update)
+	>    <OID-A>..<OID-B>  HEAD -> refs/pull/123/head
+	>  + <OID-B>...<OID-A> HEAD -> refs/pull/124/head (forced update)
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0041-process-all-refs--porcelain.sh b/t/t5411/test-0041-process-all-refs--porcelain.sh
index 73b35fe0aa..7d1a99d3a2 100644
--- a/t/t5411/test-0041-process-all-refs--porcelain.sh
+++ b/t/t5411/test-0041-process-all-refs--porcelain.sh
@@ -50,47 +50,47 @@ test_expect_success "proc-receive: process all refs ($PROTOCOL/porcelain)" '
 		HEAD:refs/for/next/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar
-	remote: pre-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo
-	remote: pre-receive< <COMMIT-B> <COMMIT-A> refs/heads/main
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
-	remote: # proc-receive hook
-	remote: proc-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar
-	remote: proc-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo
-	remote: proc-receive< <COMMIT-B> <COMMIT-A> refs/heads/main
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
-	remote: proc-receive> ok refs/heads/main
-	remote: proc-receive> option fall-through
-	remote: proc-receive> ok refs/heads/foo
-	remote: proc-receive> option fall-through
-	remote: proc-receive> ok refs/heads/bar
-	remote: proc-receive> option fall-through
-	remote: proc-receive> ok refs/for/main/topic
-	remote: proc-receive> option refname refs/pull/123/head
-	remote: proc-receive> option old-oid <COMMIT-A>
-	remote: proc-receive> option new-oid <COMMIT-B>
-	remote: proc-receive> ok refs/for/next/topic
-	remote: proc-receive> option refname refs/pull/124/head
-	remote: proc-receive> option old-oid <COMMIT-B>
-	remote: proc-receive> option new-oid <COMMIT-A>
-	remote: proc-receive> option forced-update
-	remote: # post-receive hook
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar
-	remote: post-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo
-	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/heads/main
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/pull/123/head
-	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/124/head
-	To <URL/of/upstream.git>
-	     <COMMIT-B>:refs/heads/bar    <OID-A>..<OID-B>
-	-    :refs/heads/foo    [deleted]
-	+    HEAD:refs/heads/main    <OID-B>...<OID-A> (forced update)
-	     HEAD:refs/pull/123/head    <OID-A>..<OID-B>
-	+    HEAD:refs/pull/124/head    <OID-B>...<OID-A> (forced update)
-	Done
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar        Z
+	> remote: pre-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo        Z
+	> remote: pre-receive< <COMMIT-B> <COMMIT-A> refs/heads/main        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar        Z
+	> remote: proc-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo        Z
+	> remote: proc-receive< <COMMIT-B> <COMMIT-A> refs/heads/main        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic        Z
+	> remote: proc-receive> ok refs/heads/main        Z
+	> remote: proc-receive> option fall-through        Z
+	> remote: proc-receive> ok refs/heads/foo        Z
+	> remote: proc-receive> option fall-through        Z
+	> remote: proc-receive> ok refs/heads/bar        Z
+	> remote: proc-receive> option fall-through        Z
+	> remote: proc-receive> ok refs/for/main/topic        Z
+	> remote: proc-receive> option refname refs/pull/123/head        Z
+	> remote: proc-receive> option old-oid <COMMIT-A>        Z
+	> remote: proc-receive> option new-oid <COMMIT-B>        Z
+	> remote: proc-receive> ok refs/for/next/topic        Z
+	> remote: proc-receive> option refname refs/pull/124/head        Z
+	> remote: proc-receive> option old-oid <COMMIT-B>        Z
+	> remote: proc-receive> option new-oid <COMMIT-A>        Z
+	> remote: proc-receive> option forced-update        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar        Z
+	> remote: post-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo        Z
+	> remote: post-receive< <COMMIT-B> <COMMIT-A> refs/heads/main        Z
+	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/pull/123/head        Z
+	> remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/124/head        Z
+	> To <URL/of/upstream.git>
+	>  	<COMMIT-B>:refs/heads/bar	<OID-A>..<OID-B>
+	> -	:refs/heads/foo	[deleted]
+	> +	HEAD:refs/heads/main	<OID-B>...<OID-A> (forced update)
+	>  	HEAD:refs/pull/123/head	<OID-A>..<OID-B>
+	> +	HEAD:refs/pull/124/head	<OID-B>...<OID-A> (forced update)
+	> Done
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0050-proc-receive-refs-with-modifiers.sh b/t/t5411/test-0050-proc-receive-refs-with-modifiers.sh
index 7214647ada..dba544162c 100644
--- a/t/t5411/test-0050-proc-receive-refs-with-modifiers.sh
+++ b/t/t5411/test-0050-proc-receive-refs-with-modifiers.sh
@@ -29,25 +29,25 @@ test_expect_success "proc-receive: update branch and new tag ($PROTOCOL)" '
 		$B:refs/heads/main \
 		v123 >out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
-	remote: pre-receive< <ZERO-OID> <TAG-v123> refs/tags/v123
-	remote: # proc-receive hook
-	remote: proc-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
-	remote: proc-receive< <ZERO-OID> <TAG-v123> refs/tags/v123
-	remote: proc-receive> ok refs/heads/main
-	remote: proc-receive> option refname refs/pull/123/head
-	remote: proc-receive> option old-oid <COMMIT-A>
-	remote: proc-receive> option new-oid <COMMIT-B>
-	remote: proc-receive> ok refs/tags/v123
-	remote: proc-receive> option refname refs/pull/124/head
-	remote: # post-receive hook
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/pull/123/head
-	remote: post-receive< <ZERO-OID> <TAG-v123> refs/pull/124/head
-	To <URL/of/upstream.git>
-	 <OID-A>..<OID-B> <COMMIT-B> -> refs/pull/123/head
-	 * [new reference] v123 -> refs/pull/124/head
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main        Z
+	> remote: pre-receive< <ZERO-OID> <TAG-v123> refs/tags/v123        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <COMMIT-A> <COMMIT-B> refs/heads/main        Z
+	> remote: proc-receive< <ZERO-OID> <TAG-v123> refs/tags/v123        Z
+	> remote: proc-receive> ok refs/heads/main        Z
+	> remote: proc-receive> option refname refs/pull/123/head        Z
+	> remote: proc-receive> option old-oid <COMMIT-A>        Z
+	> remote: proc-receive> option new-oid <COMMIT-B>        Z
+	> remote: proc-receive> ok refs/tags/v123         Z
+	> remote: proc-receive> option refname refs/pull/124/head        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/pull/123/head        Z
+	> remote: post-receive< <ZERO-OID> <TAG-v123> refs/pull/124/head        Z
+	> To <URL/of/upstream.git>
+	>    <OID-A>..<OID-B>  <COMMIT-B> -> refs/pull/123/head
+	>  * [new reference]   v123 -> refs/pull/124/head
 	EOF
 	test_cmp expect actual &&
 
@@ -93,32 +93,32 @@ test_expect_success "proc-receive: create/delete branch, and delete tag ($PROTOC
 		$A:refs/heads/next \
 		:refs/tags/v123 >out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <COMMIT-A> <ZERO-OID> refs/heads/main
-	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/topic
-	remote: pre-receive< <TAG-v123> <ZERO-OID> refs/tags/v123
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	remote: # proc-receive hook
-	remote: proc-receive< <COMMIT-A> <ZERO-OID> refs/heads/main
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	remote: proc-receive> ok refs/heads/main
-	remote: proc-receive> option refname refs/pull/123/head
-	remote: proc-receive> option old-oid <COMMIT-A>
-	remote: proc-receive> option new-oid <ZERO-OID>
-	remote: proc-receive> ok refs/heads/next
-	remote: proc-receive> option refname refs/pull/124/head
-	remote: proc-receive> option new-oid <COMMIT-A>
-	remote: # post-receive hook
-	remote: post-receive< <COMMIT-A> <ZERO-OID> refs/pull/123/head
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/topic
-	remote: post-receive< <TAG-v123> <ZERO-OID> refs/tags/v123
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/124/head
-	To <URL/of/upstream.git>
-	 - [deleted] refs/pull/123/head
-	 <OID-A>..<OID-B> <COMMIT-B> -> topic
-	 - [deleted] v123
-	 * [new reference] <COMMIT-A> -> refs/pull/124/head
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <COMMIT-A> <ZERO-OID> refs/heads/main        Z
+	> remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/topic        Z
+	> remote: pre-receive< <TAG-v123> <ZERO-OID> refs/tags/v123        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next        Z
+	> remote: # proc-receive hook        Z
+	> remote: proc-receive< <COMMIT-A> <ZERO-OID> refs/heads/main        Z
+	> remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/heads/next        Z
+	> remote: proc-receive> ok refs/heads/main        Z
+	> remote: proc-receive> option refname refs/pull/123/head        Z
+	> remote: proc-receive> option old-oid <COMMIT-A>        Z
+	> remote: proc-receive> option new-oid <ZERO-OID>        Z
+	> remote: proc-receive> ok refs/heads/next        Z
+	> remote: proc-receive> option refname refs/pull/124/head        Z
+	> remote: proc-receive> option new-oid <COMMIT-A>        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <COMMIT-A> <ZERO-OID> refs/pull/123/head        Z
+	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/topic        Z
+	> remote: post-receive< <TAG-v123> <ZERO-OID> refs/tags/v123        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/124/head        Z
+	> To <URL/of/upstream.git>
+	>  - [deleted]         refs/pull/123/head
+	>    <OID-A>..<OID-B>  <COMMIT-B> -> topic
+	>  - [deleted]         v123
+	>  * [new reference]   <COMMIT-A> -> refs/pull/124/head
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5548-push-porcelain.sh b/t/t5548-push-porcelain.sh
index 5a761f3642..2ab7c3cf5a 100755
--- a/t/t5548-push-porcelain.sh
+++ b/t/t5548-push-porcelain.sh
@@ -45,9 +45,6 @@ create_commits_in () {
 # of the output.
 make_user_friendly_and_stable_output () {
 	sed \
-		-e "s/  *\$//" \
-		-e "s/   */ /g" \
-		-e "s/	/    /g" \
 		-e "s/$A/<COMMIT-A>/g" \
 		-e "s/$B/<COMMIT-B>/g" \
 		-e "s/$ZERO_OID/<ZERO-OID>/g" \
@@ -56,6 +53,10 @@ make_user_friendly_and_stable_output () {
 		-e "s#To $URL_PREFIX/upstream.git#To <URL/of/upstream.git>#"
 }
 
+format_and_save_expect () {
+	sed -e 's/^> //' -e 's/Z$//' >expect
+}
+
 setup_upstream_and_workbench () {
 	# Upstream  after setup : main(B)  foo(A)  bar(A)  baz(A)
 	# Workbench after setup : main(A)
@@ -111,14 +112,14 @@ run_git_push_porcelain_output_test() {
 				next
 		) >out &&
 		make_user_friendly_and_stable_output <out >actual &&
-		cat >expect <<-EOF &&
-		To <URL/of/upstream.git>
-		=    refs/heads/baz:refs/heads/baz    [up to date]
-		     <COMMIT-B>:refs/heads/bar    <OID-A>..<OID-B>
-		-    :refs/heads/foo    [deleted]
-		+    refs/heads/main:refs/heads/main    <OID-B>...<OID-A> (forced update)
-		*    refs/heads/next:refs/heads/next    [new branch]
-		Done
+		format_and_save_expect <<-EOF &&
+		> To <URL/of/upstream.git>
+		> =	refs/heads/baz:refs/heads/baz	[up to date]
+		>  	<COMMIT-B>:refs/heads/bar	<OID-A>..<OID-B>
+		> -	:refs/heads/foo	[deleted]
+		> +	refs/heads/main:refs/heads/main	<OID-B>...<OID-A> (forced update)
+		> *	refs/heads/next:refs/heads/next	[new branch]
+		> Done
 		EOF
 		test_cmp expect actual &&
 
@@ -148,12 +149,12 @@ run_git_push_porcelain_output_test() {
 				next
 		) >out &&
 		make_user_friendly_and_stable_output <out >actual &&
-		cat >expect <<-EOF &&
+		format_and_save_expect <<-EOF &&
 		To <URL/of/upstream.git>
-		=    refs/heads/next:refs/heads/next    [up to date]
-		!    refs/heads/bar:refs/heads/bar    [rejected] (non-fast-forward)
-		!    (delete):refs/heads/baz    [rejected] (atomic push failed)
-		!    refs/heads/main:refs/heads/main    [rejected] (atomic push failed)
+		> =	refs/heads/next:refs/heads/next	[up to date]
+		> !	refs/heads/bar:refs/heads/bar	[rejected] (non-fast-forward)
+		> !	(delete):refs/heads/baz	[rejected] (atomic push failed)
+		> !	refs/heads/main:refs/heads/main	[rejected] (atomic push failed)
 		Done
 		EOF
 		test_cmp expect actual &&
@@ -168,6 +169,7 @@ run_git_push_porcelain_output_test() {
 		EOF
 		test_cmp expect actual
 	'
+
 	test_expect_success "prepare pre-receive hook ($PROTOCOL)" '
 		write_script "$upstream/hooks/pre-receive" <<-EOF
 		exit 1
@@ -189,12 +191,12 @@ run_git_push_porcelain_output_test() {
 				next
 		) >out &&
 		make_user_friendly_and_stable_output <out >actual &&
-		cat >expect <<-EOF &&
+		format_and_save_expect <<-EOF &&
 		To <URL/of/upstream.git>
-		=    refs/heads/next:refs/heads/next    [up to date]
-		!    refs/heads/bar:refs/heads/bar    [remote rejected] (pre-receive hook declined)
-		!    :refs/heads/baz    [remote rejected] (pre-receive hook declined)
-		!    refs/heads/main:refs/heads/main    [remote rejected] (pre-receive hook declined)
+		> =	refs/heads/next:refs/heads/next	[up to date]
+		> !	refs/heads/bar:refs/heads/bar	[remote rejected] (pre-receive hook declined)
+		> !	:refs/heads/baz	[remote rejected] (pre-receive hook declined)
+		> !	refs/heads/main:refs/heads/main	[remote rejected] (pre-receive hook declined)
 		Done
 		EOF
 		test_cmp expect actual &&
@@ -227,12 +229,12 @@ run_git_push_porcelain_output_test() {
 				next
 		) >out &&
 		make_user_friendly_and_stable_output <out >actual &&
-		cat >expect <<-EOF &&
+		format_and_save_expect <<-EOF &&
 		To <URL/of/upstream.git>
-		=    refs/heads/next:refs/heads/next    [up to date]
-		-    :refs/heads/baz    [deleted]
-		     refs/heads/main:refs/heads/main    <OID-A>..<OID-B>
-		!    refs/heads/bar:refs/heads/bar    [rejected] (non-fast-forward)
+		> =	refs/heads/next:refs/heads/next	[up to date]
+		> -	:refs/heads/baz	[deleted]
+		>  	refs/heads/main:refs/heads/main	<OID-A>..<OID-B>
+		> !	refs/heads/bar:refs/heads/bar	[rejected] (non-fast-forward)
 		Done
 		EOF
 		test_cmp expect actual &&
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 881f72fd44..cf13bcc3c8 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -82,7 +82,7 @@ test_commit_setvar () {
 
 # Format the output of git commands to make a user-friendly and stable
 # text.  We can easily prepare the expect text without having to worry
-# about future changes of the commit ID and spaces of the output.
+# about future changes of the commit ID.
 make_user_friendly_and_stable_output () {
 	sed \
 		-e "s/${A%${A#???????}}[0-9a-f]*/<COMMIT-A>/g" \
@@ -103,8 +103,11 @@ make_user_friendly_and_stable_output () {
 		-e "s/${P%${P#???????}}[0-9a-f]*/<COMMIT-P>/g" \
 		-e "s/${TAG1%${TAG1#???????}}[0-9a-f]*/<TAG-1>/g" \
 		-e "s/${TAG2%${TAG2#???????}}[0-9a-f]*/<TAG-2>/g" \
-		-e "s/${TAG3%${TAG3#???????}}[0-9a-f]*/<TAG-3>/g" \
-		-e "s/ *\$//"
+		-e "s/${TAG3%${TAG3#???????}}[0-9a-f]*/<TAG-3>/g"
+}
+
+format_and_save_expect () {
+	sed -e 's/Z$//' >expect
 }
 
 #            (C)   (D, pull/1/head, topic/1)
@@ -179,11 +182,11 @@ test_expect_success 'create bundle from special rev: main^!' '
 
 	git bundle verify special-rev.bdl |
 		make_user_friendly_and_stable_output >actual &&
-	cat >expect <<-\EOF &&
+	format_and_save_expect <<-\EOF &&
 	The bundle contains this ref:
 	<COMMIT-P> refs/heads/main
 	The bundle requires this ref:
-	<COMMIT-O>
+	<COMMIT-O> Z
 	EOF
 	test_cmp expect actual &&
 
@@ -200,12 +203,12 @@ test_expect_success 'create bundle with --max-count option' '
 
 	git bundle verify max-count.bdl |
 		make_user_friendly_and_stable_output >actual &&
-	cat >expect <<-\EOF &&
+	format_and_save_expect <<-\EOF &&
 	The bundle contains these 2 refs:
 	<COMMIT-P> refs/heads/main
 	<TAG-1> refs/tags/v1
 	The bundle requires this ref:
-	<COMMIT-O>
+	<COMMIT-O> Z
 	EOF
 	test_cmp expect actual &&
 
@@ -225,7 +228,7 @@ test_expect_success 'create bundle with --since option' '
 
 	git bundle verify since.bdl |
 		make_user_friendly_and_stable_output >actual &&
-	cat >expect <<-\EOF &&
+	format_and_save_expect <<-\EOF &&
 	The bundle contains these 5 refs:
 	<COMMIT-P> refs/heads/main
 	<COMMIT-N> refs/heads/release
@@ -233,8 +236,8 @@ test_expect_success 'create bundle with --since option' '
 	<TAG-3> refs/tags/v3
 	<COMMIT-P> HEAD
 	The bundle requires these 2 refs:
-	<COMMIT-M>
-	<COMMIT-K>
+	<COMMIT-M> Z
+	<COMMIT-K> Z
 	EOF
 	test_cmp expect actual &&
 
@@ -293,13 +296,13 @@ test_expect_success 'create bundle 2 - has prerequisites' '
 		--stdin \
 		release <input &&
 
-	cat >expect <<-\EOF &&
+	format_and_save_expect <<-\EOF &&
 	The bundle contains this ref:
 	<COMMIT-N> refs/heads/release
 	The bundle requires these 3 refs:
-	<COMMIT-D>
-	<COMMIT-E>
-	<COMMIT-G>
+	<COMMIT-D> Z
+	<COMMIT-E> Z
+	<COMMIT-G> Z
 	EOF
 
 	git bundle verify 2.bdl |
@@ -317,11 +320,11 @@ test_expect_success 'create bundle 2 - has prerequisites' '
 test_expect_success 'fail to verify bundle without prerequisites' '
 	git init --bare test1.git &&
 
-	cat >expect <<-\EOF &&
+	format_and_save_expect <<-\EOF &&
 	error: Repository lacks these prerequisite commits:
-	error: <COMMIT-D>
-	error: <COMMIT-E>
-	error: <COMMIT-G>
+	error: <COMMIT-D> Z
+	error: <COMMIT-E> Z
+	error: <COMMIT-G> Z
 	EOF
 
 	test_must_fail git -C test1.git bundle verify ../2.bdl 2>&1 |
@@ -352,13 +355,13 @@ test_expect_success 'create bundle 3 - two refs, same object' '
 		--stdin \
 		main HEAD <input &&
 
-	cat >expect <<-\EOF &&
+	format_and_save_expect <<-\EOF &&
 	The bundle contains these 2 refs:
 	<COMMIT-P> refs/heads/main
 	<COMMIT-P> HEAD
 	The bundle requires these 2 refs:
-	<COMMIT-M>
-	<COMMIT-K>
+	<COMMIT-M> Z
+	<COMMIT-K> Z
 	EOF
 
 	git bundle verify 3.bdl |
-- 
2.32.0.rc0.27.g7b1e85181b

