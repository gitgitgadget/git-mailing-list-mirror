Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FD7E2035F
	for <e@80x24.org>; Sat, 29 Oct 2016 00:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756553AbcJ2AFU (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 20:05:20 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:32840 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754985AbcJ2AFS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 20:05:18 -0400
Received: by mail-pf0-f178.google.com with SMTP id 197so45080056pfu.0
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 17:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=QW8IVkVNgO0lco2AniYKkI0aPa3cI13vg0MKc0dgluo=;
        b=LKL+TVs+y05YI2haPq7cMrtsUHpxS+DULypjwF9Xxt2fMFlq7wv4nf4eEl9Z5miS+j
         03Cz/Tn72AzdlPFk/aKl2JW2gfYS54/mX77Am589E8qkyW9jAD7q5t30pDsD0e2z5mWr
         ImL0Aujrk7O19lFZS14wj9AGWjjdbfniWl8G8sGkRpm/TMC/u+Qaldn7C/Nh6y9kYlov
         4pOVkp8rp7T0chaw70oGKQ5lwmljoBKEIckgjLPtVeVsad0/gjUDgnUxCZ6mBBl8LuPE
         XpBOjmAreRYMVLOT3Dz6bAEuFhpkCuhufDFLpNxJWGGoo3KNRPm7w4BUs7wA24X3jzxX
         pjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=QW8IVkVNgO0lco2AniYKkI0aPa3cI13vg0MKc0dgluo=;
        b=PK++lSs64XuI7X/FfOv3BTv8osIJMfk+kc7vr+DnW4m4/r+rPxWl3nEk1E9Wj3YFQh
         nVWnTP8iDpGigk5eSOzM655Anvbr2/jeYXpSlvMy/suT7y0HXHDiGOb6Uzn7Q5BjZgiS
         40unBK/426hBzNwArble9T2YExGHJMIhO1KOibZpTOkKSy5Pdosiu9zgr7lBoVyOHJiU
         bSrYw/s9oNeiJqCfEvQUYHzco8vG4f+bhhxr/4Yxs/4hgwt9jOHgT2Ii6HLpFSN9xkHS
         kaXZNw5OYniXNSJg6TyFap/7ftFFbctO0AVCFVF7zMwgBK+1BPgFqoH+ql8PqNQYWMN+
         4Atg==
X-Gm-Message-State: ABUngvcN4Ph5PCUB6fFD8NTVz1HjLTCJzgjZpiBWt7SFgNKhmw7CYNV8uL2YfhPG+aYHV2kD
X-Received: by 10.99.54.74 with SMTP id d71mr24473585pga.34.1477699516430;
        Fri, 28 Oct 2016 17:05:16 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id b66sm21356750pfg.10.2016.10.28.17.05.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 17:05:15 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 1/4] commit: make ignore_non_trailer take buf/len
Date:   Fri, 28 Oct 2016 17:05:08 -0700
Message-Id: <38ab31ef362d58e600860aa9c6111fd7625b46f1.1477698917.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1477698917.git.jonathantanmy@google.com>
References: <cover.1477698917.git.jonathantanmy@google.com>
In-Reply-To: <cover.1477698917.git.jonathantanmy@google.com>
References: <cover.1477698917.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make ignore_non_trailer take a buf/len pair instead of struct strbuf.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/commit.c |  2 +-
 commit.c         | 22 +++++++++++-----------
 commit.h         |  2 +-
 trailer.c        |  2 +-
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 1cba3b7..c26b939 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -790,7 +790,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		strbuf_stripspace(&sb, 0);
 
 	if (signoff)
-		append_signoff(&sb, ignore_non_trailer(&sb), 0);
+		append_signoff(&sb, ignore_non_trailer(sb.buf, sb.len), 0);
 
 	if (fwrite(sb.buf, 1, sb.len, s->fp) < sb.len)
 		die_errno(_("could not write commit template"));
diff --git a/commit.c b/commit.c
index 856fd4a..f70835a 100644
--- a/commit.c
+++ b/commit.c
@@ -1649,7 +1649,7 @@ const char *find_commit_header(const char *msg, const char *key, size_t *out_len
 }
 
 /*
- * Inspect sb and determine the true "end" of the log message, in
+ * Inspect the given string and determine the true "end" of the log message, in
  * order to find where to put a new Signed-off-by: line.  Ignored are
  * trailing comment lines and blank lines, and also the traditional
  * "Conflicts:" block that is not commented out, so that we can use
@@ -1659,37 +1659,37 @@ const char *find_commit_header(const char *msg, const char *key, size_t *out_len
  * Returns the number of bytes from the tail to ignore, to be fed as
  * the second parameter to append_signoff().
  */
-int ignore_non_trailer(struct strbuf *sb)
+int ignore_non_trailer(const char *buf, size_t len)
 {
 	int boc = 0;
 	int bol = 0;
 	int in_old_conflicts_block = 0;
 
-	while (bol < sb->len) {
-		char *next_line;
+	while (bol < len) {
+		const char *next_line;
 
-		if (!(next_line = memchr(sb->buf + bol, '\n', sb->len - bol)))
-			next_line = sb->buf + sb->len;
+		if (!(next_line = memchr(buf + bol, '\n', len - bol)))
+			next_line = buf + len;
 		else
 			next_line++;
 
-		if (sb->buf[bol] == comment_line_char || sb->buf[bol] == '\n') {
+		if (buf[bol] == comment_line_char || buf[bol] == '\n') {
 			/* is this the first of the run of comments? */
 			if (!boc)
 				boc = bol;
 			/* otherwise, it is just continuing */
-		} else if (starts_with(sb->buf + bol, "Conflicts:\n")) {
+		} else if (starts_with(buf + bol, "Conflicts:\n")) {
 			in_old_conflicts_block = 1;
 			if (!boc)
 				boc = bol;
-		} else if (in_old_conflicts_block && sb->buf[bol] == '\t') {
+		} else if (in_old_conflicts_block && buf[bol] == '\t') {
 			; /* a pathname in the conflicts block */
 		} else if (boc) {
 			/* the previous was not trailing comment */
 			boc = 0;
 			in_old_conflicts_block = 0;
 		}
-		bol = next_line - sb->buf;
+		bol = next_line - buf;
 	}
-	return boc ? sb->len - boc : 0;
+	return boc ? len - boc : 0;
 }
diff --git a/commit.h b/commit.h
index afd14f3..9c12abb 100644
--- a/commit.h
+++ b/commit.h
@@ -355,7 +355,7 @@ extern const char *find_commit_header(const char *msg, const char *key,
 				      size_t *out_len);
 
 /* Find the end of the log message, the right place for a new trailer. */
-extern int ignore_non_trailer(struct strbuf *sb);
+extern int ignore_non_trailer(const char *buf, size_t len);
 
 typedef void (*each_mergetag_fn)(struct commit *commit, struct commit_extra_header *extra,
 				 void *cb_data);
diff --git a/trailer.c b/trailer.c
index d19a92c..6d8375b 100644
--- a/trailer.c
+++ b/trailer.c
@@ -828,7 +828,7 @@ static int find_trailer_end(struct strbuf **lines, int patch_start)
 
 	for (i = 0; i < patch_start; i++)
 		strbuf_addbuf(&sb, lines[i]);
-	ignore_bytes = ignore_non_trailer(&sb);
+	ignore_bytes = ignore_non_trailer(sb.buf, sb.len);
 	strbuf_release(&sb);
 	for (i = patch_start - 1; i >= 0 && ignore_bytes > 0; i--)
 		ignore_bytes -= lines[i]->len;
-- 
2.8.0.rc3.226.g39d4020

