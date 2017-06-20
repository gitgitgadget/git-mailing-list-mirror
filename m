Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF57F1FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 02:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751938AbdFTCtT (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 22:49:19 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33155 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751789AbdFTCsy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 22:48:54 -0400
Received: by mail-pf0-f179.google.com with SMTP id 83so62786264pfr.0
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 19:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6i875v+8ZFJeZJH88h3nNmgC50sbD2PxrHFqm2b0lwk=;
        b=tpuz2gzeGGGGV5WnRAx4Oe9kWNsS35TFRur1dFKLZtZmxSE7/qj7YTOrKaZ5feosSH
         B3p8GvgDUr6C1xIXz0HWXVflDiUASrxt25i9apuHApIE/4r/583FwOX3Sj4UG+cK4Dwl
         9nq0UDW/Z0U2w59d5jzT5sQvy/oa7cI6r8QM04fpRlTUGDC8FS3MfVX5DQAMZr8n0zJA
         5M/K3LIfgg9dODUUajvjHUvQzddWlBAjtjo83sikF59YJeJe6LB1dG3ykdzcNzOQdyjx
         T04+v3ljwuiM7e1wxV7tKol5pJczyPXFBKoYaKk/Rh45+mzYJynNtxXiYV0De3PX6fWF
         gk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6i875v+8ZFJeZJH88h3nNmgC50sbD2PxrHFqm2b0lwk=;
        b=QYFg45JS+XpMqZvkxu537RdBj5UUD6Q46LKbgj9NaGnyEsfy6E1j11whwFmjf5HSm0
         rHlTpN0Iqw8pBEo+0YkTj5ja5gG3fmlHIPZ+2H4U7TnLrzsXwGc6LVigg5+oSLUGCnRn
         CmG8pxO//eEO62evYZfqUY5rEa5McXBvmc6WeeRnKddRi++gcJz/EFyrwGZSq3xm55zv
         zHvvZyPFdGnG1PTRDV1plYBXarfoENk510B1cYvg/h8f1Vfg4Y86ILbPSw/S53D7tcSA
         ++EGQ640bOVmpsD8X0ztsHy4pIryQuXeF7/dzcRNgdsPGwLBilwoQVTDLxG4zIBALMuv
         YNLw==
X-Gm-Message-State: AKS2vOxAaTTHxZUjjn06DWVK/tEavs2+yvW/KqyXQLtxUuR9nD8N3C5b
        0KUUUodqSmhCdKbk
X-Received: by 10.99.113.11 with SMTP id m11mr29031689pgc.45.1497926933715;
        Mon, 19 Jun 2017 19:48:53 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:bc0c:b118:3a9a:5fd4])
        by smtp.gmail.com with ESMTPSA id v17sm21905614pgn.4.2017.06.19.19.48.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 19:48:52 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCH 23/26] diff.c: color moved lines differently, plain mode
Date:   Mon, 19 Jun 2017 19:48:13 -0700
Message-Id: <20170620024816.20021-24-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170620024816.20021-1-sbeller@google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
 <20170620024816.20021-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the 'plain' mode for move detection of code.
This omits the checking for adjacent blocks, so it is not as useful.
If you have a lot of the same blocks moved in the same patch, the 'Zebra'
would end up slow as it is O(n^2) (n is number of same blocks).
So this may be useful there and is generally easy to add

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c                     |  5 +++++
 diff.h                     |  1 +
 t/t4015-diff-whitespace.sh | 51 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 20c1f9b99f..0d41a53b76 100644
