Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91C4C33CA1
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C422075A
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdCvLPfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbgAGExc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 23:53:32 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37243 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbgAGExb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 23:53:31 -0500
Received: by mail-qk1-f194.google.com with SMTP id 21so41654790qky.4
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 20:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2zJrhx+fGQLR0+YAKZccgX4U7vobwc6JXBDzo8umP/E=;
        b=fdCvLPfM98QszPkvSYWI52AhBE60cBlgDFiBa85lGDUFRtzJwpAOvDxF/cZ8i9Q2ox
         fnItllHDxNCxWruO3vmVlyVDLL12jY/UZNmq8rfk7myBgdhaw2Y+rHpU/O7bOaPJlFjU
         PTu0lZTOuxwwwB5rtovGe2Pm29Pig48ELe8dlx1rwYR1fbJspVF944G39lgpzoot/qk6
         BN/2FQZKn3erXmKEl1mr+HBnPUHNiUynarJSoaRzg9OM+45pTnvUejoXAoKu6geWJavQ
         w8tj644yChfKhmznYdLV7rZCcvKE4adZ5Uz3It0JQEr7I1VbcjuQ0YySdHAkAie5rlko
         AlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2zJrhx+fGQLR0+YAKZccgX4U7vobwc6JXBDzo8umP/E=;
        b=sKuOnF5Jxw0EBJP5Em03W7JtJmpHeEIcXPx0mAnzFlHj3E/n10PQ//AdNdODJve878
         79Y8ZjPVt37X9nUERBXCFGdBBKOVW7+J45d1CIQkfeg3tVc+gBK6MMV+Pi8S46zl+ohx
         dmFR4//W2lFwG7zTrTzu9z4S+JXLDUntgpn1wOYK8GO3NsVwd+JwOtevZPra1E3DhtVg
         seXpddbjmb2BbAiVxSmZRND4LCOIu41X3FDnDLMQN94LzU7eQa5vF2jO93FIiuuuI5e5
         SLf6AlAFWj33qK/CDEpmU5ZgCGfX3w+hGGkwnCE9fXHz4b2j+oT5EqNbgBf52qeuPcar
         +24w==
X-Gm-Message-State: APjAAAWBFsWjbNe7+rbIGw2rmTM/WupxGopFf8kogge4mNffLb2RGsCi
        +L48RZndKyROxNG4nZ+o1axDoYmI
X-Google-Smtp-Source: APXvYqycZvbNGYmRbMdaUFyQxJ54QPsdHk9cotu+A966av7EXIDgn1cTj2XJXYQpsKYTRoV4Q1OtVQ==
X-Received: by 2002:a05:620a:136e:: with SMTP id d14mr78849335qkl.263.1578372810296;
        Mon, 06 Jan 2020 20:53:30 -0800 (PST)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id t2sm21663893qkc.31.2020.01.06.20.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 20:53:29 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/16] t2018: use test_expect_code for failing git commands
Date:   Mon,  6 Jan 2020 23:53:01 -0500
Message-Id: <587e53053f02ad0867dc903688c8887602950bd3.1578372682.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.rc1.180.g49a268d3eb
In-Reply-To: <cover.1578372682.git.liu.denton@gmail.com>
References: <cover.1577454401.git.liu.denton@gmail.com> <cover.1578372682.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we are expecting `git diff` to fail, we negate its status with
`!`. However, if git ever exits unexpectedly, say due to a segfault, we
would not be able to tell the difference between that and a controlled
failure. Use `test_expect_code 1 git diff` instead so that if an
unexpected failure occurs, we can catch it.

We have some instances of `test_must_fail test_dirty_{un,}mergable`.
However, `test_must_fail` should only be used on git commands. Convert
these instances to use the `test_dirty_{un,}mergeable_discards_changes`
helper functions so that we remove the double-negation.

While we're at it, remove redirections to /dev/null since output is
silenced when running without `-v` anyway.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t2018-checkout-branch.sh | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 61206a90fb..7ca55efc6b 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -34,7 +34,11 @@ do_checkout () {
 }
 
 test_dirty_unmergeable () {
-	! git diff --exit-code >/dev/null
+	test_expect_code 1 git diff --exit-code
+}
+
+test_dirty_unmergeable_discards_changes () {
+	git diff --exit-code
 }
 
 setup_dirty_unmergeable () {
@@ -42,7 +46,11 @@ setup_dirty_unmergeable () {
 }
 
 test_dirty_mergeable () {
-	! git diff --cached --exit-code >/dev/null
+	test_expect_code 1 git diff --cached --exit-code
+}
+
+test_dirty_mergeable_discards_changes () {
+	git diff --cached --exit-code
 }
 
 setup_dirty_mergeable () {
@@ -94,7 +102,7 @@ test_expect_success 'checkout -f -b to a new branch with unmergeable changes dis
 
 	# still dirty and on branch1
 	do_checkout branch2 $HEAD1 "-f -b" &&
-	test_must_fail test_dirty_unmergeable
+	test_dirty_unmergeable_discards_changes
 '
 
 test_expect_success 'checkout -b to a new branch preserves mergeable changes' '
@@ -112,7 +120,7 @@ test_expect_success 'checkout -f -b to a new branch with mergeable changes disca
 	test_when_finished git reset --hard HEAD &&
 	setup_dirty_mergeable &&
 	do_checkout branch2 $HEAD1 "-f -b" &&
-	test_must_fail test_dirty_mergeable
+	test_dirty_mergeable_discards_changes
 '
 
 test_expect_success 'checkout -b to an existing branch fails' '
@@ -163,7 +171,7 @@ test_expect_success 'checkout -B to an existing branch with unmergeable changes
 test_expect_success 'checkout -f -B to an existing branch with unmergeable changes discards changes' '
 	# still dirty and on branch1
 	do_checkout branch2 $HEAD1 "-f -B" &&
-	test_must_fail test_dirty_unmergeable
+	test_dirty_unmergeable_discards_changes
 '
 
 test_expect_success 'checkout -B to an existing branch preserves mergeable changes' '
@@ -180,7 +188,7 @@ test_expect_success 'checkout -f -B to an existing branch with mergeable changes
 
 	setup_dirty_mergeable &&
 	do_checkout branch2 $HEAD1 "-f -B" &&
-	test_must_fail test_dirty_mergeable
+	test_dirty_mergeable_discards_changes
 '
 
 test_expect_success 'checkout -b <describe>' '
-- 
2.25.0.rc1.180.g49a268d3eb

