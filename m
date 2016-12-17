Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4308203EA
	for <e@80x24.org>; Sat, 17 Dec 2016 14:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757191AbcLQO4J (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 09:56:09 -0500
Received: from mail-wj0-f193.google.com ([209.85.210.193]:36651 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757078AbcLQO4G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 09:56:06 -0500
Received: by mail-wj0-f193.google.com with SMTP id j10so18022260wjb.3
        for <git@vger.kernel.org>; Sat, 17 Dec 2016 06:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TidrVmQUlUm8e9kkNKtPzB2IW8lnwMxByhGi7UyZ7g4=;
        b=WpskbQe/B3Fk3U7XBFyNbOpQrrzv44SP3m8jSK7qsoyreCJmOhAoAZAsZq+kkRvGrb
         aBQxgsi6z/rnGshBdY/otlZB2VgpufCUZdF1BBbely6jx1bLuaOR92q4htYIsaM22ohM
         hRfotxAYYOde1/DacwBCX4Il0YJV4dfqg4AFVlP5cl1wZuD7N2R8IrAwva0yUV71gtsY
         8mKb3ng59+ygMCzwLJmOX7/Sb9/n7qrff4IhenkGVMvUFGHPFEb0Fx8nE1NkFcWaOr4j
         y/uDvLBgdlppg8M3UD0qXF1DEuBF6PQPsTnrF2QmDFrk5YTiwwGRra39oWJn6MZg4+Vb
         VpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TidrVmQUlUm8e9kkNKtPzB2IW8lnwMxByhGi7UyZ7g4=;
        b=ER3r4MswA4kK7DUyc7VZc+ldCSzHe9/tijlJmr//vrG9k01pXTWGPf2SAy5s483XFt
         SAKK6nym8O9/e30ApL5onyf3AfW1+9BP2qIIjXiw5CNFztP1NGOizikS1bx4AaE5o5CI
         hbsP9DZmHzpytDo2v4Miy/Hufc+l1eHqUKfQuLbthLdVS8HgyQDxFbhJjYilx3qtWrYt
         kGNFrgnDIsBnu2CfOInXwCIyBaZmWldzAKPETZ00YxkjhfAeLhbTDMxcw2dizpS4A1dB
         imYomC6d+8sV6IqqYFokhaCApSKJQPWmnvpHx8pEPRpVUCSmPrSHKaOWPL7ZTJVPYs8S
         Gu8A==
X-Gm-Message-State: AKaTC00t2ivTjAGm15WHqltCT6ur0bD1csrCGLpU0E5cBdo31P67HETag9q1tK02MwvT0g==
X-Received: by 10.194.203.135 with SMTP id kq7mr8353234wjc.26.1481986565439;
        Sat, 17 Dec 2016 06:56:05 -0800 (PST)
Received: from localhost.localdomain (85.198.126.78.rev.sfr.net. [78.126.198.85])
        by smtp.gmail.com with ESMTPSA id y4sm11823449wjp.0.2016.12.17.06.56.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Dec 2016 06:56:04 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 02/21] config: add git_config_get_split_index()
Date:   Sat, 17 Dec 2016 15:55:28 +0100
Message-Id: <20161217145547.11748-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.49.g2414764.dirty
In-Reply-To: <20161217145547.11748-1-chriscool@tuxfamily.org>
References: <20161217145547.11748-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new function will be used in a following commit to know
if we want to use the split index feature or not.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h  |  1 +
 config.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/cache.h b/cache.h
index a50a61a197..c126fe475e 100644
--- a/cache.h
+++ b/cache.h
@@ -1821,6 +1821,7 @@ extern int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest);
 extern int git_config_get_maybe_bool(const char *key, int *dest);
 extern int git_config_get_pathname(const char *key, const char **dest);
 extern int git_config_get_untracked_cache(void);
+extern int git_config_get_split_index(void);
 
 /*
  * This is a hack for test programs like test-dump-untracked-cache to
diff --git a/config.c b/config.c
index 2eaf8ad77a..c1343bbb3e 100644
--- a/config.c
+++ b/config.c
@@ -1709,6 +1709,16 @@ int git_config_get_untracked_cache(void)
 	return -1; /* default value */
 }
 
+int git_config_get_split_index(void)
+{
+	int val = -1;
+
+	if (!git_config_get_maybe_bool("core.splitindex", &val))
+		return val;
+
+	return -1; /* default value */
+}
+
 NORETURN
 void git_die_config_linenr(const char *key, const char *filename, int linenr)
 {
-- 
2.11.0.49.g2414764.dirty

