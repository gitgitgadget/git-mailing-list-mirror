Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 454E81F453
	for <e@80x24.org>; Sun, 27 Jan 2019 19:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfA0Tlm (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 14:41:42 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:47784 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfA0Tll (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 14:41:41 -0500
Received: by mail-pf1-f202.google.com with SMTP id m3so12369420pfj.14
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 11:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zEDGAhBnNEmeIfIQLormecozVD4IiiP9quqwE/o+Csw=;
        b=Ipaf8HUWjJz9bR0Nstj13pFAXU86xal2KVS+wf7OiwzDftyw64CuOU5PqiFCX8LmVL
         y+J5zUKnywUbszIBszVq4qeCrAONP/kWMpoK8eOrd3PkqLz6kRkmjLIbZ4jju51ABKgg
         Fbb2RCx8s/HD8ht6XWnPcF+q/SrfTSl8s/VkA5SV1nRUuIffwdM7vv/dOfhO6lwKO9k6
         zFrF2mJknWI5VqgM3cBStUDlelHFl3eKmS7u0v3YW/fOqmdD+7kGP62bBv46goBZqe73
         7tTZdGKrDWZqzxrN+YSaOxoqhf2fVlav4GME/Y/rIhowePJ0pqtIcvwuWimfsqsDl5FM
         ZjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zEDGAhBnNEmeIfIQLormecozVD4IiiP9quqwE/o+Csw=;
        b=UvJWp7fbiMeptCImoEMwMkH6yiqwqvabNAAQpS+fXX7u9PrDUa11un9EcUm1j0yq4s
         wAL4w8d+vjDu3W7I3JD4Wag+2lw6vgLLMbGHYl738s88HtWViZvAfZeK0Xjz2wSYP7gc
         LBAUzeXRSIFMulHbAjXph6EyA0swprOmfJlmMrz7HENADEen7Ti6vntpKiW0Hv6rAUU7
         vS2PyfBSuSqfORf4qTOo3HBTmifrNTx0xESxAlsH7TBHR4ieQpckhg1XbvtHtMv3zcj0
         bCsKqUfhxFgUGSeVrVQCELuJLza3ox8dsPdXQAtkm6+MNf6O/XsktCqHISoVQPdghzMD
         9tsg==
X-Gm-Message-State: AJcUukc28dHMh5VoxCBK+yUfmjWtaEdlNiov7rV7a5IfG+IepSy929G2
        l/czsLMrP4REMdRoNQU9r4mDCU4SksBBTzmkicpWyvW/MYR8iuPCQglsfN62mS0JI869dj3qveY
        AQvqFJEFeELdsIV6lEK8OSJYNLAO76HF0LoGSz8Fe7bdzS7w+RCgGb660RA==
X-Google-Smtp-Source: ALg8bN5bACFSWHnWzhSGgV1UR8Rg+ojqaqel9PAnx5QJrzX5SqOZK9vZ0vbvpKh+qXckesDzwTVtyAtr5xA=
X-Received: by 2002:a63:90c4:: with SMTP id a187mr8791780pge.31.1548618100389;
 Sun, 27 Jan 2019 11:41:40 -0800 (PST)
Date:   Sun, 27 Jan 2019 11:41:24 -0800
In-Reply-To: <20190127194128.161250-1-sxenos@google.com>
Message-Id: <20190127194128.161250-4-sxenos@google.com>
Mime-Version: 1.0
References: <20190127194128.161250-1-sxenos@google.com>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
Subject: [PATCH v2 4/8] evolve: Add support for parsing metacommits
From:   sxenos@google.com
To:     git@vger.kernel.org
Cc:     Stefan Xenos <sxenos@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Xenos <sxenos@google.com>

This patch adds the get_metacommit_content method, which can classify
commits as either metacommits or normal commits, determine whether they
are abandoned, and extract the content commit's object id from the
metacommit.

Signed-off-by: Stefan Xenos <sxenos@google.com>
---
 Makefile            |  1 +
 metacommit-parser.c | 87 +++++++++++++++++++++++++++++++++++++++++++++
 metacommit-parser.h | 16 +++++++++
 3 files changed, 104 insertions(+)
 create mode 100644 metacommit-parser.c
 create mode 100644 metacommit-parser.h

diff --git a/Makefile b/Makefile
index 1a44c811aa..7ffc383f2b 100644
--- a/Makefile
+++ b/Makefile
@@ -919,6 +919,7 @@ LIB_OBJS += merge.o
 LIB_OBJS += merge-blobs.o
 LIB_OBJS += merge-recursive.o
 LIB_OBJS += mergesort.o
+LIB_OBJS += metacommit-parser.o
 LIB_OBJS += midx.o
 LIB_OBJS += name-hash.o
 LIB_OBJS += negotiator/default.o
diff --git a/metacommit-parser.c b/metacommit-parser.c
new file mode 100644
index 0000000000..5013a108a3
--- /dev/null
+++ b/metacommit-parser.c
@@ -0,0 +1,87 @@
+#include "cache.h"
+#include "metacommit-parser.h"
+#include "commit.h"
+
+/*
+ * Search the commit buffer for a line starting with the given key. Unlike
+ * find_commit_header, this also searches the commit message body.
+ */
+static const char *find_key(const char *msg, const char *key, size_t *out_len)
+{
+	int key_len = strlen(key);
+	const char *line = msg;
+
+	while (line) {
+		const char *eol = strchrnul(line, '\n');
+
+		if (eol - line > key_len &&
+				!strncmp(line, key, key_len) &&
+				line[key_len] == ' ') {
+			*out_len = eol - line - key_len - 1;
+			return line + key_len + 1;
+		}
+		line = *eol ? eol + 1 : NULL;
+	}
+	return NULL;
+}
+
+static struct commit *get_commit_by_index(struct commit_list *to_search, int index)
+{
+	while (to_search && index) {
+		to_search = to_search->next;
+		--index;
+	}
+
+	return to_search->item;
+}
+
+/*
+ * Writes the content parent's object id to "content".
+ * Returns the metacommit type. See the METACOMMIT_TYPE_* constants.
+ */
+int get_metacommit_content(
+	struct commit *commit, struct object_id *content)
+{
+	const char *buffer = get_commit_buffer(commit, NULL);
+	size_t parent_types_size;
+	const char *parent_types = find_key(buffer, "parent-type",
+		&parent_types_size);
+	const char *end;
+	int index = 0;
+	int ret;
+	struct commit *content_parent;
+
+	if (!parent_types) {
+		return METACOMMIT_TYPE_NONE;
+	}
+
+	end = &(parent_types[parent_types_size]);
+
+	while (1) {
+		char next = *parent_types;
+		if (next == ' ') {
+			index++;
+		}
+		if (next == 'c') {
+			ret = METACOMMIT_TYPE_NORMAL;
+			break;
+		}
+		if (next == 'a') {
+			ret = METACOMMIT_TYPE_ABANDONED;
+			break;
+		}
+		parent_types++;
+		if (parent_types >= end) {
+			return METACOMMIT_TYPE_NONE;
+		}
+	}
+
+	content_parent = get_commit_by_index(commit->parents, index);
+
+	if (!content_parent) {
+		return METACOMMIT_TYPE_NONE;
+	}
+
+	oidcpy(content, &(content_parent->object.oid));
+	return ret;
+}
diff --git a/metacommit-parser.h b/metacommit-parser.h
new file mode 100644
index 0000000000..e546f5a7e7
--- /dev/null
+++ b/metacommit-parser.h
@@ -0,0 +1,16 @@
+#ifndef METACOMMIT_PARSER_H
+#define METACOMMIT_PARSER_H
+
+// Indicates a normal commit (non-metacommit)
+#define METACOMMIT_TYPE_NONE 0
+// Indicates a metacommit with normal content (non-abandoned)
+#define METACOMMIT_TYPE_NORMAL 1
+// Indicates a metacommit with abandoned content
+#define METACOMMIT_TYPE_ABANDONED 2
+
+struct commit;
+
+extern int get_metacommit_content(
+	struct commit *commit, struct object_id *content);
+
+#endif
-- 
2.20.1.495.gaa96b0ce6b-goog

