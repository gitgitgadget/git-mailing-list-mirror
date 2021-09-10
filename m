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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9314CC433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 762996113A
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbhIJLF7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 07:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbhIJLFx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 07:05:53 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B94C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 04:04:42 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id u15-20020a05600c19cf00b002f6445b8f55so1101118wmq.0
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 04:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TXs09l7j+Xu6i1ACeccIVAN33VqATgAcZxCoec5XmSc=;
        b=nDPpX8Mzxelyh43aykJmejND+y0HmohgXPcH4nOiCmHXcibd4E4Ja76IXxxGOx3dU+
         vSLO9UXqIgK9Rped4WIHAg3FhhM5mqUfaoi65o09HAZaHluEaJOcAs73V15TkGufq9UK
         U2X07cOzuKWnEJ4rqV5fnw1jG7Z1LYfZZ+lo3LBiCB9rFbTcrcmGjGtmHhkjMbcVhDjE
         TX35ZWE7a27IPtSE2Fk+y7s7nJJEEiLooDP6bXV4XqdW+P11fX96ztFeeT0a0VdoS/Sp
         1hLmUPGppRiIiduxs6a3KNwJKnve/skQ6cuZQ19I9SVhG8mOpWPz74gVql+pND5S6B9O
         ty1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TXs09l7j+Xu6i1ACeccIVAN33VqATgAcZxCoec5XmSc=;
        b=zcaJxqrioyRPHZpuj4yirrzXdtdE8oTZoewnGUEQgq0MeiM78JVNxY59R+00+wrN+/
         WZ0lhLl4vUnJgnTzP+HcSpS+L2a9AEPVSfa/SIWChTJmY+jSloc7vVehG8L9QP/exQf+
         3vhYKuEfucQCdwKAW9sMB22UbIqnUUmA/S/HJq9BJKLc6kQF6q5/05VhKGEcb8gfPlUs
         OLz5KzYaaNMuIVqQLDuLpyDeMjtZeI35uwpxRJIwzwkO434/3Xk+6P44IALXHJpMFjzw
         sokVGDIxOiWsqjAn8niO3H2rPpV+vUy+mnHpJVwnerCHScziPv/7u6/1rIYN8q+sooXP
         dJIA==
X-Gm-Message-State: AOAM531fT1PODj0yUv0HSVLgkirbYw50sj2ArN3qBzjw1gWpQZIHTnrE
        PB29CJ0D+Eq0T8YYlxlserNBKGH8KCyayw==
X-Google-Smtp-Source: ABdhPJwDQQ8aXpW9wyYzE7oj7tck1n4gBjya1/4NxLKIyiYLHl8NuVAh9buoAEHsbFvHlNrHdkbi9w==
X-Received: by 2002:a05:600c:1c13:: with SMTP id j19mr7886786wms.109.1631271880514;
        Fri, 10 Sep 2021 04:04:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q201sm1013631wme.2.2021.09.10.04.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 04:04:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/8] http: correct version check for CURL_HTTP_VERSION_2
Date:   Fri, 10 Sep 2021 13:04:30 +0200
Message-Id: <patch-v2-5.8-2567b888c3d-20210910T105523Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.873.g125ff7b9940
In-Reply-To: <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
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
2.33.0.873.g125ff7b9940

