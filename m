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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB14EC433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 08:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD8F264DFF
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 08:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhBKIQk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 03:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhBKIQd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 03:16:33 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF27C061756
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 00:15:53 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id u14so4586532wmq.4
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 00:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JHMHk+LDzMWyCqxgl66ibfHAEuooiwB7NzbFFSqr88Q=;
        b=Ju4SIVr6pRHuVJmDs5M7zXToEAZLrv+dQKsACO8rhz5aL5VSx2D8EScA73mmKu8B78
         S0dV6MbYL/541KgL5vg8kQ8xZczV6Wgr1r1/gSrMIISPnvEbStn0pHrOnNqEoop6KLUv
         PAecisprFRS7AiPdGsy+Au2D0OJTdEuga/mQiRKoWNGAsLQSp/vdxQ3m96GBmDkG1oL5
         yQfOeq3WaIKZcbJR8UNRT2q+MStnCFbAoAsLg3z6nMdRznYnAmAXK+TAcE2xQ1aOAuYX
         FypBmjYVzSGnURzb2RNT56CKY09UOERiYNFmf1x8+TTGfi1I3rPIBVNbBw2p5q2pZcTI
         aikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JHMHk+LDzMWyCqxgl66ibfHAEuooiwB7NzbFFSqr88Q=;
        b=muhSrXF9Tr2AFh2YOHeJa3ledyAjoDbpH1/UmH7AInBBtVx2SVxZmlQCSzDqiAgM+O
         upnb63lJaTZKBp6RdrjjPlGwHIyZol7JP0mnXTEpVrFvgglQIycY+yaK3n2x7YMzMCj9
         Arl2ecEdt2Rv0y4Tsq50/hrasqLvE59GkAas2I5c8vTrZg6sL1YTyny0YylkUB++wGsb
         bdeS7UNi3kGmSWqq83oIPIquL2i+9ZI3VfynEhxhRcLvyq487uiopxQn/TVpgRD3wq4M
         imY3T7dHzTH9mReiF0O5JKT3BdmwPjamivZj6oSjftwgMxLlorFzHqCAkqcWzFFaihL/
         2zhg==
X-Gm-Message-State: AOAM533bm6FwrAdKsSD/BuE6VyWBQT2YEhxjvjBrDOA2LQ4ot4cAv0Hw
        MccjQzSTmTklcBqEpXS0mPWs3nWBS68=
X-Google-Smtp-Source: ABdhPJwe7VTK9Co7gnp8wkVTjGQ2UBhhgwx+c2omRvRzzyshRoxbirEsm3yTNqBfioB7ydr2qvODxA==
X-Received: by 2002:a1c:ed1a:: with SMTP id l26mr3963407wmh.114.1613031351736;
        Thu, 11 Feb 2021 00:15:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w12sm7955650wmi.4.2021.02.11.00.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 00:15:51 -0800 (PST)
Message-Id: <3e6af929d135ef2dc239e2f47f92a7e2e91cbd17.1613031350.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.843.v4.git.1613031350.gitgitgadget@gmail.com>
References: <pull.843.v3.git.1612970140.gitgitgadget@gmail.com>
        <pull.843.v4.git.1613031350.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 Feb 2021 08:15:44 +0000
Subject: [PATCH v4 1/6] t4001: add a test comparing basename similarity and
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

