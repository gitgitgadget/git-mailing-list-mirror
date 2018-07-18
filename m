Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30A261F597
	for <e@80x24.org>; Wed, 18 Jul 2018 19:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbeGRULb (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 16:11:31 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:36289 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbeGRULb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 16:11:31 -0400
Received: by mail-it0-f74.google.com with SMTP id m185-v6so3529874itm.1
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 12:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=DB4XjBgKBkOwqHYzvU1BSlbg2y+lfEdXwl26Qh1hoCQ=;
        b=SOr2BbYuEmCzEwzHJsGGa5CERgljyGB+ylE05fQ7bBQbBsJnsA/Npkb/D47h9O2Ho+
         zL0taTnpAPyEig1pjmaozEAnmcNFHm5SUmEqYfmVW/mqb4HGEl7kGZatPwqjR8pzz3Rr
         YYrmpOvxc61hoVMw7HHdV97+xNuDPM8kssTHvAWE3jRUHmZUcSQRrBportNFulDXKh3U
         8HXPOX7AKt0fhsEivtnd0pqtzw58JmNtC+sv++bV6Cdk9sCz/L3y/81mtgjmK5jztzHb
         L1xwK/Qbx1POAoJHu5IJHAj2hy87QnKierUYymPRC9sWbYqTzgOY6x86VXgdoGCfFqka
         RNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=DB4XjBgKBkOwqHYzvU1BSlbg2y+lfEdXwl26Qh1hoCQ=;
        b=n7/QskKS7oUoqwxFn+i1a4tSGGA41gr0patjyS4m2AQYpG89jKMql+t+N/+YmRMbnX
         4G943IcrGY6ze0nRIcnmSOkFac7cmONgVRMJ9bNZTWWZxoWcQU4ocB3Im2R5a74S2Aax
         d4Ojg4GSgJVgF+TSqR/C5PHfa35MJ2N6D4D1V8Epg27yp5RO8ijEVrFb1iqOd77IZZhr
         zxo8nFaS7m3Lz3yjq7YKyQ/+WtA8ERzXxd28mRANTXiYSPlV2q2Fb1esY8lG+xtW0ncK
         +42uk8zJezKncZChTSkh8a1nMacBMWqyIdWRUcxFheARqT/HC9NEmhAXau95TQRJMe4u
         MPMg==
X-Gm-Message-State: AOUpUlGYRQDYDmBunKnynSJprGFvKCymtEFUY2ZltUaNsWVdDjOgROoU
        pSTc+gvFV9NJL926EAs43BQfxCgjmZzEG5FFNX9GWIKUzMlHajb9WDOuAvOA3lr41yyHKg1vsfe
        fghB6Tu0UpKLdxbDgasjTtnelbmrKVBEMghQ0mCCoSnuuG+FrDY1LmEehFjqR
X-Google-Smtp-Source: AAOMgpfiwdcRGz7f5gpOUFQr5VMD/5NpJySu0fCcKzDhSoe/Op/4+xM8T8zc6JK8P++Voco1j0Ff0dDbQvCx
MIME-Version: 1.0
X-Received: by 2002:a6b:9cc6:: with SMTP id f189-v6mr2874639ioe.138.1531942331020;
 Wed, 18 Jul 2018 12:32:11 -0700 (PDT)
Date:   Wed, 18 Jul 2018 12:31:49 -0700
In-Reply-To: <20180718193156.47365-1-sbeller@google.com>
Message-Id: <20180718193156.47365-4-sbeller@google.com>
References: <20180718193156.47365-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH 03/10] t4015: avoid git as a pipe input
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, rybak.a.v@gmail.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In t4015 we have a pattern of

    git diff [<options, related to color>] |
        grep -v "index" |
        test_decode_color >actual &&

to produce output that we want to test against. This pattern was introduced
in 86b452e2769 (diff.c: add dimming to moved line detection, 2017-06-30)
as then the focus on getting the colors right. However the pattern used
is not best practice as we do care about the exit code of Git. So let's
not have Git as the upstream of a pipe. Piping the output of grep to
some function is fine as we assume grep to be un-flawed in our test suite.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4015-diff-whitespace.sh | 50 +++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 30 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 17df491a3ab..ddbc3901385 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1271,9 +1271,8 @@ test_expect_success 'detect permutations inside moved code -- dimmed_zebra' '
 	test_config color.diff.newMovedDimmed "normal cyan" &&
 	test_config color.diff.oldMovedAlternativeDimmed "normal blue" &&
 	test_config color.diff.newMovedAlternativeDimmed "normal yellow" &&
