Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9EBC433E0
	for <git@archiver.kernel.org>; Thu, 31 Dec 2020 03:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78ECB221FA
	for <git@archiver.kernel.org>; Thu, 31 Dec 2020 03:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgLaDzl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 22:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgLaDzl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 22:55:41 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022D7C061573
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 19:55:00 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id j13so4758218pjz.3
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 19:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BgV7R1sm4JQsIHPlKGKJooer4WgQZbM7zqtmlkeXllY=;
        b=sAbF5Wv1tyLATm6RPGY5b/yo7JEgza3xi+AZIgVEjmKWTYtAnkf5SoiZiSPpLvoBNj
         2476TN3IYcT0BS5ykEEQ9WZdsbRElx5liGH2bM97owhrhcuRqAHcyd8NoWHtqZUHIU76
         g+zl7gTu9JwQLn8M6hZrl4568rrilbNe5uj/aYwH5Zp6sIrjsL3BIUv54ev7UkUZDzfD
         20gixEVsJzFC+eudyqD3YxU0muE4T2UQ4tA0xfIY8+UiKGM4HGQNZGyJYn2PRd7r74cq
         QW6kJoKIDiQGeqnaPI0u2UwrRykEwosQsiwwhDk6BSu9fGBFQwmK0PZFEI1B811Hloz8
         uHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BgV7R1sm4JQsIHPlKGKJooer4WgQZbM7zqtmlkeXllY=;
        b=s5bPp9YEiL7XMGjyR/qIM2anKwxOiOhz40N7tVJs1Fw1SpsEtXkb8+/TkK+XwTjC/Y
         io1lgwJx0pplQbbkRUpC3KI/kGPA6YfRlQZqLpPsnum/Eg8+fa6ebohBpY1oJLuD+B4h
         LzuGBmpnKL8ae4goIA47TdM1obutYIcCis3LguqFby+KV28N/BqqdvC5UExKajQw5AlG
         lNyq7/biEtHYS7bKQeO3sjB+VXFFES1NyT3l2LdxLU5ndVeYxK/c0QNaUdV5RXp5C5Q4
         +2KoW/hmvg28EIiEQfInh+u68gIreeejEyqKAUDxHBk4EhqdPfuXSHIfcwDVeJdGxr7A
         WL3w==
X-Gm-Message-State: AOAM531DP6PnrX38aFb20CQnMAD/7H3Lg658tJJw9z19rByV/hVNR/0R
        782wYLaijA5laIXXIlAJJnjQjCdpcHtFLg==
X-Google-Smtp-Source: ABdhPJzFB+5T6DfJU/gW5vZwgCyXRjTEjew6BwTHW4ZIAaN7o+jxO6b/KQlg/KO9MqW5PIR7r+JisA==
X-Received: by 2002:a17:90a:f68c:: with SMTP id cl12mr11635123pjb.213.1609386900312;
        Wed, 30 Dec 2020 19:55:00 -0800 (PST)
Received: from athena.localdomain ([2402:800:63a8:983e:ea74:656b:d810:41f8])
        by smtp.gmail.com with ESMTPSA id t23sm44432968pfc.0.2020.12.30.19.54.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Dec 2020 19:54:59 -0800 (PST)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: test-tool: bloom: generate_filter for multiple string?
Date:   Thu, 31 Dec 2020 10:54:38 +0700
Message-Id: <20201231035438.22533-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hello,

I'm reading the code for Bloom Filter to see if arXiv:2012.00472
could be an improvement.

I'm not sure if I'm missing something or it's our test-bloom generate_filter
doesn't really support testing for multiple inputs.

If I understand correctly, we should either:
* allocate more entry for inputs; or
* abort if argc != 3

diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index 46e97b04eb..1026facc59 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -68,12 +68,14 @@ int cmd__bloom(int argc, const char **argv)
 	if (!strcmp(argv[1], "generate_filter")) {
 		struct bloom_filter filter;
 		int i = 2;
-		filter.len =  (settings.bits_per_entry + BITS_PER_WORD - 1) / BITS_PER_WORD;
-		filter.data = xcalloc(filter.len, sizeof(unsigned char));
 
 		if (argc - 1 < i)
 			usage(bloom_usage);
 
+		filter.len = (settings.bits_per_entry * (argc - 2) + BITS_PER_WORD - 1)
+			/ BITS_PER_WORD;
+		filter.data = xcalloc(filter.len, sizeof(unsigned char));
+
 		while (argv[i]) {
 			add_string_to_filter(argv[i], &filter);
 			i++;
diff --git a/t/t0095-bloom.sh b/t/t0095-bloom.sh
index 7e4ab1795f..6d83927c86 100755
--- a/t/t0095-bloom.sh
+++ b/t/t0095-bloom.sh
@@ -67,6 +67,17 @@ test_expect_success 'compute bloom key for test string 2' '
 	test_cmp expect actual
 '
 
+test_expect_success 'compute bloom key for multiple string' '
+	cat >expect <<-\EOF &&
+	Hashes:0xb270de9b|0x1bb6f26e|0x84fd0641|0xee431a14|0x57892de7|0xc0cf41ba|0x2a15558d|
+	Hashes:0x20ab385b|0xf5237fe2|0xc99bc769|0x9e140ef0|0x728c5677|0x47049dfe|0x1b7ce585|
+	Filter_Length:3
+	Filter_Data:45|ba|ac|
+	EOF
+	test-tool bloom generate_filter "Hello world!" file.txt >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'get bloom filters for commit with no changes' '
 	git init &&
 	git commit --allow-empty -m "c0" &&
-- 
Danh
