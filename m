Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E01AC636CC
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 16:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjBGQLR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 11:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjBGQLF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 11:11:05 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3AD126E4
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 08:11:03 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id q19so16291087edd.2
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 08:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJG7xfNe+Qx+OJlShRCYBW6q3uv9cTkzo5hbiQF+Pcw=;
        b=L/616+qMzuvYJVgN6Zqo4F+qe4VKc3Vp/8MU3eV9DY3IYTrJ4KxyoQbMHOYmg+BLj7
         mL/bV4T0vfHeaOEb1lJeMDq6h2CeBNUcltXEJiP6OIA8nCWRDMhkukOM5M+SEmyzxbrx
         7VuizhGkPyMjMLJAJhKr/aJQILGJ5UZhuVWwU0iYnrOfPtLSZVjCUnx9neal3hsWdy3a
         cC9K0XL5HfI8AXG4jHGaJLuTuJYLiZnFqoSPhGt4RWpYZyFG6dVaqQx6DW26Na/encn+
         U+KvBNCqiq888fXmZQTG1layk2aXWGOi7OL0t4ESJVR1muW0RnZZu5LC4FaFjB0gfBoY
         1jsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJG7xfNe+Qx+OJlShRCYBW6q3uv9cTkzo5hbiQF+Pcw=;
        b=1qktmQobmcm6YW6ouljzRTmHtlUpqGC/mUFNfZ5Gi4tzq1Lj8w7FU5Ok9v83RmGLmy
         d79yD8XAAEJQR0FvYp4ETe9cocXaoPNibtXspXCFdst18k0XRjoEXf71NHoVbSD+F4pS
         oWERXUvV1/wwKAG/JCSGe9+pSHBc5iPDkg7ON9tqxeP21/yomAo+uQZjUqB7KTeTZQol
         p/W/EPaRzG+38vVaah2EfQrZR+OHF/5TH4PxD/SlufpyLqXwtQQm8Av2J27ztHzFtehq
         1PJ1Hnf5dLz/f54iJjVol4CYYJNBTsY30NpuysP/frqwdc5avgls73Me2CTyaA4pIVZH
         jksQ==
X-Gm-Message-State: AO0yUKXWghrtCfSiKG0bubcT9l14ft1MJaYeGRTKaYaQ7g242mDFFBlp
        Kv6Q6o1ggyswjNOPuJ8tSSpzRFE/+KGeySfb
X-Google-Smtp-Source: AK7set9s+PPcwdN4PkPz4LEFAQ+V3tOG7pHb8hpNDPbA8zv+5yaRCw2cQEK8m1f+KJRpahd2yKVkzQ==
X-Received: by 2002:a17:906:ca04:b0:880:e6d0:5794 with SMTP id jt4-20020a170906ca0400b00880e6d05794mr3541957ejb.58.1675786261614;
        Tue, 07 Feb 2023 08:11:01 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e4-20020a170906080400b008a60ed04e42sm2401167ejd.110.2023.02.07.08.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 08:11:00 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 06/10] config API: don't lose the git_*get*() return values
Date:   Tue,  7 Feb 2023 17:10:46 +0100
Message-Id: <patch-v5-06.10-b515ff13f9b-20230207T154000Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1430.gb2471c0aaf4
In-Reply-To: <cover-v5-00.10-00000000000-20230207T154000Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com> <cover-v5-00.10-00000000000-20230207T154000Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since a preceding commit which added the "git_config_get()" family of
functions, and the preceding commit where *_multi() started returning
an "int" we've finally been able to ferry up non-zero return values,
rather than having negative return values normalized to a "return 1"
along the way.

In practice this doesn't matter to existing callers. They're either
ignoring these return values and relying on us to only populate "dest"
if we'd return 0, or normalizing non-zero return values with "!".

Even if they weren't normalizing them we'll only return non-zero
negative values in those cases where the config key itself is bad,
which excludes the vast majority of our callers, as they hardcode a
valued configuration key as a fixed string in the C sources.

So this change is expected to do nothing for now, but is really here
for our own sanity. It's much harder to reason about an API that's
losing return values in some cases, and coercing them in others. If
there isn't a compelling reason to do otherwise we should let the
caller decide if they care about the distinction between bad keys and
non-existence.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 config.c | 117 ++++++++++++++++++++++++++++++-------------------------
 config.h |  16 ++++----
 2 files changed, 72 insertions(+), 61 deletions(-)

