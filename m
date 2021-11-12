Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2132C433F5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 09:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8942460F45
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 09:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbhKLJoe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 04:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbhKLJod (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 04:44:33 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1519AC061766
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 01:41:43 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id n23so7558364pgh.8
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 01:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SPo0A9rJ9MTJa7mcEfUOC97IwRSWLjT58O9mYCTL/Jw=;
        b=clYyulwO0sZ+bOqJk5vhZqvgkNTEeleXSstUfQIowdeQUijSctPUuMxaK4pELCwSX1
         5/LnkOe6el4O8xfTfyXwC+BVXbKoouXoCEGwU4yX9Jgfbbf7YaE+tyuuOHS3krwL68sU
         9j8EVk+T9X2xpxpUGITQABKXYiWpZu88hSRuIDoTtuRkpm+JRNUNHpHFAweAFyXJqe4h
         Kovu3wjQo+dWQGxKlIR6+1rTTgoOYa6zIT2o2PYyhPQArOun48uaa24KyMvsgfIDuLHE
         CW4+HpApqggJoWcYzLPGWM+BQOsSTX1jfIoWi9gwXb3CStHGNOFGcaOvn0bCUfBEc27l
         H8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SPo0A9rJ9MTJa7mcEfUOC97IwRSWLjT58O9mYCTL/Jw=;
        b=Cu9tDxyVWwwASLnRCoA7gQ7C5qcD3zLs7SGgTQhUqA8O4ISgy3B7xz/gCDSMekYJQ2
         OX4v5B7232jbDIwKv9aTsqF2fNWSMVetprCdo9zZVgetI7L5yejgK0NUMFiB1Eb3Paka
         sJhmyKfvoI6XyAw6oqrEUzPYIrrl/WlS39zfCNBc+fAPM5EM3G2/uQLGb3ON+Uc71ne/
         +pqM9UbmJOsjzbJpPLY1/inf3jmFaURr7QZ2hczuRAO869mSB627zrm9I74SCZuDnSOK
         SefSq4JViuXNDv8vtKBluxEL869Y00GebtZ7/OdBhSy7rJzRmSCGMXG36GYbft6fTta1
         yC3g==
X-Gm-Message-State: AOAM533/uCzO11yknDB3n1fKFyP+AILM4pdYEQb3/UR+9Suj22W4878Q
        nSywhBXPchGNZHv/e/T/dS+TymMBPWQJ5gza
X-Google-Smtp-Source: ABdhPJzfSC2IWPCRppU9cA4DrrTfEbUMx8wX6K8YFJWzpv2QXvGqBktuUhHWEFzdmJMCPdumGLuRRg==
X-Received: by 2002:a63:9a12:: with SMTP id o18mr9183650pge.419.1636710102584;
        Fri, 12 Nov 2021 01:41:42 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.100])
        by smtp.gmail.com with ESMTPSA id q18sm6310103pfj.46.2021.11.12.01.41.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Nov 2021 01:41:42 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v2 1/6] object-file: refactor write_loose_object() to support inputstream
Date:   Fri, 12 Nov 2021 17:40:05 +0800
Message-Id: <20211112094010.73468-1-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.33.1.44.g9344627884.agit.6.5.4
In-Reply-To: <20211009082058.41138-1-chiyutianyi@gmail.com>
References: <20211009082058.41138-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

Refactor write_loose_object() to support inputstream, in the same way
that zlib reading is chunked.

Using "in_stream" instead of "void *buf", we needn't to allocate enough
memory in advance, and only part of the contents will be read when
called "in_stream.read()".

Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 object-file.c  | 50 ++++++++++++++++++++++++++++++++++++++++++++++----
 object-store.h |  5 +++++
 2 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/object-file.c b/object-file.c
index 02b7970274..1ad2cb579c 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1860,8 +1860,26 @@ static int create_tmpfile(struct strbuf *tmp, const char *filename)
 	return fd;
 }
 
