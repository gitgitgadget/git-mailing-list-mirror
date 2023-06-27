Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113C9C001B3
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 19:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjF0TxY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 15:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjF0TxT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 15:53:19 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AE1FA
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 12:53:14 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-262c488c1d3so1784029a91.3
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 12:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687895593; x=1690487593;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CFLigByeLp7/F/OtroClxP0BU3K/wJhvItmEBI3Pp5w=;
        b=bxBPx5epcrQnkQwzw1fz7Mpt6TQ4UiHWoNRsfPEnMMafillir+TVgSVgnw3lyggn5K
         RzoOfmu3dZTJkMhtpaDULccOuDk+B6uqgeyurbtWsBcwdXQEcWE0QS4MXpiFEdQJX4mt
         8LqfzpwdPSFTa4jW1Am28C8ad5I4/esRm0hBugHjfWwj3L//RyV2fuYNatHGGsuUYi5n
         RbCr/dgR5fYSt9yxuuBlLAgkVyTkm8chAuLoAmbesbZ3xrP9UiUmbWPi7EnrgllfYSaZ
         xqZs5JmNz1ElqBETpy9u+/nOYptcvhJCSg5X+VxsVs+iEbYpEQfSz/JtPiPpNDwlD9b6
         ZXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687895593; x=1690487593;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CFLigByeLp7/F/OtroClxP0BU3K/wJhvItmEBI3Pp5w=;
        b=Y+qP2+mpCshatsHG7z5JpMGkhSfeDG2vEkwfnQolHWu4TVLrxyHEGUQcVFvP175Ko8
         QdvkDqfcW+Wh1dWgCeC/5IMLcFtFtLsE6/zcAbePorc8IOBozknY63JEyl4ox9jQjwf8
         d0m5OK1hV0b4KghRrBVO6iiAK22SVcUfQB/M4kOQNFZqSf9qSihzCrv4bPp18898YWAV
         G1c83pJP7mBKkzaJzT/Ik/5NJt+yRs/4Okc03nzG3sX/YEy0lhyETB/uPZFfoORlCg31
         2MPYcbz8tTkq4tR75Jml7Tc56yZdwVxcMLZh8LqLeU4VOG26XdEmo8iQgEpsWaaHWKYj
         idhg==
X-Gm-Message-State: AC+VfDw2lNroW6oSGdmxmALlgBRr4ocpEMjhhqZL54EkyGO/PSj61udD
        eCu5YRMOj7JDjuhAQXytTp/WgegFTNOI73GZ9Dbiusw8168HqS2rSdGgQgoF1TzHoxL4K0jHWEE
        oHpkl73wiupW4S5izu8bL/hD5lUb8x+46YFGOqscwg/moK3zqeTpnRG9nd8IAzEL11A==
X-Google-Smtp-Source: ACHHUZ5jM3vSJpopnuycHmnlfIn0Qi/9nmKr0mlvZuOIvdZRZk9qKsPcbppTm69Ae73+dbaHAOcsicjOJD9qkLM=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90a:a791:b0:256:3e18:39e with SMTP
 id f17-20020a17090aa79100b002563e18039emr4898784pjq.3.1687895593506; Tue, 27
 Jun 2023 12:53:13 -0700 (PDT)
Date:   Tue, 27 Jun 2023 19:52:48 +0000
In-Reply-To: <20230627195251.1973421-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230627195251.1973421-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230627195251.1973421-6-calvinwan@google.com>
Subject: [RFC PATCH 5/8] parse: create new library for parsing strings and env values
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, nasamuffin@google.com,
        chooglen@google.com, johnathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While string and environment value parsing is mainly consumed by
config.c, there are other files that only need parsing functionality and
not config functionality. By separating out string and environment value
parsing from config, those files can instead be dependent on parse,
which has a much smaller dependency chain than config.

Move general string and env parsing functions from config.[ch] to
parse.[ch].

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 Makefile                   |   1 +
 attr.c                     |   2 +-
 config.c                   | 180 +-----------------------------------
 config.h                   |  14 +--
 pack-objects.c             |   2 +-
 pack-revindex.c            |   2 +-
 parse-options.c            |   3 +-
 parse.c                    | 182 +++++++++++++++++++++++++++++++++++++
 parse.h                    |  20 ++++
 pathspec.c                 |   2 +-
 preload-index.c            |   2 +-
 progress.c                 |   2 +-
 prompt.c                   |   2 +-
 rebase.c                   |   2 +-
 t/helper/test-env-helper.c |   2 +-
 unpack-trees.c             |   2 +-
 wrapper.c                  |   2 +-
 write-or-die.c             |   2 +-
 18 files changed, 219 insertions(+), 205 deletions(-)
 create mode 100644 parse.c
 create mode 100644 parse.h

