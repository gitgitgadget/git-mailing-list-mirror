Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD5DF2022D
	for <e@80x24.org>; Sat, 25 Feb 2017 07:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751693AbdBYHZ1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 02:25:27 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33943 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751559AbdBYHZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 02:25:25 -0500
Received: by mail-pg0-f68.google.com with SMTP id s67so5891644pgb.1
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 23:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zXDgxJavABqprPlMQYD93bivryWIZyqsAi19zSHoH/U=;
        b=VwcEoFQsWA2ViHnbR+ymLiXP88xeteasogm7ojOa/8PQbmY+IeC64PO+pUBNvoZVDr
         U6utoBWai9gyyR5BEsRiZ+sreXiuQ0/QC5R/FyCy2QeXMiCHk5I3poxH9AYuUt3jLO7/
         wpDYodQFuWSnflnB8XojtzmOCsiJBRuS90AHg9JiRTGDCPdnfZR/h5qINMS8W40Erwo3
         8FLVAVGiXKNySdb3BU5JcLX48Dysn/qHuxzv4V2bMytmopF6ayUFQiKSRKbG+nR1CjHu
         Bp2gn3m26OmG1pivYUdUtUgpIdVHfBAg52eD+QJ9K6Z6mFXds/JqJOL82dEpV+U1MsmR
         SjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zXDgxJavABqprPlMQYD93bivryWIZyqsAi19zSHoH/U=;
        b=WkfHnJuEtOpVqgtX6C/09n4NcWG1MTYWx3AgqHLVACvklRD3dH56/uhGv/IIBaqpOJ
         o+l4j8Fm9Gra+VjXUgvO9MLvUBb3TY0hPpleMBAE9UFegO5ZMCS6qSt701tSqKOE1ZQe
         hcSw7BjL8FynF4Uu2iB3mQl6HQxzLxS+J8Fmv3s5MGwzTYeWHGH4NXe0+l6ggQ1or3yX
         /2Mn6juYbhSOA7VU+55asvkxmI4tURM3f+RIKgg+I9za1YIr7SHd6vCr6mh+jyVwftH+
         I0ujQjq/isi125L/9G73MLheIn1O8YkHv08q2UkFaarPfP0bQJDPQHcfiYitcpmROlWJ
         U3tQ==
X-Gm-Message-State: AMke39lthDjQwadhdCSTLX8/4MZSG9qvviX/cBLd4eE3PoXSRNBymL/U+ZNaqjMAX0HbuA==
X-Received: by 10.99.107.130 with SMTP id g124mr8438923pgc.108.1488007519423;
        Fri, 24 Feb 2017 23:25:19 -0800 (PST)
Received: from localhost ([139.59.1.28])
        by smtp.gmail.com with ESMTPSA id y9sm4646557pfi.39.2017.02.24.23.25.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Feb 2017 23:25:18 -0800 (PST)
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Matthieu.Moy@imag.fr, pranit.bauva@gmail.com,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx,
        Siddharth Kannan <kannan.siddharth12@gmail.com>
Subject: [PATCH 5/6 v5] merge.c: delegate handling of "-" shorthand to revision.c:get_sha1
Date:   Sat, 25 Feb 2017 07:24:46 +0000
Message-Id: <1488007487-12965-6-git-send-email-kannan.siddharth12@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1488007487-12965-1-git-send-email-kannan.siddharth12@gmail.com>
References: <1488007487-12965-1-git-send-email-kannan.siddharth12@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The callchain for handling each argument contains the function
revision.c:get_sha1 where the shorthand for "-" ~ "@{-1}" has already been
implemented in a previous patch; the complete callchain leading to that
function is:

1. merge.c:collect_parents
2. commit.c:get_merge_parent : this function calls revision.c:get_sha1

This patch also adds a test for checking that the shorthand works properly

Signed-off-by: Siddharth Kannan <kannan.siddharth12@gmail.com>
---
 builtin/merge.c                   |  2 --
 t/t3035-merge-hyphen-shorthand.sh | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)
 create mode 100755 t/t3035-merge-hyphen-shorthand.sh

diff --git a/builtin/merge.c b/builtin/merge.c
index a96d4fb..36ff420 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1228,8 +1228,6 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			argc = setup_with_upstream(&argv);
 		else
 			die(_("No commit specified and merge.defaultToUpstream not set."));
-	} else if (argc == 1 && !strcmp(argv[0], "-")) {
-		argv[0] = "@{-1}";
 	}
 
 	if (!argc)
diff --git a/t/t3035-merge-hyphen-shorthand.sh b/t/t3035-merge-hyphen-shorthand.sh
new file mode 100755
index 0000000..fd37ff9
--- /dev/null
+++ b/t/t3035-merge-hyphen-shorthand.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+
+test_description='merge uses the shorthand - for @{-1}'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit first &&
+	test_commit second &&
+	test_commit third &&
+	test_commit fourth &&
+	test_commit fifth &&
+	test_commit sixth &&
+	test_commit seventh
+'
+
+test_expect_success 'setup branches' '
+        git checkout master &&
+        git checkout -b testing-2 &&
+        git checkout -b testing-1 &&
+        test_commit eigth &&
+        test_commit ninth
+'
+
+test_expect_success 'merge - should work' '
+        git checkout testing-2 &&
+        git merge - &&
+        git rev-parse HEAD HEAD^^ | sort >actual &&
+        git rev-parse master testing-1 | sort >expect &&
+        test_cmp expect actual
+'
+
+test_done
-- 
2.1.4