--- a/diff.c
+++ b/diff.c
@@ -246,6 +246,8 @@ static int parse_color_moved(const char *arg)
 {
 	if (!strcmp(arg, "no"))
 		return COLOR_MOVED_NO;
+	else if (!strcmp(arg, "plain"))
+		return COLOR_MOVED_PLAIN;
 	else if (!strcmp(arg, "zebra"))
 		return COLOR_MOVED_ZEBRA;
 	else
@@ -830,6 +832,9 @@ static void mark_color_as_moved(struct diff_options *o,
 
 		l->flags |= DIFF_SYMBOL_MOVED_LINE;
 
+		if (o->color_moved == COLOR_MOVED_PLAIN)
+			continue;
+
 		/* Check any potential block runs, advance each or nullify */
 		for (i = 0; i < pmb_nr; i++) {
 			struct moved_entry *p = pmb[i];
diff --git a/diff.h b/diff.h
index 7726ad255c..1aae8738ca 100644
--- a/diff.h
+++ b/diff.h
@@ -190,6 +190,7 @@ struct diff_options {
 	struct emitted_diff_symbols *emitted_symbols;
 	enum {
 		COLOR_MOVED_NO = 0,
+		COLOR_MOVED_PLAIN = 1,
 		COLOR_MOVED_ZEBRA = 2,
 	} color_moved;
 };
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 4a03766f1f..1ca16435d6 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -986,7 +986,7 @@ test_expect_success 'detect moved code, complete file' '
 	git mv test.c main.c &&
 	test_config color.diff.oldMoved "normal red" &&
 	test_config color.diff.newMoved "normal green" &&
-	git diff HEAD --color-moved --no-renames | test_decode_color >actual &&
+	git diff HEAD --color-moved=zebra --no-renames | test_decode_color >actual &&
 	cat >expected <<-\EOF &&
 	<BOLD>diff --git a/main.c b/main.c<RESET>
 	<BOLD>new file mode 100644<RESET>
@@ -1130,6 +1130,55 @@ test_expect_success 'detect malicious moved code, inside file' '
 	test_cmp expected actual
 '
 
+test_expect_success 'plain moved code, inside file' '
+	test_config color.diff.oldMoved "normal red" &&
+	test_config color.diff.newMoved "normal green" &&
+	test_config color.diff.oldMovedAlternative "blue" &&
+	test_config color.diff.newMovedAlternative "yellow" &&
+	# needs previous test as setup
+	git diff HEAD --no-renames --color-moved=plain| test_decode_color >actual &&
+	cat <<-\EOF >expected &&
+	<BOLD>diff --git a/main.c b/main.c<RESET>
+	<BOLD>index 27a619c..7cf9336 100644<RESET>
+	<BOLD>--- a/main.c<RESET>
+	<BOLD>+++ b/main.c<RESET>
+	<CYAN>@@ -5,13 +5,6 @@<RESET> <RESET>printf("Hello ");<RESET>
+	 printf("World\n");<RESET>
+	 }<RESET>
+	 <RESET>
+	<BRED>-int secure_foo(struct user *u)<RESET>
+	<BRED>-{<RESET>
+	<BRED>-if (!u->is_allowed_foo)<RESET>
+	<BRED>-return;<RESET>
+	<BRED>-foo(u);<RESET>
+	<BRED>-}<RESET>
+	<BRED>-<RESET>
+	 int main()<RESET>
+	 {<RESET>
+	 foo();<RESET>
+	<BOLD>diff --git a/test.c b/test.c<RESET>
+	<BOLD>index 1dc1d85..2bedec9 100644<RESET>
+	<BOLD>--- a/test.c<RESET>
+	<BOLD>+++ b/test.c<RESET>
+	<CYAN>@@ -4,6 +4,13 @@<RESET> <RESET>int bar()<RESET>
+	 printf("Hello World, but different\n");<RESET>
+	 }<RESET>
+	 <RESET>
+	<BGREEN>+<RESET><BGREEN>int secure_foo(struct user *u)<RESET>
+	<BGREEN>+<RESET><BGREEN>{<RESET>
+	<BGREEN>+<RESET><BGREEN>foo(u);<RESET>
+	<BGREEN>+<RESET><BGREEN>if (!u->is_allowed_foo)<RESET>
+	<BGREEN>+<RESET><BGREEN>return;<RESET>
+	<BGREEN>+<RESET><BGREEN>}<RESET>
+	<BGREEN>+<RESET>
+	 int another_function()<RESET>
+	 {<RESET>
+	 bar();<RESET>
+	EOF
+
+	test_cmp expected actual
+'
+
 test_expect_success 'no effect from --color-moved with --word-diff' '
 	cat <<-\EOF >text.txt &&
 	Lorem Ipsum is simply dummy text of the printing and typesetting industry.
-- 
2.12.2.575.gb14f27f917

