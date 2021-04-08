Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29847C433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 13:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E271B61151
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 13:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhDHNe7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 09:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbhDHNez (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 09:34:55 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0E7C061761
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 06:34:43 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z1so2441939edb.8
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 06:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zwmJdRexBx1jD2AWCtQ58cRuUTojeju7ZWqikHThBTc=;
        b=MD09qE94u3vNMoqrIABq2T/MDCkoOWNsOx3QvYWUsLsyholdcp4ifb5kuuQUyt88sv
         pVWw3tZdktRXAgxCbBiXowtIKi8rhtbtQ1jo8134HQ/MgBy3aMnG+SKtyLXdWhjPSI4H
         CAiLOOnoBMBEPfBttzWATi402xYUfUZKg+eAADVt6qB+B4wyP/ufO3di9EdRAxO1E3aC
         aEhY4tpg7dBCnbYjshEsquae5EFuyS71vmkl+NCU3Tll3pjEXEXNqIcYF0Y9kxjBaqgI
         nyJ3cLoVfbsBKKiwB0a79c3pwpCKpb1Zonk5NN0qQau67dhRMtvLsb/XdX3jSsAkG9p6
         QC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zwmJdRexBx1jD2AWCtQ58cRuUTojeju7ZWqikHThBTc=;
        b=uFpt36YlDGuCMU5wTf+CSjFBHzWIBySxIUKWCxZ5zrJYYeZoeSCDtT8dYU+xSS6XOD
         1X0uZah/sgKnlfy3eztw6GxmWIlrk3zwlqbIzwg4IFLtaXpyxBX1bf9ZOfcOb/oIS8Un
         8JGrDtAyp/g52k4fgrcHxApe6y6tIEG/mYw7FwZlp8KSq8UeLQxT/88vPAP8hdzgsEHa
         efe7ssZR+BgKw5t+yWUSdqVPSBzu5xmgls6ak4b8HOdEj3qvvMuZu7CKjwlXWNLWWpDc
         c981bswq4jp/ZwUJR2AYrog+ONtnQe7BUui5Z6s6Y4jCF3uPPRudSX8cG1b8tYyz+LJ0
         z1UA==
X-Gm-Message-State: AOAM533L+A+Ma8bcjlvLwDFce506LTYjKwK7UusWWbu8pqlrvObYG50o
        ry5h9B7/cMyDrd8L9/34Hww/KlmI9oMdVA==
X-Google-Smtp-Source: ABdhPJw9BZ3dPsZY5XGRNWS4dSM7C/CFe7RJAFMGwFBE7OxiB0k2rK4HZ3FBKMgKa663yaALy1IEKQ==
X-Received: by 2002:a05:6402:22a6:: with SMTP id cx6mr11523813edb.55.1617888882211;
        Thu, 08 Apr 2021 06:34:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x24sm12441621edr.36.2021.04.08.06.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 06:34:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lin Sun <lin.sun@zoom.us>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, David Aguilar <davvid@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/5] config.c: add a "tristate" helper
Date:   Thu,  8 Apr 2021 15:34:28 +0200
Message-Id: <patch-4.6-222e91e11b-20210408T133125Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.527.g9b8f7de2547
In-Reply-To: <cover-0.6-0000000000-20210408T133125Z-avarab@gmail.com>
References: <cover-0.6-0000000000-20210408T133125Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add "tristate" functions to go along with the "bool" functions and
migrate the common pattern of checking if something is "bool" or
"auto" in various places over to the new functions.

We also have e.g. "repo_config_get_bool" and
"config_error_nonbool". I'm not adding corresponding "tristate"
functions as they're not needed by anything, but we could add those in
the future if they are.

I'm not migrating over "core.abbrev" parsing as part of this
change. When "core.abbrev" was made optionally boolean in
a9ecaa06a7 (core.abbrev=no disables abbreviations, 2020-09-01) the
"die if empty" code added in g48d5014dd4 (config.abbrev: document the
new default that auto-scales, 2016-11-01) wasn't adjusted. It thus
behaves unlike all other "maybe bool" config variables.

