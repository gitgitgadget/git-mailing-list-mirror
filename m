Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0EAC2049B
	for <e@80x24.org>; Mon, 26 Dec 2016 10:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755693AbcLZKW6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Dec 2016 05:22:58 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33190 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755488AbcLZKWw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 05:22:52 -0500
Received: by mail-wm0-f66.google.com with SMTP id u144so52474162wmu.0
        for <git@vger.kernel.org>; Mon, 26 Dec 2016 02:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tPgh2+eFdXagV7yPCHp60nz6Y1jrLdsxiEiVxCQeWbs=;
        b=VEIIBIpBl6CNu3IRmHSuVev2KPjz7hN/Ou91P1xkyksJAsmLnxTQ6ylVKON9pFc0cl
         vwAdZsqBdwcVNg1ZVKj3uwgoSU5t6wgaHL4d8kpllG9IQjtJOQ0I/PTTJhHvvWBODDVO
         Cm9PWlFq7NO16XYugpzMdfMwQrnar2X3I5W4OBvGkxSfdZ7ZQLTuewkuqiWGWxkfeNVq
         5il1d8XDUMhsB+xdIsKZ7beDlsa1B93FqokAYagn0pEAYhVo8VFkx9HsOuNuKl4iFQXq
         65tvLUTw2FLCrz4amWOvotLsSd8CWsBEOpqicyqH5AlI9Damt8lPo9NPVKJDk3LiZol+
         B5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tPgh2+eFdXagV7yPCHp60nz6Y1jrLdsxiEiVxCQeWbs=;
        b=U1xtcV91dIudq8wM9EN3YYv6Com8DUhl4Fj46gnPqgx97WRKtT7qgMg7qw5gbw0XRy
         kUjBYAtRpse43rnldVE9kXuSBJP8di2D7ZxAJTM/oQQ08q+QLQ62qY/cCEPyEXyekTuo
         yfcgp1+CAA3pG+DmSZP1f3ITBEOMA7sbhMOiNPlId0WNGmhv7++q8pMKsyqmKiagNNay
         jYessOAXhlzQ9t34Y/KUSvQJ3KiLdEN6+wYghVqXkx6Qe2zoHTOVayf7l8WLf0Ri62QE
         YNOi1hRf8y9Nonfrfw/pEfn+99NQ1P9tFirhWYfa9YAEBQGh4dlCf6ByZJhC2IPB/+U4
         075w==
X-Gm-Message-State: AIkVDXLIfa/cwmUTMYDXeV/cyJgGdR8mOyItHIcXpvPcSz0u6snwWF2eRsbzhL49QRMNYw==
X-Received: by 10.28.128.211 with SMTP id b202mr24164617wmd.7.1482747770785;
        Mon, 26 Dec 2016 02:22:50 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id kp5sm54259010wjb.8.2016.12.26.02.22.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Dec 2016 02:22:49 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 15/21] config: add git_config_get_expiry() from gc.c
Date:   Mon, 26 Dec 2016 11:22:16 +0100
Message-Id: <20161226102222.17150-16-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.209.gda91e66374.dirty
In-Reply-To: <20161226102222.17150-1-chriscool@tuxfamily.org>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
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
index 069950d0b4..1e40d45aa2 100644
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
index f442f28189..279415afbd 100644
--- a/cache.h
+++ b/cache.h
@@ -1827,6 +1827,9 @@ extern int git_config_get_untracked_cache(void);
 extern int git_config_get_split_index(void);
 extern int git_config_get_max_percent_split_change(void);
 
+/* This dies if the configured or default date is in the future */
+extern int git_config_get_expiry(const char *key, const char **output);
+
 /*
  * This is a hack for test programs like test-dump-untracked-cache to
  * ensure that they do not modify the untracked cache when reading it.
diff --git a/config.c b/config.c
index cf212785bb..d6c8f8f3ba 100644
--- a/config.c
+++ b/config.c
@@ -1685,6 +1685,19 @@ int git_config_get_pathname(const char *key, const char **dest)
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
2.11.0.209.gda91e66374.dirty

