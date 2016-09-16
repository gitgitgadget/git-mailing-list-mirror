Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B722207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 17:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934667AbcIPRhd (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 13:37:33 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33239 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934495AbcIPRhb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 13:37:31 -0400
Received: by mail-pf0-f171.google.com with SMTP id 21so18591473pfy.0
        for <git@vger.kernel.org>; Fri, 16 Sep 2016 10:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=PhKhlKc/Oymk50yym6zr3jpboUK0ev3mJ+D9vWXEE10=;
        b=NwnrLJ9IIPbk3FTl9znf0/YEmalXt6IDcqU9M0+wPzUplOl9rpoqgmW90tFTRQiKVk
         wcD7AEoTJ/fdEDvr29523GS+nG4cvUWO2T63NTirobXJ5cgbAqv0ELPCFcHe/7ZNGKwI
         ieUtuid0z7z/upT5/xaEzr5Tr0YVnY9rF8u94P4o0TlMoXAogunBr0/5jW+rnbFliy4I
         UYXFZnjZzFAyV4gfsL0S3jl9HdNXJiNTT25zhXtzICsGw/Giqi0XTgQowE2TqwFvCtWo
         siCah69cA0G4UJuP57a17J+DBnw1LYiLveD6FxfszyB8RGreejX2tDTSeMCHOK886HKD
         FOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=PhKhlKc/Oymk50yym6zr3jpboUK0ev3mJ+D9vWXEE10=;
        b=lVOEgiMBVzkuBZO8OQOGc5cqHPJhygnWfkeOlclNk7fggT2VUYWRI77esZikWZ4qqH
         eqaF+f1Xa54y8LFWzjXRKiHoiyvhdvIADQQD5CXrgK1SArpuK14T+Mn8JaGyjptBdjEG
         tulPRXW25Cvi4QTWXYnVL7HopLjsSxLYPqNeYaaxfqKFYkgbJyfuIQwcoauNQBK2Y7O5
         UQq/4gZkJAoq/HkPNS7JbxkbowExqDq5VZeTxelN18fm1tdOt2jDcRBy9sjVHuvtdk3T
         lYZEcUk1ST62jHEGuapUm+8Htv2rkRkyzNxcz0xGiQlmXsyMhj90cWIhY0XczKofxoKj
         dFxQ==
X-Gm-Message-State: AE9vXwOY0ivJrLCx773xfflu4m+j0FmRX0j+b3+9SRb4Hk5qbW3groDJFudhYrde4aqtqJev
X-Received: by 10.98.58.65 with SMTP id h62mr25080964pfa.82.1474047449887;
        Fri, 16 Sep 2016 10:37:29 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id m128sm53664348pfm.42.2016.09.16.10.37.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Sep 2016 10:37:28 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
Subject: [RFC/PATCH 1/3] mailinfo: refactor commit message processing
Date:   Fri, 16 Sep 2016 10:37:22 -0700
Message-Id: <7dbb4bc0659056211b27f0033c73f0d558efdb54.1474047135.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.10.0.rc2.20.g5b18e70
In-Reply-To: <cover.1474047135.git.jonathantanmy@google.com>
References: <cover.1474047135.git.jonathantanmy@google.com>
In-Reply-To: <cover.1474047135.git.jonathantanmy@google.com>
References: <20160907063819.dd7aulnlsytcuyqj@sigill.intra.peff.net> <cover.1474047135.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Within the processing of the commit message, check for a scissors line
or a patchbreak line first (before checking for in-body headers) so that
a subsequent patch modifying the processing of in-body headers would not
cause a scissors line or patchbreak line to be misidentified.

If a line could be both an in-body header and a scissors line (for
example, "From: -- >8 --"), this is considered a fatal error
(previously, it would be interpreted as an in-body header).  (It is not
possible for a line to be both an in-body header and a patchbreak line,
since both require different prefixes.)

The following enumeration shows that processing is the same except (as
described above) the in-body header + scissors line case.

o in-body header (check_header OK)
  o passes UTF-8 conversion
    o [described above] is scissors line
    o [not possible] is patchbreak line
    o [not possible] is blank line
    o is none of the above - processed as header
  o fails UTF-8 conversion - processed as header
o not in-body header
  o passes UTF-8 conversion
    o is scissors line - processed as scissors
    o is patchbreak line - processed as patchbreak
    o is blank line - ignored if in header_stage
    o is none of the above - log message
  o fails UTF-8 conversion - input error

As for the result left in "line" (after the invocation of
handle_commit_msg), it is unused (by its caller, handle_filter, and by
handle_filter's callers, handle_boundary and handle_body) unless this
line is a patchbreak line, in which case handle_patch is subsequently
called (in handle_filter) on "line". In this case, "line" must have
passed UTF-8 conversion both before and after this patch, so the result
is still the same overall.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 mailinfo.c | 145 ++++++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 115 insertions(+), 30 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index e19abe3..23a56c2 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -340,23 +340,56 @@ static struct strbuf *decode_b_segment(const struct strbuf *b_seg)
 	return out;
 }
 
-static int convert_to_utf8(struct mailinfo *mi,
-			   struct strbuf *line, const char *charset)
+/*
+ * Attempts to convert line into UTF-8, storing the result in line.
+ *
+ * This differs from convert_to_utf8 in that conversion non-success is not
+ * considered an error case - mi->input_error is not set, and no error message
+ * is printed.
+ *
+ * If the conversion is unnecessary, returns 0 and stores NULL in old_buf (if
+ * old_buf is not NULL).
+ *
+ * If the conversion is successful, returns 0 and stores the unconverted string
+ * in old_buf and old_len (if they are respectively not NULL).
+ *
+ * If the conversion is unsuccessful, returns -1.
+ */
+static int try_convert_to_utf8(const struct mailinfo *mi, struct strbuf *line,
+			       const char *charset, char **old_buf,
+			       size_t *old_len)
 {
-	char *out;
+	char *utf8;
 
-	if (!mi->metainfo_charset || !charset || !*charset)
+	if (!mi->metainfo_charset || !charset || !*charset ||
+	    same_encoding(mi->metainfo_charset, charset)) {
+		if (old_buf)
+			*old_buf = NULL;
 		return 0;
+	}
 
-	if (same_encoding(mi->metainfo_charset, charset))
+	utf8 = reencode_string(line->buf, mi->metainfo_charset, charset);
+	if (utf8) {
+		char *temp = strbuf_detach(line, old_len);
+		if (old_buf)
+			*old_buf = temp;
+		strbuf_attach(line, utf8, strlen(utf8), strlen(utf8));
 		return 0;
-	out = reencode_string(line->buf, mi->metainfo_charset, charset);
-	if (!out) {
+	}
+	return -1;
+}
+
+/*
+ * Converts line into UTF-8, setting mi->input_error to -1 upon failure.
+ */
+static int convert_to_utf8(struct mailinfo *mi,
+			   struct strbuf *line, const char *charset)
+{
+	if (try_convert_to_utf8(mi, line, charset, NULL, NULL)) {
 		mi->input_error = -1;
 		return error("cannot convert from %s to %s",
 			     charset, mi->metainfo_charset);
 	}
-	strbuf_attach(line, out, strlen(out), strlen(out));
 	return 0;
 }
 
@@ -515,6 +548,13 @@ static int check_header(struct mailinfo *mi,
 	return ret;
 }
 
+static int check_header_raw(struct mailinfo *mi,
+			    char *buf, size_t len,
+			    struct strbuf *hdr_data[], int overwrite) {
+	const struct strbuf sb = {0, len, buf};
+	return check_header(mi, &sb, hdr_data, overwrite);
+}
+
 static void decode_transfer_encoding(struct mailinfo *mi, struct strbuf *line)
 {
 	struct strbuf *ret;
@@ -623,32 +663,48 @@ static int is_scissors_line(const struct strbuf *line)
 		gap * 2 < perforation);
 }
 
-static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
+static int resembles_rfc2822_header(const struct strbuf *line)
 {
-	assert(!mi->filter_stage);
+	char *c;
 
-	if (mi->header_stage) {
-		if (!line->len || (line->len == 1 && line->buf[0] == '\n'))
+	if (!isalpha(line->buf[0]))
+		return 0;
+
+	for (c = line->buf + 1; *c != 0; c++) {
+		if (*c == ':')
+			return 1;
+		else if (*c != '-' && !isalpha(*c))
 			return 0;
 	}
+	return 0;
+}
 
-	if (mi->use_inbody_headers && mi->header_stage) {
-		mi->header_stage = check_header(mi, line, mi->s_hdr_data, 0);
-		if (mi->header_stage)
-			return 0;
-	} else
-		/* Only trim the first (blank) line of the commit message
-		 * when ignoring in-body headers.
-		 */
-		mi->header_stage = 0;
+static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
+{
+	int ret = 0;
+	int utf8_result;
+	char *old_buf;
+	size_t old_len;
+
+	assert(!mi->filter_stage);
 
-	/* normalize the log message to UTF-8. */
-	if (convert_to_utf8(mi, line, mi->charset.buf))
-		return 0; /* mi->input_error already set */
+	/*
+	 * Obtain UTF8 for scissors line and patchbreak checks, but retain the
+	 * undecoded line in case we need to process it as an in-body header.
+	 */
+	utf8_result = try_convert_to_utf8(mi, line, mi->charset.buf, &old_buf,
+					  &old_len);
 
-	if (mi->use_scissors && is_scissors_line(line)) {
+	if (!utf8_result && mi->use_scissors && is_scissors_line(line)) {
 		int i;
 
+		if (resembles_rfc2822_header(line))
+			/*
+			 * Explicitly reject scissor lines that resemble a RFC
+			 * 2822 header, to avoid being prone to error.
+			 */
+			die("scissors line resembles RFC 2822 header");
+
 		strbuf_setlen(&mi->log_message, 0);
 		mi->header_stage = 1;
 
@@ -661,18 +717,47 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 				strbuf_release(mi->s_hdr_data[i]);
 			mi->s_hdr_data[i] = NULL;
 		}
-		return 0;
+		goto handle_commit_msg_out;
 	}
-
-	if (patchbreak(line)) {
+	if (!utf8_result && patchbreak(line)) {
 		if (mi->message_id)
 			strbuf_addf(&mi->log_message,
 				    "Message-Id: %s\n", mi->message_id);
-		return 1;
+		ret = 1;
+		goto handle_commit_msg_out;
 	}
 
+	if (mi->header_stage) {
+		char *buf = old_buf ? old_buf : line->buf;
+		if (buf[0] == 0 || (buf[0] == '\n' && buf[1] == 0))
+			goto handle_commit_msg_out;
+	}
+
+	if (mi->use_inbody_headers && mi->header_stage) {
+		char *buf = old_buf ? old_buf : line->buf;
+		size_t len = old_buf ? old_len : line->len;
+		mi->header_stage = check_header_raw(mi, buf, len,
+						    mi->s_hdr_data, 0);
+		if (mi->header_stage)
+			goto handle_commit_msg_out;
+	} else
+		/* Only trim the first (blank) line of the commit message
+		 * when ignoring in-body headers.
+		 */
+		mi->header_stage = 0;
+
+	/* If adding as a log message, conversion to UTF-8 is required. */
+	if (utf8_result) {
+		mi->input_error = -1;
+		error("cannot convert from %s to %s",
+		      mi->charset.buf, mi->metainfo_charset);
+		goto handle_commit_msg_out;
+	}
 	strbuf_addbuf(&mi->log_message, line);
-	return 0;
+
+handle_commit_msg_out:
+	free(old_buf);
+	return ret;
 }
 
 static void handle_patch(struct mailinfo *mi, const struct strbuf *line)
-- 
2.10.0.rc2.20.g5b18e70

