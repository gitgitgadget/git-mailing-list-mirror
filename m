Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42E211FEB3
	for <e@80x24.org>; Fri, 13 Jan 2017 00:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750932AbdAMAAi (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 19:00:38 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36274 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbdAMAAh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 19:00:37 -0500
Received: by mail-pf0-f173.google.com with SMTP id 189so20707482pfu.3
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 16:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UNhyzIsY1orWmLG6AmvM4pw+qv1MMSHQuE7vKD9r9ss=;
        b=PL1d8ebYW1rGE0E5Ss1/LuqoJS5c3kQXIHaQuFNFGoXJRnJ/MIK3fLDg/q2ZtcjQwi
         DFNhPs+w6BxVtF5C38Wvr0N5tYppmUePF3ejF0HI15kmIHnCp/Dd+mZCX8cUegEVnF+j
         7aWJoTxcKoGHqfMfkvepW0QNCf3Ztaq+cP+FOuHEcss/2pXK5SBUuA+LFdHpdhlUPGVR
         r9aAVNqXC5q5IauRBZN6WdYuC6+wKWpaCU6e4jJ7jxTSXnTqBXhWP2njySfVCCGHg3go
         W/OppVOh2pnGYapcS2GPAM29gpV/zb2YVpBkS2GssCV9p+k4MtmmcqLvU2/elwkGRQN/
         XOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UNhyzIsY1orWmLG6AmvM4pw+qv1MMSHQuE7vKD9r9ss=;
        b=EcOTdlnIhxHwNXkF2ZFrEEjfHsIL7LM+PpM86mfunJBT2GuR484kknvv/bo2r8zfFo
         yrZ5C27yK9CLTgDa77XshK/z4tly4g5Wj5XKPT2UT8Qt0IRCGDicBXYVXkqMvbgmdGNj
         NE8xKTJVQhrkP8j8ww/9oIejteEm8XBBq6zGa77gqE4R/0MA4fonqW4NidHKke5hTZGh
         jz/e2zdyuMSeWYSoUC1z/FzE9QwWkP+oOdyg9IQAPy+SvF/vyIwDTeZiCX5JLvTbpeQe
         YsCP0JWMCzDtbo6ew1FEtwJAx1I2rIMkOPTnk5XpkXb/fkBZxLhQy/8+QaHL64rovx4p
         vM0g==
X-Gm-Message-State: AIkVDXK4iYqY5vej1DOpFm8XJcK+47BoXgFSPi9sSqXrk4EbYaXzcaEGIkOSpaAQFDOKiwE3
X-Received: by 10.84.191.129 with SMTP id a1mr5049418pld.62.1484265243811;
        Thu, 12 Jan 2017 15:54:03 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id e6sm24312192pgf.4.2017.01.12.15.54.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jan 2017 15:54:02 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, pclouds@gmail.com,
        sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 01/27] commit.c: use strchrnul() to scan for one line
Date:   Thu, 12 Jan 2017 15:53:28 -0800
Message-Id: <20170112235354.153403-2-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170112235354.153403-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 commit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index 2cf85158b..0c4ee3de4 100644
--- a/commit.c
+++ b/commit.c
@@ -415,8 +415,7 @@ int find_commit_subject(const char *commit_buffer, const char **subject)
 		p++;
 	if (*p) {
 		p = skip_blank_lines(p + 2);
-		for (eol = p; *eol && *eol != '\n'; eol++)
-			; /* do nothing */
+		eol = strchrnul(p, '\n');
 	} else
 		eol = p;
 
-- 
2.11.0.390.gc69c2f50cf-goog

