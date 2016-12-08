Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB3671FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 18:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932270AbcLHS7k (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 13:59:40 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35752 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932140AbcLHS7j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 13:59:39 -0500
Received: by mail-pg0-f42.google.com with SMTP id p66so176767667pga.2
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 10:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kNERO8trZU0Zio27FDygK/+JY3Jl7jQJclJn2q8Q1hk=;
        b=XY91HmN66bg99QekCaFU+qUvH8NM0JlIknxqTS70ds1LT6MC74xvbI6VM2Un1yJVUD
         gB1+/FQU1KprgDfwm8bYvSSI0izveg6GNWgok0wrtVaPKm5w8zNMPynV0slmmHk7lT71
         O/melms//SQohZ44VqFNkEVYbZaXE/ckiliwVqm7D+dle2mC07UDd69NLAOI9qRyydE8
         F/8UXMx5K5kEhPWQYTqJeYoKNMD2gIsG2squOWFtT0OItQ6Ac8w2z4ujHScM8IKfdMzq
         lPnCuA6Xd/mAsu1V66GsRJMRnHJZqxZ3QXAzW2hv2BP+luJxpmMpRnUOAOMmqIyJBYTZ
         NGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kNERO8trZU0Zio27FDygK/+JY3Jl7jQJclJn2q8Q1hk=;
        b=g1YalMMHf5IozrDIdra9wlo1KNgY17aL+ZqGycuoLTmS2SkCoTeKUVAWL9wOE+EiQd
         N7cJuoCO/USa7AyU6/FMqATWEzTBPENoBzv6oQFwj+BydpVYcCfBu+BP4vtWi9oO1W6J
         fj3/9yZHaiAfe/nvVM+lVT0mw1nsAO7nsLmL0UN/mLdEaITO6FJInKXtkOXD+UkV24jl
         eOoVHXTZWmjwe4bY0T3ZJK4QXbajyWQQgUQBZbqgfRloJeGjnF9HpCpyzUKKwUYOf7xJ
         RzeERvb2UZSb4Ee/+h04/dLsHcCD+2dcJ3LZVflqEESw7giInrXEMGnkx2GAxidCuSmN
         yoNw==
X-Gm-Message-State: AKaTC01I31/XojoenPDqoQ4R8UZCGOJd1Z8Zgraj00ZAvek0z2cJP212Jxk1eI08zIfd/e16
X-Received: by 10.98.200.203 with SMTP id i72mr76398856pfk.181.1481223578436;
        Thu, 08 Dec 2016 10:59:38 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id p64sm51815634pfi.88.2016.12.08.10.59.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 10:59:37 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v2 10/16] pathspec: factor global magic into its own function
Date:   Thu,  8 Dec 2016 10:59:04 -0800
Message-Id: <1481223550-65277-11-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481223550-65277-1-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481223550-65277-1-git-send-email-bmwill@google.com>
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
index 49adea4..523d7bf 100644
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
@@ -407,9 +438,7 @@ void parse_pathspec(struct pathspec *pathspec,
 
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
2.8.0.rc3.226.g39d4020