-	git diff HEAD --no-renames --color-moved=dimmed_zebra --color |
-		grep -v "index" |
-		test_decode_color >actual &&
+	git diff HEAD --no-renames --color-moved=dimmed_zebra --color >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
 	<BOLD>--- a/lines.txt<RESET>
@@ -1315,9 +1314,8 @@ test_expect_success 'cmd option assumes configured colored-moved' '
 	test_config color.diff.oldMovedAlternativeDimmed "normal blue" &&
 	test_config color.diff.newMovedAlternativeDimmed "normal yellow" &&
 	test_config diff.colorMoved zebra &&
-	git diff HEAD --no-renames --color-moved --color |
-		grep -v "index" |
-		test_decode_color >actual &&
+	git diff HEAD --no-renames --color-moved --color >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
 	<BOLD>--- a/lines.txt<RESET>
@@ -1395,9 +1393,8 @@ test_expect_success 'move detection ignoring whitespace ' '
 	line 4
 	line 5
 	EOF
-	git diff HEAD --no-renames --color-moved --color |
-		grep -v "index" |
-		test_decode_color >actual &&
+	git diff HEAD --no-renames --color-moved --color >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
 	<BOLD>--- a/lines.txt<RESET>
@@ -1419,9 +1416,8 @@ test_expect_success 'move detection ignoring whitespace ' '
 	EOF
 	test_cmp expected actual &&
 
-	git diff HEAD --no-renames -w --color-moved --color |
-		grep -v "index" |
-		test_decode_color >actual &&
+	git diff HEAD --no-renames -w --color-moved --color >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
 	<BOLD>--- a/lines.txt<RESET>
@@ -1459,9 +1455,8 @@ test_expect_success 'move detection ignoring whitespace changes' '
 	line 5
 	EOF
 
-	git diff HEAD --no-renames --color-moved --color |
-		grep -v "index" |
-		test_decode_color >actual &&
+	git diff HEAD --no-renames --color-moved --color >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
 	<BOLD>--- a/lines.txt<RESET>
@@ -1483,9 +1478,8 @@ test_expect_success 'move detection ignoring whitespace changes' '
 	EOF
 	test_cmp expected actual &&
 
-	git diff HEAD --no-renames -b --color-moved --color |
-		grep -v "index" |
-		test_decode_color >actual &&
+	git diff HEAD --no-renames -b --color-moved --color >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
 	<BOLD>--- a/lines.txt<RESET>
@@ -1526,9 +1520,8 @@ test_expect_success 'move detection ignoring whitespace at eol' '
 	# avoid cluttering the output with complaints about our eol whitespace
 	test_config core.whitespace -blank-at-eol &&
 
-	git diff HEAD --no-renames --color-moved --color |
-		grep -v "index" |
-		test_decode_color >actual &&
+	git diff HEAD --no-renames --color-moved --color >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
 	<BOLD>--- a/lines.txt<RESET>
@@ -1550,9 +1543,8 @@ test_expect_success 'move detection ignoring whitespace at eol' '
 	EOF
 	test_cmp expected actual &&
 
-	git diff HEAD --no-renames --ignore-space-at-eol --color-moved --color |
-		grep -v "index" |
-		test_decode_color >actual &&
+	git diff HEAD --no-renames --ignore-space-at-eol --color-moved --color >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
 	<BOLD>--- a/lines.txt<RESET>
@@ -1597,9 +1589,8 @@ test_expect_success '--color-moved block at end of diff output respects MIN_ALNU
 	irrelevant_line
 	EOF
 
-	git diff HEAD --color-moved=zebra --color --no-renames |
-		grep -v "index" |
-		test_decode_color >actual &&
+	git diff HEAD --color-moved=zebra --color --no-renames >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat >expected <<-\EOF &&
 	<BOLD>diff --git a/bar b/bar<RESET>
 	<BOLD>--- a/bar<RESET>
@@ -1636,9 +1627,8 @@ test_expect_success '--color-moved respects MIN_ALNUM_COUNT' '
 	nineteen chars 456789
 	EOF
 
-	git diff HEAD --color-moved=zebra --color --no-renames |
-		grep -v "index" |
-		test_decode_color >actual &&
+	git diff HEAD --color-moved=zebra --color --no-renames >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat >expected <<-\EOF &&
 	<BOLD>diff --git a/bar b/bar<RESET>
 	<BOLD>--- a/bar<RESET>
-- 
2.18.0.233.g985f88cf7e-goog

