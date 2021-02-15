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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCA8C433E0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AA7364E27
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhBOAzd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 19:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhBOAzG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 19:55:06 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12791C06121E
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:15 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id r5so1468414wmp.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uDhodU3MGdTRdZH6VvhHlwV/e6SufajHdqHyMaEq5Z4=;
        b=DqMrjw2OTE1gZY5ttqw35swY4v8f2LOpLwX0e5p3sh2zbjUYIgfesHjMjCWWIGKMu1
         aJtRsviBmPzWl4NWmaO0OPXJud0i5XCLPoSDRpTReiATXd0esAqsmuoiBIAmX/F4wyMi
         I56y9uG5xiXhtxtD+5QcGcfF4lrBPUn0a7BepME8xhweYoExkVvHi1uuElz75EgUn35H
         kLcgByHb0VaCUt0NCqJmQs17bC02r9CRMxgz1zcbC05yw0SOK66KciMGtslxuFR3JUQF
         F+vuh0cx1gS9fcsflFQPRKy+yLY4wbCpYbPr2yuBO8vE8hTyS/AufTk+7BgR6K1sEE2s
         cpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uDhodU3MGdTRdZH6VvhHlwV/e6SufajHdqHyMaEq5Z4=;
        b=VLiaL05awr9grvmKba+0izeolrs+U5PHssyBeZ4RJDcTG9vVr1m69qO0oMs1P0lmA0
         YNaZrTaLgwvrUsXIenxslJLJ2CsyHMV40RWkiIKX8vOCONSmy9A910rsi2q7mLNk940M
         cw0xG4TP1TA41G4o2bf06S+repLJc9s3k3eTUrS3Ts+EkVeDzbOThaggJwgKEhvcqDJx
         /gWzKgA77fs8KjYdc5Kv3X7yg9AlLAuyWk+ffaFN+CKIb/FWmYxhI9cuB5dnrEZjl4wZ
         IffkClkYz4gsAXNkYlbTzSnMPzi8+kD7nZPxrLu2s3yHX9/xz1yLI2eaLbBesh5xA9+0
         Vo+A==
X-Gm-Message-State: AOAM530KBhbrjeNsZwXelk2o1ymvZnfXDFOuEGPCe+3B9DMwbf9cmcLZ
        kBoJkvzAQZ6F+w5lMNtMjes8AZVNn+asMw==
X-Google-Smtp-Source: ABdhPJz92bkFbrNQcEJp0k5wAHCKXWuV0w51wiV63Q2D3YTI3CgmGyTgxCzjtM28XHVF50KVGTfoUw==
X-Received: by 2002:a1c:67c3:: with SMTP id b186mr12235824wmc.24.1613350393538;
        Sun, 14 Feb 2021 16:53:13 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 3sm5209832wmi.2.2021.02.14.16.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 16:53:13 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 18/20] userdiff tests: test hunk headers on accumulated files
Date:   Mon, 15 Feb 2021 01:52:34 +0100
Message-Id: <20210215005236.11313-19-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87tuqebj6m.fsf@evledraar.gmail.com>
References: <87tuqebj6m.fsf@evledraar.gmail.com>
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
index 7a830ec57f..0d75d93c69 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -71,10 +71,24 @@ test_diff_funcname () {
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
+	' &&
+
+	test_expect_success "$desc (accumulated)" '
+		git diff -U1 "$what".acc >diff &&
+		last_diff_context_line diff >actual.lines &&
+		tail -n 1 actual.lines >actual &&
+		test_cmp expected actual
 	'
 }
 
@@ -92,6 +106,11 @@ do
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

