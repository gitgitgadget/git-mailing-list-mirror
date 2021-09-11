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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6794C433FE
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 09:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE1D7610F8
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 09:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbhIKJfq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 05:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbhIKJfn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 05:35:43 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D270C061756
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 02:34:31 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id i3so2865181wmq.3
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 02:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sbzeP7rqQ55dap+sdL66Tw1VxC9BIp0gVmb5VUIimZ8=;
        b=jgt7DfjJaK5yQh9Uu3JaEM3sgyGZWpZdPP1dSMa6MQSMBq6dzSj9Wl2CV5yuNZISfd
         jQb7I5Hp97mpA4CDo88T6rmjd2PRhzRCFtRDp52esI9g2TYk/HD1O6ny8ihU9DXE0c6F
         ik4SZ+Kk+6G24VrdrpR84REFWReJuo1GIkp1G5qOnomMdxcQYArXWPbxJfBJS/zh8L0v
         HOtMTWhND/av2UXOae391HOfQTztP1Le3mP4n0Z7a0OXuZx7KSBhuwoAmXzndYwqvdyy
         L6RM+BVGYcTsMjtVnpcgCQyXrL9+w6Fd5u+htFUpUN+ZRJA6FrnfXxY6IdRVQ0r4M2OR
         xsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sbzeP7rqQ55dap+sdL66Tw1VxC9BIp0gVmb5VUIimZ8=;
        b=rdQCDHlzyhYdvE3Vy4Gz67ZEfhkfU5Cs4EiyMqGnt1w1szk4deEWk8fOQ5B7JYfB4C
         u0Im+30xkbhVo8RzhDYlhH0PuM+45omi3aKKHgKnxll+4APWOm0FhJ6nmOp+Isz+fWT8
         unp/JMlxwXx5wnTAxckQUWNNvvBWdzE8dE+I6O5oeRet8WeqaNRKTLKwsx1JFSM4oDbR
         Q8vstnEbQGoFUhacK1dKX9lcF+Y6Qee7Z0AplOUQNE1N7gu28leiDC92vQq+laSTQne6
         XwJrkyCm+XFsO9LzBuXjEYTwbLkCjbl4fppcL3n8TMdsjJFmT0H+jjWb55rOqjBAGtPx
         v1+Q==
X-Gm-Message-State: AOAM530b0445mU3sQ/cn5xh47pukGBEHfstT1rhkFbv0TNPP1ntvzonI
        Q+txfGaWtpwomZfkv7ySQQ0apwsrqjSgqA==
X-Google-Smtp-Source: ABdhPJx8ThwATtW1ndUYdzJtyWnFVOFAdHh21jf+w7ULW+CwLvHoguOhHbKaDqagrnagX/nhdJiZ2A==
X-Received: by 2002:a7b:c114:: with SMTP id w20mr1918006wmi.80.1631352869446;
        Sat, 11 Sep 2021 02:34:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s10sm1161753wrg.42.2021.09.11.02.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 02:34:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Daniel Stenberg <daniel@haxx.se>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/9] http: drop support for curl < 7.18.0 (again)
Date:   Sat, 11 Sep 2021 11:34:19 +0200
Message-Id: <patch-v3-5.9-7919debfd89-20210911T092751Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.984.gea2c3555113
In-Reply-To: <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com>
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
2.33.0.984.gea2c3555113

