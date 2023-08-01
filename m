Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B24C0015E
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 18:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjHASmT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 14:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjHASmK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 14:42:10 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336C2268E
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 11:41:59 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5840614b107so73956697b3.1
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 11:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690915318; x=1691520118;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jaTeEzCxDKWERXQnRcvwGtGl2veNkFFfZk1CxIXl99Q=;
        b=kLvOlM8M3T1wKyKeL/dz6l7JpTCI1P4+sRN8jyNkZKsSFsv9nEHXO+3YhffxVYZdzy
         A/ZaQbSph9H3L8QRcE0ZxRv7mDj104lKrmSXmHuG75pyXs8cc/8khU/uPGWAZemcu70u
         eV+yxOntydtjLRWwSjSwucMr6dzORAz29FU16ZyhB7Jf6EwkL7JIotkAHaWguJ1HZSq1
         Pp+7VvzOhzDscbd+MbsTDNPqH7q4DleI+c4X9hrNNMd1UNFUJcaH/HJnXrURV6R5aE2G
         typgV0Z2IsBACw0owNzQrvxTCEcUbJA9oJK/dvwNt5c5swAwBERocVb3qbxKhAh14BcI
         eElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690915318; x=1691520118;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jaTeEzCxDKWERXQnRcvwGtGl2veNkFFfZk1CxIXl99Q=;
        b=aHzGIG0XadHfRASJ+RprNkT+6tgYQXXyqYfWFr9G6jJ1pvZGMRvYldFVsYLvb7gieS
         jKvUD4oVnZ55Duu5Liz24T/IfTDOvx7j76jfGMltY1Q2TEQgH350bNzzHLKXOUpuaeO0
         W+r86KfFpJatsnjoxDrog5WPcAf2vdLJzI7Sj7asQ7U9X66pz3oj04y/+9ZIVni5lHDv
         sceeS7YPNYsqmzy5t3iCgy+88FgGQBTL9iqvkWoupa5F7BncXgpHAUaVMd2Q80HQk4EY
         JtfRlXgm0ICLiaSTGTUaWhc1guaX6+j5p6KovnL0qLtuZ5aZn/oPSKd4hhveLYvyNvEQ
         +8pg==
X-Gm-Message-State: ABy/qLbNDaFVRVPF/QOv3PG/GxeyEG1ddPZ4RSUhhTBHkLieMJ00de0b
        okRzbhtUm553aG7QDNtg9vF6yqp7Xjj9FHRZn0xjbhRnmtBICDz4CF6VHPkjmWVCb8IdkLkU5Xn
        MPMupes2JlDoS61C7D9SSeFvbXA5X3U4nikxZpZ8/NNq4eJCYiCGswPG6H5nI7O1bpWYO0GhxR9
        9N
X-Google-Smtp-Source: APBJJlEY3rawT5LcYPGKVn57aTUqpRGP8FecQxOCaBMpCeSXfuFt9yAmMHy3fxKoOk2dg2cxAdZNaGFEk6amRJA/5EYH
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:a487:6e54:d296:9521])
 (user=jonathantanmy job=sendgmr) by 2002:a81:d008:0:b0:57a:e0b:f63 with SMTP
 id v8-20020a81d008000000b0057a0e0b0f63mr113947ywi.7.1690915318044; Tue, 01
 Aug 2023 11:41:58 -0700 (PDT)
Date:   Tue,  1 Aug 2023 11:41:40 -0700
In-Reply-To: <cover.1690912539.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1684790529.git.jonathantanmy@google.com> <cover.1690912539.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <74863c11e59c6dbf3673507b58e7c841162d3d18.1690912539.git.jonathantanmy@google.com>
Subject: [PATCH v7 5/7] t4216: test changed path filters with high bit paths
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Subsequent commits will teach Git another version of changed path
filter that has different behavior with paths that contain at least
one character with its high bit set, so test the existing behavior as
a baseline.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4216-log-bloom.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index fa9d32facf..2d4a3fefee 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -404,4 +404,47 @@ test_expect_success 'Bloom generation backfills empty commits' '
 	)
 '
 
+get_first_changed_path_filter () {
+	test-tool read-graph bloom-filters >filters.dat &&
+	head -n 1 filters.dat
+}
+
+# chosen to be the same under all Unicode normalization forms
+CENT=$(printf "\302\242")
+
+test_expect_success 'set up repo with high bit path, version 1 changed-path' '
+	git init highbit1 &&
+	test_commit -C highbit1 c1 "$CENT" &&
+	git -C highbit1 commit-graph write --reachable --changed-paths
+'
+
+test_expect_success 'setup check value of version 1 changed-path' '
+	(
+		cd highbit1 &&
+		echo "52a9" >expect &&
+		get_first_changed_path_filter >actual &&
+		test_cmp expect actual
+	)
+'
+
+# expect will not match actual if char is unsigned by default. Write the test
+# in this way, so that a user running this test script can still see if the two
+# files match. (It will appear as an ordinary success if they match, and a skip
+# if not.)
+if test_cmp highbit1/expect highbit1/actual
+then
+	test_set_prereq SIGNED_CHAR_BY_DEFAULT
+fi
+test_expect_success SIGNED_CHAR_BY_DEFAULT 'check value of version 1 changed-path' '
+	# Only the prereq matters for this test.
+	true
+'
+
+test_expect_success 'version 1 changed-path used when version 1 requested' '
+	(
+		cd highbit1 &&
+		test_bloom_filters_used "-- $CENT"
+	)
+'
+
 test_done
-- 
2.41.0.585.gd2178a4bd4-goog

