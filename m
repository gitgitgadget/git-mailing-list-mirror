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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1761AC4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 09:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F05F7600D4
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 09:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhHRJZs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 05:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbhHRJZi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 05:25:38 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8EAC0613CF
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 02:25:01 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id d6so2092998edt.7
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 02:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t0cKBq0cO0WjKJtF/MOifGlhwEeOSHikty6oGkruHtI=;
        b=nPIXaGJRtKpdNf9Vr2AuGUk1zET5LdpOXWCTS6+3iHAoU5ZbH1p5mOCyycsiDegUix
         w/e3s495VSty3OdybpGMZqEXi6uYRW5b537+I+h0EDv8bePzb0IIfqc4nH0BeHwYnUfz
         GXmPjR2VU9UCRCG+RKR9PO0f5w4D2OKsRe5Mb9Un3Ix/ew1ooDNXAV2Q0kBdqfva2m9D
         McItH4bouekpcWd7HyoTgd+h1yJr5ppTawdzaf+tQCEj5OwnIU3iB409fXv6210ikTZW
         6YPLjZqRD4JnwyuQDne2OlMnVzaJOgQ03uqXdoR1z5xfRhnMh8kAUIwPnWIojvp1FYGq
         OAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t0cKBq0cO0WjKJtF/MOifGlhwEeOSHikty6oGkruHtI=;
        b=fLASg5JHWR5atc45hboh53oH8n61QseLux18xsa3BXpkN8Z53lxx9T+jIY4jsGtY7T
         uCFrDsolLsiqnMqkh0JJttKNufXjFNOA2FuRFepHWCjhDpjUJvi3RHPPatwcGQHDyy+/
         0bkBSpAA7nABmfpAFOQYc8QkKxQzFZKfdvbh1yO4M9kKwpDjxx71TCjthTxo06ftK13w
         Jzts5ZHak1Q1uZ/za/7Ck6GSThAi0l7wfuhcd2C/Fnb1yVomElRpb/P2GYRfwkyGRwOF
         Lk9FfsveuvUNsP56UIomItvBHmUYTEi+sLUqXxQGIiGxI4g4dU7h8aXRlr2CGG8aVLLG
         v6eQ==
X-Gm-Message-State: AOAM532cGyeqBZb2v6tYgXnOD445oqb9O3MNcfEfT830vqkKJ9nFM7uI
        bHFaEyYIn5nxQ0bxFkwY/3LtQpdNaro=
X-Google-Smtp-Source: ABdhPJytzy8nbf9D/0cE3qoGMmTb+5Hnw+fTHCiYscYwO04eR0TK9nHW6au1e/gNCGszmURufLzDKw==
X-Received: by 2002:a05:6402:152:: with SMTP id s18mr8899904edu.221.1629278700390;
        Wed, 18 Aug 2021 02:25:00 -0700 (PDT)
Received: from localhost.localdomain (78-131-17-78.pool.digikabel.hu. [78.131.17.78])
        by smtp.gmail.com with ESMTPSA id q5sm2326760edt.50.2021.08.18.02.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 02:25:00 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] column: fix parsing of the '--nl' option
Date:   Wed, 18 Aug 2021 11:24:56 +0200
Message-Id: <20210818092456.3045808-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.33.0.453.gc5e41af357
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git column's '--nl' option can be used to specify a "string to be
printed at the end of each line" (quoting the man page), but this
option and its mandatory argument has been parsed as OPT_INTEGER since
the introduction of the command in 7e29b8254f (Add column layout
skeleton and git-column, 2012-04-21).  Consequently, any non-number
argument is rejected by parse-options, and any number other than 0
leads to segfault:

  $ printf "%s\n" one two |git column --mode=plain --nl=foo
  error: option `nl' expects a numerical value
  $ printf "%s\n" one two |git column --mode=plain --nl=42
  Segmentation fault (core dumped)
  $ printf "%s\n" one two |git column --mode=plain --nl=0
  one
  two

Parse this option as OPT_STRING.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/git-column.txt |  2 +-
 builtin/column.c             |  2 +-
 t/t9002-column.sh            | 18 ++++++++++++++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-column.txt b/Documentation/git-column.txt
index f58e9c43e6..6cea9ab463 100644
--- a/Documentation/git-column.txt
+++ b/Documentation/git-column.txt
@@ -39,7 +39,7 @@ OPTIONS
 --indent=<string>::
 	String to be printed at the beginning of each line.
 
---nl=<N>::
+--nl=<string>::
 	String to be printed at the end of each line,
 	including newline character.
 
diff --git a/builtin/column.c b/builtin/column.c
index 40d4b3bee2..158fdf53d9 100644
--- a/builtin/column.c
+++ b/builtin/column.c
@@ -29,7 +29,7 @@ int cmd_column(int argc, const char **argv, const char *prefix)
 		OPT_INTEGER(0, "raw-mode", &colopts, N_("layout to use")),
 		OPT_INTEGER(0, "width", &copts.width, N_("maximum width")),
 		OPT_STRING(0, "indent", &copts.indent, N_("string"), N_("padding space on left border")),
-		OPT_INTEGER(0, "nl", &copts.nl, N_("padding space on right border")),
+		OPT_STRING(0, "nl", &copts.nl, N_("string"), N_("padding space on right border")),
 		OPT_INTEGER(0, "padding", &copts.padding, N_("padding space between columns")),
 		OPT_END()
 	};
diff --git a/t/t9002-column.sh b/t/t9002-column.sh
index 89983527b6..6d3dbde3fe 100755
--- a/t/t9002-column.sh
+++ b/t/t9002-column.sh
@@ -42,6 +42,24 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_success '--nl' '
+	cat >expected <<\EOF &&
+oneZ
+twoZ
+threeZ
+fourZ
+fiveZ
+sixZ
+sevenZ
+eightZ
+nineZ
+tenZ
+elevenZ
+EOF
+	git column --nl="Z$LF" --mode=plain <lista >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success '80 columns' '
 	cat >expected <<\EOF &&
 one    two    three  four   five   six    seven  eight  nine   ten    eleven
-- 
2.33.0.453.gc5e41af357

