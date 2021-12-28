Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0BDC433FE
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 01:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbhL1BID (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 20:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234354AbhL1BH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 20:07:58 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECCAC06175F
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 17:07:56 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id v10-20020a05600c214a00b00345e59928eeso5306830wml.0
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 17:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vP9YKT4qZ0tpYS+gOuDDJtVIBjxyEeeWjytBoFhMdn8=;
        b=cno6A37QxPHB88NzdAlD5o5M95HayEabNx1JOJBNfRrG+vPZWmneKYL+AlBojP9o1E
         5+Q8p3pxUQISeQAIhdj1wOI5LStFA7XGBjqPKlJ5pVBg94yYvNyn4u0BrVoqu8jYZKOJ
         9SuMD9LmxJZGeKo3+4WtIeo65BjfUWK1Zlm/sELrvph1cQcaElXplIpqkpqtUrkIC29U
         YulMiTc10R6egIS54W1XB2dCLk2Nukw9+OQiWhFe+SVVWFly09shZBl6lQ1ARcgt5z1u
         qJEJ/0+CBPNkRMeaQm9cicVhAw+X0MP6uufCFrB8pvEzEEp3EAsre1gFS4vlGvc24Pyy
         dlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vP9YKT4qZ0tpYS+gOuDDJtVIBjxyEeeWjytBoFhMdn8=;
        b=Y7S7TkB9rs9LsnPOK/WshK2UeerFXNQprkvyxPr6IU5kooHColpOPskmjvEiDyI3Cd
         B3lrGz1rObuUd5BTDhGyqIUZ14J0Mfwb8K7YAk7LLfycVH5VjwtPFFnUf0s1n5jnE6gb
         LLOBc4Cx6e6F8YFnUWDHJiibFhE+Ao0yGTtDN+j0zX27JpYMzZzMWviGsFFNdbyZCdS2
         24VIdbxof+Rr20aiGjXvkUH/J4Kq1vusqWurLPaQ43IBDoU8n3TVpgwryDlmop2g8KiX
         PcXziUM2zwZ1POaimLhyFjqNJaNKKLHgWr6X7wJOi4BfVgbBwVRiICU4yc119YPwSS2v
         n61g==
X-Gm-Message-State: AOAM533KLMzMny5sRxvNN7AAw6BoULAow1QmU8gFLCO+WPwrAJlAzYI9
        2jIOcOLmLgR8iXAHgdZY0gHQiDljcSXvvWKX
X-Google-Smtp-Source: ABdhPJzqh3oypLu5w2jMisyDgh35UfXI0dIijrlA5TtEEASVEgD5r+Eo8OjTvC7IyrepgyYxwzcCMg==
X-Received: by 2002:a05:600c:3d19:: with SMTP id bh25mr15358490wmb.186.1640653675301;
        Mon, 27 Dec 2021 17:07:55 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b197sm16910973wmb.24.2021.12.27.17.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 17:07:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 10/10] grep.[ch]: remove GREP_PATTERN_TYPE_UNSPECIFIED
Date:   Tue, 28 Dec 2021 02:07:45 +0100
Message-Id: <patch-v7-10.10-b764c09d2b7-20211228T004707Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1250.g6a242c1e9ad
In-Reply-To: <cover-v7-00.10-00000000000-20211228T004707Z-avarab@gmail.com>
References: <cover-v6-0.7-00000000000-20211226T223035Z-avarab@gmail.com> <cover-v7-00.10-00000000000-20211228T004707Z-avarab@gmail.com>
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
index a6712adbce7..914eb5dee9b 100644
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
index 32ff4dad3de..e365b689287 100644
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
@@ -178,7 +177,6 @@ struct grep_opt {
 	.relative = 1, \
 	.pathname = 1, \
 	.max_depth = -1, \
-	.pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED, \
 	.colors = { \
 		[GREP_COLOR_CONTEXT] = "", \
 		[GREP_COLOR_FILENAME] = "", \
-- 
2.34.1.1250.g6a242c1e9ad