diff --git a/Makefile b/Makefile
index 83b385b0be..e9ad9f9ef1 100644
--- a/Makefile
+++ b/Makefile
@@ -1091,6 +1091,7 @@ LIB_OBJS += pack-write.o
 LIB_OBJS += packfile.o
 LIB_OBJS += pager.o
 LIB_OBJS += parallel-checkout.o
+LIB_OBJS += parse.o
 LIB_OBJS += parse-options-cb.o
 LIB_OBJS += parse-options.o
 LIB_OBJS += patch-delta.o
diff --git a/attr.c b/attr.c
index e9c81b6e07..cb047b4618 100644
--- a/attr.c
+++ b/attr.c
@@ -7,7 +7,7 @@
  */
 
 #include "git-compat-util.h"
-#include "config.h"
+#include "parse.h"
 #include "environment.h"
 #include "exec-cmd.h"
 #include "attr.h"
diff --git a/config.c b/config.c
index 5b71ef1624..cdd70999aa 100644
--- a/config.c
+++ b/config.c
@@ -11,6 +11,7 @@
 #include "date.h"
 #include "branch.h"
 #include "config.h"
+#include "parse.h"
 #include "convert.h"
 #include "environment.h"
 #include "gettext.h"
@@ -1204,129 +1205,6 @@ static int git_parse_source(struct config_source *cs, config_fn_t fn,
 	return error_return;
 }
 
-static uintmax_t get_unit_factor(const char *end)
-{
-	if (!*end)
-		return 1;
-	else if (!strcasecmp(end, "k"))
-		return 1024;
-	else if (!strcasecmp(end, "m"))
-		return 1024 * 1024;
-	else if (!strcasecmp(end, "g"))
-		return 1024 * 1024 * 1024;
-	return 0;
-}
-
-static int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
-{
-	if (value && *value) {
-		char *end;
-		intmax_t val;
-		intmax_t factor;
-
-		if (max < 0)
-			BUG("max must be a positive integer");
-
-		errno = 0;
-		val = strtoimax(value, &end, 0);
-		if (errno == ERANGE)
-			return 0;
-		if (end == value) {
-			errno = EINVAL;
-			return 0;
-		}
-		factor = get_unit_factor(end);
-		if (!factor) {
-			errno = EINVAL;
-			return 0;
-		}
-		if ((val < 0 && -max / factor > val) ||
-		    (val > 0 && max / factor < val)) {
-			errno = ERANGE;
-			return 0;
-		}
-		val *= factor;
-		*ret = val;
-		return 1;
-	}
-	errno = EINVAL;
-	return 0;
-}
-
-static int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max)
-{
-	if (value && *value) {
-		char *end;
-		uintmax_t val;
-		uintmax_t factor;
-
-		/* negative values would be accepted by strtoumax */
-		if (strchr(value, '-')) {
-			errno = EINVAL;
-			return 0;
-		}
-		errno = 0;
-		val = strtoumax(value, &end, 0);
-		if (errno == ERANGE)
-			return 0;
-		if (end == value) {
-			errno = EINVAL;
-			return 0;
-		}
-		factor = get_unit_factor(end);
-		if (!factor) {
-			errno = EINVAL;
-			return 0;
-		}
-		if (unsigned_mult_overflows(factor, val) ||
-		    factor * val > max) {
-			errno = ERANGE;
-			return 0;
-		}
-		val *= factor;
-		*ret = val;
-		return 1;
-	}
-	errno = EINVAL;
-	return 0;
-}
-
-int git_parse_int(const char *value, int *ret)
-{
-	intmax_t tmp;
-	if (!git_parse_signed(value, &tmp, maximum_signed_value_of_type(int)))
-		return 0;
-	*ret = tmp;
-	return 1;
-}
-
-static int git_parse_int64(const char *value, int64_t *ret)
-{
-	intmax_t tmp;
-	if (!git_parse_signed(value, &tmp, maximum_signed_value_of_type(int64_t)))
-		return 0;
-	*ret = tmp;
-	return 1;
-}
-
-int git_parse_ulong(const char *value, unsigned long *ret)
-{
-	uintmax_t tmp;
-	if (!git_parse_unsigned(value, &tmp, maximum_unsigned_value_of_type(long)))
-		return 0;
-	*ret = tmp;
-	return 1;
-}
-
-int git_parse_ssize_t(const char *value, ssize_t *ret)
-{
-	intmax_t tmp;
-	if (!git_parse_signed(value, &tmp, maximum_signed_value_of_type(ssize_t)))
-		return 0;
-	*ret = tmp;
-	return 1;
-}
-
 static int reader_config_name(struct config_reader *reader, const char **out);
 static int reader_origin_type(struct config_reader *reader,
 			      enum config_origin_type *type);
