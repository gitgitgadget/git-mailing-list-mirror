Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D093520754
	for <e@80x24.org>; Wed,  4 Jan 2017 18:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761472AbdADSFj (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 13:05:39 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34130 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761451AbdADSEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 13:04:25 -0500
Received: by mail-pf0-f181.google.com with SMTP id 127so3486776pfg.1
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 10:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1aM6tTs3WJhlduRar9DOocwYwfdre0Ej0s67EMZYShg=;
        b=TKn1Oeh9LYkwWWGXWgezGI0v8zkVO6pL9LLFAImawd70Lqh19M+ZB4k4ICjhAkrn3H
         1lJQLLo7GHyBnJFcu2u0SS5GcTxJiMeRPkoZmADOesJFWi14UjIAbyidvAsFIkuldtpW
         9n7AquO/hpjC/D8aQ9acxF7WMGgA/I1DLHncMtIhmLykvgL/K79nNBLaoq/KplbYW+YB
         7J14d4pq0Ohru2vYHGO1IJCQ33tM4HpuQoFd9KGEgwmvAUWMQL3EFSIFsxDqdkpe8G6U
         /BZCUYbI/CKB9oH60xhtoy1IVTPPBXlMOp9I7lx31IHk/ncBjBO55lMhAyny3Hw147AH
         7CJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1aM6tTs3WJhlduRar9DOocwYwfdre0Ej0s67EMZYShg=;
        b=FSk7bRjD2eE7hWOCp/HI+I7AhY0fYGeKC1gdGmShp8mMeZ7xQtg6pCNTtBr3cUDs0+
         LmkB7uNkqJAt30pLd1Q7oxDIbnlo1nTWDjv7wLVl5VpYgZNpmXOIQJcN0O1ChPhW+NbR
         E9ZYiIdIf/nlc4Fgu5gyJd+s9jEJ86PruGmL5KNEwTreLLiFOqmZxrEzl6t9h1Y7FHg8
         vc0c9zeYdNNLSggfotek90Ue6Zj92r7XlX3TE2AHcjOtYNPg5cTz58TgP8OMZLb5IO3I
         hCjrfOxIos/1QEFHSASqv6baUEfCfNjUtW5Z2tNpIc0uTyBF7/WphPfDaHqbZnLmPHT5
         Lxtg==
X-Gm-Message-State: AIkVDXIeYHlD2GndXfUtC7GpFA7JDlrJFnTPsPF0z4x0ZItPL5C31TWA8P5DKqcPB+DMryIU
X-Received: by 10.98.21.148 with SMTP id 142mr62378018pfv.38.1483553064747;
        Wed, 04 Jan 2017 10:04:24 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id o68sm148337150pfb.42.2017.01.04.10.04.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jan 2017 10:04:23 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v5 04/16] ls-tree: convert show_recursive to use the pathspec struct interface
Date:   Wed,  4 Jan 2017 10:03:59 -0800
Message-Id: <20170104180411.150000-5-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170104180411.150000-1-bmwill@google.com>
References: <20170103184241.128409-1-bmwill@google.com>
 <20170104180411.150000-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'show_recursive()' to use the pathspec struct interface from
using the '_raw' entry in the pathspec struct.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-tree.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 0e30d8623..d7ebeb4ce 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -31,21 +31,18 @@ static const  char * const ls_tree_usage[] = {
 
 static int show_recursive(const char *base, int baselen, const char *pathname)
 {
-	const char **s;
+	int i;
 
 	if (ls_options & LS_RECURSIVE)
 		return 1;
 
-	s = pathspec._raw;
-	if (!s)
+	if (!pathspec.nr)
 		return 0;
 
-	for (;;) {
-		const char *spec = *s++;
+	for (i = 0; i < pathspec.nr; i++) {
+		const char *spec = pathspec.items[i].match;
 		int len, speclen;
 
-		if (!spec)
-			return 0;
 		if (strncmp(base, spec, baselen))
 			continue;
 		len = strlen(pathname);
@@ -59,6 +56,7 @@ static int show_recursive(const char *base, int baselen, const char *pathname)
 			continue;
 		return 1;
 	}
+	return 0;
 }
 
 static int show_tree(const unsigned char *sha1, struct strbuf *base,
@@ -175,8 +173,8 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	 * cannot be lifted until it is converted to use
 	 * match_pathspec() or tree_entry_interesting()
 	 */
-	parse_pathspec(&pathspec, PATHSPEC_GLOB | PATHSPEC_ICASE |
-				  PATHSPEC_EXCLUDE,
+	parse_pathspec(&pathspec, PATHSPEC_ALL_MAGIC &
+				  ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
 		       PATHSPEC_PREFER_CWD,
 		       prefix, argv + 1);
 	for (i = 0; i < pathspec.nr; i++)
-- 
2.11.0.390.gc69c2f50cf-goog

