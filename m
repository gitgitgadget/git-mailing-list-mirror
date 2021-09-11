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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B26C433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 09:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECA8A611F0
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 09:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbhIKJfr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 05:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235620AbhIKJfo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 05:35:44 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7B6C061756
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 02:34:32 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id u19-20020a7bc053000000b002f8d045b2caso3001657wmc.1
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 02:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rMpkRluVbLg4VZlXMnrx1Umh956bpQoNk8lU0Lfz67E=;
        b=K644oDWQbfy/xD4mh+P3VPida9PeVEkUb92eM5jr5azHv6fUUkt4o4sfikB/00Palc
         f8KWH2mGzHQppc2DykZ8tZ26hVwjZUMUCNpJVOLzfWrRLSoiHxQDS69rfxeJUlnOIxmA
         kfcLDTc3lSnCPqN/JKY/GcSpnfgRY6kQ2J9FPBumw4QnESUU1IUjMzYKevdbizobBJhu
         wKwdVy0sMBNN/ej4BLlCKDNOApH1j8dwfrQPoIjWRSOUBOexY0BJSKysBFOFKHnFRW8x
         bkgllrtli/5UW+yylHhG01YoeOSGekjsu+fIkuIhN2s28aJQ1VGX9tLDFYwLY/3GfKkA
         NB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rMpkRluVbLg4VZlXMnrx1Umh956bpQoNk8lU0Lfz67E=;
        b=ovmbvTEHTGBOUYQto+IeVZk5T5Ef+J9JlZNB553NOrtrln7KA77/gjNuiRzc2PyScL
         7sCof4+J+/mM9w9284zTdkUzWXgivj804FOzYseTG4A0zsM68hS9skofhCo1OZQ4stLO
         O1y6PpkQ6V+F9qwGfyk6Bo9ElQZk/cjwfFrJb0iMIy43gRVCcpKGpb106fzNDJ1G0p2F
         Z0oAtE0Anelty1qZpyaVkCSAqwTEr2+BNVVtbNdaHNcuUoPvYaEvt+1XeZ6qM2kIC0kp
         IgdBT1oaYD9QzVwa1EubbktZI5LWxhW/pCUQlNi0wGYgO6iRKZaYLFVSRwAuMr1d3toD
         AbCA==
X-Gm-Message-State: AOAM530Ymmslr2zuOjKRJWoBXkbjlSWxaLWHw1GmrA11YTrM6BCGcd5k
        tNcmIoSAPMaOmt8RlvdpKnKxFKjbpWIx+Q==
X-Google-Smtp-Source: ABdhPJwV4l1FF/udJYdTdkaAzlcFSv6THYyzV7Op6Pj81TjJGDLaLIJtrpvXtYf5vzC2w7pn15Wrew==
X-Received: by 2002:a1c:4a:: with SMTP id 71mr1983145wma.87.1631352870415;
        Sat, 11 Sep 2021 02:34:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s10sm1161753wrg.42.2021.09.11.02.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 02:34:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Daniel Stenberg <daniel@haxx.se>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 6/9] http: correct version check for CURL_HTTP_VERSION_2
Date:   Sat, 11 Sep 2021 11:34:20 +0200
Message-Id: <patch-v3-6.9-67bc1992762-20210911T092751Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.984.gea2c3555113
In-Reply-To: <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In d73019feb44 (http: add support selecting http version, 2018-11-08)
a dependency was added on CURL_HTTP_VERSION_2, but this feature was
introduced in curl version 7.43.0, not 7.47.0, as the incorrect
version check led us to believe.

As looking through the history of that commit on the mailing list will
reveal[1], the reason for this is that an earlier version of it
depended on CURL_HTTP_VERSION_2TLS, which was introduced in libcurl
7.47.0.

But the version that made it in in d73019feb44 had dropped the
dependency on CURL_HTTP_VERSION_2TLS, but the corresponding version
check was not corrected.

The newest symbol we depend on is CURL_HTTP_VERSION_2. It was added in
7.33.0, but the CURL_HTTP_VERSION_2 alias we used was added in
7.47.0. So we could support an even older version here, but let's just
correct the checked version.

1. https://lore.kernel.org/git/pull.69.git.gitgitgadget@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 http.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index 56856178bfe..b82b5b7a532 100644
--- a/http.c
+++ b/http.c
@@ -732,7 +732,7 @@ static long get_curl_allowed_protocols(int from_user)
 	return allowed_protocols;
 }
 
-#if LIBCURL_VERSION_NUM >=0x072f00
+#if LIBCURL_VERSION_NUM >=0x072b00
 static int get_curl_http_version_opt(const char *version_string, long *opt)
 {
 	int i;
@@ -774,7 +774,7 @@ static CURL *get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2);
 	}
 
-#if LIBCURL_VERSION_NUM >= 0x072f00 // 7.47.0
+#if LIBCURL_VERSION_NUM >= 0x072b00
     if (curl_http_version) {
 		long opt;
 		if (!get_curl_http_version_opt(curl_http_version, &opt)) {
-- 
2.33.0.984.gea2c3555113

