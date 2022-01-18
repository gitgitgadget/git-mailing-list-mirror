Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D97DC433EF
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 15:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346157AbiARPzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 10:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346160AbiARPzn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 10:55:43 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683EFC061753
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 07:55:40 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id l35-20020a05600c1d2300b0034d477271c1so5190908wms.3
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 07:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zz+gwGP+Z3t7vmFWolGxN5S5/PabW00eNF0jUoAPvBM=;
        b=EgdJE/9JwpdgPUC499OswBfxvD6dqHWZDSwHKOdJu+FJjU8Ss5YDHY6XEZNy62Y7Ah
         dnHO6WnITBNnl3ukG3MDIVtY5rd1LBA6jH3claaVVZOfxRKb5dQhX0DUtNM6wXOYTZIL
         KMK/xY7CnekQVWoHRpRS5TySqiAAkED5gZe4OGQG7tC//bP3g6tFg/pqKqxei5ywH3aZ
         9OGw86j2yEC2wTsK/5il6phBf+BAnDvfkd8M0snwQd77ExMq5fwI78sjAlXplmIkHpeU
         GwGVnbT6W8I0i6Cdh8EJbBKUMPJ+bNLhLpzjndTUBmfG3Bpv+do+3oIeRpZ9INoYjX9K
         TD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zz+gwGP+Z3t7vmFWolGxN5S5/PabW00eNF0jUoAPvBM=;
        b=yORZ1RwYo/Ti01ULQVyObuOgTY+OyLSycQdmItbugZ44oiagZDC1xV4ykc7weXT8zB
         pXB6+TWhVZo+pwrn7vJ9E6xgWkIRC6NKE3Y210VdOZ3+8FRvEucyeeODHwZuFSqGu2vJ
         D9qJrc1hhoyn8+KfYn0qQ5vLMbqWpjyq8Yz/rEw1oVZQUa7ASYwZnxxpceWaMdCqJK8I
         9BrjXWo9/HOELiVCBBxrbbqsPaxGQHcBkmafzu3TNmrPgak996NGtCHWnwFrr8Du+O8J
         ARWII58zn4yX1rB9HaD5VdAhM1vvYdGfeHy1tIRrFah2njWIC2WZ5ttMHvL4ajjl43xR
         7l+Q==
X-Gm-Message-State: AOAM532ygsAtZooImPZ0AtWMuOQJ06KMXs1SowWiCrX1JU89ve2Uahkj
        sZNCAAnKHP/jwdkv6a06s0BMsHibig5Yfg==
X-Google-Smtp-Source: ABdhPJxNxrImS2rDw7KNF6umqKN32WsdMJkT629sbu6+Nlasbymg7UITM82skJDRjWF0JGQ3q7N07g==
X-Received: by 2002:a05:6000:178b:: with SMTP id e11mr22133749wrg.126.1642521338789;
        Tue, 18 Jan 2022 07:55:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f15sm1220522wrd.45.2022.01.18.07.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 07:55:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 10/10] grep.[ch]: remove GREP_PATTERN_TYPE_UNSPECIFIED
Date:   Tue, 18 Jan 2022 16:55:22 +0100
Message-Id: <patch-v8-10.10-b52a0c11fa9-20220118T155211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.rc1.864.g57621b115b6
In-Reply-To: <cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com>
References: <cover-v7-00.10-00000000000-20211228T004707Z-avarab@gmail.com> <cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the need for "GREP_PATTERN_TYPE_UNSPECIFIED" in favor of having
the users of the "pattern_type_option" member check whether that
member is set or not.

The "UNSPECIFIED" case was already handled implicitly in
compile_regexp(), and we don't use this "enum" in a "switch"
statement, so let's not explicitly name the
"GREP_PATTERN_TYPE_UNSPECIFIED = 0" case. It is still important that
"GREP_PATTERN_TYPE_BRE != 0", as can be seen in failing tests if the
parsing for "basic" in parse_pattern_type_arg() is made to "return 0".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 9 ++++++---
 grep.h | 4 +---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/grep.c b/grep.c
index bb487e994d0..3497df48ca6 100644
--- a/grep.c
+++ b/grep.c
@@ -34,7 +34,7 @@ static const char *color_grep_slots[] = {
 static int parse_pattern_type_arg(const char *opt, const char *arg)
 {
 	if (!strcmp(arg, "default"))
-		return GREP_PATTERN_TYPE_UNSPECIFIED;
+		return 0;
 	else if (!strcmp(arg, "basic"))
 		return GREP_PATTERN_TYPE_BRE;
 	else if (!strcmp(arg, "extended"))
@@ -50,8 +50,7 @@ define_list_config_array_extra(color_grep_slots, {"match"});
 
 static void adjust_pattern_type(enum grep_pattern_type *pto, const int ero)
 {
-	if (*pto == GREP_PATTERN_TYPE_UNSPECIFIED)
-		*pto = ero ? GREP_PATTERN_TYPE_ERE : GREP_PATTERN_TYPE_BRE;
+	*pto = ero ? GREP_PATTERN_TYPE_ERE : GREP_PATTERN_TYPE_BRE;
 }
 
 /*
@@ -69,12 +68,16 @@ int grep_config(const char *var, const char *value, void *cb)
 
 	if (!strcmp(var, "grep.extendedregexp")) {
 		ero = git_config_bool(var, value);
+		if (opt->pattern_type_option)
+			return 0;
 		adjust_pattern_type(&opt->pattern_type_option, ero);
 		return 0;
 	}
 
 	if (!strcmp(var, "grep.patterntype")) {
 		opt->pattern_type_option = parse_pattern_type_arg(var, value);
+		if (opt->pattern_type_option)
+			return 0;
 		if (ero == -1)
 			return 0;
 		adjust_pattern_type(&opt->pattern_type_option, ero);
diff --git a/grep.h b/grep.h
index ab0f8290784..460cb75a357 100644
--- a/grep.h
+++ b/grep.h
@@ -94,8 +94,7 @@ enum grep_expr_node {
 };
 
 enum grep_pattern_type {
-	GREP_PATTERN_TYPE_UNSPECIFIED = 0,
-	GREP_PATTERN_TYPE_BRE,
+	GREP_PATTERN_TYPE_BRE = 1,
 	GREP_PATTERN_TYPE_ERE,
 	GREP_PATTERN_TYPE_FIXED,
 	GREP_PATTERN_TYPE_PCRE
@@ -180,7 +179,6 @@ struct grep_opt {
 	.relative = 1, \
 	.pathname = 1, \
 	.max_depth = -1, \
-	.pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED, \
 	.colors = { \
 		[GREP_COLOR_CONTEXT] = "", \
 		[GREP_COLOR_FILENAME] = GIT_COLOR_MAGENTA, \
-- 
2.35.0.rc1.864.g57621b115b6