diff --git a/config.c b/config.c
index 569819b4a1b..8d7e40ac8a4 100644
--- a/config.c
+++ b/config.c
@@ -2463,86 +2463,93 @@ int git_configset_get(struct config_set *cs, const char *key)
 int git_configset_get_string(struct config_set *cs, const char *key, char **dest)
 {
 	const char *value;
-	if (!git_configset_get_value(cs, key, &value))
-		return git_config_string((const char **)dest, key, value);
-	else
-		return 1;
+	int ret;
+
+	if ((ret = git_configset_get_value(cs, key, &value)))
+		return ret;
+	return git_config_string((const char **)dest, key, value);
 }
 
 static int git_configset_get_string_tmp(struct config_set *cs, const char *key,
 					const char **dest)
 {
 	const char *value;
-	if (!git_configset_get_value(cs, key, &value)) {
-		if (!value)
-			return config_error_nonbool(key);
-		*dest = value;
-		return 0;
-	} else {
-		return 1;
-	}
+	int ret;
+
+	if ((ret = git_configset_get_value(cs, key, &value)))
+		return ret;
+	if (!value)
+		return config_error_nonbool(key);
+	*dest = value;
+	return 0;
 }
 
 int git_configset_get_int(struct config_set *cs, const char *key, int *dest)
 {
 	const char *value;
-	if (!git_configset_get_value(cs, key, &value)) {
-		*dest = git_config_int(key, value);
-		return 0;
-	} else
-		return 1;
+	int ret;
+
+	if ((ret = git_configset_get_value(cs, key, &value)))
+		return ret;
+	*dest = git_config_int(key, value);
+	return 0;
 }
 
 int git_configset_get_ulong(struct config_set *cs, const char *key, unsigned long *dest)
 {
 	const char *value;
-	if (!git_configset_get_value(cs, key, &value)) {
-		*dest = git_config_ulong(key, value);
-		return 0;
-	} else
-		return 1;
+	int ret;
+
+	if ((ret = git_configset_get_value(cs, key, &value)))
+		return ret;
+	*dest = git_config_ulong(key, value);
+	return 0;
 }
 
 int git_configset_get_bool(struct config_set *cs, const char *key, int *dest)
 {
 	const char *value;
-	if (!git_configset_get_value(cs, key, &value)) {
-		*dest = git_config_bool(key, value);
-		return 0;
-	} else
-		return 1;
+	int ret;
+
+	if ((ret = git_configset_get_value(cs, key, &value)))
+		return ret;
+	*dest = git_config_bool(key, value);
+	return 0;
 }
 
 int git_configset_get_bool_or_int(struct config_set *cs, const char *key,
 				int *is_bool, int *dest)
 {
 	const char *value;
-	if (!git_configset_get_value(cs, key, &value)) {
-		*dest = git_config_bool_or_int(key, value, is_bool);
-		return 0;
-	} else
-		return 1;
+	int ret;
+
+	if ((ret = git_configset_get_value(cs, key, &value)))
+		return ret;
+	*dest = git_config_bool_or_int(key, value, is_bool);
+	return 0;
 }
 
 int git_configset_get_maybe_bool(struct config_set *cs, const char *key, int *dest)
 {
 	const char *value;
-	if (!git_configset_get_value(cs, key, &value)) {
-		*dest = git_parse_maybe_bool(value);
-		if (*dest == -1)
-			return -1;
-		return 0;
-	} else
-		return 1;
+	int ret;
+
+	if ((ret = git_configset_get_value(cs, key, &value)))
+		return ret;
+	*dest = git_parse_maybe_bool(value);
+	if (*dest == -1)
+		return -1;
+	return 0;
 }
 
 int git_configset_get_pathname(struct config_set *cs, const char *key, const char **dest)
 {
 	const char *value;
-	if (!git_configset_get_value(cs, key, &value))
-		return git_config_pathname(dest, key, value);
-	else
-		return 1;
+	int ret;
+
+	if ((ret = git_configset_get_value(cs, key, &value)))
+		return ret;
+	return git_config_pathname(dest, key, value);
 }
 
 /* Functions use to read configuration from a repository */
@@ -2789,9 +2796,11 @@ int git_config_get_expiry_in_days(const char *key, timestamp_t *expiry, timestam
 	const char *expiry_string;
 	intmax_t days;
 	timestamp_t when;
+	int ret;
 
-	if (git_config_get_string_tmp(key, &expiry_string))
-		return 1; /* no such thing */
+	if ((ret = git_config_get_string_tmp(key, &expiry_string)))
+		/* no such thing, or git_config_parse_key() failure etc. */
+		return ret;
 
 	if (git_parse_signed(expiry_string, &days, maximum_signed_value_of_type(int))) {
 		const int scale = 86400;
@@ -2834,6 +2843,7 @@ int git_config_get_max_percent_split_change(void)
 int git_config_get_index_threads(int *dest)
 {
 	int is_bool, val;
+	int ret;
 
 	val = git_env_ulong("GIT_TEST_INDEX_THREADS", 0);
 	if (val) {
@@ -2841,15 +2851,14 @@ int git_config_get_index_threads(int *dest)
 		return 0;
 	}
 
-	if (!git_config_get_bool_or_int("index.threads", &is_bool, &val)) {
-		if (is_bool)
-			*dest = val ? 0 : 1;
-		else
-			*dest = val;
-		return 0;
-	}
-
-	return 1;
+	if ((ret = git_config_get_bool_or_int("index.threads", &is_bool,
+					      &val)))
+		return ret;
+	if (is_bool)
+		*dest = val ? 0 : 1;
+	else
+		*dest = val;
+	return 0;
 }
 
 NORETURN
diff --git a/config.h b/config.h
index 115259ecb8d..da5c498d39a 100644
--- a/config.h
+++ b/config.h
@@ -477,20 +477,22 @@ int git_configset_get_value_multi(struct config_set *cs, const char *key,
  */
 void git_configset_clear(struct config_set *cs);
 
-/*
+/**
  * These functions return 1 if not found, and 0 if found, leaving the found
- * value in the 'dest' pointer.
+ * value in the 'dest' pointer. On error a negative value is returned.
+ *
+ * The functions that return a single value (i.e. not
+ * *_get_*multi*()) will return the highest-priority value for the
+ * configuration variable `key`, i.e. in the case where we have
+ * multiple values the last value found.
  */
 
 RESULT_MUST_BE_USED
 int git_configset_get(struct config_set *cs, const char *key);
 
 /*
- * Finds the highest-priority value for the configuration variable `key`
- * and config set `cs`, stores the pointer to it in `value` and returns 0.
- * When the configuration variable `key` is not found, returns 1 without
- * touching `value`. The caller should not free or modify `value`, as it
- * is owned by the cache.
+ * The caller should not free or modify `value`, as it is owned by the
+ * cache.
  */
 int git_configset_get_value(struct config_set *cs, const char *key, const char **dest);
 
-- 
2.39.1.1430.gb2471c0aaf4

