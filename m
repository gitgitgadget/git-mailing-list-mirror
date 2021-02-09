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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA44BC433E9
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 22:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 780B464E50
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 22:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbhBIW5v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 17:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbhBIWWd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 17:22:33 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68E8C03C046
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 13:42:17 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r21so7594655wrr.9
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 13:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C3Agq6r4sx3mvRV9qIKJhQu5ubUhR75fE8xNP1oMZ8o=;
        b=CiTX2y8cNdy2ulaEtGxqGt9otaY4Peg3JenvC+Ln0LhUPFvUrSE7DFIA6xvBESFy0+
         cE0MCor5f5DeHXHxB4O+UTgVvnmalkI8EDgPYbFDxwl9Hiry9pKk7zNOA50i2IFOGM7G
         aBwsnb+jeq+AIUX0/gk8zbFefY0NvTgv+1jBV07JwIWw/Dw5Gei/45GckTDLkxMyNeGo
         yJjShTNkO5/JiEl3yIanCMPFp4rwX4euruw/wH8emxYRhbR1XI54ea/duwxZnFiYCn9E
         aeRrmaCcQVyPiv7pma0DA9trDUzXT6jeERLJK7LBcqaJjMyU0+/irKgBe0lHZRkJ2rOc
         ggsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C3Agq6r4sx3mvRV9qIKJhQu5ubUhR75fE8xNP1oMZ8o=;
        b=s53iAQDJXQvQamoRdzxbK27NfGyWYaO3SrWo+1KmrA63dsszqWaWHxFRRWu+4eUGcJ
         EsQV6XPeLSJZveN/Nrxu+BEUCUpcMFUkCUuKS0MArUDxql7AQxMd8smOlXrQBvn+dm+0
         R2j4Yy4ngkpa03noH/jrtyiUZB+88m+0c/GsOa+HGFoTZRr6Z/U+afb9zkifsbaV0WuR
         3MTbg7cvjJM0tihRSJQXQtpWRqReFl4biGvOoqyxahZfT+j4vI8yoqNTmfBnkPcylo9M
         hVlTuB9YAoOomhr0MN6/v3Iz7gXw1p1UtQt7U3amFm3ehPilnpHr0Q7Cf7n2XECe4LrW
         Jg0Q==
X-Gm-Message-State: AOAM5306xS/tneOEhGxj/LiRzKAYbZsmP3Da6nmFDkalewQtosvtbCSO
        7U0mhWFyQbI5GGPGBUsNyX81b5E6UYZrdg==
X-Google-Smtp-Source: ABdhPJxqyGPqlSFVRAYhWW7WU2JYzt+R5CQRaHbP+DruZiyii7stw6yKVdZtraFR8zl/Gd/dazznSg==
X-Received: by 2002:a05:6000:1ca:: with SMTP id t10mr123312wrx.45.1612906936354;
        Tue, 09 Feb 2021 13:42:16 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m205sm38710wmf.40.2021.02.09.13.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 13:42:15 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/12] test-lib-functions: remove generate_zero_bytes() wrapper
Date:   Tue,  9 Feb 2021 22:41:51 +0100
Message-Id: <20210209214159.22815-5-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210209214159.22815-1-avarab@gmail.com>
References: <20210209214159.22815-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since d5cfd142ec1 (tests: teach the test-tool to generate NUL bytes
and use it, 2019-02-14) the generate_zero_bytes() functions has been a
thin wrapper for "test-tool genzeros". Let's have its only user call
that directly instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5318-commit-graph.sh | 2 +-
 t/test-lib-functions.sh | 7 -------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 2ed0c1544da..368d1cfb448 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -529,7 +529,7 @@ corrupt_graph_and_verify() {
 	zero_pos=${4:-${orig_size}} &&
 	printf "$data" | dd of="$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
 	dd of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" if=/dev/null &&
-	generate_zero_bytes $(($orig_size - $zero_pos)) >>"$objdir/info/commit-graph" &&
+	test-tool genzeros $(($orig_size - $zero_pos)) >>"$objdir/info/commit-graph" &&
 	corrupt_graph_verify "$grepstr"
 
 }
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 728bdf94684..55d58b4a6ac 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -111,13 +111,6 @@ remove_cr () {
 	tr '\015' Q | sed -e 's/Q$//'
 }
 
-# Generate an output of $1 bytes of all zeroes (NULs, not ASCII zeroes).
-# If $1 is 'infinity', output forever or until the receiving pipe stops reading,
-# whichever comes first.
-generate_zero_bytes () {
-	test-tool genzeros "$@"
-}
-
 # In some bourne shell implementations, the "unset" builtin returns
 # nonzero status when a variable to be unset was not set in the first
 # place.
-- 
2.30.0.284.gd98b1dd5eaa7

