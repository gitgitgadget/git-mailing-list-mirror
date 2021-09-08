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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB4EC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 15:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1140B610E9
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 15:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352093AbhIHPdg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 11:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350469AbhIHPdN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 11:33:13 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF9BC061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 08:32:05 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id i3so2058713wmq.3
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 08:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DyRocttpxy0z4l65WwiDwVEAYaVpNSCjQ3aziwmlWFM=;
        b=NnY1m62zJUE39d833fyhKopz4wQD+Bv9p1XZDjFSAqbNMnSrRCickWAFwHgzryGYu1
         JNSY2zsSbR0BEYryow2CRx5VIYC7QPcfLBPyKp8JKL2LK3lzmgGtmaUkxlMjFM0yjum9
         GJquMyQjp1AXQKv+EsLIT6uZlvV1i5XPWR1WamSUeBenaJ8tqpA7Vb75+u1OhatrO6BA
         c6imUAGFudzb2f3NmQ9WOuVEDu1ylHrbkLDRooN7eg20MMQnX34hqXTdaYIRjgNABvao
         SGyXLdpfmnGM8qH0LAOATy7cfIacujKcjHDRc8sCfGgDtj/lCkcD2cBUiiqLxAOhcDyH
         MHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DyRocttpxy0z4l65WwiDwVEAYaVpNSCjQ3aziwmlWFM=;
        b=QI4VQTgf/xq3fSTJgeYHNW0z7TQIj+cBZezHQV7Ukx3HAsf1TzC0Z5N9DRv1SjwhmW
         tQrTJzCXSfNiV7KOXdXkUGRWAwR4K7nBtMPqBFHHGCwOksioACA4hqI48/tlwrYT4exa
         ssORqMwjRqIxuQ5ND+mMQ4QVaatWWWn690HGRjzRWk1ISA+7CFR84HBtgTtJG3fxBVDL
         48QRg5g3UV9qLrZwJNWmWAPGrAHVjCe7BxredlZwPtV/l2Y/tHJiRXsBxlS6IxCWHAs4
         53OccanoWdLZAWrOSZ3WF01Umld6xNmjZldT97RLm83/rt0/Viic08Z8F2oHsLh+U7aw
         pDcA==
X-Gm-Message-State: AOAM531pQo8ewXvNwBzHqTfBmqMjA5rJ1MhyJV3/XwgXVPeUyOUmrBQX
        Re9p+/RkC1LVm/lFC80RtiVlYiTu3YIKNg==
X-Google-Smtp-Source: ABdhPJy0liTJUwUFCmvztcopFv6qDrV9IFvJc0g764htDnuSaqMTBwsvXT3tSbEwQTZOorCsE+d19Q==
X-Received: by 2002:a1c:c903:: with SMTP id f3mr4339716wmb.101.1631115123666;
        Wed, 08 Sep 2021 08:32:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm2385580wrh.67.2021.09.08.08.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 08:32:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/5] http: correct version check for CURL_HTTP_VERSION_2_0
Date:   Wed,  8 Sep 2021 17:31:54 +0200
Message-Id: <patch-3.5-d8192164937-20210908T152807Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.825.g2bf60429931
In-Reply-To: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
References: <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com> <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In d73019feb44 (http: add support selecting http version, 2018-11-08)
a dependency was added on CURL_HTTP_VERSION_2_0, but this feature was
introduced in curl version 7.43.0, not 7.47.0, as the incorrect
version check led us to believe.

As looking through the history of that commit on the mailing list will
reveal[1], the reason for this is that an earlier version of it
depended on CURL_HTTP_VERSION_2TLS, which was introduced in libcurl
7.47.0.

But the version that made it in in d73019feb44 had dropped the
dependency on CURL_HTTP_VERSION_2TLS, but the corresponding version
check was not corrected.

1. https://lore.kernel.org/git/pull.69.git.gitgitgadget@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 http.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index f7d5b6a0776..b19d0a697d8 100644
--- a/http.c
+++ b/http.c
@@ -730,7 +730,7 @@ static long get_curl_allowed_protocols(int from_user)
 	return allowed_protocols;
 }
 
-#if LIBCURL_VERSION_NUM >=0x072f00
+#if LIBCURL_VERSION_NUM >=0x072b00
 static int get_curl_http_version_opt(const char *version_string, long *opt)
 {
 	int i;
@@ -772,7 +772,7 @@ static CURL *get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2);
 	}
 
-#if LIBCURL_VERSION_NUM >= 0x072f00 // 7.47.0
+#if LIBCURL_VERSION_NUM >= 0x072b00
     if (curl_http_version) {
 		long opt;
 		if (!get_curl_http_version_opt(curl_http_version, &opt)) {
-- 
2.33.0.825.g2bf60429931

