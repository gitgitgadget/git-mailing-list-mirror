Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FAB41F453
	for <e@80x24.org>; Fri, 15 Feb 2019 04:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387726AbfBOEb1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 23:31:27 -0500
Received: from mail-yb1-f201.google.com ([209.85.219.201]:35134 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387506AbfBOEb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 23:31:26 -0500
Received: by mail-yb1-f201.google.com with SMTP id g19so5113305ybe.2
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 20:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=T7o3js+N3EETI2iFDDIVIRNGQa2tabardumGGAddZaI=;
        b=J5UxA1TuGH55DWaZ+kaRW2wvpEtWp5UvQ0AwRdqMKTpCgVX5GON+q9bvDfG22T9ipx
         r8nrF0Y1WVSj8JcaW5VWVsiIouygXvMDw7DzNfipOXSL6bo3iXN+O4zVTYCsqoIbuDym
         8KLte0Gh6IewJ6AE06hkc6u75GAV0gvw8p/btlkLZHjebmw63o1W+92IqNBlrAPdrsrV
         i3YYwM43mBU4zxgxc0/S8ybiz2BMufgkerxe7kLrjZEwbN+nkkc2YZiOVNoDYI6LxHBb
         rLHsh5fFS3XYkSPieYXzZJrVpnRfQAGowDjNmaasATu3395RgRyNr2GWOaFAtj42IlCs
         xo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T7o3js+N3EETI2iFDDIVIRNGQa2tabardumGGAddZaI=;
        b=cV9bnT4ZAl7XT2ktko81007SX4eMNWrAyevgjzaPPckSlodConUPg0h1Kzqz9mZI6y
         8ojDvtW0Qcv5VI8o/bADCY/SdoVuIg3dxkFAAWk8sD4pvM8XBvzRgXZda1wrZdeYuwhX
         AUNkM9RrZZE0QkhXhbPEYjQHneMSrFaBX+x1UMv2MSfsvhnjjagNrBVht2ksBdIHObXR
         3t/JoAOng7EmYdTv28xZmvwQxeewTNydrRTmgx5SmvwJ6dtOcyb+cbotLP0tjBEN1cnV
         OSGE1iFjsvcz1ypeyWS2JVov8vlNPKPlTJPPncpqxBRGvVWKhrdfKOcxtP0K4fvmebcH
         aO+g==
X-Gm-Message-State: AHQUAuZ0bBXei3eb5poTh+eHC4exv1ZmaXecEiksOzdQ4ej1XmQNUPrV
        3O2vibcPMDRKR0IS3JKYR6Y5KA897Y6Ezs3E63NksHgBZzCjIrlmyPcECwz3AZj9V+rr04CEFqc
        rZ0dj23gN9jtB5Avmq3YzmzF8PKQe9LIYEHxI5NprHtC0v8i53uukvQ33+A==
X-Google-Smtp-Source: AHgI3IYmHBrLSD+NekewJhOtveZJF55n8RI0oFOY22doPeWv17CZCTZ4uLcL3WXiPC58ZIDvPQxDylOa2Wo=
X-Received: by 2002:a25:1ed4:: with SMTP id e203mr3183027ybe.2.1550205085436;
 Thu, 14 Feb 2019 20:31:25 -0800 (PST)
Date:   Thu, 14 Feb 2019 20:31:01 -0800
In-Reply-To: <20190215043105.163688-1-sxenos@google.com>
Message-Id: <20190215043105.163688-4-sxenos@google.com>
Mime-Version: 1.0
References: <20190215043105.163688-1-sxenos@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH v5 4/8] evolve: add support for parsing metacommits
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
index f0b2299172..ab1103a9e9 100644
--- a/Makefile
+++ b/Makefile
@@ -939,6 +939,7 @@ LIB_OBJS += merge.o
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
2.21.0.rc0.258.g878e2cd30e-goog

