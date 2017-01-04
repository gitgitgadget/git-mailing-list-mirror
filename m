Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78E1720756
	for <e@80x24.org>; Wed,  4 Jan 2017 18:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965819AbdADSEy (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 13:04:54 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35897 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761460AbdADSEg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 13:04:36 -0500
Received: by mail-pf0-f181.google.com with SMTP id 189so83386460pfz.3
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 10:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B0mlUDb0zoOgbsKbhDPWH624yW1/9ZH9jLKPxLQKpAg=;
        b=Q7tzV8XI7uqzhKDirrQnqLbspRS4KXkYkBaNqeC85Kr7GspSdzNJxmzn8mDqFdNuZi
         dF0pamDZh9JQVPcsBPCreod1yxV6awKGXP0UFUMOa4rIL2wi3SAHcV8/XlgCjHZVSCQT
         AIgOPpLXVC/okQxcNMKRGj98G/ncVKPdZspdouomw4SDvc5+tn4XY1KRS8m+n40lwX0S
         kA3MPXp+JXEj/mKiBzw+lQBHLSUyU/L9dgPE63X+8OQvjYDCvSK9Ice1THgFesC93/NV
         hHM37dpZlxRiMEvngR/+8DNaiEEYb6SfOILUG/K+PNNjy3FYysBeL2w7zMwR78ziv5Ap
         upGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B0mlUDb0zoOgbsKbhDPWH624yW1/9ZH9jLKPxLQKpAg=;
        b=E0igsNekmNzBPlnOh02w290XfNQxB/Y4AKtSuiHIhRXowdmU9aJ0WTmeA36idHYXmc
         oYzbT0p4+oxs2ARKmA3jyrqwAWLvbGprIBEWVBQjJgyX245zNxGr+Q5dggc0SqDlikMG
         CoHauulBvLkThlNI3JaEzi4lbaomgWbKsQ/yfnxQ1LAJjwXOXHI1icWzHRI8xZo25uFE
         5xKDP7TF/lvTeoHhcYTxI5jkzGsffzntSKZJ3NUdy+YCLN3HbQAc7I7WrhEaX0jZ627E
         REWWWiCYxlzVad9gGfUJ54QhFNXjIa+e4bzRnH9bDSg7zRK6nHXru2ci7bDqFyysqnJ6
         v55g==
X-Gm-Message-State: AIkVDXIE8BtCT4hJYnOfCnsltvr7m+scVPr620I+hDvAAQaDgz6R0OeOEzW/taEBKHsSEcSE
X-Received: by 10.98.72.129 with SMTP id q1mr63394114pfi.169.1483553075439;
        Wed, 04 Jan 2017 10:04:35 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id o68sm148337150pfb.42.2017.01.04.10.04.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jan 2017 10:04:34 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v5 11/16] pathspec: create parse_short_magic function
Date:   Wed,  4 Jan 2017 10:04:06 -0800
Message-Id: <20170104180411.150000-12-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170104180411.150000-1-bmwill@google.com>
References: <20170103184241.128409-1-bmwill@google.com>
 <20170104180411.150000-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor out the logic responsible for parsing short magic into its own
function.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pathspec.c | 54 ++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 77df55da6..1b0901848 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -157,6 +157,41 @@ static int get_global_magic(int element_magic)
 }
 
 /*
+ * Parse the pathspec element looking for short magic
+ *
+ * saves all magic in 'magic'
+ * returns the position in 'elem' after all magic has been parsed
+ */
+static const char *parse_short_magic(unsigned *magic, const char *elem)
+{
+	const char *pos;
+
+	for (pos = elem + 1; *pos && *pos != ':'; pos++) {
+		char ch = *pos;
+		int i;
+
+		if (!is_pathspec_magic(ch))
+			break;
+
+		for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
+			if (pathspec_magic[i].mnemonic == ch) {
+				*magic |= pathspec_magic[i].bit;
+				break;
+			}
+		}
+
+		if (ARRAY_SIZE(pathspec_magic) <= i)
+			die(_("Unimplemented pathspec magic '%c' in '%s'"),
+			    ch, elem);
+	}
+
+	if (*pos == ':')
+		pos++;
+
+	return pos;
+}
+
+/*
  * Take an element of a pathspec and check for magic signatures.
  * Append the result to the prefix. Return the magic bitmap.
  *
@@ -220,24 +255,7 @@ static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
 		copyfrom++;
 	} else {
 		/* shorthand */
-		for (copyfrom = elt + 1;
-		     *copyfrom && *copyfrom != ':';
-		     copyfrom++) {
-			char ch = *copyfrom;
-
-			if (!is_pathspec_magic(ch))
-				break;
-			for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++)
-				if (pathspec_magic[i].mnemonic == ch) {
-					element_magic |= pathspec_magic[i].bit;
-					break;
-				}
-			if (ARRAY_SIZE(pathspec_magic) <= i)
-				die(_("Unimplemented pathspec magic '%c' in '%s'"),
-				    ch, elt);
-		}
-		if (*copyfrom == ':')
-			copyfrom++;
+		copyfrom = parse_short_magic(&element_magic, elt);
 	}
 
 	magic |= element_magic;
-- 
2.11.0.390.gc69c2f50cf-goog

