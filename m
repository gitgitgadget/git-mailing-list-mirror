Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43D6E8FDB3
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 20:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241100AbjJCUzt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 16:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241091AbjJCUzs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 16:55:48 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42BCAB
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 13:55:43 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3247d69ed2cso1416417f8f.0
        for <git@vger.kernel.org>; Tue, 03 Oct 2023 13:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696366542; x=1696971342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Qyi2YiFyKIkoJDv/HVA774MkrfXAnkcE6ASof/Q4wo=;
        b=d4IYZcvrwi1InU6HfuRDhJflmLtZZTS7LO3zmV9T9PqVYYQda+4t8EWbJ6RobP7Rta
         osMi2NB/Dk3VL83DWZ39JqzjzsQ/IClpTJ42s2mULLYzkt0FMJSo1FlZOvW6d0oojJjW
         SaYmRUhflzfBRsIRywILFZbSVRhs+7Hbgvbl6HEhnHV6vdVfy7eYGqxOxNCxDDnAA+b1
         tLtqeMpfGy6ByYoHpnSGxvqdS6evYrNGtVHSDYZyXxCDU13127tmy8m/GKOmdA71FdSL
         s3QxiQ/8/jhOaS78JMR3V5/4n1a3tYK9neAaMMVhl7BHDg3n19aH0Ky1ZNrqOHV7egMM
         9Zuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696366542; x=1696971342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Qyi2YiFyKIkoJDv/HVA774MkrfXAnkcE6ASof/Q4wo=;
        b=GKm3YCcYrBjbbwkOTD/iyjpm0wdyvEy3rPvpZZY8N10FnFwKJ6uTgTlPv3Td3PkvF2
         bUdvn3jUhjFG7M5hM2DIWiXXZ2YFtcXLLyu2WnXlrg3CoP5OOVpbewQgytwxxxEQl+PU
         RVSK152K0W3tiEpkbpkgpWFQ77oGmjv6oFGrIQyDvfimV/u+/RrdDB1VDBkWTwXWYdb3
         jIzlzV80c73w9YMg5Ol2h+NevR1kGGWmg131YJbRCX5UuXFN4YPJXZzRP2pAacqGKDbb
         kpeLlkkauV2W0t3a0nQccjbAr3eCVm+/Y7UZKHtnc3FHSSAJ0YenWLfWBM3CeyXTxCn9
         nZAQ==
X-Gm-Message-State: AOJu0Yy9CikoJdRbv3w2byR8hEJ2riADNrfp6It9ePXc8JBqtq8sO+Ks
        ZabhW2NcLrKP+QzNPeC0rigoeWDWlrDtqw==
X-Google-Smtp-Source: AGHT+IHUj8AxfPRjFn9YFmG8Q8LryAuwOfsz7qLNevhjFuvi1XP2aeAsA+YMj8u9ZpRMzrPqT6VA1g==
X-Received: by 2002:a05:6000:104a:b0:31a:d2f9:7372 with SMTP id c10-20020a056000104a00b0031ad2f97372mr337197wrx.29.1696366541894;
        Tue, 03 Oct 2023 13:55:41 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id g10-20020adfe40a000000b0030ae53550f5sm2355517wrm.51.2023.10.03.13.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 13:55:41 -0700 (PDT)
From:   Andy Koppe <andy.koppe@gmail.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH] decorate: add color.decorate.symbols config option
Date:   Tue,  3 Oct 2023 21:54:42 +0100
Message-ID: <20231003205442.22963-1-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add new 'color.decorate.symbols' config option for determining the color
of the prefix, suffix, separator and arrow symbols used in --decorate
output and related log format placeholders, to allow them to be colored
differently from commit hashes.

For backward compatibility, fall back to the commit hash color that can
be specified with the 'color.diff.commit' option if the new option is
not provided.

Add the setting to the color.decorate.<slot> documentation, rewording
that a bit to try to improve readability.

Amend t4207-log-decoration-colors.sh to test the option.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 Documentation/config/color.txt   |  7 ++--
 commit.h                         |  1 +
 log-tree.c                       | 15 ++++++---
 t/t4207-log-decoration-colors.sh | 58 +++++++++++++++++---------------
 4 files changed, 45 insertions(+), 36 deletions(-)

diff --git a/Documentation/config/color.txt b/Documentation/config/color.txt
index 1795b2d16b..5d3612ff09 100644
--- a/Documentation/config/color.txt
+++ b/Documentation/config/color.txt
@@ -75,9 +75,10 @@ color.diff.<slot>::
 
 color.decorate.<slot>::
 	Use customized color for 'git log --decorate' output.  `<slot>` is one
