Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD1CC433E3
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 17:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FE7F206D4
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 17:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnYNLE2w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733289AbgFWRrZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733273AbgFWRrW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 13:47:22 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6C1C061796
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 10:47:21 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id l10so21456584wrr.10
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 10:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ylXudJhJHctFwahixARVJ60X1aBkrBQE5e/sNafWwb4=;
        b=EnYNLE2wqgCA8QZeWUUf+HzR6bmMOQLTyfVeaKr0lryL8SaTLw2NVBo2gk+70HYNEt
         tTms/5zrBU6RyXANd8tjB9hey6ffApkJk0D63F0rdR04Sqq43xth7a7Owede61T5YWpK
         bNRR1K6lROHg+3jpD2z8UI0Zc4Mnv0JLPpklsrbbSM25UYAyZegTNLvqqHVUc98cP+bG
         Lb4gSTe7/gMpJjunlBZqMTjEvFN5Y+l0u30LCntVY3TzZopfd+P6K67sFOx5dRHsJpRE
         U4pa1gPPGMm80drB9RFqV8oS6/gq5RIOHN5a0VdPpQVn8joQkK6tfVdfr3knD1OY6JNR
         aFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ylXudJhJHctFwahixARVJ60X1aBkrBQE5e/sNafWwb4=;
        b=rRFF1PN2cy5bwGaYq+zWd+GGu62lJKtH5N5VfRh8tMZ5fx5V97vwK+5jfrcjYRHaHc
         dXFxIaBMJ0tRoL9Y6zomEtuuW0/6XoqgyvsnjfSOU52YFskYft//L9dXQcPngboPFf5f
         tV3zCMyP5IUvyEMJOGAfBzG1qj99TCOUbyVQjRkJuGXo8oueZjEHL3DFlC+22UXid0VQ
         ifWhXe4JiNsIwYFavc8N+JPMUQVp7yt94oCWMHsnsU6fwRsJPEMucaSUlztpus2JnJ4e
         ByrQPOAlcebobnJmYV2oxsZOjB6EtOdj2LG5eXXrmXb1DfV9x2QW8gmyi84OInR44stO
         5+eg==
X-Gm-Message-State: AOAM532wlQk5zu0qvFfP88vrUdVlu87F8egRJUvbcQl+fBWjrnNMdKNk
        rW/6oI08BmQ8XfyZlFAStnDrBDqY
X-Google-Smtp-Source: ABdhPJxgUQdOfGFw5jXUjAeInxG+Uulk1hhtJ+5sGE7VuEs5dP7rrG/QyRQRPmN2/Xf1JLQBZ2yBmg==
X-Received: by 2002:adf:e6c8:: with SMTP id y8mr27953434wrm.40.1592934439352;
        Tue, 23 Jun 2020 10:47:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z2sm5057318wmc.2.2020.06.23.10.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 10:47:18 -0700 (PDT)
Message-Id: <719c7091a7a48434ce7534c5b617f4238d96e22d.1592934430.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
        <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
From:   "Taylor Blau via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Jun 2020 17:47:08 +0000
Subject: [PATCH v2 09/11] revision: empty pathspecs should not use Bloom
 filters
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com, l.s.r@web.de,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Taylor Blau <me@ttaylorr.com>

The prepare_to_use_bloom_filter() method was not intended to be called
on an empty pathspec. However, 'git log -- .' and 'git log' are subtly
different: the latter reports all commits while the former will simplify
commits that do not change the root tree.

This means that the path used to construct the bloom_key might be empty,
and that value is not added to the Bloom filter during construction.
That means that the results are likely incorrect!

To resolve the issue, be careful about the length of the path and stop
filling Bloom filters. To be completely sure we do not use them, drop
the pointer to the bloom_filter_settings from the commit-graph. That
allows our test to look at the trace2 logs to verify no Bloom filter
statistics are reported.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 revision.c           | 4 ++++
 t/t4216-log-bloom.sh | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/revision.c b/revision.c
index ed59084f50..b53377cd52 100644
--- a/revision.c
+++ b/revision.c
@@ -704,6 +704,10 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 		path = pi->match;
 
 	len = strlen(path);
+	if (!len) {
+		revs->bloom_filter_settings = NULL;
+		return;
+	}
 
 	revs->bloom_key = xmalloc(sizeof(struct bloom_key));
 	fill_bloom_key(path, len, revs->bloom_key, revs->bloom_filter_settings);
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 426de10041..f890cc4737 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -112,6 +112,10 @@ test_expect_success 'git log -- multiple path specs does not use Bloom filters'
 	test_bloom_filters_not_used "-- file4 A/file1"
 '
 
+test_expect_success 'git log -- "." pathspec at root does not use Bloom filters' '
+	test_bloom_filters_not_used "-- ."
+'
+
 test_expect_success 'git log with wildcard that resolves to a single path uses Bloom filters' '
 	test_bloom_filters_used "-- *4" &&
 	test_bloom_filters_used "-- *renamed"
-- 
gitgitgadget

