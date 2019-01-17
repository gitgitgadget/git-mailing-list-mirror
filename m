Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 774011F453
	for <e@80x24.org>; Thu, 17 Jan 2019 20:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfAQU3h (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 15:29:37 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:34591 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728923AbfAQU3f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 15:29:35 -0500
Received: by mail-yw1-f74.google.com with SMTP id i2so5779548ywb.1
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 12:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jdhbUYwZITarFX1U+joZbjx8HfFhNMOO7oRD9rn/YJo=;
        b=naCiViZH/2d1jQD6zH5ZOmZONsb0l+0ltgwJZAm42yH3ZS7OMwP5Ico5sizdbwy1PP
         LsIPG1m2WavOzvSusdHujW4xxKptKW6lxV0/d4ywbhVeaVz/CkMvbTqRWbxF6sgQTQii
         VM/zTvhdaprvCpBESYscDnHNAGmMKMIkNrLrSkLg7h0fOT+H701jcsYbTf717Xk1yKap
         hK1szDHncFRu+dbY5Kv7kbqWzx3lg6hA1wKB7FPpr85vmgyPDGCEs68jwHWNFgk+UwtV
         YWnMxzv1Cwvzawv5N5dAqmJMrWF93O+ulu3+YnIxWNQgsSvgUVH+u9fcNbXfGlCAzpFl
         5U6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jdhbUYwZITarFX1U+joZbjx8HfFhNMOO7oRD9rn/YJo=;
        b=ftM4yY/8I4GzLZd5iu9LxoAs9py8liuU7Drb1+azeZeOYjyVnfL3v0del+Y8/oHUiz
         cFIYftHXWtAZvvod31CHMNVmzHIoD1dJySZm7u+f3ZasYhxJoxElO8mQVFxVTFXpdkLX
         buCQFJIzhbsIfLS4fZG9dPV82LPbOaC3fyJREnC79f2HCjt8aRONxAFyW/li4yMN1sTg
         /SeuI0T8iYOJ3HnrNdnkKcS4Qi8KVpTECJNCiSjc3JfRwSTis/1iAf9DrtkZEgf4b63B
         IWTqcXmwtfpyHYj83/FwNkvjabahUjCaqKu/RziCXmpEvV3+cO0cXurv5ZNbOFievzGq
         AnRg==
X-Gm-Message-State: AJcUukfvGJxa4EtwidJ7APht5UlAm+Sr3aD//ATI9CEBkr6xM67qhOK3
        6MANfw3pCkNk0HlRdHRJV+BxkIkfaO3T9B66P4UR60zQuCM158s/OeXeVTU3klRnIXHwVc7K0Uk
        4FW8rS0U8Zbcp/zjX10dAHRXGY3VdN0YKyRLgr6d1X2eSmS22E5o/
X-Google-Smtp-Source: ALg8bN5C7P8NJIQojfSlkf8aXbK/QUNy1adYI2MLElgYGWkpxa3RuC3V6e7Zy4xWmorhulnZOPIcZ9Un
X-Received: by 2002:a0d:ec8b:: with SMTP id v133mr7585900ywe.2.1547756974187;
 Thu, 17 Jan 2019 12:29:34 -0800 (PST)
Date:   Thu, 17 Jan 2019 15:29:17 -0500
In-Reply-To: <20190117202919.157326-1-brho@google.com>
Message-Id: <20190117202919.157326-2-brho@google.com>
Mime-Version: 1.0
References: <20190107213013.231514-1-brho@google.com> <20190117202919.157326-1-brho@google.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
Subject: [PATCH v2 1/3] Move init_skiplist() outside of fsck
From:   Barret Rhoden <brho@google.com>
To:     git@vger.kernel.org
Cc:     "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?Ren=C3=A9=20Scharfe?=" <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

init_skiplist() took a file consisting of SHA-1s and comments and added
the objects to an oidset.  This functionality is useful for other
commands.

Signed-off-by: Barret Rhoden <brho@google.com>
---
 fsck.c   | 37 +------------------------------------
 oidset.c | 35 +++++++++++++++++++++++++++++++++++
 oidset.h |  7 +++++++
 3 files changed, 43 insertions(+), 36 deletions(-)

diff --git a/fsck.c b/fsck.c
index 68502ce85b11..80b53e6f4968 100644
--- a/fsck.c
+++ b/fsck.c
@@ -181,41 +181,6 @@ static int fsck_msg_type(enum fsck_msg_id msg_id,
 	return msg_type;
 }
 
-static void init_skiplist(struct fsck_options *options, const char *path)
-{
-	FILE *fp;
-	struct strbuf sb = STRBUF_INIT;
-	struct object_id oid;
-
-	fp = fopen(path, "r");
-	if (!fp)
-		die("Could not open skip list: %s", path);
-	while (!strbuf_getline(&sb, fp)) {
-		const char *p;
-		const char *hash;
-
-		/*
-		 * Allow trailing comments, leading whitespace
-		 * (including before commits), and empty or whitespace
-		 * only lines.
-		 */
-		hash = strchr(sb.buf, '#');
-		if (hash)
-			strbuf_setlen(&sb, hash - sb.buf);
-		strbuf_trim(&sb);
-		if (!sb.len)
-			continue;
-
-		if (parse_oid_hex(sb.buf, &oid, &p) || *p != '\0')
-			die("Invalid SHA-1: %s", sb.buf);
-		oidset_insert(&options->skiplist, &oid);
-	}
-	if (ferror(fp))
-		die_errno("Could not read '%s'", path);
-	fclose(fp);
-	strbuf_release(&sb);
-}
-
 static int parse_msg_type(const char *str)
 {
 	if (!strcmp(str, "error"))
@@ -284,7 +249,7 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 		if (!strcmp(buf, "skiplist")) {
 			if (equal == len)
 				die("skiplist requires a path");
-			init_skiplist(options, buf + equal + 1);
+			oidset_parse_file(&options->skiplist, buf + equal + 1);
 			buf += len + 1;
 			continue;
 		}
diff --git a/oidset.c b/oidset.c
index fe4eb921df81..a4f38a040320 100644
--- a/oidset.c
+++ b/oidset.c
@@ -35,3 +35,38 @@ void oidset_clear(struct oidset *set)
 	kh_release_oid(&set->set);
 	oidset_init(set, 0);
 }
+
+void oidset_parse_file(struct oidset *set, const char *path)
+{
+	FILE *fp;
+	struct strbuf sb = STRBUF_INIT;
+	struct object_id oid;
+
+	fp = fopen(path, "r");
+	if (!fp)
+		die("Could not open skip list: %s", path);
+	while (!strbuf_getline(&sb, fp)) {
+		const char *p;
+		const char *hash;
+
+		/*
+		 * Allow trailing comments, leading whitespace
+		 * (including before commits), and empty or whitespace
+		 * only lines.
+		 */
+		hash = strchr(sb.buf, '#');
+		if (hash)
+			strbuf_setlen(&sb, hash - sb.buf);
+		strbuf_trim(&sb);
+		if (!sb.len)
+			continue;
+
+		if (parse_oid_hex(sb.buf, &oid, &p) || *p != '\0')
+			die("Invalid SHA-1: %s", sb.buf);
+		oidset_insert(set, &oid);
+	}
+	if (ferror(fp))
+		die_errno("Could not read '%s'", path);
+	fclose(fp);
+	strbuf_release(&sb);
+}
diff --git a/oidset.h b/oidset.h
index c9d0f6d3cc8b..a3452eb7de84 100644
--- a/oidset.h
+++ b/oidset.h
@@ -73,6 +73,13 @@ int oidset_remove(struct oidset *set, const struct object_id *oid);
  */
 void oidset_clear(struct oidset *set);
 
+/**
+ * Add the contents of the file 'path' to an initialized oidset.  Each line is
+ * an unabbreviated SHA-1.  Comments begin with '#', and trailing comments are
+ * allowed.  Leading whitespace and empty or white-space only lines are ignored.
+ */
+void oidset_parse_file(struct oidset *set, const char *path);
+
 struct oidset_iter {
 	kh_oid_t *set;
 	khiter_t iter;
-- 
2.20.1.321.g9e740568ce-goog