-	of `branch`, `remoteBranch`, `tag`, `stash` or `HEAD` for local
-	branches, remote-tracking branches, tags, stash and HEAD, respectively
-	and `grafted` for grafted commits.
+	of `HEAD` for the current HEAD ref, `branch` for local branches,
+	`remoteBranch` for remote-tracking branches, `tag` for tags, `stash`
+	for the top stash entry, `grafted` for grafted commits, and `symbols`
+	for the punctuation surrounding the other elements.
 
 color.grep::
 	When set to `always`, always highlight matches.  When `false` (or
diff --git a/commit.h b/commit.h
index 28928833c5..cefcb7c490 100644
--- a/commit.h
+++ b/commit.h
@@ -56,6 +56,7 @@ enum decoration_type {
 	DECORATION_REF_STASH,
 	DECORATION_REF_HEAD,
 	DECORATION_GRAFTED,
+	DECORATION_SYMBOLS,
 };
 
 void add_name_decoration(enum decoration_type type, const char *name, struct object *obj);
diff --git a/log-tree.c b/log-tree.c
index 504da6b519..a5dd4292fc 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -41,6 +41,7 @@ static char decoration_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_BOLD_MAGENTA,	/* REF_STASH */
 	GIT_COLOR_BOLD_CYAN,	/* REF_HEAD */
 	GIT_COLOR_BOLD_BLUE,	/* GRAFTED */
+	GIT_COLOR_NIL,		/* SYMBOLS */
 };
 
 static const char *color_decorate_slots[] = {
@@ -50,6 +51,7 @@ static const char *color_decorate_slots[] = {
 	[DECORATION_REF_STASH]	= "stash",
 	[DECORATION_REF_HEAD]	= "HEAD",
 	[DECORATION_GRAFTED]	= "grafted",
+	[DECORATION_SYMBOLS]	= "symbols",
 };
 
 static const char *decorate_get_color(int decorate_use_color, enum decoration_type ix)
@@ -312,7 +314,7 @@ void format_decorations(struct strbuf *sb,
 {
 	const struct name_decoration *decoration;
 	const struct name_decoration *current_and_HEAD;
-	const char *color_commit, *color_reset;
+	const char *color_symbols, *color_reset;
 
 	const char *prefix = " (";
 	const char *suffix = ")";
@@ -337,7 +339,10 @@ void format_decorations(struct strbuf *sb,
 			tag = opts->tag;
 	}
 
-	color_commit = diff_get_color(use_color, DIFF_COMMIT);
+	color_symbols = decorate_get_color(use_color, DECORATION_SYMBOLS);
+	if (color_is_nil(color_symbols))
+		color_symbols = diff_get_color(use_color, DIFF_COMMIT);
+
 	color_reset = decorate_get_color(use_color, DECORATION_NONE);
 
 	current_and_HEAD = current_pointed_by_HEAD(decoration);
@@ -352,7 +357,7 @@ void format_decorations(struct strbuf *sb,
 				decorate_get_color(use_color, decoration->type);
 
 			if (*prefix) {
-				strbuf_addstr(sb, color_commit);
+				strbuf_addstr(sb, color_symbols);
 				strbuf_addstr(sb, prefix);
 				strbuf_addstr(sb, color_reset);
 			}
@@ -369,7 +374,7 @@ void format_decorations(struct strbuf *sb,
 
 			if (current_and_HEAD &&
 			    decoration->type == DECORATION_REF_HEAD) {
-				strbuf_addstr(sb, color_commit);
+				strbuf_addstr(sb, color_symbols);
 				strbuf_addstr(sb, pointer);
 				strbuf_addstr(sb, color_reset);
 				strbuf_addstr(sb, decorate_get_color(use_color, current_and_HEAD->type));
@@ -382,7 +387,7 @@ void format_decorations(struct strbuf *sb,
 		decoration = decoration->next;
 	}
 	if (*suffix) {
-		strbuf_addstr(sb, color_commit);
+		strbuf_addstr(sb, color_symbols);
 		strbuf_addstr(sb, suffix);
 		strbuf_addstr(sb, color_reset);
 	}
diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
index 21986a866d..663ae49d34 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -18,6 +18,7 @@ test_expect_success setup '
 	git config color.decorate.tag "reverse bold yellow" &&
 	git config color.decorate.stash magenta &&
 	git config color.decorate.grafted black &&
+	git config color.decorate.symbols white &&
 	git config color.decorate.HEAD cyan &&
 
 	c_reset="<RESET>" &&
@@ -29,6 +30,7 @@ test_expect_success setup '
 	c_stash="<MAGENTA>" &&
 	c_HEAD="<CYAN>" &&
 	c_grafted="<BLACK>" &&
+	c_symbols="<WHITE>" &&
 
 	test_commit A &&
 	git clone . other &&
@@ -53,17 +55,17 @@ cmp_filtered_decorations () {
 # to this test since it does not contain any decoration, hence --first-parent
 test_expect_success 'commit decorations colored correctly' '
 	cat >expect <<-EOF &&
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD${c_reset}\
-${c_commit} -> ${c_reset}${c_branch}main${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: ${c_reset}${c_tag}v1.0${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: ${c_reset}${c_tag}B${c_reset}${c_commit})${c_reset} B
-${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
-${c_tag}tag: ${c_reset}${c_tag}A1${c_reset}${c_commit}, \
-${c_reset}${c_remoteBranch}other/main${c_reset}${c_commit})${c_reset} A1
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
-${c_stash}refs/stash${c_reset}${c_commit})${c_reset} On main: Changes to A.t
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
-${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_commit})${c_reset} A
+	${c_commit}COMMIT_ID${c_reset}${c_symbols} (${c_reset}${c_HEAD}HEAD${c_reset}\
+${c_symbols} -> ${c_reset}${c_branch}main${c_reset}${c_symbols}, \
+${c_reset}${c_tag}tag: ${c_reset}${c_tag}v1.0${c_reset}${c_symbols}, \
+${c_reset}${c_tag}tag: ${c_reset}${c_tag}B${c_reset}${c_symbols})${c_reset} B
+${c_commit}COMMIT_ID${c_reset}${c_symbols} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}A1${c_reset}${c_symbols}, \
+${c_reset}${c_remoteBranch}other/main${c_reset}${c_symbols})${c_reset} A1
+	${c_commit}COMMIT_ID${c_reset}${c_symbols} (${c_reset}\
+${c_stash}refs/stash${c_reset}${c_symbols})${c_reset} On main: Changes to A.t
+	${c_commit}COMMIT_ID${c_reset}${c_symbols} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_symbols})${c_reset} A
 	EOF
 
 	git log --first-parent --no-abbrev --decorate --oneline --color=always --all >actual &&
@@ -78,14 +80,14 @@ test_expect_success 'test coloring with replace-objects' '
 	git replace HEAD~1 HEAD~2 &&
 
 	cat >expect <<-EOF &&
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD${c_reset}\
-${c_commit} -> ${c_reset}${c_branch}main${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: ${c_reset}${c_tag}D${c_reset}${c_commit})${c_reset} D
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
-${c_tag}tag: ${c_reset}${c_tag}C${c_reset}${c_commit}, \
-${c_reset}${c_grafted}replaced${c_reset}${c_commit})${c_reset} B
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
-${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_commit})${c_reset} A
+	${c_commit}COMMIT_ID${c_reset}${c_symbols} (${c_reset}${c_HEAD}HEAD${c_reset}\
+${c_symbols} -> ${c_reset}${c_branch}main${c_reset}${c_symbols}, \
+${c_reset}${c_tag}tag: ${c_reset}${c_tag}D${c_reset}${c_symbols})${c_reset} D
+	${c_commit}COMMIT_ID${c_reset}${c_symbols} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}C${c_reset}${c_symbols}, \
+${c_reset}${c_grafted}replaced${c_reset}${c_symbols})${c_reset} B
+	${c_commit}COMMIT_ID${c_reset}${c_symbols} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_symbols})${c_reset} A
 EOF
 
 	git log --first-parent --no-abbrev --decorate --oneline --color=always HEAD >actual &&