@@ -1404,23 +1282,6 @@ ssize_t git_config_ssize_t(const char *name, const char *value)
 	return ret;
 }
 
-static int git_parse_maybe_bool_text(const char *value)
-{
-	if (!value)
-		return 1;
-	if (!*value)
-		return 0;
-	if (!strcasecmp(value, "true")
-	    || !strcasecmp(value, "yes")
-	    || !strcasecmp(value, "on"))
-		return 1;
-	if (!strcasecmp(value, "false")
-	    || !strcasecmp(value, "no")
-	    || !strcasecmp(value, "off"))
-		return 0;
-	return -1;
-}
-
 static const struct fsync_component_name {
 	const char *name;
 	enum fsync_component component_bits;
@@ -1495,16 +1356,6 @@ static enum fsync_component parse_fsync_components(const char *var, const char *
 	return (current & ~negative) | positive;
 }
 
-int git_parse_maybe_bool(const char *value)
-{
-	int v = git_parse_maybe_bool_text(value);
-	if (0 <= v)
-		return v;
-	if (git_parse_int(value, &v))
-		return !!v;
-	return -1;
-}
-
 int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
 {
 	int v = git_parse_maybe_bool_text(value);
@@ -2165,35 +2016,6 @@ void git_global_config(char **user_out, char **xdg_out)
 	*xdg_out = xdg_config;
 }
 
-/*
- * Parse environment variable 'k' as a boolean (in various
- * possible spellings); if missing, use the default value 'def'.
- */
-int git_env_bool(const char *k, int def)
-{
-	const char *v = getenv(k);
-	int val;
-	if (!v)
-		return def;
-	val = git_parse_maybe_bool(v);
-	if (val < 0)
-		die(_("bad boolean environment value '%s' for '%s'"),
-		    v, k);
-	return val;
-}
-
-/*
- * Parse environment variable 'k' as ulong with possibly a unit
- * suffix; if missing, use the default value 'val'.
- */
-unsigned long git_env_ulong(const char *k, unsigned long val)
-{
-	const char *v = getenv(k);
-	if (v && !git_parse_ulong(v, &val))
-		die(_("failed to parse %s"), k);
-	return val;
-}
-
 int git_config_system(void)
 {
 	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
diff --git a/config.h b/config.h
index 247b572b37..7a7f53e503 100644
--- a/config.h
+++ b/config.h
@@ -3,7 +3,7 @@
 
 #include "hashmap.h"
 #include "string-list.h"
-
+#include "parse.h"
 
 /**
  * The config API gives callers a way to access Git configuration files
@@ -205,16 +205,6 @@ int config_with_options(config_fn_t fn, void *,
  * The following helper functions aid in parsing string values
  */
 
-int git_parse_ssize_t(const char *, ssize_t *);
-int git_parse_ulong(const char *, unsigned long *);
-int git_parse_int(const char *value, int *ret);
-
-/**
- * Same as `git_config_bool`, except that it returns -1 on error rather
- * than dying.
- */
-int git_parse_maybe_bool(const char *);
-
 /**
  * Parse the string to an integer, including unit factors. Dies on error;
  * otherwise, returns the parsed result.
@@ -343,8 +333,6 @@ int git_config_rename_section(const char *, const char *);
 int git_config_rename_section_in_file(const char *, const char *, const char *);
 int git_config_copy_section(const char *, const char *);
 int git_config_copy_section_in_file(const char *, const char *, const char *);
-int git_env_bool(const char *, int);
-unsigned long git_env_ulong(const char *, unsigned long);
 int git_config_system(void);
 int config_error_nonbool(const char *);
 #if defined(__GNUC__)
diff --git a/pack-objects.c b/pack-objects.c
index 1b8052bece..f403ca6986 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -3,7 +3,7 @@
 #include "pack.h"
 #include "pack-objects.h"
 #include "packfile.h"
-#include "config.h"
+#include "parse.h"
 
 static uint32_t locate_object_entry_hash(struct packing_data *pdata,
 					 const struct object_id *oid,
diff --git a/pack-revindex.c b/pack-revindex.c
index 7fffcad912..a01a2a4640 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -6,7 +6,7 @@
 #include "packfile.h"
 #include "strbuf.h"
 #include "trace2.h"
-#include "config.h"
+#include "parse.h"
 #include "midx.h"
 #include "csum-file.h"
 
diff --git a/parse-options.c b/parse-options.c
index f8a155ee13..9f542950a7 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1,11 +1,12 @@
 #include "git-compat-util.h"
 #include "parse-options.h"
 #include "abspath.h"
-#include "config.h"
+#include "parse.h"
 #include "commit.h"
 #include "color.h"
 #include "gettext.h"
 #include "strbuf.h"
+#include "string-list.h"
 #include "utf8.h"
 
 static int disallow_abbreviated_options;
diff --git a/parse.c b/parse.c
new file mode 100644
index 0000000000..42d691a0fb
--- /dev/null
+++ b/parse.c
@@ -0,0 +1,182 @@
+#include "git-compat-util.h"
+#include "gettext.h"
+#include "parse.h"
+
+static uintmax_t get_unit_factor(const char *end)
+{
+	if (!*end)
+		return 1;
+	else if (!strcasecmp(end, "k"))
+		return 1024;
+	else if (!strcasecmp(end, "m"))
+		return 1024 * 1024;
+	else if (!strcasecmp(end, "g"))
+		return 1024 * 1024 * 1024;
+	return 0;
+}
+
+int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
+{
+	if (value && *value) {
+		char *end;
+		intmax_t val;
+		intmax_t factor;
+
+		if (max < 0)
+			BUG("max must be a positive integer");
+
+		errno = 0;
+		val = strtoimax(value, &end, 0);
+		if (errno == ERANGE)
+			return 0;
+		if (end == value) {
+			errno = EINVAL;
+			return 0;
+		}
+		factor = get_unit_factor(end);
+		if (!factor) {
+			errno = EINVAL;
+			return 0;
+		}
+		if ((val < 0 && -max / factor > val) ||
+		    (val > 0 && max / factor < val)) {
+			errno = ERANGE;
+			return 0;
+		}
+		val *= factor;
+		*ret = val;
+		return 1;
+	}
+	errno = EINVAL;
+	return 0;
+}
+
+static int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max)
+{
+	if (value && *value) {
+		char *end;
+		uintmax_t val;
+		uintmax_t factor;
+
+		/* negative values would be accepted by strtoumax */
+		if (strchr(value, '-')) {
+			errno = EINVAL;
+			return 0;
+		}
+		errno = 0;
+		val = strtoumax(value, &end, 0);
+		if (errno == ERANGE)
+			return 0;
+		if (end == value) {
+			errno = EINVAL;
+			return 0;
+		}
+		factor = get_unit_factor(end);
+		if (!factor) {
+			errno = EINVAL;
+			return 0;
+		}
+		if (unsigned_mult_overflows(factor, val) ||
+		    factor * val > max) {
+			errno = ERANGE;
+			return 0;
+		}
+		val *= factor;
+		*ret = val;
+		return 1;
+	}
+	errno = EINVAL;
+	return 0;
+}
+
+int git_parse_int(const char *value, int *ret)
+{
+	intmax_t tmp;
+	if (!git_parse_signed(value, &tmp, maximum_signed_value_of_type(int)))
+		return 0;
+	*ret = tmp;
+	return 1;
+}
+
+int git_parse_int64(const char *value, int64_t *ret)
+{
+	intmax_t tmp;
+	if (!git_parse_signed(value, &tmp, maximum_signed_value_of_type(int64_t)))
+		return 0;
+	*ret = tmp;
+	return 1;
+}
+
+int git_parse_ulong(const char *value, unsigned long *ret)
+{
+	uintmax_t tmp;
+	if (!git_parse_unsigned(value, &tmp, maximum_unsigned_value_of_type(long)))
+		return 0;
+	*ret = tmp;
+	return 1;
+}
+
+int git_parse_ssize_t(const char *value, ssize_t *ret)
+{
+	intmax_t tmp;
+	if (!git_parse_signed(value, &tmp, maximum_signed_value_of_type(ssize_t)))
+		return 0;
+	*ret = tmp;
+	return 1;
+}
+
+int git_parse_maybe_bool_text(const char *value)
+{
+	if (!value)
+		return 1;
+	if (!*value)
+		return 0;
+	if (!strcasecmp(value, "true")
+	    || !strcasecmp(value, "yes")
+	    || !strcasecmp(value, "on"))
+		return 1;
+	if (!strcasecmp(value, "false")
+	    || !strcasecmp(value, "no")
+	    || !strcasecmp(value, "off"))
+		return 0;
+	return -1;
+}
+
+int git_parse_maybe_bool(const char *value)
+{
+	int v = git_parse_maybe_bool_text(value);
+	if (0 <= v)
+		return v;
+	if (git_parse_int(value, &v))
+		return !!v;
+	return -1;
+}
+
+/*
+ * Parse environment variable 'k' as a boolean (in various
+ * possible spellings); if missing, use the default value 'def'.
+ */
+int git_env_bool(const char *k, int def)
+{
+	const char *v = getenv(k);
+	int val;
+	if (!v)
+		return def;
+	val = git_parse_maybe_bool(v);
+	if (val < 0)
+		die(_("bad boolean environment value '%s' for '%s'"),
+		    v, k);
+	return val;
+}
+
+/*
+ * Parse environment variable 'k' as ulong with possibly a unit
+ * suffix; if missing, use the default value 'val'.
+ */
+unsigned long git_env_ulong(const char *k, unsigned long val)
+{
+	const char *v = getenv(k);
+	if (v && !git_parse_ulong(v, &val))
+		die(_("failed to parse %s"), k);
+	return val;
+}
diff --git a/parse.h b/parse.h
new file mode 100644
index 0000000000..07d2193d69
--- /dev/null
+++ b/parse.h
@@ -0,0 +1,20 @@
+#ifndef PARSE_H
+#define PARSE_H
+
+int git_parse_signed(const char *value, intmax_t *ret, intmax_t max);
+int git_parse_ssize_t(const char *, ssize_t *);
+int git_parse_ulong(const char *, unsigned long *);
+int git_parse_int(const char *value, int *ret);
+int git_parse_int64(const char *value, int64_t *ret);
+
+/**
+ * Same as `git_config_bool`, except that it returns -1 on error rather
+ * than dying.
+ */
+int git_parse_maybe_bool(const char *);
+int git_parse_maybe_bool_text(const char *value);
+
+int git_env_bool(const char *, int);
+unsigned long git_env_ulong(const char *, unsigned long);
+
+#endif /* PARSE_H */
diff --git a/pathspec.c b/pathspec.c
index 4991455281..39337999d4 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "config.h"
+#include "parse.h"
 #include "dir.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/preload-index.c b/preload-index.c
