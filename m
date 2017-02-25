Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BA302022D
	for <e@80x24.org>; Sat, 25 Feb 2017 07:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751683AbdBYHZY (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 02:25:24 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33965 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751647AbdBYHZW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 02:25:22 -0500
Received: by mail-pg0-f68.google.com with SMTP id s67so5891760pgb.1
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 23:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9AtnfrxRPJJ0I9iYQEUN/Y8loQIfIqLjEYAdj4GTGnE=;
        b=q9jNKHKu7IP9ty2+yFUwZ8/loFQ2h2PNoJSVYx+Tpz2Yj3Q4jPZmIv1GZWxS64hG5a
         rR+TBrpjCElmvAh5MTRrPkYYiAMpZIE3MP4pPZr4+v3VhsB8y0t/RR0VN2IH/NL8BgxF
         oEamtyzMWp5leQWuMUfdp4ZGHH6lxiULnpGRICC0b/t48mmGHybrW67nI7KsADWVIZ9G
         e4vKBOXd81A4G2e+xXJIufKGEPbP/JjnpGrBetY0dL2esTz7JZop//GYF7gGdJl5htA2
         Ekns9wfavNuHftawoHAbx06mCOY8prhtjTyYnboeHiN2KF/EMjKkXvSEuXbOpr5yFVto
         oBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9AtnfrxRPJJ0I9iYQEUN/Y8loQIfIqLjEYAdj4GTGnE=;
        b=p0LSP/OWBe6AJZaWs60VmQIu7Z1RM5h49kZV/3JlU/BaBEENissGgjbwR5RwiHkiSA
         z6np5Ofq1SMkcCu+CK1N0MuO8sDYQDekBGSMLPTvsU24jpToe97UH2Xp3V7aqthyOa14
         Uqsz1H0v8teUvsf8ltlhBKA6saIVA3157WKHetO3yyAtGWzssUqVVniwGRqSsNckQ2yN
         fPbs2QS3+XYKuyU667lM3u2VE6I85Ol3pIikCmU7/xhf7Q4TZ9c/JvHHr+63cXJCxCf9
         RFLT00Szh665lmDoYmc6EH9XFIJiDYCe7pVLz/gystrx1n4OSecB8Yq8J/2syht78kC3
         rtkQ==
X-Gm-Message-State: AMke39kSrh6AJxAjADvLQnLz1TCtuEwXCyViNkp65a3iF80j8iElyr5swjBxwD5chFqNIA==
X-Received: by 10.84.224.11 with SMTP id r11mr9586741plj.130.1488007521983;
        Fri, 24 Feb 2017 23:25:21 -0800 (PST)
Received: from localhost ([139.59.1.28])
        by smtp.gmail.com with ESMTPSA id u24sm18683445pfi.25.2017.02.24.23.25.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Feb 2017 23:25:21 -0800 (PST)
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Matthieu.Moy@imag.fr, pranit.bauva@gmail.com,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx,
        Siddharth Kannan <kannan.siddharth12@gmail.com>
Subject: [PATCH 6/6 v5] revert.c: delegate handling of "-" shorthand to setup_revisions
Date:   Sat, 25 Feb 2017 07:24:47 +0000
Message-Id: <1488007487-12965-7-git-send-email-kannan.siddharth12@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1488007487-12965-1-git-send-email-kannan.siddharth12@gmail.com>
References: <1488007487-12965-1-git-send-email-kannan.siddharth12@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

revert.c:run_sequencer calls setup_revisions right after replacing "-" with
"@{-1}" for this shorthand. A previous patch taught setup_revisions to handle
this shorthand by doing the required replacement inside revision.c:get_sha1_1.

Hence, the code here is redundant and has been removed.

This patch also adds a test to check that revert recognizes the "-" shorthand.

Signed-off-by: Siddharth Kannan <kannan.siddharth12@gmail.com>
---
 builtin/revert.c            |  2 --
 t/t3514-revert-shorthand.sh | 25 +++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)
 create mode 100755 t/t3514-revert-shorthand.sh

diff --git a/builtin/revert.c b/builtin/revert.c
index 4ca5b51..0bc6657 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -155,8 +155,6 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 		opts->revs->no_walk = REVISION_WALK_NO_WALK_UNSORTED;
 		if (argc < 2)
 			usage_with_options(usage_str, options);
-		if (!strcmp(argv[1], "-"))
-			argv[1] = "@{-1}";
 		memset(&s_r_opt, 0, sizeof(s_r_opt));
 		s_r_opt.assume_dashdash = 1;
 		argc = setup_revisions(argc, argv, opts->revs, &s_r_opt);
diff --git a/t/t3514-revert-shorthand.sh b/t/t3514-revert-shorthand.sh
new file mode 100755
index 0000000..51f8c81d
--- /dev/null
+++ b/t/t3514-revert-shorthand.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+
+test_description='log can show previous branch using shorthand - for @{-1}'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit first
+'
+
+test_expect_success 'setup branches' '
+        echo "hello" >hello &&
+        cat hello >expect &&
+        git add hello &&
+        git commit -m "hello first commit" &&
+        echo "world" >>hello &&
+        git commit -am "hello second commit" &&
+        git checkout -b testing-1 &&
+        git checkout master &&
+        git revert --no-edit - &&
+        cat hello >actual &&
+        test_cmp expect actual
+'
+
+test_done
-- 
2.1.4

