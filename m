Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B594C43219
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 17:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242007AbhLFRHo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 12:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347656AbhLFQ7a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 11:59:30 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D869C061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 08:56:01 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d9so23814848wrw.4
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 08:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fAMmpkIiZ4ClEaSx+sZfIyoO2JF8Bispgn46oBK3fCY=;
        b=Q9Bmd2p1oT6W6kHrWnKJMW0u6yxtgTEVDM2t/dyhsit8R02OA+mcRQJrPtNREzZZlV
         H8TMWOlVVoRBAzMCCsyoy6Cgy+Eu9lUNpvLW1P/7RVuBBJaaZjyZh+qKJEF74GaYlXAL
         fEn/aXJUJLJ41FjEXL1IUMlj/Sy8ETrAzBgxyltbPcoVYVnLqK3TNWGjM/7e2t4CiehQ
         I0Rj+Zyx14Ms5g4jXdlDP+t7PjIyxxQGODsXlrTws2aKH+7LpapW4fG1QJTdyDOoyGVf
         d+pErMm6s239gKz9im6zJgDihIxxOAGyTzqYF/75y9ZVvVoFcPZ+nmisu9nAEoBUpgMu
         uefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fAMmpkIiZ4ClEaSx+sZfIyoO2JF8Bispgn46oBK3fCY=;
        b=vWJ+quXLqt5XNdf73h3bWQIfbKG2WG+sjNHP3FGZBwPvMxugwRX7grslKQ0Irdbr14
         VZc/X+2OfdmV+MOSti4GKXAYemeuuT4ML7+VZsqx2M7CPCS6uwT5WhW+ETYp11Y3RyKH
         k3a2TcyjoCXtZxzg50dqH9iJT/7YXCUon9s43+7is9b+cbRd5pvL572xuooXSTAkFqku
         LaOEmD3sn1eGR+3dN5iBrvLQqm4WM9tA8ktdaGfY8Ik1+KXl9+2UmXyOyyrmlMBPfc4s
         Ws4nmCbQMUixeWiTAJmz9cjReh2ycMw/5u4UJBvMW5SXjsyW+5xPsIF7uuyvyFtBHXpw
         mrmQ==
X-Gm-Message-State: AOAM530uM+bUnjMSK2O/ExHPwNWcScMA9eDsx2RAtaquh9SSzxnfTEKO
        Qdo3KD3cWEp8iFLwj3Q+xr3kE/rNFROX8A==
X-Google-Smtp-Source: ABdhPJwbJiDV9W51NP9pCdOWSCBFInajrsIMAyL051mf8LwFs6kZyC48wQWRwY74scqzs1N7OUsZxQ==
X-Received: by 2002:a5d:5303:: with SMTP id e3mr44302055wrv.73.1638809759823;
        Mon, 06 Dec 2021 08:55:59 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j40sm11775419wms.16.2021.12.06.08.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 08:55:58 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/4] config API: don't use vreportf(), make it static in usage.c
Date:   Mon,  6 Dec 2021 17:55:53 +0100
Message-Id: <patch-4.4-e0e6427cbd3-20211206T165221Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.898.g5a552c2e5f0
In-Reply-To: <cover-0.4-00000000000-20211206T165221Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20211206T165221Z-avarab@gmail.com>
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
index c6c6f7d6b51..bdb3977b9ec 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -474,7 +474,6 @@ static inline int git_has_dir_sep(const char *path)
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
index 3d09e8eea48..9943dd8742e 100644
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
2.34.1.898.g5a552c2e5f0

