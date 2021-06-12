Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4A0C48BCF
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 05:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A768611CD
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 05:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhFLFKY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Jun 2021 01:10:24 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:35367 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhFLFKU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jun 2021 01:10:20 -0400
Received: by mail-pg1-f173.google.com with SMTP id o9so4142166pgd.2
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 22:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Ds7qcfZJxIZk0oTiEJ03M14O8CCPq8A8Sw5wYKxqjg=;
        b=jmxYcfajCfdiTNL5vrcTmmKFmRuAr7hNZNlLg17AoHct3SP/72440xYrQ9hWJOHpCO
         xb/A9yBQaY2bO/KGbJaMVoA9uFefxuYtxq01NBPfrQysVyYCssqBlWVm/vR5rK3MQdMG
         Le7K10U4Ig7M9xx59lMN3L12oQdg4CVSEaL5KuewZVzsac9kBmaEJM/r91nlxAIvL/xs
         odxlrH++l5ado1avzJKhAorKlmjatYOnX6ketUH3gMAIJ1Dne1Kw3cGwQA1A/n41bWCs
         tpcAzH4id5pgXd8sVYOf+a9ZuyrH+AFKcAFc7PJuGPojLlBiJe8IXmBwYpO17TULFgCF
         PlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Ds7qcfZJxIZk0oTiEJ03M14O8CCPq8A8Sw5wYKxqjg=;
        b=mKBNepbXFnBD2kM1NIgct7sOBdI1G/Xv/nTD76aIfpYpdVb6gJthCFfre5MjN+vUGm
         FgumvF8Ia5QUbUb2xE5ArhYm8Q250iOC2KWMvlBOx5p5avpCij7C3oML9F144g4vxso8
         u7q4GwgYVVoTIb6KaQZzwD7idtGp1zdJzbIh5YhCpQLzWt9Whc8tPPgqnmVwyTvhEV/U
         7OagE/H96cfuCAT1U7oHRCwcm7mQdqXgyjocg/XCrSpt5M5MjjobCXYhGuxx8qmr7QYZ
         oE6aKYmhO/408zToJxD+cyjo3SqekQqwsqnS9uLDlMsQkItJFBX2dIxADn5dH1geGs4t
         loWw==
X-Gm-Message-State: AOAM532kNW4xwjFNtSHNYfheMnVj8hWk/4Xml8rkXwI8ORi2BFGgp6q3
        qnFywR7YxQMOtu6qy5IF/gw=
X-Google-Smtp-Source: ABdhPJy9aXYnM6NS2N4dSq1Wu63GGgS9+7aZwS6abI9XFf3Lsf2lVT9MhjCChzh8PMuSm9embjs/5w==
X-Received: by 2002:a62:78d4:0:b029:2ea:ba:234c with SMTP id t203-20020a6278d40000b02902ea00ba234cmr11606141pfc.53.1623474440316;
        Fri, 11 Jun 2021 22:07:20 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id n23sm6651745pff.93.2021.06.11.22.07.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jun 2021 22:07:19 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 4/4] test: compare raw output, not mangle tabs and spaces
Date:   Sat, 12 Jun 2021 13:07:11 +0800
Message-Id: <20210612050711.4057-5-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <87im2s5jjm.fsf@evledraar.gmail.com>
References: <87im2s5jjm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

