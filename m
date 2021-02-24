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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77175C433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4035264F08
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbhBXT5o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235207AbhBXTyC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:54:02 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4760EC0611C2
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:16 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id u14so3051928wri.3
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IkBGGjQHAjplwjvCfMMn7O/Kdu3StAf66jdZrlVtz40=;
        b=W7uXYowYDfv4/Yb+58jMLseEjOYMdJB5aV4eBWs4OWE3mkr3BEV4eRDmwBbO1f4gWl
         5LgXDTefJLFkx9q2RWV1qaUSQW36dJ1QAy569NpfWgcIzuEP1RONq8bkDvxj3NI7yFGF
         5AeyyCTWGsZZLyvBgq+2E32C9D3dhE/UrrPfVP5YligD5MDL/rh14Kk9+Oy5Sd0/Wiha
         TSsOtsq+o3Cphn1xH/iWRl5kPVKw77Qo+ST/Hgq1RUPMfOtv2Ox8ZN6KLaAvnI819fcU
         5aqLeYN6gyhmuG+u57CnDhxzLPqVcqEenyzJPrYQCr3YGEeD6UJdTE+OwJIVyew3NLwj
         YpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IkBGGjQHAjplwjvCfMMn7O/Kdu3StAf66jdZrlVtz40=;
        b=LTHRrDbdqdoN/nQixpyuaoHLZtxsJX5wgTHzVTbaNvFCEd2w65qhJWw/2VIOs0hfw3
         zzNsNGP7sSWeD4m9P3JJ/zsQk+OZKu45kFAiPDdvuBEafkJvAYM4pjd8LUNs0kbF15go
         k/u++vwUDi0DSyvYDRBKDDMSjE2v/B/6gsFktOmeMXkuzp9z6VD6GQCHzZ5zjPFH7wpy
         nh/NdN/2CU342Zggv5ioKhBVPka+DzF6K9E+enVVhBSTNkVUa4zudz6FxHEGOqjMNPrV
         b5/dCjLoXtQQpnZOZgpYKIcv+p/HKccZa3jfGNC4jp7iowwFxXsRZrItZTDCPpD1bwTp
         QV/w==
X-Gm-Message-State: AOAM530NxTlc4ogaW3bUcnZ6IoJyL+yN2OdrZ1VDyvr0B49PDtfi/t3d
        xH/eNJs964aehemvo2LphGnM60nEz+dmAA==
X-Google-Smtp-Source: ABdhPJxGGuB3y0RzD823PEEiCTESieZBJFZHv7lG7Y0rvMaN1A3fGwNtmS1D5WVcW0EkfSfhukCb9g==
X-Received: by 2002:adf:9564:: with SMTP id 91mr32313973wrs.207.1614196334766;
        Wed, 24 Feb 2021 11:52:14 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:52:14 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 26/35] userdiff tests: switch to -U0 by default
Date:   Wed, 24 Feb 2021 20:51:20 +0100
Message-Id: <20210224195129.4004-27-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the -U1 default in the userdiff tests to -U0. There's no reason
to use -U1, it just causes confusion and the need to work around the
test semantics themselves by not having the matching line immediately
precede the changed line.

The -U1 was initially added in f12c66b9bb8 (userdiff/perl: anchor
"sub" and "package" patterns on the left, 2011-05-21), seemingly to
appease a specific test I'd reported as failing with the "perl"
pattern. This was then documented in bfa7d01413b (t4018: an
infrastructure to test hunk headers, 2014-03-21).

There's no special logic in xdiff/xemit.c that would depend on -U1
v.s. -U0 here. So let's use -U0 for simplicity, we're interested in
what lines match most of the time, not at which line we start the
search.

A couple of test cases depended on the -U1, most confusingly one of
the custom.sh test cases.

Let's extend "test_diff_funcname()" to take an argument to "git diff"
and test "-U1" there, both because rewriting the testcase would be
painful to understand in the context of reviewing this change, and so
that we explicitly test that we're using -U0.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018-diff-funcname.sh | 5 +++--
 t/t4018/README           | 7 +++----
 t/t4018/custom.sh        | 1 +
 t/t4018/perl.sh          | 1 -
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index a3058fda130..ca23d156666 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -104,7 +104,7 @@ do
 	"
 
 	test_expect_success "hunk header: $i" "
-		git diff -U1 $i >diff &&
+		git diff -U0 $i >diff &&
 		last_diff_context_line diff >ctx &&
 		test_cmp t4018/$i.header ctx
 	"
@@ -112,6 +112,7 @@ done
 
 test_diff_funcname () {
 	desc=$1
+	diff_opts=${2:--U0} &&
 	cat <&8 >arg.header &&
 	cat <&9 >arg.test &&
 	what=$(cat arg.what) &&
@@ -124,7 +125,7 @@ test_diff_funcname () {
 	' &&
 
 	test_expect_success "$desc" '
-		git diff -U1 "$what" >diff &&
+		git diff $diff_opts "$what" >diff &&
 		last_diff_context_line diff >actual &&
 		test_cmp expected actual
 	' &&
diff --git a/t/t4018/README b/t/t4018/README
index a3220dd6374..cef7d3c0e17 100644
--- a/t/t4018/README
+++ b/t/t4018/README
@@ -5,11 +5,10 @@ How to write test cases
 There are two ways of writing tests in this directory. In both cases
 "LANG" is the userdiff driver name, e.g. "perl" or "cpp".
 
-The word "ChangeMe" (exactly this form) should appear at a distance of
-at least two lines from the line that must appear in the hunk
-header. See below sections.
+The word "ChangeMe" below the line that must appear in the hunk header
+(we run the diff with -U0). See below sections.
 
-t4018 header: t/README.
+t4018 header: The content of the "EOF_TEST" argument is used as-is, with the
 "LANG.sh" test cases
 ====================
 
diff --git a/t/t4018/custom.sh b/t/t4018/custom.sh
index 127524afda3..97f310c02fb 100755
--- a/t/t4018/custom.sh
+++ b/t/t4018/custom.sh
@@ -10,6 +10,7 @@ test_expect_success 'custom: setup non-trivial custom' '
 '
 
 test_diff_funcname 'custom: non-trivial custom pattern' \
+	'-U1' \
 	8<<\EOF_HUNK 9<<\EOF_TEST
 int special, RIGHT;
 EOF_HUNK
diff --git a/t/t4018/perl.sh b/t/t4018/perl.sh
index ba11241750b..63f373d1a43 100755
--- a/t/t4018/perl.sh
+++ b/t/t4018/perl.sh
@@ -89,6 +89,5 @@ sub foo;
 EOF_HUNK
 sub foo;
 =head1
-
 ChangeMe
 EOF_TEST
-- 
2.30.0.284.gd98b1dd5eaa7

