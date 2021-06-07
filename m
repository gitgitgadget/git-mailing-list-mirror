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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680D4C47095
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 11:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 542BF61205
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 11:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhFGMBj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 08:01:39 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:33313 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhFGMBh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 08:01:37 -0400
Received: by mail-wr1-f52.google.com with SMTP id a20so17338460wrc.0
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 04:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z6qQRqJGyPXAUQHByKcD3gHciIzlhof6rBbdttE07Yc=;
        b=RQ8hf6xzuHKvGk6yDDMOxLEWOY6AibLS5E5nQ7sG1lQRgdUmW9OonpspFBbfQWwpix
         iOnzDqEJ6EVswiUCBVYwfZ+eP0Z7uGByh2whNoJ/2LGWxC5CL0Bpk79eQSrboKBKazPL
         X1ryu4EdVaWXDfFvWSEWTWfGNuZvxsmIw001up3QGcL1UqrWGKWNj/NXXWts7QemKHVU
         h4Cnjw/KZcDexgjy/33+TFdKgPYGoVIdFJbipmEYM1+AkkG6/3S6HDyP+d89gji2xMDd
         GzPh/7/xrUvbHmny4AHXbvjCjSbx8i/1jLWADy3aMEkVS+XSktqxTcUw8mQXelxKGgWJ
         nMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z6qQRqJGyPXAUQHByKcD3gHciIzlhof6rBbdttE07Yc=;
        b=LFh8XXN9cT4bMxQIyyF/AvdDqRV4wgv0FAXtADruML7wq9/eAs4lA/2UnTnthBprQ/
         4Xkw6lpzydJWOSiKQuEqTeR1OOncAnYYqmYjgc1f5orXOOeCWb9bZS/GYD+yHmBz9xxg
         7+7PQ0jRhLjBWzMRHT8mrFrUKDWeYFFE/zOe1rNCQkh197ucdQRLsJOnYiDj1k+Ko1ua
         ZaaO5fLRMlyfIfbOZtB+FVPei/i2thXWCIfZueyllz/9e1wPOH+pKOcArVw/L4ua+qto
         okZ+YIlCwzZiu3K+CE3RpYKuUaIbeZ//1K6uVNw8loTon1jtaZhzmC//bGlP049hnZxq
         wKbg==
X-Gm-Message-State: AOAM530nQpsPoAhv1zZvezYZPCEvypYgSvyOewgeCfjAKLme+2FvSbo3
        gEgFlm9iLxYHaFNZJClQQyYjr3g5PSddtQ==
X-Google-Smtp-Source: ABdhPJxjzbLeGjMoO828lOMPRD+O+LkIu1RvAi/nr6Grpqwd83rycbYFBdmBmn1ChUJIlnq+Ch46Wg==
X-Received: by 2002:a5d:47c3:: with SMTP id o3mr8349736wrc.122.1623067115157;
        Mon, 07 Jun 2021 04:58:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 92sm17215166wrp.88.2021.06.07.04.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 04:58:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/4] test-tools: migrate read-cache-perf to parse_options()
Date:   Mon,  7 Jun 2021 13:58:25 +0200
Message-Id: <patch-2.4-07f392e087-20210607T115454Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-0.4-0000000000-20210607T115454Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210607T115454Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the newly added (but then mostly copy/pasted) read-cache-perf
to use the parse_options() API. This will make things easier as we add
new options.

Since we check the "cnt = < 1" case now via more idiomatic
post-parse_options() assertions we can move from the for-loop to a
while-loop and ditch the "i" variable.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-read-cache-perf.c | 26 ++++++++++++++++++++------
 t/perf/p0002-read-cache.sh      |  2 +-
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/t/helper/test-read-cache-perf.c b/t/helper/test-read-cache-perf.c
index 90176c010a..54ad0c3135 100644
--- a/t/helper/test-read-cache-perf.c
+++ b/t/helper/test-read-cache-perf.c
@@ -1,18 +1,32 @@
 #include "test-tool.h"
 #include "cache.h"
+#include "parse-options.h"
+
+static const char *read_cache_perf_usage[] = {
+	"test-tool read-cache-perf [<options>...]",
+	NULL
+};
 
 int cmd__read_cache_perf(int argc, const char **argv)
 {
 	struct repository *r = the_repository;
-	int i, cnt = 1;
+	int cnt = -1;
+	struct option options[] = {
+		OPT_INTEGER(0, "count", &cnt, "number of passes"),
+		OPT_END()
+	};
 
-	if (argc == 2)
-		cnt = strtol(argv[1], NULL, 0);
-	else
-		die("usage: test-tool read-cache-perf [<count>]");
+	argc = parse_options(argc, argv, "test-tools", options,
+			     read_cache_perf_usage, 0);
+	if (argc > 0)
+		usage_msg_opt("Too many arguments.", read_cache_perf_usage,
+			      options);
+	if (cnt < 1)
+		usage_msg_opt("Need at least one pass.", read_cache_perf_usage,
+			      options);
 
 	setup_git_directory();
-	for (i = 0; i < cnt; i++) {
+	while (cnt--) {
 		repo_read_index(r);
 		discard_index(r->index);
 	}
diff --git a/t/perf/p0002-read-cache.sh b/t/perf/p0002-read-cache.sh
index d0ba5173fb..1762b64865 100755
--- a/t/perf/p0002-read-cache.sh
+++ b/t/perf/p0002-read-cache.sh
@@ -8,7 +8,7 @@ test_perf_default_repo
 
 count=1000
 test_perf "read_cache/discard_cache $count times" "
-	test-tool read-cache-perf $count
+	test-tool read-cache-perf --count=$count
 "
 
 test_done
-- 
2.32.0.rc3.434.gd8aed1f08a7

