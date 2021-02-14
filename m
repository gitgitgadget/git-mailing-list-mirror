Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E950C433E0
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 07:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E37B364E26
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 07:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhBNHxb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 02:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhBNHwi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 02:52:38 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5A5C0613D6
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:51:54 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id a16so2816552wmm.0
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=q2/RjMvPbQZ2i/4K0REqv5aDqCaRsAst7SRl6ErOZRo=;
        b=CjPJRXlAzTz/BiBxyzEbKtg0EY55P7DQCh/MQmLEEkoN0ExSjHmGpdpvPeq/ibIQXp
         ryXvIun19K/8ZJtp3Gcqo+pGFSMczS80jh3+xUrFTJgJFMyn6uigrdG93Xj/RqGjkQD3
         Zj1n++IK+hCQDtdKT4mPAJ4kusv6Z5I13z41+bZQYMv/R6W2y1Uc3EzbAAxPdo/2N9th
         5mEBu2lPh8+TmAXUmKXN0aKJAKIciD5cOTc5A54xRPIRioqz1ycEWhLFtk/hI0QVRrIU
         8M1MaRH0BTMrJg88EBWiXRcWrdw0hHr7E+QgbX3AaILPA5ihC0YamB9qJsYCCCZkgwGn
         xCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=q2/RjMvPbQZ2i/4K0REqv5aDqCaRsAst7SRl6ErOZRo=;
        b=FZL7+Wq79OusNo99aEvjPIh96R0CajpnG9022hemdgSuHaj1hoZF5P2n9axJlBJiAp
         IH065orfpHOH9ogHig2fMk7k9ZTFc/e3DKjTBDdrz+THK9t8CHQprnjJXiCODbRXaRnY
         +xkVYVjGQYOd+5I8yTAeQ2LwmW+7BXmlQiVWDJNr/3xAKZHtK20GTkTmuF2HOBsNNd9Q
         2CAoCWALPFyeQo+JJAWW5dcg9HTa2M7Q4SHB0Em964v1NzDDqiRf1jSm+Wt+TEN+F66l
         FFHxaR5IvuyxqA7Ix+IwnFqWi8E60KFEPDsCjnE2b2jp0Wh8t8EqR4gVMkDIcQHy8CIS
         MPcQ==
X-Gm-Message-State: AOAM5318FZDb6L5Z8FDsrYKJJwRlXe88EnTPcciwO4m9TJT1ynAt1qIh
        kvwOwiWDDWJHhFluCKwdEcXDwCwJ1wI=
X-Google-Smtp-Source: ABdhPJwDVK3sRWM736YhbWWj0If6oMVz0C+Lq+FxBhee/Gh2/5TNkmbExafpvO21/oiGUxfH5H5LFA==
X-Received: by 2002:a1c:cc14:: with SMTP id h20mr9277808wmb.180.1613289113673;
        Sat, 13 Feb 2021 23:51:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s23sm18869364wmc.35.2021.02.13.23.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 23:51:53 -0800 (PST)
Message-Id: <6848422e47e8b8477e6d24b6442345aa521ccdb5.1613289112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.843.v5.git.1613289112.gitgitgadget@gmail.com>
References: <pull.843.v4.git.1613031350.gitgitgadget@gmail.com>
        <pull.843.v5.git.1613289112.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Feb 2021 07:51:46 +0000
Subject: [PATCH v5 1/6] t4001: add a test comparing basename similarity and
 content similarity
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Add a simple test where a removed file is similar to two different added
files; one of them has the same basename, and the other has a slightly
higher content similarity.  In the current test, content similarity is
weighted higher than filename similarity.

Subsequent commits will add a new rule that weighs a mixture of filename
similarity and content similarity in a manner that will change the
outcome of this testcase.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t4001-diff-rename.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index c16486a9d41a..0f97858197e1 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -262,4 +262,27 @@ test_expect_success 'diff-tree -l0 defaults to a big rename limit, not zero' '
 	grep "myotherfile.*myfile" actual
 '
 
+test_expect_success 'basename similarity vs best similarity' '
+	mkdir subdir &&
+	test_write_lines line1 line2 line3 line4 line5 \
+			 line6 line7 line8 line9 line10 >subdir/file.txt &&
+	git add subdir/file.txt &&
+	git commit -m "base txt" &&
+
+	git rm subdir/file.txt &&
+	test_write_lines line1 line2 line3 line4 line5 \
+			  line6 line7 line8 >file.txt &&
+	test_write_lines line1 line2 line3 line4 line5 \
+			  line6 line7 line8 line9 >file.md &&
+	git add file.txt file.md &&
+	git commit -a -m "rename" &&
+	git diff-tree -r -M --name-status HEAD^ HEAD >actual &&
+	# subdir/file.txt is 88% similar to file.md and 78% similar to file.txt
+	cat >expected <<-\EOF &&
+	R088	subdir/file.txt	file.md
+	A	file.txt
+	EOF
+	test_cmp expected actual
+'
+
 test_done
-- 
gitgitgadget

