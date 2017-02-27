Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3525A1F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 18:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751542AbdB0SL0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 13:11:26 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36572 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751470AbdB0SLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 13:11:16 -0500
Received: by mail-wr0-f196.google.com with SMTP id l37so2471078wrc.3
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 10:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AE3IeLdkqGC+UKYB/uGQWKOQkjejfnJrQLqVBJk4bhY=;
        b=YTlifuKz6gWUixEAg2fsNo0Wc8BtOoa1hfLYh7m5K54IoEPadb0gjcvAzjaFEDPo+e
         JgkI7SBLp5WsXU3fglZk8P1cJdBkDVH0+yJrluMDV6gvosKtcLrdR+r8JenYLnsIHnVv
         uWUv2EqG0wEENb0Dh602LB8yJz2LiqCgV2zMmNrGVWusUyzMDkmoK4aAY0bbSBArllyJ
         7YjZvUqGfS0APli7w0/AYHRmLF8fRgPl7pmlMdJxUEjRp7AkDOHZywT1r73jbECHqkkM
         NMyfj2eO3kDE9beafh0Z3q79pwr03ufnIi+0FCYYf1hvim06vSLwKUqYvAlewU40p5XW
         +VIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AE3IeLdkqGC+UKYB/uGQWKOQkjejfnJrQLqVBJk4bhY=;
        b=gu392yG0GBlzQIQ2Vioge5bvE+e2N+xTfd0ZIKj3vImR/MqSm2vV39ll7jxH/qO0OH
         a40iOh8ZSazsvWI3MegaQXpBkJl1qAVkQuaemBMQfKtzk7tJaVdmJHM+Y9uhUjby+oWG
         x84C2EgmvVgIycHhMEfNxwEGZmC4PmEXV5/qiguhg22iEkGRdTt8EczWhdZQdrogwFl8
         9NJPpYw1sETAcKlPk0i4PYc7dCaGURGaoNF56GvzhX5eFyK6OyqT4pJOwrYQAuf9K8dj
         6NKmBSMRH/g6RF5FjPVlXNqA4Z4fV5NO0nOxLEXmvT/xT/JYvI2QyqZ2z6u6JHWqqI0l
         96QA==
X-Gm-Message-State: AMke39ks5025JbOHq91iSW48ckUcUKObz5QifUZm9RV1bWsVV3/b+OtYkzNlnYtkjwo/cA==
X-Received: by 10.223.166.137 with SMTP id t9mr15356544wrc.15.1488218458909;
        Mon, 27 Feb 2017 10:00:58 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id e73sm15226798wmi.32.2017.02.27.10.00.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 10:00:58 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 16/22] config: add git_config_get_expiry() from gc.c
Date:   Mon, 27 Feb 2017 19:00:13 +0100
Message-Id: <20170227180019.18666-17-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.22.g0672473d40
In-Reply-To: <20170227180019.18666-1-chriscool@tuxfamily.org>
References: <20170227180019.18666-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function will be used in a following commit to get the expiration
time of the shared index files from the config, and it is generic
enough to be put in "config.c".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/gc.c | 15 ++-------------
 cache.h      |  3 +++
 config.c     | 13 +++++++++++++
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 331f219260..66dff6a8af 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -62,17 +62,6 @@ static void report_pack_garbage(unsigned seen_bits, const char *path)
 		string_list_append(&pack_garbage, path);
 }
 
-static void git_config_date_string(const char *key, const char **output)
-{
-	if (git_config_get_string_const(key, output))
-		return;
-	if (strcmp(*output, "now")) {
-		unsigned long now = approxidate("now");
-		if (approxidate(*output) >= now)
-			git_die_config(key, _("Invalid %s: '%s'"), key, *output);
-	}
-}
-
 static void process_log_file(void)
 {
 	struct stat st;
@@ -111,8 +100,8 @@ static void gc_config(void)
 	git_config_get_int("gc.auto", &gc_auto_threshold);
 	git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
 	git_config_get_bool("gc.autodetach", &detach_auto);
-	git_config_date_string("gc.pruneexpire", &prune_expire);
-	git_config_date_string("gc.worktreepruneexpire", &prune_worktrees_expire);
+	git_config_get_expiry("gc.pruneexpire", &prune_expire);
+	git_config_get_expiry("gc.worktreepruneexpire", &prune_worktrees_expire);
 	git_config(git_default_config, NULL);
 }
 
diff --git a/cache.h b/cache.h
index 6b25b50aab..8994e7d373 100644
--- a/cache.h
+++ b/cache.h
@@ -1888,6 +1888,9 @@ extern int git_config_get_untracked_cache(void);
 extern int git_config_get_split_index(void);
 extern int git_config_get_max_percent_split_change(void);
 
+/* This dies if the configured or default date is in the future */
+extern int git_config_get_expiry(const char *key, const char **output);
+
 /*
  * This is a hack for test programs like test-dump-untracked-cache to
  * ensure that they do not modify the untracked cache when reading it.
diff --git a/config.c b/config.c
index 35b6f02960..f20d7d88f7 100644
--- a/config.c
+++ b/config.c
@@ -1712,6 +1712,19 @@ int git_config_get_pathname(const char *key, const char **dest)
 	return ret;
 }
 
+int git_config_get_expiry(const char *key, const char **output)
+{
+	int ret = git_config_get_string_const(key, output);
+	if (ret)
+		return ret;
+	if (strcmp(*output, "now")) {
+		unsigned long now = approxidate("now");
+		if (approxidate(*output) >= now)
+			git_die_config(key, _("Invalid %s: '%s'"), key, *output);
+	}
+	return ret;
+}
+
 int git_config_get_untracked_cache(void)
 {
 	int val = -1;
-- 
2.12.0.22.g0672473d40

