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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F22C432BE
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 09:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0371A61019
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 09:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238226AbhG3JfV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 05:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238383AbhG3JfL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 05:35:11 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348A6C0613CF
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 02:35:07 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b7so10478826wri.8
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 02:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QjLlhSd8jpa9eE9Fi6inh2kZu/6i1DtCn1uu8xh0xkU=;
        b=ovPgFo2KJ+8+Pw6zmQiRqTrqrfSWyQF5qEDGU/famXmms55pfnN9AFInbjriq++bLQ
         ImLYJvQblr+UbMYwYN1SbJVUIVty0Y8T7Vn4MU3sWAhcdB2kMc6Tbx24jycoZ4oKVvQV
         OmQSrzVL/nBvpzpr7KtBHuakYm/21SbG6MNK8HZnqRTEAaFbmeQHXJ6kNdlZw9bLusGA
         mmKrikRsxWag/qwCInx/BRxHGEYy5Z54IV3OZ4OJgT2WgMjSyFxcGss5dQaYnT2xabE9
         MiRvs81198c18dol7fxIuJNMHKE3DGDPpQ9Bsfs46YhaasJt66EKOE4FJ0Gg/sGptg8z
         tiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QjLlhSd8jpa9eE9Fi6inh2kZu/6i1DtCn1uu8xh0xkU=;
        b=seqWsFQycIPu2MtVKLpK7lJ3jOPz0OzeCSOTwtu80+xmchN2gGFSZ1074Xouf3HxVe
         HKxq1jYJngaYTLkJ55AOIZzO1eitlQp5ICOLONZdniq7y8fJAAvj1AZGsihItar6l9LE
         6d9uctBTy9yt/lVKwkSlrXzJbrElXhtVO5z6sW17BoS2L+Izpe9WJpxcNEqddfzUcqMc
         hhOwtqM1VZX15tt2GL+GpVUMjybxrDNF1a4yY6CL/35XuvPf6ELJqxHJQQccbybC1Eky
         yUny5hxwF9efn0QA315G+goUY7T4x2z+8WWohtkd/aAhV4ux4hdvOAPOdF83wI0OdtWY
         nedw==
X-Gm-Message-State: AOAM532yl8LsAfFFilijqNtAqLOzy5kt/WJEvHPgiyeioSvHMNOgyM17
        UEPGZKjCqVunTp5aQQ4aDBENOABGZgukjQ==
X-Google-Smtp-Source: ABdhPJzAQp5W8M2C7G5wQVfRph+702bFtoKQsC7bI8DP2jvyhgJN8T0KdW+UZ7H0YL5+H3w981aHhQ==
X-Received: by 2002:a5d:674c:: with SMTP id l12mr2053010wrw.112.1627637705624;
        Fri, 30 Jul 2021 02:35:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t17sm1089903wru.94.2021.07.30.02.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 02:35:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>,
        "Tom G . Christensen" <tgc@jupiterrise.com>,
        Mischa POSLAWSKY <git@shiar.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/7] http: drop support for curl < 7.18.0 (again)
Date:   Fri, 30 Jul 2021 11:31:57 +0200
Message-Id: <patch-v3-5.7-b857a9ef7b1-20210730T092843Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.1069.g516d52f3d85
In-Reply-To: <cover-v3-0.7-00000000000-20210730T092843Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210721T220402Z-avarab@gmail.com> <cover-v3-0.7-00000000000-20210730T092843Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a preceding commit we dropped support for curl < 7.19.4, so we can
drop support for this non-obvious dependency on curl < 7.18.0.

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
index e9446850a62..477bf591141 100644
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
2.32.0.1069.g516d52f3d85

