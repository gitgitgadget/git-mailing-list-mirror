Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F24C720754
	for <e@80x24.org>; Wed,  4 Jan 2017 18:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965766AbdADSEz (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 13:04:55 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35358 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761462AbdADSEe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 13:04:34 -0500
Received: by mail-pg0-f42.google.com with SMTP id i5so164988620pgh.2
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 10:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yz+Jr7/Red4IW/xfYSDnEfH3gOc0Nbw4Cvl9O11uLOg=;
        b=TjeWp6axIR+lAvtlqZTPpaTtDOpziOCHDOH4MtS2X3PD1INkL0LhHXQjYxjeq9Pwns
         +WJmGjtZ8YEE8KxH+4yCPXHYFcS+jWh9Tn2Vq6+Ew8o9JEsZWU9igYAeX18KmeRKx4kY
         1a4mtDcNpgc9HhsvKu/LXH/YNocuwjkH4KWxwZn/CZSPnoyrCFZ7OT1/7XoAIPD49xT1
         rGz7MeYm5ZX7sRBh7EIOrnenpItd91V+eT7FZxEMHtTCcVvPLo3Xcknaqfe9vr81rx4p
         MuTYGKcg3/X6RCDvECoJy6BNyeMwtQYvy5OZpyZkHEtRSDMD+GF+VZlKuked0PN2Gxep
         68sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yz+Jr7/Red4IW/xfYSDnEfH3gOc0Nbw4Cvl9O11uLOg=;
        b=AZG6VXDfrD9zRGWF7DRxKz5eRAQvoWhXSSeJYY3uw76NUTpxrUz210SS6/QA/elEUR
         PC0SR4UAK9pQvjn26eOH9IlhEUeB4f/H9ID+KPoyezNo4ejCY7hYfm7zp5f8XzRyLaoK
         HrlRDUoE7IKl1QH0RrwdVcRGxZaEGyaB0Uge01wakVP+ryQNyezKtBOgU0A3mYGge8Ip
         zRnNxg1LpiOIuynwhkTNw6jksnhxF7ZgKT1Z0jiTlMHS3ygk1ZsxCZD/bRVWFFgRDHn7
         CmtzYS/VuAFnEi/ONan3J38WThws19/Wl8OQ+v3tXE63WC7xgOT/e1hqdcOnjg6lX5oy
         Ppjg==
X-Gm-Message-State: AIkVDXKU4PRFEheoy8Or1wVuARFWl9W7JvaONnGxMpOX6uHKhc0GetYM7/ESe/8v1RkqwtWq
X-Received: by 10.98.208.70 with SMTP id p67mr64092189pfg.15.1483553073712;
        Wed, 04 Jan 2017 10:04:33 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id o68sm148337150pfb.42.2017.01.04.10.04.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jan 2017 10:04:32 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v5 10/16] pathspec: factor global magic into its own function
Date:   Wed,  4 Jan 2017 10:04:05 -0800
Message-Id: <20170104180411.150000-11-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170104180411.150000-1-bmwill@google.com>
References: <20170103184241.128409-1-bmwill@google.com>
 <20170104180411.150000-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create helper functions to read the global magic environment variables
in additon to factoring out the global magic gathering logic into its
own function.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pathspec.c | 127 +++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 78 insertions(+), 49 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index af7f2d01d..77df55da6 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -87,6 +87,75 @@ static void prefix_magic(struct strbuf *sb, int prefixlen, unsigned magic)
 	strbuf_addf(sb, ",prefix:%d)", prefixlen);
 }
 
