Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72A61201A4
	for <e@80x24.org>; Fri, 12 May 2017 05:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755672AbdELFEK (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 01:04:10 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33042 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755313AbdELFEH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 01:04:07 -0400
Received: by mail-pf0-f196.google.com with SMTP id a23so5694020pfe.0
        for <git@vger.kernel.org>; Thu, 11 May 2017 22:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OPFk2kPomZvB/7ME5gt1BJdg+XQM3UeAh8RXn/VtUgI=;
        b=GWKuRJ8rpShOie6kA//bLXntkYFHPvl0TV1RvwV30ZdoyZT+W1lmzeOGd3DMVJYxeL
         ua7Y8gtXZqqS7wtPBsFItJ+u9mZJTdJAjcj4pQOvS9Jj9QwBBGF6Pccoj+RNxpKpHHVv
         gNNs9APfquEMLLh9+q/l5xM2nDXNR0OrYUqCyQqoJeHvnAJ+3dL04ZLdC/fBspcshibN
         tvgfKskrs5fxxMi/7zzOSX/mb1snRxxzT/s8/ahCdQMMuZ2K+j7faKCgglACW+BbVBnn
         TmaK5oe0cZqk53L4S3Pj5uWdyleuhL+j/3Xy5zVXMDOYdKyRtf7GY7fWl1lW3EiZR+uz
         auXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OPFk2kPomZvB/7ME5gt1BJdg+XQM3UeAh8RXn/VtUgI=;
        b=ou2Ygw36qp2CZE02S5kHB2JJLV1lxMD51OMTUwtnA8NjkEvzGWGAv+e1joISeBhK+J
         DGMFZmkEHoj8GNBhr96HOHjTgHQqrtdnfxKJofXDbIICY3Ai8t6+9Tx7cG7PqFcIYtKW
         pHKq2d4sn/0TAKRHgGFsGJIjZE1rUM9CbwbyAfWsEssOk3hk2e3X3BHGBMoBq3drV0t8
         avGswN0iwX+74SYlZ6twYJKZJ4+OGfyMhUyr6ark14Obohi97xAVv5OwM3CmukEbrUQU
         1eWdFhT4HN3ky7DlLK13J15I02nf7NqMJg62CqOcbngPLEhCyFSmbB6PLQVzMQlLYE7T
         uu4g==
X-Gm-Message-State: AODbwcAy1xQE2D/cE0H3PS9mQTyw58qaO85zK52vG4WNM3TFRALrz9r5
        qVgK0ryt0XMLag==
X-Received: by 10.98.222.133 with SMTP id h127mr2349060pfg.63.1494565446740;
        Thu, 11 May 2017 22:04:06 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:3:1ec0:ad55:5f17:47e6:6202])
        by smtp.gmail.com with ESMTPSA id p3sm2747654pgd.36.2017.05.11.22.04.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 May 2017 22:04:05 -0700 (PDT)
From:   Brian Malehorn <bmalehorn@gmail.com>
To:     git@vger.kernel.org
Cc:     Brian Malehorn <bmalehorn@gmail.com>
Subject: [PATCH 2/3] commit.c: add is_scissors_line
Date:   Thu, 11 May 2017 22:03:46 -0700
Message-Id: <20170512050347.30765-3-bmalehorn@gmail.com>
X-Mailer: git-send-email 2.12.3.3.g39c96af
In-Reply-To: <20170512050347.30765-1-bmalehorn@gmail.com>
References: <20170512050347.30765-1-bmalehorn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move is_scissors_line to commit.c and expose it through commit.h.
This is needed in commit.c, and mailinfo.c shouldn't really own it.
---
 commit.c   | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 commit.h   |  1 +
 mailinfo.c | 53 +----------------------------------------------------
 3 files changed, 54 insertions(+), 52 deletions(-)

diff --git a/commit.c b/commit.c
index fab826973..041cfa5a9 100644
--- a/commit.c
+++ b/commit.c
@@ -1646,6 +1646,58 @@ const char *find_commit_header(const char *msg, const char *key, size_t *out_len
 	return NULL;
 }
 
