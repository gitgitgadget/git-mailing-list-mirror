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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413C2C433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22F8460249
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244873AbhIMPiR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 11:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240371AbhIMPiE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 11:38:04 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F61C020E7B
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 07:51:40 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so166147wms.4
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 07:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bA1Yc88YPUYOuVpDAWHt4mfj96aq/dryPQCy1gAylLI=;
        b=FDoo9EFEB8y3eyFVxg89Cbi93WDxzwuKTnuSzSj3kOqZzF+lA5iyHR8CXhDqUJGib2
         zGxlUb9//5WsBc049wBpt/fQr6T+OHigPODHD9Lg+tiNTUR1/ywFI5sxWBSDV5pmtOVt
         iK026XdUZIucmINOMY2HZxcl9Ifd/1Zfp1ck8zM3BqorinHNaYXAK6LKrJ4eUK1M3gM6
         5hHYEpqAJk/nswAftFRbycLhnb6Aj7iCt7aR+SYinHkJHofy4ssYFF9vDT0lRXiWCVQZ
         2vrll+QG2N+cJc8jIpSNzCKeKQbCzKbvlld03vR7OZ71J6YjTG4KSBV+wS9veZ26S9YM
         wSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bA1Yc88YPUYOuVpDAWHt4mfj96aq/dryPQCy1gAylLI=;
        b=oyTf/8PJTNv2C8wWHj0NJTEiuN9ooY03aDML6aIKa6fYdhUi2hpuliuaATUlkZYV4N
         xCKISqQ+zoEiGtd1BnX/YZ809zOitcCl+fpRAyKV2nBuEcsMFVj5EJ3UHVsugDBzUeVi
         C/sC8FgKlx9VV+yZMl1HNPRkLQmMIY1aPpcY1VimCt0mkPhqF7aTFQVYvI4tSsBDrc1+
         M8V9FO6Vx36Ypf0LLWZ//g6oZLRW7w0fY0KcSM3SRBVnAjVofLj0etQ+v4sDBi1Mc2n6
         z8xgapvCACnvU/kzI6Aw16pGfMEhNCvpAkvUwhCIxYz6A+f7xsOrNJzv9PLdtapN3lbh
         Ss7Q==
X-Gm-Message-State: AOAM533/WFBykky/7bw8SJ0GbIigIt4bmcs8oAN+0zcWcaRfAKqvj5wB
        cQ3gVhDo6CkwrtGr/snq4IviCHtbPa9vyQ==
X-Google-Smtp-Source: ABdhPJzduuZ/jTiqe0XQxLOD8UOduVdBvES1b6CcGcmI5LSLUpgrdlmBDeP8IdZLYBwTHXFgvO9Nfw==
X-Received: by 2002:a1c:a713:: with SMTP id q19mr11635663wme.42.1631544699140;
        Mon, 13 Sep 2021 07:51:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o24sm3638854wmm.11.2021.09.13.07.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 07:51:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Daniel Stenberg <daniel@haxx.se>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 5/9] http: drop support for curl < 7.18.0 (again)
Date:   Mon, 13 Sep 2021 16:51:25 +0200
Message-Id: <patch-v4-5.9-73ad0d4cb28-20210913T144846Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1013.ge8323766266
In-Reply-To: <cover-v4-0.9-00000000000-20210913T144846Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20210913T144846Z-avarab@gmail.com>
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
2.33.0.1013.ge8323766266

