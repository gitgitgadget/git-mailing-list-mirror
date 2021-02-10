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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70156C433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 15:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4163964E85
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 15:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbhBJPQo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 10:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbhBJPQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 10:16:27 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7619C06174A
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 07:15:46 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id 7so3037616wrz.0
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 07:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JHMHk+LDzMWyCqxgl66ibfHAEuooiwB7NzbFFSqr88Q=;
        b=EbLBfjy5QdN6tWm9sxOOrnD8wibs0cMMCcswBXjHqUSFqJpGgpstvrZ6+Dw1LIEy52
         /Th+7N64b6c5YBlVh9w3mQ8uJXYUqG8iKGmaTC39bk+ItdEqmnP9gqX+igkeI4C/QkJD
         A8vgwtSgu4+MJHpxW53qZ3gz7GWxCyHnlGAzNBTGPfRGqZbmY2ZdXFUPGksOEsMphbf5
         k4jQOAmYEaHS4PtJvuay8VFTkAAXSQmsv83+K5DMLpAsAI6vWiHl+YtLz36c99fxjfVp
         yu1mVtFG59wJei0YlLvt8cFiuPSR4KNf/wDcPHBiTLh8kcpVS/JxU3TSHNurRb2MOmc0
         Biyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JHMHk+LDzMWyCqxgl66ibfHAEuooiwB7NzbFFSqr88Q=;
        b=jox5yx5h8xSLnADV+QYgbd5aXV7p7eoUZZacNEnVsmL0CEuFvL4NVwid6VSUD6ws2L
         kA09WMFNYm30uNo7GDVuVCkjWG0/rii1udoaXYgVEN5KbpcT61GRTODJUPyv4YyjsHjh
         nV58tEHqkWPu5/l0lbHdLiE6mi10UJ2sXjTgTWfCsg1RTkfptWf8bfu9JyND/Hvn2YqS
         gFRtgg/yPESnY34nQORkI3QQV/MMtDv8OCvnsMXvdEJRHlpG+pE3IjnVcTbKv2+zIWqo
         3R9ShJVSXxmWXYhtu28IknBFeTvVVv7pIYmg9mgArZSD7UK+t6xGS5DL9pBN1YCIxL2H
         vrCw==
X-Gm-Message-State: AOAM531QbCHcEjbrvExwXSjNNB3J4uudITIHSQOYW3rURYR+khvkSejO
        oVBFENpzLbrFyKyivHqXCcuBPYfKeVk=
X-Google-Smtp-Source: ABdhPJynWdB6B3LPXD35t1J7vvxtcX7T7zF80uHO/Za9iP/dj6R5DHm4WrRhSTOILlkqCOJrfLmdBw==
X-Received: by 2002:a5d:5049:: with SMTP id h9mr4302880wrt.404.1612970145504;
        Wed, 10 Feb 2021 07:15:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m131sm3099830wmf.41.2021.02.10.07.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 07:15:44 -0800 (PST)
Message-Id: <3e6af929d135ef2dc239e2f47f92a7e2e91cbd17.1612970140.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.843.v3.git.1612970140.gitgitgadget@gmail.com>
References: <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
        <pull.843.v3.git.1612970140.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Feb 2021 15:15:36 +0000
Subject: [PATCH v3 1/5] t4001: add a test comparing basename similarity and
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
higher content similarity.  Without break detection, filename similarity
of 100% trumps content similarity for pairing up related files.  For
any filename similarity less than 100%, the opposite is true -- content
similarity is all that matters.  Add a testcase that documents this.

Subsequent commits will add a new rule that includes an inbetween state,
where a mixture of filename similarity and content similarity are
weighed, and which will change the outcome of this testcase.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t4001-diff-rename.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index c16486a9d41a..797343b38106 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -262,4 +262,28 @@ test_expect_success 'diff-tree -l0 defaults to a big rename limit, not zero' '
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
+	# subdir/file.txt is 89% similar to file.md, 78% similar to file.txt,
+	# but since same basenames are checked first...
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

