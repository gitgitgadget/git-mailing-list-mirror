Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0F341F453
	for <e@80x24.org>; Fri,  1 Feb 2019 03:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfBADJn (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 22:09:43 -0500
Received: from mail-io1-f73.google.com ([209.85.166.73]:40398 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfBADJm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 22:09:42 -0500
Received: by mail-io1-f73.google.com with SMTP id u2so4307061iob.7
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 19:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GiTODEaq/c2mfjPsPVca5Ciq3UppcJrW799H2p79SS4=;
        b=ayTyH9CRVUQTCT91c6KDC3WpzwPZWT/luAuA9L3akiUBtrjeKdr8UrJWLdCRxNpJU6
         oN8Xw5mXlapmrEXOYieBz9Ug9n5prC8tb9eKpZO6EUSyMjMfauEQ+gEsCczaytJn+mtp
         tfu7n1MyHdOoDGSg6cONqdIOfRdXswpQOmui1ZKKwJJ9KhVEn/t6bij/qfedq3/M+aLe
         8TnwwtgLCxVI8hI4draxvXYk7XI1VwA7RBjWfjPavDkVjnnuIvYrZ+G1Vk0WHYHOk+e8
         Jfkx0bZa2mnyfqto825bl76rtW14QIb2zD0epQ8lEqRwMX+aWv+/5wggDCllFza6ftUq
         29bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GiTODEaq/c2mfjPsPVca5Ciq3UppcJrW799H2p79SS4=;
        b=EB8DE5DqZcb8NbohbWoeaRIusqiqW+VZ8LjXEp6SgCIj/l8KUlMWFIjbha+/XohVyp
         M+MXTg//PEZ/HAuXD6TfRRWBGsdnrX2Z9j6OCfddTVu3hWD0PKGVrYFKd3pThufT3dfI
         oHA2HNsRDAYBgzTU6w+DEtSf9v4rgn94jOmbGpEm7JZL2EE4f3g0ycxc7VDqh6FAFBh+
         H2QR0ZRi/RYXwJ88JbCJGWXHplKvS7VRMHYOi/v1zMJ2IgWUY34i9kuYlOdDpF7M2Efo
         upe9rMXpYSUOTpP+4cg24zy1hpoMP2KSXkqGi1JwORpeGcoUw7mVVALxkth7TXlGErLD
         Y3ng==
X-Gm-Message-State: AHQUAuZjkEJbwTzXVCs1z/qQgROczDruopSOesrdH+p+yQPOgwZnjPoq
        tkuQfCpL2qTuySpxxxLA7lGWKt1WwRQV4HMaoiSsz2Dse6wrT4ANaCaTUGTzGsGb5LuOZ+xIZw9
        zUVoE9NrQ4BqEQ0d1uNZRw8nLwFgAX5WTdL61+xJ3BgnV4LdkOohUclYQVQ==
X-Google-Smtp-Source: AHgI3Ia7pALzVI3OGDTJsMXBWCW4HAR2vrWwCIcFigYm/UitfG8yKDzKahGTVhfS2XwDhWIhlZaaaDRqu+c=
X-Received: by 2002:a24:a945:: with SMTP id x5mr424689iti.26.1548990581281;
 Thu, 31 Jan 2019 19:09:41 -0800 (PST)
Date:   Thu, 31 Jan 2019 19:09:21 -0800
In-Reply-To: <20190201030925.177124-1-sxenos@google.com>
Message-Id: <20190201030925.177124-4-sxenos@google.com>
Mime-Version: 1.0
References: <20190201030925.177124-1-sxenos@google.com>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
Subject: [PATCH v4 4/8] evolve: add support for parsing metacommits
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
 Makefile            |   1 +
 metacommit-parser.c | 110 ++++++++++++++++++++++++++++++++++++++++++++
 metacommit-parser.h |  16 +++++++
 3 files changed, 127 insertions(+)
 create mode 100644 metacommit-parser.c
 create mode 100644 metacommit-parser.h

diff --git a/Makefile b/Makefile
index 6e8d017e8e..c850a407ec 100644
--- a/Makefile
+++ b/Makefile
@@ -928,6 +928,7 @@ LIB_OBJS += merge.o
 LIB_OBJS += merge-blobs.o
 LIB_OBJS += merge-recursive.o
 LIB_OBJS += mergesort.o
+LIB_OBJS += metacommit-parser.o
 LIB_OBJS += midx.o
 LIB_OBJS += name-hash.o
 LIB_OBJS += negotiator/default.o
diff --git a/metacommit-parser.c b/metacommit-parser.c
new file mode 100644
index 0000000000..70c1428bfc
--- /dev/null
+++ b/metacommit-parser.c
@@ -0,0 +1,110 @@
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
+		if (eol - line > key_len && !memcmp(line, key, key_len) &&
+		    line[key_len] == ' ') {
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
+		index--;
+	}
+
+	if (!to_search)
+		return NULL;
+
+	return to_search->item;
+}
+
+/*
+ * Writes the index of the content parent to "result". Returns the metacommit
+ * type. See the METACOMMIT_TYPE_* constants.
+ */
+static int index_of_content_commit(const char *buffer, int *result)
+{
+	int index = 0;
+	int ret = METACOMMIT_TYPE_NONE;
+	size_t parent_types_size;
+	const char *parent_types = find_key(buffer, "parent-type",
+		&parent_types_size);
+	const char *end;
+	const char *enum_start = parent_types;
+	int enum_length = 0;
+
+	if (!parent_types)
+		return METACOMMIT_TYPE_NONE;
+
+	end = &parent_types[parent_types_size];
+
+	while (1) {
+		char next = *parent_types;
+		if (next == ' ' || parent_types >= end) {
+			if (enum_length == 1) {
+				char first_char_in_enum = *enum_start;
+				if (first_char_in_enum == 'c') {
+					ret = METACOMMIT_TYPE_NORMAL;
+					break;
+				}
+				if (first_char_in_enum == 'a') {
+					ret = METACOMMIT_TYPE_ABANDONED;
+					break;
+				}
+			}
+			if (parent_types >= end)
+				return METACOMMIT_TYPE_NONE;
+			enum_start = parent_types + 1;
+			enum_length = 0;
+			index++;
+		} else {
+			enum_length++;
+		}
+		parent_types++;
+	}
+
+	*result = index;
+	return ret;
+}
+
+/*
+ * Writes the content parent's object id to "content".
+ * Returns the metacommit type. See the METACOMMIT_TYPE_* constants.
+ */
+int get_metacommit_content(struct commit *commit, struct object_id *content)
+{
+	const char *buffer = get_commit_buffer(commit, NULL);
+	int index = 0;
+	int ret = index_of_content_commit(buffer, &index);
+	struct commit *content_parent;
+
+	if (ret == METACOMMIT_TYPE_NONE)
+		return ret;
+
+	content_parent = get_commit_by_index(commit->parents, index);
+
+	if (!content_parent)
+		return METACOMMIT_TYPE_NONE;
+
+	oidcpy(content, &(content_parent->object.oid));
+	return ret;
+}
diff --git a/metacommit-parser.h b/metacommit-parser.h
new file mode 100644
index 0000000000..1fad17dbf8
--- /dev/null
+++ b/metacommit-parser.h
@@ -0,0 +1,16 @@
+#ifndef METACOMMIT_PARSER_H
+#define METACOMMIT_PARSER_H
+
+/* Indicates a normal commit (non-metacommit) */
+#define METACOMMIT_TYPE_NONE 0
+/* Indicates a metacommit with normal content (non-abandoned) */
+#define METACOMMIT_TYPE_NORMAL 1
+/* Indicates a metacommit with abandoned content */
+#define METACOMMIT_TYPE_ABANDONED 2
+
+struct commit;
+
+extern int get_metacommit_content(
+	struct commit *commit, struct object_id *content);
+
+#endif
-- 
2.20.1.611.gfbb209baf1-goog

