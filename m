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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12083C43332
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 15:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA92C64DE0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 15:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhBOPs6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 10:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbhBOPpb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 10:45:31 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0219C0617A9
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:44:50 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v14so9442389wro.7
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WxRMbX36FcIz+AwKLhqroXJbRhiixlXJzzg4kxqCa34=;
        b=CfYgkVnksKYG7/9y8btNwkjLJN/U+nkoQAfODcoOPfh3lg/Q0tEEdkVB4cryuD6mzJ
         usOzqmKB3acUnT6u465oz1h7wYZzgnV3RheiiWsFIL0aILrJdhs3fnprdYiGguXeSR8P
         takoSwIh2raEhKIjW4Q7CuKFkqfKp00uFtjEA3B4JVkdYOLkzW8hjDi2iKzES3rliD2c
         tfIDZlG3JMv6PVWGltULmoYyT8/pxx2zAHdYVYePnjGfttoHoVWRqu3MqG4qMed8zQpV
         vBDUNkJaUD9Tpq91bXd5sQMulvNVftNHDKkmm10w58QxObzsV8JXxaXhLlR87pfkhacC
         o3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WxRMbX36FcIz+AwKLhqroXJbRhiixlXJzzg4kxqCa34=;
        b=p5+N7EdyBuxt7CSdGD76ECA7wxul375zSNNs4Ihon77pX4QX3SjyLmbEH0BhahZlIL
         ehCU6ewvMyPZFi7CS2jDxjgPu+L1Vy6IeY1V3cNCcoh0pCORNR9YlH3hEHuD/OYl5Ck0
         2Nwfi23AY1bNivRfiu/SZF/wGceT7Ty+BUjfw5nvvrKDqzfTMbstzdXfnsD5biA9ZjQk
         fi6sYHfmm9Rbs8pWbKEfJuynOYkt32WMJiKHR3P5/JmHJcGzyL6fT+kx+DkVoqCKCBfO
         g8nR6N3jL7QrBKeNw2kuNYd9wUwOUhmqC9S6ca6OSsSgzmiLrmw2qWFnrbaegfEsS7hI
         9OvA==
X-Gm-Message-State: AOAM531tifgmoK68nDmdlC9+PUyMTLSzecbiUZZoL7lp25ttDydbYpTL
        OJRU6BY89onjkZQKsjVnCwc/Jm+yDNJSoQ==
X-Google-Smtp-Source: ABdhPJxes8GzMeyRxM1qcxmznX1fKPtfq9Ls09Yoy8gHaDVsLwSsNFVTdpM2/noxOVyMuJQ1fo8Tog==
X-Received: by 2002:a5d:5104:: with SMTP id s4mr19065562wrt.277.1613403889127;
        Mon, 15 Feb 2021 07:44:49 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm23562757wrx.57.2021.02.15.07.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:44:48 -0800 (PST)
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
Subject: [PATCH v2 04/27] userdiff style: normalize pascal regex declaration
Date:   Mon, 15 Feb 2021 16:44:04 +0100
Message-Id: <20210215154427.32693-5-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215005236.11313-1-avarab@gmail.com>
References: <20210215005236.11313-1-avarab@gmail.com>
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
index c7aaf7094f..10a02d3620 100644
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

