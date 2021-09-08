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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F1AC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 15:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D93EF610E8
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 15:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352106AbhIHPd0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 11:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhIHPdL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 11:33:11 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD80C061757
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 08:32:03 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n14-20020a05600c3b8e00b002f8bd2f8ab6so1936578wms.5
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 08:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SpQsoKx18BbT4CkvCLWDRjOovXm2qc+ZFQQbmLo9usw=;
        b=LscmegjHY/TXWCiCCi8YVvWk1bekbcB/YHVUNNv3nVpGCOQfA9ZuCjc80gDDhpXdXf
         QCkLwM6lrzM+DHxjIpPM5zGL1us1GpZca4RQJmj+JtybrU7LkAb5XAISIGM1vawNX5Uv
         RyjCmLPAcsBEeX17nkrUM4sNVPqRYNI8RuRUnPGW0mYuo4hzD0XjPoCPgDshS258JoZm
         WwceOUx3FAmldoiPB+qtg4mowJu9ysrm2nM94pqbqDqeWWUmba6ut1fuY25/5M8I/n/M
         apiwR58EdgzXQfxO+k1c99MeuCLikTTXVUbiTZ2uIWTQbe3XrCBe+1U6BJOnN3Jbdi6J
         KjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SpQsoKx18BbT4CkvCLWDRjOovXm2qc+ZFQQbmLo9usw=;
        b=YGgoFjw3B6V1V29RK4RkqxXtlPU0VkSfI0iqDLXKOurFCUWTCvbKCt8uk5jhCphn7R
         APcgJC6yfvMgMIsT43z3pjOqfEiAxykvuyy8Q/u5oW1IpdNXeJjFrP1IC8VTnaTJYgOn
         DptDc0Z1OJTk4hrIK5PdtR94pw6TTtJxEGevNG08NA/XLApi2YMzunevXar1X1EJaPWS
         CCakpMeIHYcYEzmViBD5EC+8FoT8VysrP5l5Z8YzzCIF3fQRDSIbFWojMpOn7XVCMA1p
         oWzX8CQZ2kCFIRSfduEAUjIm0nVur2NUPBdYL+/p+nj5hH5oJj6uvbPm3c04Bz52Dwh3
         TTTg==
X-Gm-Message-State: AOAM530UvR/m8vtGGEEsvRC8mU6k61u4LAPWEDjWVvgj1Wh+MA4n2iRn
        bO2UVrxShHJODcOleL4TOdclTkBTP9IDKw==
X-Google-Smtp-Source: ABdhPJzWdRD/tcm6+X9RiSzrtAekM+8bo30KO4NTrtTb0TBDIZVF6cOs1TWzoAHXALuZQqEeQd0WNA==
X-Received: by 2002:a05:600c:4f0b:: with SMTP id l11mr4156433wmq.126.1631115122048;
        Wed, 08 Sep 2021 08:32:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm2385580wrh.67.2021.09.08.08.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 08:32:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/5] http: drop support for curl < 7.18.0 (again)
Date:   Wed,  8 Sep 2021 17:31:52 +0200
Message-Id: <patch-1.5-3ffa2f491dd-20210908T152807Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.825.g2bf60429931
In-Reply-To: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
References: <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com> <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 644de29e220 (http: drop support for curl < 7.19.4, 2021-07-30) we
dropped support for curl < 7.19.4, so we can drop support for this
non-obvious dependency on curl < 7.18.0.

It's non-obvious because in curl's hex version notation 0x071800 is
version 7.24.0, *not* 7.18.0, so at a glance this patch looks
incorrect.

But it's correct, because the existing version check being removed
here is wrong. The check guards use of the following curl defines:

    CURLPROXY_SOCKS4                7.10
    CURLPROXY_SOCKS4A               7.18.0
    CURLPROXY_SOCKS5                7.10
    CURLPROXY_SOCKS5_HOSTNAME       7.18.0

I.e. the oldest version that has these is in fact 7.18.0, not
7.24.0. That we were checking 7.24.0 is just an mistake in
6d7afe07f29 (remote-http(s): support SOCKS proxies, 2015-10-26),
i.e. its author confusing base 10 and base 16.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 http.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/http.c b/http.c
index a0f169d2fe5..56856178bfe 100644
--- a/http.c
+++ b/http.c
@@ -927,7 +927,6 @@ static CURL *get_curl_handle(void)
 		 */
 		curl_easy_setopt(result, CURLOPT_PROXY, "");
 	} else if (curl_http_proxy) {
-#if LIBCURL_VERSION_NUM >= 0x071800
 		if (starts_with(curl_http_proxy, "socks5h"))
 			curl_easy_setopt(result,
 				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS5_HOSTNAME);
@@ -940,7 +939,6 @@ static CURL *get_curl_handle(void)
 		else if (starts_with(curl_http_proxy, "socks"))
 			curl_easy_setopt(result,
 				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4);
-#endif
 #if LIBCURL_VERSION_NUM >= 0x073400
 		else if (starts_with(curl_http_proxy, "https")) {
 			curl_easy_setopt(result, CURLOPT_PROXYTYPE, CURLPROXY_HTTPS);
-- 
2.33.0.825.g2bf60429931

