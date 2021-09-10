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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE3BC433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 662906113A
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbhIJLF4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 07:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbhIJLFw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 07:05:52 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80036C061756
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 04:04:41 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id g74so919157wmg.5
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 04:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7lr+vWLfvlOX6WWabmhoxW4Ecpsa83klZ7DpF/rCf6M=;
        b=AoY9bPlGSl8o6l607GKKYdBLXA8yhvFm9juIhvPdoBoBCOGBVuCCQ//Q5PBbloPdyi
         4qC5IC4CcVfi0q/2KAR7/iSqJlNoJ/30rG449e/zVAfSk61a/fbdiI9w9RB4msCA9WwV
         dLShiVRkvU/LxexC6UbOdwvh7HuVO+0j0yxI/mClE4DKHyp4KT4VsWo2w9ElH7+QG4bd
         OcetGPl/0JMYcehRIktowbAyga1UYwu+NBrNzbeX5rY5OhLxLE+PRBGtqNWKBRY0CcJ+
         weZfg9d+eB3FsPW79bmTkvykptQccmf2Cm8Bwu+moG2xxH0TfTvUkFbdh8R2IA8xzm+b
         7YpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7lr+vWLfvlOX6WWabmhoxW4Ecpsa83klZ7DpF/rCf6M=;
        b=L0cBCBlJZXkGeB+diPrbbc24qDBUazNPYcS+xc813fWswfhhZCvBjIHB9vep8ynB/f
         GQPJWweRfRMZ1gA+5FmFLTPmpnTQ0X+ct+RXTAbpU3f2bZRfoDK8zEVtLkk2uGW7x0Fb
         0+yvCH8dO4gKPXCqWEvD8uf7i3YauCjJBJ3hxQnMNsVbwpRmxcsaVA5YFcAuAWveLFs5
         T+QhbXeZJQJ+rB6HmRFQIvzyPO9dIU1s37GFvpGp7dGRdGh91bejEZHRQPG8YIWN93zV
         MCdF0MZdOaZLZqT14DaUsDkfcY9UDQwFrCwkEISToJCHW2Su5aVJVE/TgysjOEZC3Dn4
         oSZQ==
X-Gm-Message-State: AOAM532CI9uCzBRFnvoPlamok7Zo4Wj8lpMv3dUkIa1alBoM4fYbcH/A
        atlrYtdDeIDmq6KX0s7eWlKDHeZLM6PxjQ==
X-Google-Smtp-Source: ABdhPJwF2OzxOIitMUyOhE++fn7SWqPXXceVdvrd0XZkpjOloThXcOPWNl8/vqK1yj/Psfv3vwr8Bg==
X-Received: by 2002:a7b:cb8c:: with SMTP id m12mr7568966wmi.77.1631271879855;
        Fri, 10 Sep 2021 04:04:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q201sm1013631wme.2.2021.09.10.04.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 04:04:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/8] http: drop support for curl < 7.18.0 (again)
Date:   Fri, 10 Sep 2021 13:04:29 +0200
Message-Id: <patch-v2-4.8-e73a9ff1780-20210910T105523Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.873.g125ff7b9940
In-Reply-To: <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
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
2.33.0.873.g125ff7b9940

