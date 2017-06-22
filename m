Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CE2020802
	for <e@80x24.org>; Thu, 22 Jun 2017 21:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753821AbdFVVib (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 17:38:31 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33852 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753772AbdFVVi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 17:38:29 -0400
Received: by mail-wr0-f195.google.com with SMTP id k67so7765034wrc.1
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 14:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M5IqzrMxR6tPRohINKSqLagjLhiYnNCkh9WoNGgder0=;
        b=jt+H32DY7FtxLAHt75e38WOqG1eWAb1PEz6cb22DYOkfFKF8IhCgyuJEBCi0Vwf7m/
         utz7W64LbIMlhgzbV3UBn6gh+Zc0g70WET5ap/OatgAHcHBgo/11bb2gIwvHQcC3t1aW
         oUGwvRvnh0nY4ufHUdsQPYVxLhHYQuuOVcD8tWB6hpc8eOTNppOwfsPAUAjzFrSduBot
         /K1o9Q6eWyEp0N0W9dgCbl5SVMzUk4IR3juXqoV9zG4pwQ4cWZETX+1Qwbo9HUC7tE/6
         KJ64xFUaVh0jkUMF2B2KzeoGN9FwL4TlNRj+xBDjtTYBn40pcl1tD1/V5vJ/jWqCwp4u
         e1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M5IqzrMxR6tPRohINKSqLagjLhiYnNCkh9WoNGgder0=;
        b=hgEmdsNyL1WYtvEhdzqdDOhT4PmArBRyrYF3AYeUqW2hGQICA7aErfjDeuD0m8/1KE
         OAzmY7EEY8Ju8hFWROf8gIvXOgkES18Z5SJyvVgqfuJBDIugvQUlqca0LQHbegFn70L9
         4n2HBG1t8gaJ1DeLf+fU0nRuyxWzAWgMnUTHNhRJbe02YHmrqfbJsygTgkseHjgKWkRf
         pVYVrQRYbHP51ciZZn0AwxIEYoXnVaYK0AL8BeXu46Bj6TmffWvuyjXZfLwPscoeDJi/
         g8gVj+LXfL65JyQ2zq34/CE12CgaKBh3a7/uRxq31lvRmY9YlDUl23eZcn+u/L4nLZip
         YxCg==
X-Gm-Message-State: AKS2vOyW5fYP9/aCbiAnWbPEDxK6WHisWYHGaRpVmP8RRbGfOVyp0pmu
        iQDyNMMqTu5YI/d7AjQ=
X-Received: by 10.80.195.207 with SMTP id i15mr3927095edf.70.1498167507445;
        Thu, 22 Jun 2017 14:38:27 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w26sm1404966edw.28.2017.06.22.14.38.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jun 2017 14:38:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH 3/3] wildmatch: make use of the interface for precompiling wildmatch() patterns