We used to call `make_user_friendly_and_stable_output` to mangle
trailing spaces in output before comparing with the expect file.
Ævar recommends generating expect file using pattern "'s/Z$//'" to
compare expect file with raw output.

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
index 6398f5f2a3..3c747782c1 100644
--- a/t/t5411/common-functions.sh
+++ b/t/t5411/common-functions.sh
@@ -32,17 +32,14 @@ get_abbrev_oid () {
 
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
 		-e "s/$(get_abbrev_oid $A)[0-9a-f]*/<COMMIT-A>/g" \
 		-e "s/$(get_abbrev_oid $B)[0-9a-f]*/<COMMIT-B>/g" \
 		-e "s/$(get_abbrev_oid $TAG)[0-9a-f]*/<TAG-v123>/g" \
@@ -56,6 +53,10 @@ filter_out_user_friendly_and_stable_output () {
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
index 2c69cf60d4..ce64bb660b 100644
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
-	 <COMMIT-A>..<COMMIT-B> <COMMIT-B> -> main
-	 * [new branch] HEAD -> next
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main        Z
+	> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/main        Z
+	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next        Z
+	> To <URL/of/upstream.git>
+	>    <COMMIT-A>..<COMMIT-B>  <COMMIT-B> -> main
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
-	 <COMMIT-A>..<COMMIT-B> <COMMIT-B> -> next
-	 ! [rejected] main -> main (non-fast-forward)
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/next        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/next        Z
+	> To <URL/of/upstream.git>
+	>    <COMMIT-A>..<COMMIT-B>  <COMMIT-B> -> next
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
-	 + <COMMIT-B>...<COMMIT-A> main -> main (forced update)
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
+	>  + <COMMIT-B>...<COMMIT-A> main -> main (forced update)
+	>  - [deleted]         next
+	>  * [new tag]         v123 -> v123
+	>  * [new reference]   main -> refs/review/main/topic
+	>  * [new branch]      HEAD -> a/b/c
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0001-standard-git-push--porcelain.sh b/t/t5411/test-0001-standard-git-push--porcelain.sh
index 7b982c8395..373ec3d865 100644
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
-	     <COMMIT-B>:refs/heads/main    <COMMIT-A>..<COMMIT-B>
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
+	>  	<COMMIT-B>:refs/heads/main	<COMMIT-A>..<COMMIT-B>
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
-	     <COMMIT-B>:refs/heads/next    <COMMIT-A>..<COMMIT-B>
-	!    refs/heads/main:refs/heads/main    [rejected] (non-fast-forward)
-	Done
+	format_and_save_expect <<-EOF &&
+	> remote: # pre-receive hook        Z
+	> remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/next        Z
+	> remote: # post-receive hook        Z
+	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/next        Z
+	> To <URL/of/upstream.git>
+	>  	<COMMIT-B>:refs/heads/next	<COMMIT-A>..<COMMIT-B>
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
-	+    refs/heads/main:refs/heads/main    <COMMIT-B>...<COMMIT-A> (forced update)
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
+	> +	refs/heads/main:refs/heads/main	<COMMIT-B>...<COMMIT-A> (forced update)
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
index a482ff931a..f7a494bdb9 100644
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
-	 <COMMIT-A>..<COMMIT-B> <COMMIT-B> -> main
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
+	>    <COMMIT-A>..<COMMIT-B>  <COMMIT-B> -> main
+	>  ! [remote rejected] HEAD -> refs/for/main/topic (proc-receive failed to report status)
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0023-report-unexpect-ref--porcelain.sh b/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
index c586cd70a0..63c479e975 100644
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
-	     <COMMIT-B>:refs/heads/main    <COMMIT-A>..<COMMIT-B>
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
+	>  	<COMMIT-B>:refs/heads/main	<COMMIT-A>..<COMMIT-B>
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
index bbd09ecdfb..988a4302a6 100644
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
-	 <COMMIT-B>..<COMMIT-A> HEAD -> refs/pull/123/head
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
+	>    <COMMIT-B>..<COMMIT-A>  HEAD -> refs/pull/123/head
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
-	 <COMMIT-B>..<COMMIT-A> HEAD -> refs/for/main/topic
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
+	>    <COMMIT-B>..<COMMIT-A>  HEAD -> refs/for/main/topic
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
-	 <COMMIT-A>..<COMMIT-B> HEAD -> refs/for/main/topic
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
+	>    <COMMIT-A>..<COMMIT-B>  HEAD -> refs/for/main/topic
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
-	 + <COMMIT-B>...<COMMIT-A> HEAD -> refs/pull/124/head (forced update)
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
+	>  + <COMMIT-B>...<COMMIT-A> HEAD -> refs/pull/124/head (forced update)
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0033-report-with-options--porcelain.sh b/t/t5411/test-0033-report-with-options--porcelain.sh
index d6a24d60ff..daacb3d69d 100644
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
-	     HEAD:refs/pull/123/head    <COMMIT-B>..<COMMIT-A>
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
+	>  	HEAD:refs/pull/123/head	<COMMIT-B>..<COMMIT-A>
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
-	     HEAD:refs/for/main/topic    <COMMIT-B>..<COMMIT-A>
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
+	>  	HEAD:refs/for/main/topic	<COMMIT-B>..<COMMIT-A>
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
-	     HEAD:refs/for/main/topic    <COMMIT-A>..<COMMIT-B>
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
+	>  	HEAD:refs/for/main/topic	<COMMIT-A>..<COMMIT-B>
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
-	+    HEAD:refs/pull/124/head    <COMMIT-B>...<COMMIT-A> (forced update)
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
+	> +	HEAD:refs/pull/124/head	<COMMIT-B>...<COMMIT-A> (forced update)
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
index 604656824b..8c8a6c16e1 100644
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
-	 <COMMIT-A>..<COMMIT-B> HEAD -> refs/for/main/topic
-	 * [new reference] HEAD -> refs/changes/24/124/1
-	 <COMMIT-A>..<COMMIT-B> HEAD -> refs/changes/25/125/1
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
+	>    <COMMIT-A>..<COMMIT-B>  HEAD -> refs/for/main/topic
+	>  * [new reference]   HEAD -> refs/changes/24/124/1
+	>    <COMMIT-A>..<COMMIT-B>  HEAD -> refs/changes/25/125/1
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
-	 <COMMIT-A>..<COMMIT-B> HEAD -> refs/for/main/topic
-	 + <COMMIT-B>...<COMMIT-A> HEAD -> refs/changes/25/125/1 (forced update)
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
+	>    <COMMIT-A>..<COMMIT-B>  HEAD -> refs/for/main/topic
+	>  + <COMMIT-B>...<COMMIT-A> HEAD -> refs/changes/25/125/1 (forced update)
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
-	 <COMMIT-A>..<COMMIT-B> HEAD -> refs/changes/24/124/2
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
+	>    <COMMIT-A>..<COMMIT-B>  HEAD -> refs/changes/24/124/2
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh b/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
index 6cc0c78a2a..bc44810f33 100644
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
-	     HEAD:refs/for/main/topic    <COMMIT-A>..<COMMIT-B>
-	*    HEAD:refs/changes/24/124/1    [new reference]
-	     HEAD:refs/changes/25/125/1    <COMMIT-A>..<COMMIT-B>
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
+	>  	HEAD:refs/for/main/topic	<COMMIT-A>..<COMMIT-B>
+	> *	HEAD:refs/changes/24/124/1	[new reference]
+	>  	HEAD:refs/changes/25/125/1	<COMMIT-A>..<COMMIT-B>
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
-	     HEAD:refs/for/main/topic    <COMMIT-A>..<COMMIT-B>
-	+    HEAD:refs/changes/25/125/1    <COMMIT-B>...<COMMIT-A> (forced update)
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
+	>  	HEAD:refs/for/main/topic	<COMMIT-A>..<COMMIT-B>
+	> +	HEAD:refs/changes/25/125/1	<COMMIT-B>...<COMMIT-A> (forced update)
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
-	     HEAD:refs/changes/24/124/2    <COMMIT-A>..<COMMIT-B>
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
+	>  	HEAD:refs/changes/24/124/2	<COMMIT-A>..<COMMIT-B>
+	> Done
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0038-report-mixed-refs.sh b/t/t5411/test-0038-report-mixed-refs.sh
index 9260644814..e63fe7ba11 100644
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
-	 <COMMIT-A>..<COMMIT-B> <COMMIT-B> -> main
-	 * [new branch] HEAD -> bar
-	 * [new branch] HEAD -> baz
-	 * [new reference] HEAD -> refs/for/next/topic2
-	 * [new branch] HEAD -> foo
-	 <COMMIT-A>..<COMMIT-B> HEAD -> refs/for/main/topic
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
+	>    <COMMIT-A>..<COMMIT-B>  <COMMIT-B> -> main
+	>  * [new branch]      HEAD -> bar
+	>  * [new branch]      HEAD -> baz
+	>  * [new reference]   HEAD -> refs/for/next/topic2
+	>  * [new branch]      HEAD -> foo
+	>    <COMMIT-A>..<COMMIT-B>  HEAD -> refs/for/main/topic
+	>  ! [remote rejected] HEAD -> refs/for/next/topic1 (fail to call Web API)
+	>  ! [remote rejected] HEAD -> refs/for/next/topic3 (proc-receive failed to report status)
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0039-report-mixed-refs--porcelain.sh b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
index 4fe37683f8..99d17b73af 100644
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
-	     <COMMIT-B>:refs/heads/main    <COMMIT-A>..<COMMIT-B>
-	*    HEAD:refs/heads/bar    [new branch]
-	*    HEAD:refs/heads/baz    [new branch]
-	*    HEAD:refs/for/next/topic2    [new reference]
-	*    HEAD:refs/heads/foo    [new branch]
-	     HEAD:refs/for/main/topic    <COMMIT-A>..<COMMIT-B>
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
+	>  	<COMMIT-B>:refs/heads/main	<COMMIT-A>..<COMMIT-B>
+	> *	HEAD:refs/heads/bar	[new branch]
+	> *	HEAD:refs/heads/baz	[new branch]
+	> *	HEAD:refs/for/next/topic2	[new reference]
+	> *	HEAD:refs/heads/foo	[new branch]
+	>  	HEAD:refs/for/main/topic	<COMMIT-A>..<COMMIT-B>
+	> !	HEAD:refs/for/next/topic1	[remote rejected] (fail to call Web API)
+	> !	HEAD:refs/for/next/topic3	[remote rejected] (proc-receive failed to report status)
+	> Done
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0040-process-all-refs.sh b/t/t5411/test-0040-process-all-refs.sh
index 33a7f49a50..2f405adefa 100644
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
-	 <COMMIT-A>..<COMMIT-B> <COMMIT-B> -> bar
-	 - [deleted] foo
-	 + <COMMIT-B>...<COMMIT-A> HEAD -> main (forced update)
-	 <COMMIT-A>..<COMMIT-B> HEAD -> refs/pull/123/head
-	 + <COMMIT-B>...<COMMIT-A> HEAD -> refs/pull/124/head (forced update)
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
+	>    <COMMIT-A>..<COMMIT-B>  <COMMIT-B> -> bar
+	>  - [deleted]         foo
+	>  + <COMMIT-B>...<COMMIT-A> HEAD -> main (forced update)
+	>    <COMMIT-A>..<COMMIT-B>  HEAD -> refs/pull/123/head
+	>  + <COMMIT-B>...<COMMIT-A> HEAD -> refs/pull/124/head (forced update)
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0041-process-all-refs--porcelain.sh b/t/t5411/test-0041-process-all-refs--porcelain.sh
index 07dce47a7d..c88405792e 100644
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
-	     <COMMIT-B>:refs/heads/bar    <COMMIT-A>..<COMMIT-B>
-	-    :refs/heads/foo    [deleted]
-	+    HEAD:refs/heads/main    <COMMIT-B>...<COMMIT-A> (forced update)
-	     HEAD:refs/pull/123/head    <COMMIT-A>..<COMMIT-B>
-	+    HEAD:refs/pull/124/head    <COMMIT-B>...<COMMIT-A> (forced update)
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
+	>  	<COMMIT-B>:refs/heads/bar	<COMMIT-A>..<COMMIT-B>
+	> -	:refs/heads/foo	[deleted]
+	> +	HEAD:refs/heads/main	<COMMIT-B>...<COMMIT-A> (forced update)
+	>  	HEAD:refs/pull/123/head	<COMMIT-A>..<COMMIT-B>
+	> +	HEAD:refs/pull/124/head	<COMMIT-B>...<COMMIT-A> (forced update)
+	> Done
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0050-proc-receive-refs-with-modifiers.sh b/t/t5411/test-0050-proc-receive-refs-with-modifiers.sh
index 906d75e62d..31989f0185 100644
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
-	 <COMMIT-A>..<COMMIT-B> <COMMIT-B> -> refs/pull/123/head
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
+	>    <COMMIT-A>..<COMMIT-B>  <COMMIT-B> -> refs/pull/123/head
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
-	 <COMMIT-A>..<COMMIT-B> <COMMIT-B> -> topic
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
+	>    <COMMIT-A>..<COMMIT-B>  <COMMIT-B> -> topic
+	>  - [deleted]         v123
+	>  * [new reference]   <COMMIT-A> -> refs/pull/124/head
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5548-push-porcelain.sh b/t/t5548-push-porcelain.sh
index 335abe85a7..f11ff57e54 100755
--- a/t/t5548-push-porcelain.sh
+++ b/t/t5548-push-porcelain.sh
@@ -44,15 +44,16 @@ get_abbrev_oid () {
 # of the output.
 make_user_friendly_and_stable_output () {
 	sed \
-		-e "s/  *\$//" \
-		-e "s/   */ /g" \
-		-e "s/	/    /g" \
 		-e "s/$(get_abbrev_oid $A)[0-9a-f]*/<COMMIT-A>/g" \
 		-e "s/$(get_abbrev_oid $B)[0-9a-f]*/<COMMIT-B>/g" \
 		-e "s/$ZERO_OID/<ZERO-OID>/g" \
 		-e "s#To $URL_PREFIX/upstream.git#To <URL/of/upstream.git>#"
 }
 
+format_and_save_expect () {
+	sed -e 's/^> //' -e 's/Z$//' >expect
+}
+
 setup_upstream_and_workbench () {
 	# Upstream  after setup : main(B)  foo(A)  bar(A)  baz(A)
 	# Workbench after setup : main(A)
@@ -108,14 +109,14 @@ run_git_push_porcelain_output_test() {
 				next
 		) >out &&
 		make_user_friendly_and_stable_output <out >actual &&
-		cat >expect <<-EOF &&
-		To <URL/of/upstream.git>
-		=    refs/heads/baz:refs/heads/baz    [up to date]
-		     <COMMIT-B>:refs/heads/bar    <COMMIT-A>..<COMMIT-B>
-		-    :refs/heads/foo    [deleted]
-		+    refs/heads/main:refs/heads/main    <COMMIT-B>...<COMMIT-A> (forced update)
-		*    refs/heads/next:refs/heads/next    [new branch]
-		Done
+		format_and_save_expect <<-EOF &&
+		> To <URL/of/upstream.git>
+		> =	refs/heads/baz:refs/heads/baz	[up to date]
+		>  	<COMMIT-B>:refs/heads/bar	<COMMIT-A>..<COMMIT-B>
+		> -	:refs/heads/foo	[deleted]
+		> +	refs/heads/main:refs/heads/main	<COMMIT-B>...<COMMIT-A> (forced update)
+		> *	refs/heads/next:refs/heads/next	[new branch]
+		> Done
 		EOF
 		test_cmp expect actual &&
 
@@ -145,12 +146,12 @@ run_git_push_porcelain_output_test() {
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
@@ -165,6 +166,7 @@ run_git_push_porcelain_output_test() {
 		EOF
 		test_cmp expect actual
 	'
+
 	test_expect_success "prepare pre-receive hook ($PROTOCOL)" '
 		write_script "$upstream/hooks/pre-receive" <<-EOF
 		exit 1
@@ -186,12 +188,12 @@ run_git_push_porcelain_output_test() {
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
@@ -224,12 +226,12 @@ run_git_push_porcelain_output_test() {
 				next
 		) >out &&
 		make_user_friendly_and_stable_output <out >actual &&
-		cat >expect <<-EOF &&
+		format_and_save_expect <<-EOF &&
 		To <URL/of/upstream.git>
-		=    refs/heads/next:refs/heads/next    [up to date]
-		-    :refs/heads/baz    [deleted]
-		     refs/heads/main:refs/heads/main    <COMMIT-A>..<COMMIT-B>
-		!    refs/heads/bar:refs/heads/bar    [rejected] (non-fast-forward)
+		> =	refs/heads/next:refs/heads/next	[up to date]
+		> -	:refs/heads/baz	[deleted]
+		>  	refs/heads/main:refs/heads/main	<COMMIT-A>..<COMMIT-B>
+		> !	refs/heads/bar:refs/heads/bar	[rejected] (non-fast-forward)
 		Done
 		EOF
 		test_cmp expect actual &&
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 3140ca4fdc..b13e8a52a9 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -94,7 +94,7 @@ get_abbrev_oid () {
 
 # Format the output of git commands to make a user-friendly and stable
 # text.  We can easily prepare the expect text without having to worry
-# about future changes of the commit ID and spaces of the output.
+# about future changes of the commit ID.
 make_user_friendly_and_stable_output () {
 	sed \
 		-e "s/$(get_abbrev_oid $A)[0-9a-f]*/<COMMIT-A>/g" \
@@ -115,8 +115,11 @@ make_user_friendly_and_stable_output () {
 		-e "s/$(get_abbrev_oid $P)[0-9a-f]*/<COMMIT-P>/g" \
 		-e "s/$(get_abbrev_oid $TAG1)[0-9a-f]*/<TAG-1>/g" \
 		-e "s/$(get_abbrev_oid $TAG2)[0-9a-f]*/<TAG-2>/g" \
-		-e "s/$(get_abbrev_oid $TAG3)[0-9a-f]*/<TAG-3>/g" \
-		-e "s/ *\$//"
+		-e "s/$(get_abbrev_oid $TAG3)[0-9a-f]*/<TAG-3>/g"
+}
+
+format_and_save_expect () {
+	sed -e 's/Z$//' >expect
 }
 
 #            (C)   (D, pull/1/head, topic/1)
@@ -191,11 +194,11 @@ test_expect_success 'create bundle from special rev: main^!' '
 
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
 
@@ -212,12 +215,12 @@ test_expect_success 'create bundle with --max-count option' '
 
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
 
@@ -237,7 +240,7 @@ test_expect_success 'create bundle with --since option' '
 
 	git bundle verify since.bdl |
 		make_user_friendly_and_stable_output >actual &&
-	cat >expect <<-\EOF &&
+	format_and_save_expect <<-\EOF &&
 	The bundle contains these 5 refs:
 	<COMMIT-P> refs/heads/main
 	<COMMIT-N> refs/heads/release
@@ -245,8 +248,8 @@ test_expect_success 'create bundle with --since option' '
 	<TAG-3> refs/tags/v3
 	<COMMIT-P> HEAD
 	The bundle requires these 2 refs:
-	<COMMIT-M>
-	<COMMIT-K>
+	<COMMIT-M> Z
+	<COMMIT-K> Z
 	EOF
 	test_cmp expect actual &&
 
@@ -305,13 +308,13 @@ test_expect_success 'create bundle 2 - has prerequisites' '
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
@@ -329,11 +332,11 @@ test_expect_success 'create bundle 2 - has prerequisites' '
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
@@ -364,13 +367,13 @@ test_expect_success 'create bundle 3 - two refs, same object' '
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

