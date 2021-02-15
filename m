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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9341C433E0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 16:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DED964D9D
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 16:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbhBOQVA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 11:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbhBOPrq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 10:47:46 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312A2C0611BD
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:45:06 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id l12so9497756wry.2
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vPd6nLXvIP6jTAsnv4H2DqTYT74gf59eeM2suTUi1BE=;
        b=myIeX/rxCR0xntRh+VXJI5+lBbjZBCffxKCSK5gbmSciVk0dYMW0YA61aJRUgmslWI
         wR03YVulYrPz13YRdDif+oPuo7S0QxwylB3B5zimGLjw9rOljk5rMbCFD/iC7VCjJidT
         TQmioY1Y1ulu6vKP7hetmlWjKeb+J/PDCOrU3s60b6A8QGZCL4v+3S4c8Bq7gqycC9E7
         VJugmGtc8VxF2RefTHnHc+LVeXl8OTMIci9wuh73l1YCPaghVHFP2ABCVL8LKWrLYWil
         0pjq+hITnIORULseP8Pa72N559+Y+01SwYQJlfbnjNTMfx2E/r+e1fOgLVF+4J8o/Sj2
         qySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vPd6nLXvIP6jTAsnv4H2DqTYT74gf59eeM2suTUi1BE=;
        b=hFPVO2K9iCa59p1BpH1emDHLlpt2Yj99EFYXVWxTTiRgTWzuE3MKGOfFEbq+C3mfSP
         uNaKxyDPwZctzkzOOCBr5exFfmiS8NmJNl5iI8XjDcoW88oUoJtZl4SODSwsu3M2/HVN
         RdAutPB4RHADUhjQ5AzQ538QD3K71mUvDk+6bPCWvxOvPcXeLwVKXXD4OCjPx84qO4Nv
         3HtHyIpFDHccxA7yOrcH5cqJyumT601VEZ0ZLNDH5sUJVspTVfloMHN68FDwsBp95kLQ
         PtQ/+mk6gqzYZ+MjPv4Uxe+bJO1L+/MIyii+OpJknaZvrkVzRDjGt6EKZdYA8T29FGyE
         p6qw==
X-Gm-Message-State: AOAM532YmQcetyveIMHnooLW2l5SQiXjMVhtn6vGarSt8alJueM4+RMw
        P3z6ZSFl7jq+k2V3TVXtKPl7Xm9Aii9V2g==
X-Google-Smtp-Source: ABdhPJwrM7cNBgG1rzu1KNmqhGM4iPiEnXcHBwNJaVKJIHYkUFGYRYwXnq5aCIFbFBRYq/J+6xuBaA==
X-Received: by 2002:adf:e848:: with SMTP id d8mr19371971wrn.391.1613403904710;
        Mon, 15 Feb 2021 07:45:04 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm23562757wrx.57.2021.02.15.07.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:45:04 -0800 (PST)
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
Subject: [PATCH v2 22/27] userdiff tests: test hunk headers on accumulated files
Date:   Mon, 15 Feb 2021 16:44:22 +0100
Message-Id: <20210215154427.32693-23-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215005236.11313-1-avarab@gmail.com>
References: <20210215005236.11313-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The existing tests in "t/t4018/" are unrealistic in that they're all
setting up small few-line isolated test cases with one thing we could
match as a hunk header, right above the one change in the file.

Expand those tests by accumulating changes within the same file type
in the "test_diff_funcname" function. So e.g. for "bash" we'll end up
a "bash.acc" file with 15 s/ChangeMe/IWasChanged/ changes.

This stress tests whether the hunk header selection will "jump across"
to an earlier change because the match for that is greedier.

As it turns out we had one false positive in "t/t4018/cpp.sh" and
"t4018/matlab.sh" because of how the tests were structured, we must
always give the "ChangeMe" line at least one line of separation from
the header, since it was at the end of those tests we'd select the
"wrong" header. Let's adjust the spacing to compensate.

So in the end we found nothing of interest here, regardless, I think
it is useful to continue to test in this mode. It's likely to aid in
finding bugs in combinations of our positive and negative matching as
we add more built-in patterns.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018-diff-funcname.sh | 19 +++++++++++++++++++
 t/t4018/cpp.sh           |  1 +
 t/t4018/matlab.sh        |  3 +++
 3 files changed, 23 insertions(+)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 2efe4e5bdd..8b4500037f 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -65,12 +65,26 @@ test_diff_funcname () {
 		do_change_me "$what"
 	' &&
 
+	test_expect_success "setup: $desc (accumulated)" '
+		cat arg.test >>arg.tests &&
+		cp arg.tests "$what".acc &&
+		git add "$what".acc &&
+		do_change_me "$what".acc
+	' &&
+
 	test_expect_success "$desc" '
 		git diff -U1 "$what" >diff &&
 		last_diff_context_line diff >actual &&
 		test_cmp expected actual
 	' &&
 
+	test_expect_success "$desc (accumulated)" '
+		git diff -U1 "$what".acc >diff &&
+		last_diff_context_line diff >actual.lines &&
+		tail -n 1 actual.lines >actual &&
+		test_cmp expected actual
+	' &&
+
 	test_expect_success "teardown: $desc" '
 		# In case any custom config was set immediately before
 		# the test itself in the test file
@@ -93,6 +107,11 @@ do
 		echo "$what" >arg.what
 	' &&
 
+	test_expect_success "setup: hunk header for $what (accumulated)" '
+		>arg.tests &&
+		echo "$what.acc diff=$what" >>.gitattributes
+	' &&
+
 	. "$test"
 done
 
diff --git a/t/t4018/cpp.sh b/t/t4018/cpp.sh
index 185d40d5ef..e0ab749316 100755
--- a/t/t4018/cpp.sh
+++ b/t/t4018/cpp.sh
@@ -206,6 +206,7 @@ void wrong()
 struct RIGHT_iterator_tag {};
 
 int ChangeMe;
+
 EOF_TEST
 
 test_diff_funcname 'cpp: template function definition' \
diff --git a/t/t4018/matlab.sh b/t/t4018/matlab.sh
index f62289148e..fba410e6f5 100755
--- a/t/t4018/matlab.sh
+++ b/t/t4018/matlab.sh
@@ -31,6 +31,7 @@ EOF_HUNK
 %%% RIGHT section
 # this is octave script
 ChangeMe = 1;
+
 EOF_TEST
 
 test_diff_funcname 'matlab: octave section 2' \
@@ -40,6 +41,7 @@ EOF_HUNK
 ## RIGHT section
 # this is octave script
 ChangeMe = 1;
+
 EOF_TEST
 
 test_diff_funcname 'matlab: section' \
@@ -49,4 +51,5 @@ EOF_HUNK
 %% RIGHT section
 % this is understood by both matlab and octave
 ChangeMe = 1;
+
 EOF_TEST
-- 
2.30.0.284.gd98b1dd5eaa7

