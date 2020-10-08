Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86779C43467
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 10:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 235D921734
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 10:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOXwMiwZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbgJHKN4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 06:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729341AbgJHKNx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 06:13:53 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A75C0613D2
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 03:13:53 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n18so5942271wrs.5
        for <git@vger.kernel.org>; Thu, 08 Oct 2020 03:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nw3krdT6vhbog0t2sxP9jCDiqirm4Sz3ePFWwZ4HrgM=;
        b=UOXwMiwZtYbgoliYIkmHJZWLeuohKDpg6eQJDyW5/DgbXQG0qzI9Rw7dhVzPqfbzDn
         wMYkeAaS8/LjeMSGZisHAOrt52Q2t27UkuJqW4UvHnIeVDmLg3aVaxneo97cB/qcz4YO
         aJh2rkjLyEtnyWf9etI+G9TI05b7drf7hvpSy0/8E/JM19BTdjaS2ZQaEIA7FsFfI3GF
         4l59ZB73EP7QOKjYK043+kjh8bFLHSd2ob80Xn3i+nTec8xf1e3lZqHcXf9OCs9Ynpfm
         4ajOCLR0NEpYYkDe9tbVPp509K6VLmrLcdcF1pNJQdqsmUJdzc3YwUCyKlfwRx8xaDgK
         pGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nw3krdT6vhbog0t2sxP9jCDiqirm4Sz3ePFWwZ4HrgM=;
        b=q/b1yTaKZ+wYCS2jehr6PDJIG91SxqylcTsspqvASXTtzWi4bKXRD9Iz2Y4opnUCF6
         TH49X3wiY75Z193MattKZkdXu3VsIciEzM+EfP5TrERTzLTmWhv/ca1wPj+FHu/tA3f4
         du+RcjbbfZppyQaJnuSoY1rM1BTR5OdXaX4mwwtA2ActHz0inZDRQVUGwGzPnitUY6Or
         QBWSSVXOAyYGc7UAsSywKgTcKFyhWPaEG75nRZBU2Zn5yC0UGhgwG3RSARd9UX6PcNeW
         owyVYovNTLbo1sb88p0+wfJiML2xHtuiw88MmQXLLvNcPjQATp10ya25PWOy8Docuz26
         PNww==
X-Gm-Message-State: AOAM533bd879E3wPdSWhWMBWzDt+2KmnjDBIZS31WD+8JvyPB8AVTM/D
        fSV7nxqMFD2djMVk2ILE5fzbZA8bfPY=
X-Google-Smtp-Source: ABdhPJzRXKvZ3wioTP30HWFydY16Xak+GfkUYbDyU3kN1A89s913d6pSKuWgTqylLtRIy4OugbV7ow==
X-Received: by 2002:a5d:5449:: with SMTP id w9mr8938547wrv.182.1602152029960;
        Thu, 08 Oct 2020 03:13:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z1sm6322948wmk.45.2020.10.08.03.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 03:13:49 -0700 (PDT)
Message-Id: <2c6f41f9adf361dd700fefaf0fa7819720929c04.1602152027.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.743.v2.git.1602152027.gitgitgadget@gmail.com>
References: <pull.743.git.1601888196.gitgitgadget@gmail.com>
        <pull.743.v2.git.1602152027.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 08 Oct 2020 10:13:46 +0000
Subject: [PATCH v2 1/2] t1415: avoid using `main` as ref name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In preparation for a patch series that will change the fall-back for
`init.defaultBranch` to `main`, let's not use `main` as ref name in this
test script.

Otherwise, the `git for-each-ref ... | grep main` which wants to catch
those refs would also unexpectedly catch `refs/heads/main`.

Since the refs in question are worktree-local ones (i.e. each worktree
has their own, just like `HEAD`), and since the test case already uses a
secondary worktree called "second", let's use the name "first" for those
refs instead.

While at it, adjust the test titles that talk about a "repo" when they
meant a "worktree" instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1415-worktree-refs.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t1415-worktree-refs.sh b/t/t1415-worktree-refs.sh
index bb2c7572a3..7ab91241ab 100755
--- a/t/t1415-worktree-refs.sh
+++ b/t/t1415-worktree-refs.sh
@@ -76,24 +76,24 @@ test_expect_success 'reflog of worktrees/xx/HEAD' '
 	test_cmp expected actual.wt2
 '
 
-test_expect_success 'for-each-ref from main repo' '
+test_expect_success 'for-each-ref from main worktree' '
 	mkdir fer1 &&
 	git -C fer1 init repo &&
 	test_commit -C fer1/repo initial &&
 	git -C fer1/repo worktree add ../second &&
-	git -C fer1/repo update-ref refs/bisect/main HEAD &&
-	git -C fer1/repo update-ref refs/rewritten/main HEAD &&
-	git -C fer1/repo update-ref refs/worktree/main HEAD &&
-	git -C fer1/repo for-each-ref --format="%(refname)" | grep main >actual &&
+	git -C fer1/repo update-ref refs/bisect/first HEAD &&
+	git -C fer1/repo update-ref refs/rewritten/first HEAD &&
+	git -C fer1/repo update-ref refs/worktree/first HEAD &&
+	git -C fer1/repo for-each-ref --format="%(refname)" | grep first >actual &&
 	cat >expected <<-\EOF &&
-	refs/bisect/main
-	refs/rewritten/main
-	refs/worktree/main
+	refs/bisect/first
+	refs/rewritten/first
+	refs/worktree/first
 	EOF
 	test_cmp expected actual
 '
 
-test_expect_success 'for-each-ref from linked repo' '
+test_expect_success 'for-each-ref from linked worktree' '
 	mkdir fer2 &&
 	git -C fer2 init repo &&
 	test_commit -C fer2/repo initial &&
-- 
gitgitgadget

