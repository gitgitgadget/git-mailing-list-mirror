Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED63C433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 17:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239749AbiCVRaY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 13:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239734AbiCVRaR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 13:30:17 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDB365C0
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 10:28:48 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id i186so2385477wma.3
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 10:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xAr9PF28yZSi7PsaTPcsSOpQPfWmKCXhkTZW1DnpfOs=;
        b=YSYeF+ILqDDviWeT7oa0W55UwFJ13x5JA8mAyctiZXxjNUC4/VKxtuxtwc4plqHjnH
         Xbo53RrptDvos3uv6+hodYbHqKDVrZNfa/nowlMGb4pkuzyi0Jbw6/cNzfhJHRpoJnD6
         +/jMQMWZgR4D4p+I27NzlGboSQYitEkCG8RJ/QG/85iru8zz3SWejPBQlw99ZKGsQHJc
         4YlTrY9l4baogTFRlMQ2GvpTGkGgjPvKT474BwPz95NS7RjU1py0WpzYZjta5HyXxRoX
         IqJOBkO9Fqwj6tPXAwVYOWoR3cj1tC2KjkScrlfpxomX3IE5jGvrPWa+dseh/Em308ks
         4rwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xAr9PF28yZSi7PsaTPcsSOpQPfWmKCXhkTZW1DnpfOs=;
        b=WR+70KQW7C98Gnox55Xoc2CeJIoxGcaCfbMZs6ankfnCYjpmobEL0RXAq0dP3z0fqN
         +X+d9JVqZr/nVVlSxQndRk9nLi6m26FCjIwETjvl1JqT6sjGhrlDep1h2WGn2cet6IA9
         5MAkxUfnVAGO51jcWz40/L95+xyRTq2Vqp5z+GTOq5LAC0C+BQz0ozZZq974tldZ/5E3
         N4M2npWsSDh7+7R345eBNJMBh7bwEj9arRBMY3aaLRRA4Dk9GgTDwzs1DMttqmV1M5U6
         PDD2e/wyxCfbs0jIyU6sX3bRJE/7C0ZSdTRsfoBCdDxoIvRXPhbpXktJx5DN9D8dalTw
         rk4g==
X-Gm-Message-State: AOAM533/skW0FRebMacsCZ7GvIOlFplBEDBqpt1BiGC4J/4t6Kp2aMI5
        pevokGF4kqCHAt+NEmaUTrKb/I8Nq6c=
X-Google-Smtp-Source: ABdhPJxbkMGAKwCz5Y0ExfNe1cWjmrwSPHNc6MJiv5ulY998lYMmnp0sgW9BVIWL3KPTwTcA0wtqWQ==
X-Received: by 2002:a1c:2744:0:b0:382:a9b7:1c8a with SMTP id n65-20020a1c2744000000b00382a9b71c8amr4771786wmn.187.1647970126453;
        Tue, 22 Mar 2022 10:28:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d1-20020adffbc1000000b00203de0fff63sm16305223wrs.70.2022.03.22.10.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 10:28:46 -0700 (PDT)
Message-Id: <b3c9e6523a5466bd8949c77b480c74881edade2f.1647970119.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1186.git.1647970119.gitgitgadget@gmail.com>
References: <pull.1186.git.1647970119.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 17:28:39 +0000
Subject: [PATCH 5/5] bundle: output hash information in 'verify'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The previous change moved the 'filter' capability to the end of the 'git
bundle verify' output. Now, add the 'object-format' capability to the
output, when it exists.

This change makes 'git bundle verify' output the hash used in all cases,
even if the capability is not in the bundle. This means that v2 bundles
will always output that they use "sha1". This might look noisy to some
users, but it does simplify the implementation and the test strategy for
this feature.

Since 'verify' ends early when a prerequisite commit is missing, we need
to insert this hash message carefully into our expected test output
throughout t6020.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle.c               |  2 ++
 t/t6020-bundle-misc.sh | 24 +++++++++++++++++-------
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/bundle.c b/bundle.c
index 276b55f8ce2..d50cfb5aa7e 100644
--- a/bundle.c
+++ b/bundle.c
@@ -278,6 +278,8 @@ int verify_bundle(struct repository *r,
 			list_refs(r, 0, NULL);
 		}
 
+		printf_ln("The bundle uses this hash algorithm: %s",
+			  header->hash_algo->name);
 		if (header->filter.choice)
 			printf_ln("The bundle uses this filter: %s",
 				  list_objects_filter_spec(&header->filter));
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index c4ab1367afc..833205125ab 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -122,6 +122,8 @@ format_and_save_expect () {
 	sed -e 's/Z$//' >expect
 }
 
