Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB7238DF1
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 06:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5OI6VWB"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d604b4b30so28166055e9.1
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 22:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704869493; x=1705474293; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7COct+8+WEna7hs7utinyouT7wLiyPcBuZMs7kZSJU=;
        b=J5OI6VWBeyH/QdYaysNzSlkjXQj88C4Iv+n1CqTngl3dtQVBodLgRPu/j/D3ccFtSV
         h5L9fvBRB9qoju/Ge20xConY6t2zPm9juCgrVKnVTC5mhKZjJr8g61UnA/sSM3ZTkevG
         cu9QMqOD1B/zyq+wvy/l+nJexmhy6Ym4OEMgwujNk7V7Ipo6cJ73QEdW4dm9aJhNqqTA
         1kDjXnItswqdoOoHVZpgpg/XWXnm9EBjEhBb1uRleCwHWlSjw3tEJP2xjZxCb4je6bJF
         s32YNoUxOrQQz8GTjU6stQWPixn3JfbUQR67ILQigb+q6gTLrrcK2IJKltMz84xdwVNQ
         RvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704869493; x=1705474293;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7COct+8+WEna7hs7utinyouT7wLiyPcBuZMs7kZSJU=;
        b=u6lC3ct+6xlSIQyglNiq6ve0dZmWB9I3lnxzJAV32ldXiK/WL3DPJpHtIFpPpRL0d0
         n9uKSR2wF1iZejP0hGe9qEFNZCPUioSTGBESLVxoX/eWVZZHg1ZH3aCHriSlYzfj391k
         E6FSGNjpHznQvqcgSX3a0RuGQ70FGFENVa0Dr7+fTufrj8xgjUdLpJqvwamPnrSCPZkD
         q9xo06h0U2535g/lb3NGarEG+74iws4ZEUGWCRlTi7EwoasAUjJELmfDgI59+0EOBU1r
         YTJAkTAPpowa3LULAsvDa2q6GDqwMDy0ho+e4rzOHfpCCXyfg/n+8alvw/O/zTll+JVm
         FULw==
X-Gm-Message-State: AOJu0YzX95b/DxtUKQBUgKyW1jlIaDPkaeTGscQ9nJSeoyTfGpJfgzWr
	2Z4ZDQRaGIoeX9S6WYAmNqXQWOR7KQQ=
X-Google-Smtp-Source: AGHT+IG3KmD3J9I63f9Pl22PTkNYsZmZdHgNgetijtyDPPcxCucMJIdyCqIot8LPL3RpxAqTUdp9+Q==
X-Received: by 2002:a05:600c:1551:b0:40e:4eed:dab8 with SMTP id f17-20020a05600c155100b0040e4eeddab8mr302021wmg.129.1704869493140;
        Tue, 09 Jan 2024 22:51:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u13-20020a05600c19cd00b0040e34ca648bsm1031528wmq.0.2024.01.09.22.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 22:51:32 -0800 (PST)
Message-ID: <fd4a9d54d9522973a4c22e43cb1d7964033d4837.1704869487.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 10 Jan 2024 06:51:21 +0000
Subject: [PATCH 05/10] sequencer: use the trailer iterator
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Emily Shaffer <nasamuffin@google.com>,
    Junio C Hamano <gitster@pobox.com>,
    Christian Couder <chriscool@tuxfamily.org>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

This patch allows for the removal of "trailer_info_get()" from the
trailer.h API, which will be in the next patch.

Instead of calling "trailer_info_get()", which is a low-level function
in the trailers implementation (trailer.c), call
trailer_iterator_advance(), which was specifically designed for public
consumption in f0939a0eb1 (trailer: add interface for iterating over
commit trailers, 2020-09-27).

Avoiding "trailer_info_get()" means we don't have to worry about options
like "no_divider" (relevant for parsing trailers). We also don't have to
check for things like "info.trailer_start == info.trailer_end" to see
whether there were any trailers (instead we can just check to see
whether the iterator advanced at all).

