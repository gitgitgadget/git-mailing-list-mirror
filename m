Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B58AD1FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 18:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760600AbdACSt0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 13:49:26 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33548 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758252AbdACStY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 13:49:24 -0500
Received: by mail-pf0-f171.google.com with SMTP id d2so78142872pfd.0
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 10:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HO+FhJ+mOtedOH3yWkZsjzYm0VNLeBDnQb70IMagobA=;
        b=RaFKMeDSm3YVt7sLhU5g5i3SNZGFjcKRUASHzRJx8TzhaIEBwdA3ZWnms2x6hLIN9L
         0lEEmYn+B8bCD5W1QCy9uevT5EpBLuKEKmFhvjZ/NsS1G5A8VZcohHJPXzThJTjw/pe8
         s39X/6Y7APpmWv8U8If++D/grTlhqu+wADRUwBqt8w4a14X9kpWCHfflrF/B3odx4yv7
         5Osz3xLS08DWI5b8JjmenZn5oyW13DabRjBbdKuchTiDZbpN/1vZwIpd3WjQIY+XcOGM
         AvuEGO7bfdW7UAz62zozEYWM84L21GUZ2U4yEXjw/7znO570oXlYHqKljrCfmN+Er6Bf
         gn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HO+FhJ+mOtedOH3yWkZsjzYm0VNLeBDnQb70IMagobA=;
        b=iEuIU7TxHwWdCsqF0a0wpGUzJc7l9ktaP3nQ1CeF/ZbozUviRd573K/t8OaJ6siODw
         Xm59zXoxfann2t66mWWY07bwbEotAqHEyGLp0ejIH0Ij4aXMiJ7Ek8CxmDUhwXIjfU85
         8C33Rg8Udo/EHoX7LJsBi1zzkaOV6U2Peq/Tz+FkD7aCM3FvpnsUT9VDWbcJG8710vGo
         tsxSpVnDenPacI9no7fLiycBA42hi+Iq5uyWM+SBHTjm0XC+ZKrF0hGDVySUhql39u1f
         8nCccO23Tz2L1+yd5hv2HGkgbvTKwPbJVPErh5Im0CZ1dIVngYc6Y51NSBPY0h/HgJdy
         jCzg==
X-Gm-Message-State: AIkVDXLUhxhn9RX+wMiLRqNChopRiHDWVPTYsbD53DPOkPXxQIjaKG0AihejvIEeh/iDDfrZ
X-Received: by 10.84.213.23 with SMTP id f23mr137196750pli.59.1483468993990;
        Tue, 03 Jan 2017 10:43:13 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id e5sm141421338pfd.77.2017.01.03.10.43.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jan 2017 10:43:13 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v4 10/16] pathspec: factor global magic into its own function
Date:   Tue,  3 Jan 2017 10:42:35 -0800
Message-Id: <20170103184241.128409-11-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170103184241.128409-1-bmwill@google.com>
References: <1481670870-66754-1-git-send-email-bmwill@google.com>
 <20170103184241.128409-1-bmwill@google.com>
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
index 032436bc1..f760f44f9 100644
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