+HASH_MESSAGE="The bundle uses this hash algorithm: $GIT_DEFAULT_HASH"
+
 #            (C)   (D, pull/1/head, topic/1)
 #             o --- o
 #            /       \                              (L)
@@ -194,11 +196,12 @@ test_expect_success 'create bundle from special rev: main^!' '
 
 	git bundle verify special-rev.bdl |
 		make_user_friendly_and_stable_output >actual &&
-	format_and_save_expect <<-\EOF &&
+	format_and_save_expect <<-EOF &&
 	The bundle contains this ref:
 	<COMMIT-P> refs/heads/main
 	The bundle requires this ref:
 	<COMMIT-O> Z
+	$HASH_MESSAGE
 	EOF
 	test_cmp expect actual &&
 
@@ -215,12 +218,13 @@ test_expect_success 'create bundle with --max-count option' '
 
 	git bundle verify max-count.bdl |
 		make_user_friendly_and_stable_output >actual &&
-	format_and_save_expect <<-\EOF &&
+	format_and_save_expect <<-EOF &&
 	The bundle contains these 2 refs:
 	<COMMIT-P> refs/heads/main
 	<TAG-1> refs/tags/v1
 	The bundle requires this ref:
 	<COMMIT-O> Z
+	$HASH_MESSAGE
 	EOF
 	test_cmp expect actual &&
 
@@ -240,7 +244,7 @@ test_expect_success 'create bundle with --since option' '
 
 	git bundle verify since.bdl |
 		make_user_friendly_and_stable_output >actual &&
-	format_and_save_expect <<-\EOF &&
+	format_and_save_expect <<-EOF &&
 	The bundle contains these 5 refs:
 	<COMMIT-P> refs/heads/main
 	<COMMIT-N> refs/heads/release
@@ -250,6 +254,7 @@ test_expect_success 'create bundle with --since option' '
 	The bundle requires these 2 refs:
 	<COMMIT-M> Z
 	<COMMIT-K> Z
+	$HASH_MESSAGE
 	EOF
 	test_cmp expect actual &&
 
@@ -267,11 +272,12 @@ test_expect_success 'create bundle 1 - no prerequisites' '
 	EOF
 	git bundle create stdin-1.bdl --stdin <input &&
 
-	cat >expect <<-\EOF &&
+	format_and_save_expect <<-EOF &&
 	The bundle contains these 2 refs:
 	<COMMIT-D> refs/heads/topic/1
 	<COMMIT-H> refs/heads/topic/2
 	The bundle records a complete history.
+	$HASH_MESSAGE
 	EOF
 
 	# verify bundle, which has no prerequisites
@@ -308,13 +314,14 @@ test_expect_success 'create bundle 2 - has prerequisites' '
 		--stdin \
 		release <input &&
 
-	format_and_save_expect <<-\EOF &&
+	format_and_save_expect <<-EOF &&
 	The bundle contains this ref:
 	<COMMIT-N> refs/heads/release
 	The bundle requires these 3 refs:
 	<COMMIT-D> Z
 	<COMMIT-E> Z
 	<COMMIT-G> Z
+	$HASH_MESSAGE
 	EOF
 
 	git bundle verify 2.bdl |
@@ -367,13 +374,14 @@ test_expect_success 'create bundle 3 - two refs, same object' '
 		--stdin \
 		main HEAD <input &&
 
-	format_and_save_expect <<-\EOF &&
+	format_and_save_expect <<-EOF &&
 	The bundle contains these 2 refs:
 	<COMMIT-P> refs/heads/main
 	<COMMIT-P> HEAD
 	The bundle requires these 2 refs:
 	<COMMIT-M> Z
 	<COMMIT-K> Z
+	$HASH_MESSAGE
 	EOF
 
 	git bundle verify 3.bdl |
@@ -409,12 +417,13 @@ test_expect_success 'create bundle 4 - with tags' '
 		--stdin \
 		--all <input &&
 
-	cat >expect <<-\EOF &&
+	cat >expect <<-EOF &&
 	The bundle contains these 3 refs:
 	<TAG-1> refs/tags/v1
 	<TAG-2> refs/tags/v2
 	<TAG-3> refs/tags/v3
 	The bundle records a complete history.
+	$HASH_MESSAGE
 	EOF
 
 	git bundle verify 4.bdl |
@@ -511,6 +520,7 @@ do
 		<TAG-3> refs/tags/v3
 		<COMMIT-P> HEAD
 		The bundle records a complete history.
+		$HASH_MESSAGE
 		The bundle uses this filter: $filter
 		EOF
 		test_cmp expect actual &&
-- 
gitgitgadget