+static inline int get_literal_global(void)
+{
+	static int literal = -1;
+
+	if (literal < 0)
+		literal = git_env_bool(GIT_LITERAL_PATHSPECS_ENVIRONMENT, 0);
+
+	return literal;
+}
+
+static inline int get_glob_global(void)
+{
+	static int glob = -1;
+
+	if (glob < 0)
+		glob = git_env_bool(GIT_GLOB_PATHSPECS_ENVIRONMENT, 0);
+
+	return glob;
+}
+
+static inline int get_noglob_global(void)
+{
+	static int noglob = -1;
+
+	if (noglob < 0)
+		noglob = git_env_bool(GIT_NOGLOB_PATHSPECS_ENVIRONMENT, 0);
+
+	return noglob;
+}
+
+static inline int get_icase_global(void)
+{
+	static int icase = -1;
+
+	if (icase < 0)
+		icase = git_env_bool(GIT_ICASE_PATHSPECS_ENVIRONMENT, 0);
+
+	return icase;
+}
+
+static int get_global_magic(int element_magic)
+{
+	int global_magic = 0;
+
+	if (get_literal_global())
+		global_magic |= PATHSPEC_LITERAL;
+
+	/* --glob-pathspec is overridden by :(literal) */
+	if (get_glob_global() && !(element_magic & PATHSPEC_LITERAL))
+		global_magic |= PATHSPEC_GLOB;
+
+	if (get_glob_global() && get_noglob_global())
+		die(_("global 'glob' and 'noglob' pathspec settings are incompatible"));
+
+	if (get_icase_global())
+		global_magic |= PATHSPEC_ICASE;
+
+	if ((global_magic & PATHSPEC_LITERAL) &&
+	    (global_magic & ~PATHSPEC_LITERAL))
+		die(_("global 'literal' pathspec setting is incompatible "
+		      "with all other global pathspec settings"));
+
+	/* --noglob-pathspec adds :(literal) _unless_ :(glob) is specified */
+	if (get_noglob_global() && !(element_magic & PATHSPEC_GLOB))
+		global_magic |= PATHSPEC_LITERAL;
+
+	return global_magic;
+}
+
 /*
  * Take an element of a pathspec and check for magic signatures.
  * Append the result to the prefix. Return the magic bitmap.
@@ -104,46 +173,12 @@ static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
 				const char *prefix, int prefixlen,
 				const char *elt)
 {
-	static int literal_global = -1;
-	static int glob_global = -1;
-	static int noglob_global = -1;
-	static int icase_global = -1;
-	unsigned magic = 0, element_magic = 0, global_magic = 0;
+	unsigned magic = 0, element_magic = 0;
 	const char *copyfrom = elt;
 	char *match;
 	int i, pathspec_prefix = -1;
 
-	if (literal_global < 0)
-		literal_global = git_env_bool(GIT_LITERAL_PATHSPECS_ENVIRONMENT, 0);
-	if (literal_global)
-		global_magic |= PATHSPEC_LITERAL;
-
-	if (glob_global < 0)
-		glob_global = git_env_bool(GIT_GLOB_PATHSPECS_ENVIRONMENT, 0);
-	if (glob_global)
-		global_magic |= PATHSPEC_GLOB;
-
-	if (noglob_global < 0)
-		noglob_global = git_env_bool(GIT_NOGLOB_PATHSPECS_ENVIRONMENT, 0);
-
-	if (glob_global && noglob_global)
-		die(_("global 'glob' and 'noglob' pathspec settings are incompatible"));
-
-
-	if (icase_global < 0)
-		icase_global = git_env_bool(GIT_ICASE_PATHSPECS_ENVIRONMENT, 0);
-	if (icase_global)
-		global_magic |= PATHSPEC_ICASE;
-
-	if ((global_magic & PATHSPEC_LITERAL) &&
-	    (global_magic & ~PATHSPEC_LITERAL))
-		die(_("global 'literal' pathspec setting is incompatible "
-		      "with all other global pathspec settings"));
-
-	if (flags & PATHSPEC_LITERAL_PATH)
-		global_magic = 0;
-
-	if (elt[0] != ':' || literal_global ||
+	if (elt[0] != ':' || get_literal_global() ||
 	    (flags & PATHSPEC_LITERAL_PATH)) {
 		; /* nothing to do */
 	} else if (elt[1] == '(') {
@@ -207,15 +242,11 @@ static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
 
 	magic |= element_magic;
 
-	/* --noglob-pathspec adds :(literal) _unless_ :(glob) is specified */
-	if (noglob_global && !(magic & PATHSPEC_GLOB))
-		global_magic |= PATHSPEC_LITERAL;
-
-	/* --glob-pathspec is overridden by :(literal) */
-	if ((global_magic & PATHSPEC_GLOB) && (magic & PATHSPEC_LITERAL))
-		global_magic &= ~PATHSPEC_GLOB;
-
-	magic |= global_magic;
+	/* PATHSPEC_LITERAL_PATH ignores magic */
+	if (flags & PATHSPEC_LITERAL_PATH)
+		magic = PATHSPEC_LITERAL;
+	else
+		magic |= get_global_magic(element_magic);
 
 	if (pathspec_prefix >= 0 &&
 	    (prefixlen || (prefix && *prefix)))
@@ -241,7 +272,7 @@ static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
 	 * original. Useful for passing to another command.
 	 */
 	if ((flags & PATHSPEC_PREFIX_ORIGIN) &&
-	    prefixlen && !literal_global) {
+	    prefixlen && !get_literal_global()) {
 		struct strbuf sb = STRBUF_INIT;
 
 		/* Preserve the actual prefix length of each pattern */
@@ -408,9 +439,7 @@ void parse_pathspec(struct pathspec *pathspec,
 
 		item[i].magic = prefix_pathspec(item + i, flags,
 						prefix, prefixlen, entry);
-		if ((flags & PATHSPEC_LITERAL_PATH) &&
-		    !(magic_mask & PATHSPEC_LITERAL))
-			item[i].magic |= PATHSPEC_LITERAL;
+
 		if (item[i].magic & PATHSPEC_EXCLUDE)
 			nr_exclude++;
 		if (item[i].magic & magic_mask)
-- 
2.11.0.390.gc69c2f50cf-goog