+struct input_data_from_buffer {
+	const char *buf;
+	unsigned long len;
+};
+
+static const char *read_input_stream_from_buffer(void *data, unsigned long *len)
+{
+	struct input_data_from_buffer *input = (struct input_data_from_buffer *)data;
+
+	if (input->len == 0) {
+		*len = 0;
+		return NULL;
+	}
+	*len = input->len;
+	input->len = 0;
+	return input->buf;
+}
+
 static int write_loose_object(const struct object_id *oid, char *hdr,
-			      int hdrlen, const void *buf, unsigned long len,
+			      int hdrlen, struct input_stream *in_stream,
 			      time_t mtime, unsigned flags)
 {
 	int fd, ret;
@@ -1871,6 +1889,8 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	struct object_id parano_oid;
 	static struct strbuf tmp_file = STRBUF_INIT;
 	static struct strbuf filename = STRBUF_INIT;
+	const char *buf;
+	unsigned long len;
 
 	loose_object_path(the_repository, &filename, oid);
 
@@ -1898,6 +1918,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	the_hash_algo->update_fn(&c, hdr, hdrlen);
 
 	/* Then the data itself.. */
+	buf = in_stream->read(in_stream->data, &len);
 	stream.next_in = (void *)buf;
 	stream.avail_in = len;
 	do {
@@ -1960,6 +1981,13 @@ int write_object_file_flags(const void *buf, unsigned long len,
 {
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen = sizeof(hdr);
+	struct input_stream in_stream = {
+		.read = read_input_stream_from_buffer,
+		.data = (void *)&(struct input_data_from_buffer) {
+			.buf = buf,
+			.len = len,
+		},
+	};
 
 	/* Normally if we have it in the pack then we do not bother writing
 	 * it out into .git/objects/??/?{38} file.
@@ -1968,7 +1996,7 @@ int write_object_file_flags(const void *buf, unsigned long len,
 				  &hdrlen);
 	if (freshen_packed_object(oid) || freshen_loose_object(oid))
 		return 0;
-	return write_loose_object(oid, hdr, hdrlen, buf, len, 0, flags);
+	return write_loose_object(oid, hdr, hdrlen, &in_stream, 0, flags);
 }
 
 int hash_object_file_literally(const void *buf, unsigned long len,
@@ -1977,6 +2005,13 @@ int hash_object_file_literally(const void *buf, unsigned long len,
 {
 	char *header;
 	int hdrlen, status = 0;
+	struct input_stream in_stream = {
+		.read = read_input_stream_from_buffer,
+		.data = (void *)&(struct input_data_from_buffer) {
+			.buf = buf,
+			.len = len,
+		},
+	};
 
 	/* type string, SP, %lu of the length plus NUL must fit this */
 	hdrlen = strlen(type) + MAX_HEADER_LEN;
@@ -1988,7 +2023,7 @@ int hash_object_file_literally(const void *buf, unsigned long len,
 		goto cleanup;
 	if (freshen_packed_object(oid) || freshen_loose_object(oid))
 		goto cleanup;
-	status = write_loose_object(oid, header, hdrlen, buf, len, 0, 0);
+	status = write_loose_object(oid, header, hdrlen, &in_stream, 0, 0);
 
 cleanup:
 	free(header);
@@ -2003,14 +2038,21 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen;
 	int ret;
+	struct input_data_from_buffer data;
+	struct input_stream in_stream = {
+		.read = read_input_stream_from_buffer,
+		.data = &data,
+	};
 
 	if (has_loose_object(oid))
 		return 0;
 	buf = read_object(the_repository, oid, &type, &len);
 	if (!buf)
 		return error(_("cannot read object for %s"), oid_to_hex(oid));
+	data.buf = buf;
+	data.len = len;
 	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(type), (uintmax_t)len) + 1;
-	ret = write_loose_object(oid, hdr, hdrlen, buf, len, mtime, 0);
+	ret = write_loose_object(oid, hdr, hdrlen, &in_stream, mtime, 0);
 	free(buf);
 
 	return ret;
diff --git a/object-store.h b/object-store.h
index 952efb6a4b..f1b67e9100 100644
--- a/object-store.h
+++ b/object-store.h
@@ -34,6 +34,11 @@ struct object_directory {
 	char *path;
 };
 
+struct input_stream {
+	const char *(*read)(void* data, unsigned long *len);
+	void *data;
+};
+
 KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
 	struct object_directory *, 1, fspathhash, fspatheq)
 
-- 
2.33.1.44.g9344627884.agit.6.5.4

