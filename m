Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76EDC433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFE6E61A7C
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347224AbhKOXUg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352934AbhKOXS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 18:18:29 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCFCC03E033
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:40 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id b12so33613269wrh.4
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qdrqTb0ETKj9YnFe1m2xENmlQC6kUaSA12nGV6D6R18=;
        b=VoFk2TRbBdhwIhHJJ1hBITh0I9JWgHpBSJk1j6UyoflSgVCq/Kn4TAU6TlBtrPKyOD
         atvI7Nsh9tSzYP8ap8tiAYi48d+1xA/K+LNLqSxgvBsssuUAxwdwusO03UQU9lo+tkz+
         MlMv0uVL8gYM3o7yi+9ubQ2ea7eiNSNnPEle57X+St+7K1qiRobE3vllkroEd4FLgGCV
         YalOmSxNSboz6NE8jZyveB/tmrrnIigxE1qaUXqb06dpyDNuy7UYSiDPI/SFcWpkAyjq
         7JnTXBSIX3T0KPYKVBj2Olx5SLLtyYzheI7ARyNy1JHGL+GdG01xRAxmKz26yW1Uktrh
         WrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qdrqTb0ETKj9YnFe1m2xENmlQC6kUaSA12nGV6D6R18=;
        b=lM1rO18zfy9jPO3EKCjPGN5IXbEarZb9xiR+CZ8RgSRyzSb6UIyOunHsrmuEGdd325
         WhrIRMw3i1gMxhcexG1lHsNTyjcana4ZmfpWWxkrK6iGEU3Mvl4Xj5XRDrcBty99E5S6
         GGbOH+zE26XQqlfyuDMrn4FEvH8kLAFgWOnFfywokNHWeGU8kjKmwPOrgX+Z9Vs07oz6
         3AGGE+9wsC9vGyoscbLRkTukcxbCA7qvpJf3irQiHKhr0PFtXYIGxN1P7zX97qdoOv+U
         x9j1/E7UaNkaW84kLRU2LId1xFCB9MRaxpMAbmV//YvyVO4bTAV2OjLEQKfdyMLQm7GK
         lhvg==
X-Gm-Message-State: AOAM532v4W+x/QJa64/lXcf34yZmXDozF8N0VAeDMrLr9sFhYOd5f11V
        c8sHGX+Odp60ebc0cLLinA3vNRi5qUYL0g==
X-Google-Smtp-Source: ABdhPJypgP2wBFljVcHyv7VctqUzxj0z/VfLuZGaGQ7mTjZv/tKq28sFdcuP6pce1Uln/Df/ZRzTRQ==
X-Received: by 2002:a05:6000:186e:: with SMTP id d14mr3090714wri.376.1637014718446;
        Mon, 15 Nov 2021 14:18:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n184sm526812wme.2.2021.11.15.14.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 14:18:37 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 06/21] config API: don't use vreportf(), make it static in usage.c
Date:   Mon, 15 Nov 2021 23:18:16 +0100
Message-Id: <RFC-patch-06.21-40fe7cf81a8-20211115T220831Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.809.g11e21d44b24
In-Reply-To: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
References: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preceding commits the rest of the vreportf() users outside of
usage.c have been migrated to die_message(), leaving only the
git_die_config() function added in 5a80e97c827 (config: add
`git_die_config()` to the config-set API, 2014-08-07).

Let's have its callers call error() themselves if they want to emit a
message, which is exactly what git_die_config() was doing for them
before emitting its own die() message.

This means that we can make the vreportf() in usage.c "static", and
only expose functions such as usage(), die(), warning() etc.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fast-import.c |  7 ++++---
 builtin/notes.c       |  6 ++++--
 config.c              | 22 +++++++++-------------
 config.h              | 10 ++++++----
 git-compat-util.h     |  1 -
 imap-send.c           |  3 ++-
 usage.c               |  2 +-
 7 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 2b2e28bad79..4e2432bb491 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -3456,9 +3456,10 @@ static void git_pack_config(void)
 	}
 	if (!git_config_get_int("pack.indexversion", &indexversion_value)) {
 		pack_idx_opts.version = indexversion_value;
-		if (pack_idx_opts.version > 2)
-			git_die_config("pack.indexversion",
-					"bad pack.indexversion=%"PRIu32, pack_idx_opts.version);
+		if (pack_idx_opts.version > 2) {
+			error("bad pack.indexversion=%"PRIu32, pack_idx_opts.version);
+			git_die_config("pack.indexversion");
+		}
 	}
 	if (!git_config_get_ulong("pack.packsizelimit", &packsizelimit_value))
 		max_packsize = packsizelimit_value;
