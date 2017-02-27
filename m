Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 451851F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 18:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751531AbdB0SCE (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 13:02:04 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35454 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbdB0SCD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 13:02:03 -0500
Received: by mail-wr0-f193.google.com with SMTP id q39so11341500wrb.2
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 10:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=30rqp3JsPISmhtL1ZFQMHBZQzQVv/AER0PqsUbe//AE=;
        b=TKaz9ia9SUuuMYkk/GyfFv19/q7XcSlYxEnEydy8NUmwlvEOSmCFOkSRod+7ybo5no
         pSt9dgXDFeN7YIiovVw11dH7p9oBxyruySxT++/9TrbIDcst3b2o9RTeCMYfRJSJOknT
         dDi+GsOs/syK5En6lO/zeFD4ieGhF/mVjZ8CWsbkBdGefKpwKk0IYRBxfAgUJ7UAo0aq
         wQThscb/ekVl5U+uIQyrq8VH/qq9oR44biWcymOXYzqXHqHkP0XJfzsHc6zC9fZKmQyR
         Gn2NwBMOPdssr2tgdn6Xr54piv1VSJmYBH/DaeWo2RxANU0908s4/8bfCMWq5mWbXxuD
         MVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=30rqp3JsPISmhtL1ZFQMHBZQzQVv/AER0PqsUbe//AE=;
        b=lAjJpsQALSwuAC3TebaG0qfanF7/CRGvRaJCEqHjrn6vnp8qy9V5FhYQvtSxky3PvD
         9vI9iqc+X8oYDouP5H+FbmQhE4fsoTW/gRTRK5DPyprSo0pTEIyqpLY96o+jkWkpsr/W
         aaUjRblHgjxXAN1bcefW5StCGK2BASrwM8OkHfjJ2x99vwGE01jjGW1BSI0VWvdVi6Hy
         zkvUxDgp9ApJzAL3MczVBEMMOlWOr96VPzmNpipimK1B711uWoCqcqb3EvWO+i9V5TpU
         5YxM6f+iGDQ6BXOoFp18MXD2V8A3VqeU9YzwZMvWlhjhiQ076Cuu6GAjN4EZdNKg3oYB
         +WrQ==
X-Gm-Message-State: AMke39nZQfZ5bWmLy4tpT8ySe2gHpEu5RffnZ2FozzA1mViJStqJW56l8xglp9tdX1EciQ==
X-Received: by 10.223.144.65 with SMTP id h59mr17981303wrh.30.1488218440854;
        Mon, 27 Feb 2017 10:00:40 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id e73sm15226798wmi.32.2017.02.27.10.00.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 10:00:39 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 03/22] config: add git_config_get_split_index()
Date:   Mon, 27 Feb 2017 19:00:00 +0100
Message-Id: <20170227180019.18666-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.22.g0672473d40
In-Reply-To: <20170227180019.18666-1-chriscool@tuxfamily.org>
References: <20170227180019.18666-1-chriscool@tuxfamily.org>
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
index 61fc86e6d7..014aa7ea11 100644
--- a/cache.h
+++ b/cache.h
@@ -1882,6 +1882,7 @@ extern int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest);
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
2.12.0.22.g0672473d40