index e44530c80c..63fd35d64b 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -7,7 +7,7 @@
 #include "environment.h"
 #include "fsmonitor.h"
 #include "gettext.h"
-#include "config.h"
+#include "parse.h"
 #include "preload-index.h"
 #include "progress.h"
 #include "read-cache.h"
diff --git a/progress.c b/progress.c
index f695798aca..c83cb60bf1 100644
--- a/progress.c
+++ b/progress.c
@@ -17,7 +17,7 @@
 #include "trace.h"
 #include "trace2.h"
 #include "utf8.h"
-#include "config.h"
+#include "parse.h"
 
 #define TP_IDX_MAX      8
 
diff --git a/prompt.c b/prompt.c
index 3baa33f63d..8935fe4dfb 100644
--- a/prompt.c
+++ b/prompt.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "config.h"
+#include "parse.h"
 #include "environment.h"
 #include "run-command.h"
 #include "strbuf.h"
diff --git a/rebase.c b/rebase.c
index 17a570f1ff..69a1822da3 100644
--- a/rebase.c
+++ b/rebase.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
 #include "rebase.h"
-#include "config.h"
+#include "parse.h"
 #include "gettext.h"
 
 /*
diff --git a/t/helper/test-env-helper.c b/t/helper/test-env-helper.c
index 66c88b8ff3..1c486888a4 100644
--- a/t/helper/test-env-helper.c
+++ b/t/helper/test-env-helper.c
@@ -1,5 +1,5 @@
 #include "test-tool.h"
-#include "config.h"
+#include "parse.h"
 #include "parse-options.h"
 
 static char const * const env__helper_usage[] = {
diff --git a/unpack-trees.c b/unpack-trees.c
index 87517364dc..761562a96e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2,7 +2,7 @@
 #include "advice.h"
 #include "strvec.h"
 #include "repository.h"
-#include "config.h"
+#include "parse.h"
 #include "dir.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/wrapper.c b/wrapper.c
index 62c04aeb17..3e554f50c6 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -3,7 +3,7 @@
  */
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "config.h"
+#include "parse.h"
 #include "gettext.h"
 #include "strbuf.h"
 
diff --git a/write-or-die.c b/write-or-die.c
index d8355c0c3e..42a2dc73cd 100644
--- a/write-or-die.c
+++ b/write-or-die.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "config.h"
+#include "parse.h"
 #include "run-command.h"
 #include "write-or-die.h"
 
-- 
2.41.0.162.gfafddb0af9-goog

