Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C92C433EF
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 16:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238902AbiFTQpe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 12:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244472AbiFTQon (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 12:44:43 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBB913D2E
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 09:44:41 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id c13so11440374eds.10
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 09:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YC4PlL3HLVnpVOZ2IgnVf9X5f38+B/8Q/zUQljL4Lik=;
        b=b1LijEdveIRPjc0AbtTMTqCjbrPbCkcP5LrWEbbsU18jRTd5c4mA5Nr74dRQeO8ePh
         b/FrJGYGQ2sA6eZOE/mDYKCuU1GoYazzYSLlReCAqZah15NjwVNQnDzI373BxZFrTx6n
         u+e2mmtcU6PoSrrvUOHrDsDkcj5D446LIUfPcQGoTgv5HDsj0BXfnjJiUOf2zf3MC8b9
         NrvK9++rCQz8ZbvKOup8UDpLbB+et0vGLajaVYpcu/9cNFzmn1vLXeSXqvowdUTv8NSd
         omJj2ore2k/ZixNA4O0ST+vw4uzEdztzjdvCbjBABbogbDeG7pMnBbCZ2APqo117lnBj
         JICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YC4PlL3HLVnpVOZ2IgnVf9X5f38+B/8Q/zUQljL4Lik=;
        b=yAsV0qpbW0R2Bt0B0ZAWzynRX7EbSe5jJqzXesuy5JrIibc++Oedevzag36cIo+H/C
         LP2ZgsAVgLA4SeiiAbUsEpcAal6qb/wDnqDUWAkeyAvhY/4/xexzNBTvKTp2hutKY28m
         QGzAgUR8EYoD0yK0hbnnFJP5YSwk6N1T7GkTANftHtsmp9DM4hmXIliqpMnioeTpnpQX
         QJFZTjFI5P+tjiAvA1GQ82Xmg5XbHBQH8zKIJYYXmO0kbSxOmDEKxkflYc1kwIM/XiJC
         7npSb9rD5jMwS55kAZT3i/JlOTVJaV/EmZ+MQ+Cb7uQKrqzV7Zu9PFWGxSjxdHmoRGug
         tRnA==
X-Gm-Message-State: AJIora/NBgcj8Q4aQuX0NuAW+6ww01R6+I7WKOnqGY70S//C007RMEzU
        zGmAtjhcIphCrD1p/iXss36+yrksUQo9QQ==
X-Google-Smtp-Source: AGRyM1vECvPBtvOkABuJdDjKHyQVdkMilhh2GN9vIDfcn0dIvIkAn/rawU9FCJ10R4wlgHZB0G1G7Q==
X-Received: by 2002:a05:6402:3886:b0:435:643a:b7ae with SMTP id fd6-20020a056402388600b00435643ab7aemr20366559edb.4.1655743479292;
        Mon, 20 Jun 2022 09:44:39 -0700 (PDT)
Received: from ashopov-C02DP555MD6R.corp.uber.internal (77-160-247-90.fixed.kpn.net. [77.160.247.90])
        by smtp.gmail.com with ESMTPSA id nb36-20020a1709071ca400b0070beb9401d9sm6294115ejc.171.2022.06.20.09.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 09:44:38 -0700 (PDT)
From:   Alexander Shopov <ash@kambanaria.org>
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>
Subject: [PATCH] name-rev: prefix annotate-stdin with '--' in message
Date:   Mon, 20 Jun 2022 18:44:34 +0200
Message-Id: <20220620164434.49618-1-ash@kambanaria.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an option rather than command.  Make the message convey this
similar to the other messages in the file.

Signed-off-by: Alexander Shopov <ash@kambanaria.org>
---

Add missing '--' prefix to option name in help message
Based on discussion: https://github.com/git-l10n/git-po/pull/637

 builtin/name-rev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 02ea9d1633..580b1eb170 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -577,7 +577,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 				   N_("ignore refs matching <pattern>")),
 		OPT_GROUP(""),
 		OPT_BOOL(0, "all", &all, N_("list all commits reachable from all refs")),
-		OPT_BOOL(0, "stdin", &transform_stdin, N_("deprecated: use annotate-stdin instead")),
+		OPT_BOOL(0, "stdin", &transform_stdin, N_("deprecated: use --annotate-stdin instead")),
 		OPT_BOOL(0, "annotate-stdin", &annotate_stdin, N_("annotate text from stdin")),
 		OPT_BOOL(0, "undefined", &allow_undefined, N_("allow to print `undefined` names (default)")),
 		OPT_BOOL(0, "always",     &always,
--
2.36.1

