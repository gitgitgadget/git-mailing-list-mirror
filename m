Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB0082022A
	for <e@80x24.org>; Wed,  2 Nov 2016 17:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756604AbcKBR3e (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 13:29:34 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33213 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756595AbcKBR3c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 13:29:32 -0400
Received: by mail-pf0-f172.google.com with SMTP id d2so15406929pfd.0
        for <git@vger.kernel.org>; Wed, 02 Nov 2016 10:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=IQmxm7SNMunrYFy1lWJL7iveUwHa8WW9LfNCVKKG7GU=;
        b=MAn/f8tHEVgnMZWAbqS+pouuKyO7dzGkzrWPrYSSdoUFJMyRhad5rYAXp3DsOgrr9D
         BX4ArrvQuSzGBDtMkL6s4pbR0sYvsThaPqM6khk1DmdtqH0nXfArUCppVnj4x4FPbNbg
         B47xs9rcntabCBlbxeb1UqdtWnHb0I3i1rdOP2XLLdTcR614nv/FZEj4pQnOjoMG5FIK
         ORHavWD097CkCeYdpQvdKPV51inl671KKPjXBMzgnA9S7Fvb9TIEcmBv64VxS3e5mTG6
         4qW1ysfHZKEoriIk02g/PXncweXXRy51cLQ+avHXdMbnLlTTdO9NBAwFE0KyJ59lu+lC
         XygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=IQmxm7SNMunrYFy1lWJL7iveUwHa8WW9LfNCVKKG7GU=;
        b=G1uqu+sC13suTs18Kjh8NAVfFo5WxsvHtw4zYSjomrOAyd3RaQOOLmpYhuuJD1+L3o
         nNOIptEMPbIMf8Azx7/JDwarUm1SX1PKdi8raB+CmdC5pbc8IoC1NpZPHdlj7DXODJ4U
         ZkCJdNOerr/gfy8igGTDp6PP+YqroHWSAzkMR5ICquOAROaWdc8XoUz/tux2OxvzfMtn
         7Va3nzJoaepn6bnr7FjBz8b8GITYEh9U6ym6RjQwQNNNXPVCtOQIEMalfRZN8h2ww2Yo
         FnNDGt2o79Y4DJUadoT9hhGW+KgPQripaq4K4lXJmOxpQTPS4chKIUeJP0obMfTJwHF2
         flzw==
X-Gm-Message-State: ABUngvd/RCw4Lg4copBzmknaxSNF1LtBAB+aNtGU47cOyWt2aoCe/ch/ry1iasW4avz8xICA
X-Received: by 10.98.213.7 with SMTP id d7mr8710963pfg.3.1478107771517;
        Wed, 02 Nov 2016 10:29:31 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id f23sm6185167pff.59.2016.11.02.10.29.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Nov 2016 10:29:30 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 2/5] commit: make ignore_non_trailer take buf/len
Date:   Wed,  2 Nov 2016 10:29:17 -0700
Message-Id: <351c897b0f27c6fc72598b872aafd26515e57e16.1478107666.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1478107666.git.jonathantanmy@google.com>
References: <cover.1478107666.git.jonathantanmy@google.com>
In-Reply-To: <cover.1478107666.git.jonathantanmy@google.com>
References: <cover.1477698917.git.jonathantanmy@google.com> <cover.1478107666.git.jonathantanmy@google.com>
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
index 8976c3d..887ccc7 100644
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
index 856fd4a..2cf8515 100644
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
+		const char *next_line = memchr(buf + bol, '\n', len - bol);
 
-		if (!(next_line = memchr(sb->buf + bol, '\n', sb->len - bol)))
-			next_line = sb->buf + sb->len;
+		if (!next_line)
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
index dc525e3..9d7765e 100644
--- a/trailer.c
+++ b/trailer.c
@@ -840,7 +840,7 @@ static int find_trailer_end(struct strbuf **lines, int patch_start)
 
 	for (i = 0; i < patch_start; i++)
 		strbuf_addbuf(&sb, lines[i]);
-	ignore_bytes = ignore_non_trailer(&sb);
+	ignore_bytes = ignore_non_trailer(sb.buf, sb.len);
 	strbuf_release(&sb);
 	for (i = patch_start - 1; i >= 0 && ignore_bytes > 0; i--)
 		ignore_bytes -= lines[i]->len;
-- 
2.8.0.rc3.226.g39d4020

