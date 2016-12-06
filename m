Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B2A620259
	for <e@80x24.org>; Tue,  6 Dec 2016 21:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbcLFVxk (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 16:53:40 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35202 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751888AbcLFVxN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 16:53:13 -0500
Received: by mail-pf0-f169.google.com with SMTP id i88so72195251pfk.2
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 13:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DIxtqqUZUjg3vs+zqaj7kbDRsbC6XzarbouGMDyMnWA=;
        b=JiCrY4fOElZ1XmlRSE3MrKshGUIGv16gLIryz13Lta9FAvDaeA+hu64/AM33KLOcm+
         hWzx5+Ux9MReOVMPyNaxU2btpHTsxm72KuVmEAweojfwV/M2VGiHNaVu6I6UhYmQiZuV
         AS2OeOmdsA4e2wMyNt1LJCI28ilTAwzp/fh4vsbxQpl6N1Rwio3fXap4bD0ruiEDGZul
         trK7S0380aL5FRzLuI6kiqTi1AUr5T9FyE7iQLe/sCVsm37MXoOX1NNceGwIXrT9ogZj
         cU+a/mN+olMQ4AEpo/RqPZiZ6VerQTBbPiPSNDi2R1jTLkYffZCRZJeaQ5tcormbXwQS
         C/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DIxtqqUZUjg3vs+zqaj7kbDRsbC6XzarbouGMDyMnWA=;
        b=fXSK7c61Op0Eqb2B7CNMDAH4egYL3vwMXwLjU8YefNt31QG7cTngEnZJNU0QIZHZ4i
         r5O0CLW/4HnRhC+rIsEZfqwaVyUEFc4vLHe41YMotEWYLLpJ5jK6NweaEauwfIUefn37
         j/C/pi/D08MPxx7I3Hj2dyciTxUlXiVS5TWDArA6jNej8rY0dsYPVNRBvTzGsti14P0E
         I9m376C/vwx2PQQ3xhowkvQ6NNVYM1WA+sTYi2DNYM4oMZ7DlhKXxlZ6pzkXBYNInGzF
         7l4PpxGFzH3j/gfLgm0+aI3vD7TbvmqOeKPOho5XXXRSqSu6MhtVh77+jbl6AGdFwK8L
         yiWw==
X-Gm-Message-State: AKaTC02TA9u07brHtMudk+Eb9dhYKh9EF8O0T6KWhiQ1InllP692cyVyk/BDFTXs76oaxpkR
X-Received: by 10.84.210.233 with SMTP id a96mr140719572pli.118.1481061151886;
        Tue, 06 Dec 2016 13:52:31 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id y89sm36940228pfk.83.2016.12.06.13.52.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Dec 2016 13:52:30 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 11/17] pathspec: factor global magic into its own function
Date:   Tue,  6 Dec 2016 13:51:40 -0800
Message-Id: <1481061106-117775-12-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481061106-117775-1-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create helper functions to read the global magic environment variables
in additon to factoring out the global magic gathering logic into its
own function.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pathspec.c | 120 +++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 74 insertions(+), 46 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 5afebd3..08e76f6 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -87,6 +87,74 @@ static void prefix_magic(struct strbuf *sb, int prefixlen, unsigned magic)
 	strbuf_addf(sb, ",prefix:%d)", prefixlen);
 }
 
+static inline int get_literal_global(void)
+{
+	static int literal_global = -1;
+
+	if (literal_global < 0)
+		literal_global = git_env_bool(GIT_LITERAL_PATHSPECS_ENVIRONMENT,
+					      0);
+	return literal_global;
+}
+
+static inline int get_glob_global(void)
+{
+	static int glob_global = -1;
+
+	if (glob_global < 0)
+		glob_global = git_env_bool(GIT_GLOB_PATHSPECS_ENVIRONMENT, 0);
+	return glob_global;
+}
+
+static inline int get_noglob_global(void)
+{
+	static int noglob_global = -1;
+
+	if (noglob_global < 0)
+		noglob_global = git_env_bool(GIT_NOGLOB_PATHSPECS_ENVIRONMENT,
+					     0);
+	return noglob_global;
+}
+
+static inline int get_icase_global(void)
+{
+	static int icase_global = -1;
+
+	if (icase_global < 0)
+		icase_global = git_env_bool(GIT_ICASE_PATHSPECS_ENVIRONMENT, 0);
+
+	return icase_global;
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
@@ -105,46 +173,12 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
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
@@ -208,15 +242,9 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 
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
+	if (!(flags & PATHSPEC_LITERAL_PATH))
+		magic |= get_global_magic(element_magic);
 
 	if (pathspec_prefix >= 0 &&
 	    (prefixlen || (prefix && *prefix)))
@@ -242,7 +270,7 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 	 * original. Useful for passing to another command.
 	 */
 	if ((flags & PATHSPEC_PREFIX_ORIGIN) &&
-	    prefixlen && !literal_global) {
+	    prefixlen && !get_literal_global()) {
 		struct strbuf sb = STRBUF_INIT;
 
 		/* Preserve the actual prefix length of each pattern */
-- 
2.8.0.rc3.226.g39d4020