+int is_scissors_line(const char *line)
+{
+	const char *c;
+	int scissors = 0, gap = 0;
+	const char *first_nonblank = NULL, *last_nonblank = NULL;
+	int visible, perforation = 0, in_perforation = 0;
+
+	for (c = line; *c != '\n'; c++) {
+		if (isspace(*c)) {
+			if (in_perforation) {
+				perforation++;
+				gap++;
+			}
+			continue;
+		}
+		last_nonblank = c;
+		if (first_nonblank == NULL)
+			first_nonblank = c;
+		if (*c == '-') {
+			in_perforation = 1;
+			perforation++;
+			continue;
+		}
+		if ((!memcmp(c, ">8", 2) || !memcmp(c, "8<", 2) ||
+		     !memcmp(c, ">%", 2) || !memcmp(c, "%<", 2))) {
+			in_perforation = 1;
+			perforation += 2;
+			scissors += 2;
+			c++;
+			continue;
+		}
+		in_perforation = 0;
+	}
+
+	/*
+	 * The mark must be at least 8 bytes long (e.g. "-- >8 --").
+	 * Even though there can be arbitrary cruft on the same line
+	 * (e.g. "cut here"), in order to avoid misidentification, the
+	 * perforation must occupy more than a third of the visible
+	 * width of the line, and dashes and scissors must occupy more
+	 * than half of the perforation.
+	 */
+
+	if (first_nonblank && last_nonblank)
+		visible = last_nonblank - first_nonblank + 1;
+	else
+		visible = 0;
+	return (scissors && 8 <= visible &&
+		visible < perforation * 3 &&
+		gap * 2 < perforation);
+}
+
 /*
  * Inspect the given string and determine the true "end" of the log message, in
  * order to find where to put a new Signed-off-by: line.  Ignored are
diff --git a/commit.h b/commit.h
index 9c12abb91..58cbab1cd 100644
--- a/commit.h
+++ b/commit.h
@@ -353,6 +353,7 @@ extern void free_commit_extra_headers(struct commit_extra_header *extra);
  */
 extern const char *find_commit_header(const char *msg, const char *key,
 				      size_t *out_len);
+extern int is_scissors_line(const char *line);
 
 /* Find the end of the log message, the right place for a new trailer. */
 extern int ignore_non_trailer(const char *buf, size_t len);
diff --git a/mailinfo.c b/mailinfo.c
index eadd0597f..52af800a5 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "utf8.h"
 #include "strbuf.h"
+#include "commit.h"
 #include "mailinfo.h"
 
 static void cleanup_space(struct strbuf *sb)
@@ -654,58 +655,6 @@ static inline int patchbreak(const struct strbuf *line)
 	return 0;
 }
 
-static int is_scissors_line(const char *line)
-{
-	const char *c;
-	int scissors = 0, gap = 0;
-	const char *first_nonblank = NULL, *last_nonblank = NULL;
-	int visible, perforation = 0, in_perforation = 0;
-
-	for (c = line; *c != '\n'; c++) {
-		if (isspace(*c)) {
-			if (in_perforation) {
-				perforation++;
-				gap++;
-			}
-			continue;
-		}
-		last_nonblank = c;
-		if (first_nonblank == NULL)
-			first_nonblank = c;
-		if (*c == '-') {
-			in_perforation = 1;
-			perforation++;
-			continue;
-		}
-		if ((!memcmp(c, ">8", 2) || !memcmp(c, "8<", 2) ||
-		     !memcmp(c, ">%", 2) || !memcmp(c, "%<", 2))) {
-			in_perforation = 1;
-			perforation += 2;
-			scissors += 2;
-			c++;
-			continue;
-		}
-		in_perforation = 0;
-	}
-
-	/*
-	 * The mark must be at least 8 bytes long (e.g. "-- >8 --").
-	 * Even though there can be arbitrary cruft on the same line
-	 * (e.g. "cut here"), in order to avoid misidentification, the
-	 * perforation must occupy more than a third of the visible
-	 * width of the line, and dashes and scissors must occupy more
-	 * than half of the perforation.
-	 */
-
-	if (first_nonblank && last_nonblank)
-		visible = last_nonblank - first_nonblank + 1;
-	else
-		visible = 0;
-	return (scissors && 8 <= visible &&
-		visible < perforation * 3 &&
-		gap * 2 < perforation);
-}
-
 static void flush_inbody_header_accum(struct mailinfo *mi)
 {
 	if (!mi->inbody_header_accum.len)
-- 
2.12.3.3.g39c96af

