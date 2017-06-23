Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C7B120898
	for <e@80x24.org>; Fri, 23 Jun 2017 01:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754128AbdFWBaA (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 21:30:00 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36532 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753557AbdFWB37 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 21:29:59 -0400
Received: by mail-pg0-f43.google.com with SMTP id u62so14980655pgb.3
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 18:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0bUnRluoSGCQ5yA/+jSncFIz6dRdlo8NVItrJVqLwu8=;
        b=EY+L8hUPIhXqaNGie5DJzbUwtRUA2VLaqw352JPWU8e+bbN6LGi75Zgaqgaxmgxci4
         kPd+Sm6iIwk5Bj6G0sOBfoWCiakpTEhTiBDhOW2ifkE0OaLW+izP342EJGdwuEbkQHXT
         py6K9JYjxDJSyWTdBqYpYXuRjXsCmFeq9Z0IzE97Y2KrdqfxAZGtWJr169EdzthUBXhf
         OS3cK0SrvSQTHz/dDFsQDbzZ0NWIG7XGWwwEEr0My81sL00xYD1j9gUp3GlApmvt+cki
         VvYte0F6ZHk/omB6KixMLdBd9P4f+s6j88fO65YHaSw49ee247SiI/7ZspWh+M19o1iV
         1csg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0bUnRluoSGCQ5yA/+jSncFIz6dRdlo8NVItrJVqLwu8=;
        b=dT4Dn2hRsEJm7VSvKIj4X+7JOdMYFgpjLj5h1JI7TncufgHxPB8k6b9uzSdcvvjrgG
         NFPpQ8xzeWlLRcbCH6783ySQYu9UumKGfcRZ1beibSrW3c/KVHLnfa7+0eftcxORpFAJ
         xslFgJdMfp/18Ha+z3p/ArxLjh6F6cbXNJbTiNtDToLRzMyVFuJTSUCWJIA75r8NsPJj
         SFf7cvJe3H3b8YWtqskJLFQLhwD7zcFXJ1yIIZ2rha84SUzgodxETk7v25NipSlZLvw5
         AkzcIR8qt3ZXBDTPqz9xQr2TaHUC/wZhOzhTZcXZFTLnacHf5dBOxo9cb1RjOxlapeZz
         pJrQ==
X-Gm-Message-State: AKS2vOzQNUz1QMH1Fv/lEBIwdYF/HEkx6CWC71mL/WGNYmP4d5D8DXuF
        e9q93lAxMtQyWh+P
X-Received: by 10.99.8.1 with SMTP id 1mr5518052pgi.15.1498181398489;
        Thu, 22 Jun 2017 18:29:58 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:54b:7db6:84cb:995a])
        by smtp.gmail.com with ESMTPSA id a84sm6315423pfe.19.2017.06.22.18.29.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 18:29:56 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCHv2 23/25] diff.c: color moved lines differently, plain mode
Date:   Thu, 22 Jun 2017 18:29:17 -0700
Message-Id: <20170623012919.28693-24-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170623012919.28693-1-sbeller@google.com>
References: <20170620024816.20021-1-sbeller@google.com>
 <20170623012919.28693-1-sbeller@google.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c                     |  5 +++++
 diff.h                     |  1 +
 t/t4015-diff-whitespace.sh | 51 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index e6f547804f..0eb744514f 100644
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
@@ -831,6 +833,9 @@ static void mark_color_as_moved(struct diff_options *o,
 
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