@@ -104,15 +106,15 @@ test_expect_success 'test coloring with grafted commit' '
 	git replace --graft HEAD HEAD~2 &&
 
 	cat >expect <<-EOF &&
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD${c_reset}\
-${c_commit} -> ${c_reset}${c_branch}main${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: ${c_reset}${c_tag}D${c_reset}${c_commit}, \
-${c_reset}${c_grafted}replaced${c_reset}${c_commit})${c_reset} D
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
-${c_tag}tag: ${c_reset}${c_tag}v1.0${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: ${c_reset}${c_tag}B${c_reset}${c_commit})${c_reset} B
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
-${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_commit})${c_reset} A
+	${c_commit}COMMIT_ID${c_reset}${c_symbols} (${c_reset}${c_HEAD}HEAD${c_reset}\
+${c_symbols} -> ${c_reset}${c_branch}main${c_reset}${c_symbols}, \
+${c_reset}${c_tag}tag: ${c_reset}${c_tag}D${c_reset}${c_symbols}, \
+${c_reset}${c_grafted}replaced${c_reset}${c_symbols})${c_reset} D
+	${c_commit}COMMIT_ID${c_reset}${c_symbols} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}v1.0${c_reset}${c_symbols}, \
+${c_reset}${c_tag}tag: ${c_reset}${c_tag}B${c_reset}${c_symbols})${c_reset} B
+	${c_commit}COMMIT_ID${c_reset}${c_symbols} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_symbols})${c_reset} A
 	EOF
 
 	git log --first-parent --no-abbrev --decorate --oneline --color=always HEAD >actual &&
-- 
2.42.GIT

