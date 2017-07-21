Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33AD2208E0
	for <e@80x24.org>; Fri, 21 Jul 2017 09:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753940AbdGUJ60 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 05:58:26 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35920 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753388AbdGUJ6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 05:58:25 -0400
Received: by mail-wm0-f65.google.com with SMTP id 184so3792166wmo.3
        for <git@vger.kernel.org>; Fri, 21 Jul 2017 02:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uwu9zU0QwJbQbL05J5ZdFCrAwtHMO1JKHac8BFt1tqU=;
        b=N88/DaRxI9Y8b97qWrtkqcrqjapn9tJ0u6aF4xTj9OPSU3sSd38PXgUh612C7HcKIa
         d1thKNhS3h98/W09zFVHyz7kyy5BSORL1JlUkt6tg4HkdI4BEaZ03uoKo+/PrPY9s+ub
         R5+toNMAqgKbHW52VU0owHoGk2pNx3zByfIEPoT9zkquApow/OxwkjmPbbcWSqTJqSuS
         ylpTEGTzetzU20FXxFdmwsQx6bpju26DpGJpWvubndjCvYswbFxwbgLVwevUuN4JVH++
         PFlvbRB/q4SSOdkbuTp3v5Qud2r1Df9P56pcmYFP27WdkKjIuc89jJCG4zLIYsP4pNKn
         5GGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uwu9zU0QwJbQbL05J5ZdFCrAwtHMO1JKHac8BFt1tqU=;
        b=Zd3fO0YtT9lzlh1rhoVHpueccX3m/ZI2v/R3xo7vltjeeH7Icr51NppiHMJDhRkB+G
         T1yeUZEuY6FA7aES9ikj3eEa73kkxKIbDMpugtyEZw1AZIYpKrL1jqBoXiSZlX2bW4Iu
         dl+uQW2sht1N5XKY7nuPKnAb76koJhDqqikZaSiUT7zXDsOqmHsbvCRR+ZxbrBCMIFHZ
         2sHZ4SciAjeqwVnJxmyzKbB68wvS28YaNpf5AlYS41wA2jebnpCd8ojemaE7UPklUyOU
         QzZhGZjfTpa2mzyVidA8rdKOiDeqZJ80VQqa1j8nkRLu2IhZYcisYMqQlAtVNaj1lWGo
         LaWw==
X-Gm-Message-State: AIVw1104Dv2EhtzhwD3JtDjybWPLAfloTty/ro7/ammBepdl4y55+D6d
        lqqD2TaIAhuUG8k7
X-Received: by 10.28.61.4 with SMTP id k4mr4110967wma.148.1500631104253;
        Fri, 21 Jul 2017 02:58:24 -0700 (PDT)
Received: from localhost.localdomain (72.198.126.78.rev.sfr.net. [78.126.198.72])
        by smtp.gmail.com with ESMTPSA id r191sm1133775wmg.6.2017.07.21.02.58.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Jul 2017 02:58:23 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lukas Fleischer <lfleischer@lfos.de>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] refs: use skip_prefix() in ref_is_hidden()
Date:   Fri, 21 Jul 2017 11:57:57 +0200
Message-Id: <20170721095757.28373-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.0.rc0.26.g981adb928e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This saves one line, makes the code a bit easier to understand
and perhaps a bit faster too.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 refs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index ba22f4acef..15cb36d426 100644
--- a/refs.c
+++ b/refs.c
@@ -1160,7 +1160,7 @@ int ref_is_hidden(const char *refname, const char *refname_full)
 		const char *match = hide_refs->items[i].string;
 		const char *subject;
 		int neg = 0;
-		int len;
+		const char *p;
 
 		if (*match == '!') {
 			neg = 1;
@@ -1175,10 +1175,9 @@ int ref_is_hidden(const char *refname, const char *refname_full)
 		}
 
 		/* refname can be NULL when namespaces are used. */
-		if (!subject || !starts_with(subject, match))
+		if (!subject || !skip_prefix(subject, match, &p))
 			continue;
-		len = strlen(match);
-		if (!subject[len] || subject[len] == '/')
+		if (!*p || *p == '/')
 			return !neg;
 	}
 	return 0;
-- 
2.14.0.rc0.26.g981adb928e.dirty

