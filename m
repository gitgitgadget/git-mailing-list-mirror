Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 690701FAAD
	for <e@80x24.org>; Sat, 28 Jan 2017 02:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750893AbdA1CCs (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 21:02:48 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34575 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751001AbdA1CCj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 21:02:39 -0500
Received: by mail-pg0-f42.google.com with SMTP id 14so85552289pgg.1
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 18:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D+vEmF75eT9Ais22yscP8QVp1k3bwesgcYspdacfbh4=;
        b=truMq1d1gIuQO8HeX/Ar+lZDmj6BpsKMf5GP7+u9nlWipGjhXBxpDc1mdv0VZQPVWK
         KFUuRN2fYLzIjE855J4AKmjzDjojcqFSdZaRC2aXkLUNLjR7JdZ/6meiGkacLpf5PmSI
         2e+FKzd8ANaRm1U9STltxpRo6s7SuaTBPRUrc23e4MGqEtfi/IZokXwHRtWmHl6fI/SJ
         WsBkqJGCzhdefeJ4Aa1GxdSL3FsCQRAW2TmNF1aFVHyj0CbLYCtSoGFwMTg61HrkygTU
         g8tk/smrD6dRF52PgRkgPLzES/BBh2pKBbpGgm5+CNQtNWHzHUhtZpfIQy4p3RaNqPxE
         +fhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D+vEmF75eT9Ais22yscP8QVp1k3bwesgcYspdacfbh4=;
        b=Fd7mqJB8dE50ZCRuJwIfBxuJukyFHAUjClMO8lPempRDQjV9RElrLCm/Bz6tkoBqTs
         H1HQRsV0uGNq5ilPvbcw8Fbp103+J/tKC54FVw3Iu+I+asf/KyQaT0SH8Hyf5Iwx25oj
         X87qAsiuhCBOgh/whKOejqtLR+jU1NDx6QQwB3aaVppLGAS/Rxsgx5cNvffn8x7PzcLL
         KvZEt7rVotMfVgzv8ljUw574MwYvQClyWpLZ2Mxu2prsbBx3ybtlqV5C8DvKRXd+ZQch
         wvRPC2EKGIcR8HxnbxlciUAcOMSSQec3JosZZGRe97cu+Bn3d50EUjilEYq13rAKgqHe
         f8dw==
X-Gm-Message-State: AIkVDXJ+nUvn7vI18eWyd4fAy2FQnRiJC89NBiHNaWqNj/4ry3FPN70LdcsiopmvV39/8SJK
X-Received: by 10.98.215.70 with SMTP id v6mr12171746pfl.141.1485568953704;
        Fri, 27 Jan 2017 18:02:33 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id w76sm14136185pfd.74.2017.01.27.18.02.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jan 2017 18:02:32 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 04/27] attr.c: explain the lack of attr-name syntax check in parse_attr()
Date:   Fri, 27 Jan 2017 18:01:44 -0800
Message-Id: <20170128020207.179015-5-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170128020207.179015-1-bmwill@google.com>
References: <20170123203525.185058-1-bmwill@google.com>
 <20170128020207.179015-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/attr.c b/attr.c
index 007f1a299..6b55a57ef 100644
--- a/attr.c
+++ b/attr.c
@@ -183,6 +183,12 @@ static const char *parse_attr(const char *src, int lineno, const char *cp,
 			return NULL;
 		}
 	} else {
+		/*
+		 * As this function is always called twice, once with
+		 * e == NULL in the first pass and then e != NULL in
+		 * the second pass, no need for invalid_attr_name()
+		 * check here.
+		 */
 		if (*cp == '-' || *cp == '!') {
 			e->setto = (*cp == '-') ? ATTR__FALSE : ATTR__UNSET;
 			cp++;
-- 
2.11.0.483.g087da7b7c-goog

