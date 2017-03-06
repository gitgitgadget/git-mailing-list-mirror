Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FE611FBEC
	for <e@80x24.org>; Mon,  6 Mar 2017 11:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753481AbdCFLn2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 06:43:28 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36587 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752969AbdCFLn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 06:43:27 -0500
Received: by mail-wm0-f67.google.com with SMTP id v190so13260321wme.3
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 03:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WI/BXRTHVsDPz2ckkq55QaeOC5xkR0lzh3n7vA/G/fA=;
        b=rsEI2bKLVVLAX17nHiGz6QqsI5aGSrl2wLk1xPjM9y5BYRs/ig1wWD3mOYuZDvrQMi
         orZKWoI86X/sOX2TVHPM7cZhrfQN9YtUWDK5bxwHbgw17xfueL2GCKtqUddMUgZxJdSz
         SvjDD22ux8PxninWe2vatwT/ctLrOpsQgItD2d/ZgSFP3aVOiKMiXUl/ovHKB74ExvKV
         lCWTDP3S/Znorol5qOlGk8hhzRqEz0c8KvpHrxeaAZ7NMhbM/6zvwAI30mXNksMofwHL
         0mPG8E8HxVjxiP5shO8SLl/EYBw73P4PhtgRG6Jq+EC9UTygalemkDprbNeXM6QRpAKc
         Zo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WI/BXRTHVsDPz2ckkq55QaeOC5xkR0lzh3n7vA/G/fA=;
        b=RQNpWSj5XLKba77oQ0u0o+FMQA+cDbXYO1tQAwX0rnw/S4xnfKs2bFsYFGpYYNirOB
         8PSO3Py8gHnp4h+43UmobhlpWvM/tJ5ExtaMB3xd5xiBETNcFTRKgfmWq2beQVhB8uYY
         ngDW/0m+W7mWMsevNJEIDI4qWakSwc07s/TR2OZvAOFCGjR9bKZfBo0F3Vg+fLYo/eU0
         2jm+ktTViPGIMAsog/3KFDrVNd0KeVSZTN9giNboFCcjrX1R3cnm7FczGYh7avu4k+6B
         p3iGgGjnNKbwbJoi3A86btXox3EmgfKlL+Wnb1fLGYgI8wbtae6VkGJE02W4NH+b5aK1
         pkKw==
X-Gm-Message-State: AMke39kcLstp+P0VT0szjvAfvrbnMIAJ2W7ZWMX4pCLx/znxGmG9nECoRKRK4I+3j/vfrQ==
X-Received: by 10.28.180.135 with SMTP id d129mr12248823wmf.135.1488793341353;
        Mon, 06 Mar 2017 01:42:21 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 191sm14144086wmo.21.2017.03.06.01.42.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 01:42:20 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 03/22] config: add git_config_get_split_index()
Date:   Mon,  6 Mar 2017 10:41:44 +0100
Message-Id: <20170306094203.28250-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.206.g74921e51d6.dirty
In-Reply-To: <20170306094203.28250-1-chriscool@tuxfamily.org>
References: <20170306094203.28250-1-chriscool@tuxfamily.org>
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
index 80b6372cf7..03de80daae 100644
--- a/cache.h
+++ b/cache.h
@@ -1926,6 +1926,7 @@ extern int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest);
 extern int git_config_get_maybe_bool(const char *key, int *dest);
 extern int git_config_get_pathname(const char *key, const char **dest);
 extern int git_config_get_untracked_cache(void);
+extern int git_config_get_split_index(void);
 
 /*
  * This is a hack for test programs like test-dump-untracked-cache to
diff --git a/config.c b/config.c
index 2ac1aa19b0..2a97696be7 100644
--- a/config.c
+++ b/config.c
@@ -1736,6 +1736,16 @@ int git_config_get_untracked_cache(void)
 	return -1; /* default value */
 }
 
+int git_config_get_split_index(void)
+{
+	int val;
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
2.12.0.206.g74921e51d6.dirty

