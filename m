Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA7CC433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A76260249
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243941AbhIMPiN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 11:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245133AbhIMPiE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 11:38:04 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD4EC020E7C
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 07:51:42 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id i3so6883207wmq.3
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 07:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/iD6WqRQz8S7xYRDkESMQlS+tH4246i9fKxOHUyasTA=;
        b=f3Cvew+erqdLHLXuNDsl5u846icz2PEeIBkgYPPRy8rsEH0dFigdwalJwoRtSuKuks
         RE2vDUQbEy+7lv1yKygWyZrpo/8BgGi0+lx3IonqqS7rtY97RvfsKWEzZWWK3V9xo6/U
         Co2Z6BYT4bbzKHP8BK3VVkPiPwVjO20U8NsYExqv5sS5ls32fH+87ewDmkO3VYAgENAM
         +3H2wRXIs5vkI4VscARMoQHl8+cqdLQVyCiOIZKUF7NNBJwe1RIOFzFu065eqEVY2r20
         8TlSD/BXLNaObteAdQAnw+Dw71gKKHG+hzcGqIzq+GmruvgeR85HP5Yk4tZ8+E7pPUot
         /IPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/iD6WqRQz8S7xYRDkESMQlS+tH4246i9fKxOHUyasTA=;
        b=4NuKSARMcG2tvV7AMPvYBgDtT8IFL8pUdgaF4AAgSPbzacmp2dITJZLSDADz1bzYsa
         S4cb8/ypHSlwP3kwF+vUC2oQDslteCJwHeU86XCpkjcRvfXBUJVSmxNRAP2cDb10u/+p
         8VyzSO2/PffR1LqanG4Qsb6SLf2g+9OW6vthLkxbDtsk+ZVjRvlwCus4zsosyWp4OL9c
         l2JUWRWmeRNFlQGvWC5rI6gm021Pa9fB4xSLwe4FEwBhETD5xf0NwM65LY5xLmXb5Yt8
         dB9DDTsOqw4UoDzW8OSRi/P5KR3iv+xcxviuwI2A/Atr9T0d+1NmkZ0xVGiNgSRedWVB
         daaw==
X-Gm-Message-State: AOAM532sN+KU9gUtxCV1LqOjGR038jksMuEhH7uBhEE369kEVN240NRC
        Xzly6k8Rwv02H0OsW7uH0OaLhNGXcCe+Vw==
X-Google-Smtp-Source: ABdhPJyXR+gxa4RLP8QYyxgQZ7CmIGl3u1rqrgFudiROIw6hpfnJ6ko9tfwGwJmIbhG1wd3i5zrMyQ==
X-Received: by 2002:a05:600c:4ba2:: with SMTP id e34mr11917302wmp.50.1631544700287;
        Mon, 13 Sep 2021 07:51:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o24sm3638854wmm.11.2021.09.13.07.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 07:51:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Daniel Stenberg <daniel@haxx.se>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 6/9] http: correct version check for CURL_HTTP_VERSION_2
Date:   Mon, 13 Sep 2021 16:51:26 +0200
Message-Id: <patch-v4-6.9-f4d1de8a112-20210913T144846Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1013.ge8323766266
In-Reply-To: <cover-v4-0.9-00000000000-20210913T144846Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20210913T144846Z-avarab@gmail.com>
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
2.33.0.1013.ge8323766266

