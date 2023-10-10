Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B90CD8CB7
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 20:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343904AbjJJUe1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 16:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343808AbjJJUd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 16:33:56 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869AFB0
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:33:45 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-49d8dd34f7bso1997465e0c.3
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696970024; x=1697574824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z+Flt4mcDLnGAqCFrEF92nC3MImuUuxlNM0YsbFqOR4=;
        b=B/sTBdiKLAGB4MKkmKoPRE3gwq3jxLwWwWM+AXHrELLSVnRuQTmZc21Wdk3KBrBrNQ
         Pm93A0FMEt14KvuqCmNieawNV6lBkOpvRp5UF/ThCybYYVQy1Z7ar4MIETk/W71bqsXq
         b/rXFoDvtld844IRelromC863RZOIdIO1w4PioBco3UdSg8cJtW1sHG3QxduMucbbJJa
         afe4iIZDY0X2Yxwg0bi6qvcGLTpSTOhk8848I1cmLF3YO1Hju7lpGVUZIZkqEDrcHu8M
         gbpgW2CGp2E1rdagcO0zR6w89jFoLan8iL7Yl0QE/f1jvxd4Ou2LhIGvE02xZa3kVcBU
         v5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970024; x=1697574824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+Flt4mcDLnGAqCFrEF92nC3MImuUuxlNM0YsbFqOR4=;
        b=qVdcxDdW5kpu/OPdPmyWLlg1mvJdpIgFtp1KIyfozRAE3gHIzfDrXESWMj3iNxBkO9
         6kMmrh3M6vYojXG9JDmIwt9dT0c9scr8VfLc6ZfmaYlq82gkX+pED2eqw/d7ywBrxLVH
         javNYCeKYNtldH7vld5UFmBMSCnLOu+pSCwGx+/NtiZTFQ0fOMfUMS8572O/4JuwQfzD
         eKvI3sbXxivXWSdpR7kXArq90aUigQl2WzUwU4EfJySj864qu9ecdeHXKCtU6++kH5e9
         bpPitLMeHyl2ZtOz8YwAES0GcjliybqwBdLEsH7+3e5WkMhzTbHlfxbLPSppUDPbTSsS
         i6xw==
X-Gm-Message-State: AOJu0Yw8mwgqPCtVtukqb7rDt86b3+8M73/1Tr6HEmM3ysvBcdKae0TY
        XgiAhOhQML4Wi5yxWxrtdQP3yKDyBWVgIafN0zYcPg==
X-Google-Smtp-Source: AGHT+IFatPozsq80wnHur68RgmD5QE05xs1GGdAgXwLbppqdpNyTMevo8hMZm+79jWsOWc4mLVjLvw==
X-Received: by 2002:a1f:ed02:0:b0:4a0:6fd4:4333 with SMTP id l2-20020a1fed02000000b004a06fd44333mr6823106vkh.13.1696970024404;
        Tue, 10 Oct 2023 13:33:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e6-20020ac845c6000000b004181234dd1dsm4716256qto.96.2023.10.10.13.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:33:44 -0700 (PDT)
Date:   Tue, 10 Oct 2023 16:33:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 08/17] t4216: test changed path filters with high bit paths
Message-ID: <cba766f224b0d2b4fd952b11bef8068c07dfcf88.1696969994.git.me@ttaylorr.com>
References: <cover.1692654233.git.me@ttaylorr.com>
 <cover.1696969994.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1696969994.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

Subsequent commits will teach Git another version of changed path
filter that has different behavior with paths that contain at least
one character with its high bit set, so test the existing behavior as
a baseline.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t4216-log-bloom.sh | 52 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index f49a8f2fbf..da67c40134 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -484,4 +484,56 @@ test_expect_success 'merge graph layers with incompatible Bloom settings' '
 	! grep "disabling Bloom filters" err
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
+test_expect_success 'setup make another commit' '
+	# "git log" does not use Bloom filters for root commits - see how, in
+	# revision.c, rev_compare_tree() (the only code path that eventually calls
+	# get_bloom_filter()) is only called by try_to_simplify_commit() when the commit
+	# has one parent. Therefore, make another commit so that we perform the tests on
+	# a non-root commit.
+	test_commit -C highbit1 anotherc1 "another$CENT"
+'
+
+test_expect_success 'version 1 changed-path used when version 1 requested' '
+	(
+		cd highbit1 &&
+		test_bloom_filters_used "-- another$CENT"
+	)
+'
+
 test_done
-- 
2.42.0.342.g8bb3a896ee