Also, teach the iterator about non-trailer lines, by adding a new field
called "raw" to hold both trailer and non-trailer lines. This is
necessary because a "trailer block" is a list of trailer lines of at
least 25% trailers (see 146245063e (trailer: allow non-trailers in
trailer block, 2016-10-21)), such that it may hold non-trailer lines.

Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/shortlog.c |  7 +++++--
 sequencer.c        | 35 +++++++++++++++--------------------
 trailer.c          | 20 ++++++++++++--------
 trailer.h          | 13 +++++++++++++
 4 files changed, 45 insertions(+), 30 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 1307ed2b88a..dc8fd5a5532 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -172,7 +172,7 @@ static void insert_records_from_trailers(struct shortlog *log,
 					 const char *oneline)
 {
 	struct trailer_iterator iter;
-	const char *commit_buffer, *body;
+	const char *commit_buffer, *body, *value;
 	struct strbuf ident = STRBUF_INIT;
 
 	if (!log->trailers.nr)
@@ -190,7 +190,10 @@ static void insert_records_from_trailers(struct shortlog *log,
 
 	trailer_iterator_init(&iter, body);
 	while (trailer_iterator_advance(&iter)) {
-		const char *value = iter.val.buf;
+		if (!iter.is_trailer)
+			continue;
+
+		value = iter.val.buf;
 
 		if (!string_list_has_string(&log->trailers, iter.key.buf))
 			continue;
diff --git a/sequencer.c b/sequencer.c
index 3cc88d8a800..d199869cda9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -319,37 +319,32 @@ static const char *get_todo_path(const struct replay_opts *opts)
 static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
 	size_t ignore_footer)
 {
-	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
-	struct trailer_info info;
-	size_t i;
-	int found_sob = 0, found_sob_last = 0;
-	char saved_char;
-
-	opts.no_divider = 1;
+	struct trailer_iterator iter;
+	size_t i = 0, found_sob = 0;
+	char saved_char = sb->buf[sb->len - ignore_footer];
 
 	if (ignore_footer) {
-		saved_char = sb->buf[sb->len - ignore_footer];
 		sb->buf[sb->len - ignore_footer] = '\0';
 	}
 
-	trailer_info_get(&info, sb->buf, &opts);
+	trailer_iterator_init(&iter, sb->buf);
+	while (trailer_iterator_advance(&iter)) {
+		i++;
+		if (sob &&
+		    iter.is_trailer &&
+		    !strncmp(iter.raw.buf, sob->buf, sob->len)) {
+			found_sob = i;
+		}
+	}
+	trailer_iterator_release(&iter);
 
 	if (ignore_footer)
 		sb->buf[sb->len - ignore_footer] = saved_char;
 
-	if (info.trailer_block_start == info.trailer_block_end)
+	if (!i)
 		return 0;
 
-	for (i = 0; i < info.trailer_nr; i++)
-		if (sob && !strncmp(info.trailers[i], sob->buf, sob->len)) {
-			found_sob = 1;
-			if (i == info.trailer_nr - 1)
-				found_sob_last = 1;
-		}
-
-	trailer_info_release(&info);
-
-	if (found_sob_last)
+	if (found_sob == i)
 		return 3;
 	if (found_sob)
 		return 2;
diff --git a/trailer.c b/trailer.c
index 132f22b3dd7..593717fd56c 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1151,6 +1151,7 @@ void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
 	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
 	strbuf_init(&iter->key, 0);
 	strbuf_init(&iter->val, 0);
+	strbuf_init(&iter->raw, 0);
 	opts.no_divider = 1;
 	trailer_info_get(&iter->internal.info, msg, &opts);
 	iter->internal.cur = 0;
@@ -1158,17 +1159,19 @@ void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
 
 int trailer_iterator_advance(struct trailer_iterator *iter)
 {
-	while (iter->internal.cur < iter->internal.info.trailer_nr) {
-		char *trailer = iter->internal.info.trailers[iter->internal.cur++];
-		int separator_pos = find_separator(trailer, separators);
-
-		if (separator_pos < 1)
-			continue; /* not a real trailer */
-
+	char *line;
+	int separator_pos;
+	if (iter->internal.cur < iter->internal.info.trailer_nr) {
+		line = iter->internal.info.trailers[iter->internal.cur++];
+		separator_pos = find_separator(line, separators);
+		iter->is_trailer = (separator_pos > 0);
+
+		strbuf_reset(&iter->raw);
+		strbuf_addstr(&iter->raw, line);
 		strbuf_reset(&iter->key);
 		strbuf_reset(&iter->val);
 		parse_trailer(&iter->key, &iter->val, NULL,
-			      trailer, separator_pos);
+			      line, separator_pos);
 		unfold_value(&iter->val);
 		return 1;
 	}
@@ -1180,4 +1183,5 @@ void trailer_iterator_release(struct trailer_iterator *iter)
 	trailer_info_release(&iter->internal.info);
 	strbuf_release(&iter->val);
 	strbuf_release(&iter->key);
+	strbuf_release(&iter->raw);
 }
diff --git a/trailer.h b/trailer.h
index 50f70556302..d50c9fd79b2 100644
--- a/trailer.h
+++ b/trailer.h
@@ -127,6 +127,19 @@ struct trailer_iterator {
 	struct strbuf key;
 	struct strbuf val;
 
+	/*
+	 * Raw line (e.g., "foo: bar baz") before being parsed as a trailer
+	 * key/val pair. This field can contain non-trailer lines because it's
+	 * valid for a trailer block to contain such lines (i.e., we only
+	 * require 25% of the lines in a trailer block to be trailer lines).
+	 */
+	struct strbuf raw;
+
+	/*
+	 * 1 if the raw line was parsed as a separate key/val pair.
+	 */
+	int is_trailer;
+
 	/* private */
 	struct {
 		struct trailer_info info;
-- 
gitgitgadget

