Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCA0C1F453
	for <e@80x24.org>; Mon, 21 Jan 2019 22:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfAUWcc (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 17:32:32 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:51199 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfAUWcb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 17:32:31 -0500
Received: by mail-yw1-f73.google.com with SMTP id b8so11823731ywb.17
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 14:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nUQRE+j96MBpSIBvix+R5v5Qd59WfjWobTxdWQPLYlI=;
        b=DbpB1hm9EFh1qyOjMaCKC+HjKhv91n97En5FvFLJeN1o35Lf9PvdNZNY/91sVrb15i
         maedJ9KOTgUxmCwR78DTFMuNu3kulPdvMiwKGnD/cU0Wh3MYK3eLVziIBf0l5/7aYbvV
         mO7X6I8P0qtbdQaInQ5cGXSYYyUKRn6QDDgu7DqbOSIXL58WYd8LSQoDzRtaG3bhptd0
         BkJSAadgmzJTx93/EwJbvZdbDG1yWUnJ5g46HiYCIagvkZsylaCE+hELZ8XltSiF2Z4a
         GxdBgazm2sNLP72VMqJfL12RqgWM9N8SXlWg1ZCgAY5L24XKth3uzxvZDG2ttDJ4zXCE
         /beA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nUQRE+j96MBpSIBvix+R5v5Qd59WfjWobTxdWQPLYlI=;
        b=b9msMH3/HeOzVwYkDkHqighhfEXAQPyB6NvHbGtcoXdfSXerg54XFsMRjYMKarUF93
         ToOBznnBZK4ekMI9vS/j6+JQBxJTP57Vr1aWcGyxvDdI+LfWwCYM58nh0CFwR5HTOiTR
         tKPrFmrMAAC2w2/UMn1uBxrShUEqljWprZBGfaWjDwUOUSQkrU0UPAcwJnsXEpBn3eG5
         gERf0r6q8aBOEUKjaAsykeY9XhraI4iZUaNWin6A9/N/4aWH6BSnutdw4O402voU7I2Y
         vSmfLNd8aOImyhommtsRbs/wckhFibYpT86xQF93a7DNoOWH/KvnjsWnQbb+DZyVrOcg
         Qu9A==
X-Gm-Message-State: AJcUukfjSFE4T2IV4KXWA1upK2FnhlP/i0BVOGjnVeHz/I6tl6XaufFJ
        5oCrN65kD1K70bWG/cVvIbCyCFJiJqAuaMmIWOQnuMUBSoMJYvIFbDZ0innH25TGHs+/7HTIQdL
        +hFN6TTP5PgTPsJgcMotmESlmtPUMUGHnElNYRzMhmCrLKoKj5Z7eG6zzpA==
X-Google-Smtp-Source: ALg8bN7Hc/UKqYyaa240LTJ8Dd6QXEkfv83bDRqNE28fv5ncF7eHI7IXlBz0BjL2TDiYAQAx+ozl5jpdWSA=
X-Received: by 2002:a25:245:: with SMTP id 66mr9379357ybc.39.1548109950356;
 Mon, 21 Jan 2019 14:32:30 -0800 (PST)
Date:   Mon, 21 Jan 2019 14:32:12 -0800
In-Reply-To: <20190121223216.66659-1-sxenos@google.com>
Message-Id: <20190121223216.66659-4-sxenos@google.com>
Mime-Version: 1.0
References: <20190121223216.66659-1-sxenos@google.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
Subject: [PATCH 4/8] evolve: Add support for parsing metacommits
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
2.20.1.321.g9e740568ce-goog