diff --git a/builtin/notes.c b/builtin/notes.c
index 2812d1eac40..60c5dab4122 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -763,8 +763,10 @@ static int git_config_get_notes_strategy(const char *key,
 
 	if (git_config_get_string(key, &value))
 		return 1;
-	if (parse_notes_merge_strategy(value, strategy))
-		git_die_config(key, _("unknown notes merge strategy %s"), value);
+	if (parse_notes_merge_strategy(value, strategy)) {
+		error(_("unknown notes merge strategy %s"), value);
+		git_die_config(key);
+	}
 
 	free(value);
 	return 0;
diff --git a/config.c b/config.c
index c5873f3a706..30f7971e0cc 100644
--- a/config.c
+++ b/config.c
@@ -2323,7 +2323,7 @@ int repo_config_get_string(struct repository *repo,
 	git_config_check_init(repo);
 	ret = git_configset_get_string(repo->config, key, dest);
 	if (ret < 0)
-		git_die_config(key, NULL);
+		git_die_config(key);
 	return ret;
 }
 
@@ -2334,7 +2334,7 @@ int repo_config_get_string_tmp(struct repository *repo,
 	git_config_check_init(repo);
 	ret = git_configset_get_string_tmp(repo->config, key, dest);
 	if (ret < 0)
-		git_die_config(key, NULL);
+		git_die_config(key);
 	return ret;
 }
 
@@ -2380,7 +2380,7 @@ int repo_config_get_pathname(struct repository *repo,
 	git_config_check_init(repo);
 	ret = git_configset_get_pathname(repo->config, key, dest);
 	if (ret < 0)
-		git_die_config(key, NULL);
+		git_die_config(key);
 	return ret;
 }
 
@@ -2452,8 +2452,10 @@ int git_config_get_expiry(const char *key, const char **output)
 		return ret;
 	if (strcmp(*output, "now")) {
 		timestamp_t now = approxidate("now");
-		if (approxidate(*output) >= now)
-			git_die_config(key, _("Invalid %s: '%s'"), key, *output);
+		if (approxidate(*output) >= now) {
+			error(_("Invalid %s: '%s'"), key, *output);
+			git_die_config(key);
+		}
 	}
 	return ret;
 }
@@ -2550,18 +2552,12 @@ void git_die_config_linenr(const char *key, const char *filename, int linenr)
 		    key, filename, linenr);
 }
 
-NORETURN __attribute__((format(printf, 2, 3)))
-void git_die_config(const char *key, const char *err, ...)
+NORETURN
+void git_die_config(const char *key)
 {
 	const struct string_list *values;
 	struct key_value_info *kv_info;
 
-	if (err) {
-		va_list params;
-		va_start(params, err);
-		vreportf("error: ", err, params);
-		va_end(params);
-	}
 	values = git_config_get_value_multi(key);
 	kv_info = values->items[values->nr - 1].util;
 	git_die_config_linenr(key, kv_info->filename, kv_info->linenr);
diff --git a/config.h b/config.h
index f119de01309..fae585d2005 100644
--- a/config.h
+++ b/config.h
@@ -626,11 +626,13 @@ struct key_value_info {
 };
 
 /**
- * First prints the error message specified by the caller in `err` and then
- * dies printing the line number and the file name of the highest priority
- * value for the configuration variable `key`.
+ * Dies printing the line number and the file name of the highest
+ * priority value for the configuration variable `key`.
+ *
+ * Consider calling error() first with a more specific formatted
+ * message of your own.
  */
-NORETURN void git_die_config(const char *key, const char *err, ...) __attribute__((format(printf, 2, 3)));
+NORETURN void git_die_config(const char *key);
 
 /**
  * Helper function which formats the die error message according to the
diff --git a/git-compat-util.h b/git-compat-util.h
index d56f416af8a..2f44aa86a8b 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -466,7 +466,6 @@ static inline int git_has_dir_sep(const char *path)
 struct strbuf;
 
 /* General helper functions */
-void vreportf(const char *prefix, const char *err, va_list params);
 NORETURN void usage(const char *err);
 NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2)));
 NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
diff --git a/imap-send.c b/imap-send.c
index e6090a0346a..0fdfe5159eb 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1350,7 +1350,8 @@ static int git_imap_config(const char *var, const char *val, void *cb)
 		server.port = git_config_int(var, val);
 	else if (!strcmp("imap.host", var)) {
 		if (!val) {
-			git_die_config("imap.host", "Missing value for 'imap.host'");
+			error("Missing value for 'imap.host'");
+			git_die_config("imap.host");
 		} else {
 			if (starts_with(val, "imap:"))
 				val += 5;
diff --git a/usage.c b/usage.c
index a39d7aa330b..43231c8eac0 100644
--- a/usage.c
+++ b/usage.c
@@ -6,7 +6,7 @@
 #include "git-compat-util.h"
 #include "cache.h"
 
-void vreportf(const char *prefix, const char *err, va_list params)
+static void vreportf(const char *prefix, const char *err, va_list params)
 {
 	char msg[4096];
 	char *p, *pend = msg + sizeof(msg);
-- 
2.34.0.rc2.809.g11e21d44b24