Date:   Thu, 22 Jun 2017 21:38:10 +0000
Message-Id: <20170622213810.14785-4-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170622213810.14785-1-avarab@gmail.com>
References: <20170622213810.14785-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make use of the batch wildmatch() interface. As noted in the comment
here the main hot codepath is not being touched, but some other
invocations where we repeatedly match the same glob against multiple
strings have been migrated.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/name-rev.c |  6 +++++-
 builtin/replace.c  |  7 ++++---
 config.c           |  8 ++++++--
 dir.c              | 12 ++++++++++++
 refs.c             |  7 ++++---
 5 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index d21a5002a7..a8f8010e1e 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -127,14 +127,18 @@ static void name_rev(struct commit *commit,
 static int subpath_matches(const char *path, const char *filter)
 {
 	const char *subpath = path;
+	struct wildmatch_compiled *code = wildmatch_compile(filter, 0);
 
 	while (subpath) {
-		if (!wildmatch(filter, subpath, 0))
+		if (!wildmatch_match(code, subpath)) {
+			wildmatch_free(code);
 			return subpath - path;
+		}
 		subpath = strchr(subpath, '/');
 		if (subpath)
 			subpath++;
 	}
+	wildmatch_free(code);
 	return -1;
 }
 
diff --git a/builtin/replace.c b/builtin/replace.c
index 89262df5a1..70e7af72ce 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -31,7 +31,7 @@ enum replace_format {
 };
 
 struct show_data {
-	const char *pattern;
+	struct wildmatch_compiled *code;
 	enum replace_format format;
 };
 
@@ -40,7 +40,7 @@ static int show_reference(const char *refname, const struct object_id *oid,
 {
 	struct show_data *data = cb_data;
 
-	if (!wildmatch(data->pattern, refname, 0)) {
+	if (!wildmatch_match(data->code, refname)) {
 		if (data->format == REPLACE_FORMAT_SHORT)
 			printf("%s\n", refname);
 		else if (data->format == REPLACE_FORMAT_MEDIUM)
@@ -69,7 +69,7 @@ static int list_replace_refs(const char *pattern, const char *format)
 
 	if (pattern == NULL)
 		pattern = "*";
-	data.pattern = pattern;
+	data.code = wildmatch_compile(pattern, 0);
 
 	if (format == NULL || *format == '\0' || !strcmp(format, "short"))
 		data.format = REPLACE_FORMAT_SHORT;
@@ -83,6 +83,7 @@ static int list_replace_refs(const char *pattern, const char *format)
 		    format);
 
 	for_each_replace_ref(show_reference, (void *)&data);
+	wildmatch_free(data.code);
 
 	return 0;
 }
diff --git a/config.c b/config.c
index 260caf27b8..2ec45e9790 100644
--- a/config.c
+++ b/config.c
@@ -215,6 +215,7 @@ static int include_by_gitdir(const struct config_options *opts,
 	int ret = 0, prefix;
 	const char *git_dir;
 	int already_tried_absolute = 0;
+	struct wildmatch_compiled *code = NULL;
 
 	if (opts->git_dir)
 		git_dir = opts->git_dir;
@@ -244,8 +245,10 @@ static int include_by_gitdir(const struct config_options *opts,
 			goto done;
 	}
 
-	ret = !wildmatch(pattern.buf + prefix, text.buf + prefix,
-			 icase ? WM_CASEFOLD : 0);
+	if (!code)
+		code = wildmatch_compile(pattern.buf + prefix,
+					 icase ? WM_CASEFOLD : 0);
+	ret = !wildmatch_match(code, text.buf + prefix);
 
 	if (!ret && !already_tried_absolute) {
 		/*
@@ -264,6 +267,7 @@ static int include_by_gitdir(const struct config_options *opts,
 done:
 	strbuf_release(&pattern);
 	strbuf_release(&text);
+	wildmatch_free(code);
 	return ret;
 }
 
diff --git a/dir.c b/dir.c
index 544056b37a..f4b5b93956 100644
--- a/dir.c
+++ b/dir.c
@@ -79,6 +79,18 @@ int git_fnmatch(const struct pathspec_item *item,
 			ps_strcmp(item, pattern,
 				  string + string_len - pattern_len);
 	}
+
+	/*
+	 * TODO: This is the main hot path, but untangling this whole
+	 * munging of the prefix is a PITA. We take e.g. the pattern
+	 * "t/**.sh" and then conclude that there's a directory "t",
+	 * and then match its entries (recursively) against "**.sh".
+	 *
+	 * We should try to just always match the full glob against
+	 * the full pattern. See my "BUG: wildmatches ... don't match
+	 * properly due to internal optimizations" on the mailing list
+	 * (<CACBZZX5u5fF4fJBJ3CwH0DmLBw4D32jN5o=Om-iqwQdPG93DFg@mail.gmail.com>).
+	 */
 	if (item->magic & PATHSPEC_GLOB)
 		return wildmatch(pattern, string,
 				 WM_PATHNAME |
diff --git a/refs.c b/refs.c
index 32626a4cd1..ce83b3fccf 100644
--- a/refs.c
+++ b/refs.c
@@ -194,7 +194,7 @@ char *resolve_refdup(const char *refname, int resolve_flags,
 
 /* The argument to filter_refs */
 struct ref_filter {
-	const char *pattern;
+	struct wildmatch_compiled *code;
 	each_ref_fn *fn;
 	void *cb_data;
 };
@@ -229,7 +229,7 @@ static int filter_refs(const char *refname, const struct object_id *oid,
 {
 	struct ref_filter *filter = (struct ref_filter *)data;
 
-	if (wildmatch(filter->pattern, refname, 0))
+	if (wildmatch_match(filter->code, refname))
 		return 0;
 	return filter->fn(refname, oid, flags, filter->cb_data);
 }
@@ -390,12 +390,13 @@ int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 		strbuf_addch(&real_pattern, '*');
 	}
 
-	filter.pattern = real_pattern.buf;
+	filter.code = wildmatch_compile(real_pattern.buf, 0);
 	filter.fn = fn;
 	filter.cb_data = cb_data;
 	ret = for_each_ref(filter_refs, &filter);
 
 	strbuf_release(&real_pattern);
+	wildmatch_free(filter.code);
 	return ret;
 }
 
-- 
2.13.1.611.g7e3b11ae1

