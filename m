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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D7AC47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 11:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B13A0611AD
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 11:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhFGMAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 08:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhFGMAs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 08:00:48 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F32C061766
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 04:58:42 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id i94so12238111wri.4
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 04:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r0xzgf6LNlsk/SR2IcsJ4Oq1MWb1y0CfBT5f0JgiEPQ=;
        b=BvEFbfFu331pRFhvSE0LVWciXyk6rw4x3ZtRUKg4OqbXLc3oXCztZLRo9GPdvEvo4Z
         4BNAfcg/fnUSN5EKIAvHaGumLaB8z5foWe545U6cWvSDv3YoFEC2wL72COqENWphW5JF
         gVvr0cNp9imFpdpo0Mh8Z7lw/mxKAVwwhkrIMO+kJZyzCiN51EId8MPMYj+tMyNaSRly
         X6QGdXC0PtIt7OElAnreaC8ktK4spcHR/0ohaQdgfqYVkme/EElOt7H01MtZZvtAOZVj
         CT0OlqMr8jiwo7/AzNyL89xZc9nrLEXR0il0OIjFZLu7MXJsqPlBWtLwrvEojBbvHLxj
         3S0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r0xzgf6LNlsk/SR2IcsJ4Oq1MWb1y0CfBT5f0JgiEPQ=;
        b=ktlaIYwXaEEP50FOHiX7qNGCsXNoDRrimb0dOzHApuyIwa9uWDAbzjOeCHPV1zVoVf
         f6QFTHJIpvxE04B2vuRuqhJYpyzjxCTEdWMAcHt6AoGX74Cgd+7FXwqGE3/DuHIsI0Pv
         ruS0oyD+sf8zujXZP1DIRYApCn26325rBI1NuUK+gLq26GkKgD0FO96HGxkhmcMidnV5
         d1LoO6ujbaRksiHgLwdeDh1Sxf1KsbWaJ/6gMb6yKzD5e9Pk2LZQ5BJWojZHUINfGKRh
         /j4TrJ3Mv9P76TE3PbVjwtK86UzHV6D8MokSL1SDvtHMkJply5FFRtEK3q9HmiXLJzP3
         yTAw==
X-Gm-Message-State: AOAM530cLmyLc9U7nt8Auj1P92WkLIHt8Qw4ZfgKlWiob5R7Y7FMBqN/
        HWZjuSWhqaUpQhSSVDpRG2JCOzPLdVR6KA==
X-Google-Smtp-Source: ABdhPJwae+bqE/jz/efp7Mpa5SKNX/YLUL986nnA17xxtyE1QKUFOMnzW8U8YMR9cQOMuDlMPDzXqg==
X-Received: by 2002:adf:eb82:: with SMTP id t2mr16692758wrn.337.1623067117095;
        Mon, 07 Jun 2021 04:58:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 92sm17215166wrp.88.2021.06.07.04.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 04:58:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/4] read-cache perf: add a perf test for refresh_index()
Date:   Mon,  7 Jun 2021 13:58:27 +0200
Message-Id: <patch-4.4-120a37acae-20210607T115454Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-0.4-0000000000-20210607T115454Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210607T115454Z-avarab@gmail.com>
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
index 54ad0c3135..a2802559a5 100644
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
index 1762b64865..cbccc5ace9 100755
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
2.32.0.rc3.434.gd8aed1f08a7

