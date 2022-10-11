Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAA7C433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 00:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJKAfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 20:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiJKAem (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 20:34:42 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1B680EB6
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 17:34:24 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id p16so3996634iod.6
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 17:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lstkDFq4jfz2nw9TugaLNsUmK6wX8r1Og41n5T4pgV0=;
        b=QhYFB7Dd8YC+8dj9dmVolt8ZFazsdZLFEGIkIwrPs36cZ/QxoIjUr5W6NlNeLpB6bq
         1G7IZyDE0opCCikfSL6we3Pi5EEW1UY948ilgl+sT+TBjkJPNLSkmuropZYi8TEqsZ+1
         cXQwpPuNdAbSO3kLppkil3mf1L0Yth9CNicszGOTeKZPyDJ16NDRdjXvkIUlNiRIIQMw
         1lBbfthpHz2wnN+faEW355kRdkx5qQBtdSweCvSp1zLulWwTe+9FftYQ7LTseEt2YtNA
         OEANq8i2nnwnpackwbf+GFGaUuaj3/OtYS8Kah66scrlLsORcYe0KUhmnhnbYsRtBkQR
         q/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lstkDFq4jfz2nw9TugaLNsUmK6wX8r1Og41n5T4pgV0=;
        b=pedyBv6s6PSlSuddbH9OHjjk0FzCIw8gYTLWHA8hCZu0yYHYCTikAOphFeojAPMpuR
         v9mEPmXjeEsm0V0668fmwB9ZTWW+V1Hsby5cPOwWdSy2XTA1K83rwOSLfGNzbmU2ueoy
         KYGCrpR53HJ5mtMaLRAprvaG99THld01mR3nXx/JC/6KIvXbVJFKR6NIleitUnE09G6y
         jIashv+qAu1pQRH6HUI0M7D7v2AIQQBZ4y/ARjTkZrTTqlz+wlS8cxHwVn8f5WKeMIWY
         IO4BQMvd5Osjq/nX3Lgxgww1faeFU/zlZ3jwG5szlkWlJv6X46oUgdvA5KklnXTG0bQp
         BoDg==
X-Gm-Message-State: ACrzQf14tfM6KGSHcTJkPssF0LOjeIkATZucqxVRuzQA4x8UPKRebQp9
        bpFnJ9sEUyCvL/LpcyZ6W9o23rJfBY8E0qP5
X-Google-Smtp-Source: AMsMyM679dARYVJBNYOJfZZ9340gBHC7HtVVMhRA3O/ejzyrF8ce7vbS+92amfd4RGLWka0LMw9Rsw==
X-Received: by 2002:a5d:9411:0:b0:6a7:f7ec:6dd8 with SMTP id v17-20020a5d9411000000b006a7f7ec6dd8mr9596025ion.44.1665448462765;
        Mon, 10 Oct 2022 17:34:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v15-20020a056602058f00b006bbe7f012b9sm3307514iox.8.2022.10.10.17.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 17:34:22 -0700 (PDT)
Date:   Mon, 10 Oct 2022 20:34:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     jacob@initialcommit.io, peff@peff.net, gitster@pobox.com
Subject: [PATCH 7/7] shortlog: implement `--group=trailer` in terms of
 `--group=<format>`
Message-ID: <02adc297e7661cbc25302b9f5659d2356b8b5008.1665448437.git.me@ttaylorr.com>
References: <cover.1665448437.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1665448437.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the same spirit as the previous commit, reimplement
`--group=trailer:<key>` as a special case of `--group=<format>`, too.

Unsurprisingly, this reimplementation is a little bit more complicated
than the previous two. The complexity stems from having to enumerate
each of the trailers one-by-one, as well as delegating control to
`parse_ident()` to handle whether or not to show an individual's email.

To enumerate each trailer in a commit, we set the separator used in the
pretty format to be a NUL byte. This hack allows us to treat the strbuf
from `format_commit_message()` as an array of strings.

Since this handling is unique to the `--group:trailer` mode, use `util`
bit in the `string_list_entry` to signal which `<format>`s came from
`--group:trailer` arguments (and thus need special treatment).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/shortlog.c | 66 ++++++++++++++++++----------------------------
 shortlog.h         |  1 -
 2 files changed, 25 insertions(+), 42 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index b46df179fe..e8cf727342 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -162,44 +162,30 @@ static void read_from_stdin(struct shortlog *log)
 	strbuf_release(&oneline);
 }
 
