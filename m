Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488E0C433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24CFD207F9
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1LX0g+S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbgGAN1r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731092AbgGAN1l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 09:27:41 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F7DC08C5DB
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 06:27:40 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o2so23253159wmh.2
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 06:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oI7WnFBtC3brw2z+oArUkqpJjEwqjcuZPTLeeJP+XwQ=;
        b=q1LX0g+S5tJkygDP7VrnskbSY+HSkzSu9zUNuW+B0rfR1T8X46Th1N5AHrcZmgBxpo
         3+PvmwnUbkPklVxpUcr2gVW+R3GNDNQ02q+YstW6OgV6b5HYdVTfM3DVtlzeXaBLg4oU
         I5RuVb9ZuNqXYrjpHShzF4rb9lhi7/2AG4eauBVL/RDrNDaDDvkJToRb4zxAZzl1lJFb
         H2zdCPsSaSAcdP0Z4IXxQytZFwicuWvojsyF5fLAjwC1DYs3vEShf27OUNlgYq3w5/OP
         41smwvptxIFG31dUkoTJLvkFq2BtMc//4poxn/UGmLrCaZL/iY+nM0RHaLC7qHYTAePX
         yhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oI7WnFBtC3brw2z+oArUkqpJjEwqjcuZPTLeeJP+XwQ=;
        b=pKpf2aeyTZvJvRlfZ/a0oH/LLHrOuWT3NA+SRWgv0eEf9K9v1NArjxz0mfCx8picsK
         tjJDJnRDutNdA61lvcZZ37BGbdZgijQmyfNq/+nJyIRv5fojAnhgzrjFqRjCna6aTgjn
         AlWwzKj15s9UFX3hT5cXPiS7b5GodPyNgGActLX92FwNZQa4rWlokSos/GPs+vHE5Q7c
         Mwfdmx7AJifDc8vLQazQzG7PU9Ei3RXW2GRcUjxMvCNYW2Z/wgylE/4swyPI/S0zgZet
         afZVmyOyOkRvSGOoNLw7zdlhOYZaGBkcwGuygkmOUbokYrAkun6LvKhWszhgOhvZfeVe
         TeMw==
X-Gm-Message-State: AOAM533IJo8JzVysUW5/8KH5qnY9s46DDi1MN4WgRL1HJ0zT+08rsoWT
        /jaGRhW8zmX46Z1a/b+bOrLU3LvY
X-Google-Smtp-Source: ABdhPJzTHVvdusEpokc+q0+QpDw3r5/xiNKUpeHx1+1x0txpHaN8785Ry0M5rlllfBv6n8bGl9W/Kw==
X-Received: by 2002:a1c:9d07:: with SMTP id g7mr26651295wme.160.1593610059212;
        Wed, 01 Jul 2020 06:27:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b18sm7596440wmb.18.2020.07.01.06.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 06:27:38 -0700 (PDT)
Message-Id: <a95de3cceb39ea499d18e20aa0e3de973765cb26.1593610050.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.v4.git.1593610050.gitgitgadget@gmail.com>
References: <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
        <pull.659.v4.git.1593610050.gitgitgadget@gmail.com>
From:   "Taylor Blau via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Jul 2020 13:27:29 +0000
Subject: [PATCH v4 09/10] revision: empty pathspecs should not use Bloom
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
index ddf09ab0aa..667ca36e1c 100644
--- a/revision.c
+++ b/revision.c
@@ -702,6 +702,10 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 		path = pi->match;
 
 	len = strlen(path);
+	if (!len) {
+		revs->bloom_filter_settings = NULL;
+		return;
+	}
 
 	revs->bloom_key = xmalloc(sizeof(struct bloom_key));
 	fill_bloom_key(path, len, revs->bloom_key, revs->bloom_filter_settings);
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 52ad998f9e..29338f36bf 100755
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

