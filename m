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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BB8C63798
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 22:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3CA921527
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 22:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bn+yyq1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391791AbgKZWXO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 17:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387685AbgKZWXM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 17:23:12 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2015FC0613D4
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 14:23:12 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id u10so652691wmm.0
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 14:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nrf1B/mjDuKVtAiooF3Zhliy60HVigqM1yyq2cZrlwo=;
        b=bn+yyq1N98c8e0/mV9FEBHMpRlcHK980a8FInG3aUQSSAqapiaBdQlVsc5lbJTWNG8
         CrrB3noofIU4pFhUuznvl2zPrEHPSKj/s1/uDBgQihi+eCV9m7zG9oX8gBZAGtd/qu2m
         38cDjzpDeZYK79EOLfUgkkTMQfycglUS7c6YbSw7pCbjQDG0rrDEF4jzBHyat+wTSuFm
         nJofYZpuPPVUjBXEpgdXCaadfSuLrN34b2q0OHMwKyiTXTpVkKCf80yGyAGmVBznAKTs
         e7flEcH73GEXLdCujoesOQdxIbFXnqqP2jnFR2H2sZ64yEyu5G+9GA/QqF0/b/NM1yb/
         ENHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nrf1B/mjDuKVtAiooF3Zhliy60HVigqM1yyq2cZrlwo=;
        b=Sypbx7zx7bad7b0A5Dy+jWrf18N0FrxGNXHfLbhxO/nHJyO8zWmW/abTDRRm9jd+e/
         jRDKR6Gy0VK8yc8Q129oJBivUBUdw9TZ058NGIcswBahywzb87M5Hk5b476BDh1i5Zxm
         FH8cdYXuv9AGi+ekcMmr7wsXBORhtnjtml3x+aQVsMrWmtM4ZWJrFN7vta1vNazJu0il
         B1GByHCAdgApCiQf/9F+oHSkJQiRKtudNgV66u6ZUnnwgPJB5pzE1pFpwUInpjHwMQAl
         m/ORbbtGaxrA19j4SrwUUl40m4RER715yx1xCNl66zfcYlJWSMnl7sFp5CPzEX6XeAtW
         AieQ==
X-Gm-Message-State: AOAM531iecjgVDJfzUxZeOhQ/Oz3EGGqHUaGz3g6UlycsyspSHIVvVhL
        /AgLuOfi/vi0I+1MxbvTkXc+jhWSVdXzdQ==
X-Google-Smtp-Source: ABdhPJzpS+nLbk+PTV1KLW3lgC7VKgKMl/2Sygkd3KLfB336LnPn7zzskhtmTPOgCAEa9USUwkHzfA==
X-Received: by 2002:a05:600c:2306:: with SMTP id 6mr5559591wmo.140.1606429390493;
        Thu, 26 Nov 2020 14:23:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e3sm11283237wro.90.2020.11.26.14.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 14:23:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/10] mktag: use default strbuf_read() hint
Date:   Thu, 26 Nov 2020 23:22:49 +0100
Message-Id: <20201126222257.5629-3-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201126012854.399-1-avarab@gmail.com>
References: <20201126012854.399-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the hardcoded hint of 2^12 to 0. The default strbuf hint is
perfectly fine here, and the only reason we were hardcoding it is
because it survived migration from a pre-strbuf fixed-sized buffer.

See fd17f5b5f77 (Replace all read_fd use with strbuf_read, and get rid
of it., 2007-09-10) for that migration.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/mktag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/mktag.c b/builtin/mktag.c
index 4982d3a93e..ff7ac8e0e5 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -161,7 +161,7 @@ int cmd_mktag(int argc, const char **argv, const char *prefix)
 	if (argc != 1)
 		usage("git mktag");
 
-	if (strbuf_read(&buf, 0, 4096) < 0) {
+	if (strbuf_read(&buf, 0, 0) < 0) {
 		die_errno("could not read from stdin");
 	}
 
-- 
2.29.2.222.g5d2a92d10f8

