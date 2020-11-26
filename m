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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB6CC56201
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12473216C4
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFcb4j8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731643AbgKZB3D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 20:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730060AbgKZB3D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 20:29:03 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E682C061A55
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 17:29:01 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id l1so329964wrb.9
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 17:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nrf1B/mjDuKVtAiooF3Zhliy60HVigqM1yyq2cZrlwo=;
        b=kFcb4j8xMf8gF8bBGKA9zSpBXC+q92Yxo/NLGhAQU1Vebn/z3mHh2ZWxij8gPKX+S+
         d5F5lz0Kym1v7h1/DkPW+sHYt7sxukcyva1vfsx5ecovp/CmIZZzsNOroEIryb4BEczj
         jr051l3gqGbq9MSEVcR/gnF9mJKL7XgWD6btmsR/MNvHcUfnoH/xz+JedriD1lWydG23
         L+qxKqZ8SOUvOBj5NB8iP0rocVBLihv5Qwj22TU5hEVH+K36LM3ynvgIuMmJ7pW5JE5R
         dslLICmy3IF2zsMTiohP1uBTsyoZIwk5Xig9wi9ceAr8qqePYNcDMN0sdpPqfBjbpcN8
         zKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nrf1B/mjDuKVtAiooF3Zhliy60HVigqM1yyq2cZrlwo=;
        b=shISa2+Ygro7cmiQIlBZxLpno568rztd18H8tReLFWamiWFji4PwmgOHL59DaNIDIq
         WS2mdbsGTmRlpQrs8PJck4gKnZavyNkdTcjfiEzvL3xv6dPk6YAwEnug5vx1kD2X9jw2
         PBf9pcyctkP3XDz0fKJnkRpVUOvKwiHHN6BSTubwMM+V0rjP2/i4waf3S8TOxZjrYG8x
         7DmS6/qRijD12cDA0YhQJdiNCuNw7eAfat63k0aAviQ9AShElQL2YK77hMHxyrpOv5tj
         C0QW+8hBHE3MuTwps3lvTv7pcMVAdbsIbUA6svGjV5V6chnC7dargk0YGkQIse7/YtHp
         D21g==
X-Gm-Message-State: AOAM5303+ngUubnin0CDCZ1TPMP682b7+b4qdEzPhxjRfL71pPVmG+Y7
        0myv+Qk0AN+Zf62qxJO6gltXLi7jKQ1tig==
X-Google-Smtp-Source: ABdhPJxV5ZyaaOO7bAFcPcXRErHJcOSwz8kzGw9A3yhrLuHRicP8HKSC8wSnWbHaM+vs9i5G98Gc/g==
X-Received: by 2002:a5d:474b:: with SMTP id o11mr715812wrs.235.1606354139974;
        Wed, 25 Nov 2020 17:28:59 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q12sm6402523wmc.45.2020.11.25.17.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 17:28:59 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH 01/12] mktag: use default strbuf_read() hint
Date:   Thu, 26 Nov 2020 02:28:43 +0100
Message-Id: <20201126012854.399-2-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net>
References: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net>
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

