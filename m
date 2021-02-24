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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A26C433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2F5464EDD
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbhBXTxS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbhBXTwh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:52:37 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269A9C06178A
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:51:57 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r3so3028374wro.9
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rVQUS916SkOLnrvHQDUbKibSU9DW/B5XLZlxl5YQPlw=;
        b=oFMGMuaO9TiSxrFx3PFcKYtnv+SI4LKk+DHDDw/IrkMUp3s7/ZBfZDJAAGgBRDEn8R
         HB8S7wxJR8Dyeg2IxN0lXzGOKQrkv2PkXh11U+Cz1q1EwQQMSXaaIPzzPc0AJ7g6WPbv
         3wwj5C2Fx+aIdMPbbOjzsJuCPhqoucnlTnAd4or2SO/Y9gJ2Wfxd/m9r3TQTY8c0hYeJ
         q6rhjUITf1YMbAwwdFf314QLTUZRo6K30YzfqlOLjtIHYaRoPayQQg3xO2/1GztVWzfv
         adJNLKbFSZKTxqw1/lxjwTLzixoLoxVJKJXF6p5fZBFrtegItjyZ5QjEbsARt/RQfCIe
         No6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rVQUS916SkOLnrvHQDUbKibSU9DW/B5XLZlxl5YQPlw=;
        b=cL4XEBgH9KD8IfqdCiStmHbQePjO9dC4nYfjQhbWcQR3ObILjBqde8X7bL2AmooSPX
         9PcfjdRUKwUpfsnJTTIcfFX5j/7W9zj+/dfBZhmCvHAPbtlHx+UtXXVZzASjxz7QjPTR
         Utc2aIX9GYDy5QxPKBiSNfrBgesbAfNsUo/zQ+eTRf74MFKkvxLi0zRrtF03ollVK37t
         0PMBdc9EkjP3gDHHnfq06ZDYwdkWWwq+10WdTU/j/5QlnVMxfuDbV5szxS44Gr9VRP3W
         l8OlFS4ZXFgZpXjyz9w2DkG5a2qUFi+A+VtfrmgnbYCwXTP8ixqmvXfv0BauKlNjDX5q
         hyKg==
X-Gm-Message-State: AOAM532HjzKPSb3RwNmYTw/8SSjdNXcMpv8k4f41S7JBW6gAuIlqGvwM
        vs31vEGY1JgfPGXcOaCjPTEAVLY3Y8J6FQ==
X-Google-Smtp-Source: ABdhPJw2kkY9snYgVI0BdB4jRMZo7k1Buj4T8DroSwqixTV8maKxrrqgT+3w/j6AZ+1DQD2YQ4D9Zw==
X-Received: by 2002:a5d:458a:: with SMTP id p10mr24037776wrq.347.1614196315682;
        Wed, 24 Feb 2021 11:51:55 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:51:55 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 04/35] userdiff style: normalize pascal regex declaration
Date:   Wed, 24 Feb 2021 20:50:58 +0100
Message-Id: <20210224195129.4004-5-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Declare the pascal pattern consistently with how we declare the
others, not having "\n" on one line by itself, but as part of the
pattern, and when there are alterations have the "|" at the start, not
end of the line.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 userdiff.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index c7aaf7094f8..10a02d36209 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -175,9 +175,8 @@ PATTERNS("objc",
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
 	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"),
 PATTERNS("pascal",
-	 "^(((class[ \t]+)?(procedure|function)|constructor|destructor|interface|"
-		"implementation|initialization|finalization)[ \t]*.*)$"
-	 "\n"
+	 "^(((class[ \t]+)?(procedure|function)|constructor|destructor|interface"
+	 "|implementation|initialization|finalization)[ \t]*.*)$\n"
 	 "^(.*=[ \t]*(class|record).*)$",
 	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
-- 
2.30.0.284.gd98b1dd5eaa7

