Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832B7C433E0
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 12:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61F08207E8
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 12:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzqqO48g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbgFZMa4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbgFZMas (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 08:30:48 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5C8C08C5E0
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 05:30:47 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id t194so9206827wmt.4
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 05:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=atGy9u7eA44BnPzrmTRlUi90gvPaY2RDb3FLnfIyHd8=;
        b=WzqqO48g+4oUrKS+i8s9213YCZsizLJ8ZwjJNCG2zcTVE9JbjAIpKnZXnAIfXRaR7q
         k0Gm3sVmGyG45619Esk+nRrwFTgTN0eL16vV3h/H5Glk8XkiXYp+I262uzfVZukSzOt+
         HcirJOVC8STr5miBS87KsEnatUgCfnFv5la0F/RO6H60q/aMtaEtUNIt2SN0q75VgJNN
         JKWGZlMipAyYWpF5X05V4JFe3F6cOe5KnOqzRFl5gmowil0rbW/8HIoukWbwQQaVnZgb
         Azkeje47rFaquL4mYsZwKvwrt2UElMSH5V5FjUj4nvWZxocdmiXM4/g3bfYi526QR/O5
         1rWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=atGy9u7eA44BnPzrmTRlUi90gvPaY2RDb3FLnfIyHd8=;
        b=sTVdwWwHWjk5H8XSDc+AgTbR+Ylsq86VI8do2g7Fgh2UFkyJAGMc+Mzo1SrMpRN0gQ
         NX9V6PMkl5pGaxHg7HrYFIaNzdXNcrzc+L79MWDgmVMf8oVkZzee0AFyIWSm0SF+JUFz
         3aRUz9mwtr6rccD/rlCkEyStoIQ3NeluV/vk29mtHlbOZhLeoZ3z5A2scahsCYVBJBvk
         3VdIirYLR+yk8Xmk1psCaSA/ipNu4GNO5h8aXDG+xeKHQez3EWcTmoVuJG4asTmPMKqb
         oISC+5ejbWK8fHXa7g3nLzUgaUeKBy1jjscXLYPn8lATcYaMgnPFeDQB1OQA6NNltVD6
         mnag==
X-Gm-Message-State: AOAM530qoYEKGxZLtoWj0zhpwgq5TyFPdNHlf7D3nEaWPNwKX/x96nCH
        gmONGr5MBJcUSZw0HfBJbUnnzTso
X-Google-Smtp-Source: ABdhPJzd3ExD7CPixJKBoM7sslD0yyBZM7grnEezeqUGYiCPURZ7XaZy7L6B3qxGH8amsa5LpfvFzw==
X-Received: by 2002:a1c:8192:: with SMTP id c140mr3105870wmd.108.1593174646327;
        Fri, 26 Jun 2020 05:30:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 2sm16498493wmo.44.2020.06.26.05.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 05:30:45 -0700 (PDT)
Message-Id: <7d6163305aa6ba295d5bc5ee685b158ae2853d93.1593174637.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
References: <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
        <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
From:   "Taylor Blau via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Jun 2020 12:30:35 +0000
Subject: [PATCH v3 09/10] revision: empty pathspecs should not use Bloom
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
index 73ed51b595..e3e4badd4c 100755
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

