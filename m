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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10804C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 09:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5C8461165
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 09:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhHXJQ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 05:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235652AbhHXJQT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 05:16:19 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC70C061760
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 02:15:35 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id f9-20020a05600c1549b029025b0f5d8c6cso1331608wmg.4
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 02:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sWGIxOrcSa7Vn/di+6qSQSu9BiHtTe5SOwI3VUYeoKc=;
        b=L7PhgRoGW1t+EWAHsYxrR3uFoMom/xbPuu2BabF+pKuSuDeF7usqC7pl6gdrZvGmlj
         NtnSrNVFDH6FQesHeKlzjPD7JBambp0/7ioVxlqWTVjkqG60AMdUq1QoW24UfFhbE57y
         lKHjGPhCymRYOSfc8uH5swO4uhNooEizd3ElrkzvH8rubj1X2e0dpCJv1MEVLn1A2k5e
         PSFSZg/5nmmgV3xZdQdle+eNxoM+31r2Ff+xnAr9hOy0847QpMPBJ6sdeVZfbRTHEmGk
         svjdps4vWSQUjYRwMV74IciSKvQ0qgYrXVvw2Nn5iWbgX3GPL4y0bwKMNIPXc94D6tCT
         Bmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sWGIxOrcSa7Vn/di+6qSQSu9BiHtTe5SOwI3VUYeoKc=;
        b=GT6dyeR7Ro52S+KtjZbTKir+O2VMv5dW3PhsA83AqMPkLrVwq12F2H/NRLTAbglaoO
         jFyI8bzAOgzhfv4xuHPykI4PcvGpQMm6Q2IK574lUA4G/JWMC49MtGKpyGsiCT7BVy/U
         vkKZhKqQCtzOq7cZE7DuHnMyF0WV/ejjiJ+ohUc5voXTeVNGIISggOkuM60WQrUAZ6YB
         a6fJPg2LlfCAibncynWEODmlW8wtEW0stVWwH63jlH8MzOZTIbkopU3jggFnMEbeu+TV
         qB0TfZmhKBp53WETbndOT/2r5r081Zc/QOIv6JEFGRNc9F1+UXrxgudETDt1tUH1r9ND
         iFRQ==
X-Gm-Message-State: AOAM531uaZTiEGXDHt7ij623RzTnN6KEMftWVapepPIsMS/3GHBTUqSs
        i69EHeYYChVKH+w2ZqTih1jRKjYHidxJ9g==
X-Google-Smtp-Source: ABdhPJw0PcOAVn469evGmoAdRx0ZI6jmUUlmvOKZhJA5dv38BivoISrQVpo1zEXtn+vnzUdTqzUB5g==
X-Received: by 2002:a05:600c:350d:: with SMTP id h13mr3024238wmq.38.1629796534161;
        Tue, 24 Aug 2021 02:15:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u8sm1853104wmq.45.2021.08.24.02.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 02:15:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/4] read-cache perf: add a perf test for refresh_index()
Date:   Tue, 24 Aug 2021 11:15:25 +0200
Message-Id: <patch-v2-4.4-e3648bf78c7-20210824T091204Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.663.gbaff4edb973
In-Reply-To: <cover-v2-0.4-00000000000-20210824T091204Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210607T115454Z-avarab@gmail.com> <cover-v2-0.4-00000000000-20210824T091204Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a perf test for the refresh_index() function to compliment the
existing read()/discard() in a loop perf test added in
1ecb5ff141f (read-cache: add simple performance test, 2013-06-09).

Since this test is much slower (around 10x) than the previous
read()/discard() test let's run it 100 times instead of the 1000 time
the first one runs.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-read-cache-perf.c | 12 ++++++++++++
 t/perf/p0002-read-cache.sh      |  5 +++++
 2 files changed, 17 insertions(+)

diff --git a/t/helper/test-read-cache-perf.c b/t/helper/test-read-cache-perf.c
index 301e98797b4..630c126fbf3 100644
--- a/t/helper/test-read-cache-perf.c
+++ b/t/helper/test-read-cache-perf.c
@@ -11,8 +11,11 @@ int cmd__read_cache_perf(int argc, const char **argv)
 {
 	struct repository *r = the_repository;
 	int cnt = -1;
+	int refresh = 0;
 	struct option options[] = {
 		OPT_INTEGER(0, "count", &cnt, "number of passes"),
+		OPT_BOOL(0, "refresh", &refresh,
+			 "call refresh_index() in a loop, not read()/discard()"),
 		OPT_END()
 	};
 
@@ -26,10 +29,19 @@ int cmd__read_cache_perf(int argc, const char **argv)
 			      options);
 
 	setup_git_directory();
+	if (refresh)
+		repo_read_index(r);
 	while (cnt--) {
+		if (refresh) {
+			unsigned int flags = REFRESH_QUIET|REFRESH_PROGRESS;
+			refresh_index(r->index, flags, NULL, NULL, NULL);
+			continue;
+		}
 		repo_read_index(r);
 		discard_index(r->index);
 	}
+	if (refresh)
+		discard_index(r->index);
 
 	return 0;
 }
diff --git a/t/perf/p0002-read-cache.sh b/t/perf/p0002-read-cache.sh
index 1762b648654..cbccc5ace95 100755
--- a/t/perf/p0002-read-cache.sh
+++ b/t/perf/p0002-read-cache.sh
@@ -11,4 +11,9 @@ test_perf "read_cache/discard_cache $count times" "
 	test-tool read-cache-perf --count=$count
 "
 
+count=100
+test_perf "refresh_index() $count times" "
+	test-tool read-cache-perf --count=$count --refresh
+"
+
 test_done
-- 
2.33.0.663.gbaff4edb973