-static void insert_records_from_trailers(struct shortlog *log,
-					 struct strset *dups,
-					 struct commit *commit,
-					 struct pretty_print_context *ctx,
-					 const char *oneline)
+static void insert_records_from_trailer(struct shortlog *log,
+					struct strset *dups,
+					struct strbuf *buf,
+					struct pretty_print_context *ctx,
+					const char *oneline)
 {
-	struct trailer_iterator iter;
-	const char *commit_buffer, *body;
-	struct strbuf ident = STRBUF_INIT;
+	struct strbuf ibuf = STRBUF_INIT;
+	char *bol = buf->buf;
+	char *value;
 
-	/*
-	 * Using format_commit_message("%B") would be simpler here, but
-	 * this saves us copying the message.
-	 */
-	commit_buffer = logmsg_reencode(commit, NULL, ctx->output_encoding);
-	body = strstr(commit_buffer, "\n\n");
-	if (!body)
-		return;
+	while (bol < buf->buf + buf->len) {
+		strbuf_reset(&ibuf);
 
-	trailer_iterator_init(&iter, body);
-	while (trailer_iterator_advance(&iter)) {
-		const char *value = iter.val.buf;
+		value = bol;
+		if (!parse_ident(log, &ibuf, bol))
+			value = ibuf.buf;
 
-		if (!string_list_has_string(&log->trailers, iter.key.buf))
-			continue;
+		if (strset_add(dups, value))
+			insert_one_record(log, value, oneline);
 
-		strbuf_reset(&ident);
-		if (!parse_ident(log, &ident, value))
-			value = ident.buf;
-
-		if (!strset_add(dups, value))
-			continue;
-		insert_one_record(log, value, oneline);
+		bol += strlen(bol) + 1;
 	}
-	trailer_iterator_release(&iter);
 
-	strbuf_release(&ident);
-	unuse_commit_buffer(commit, commit_buffer);
+	strbuf_release(&ibuf);
 }
 
 static void insert_records_from_format(struct shortlog *log,
@@ -216,7 +202,10 @@ static void insert_records_from_format(struct shortlog *log,
 
 		format_commit_message(commit, item->string, &buf, ctx);
 
-		if (strset_add(dups, buf.buf))
+		if (item->util)
+			insert_records_from_trailer(log, dups, &buf, ctx,
+						    oneline);
+		else if (strset_add(dups, buf.buf))
 			insert_one_record(log, buf.buf, oneline);
 	}
 
@@ -244,9 +233,6 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	}
 	oneline_str = oneline.len ? oneline.buf : "<none>";
 
-	if (log->groups & SHORTLOG_GROUP_TRAILER) {
-		insert_records_from_trailers(log, &dups, commit, &ctx, oneline_str);
-	}
 	insert_records_from_format(log, &dups, commit, &ctx, oneline_str);
 
 	strset_clear(&dups);
@@ -317,15 +303,17 @@ static int parse_group_option(const struct option *opt, const char *arg, int uns
 
 	if (unset) {
 		log->groups = 0;
-		string_list_clear(&log->trailers, 0);
 		string_list_clear(&log->format, 0);
 	} else if (!strcasecmp(arg, "author"))
 		log->groups |= SHORTLOG_GROUP_AUTHOR;
 	else if (!strcasecmp(arg, "committer"))
 		log->groups |= SHORTLOG_GROUP_COMMITTER;
 	else if (skip_prefix(arg, "trailer:", &field)) {
+		struct strbuf buf = STRBUF_INIT;
 		log->groups |= SHORTLOG_GROUP_TRAILER;
-		string_list_append(&log->trailers, field);
+		strbuf_addf(&buf, "%%(trailers:key=%s,valueonly=true,separator=%%x00)", field);
+		string_list_append(&log->format, buf.buf)->util = (void*)1;
+		strbuf_release(&buf);
 	} else if (strchrnul(arg, '%')) {
 		log->groups |= SHORTLOG_GROUP_FORMAT;
 		string_list_append(&log->format, arg);
@@ -347,8 +335,6 @@ void shortlog_init(struct shortlog *log)
 	log->wrap = DEFAULT_WRAPLEN;
 	log->in1 = DEFAULT_INDENT1;
 	log->in2 = DEFAULT_INDENT2;
-	log->trailers.strdup_strings = 1;
-	log->trailers.cmp = strcasecmp;
 	log->format.strdup_strings = 1;
 }
 
@@ -434,8 +420,6 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 
 	shortlog_init_group(&log);
 
-	string_list_sort(&log.trailers);
-
 	/* assume HEAD if from a tty */
 	if (!nongit && !rev.pending.nr && isatty(0))
 		add_head_to_pending(&rev);
diff --git a/shortlog.h b/shortlog.h
index e52f001fb7..ac844394a8 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -24,7 +24,6 @@ struct shortlog {
 		SHORTLOG_GROUP_TRAILER = (1 << 2),
 		SHORTLOG_GROUP_FORMAT = (1 << 3),
 	} groups;
-	struct string_list trailers;
 	struct string_list format;
 
 	int email;
-- 
2.37.0.1.g1379af2e9d