I have a planned series to start adding some tests for "core.abbrev",
but AFAICT there's not even a test for "core.abbrev=true", and I'd
like to focus on thing that have no behavior change here, so let's
leave it for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/log.c  | 13 +++++++------
 compat/mingw.c |  6 +++---
 config.c       | 16 ++++++++++++++++
 config.h       | 12 ++++++++++++
 http.c         |  5 +++--
 userdiff.c     |  6 ++----
 6 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 8acd285daf..0d945313d8 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -868,11 +868,12 @@ static int git_format_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 	if (!strcmp(var, "format.numbered")) {
-		if (value && !strcasecmp(value, "auto")) {
+		int tristate = git_config_tristate(var, value);
+		if (tristate == 2) {
 			auto_number = 1;
 			return 0;
 		}
-		numbered = git_config_bool(var, value);
+		numbered = tristate;
 		auto_number = auto_number && numbered;
 		return 0;
 	}
@@ -904,11 +905,11 @@ static int git_format_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "format.signaturefile"))
 		return git_config_pathname(&signature_file, var, value);
 	if (!strcmp(var, "format.coverletter")) {
-		if (value && !strcasecmp(value, "auto")) {
+		int tristate = git_config_tristate(var, value);
+		if (tristate == 2)
 			config_cover_letter = COVER_AUTO;
-			return 0;
-		}
-		config_cover_letter = git_config_bool(var, value) ? COVER_ON : COVER_OFF;
+		else
+			config_cover_letter = tristate ? COVER_ON : COVER_OFF;
 		return 0;
 	}
 	if (!strcmp(var, "format.outputdirectory"))
diff --git a/compat/mingw.c b/compat/mingw.c
index a43599841c..e6e85ae99a 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -247,11 +247,11 @@ int mingw_core_config(const char *var, const char *value, void *cb)
 	}
 
 	if (!strcmp(var, "core.restrictinheritedhandles")) {
-		if (value && !strcasecmp(value, "auto"))
+		int tristate = git_config_tristate(var, value);
+		if (tristate == 2)
 			core_restrict_inherited_handles = -1;
 		else
-			core_restrict_inherited_handles =
-				git_config_bool(var, value);
+			core_restrict_inherited_handles = tristate;
 		return 0;
 	}
 
diff --git a/config.c b/config.c
index fc28dbd97c..74d2b2c0df 100644
--- a/config.c
+++ b/config.c
@@ -1257,6 +1257,14 @@ int git_parse_maybe_bool(const char *value)
 	return -1;
 }
 
+int git_parse_maybe_tristate(const char *value)
+{
+	int v = git_parse_maybe_bool(value);
+	if (v < 0 && !strcasecmp(value, "auto"))
+		return 2;
+	return v;
+}
+
 int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
 {
 	int v = git_parse_maybe_bool_text(value);
@@ -1268,6 +1276,14 @@ int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
 	return git_config_int(name, value);
 }
 
+int git_config_tristate(const char *name, const char *value)
+{
+	int v = git_parse_maybe_tristate(value);
+	if (v < 0)
+		die(_("bad tristate config value '%s' for '%s'"), value, name);
+	return v;
+}
+
 int git_config_bool(const char *name, const char *value)
 {
 	int v = git_parse_maybe_bool(value);
diff --git a/config.h b/config.h
index 19a9adbaa9..c5129e4392 100644
--- a/config.h
+++ b/config.h
@@ -197,6 +197,12 @@ int git_parse_ulong(const char *, unsigned long *);
  */
 int git_parse_maybe_bool(const char *);
 
+/**
+ * Same as `git_parse_maybe_bool`, except that "auto" is recognized and
+ * will return "2".
+ */
+int git_parse_maybe_tristate(const char *);
+
 /**
  * Parse the string to an integer, including unit factors. Dies on error;
  * otherwise, returns the parsed result.
@@ -226,6 +232,12 @@ int git_config_bool_or_int(const char *, const char *, int *);
  */
 int git_config_bool(const char *, const char *);
 
+/**
+ * Like git_config_bool() except "auto" is also recognized and will
+ * return "2"
+ */
+int git_config_tristate(const char *, const char *);
+
 /**
  * Allocates and copies the value string into the `dest` parameter; if no
  * string is given, prints an error message and returns -1.
diff --git a/http.c b/http.c
index 406410f884..b54a232e90 100644
--- a/http.c
+++ b/http.c
@@ -406,10 +406,11 @@ static int http_options(const char *var, const char *value, void *cb)
 		return git_config_string(&user_agent, var, value);
 
 	if (!strcmp("http.emptyauth", var)) {
-		if (value && !strcmp("auto", value))
+		int tristate = git_config_tristate(var, value);
+		if (tristate == 2)
 			curl_empty_auth = -1;
 		else
-			curl_empty_auth = git_config_bool(var, value);
+			curl_empty_auth = tristate;
 		return 0;
 	}
 
diff --git a/userdiff.c b/userdiff.c
index 3f81a2261c..7ff010961f 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -277,10 +277,8 @@ static int parse_funcname(struct userdiff_funcname *f, const char *k,
 
 static int parse_tristate(int *b, const char *k, const char *v)
 {
-	if (v && !strcasecmp(v, "auto"))
-		*b = -1;
-	else
-		*b = git_config_bool(k, v);
+	int tristate = git_config_tristate(k, v);
+	*b = tristate == 2 ? -1 : tristate;
 	return 0;
 }
 
-- 
2.31.1.527.g9b8f7de2547

