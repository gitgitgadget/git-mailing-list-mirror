Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C661CC433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 08:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C2A4613BD
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 08:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239204AbhDMIDa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 04:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbhDMIDR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 04:03:17 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648ABC061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 01:02:31 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id x12so3642295ejc.1
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 01:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=26tubh//y6q6ZVxcde/gRKaD4nR9UEf7Rb2YjqjnBF0=;
        b=NhHUbpPNVy4r3Dp0k1DETKf3svpw1H2Y4DAp0rnsvp7mXjGoXUUn1u0917TEOfvoN0
         VYqHaO+Ru4AyuFwnUE+WLTedIV76wovqnNIDB0bfXP1ep4uN2Ud7qpXM3LHxmA76Nwkp
         yPj4H5zGOdL8hsvNa4Vbfeo4YB2cAVOil8jBk+eZsD27Kf5JH6CjuQXO2ey13USGD8sX
         B5RpZuHsGTxoLrxc9IrOun1ZfTOOkY2kevsQXW2S5xHTEiF+19r9qV+IiTpCtWz/RNyj
         2gG0ZCasVrKMStF4kKsSLzPbvDxBZJnNWWGV5uYf/Cl/KPjhlESU5uEQvcIR9bVRYzDx
         p8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=26tubh//y6q6ZVxcde/gRKaD4nR9UEf7Rb2YjqjnBF0=;
        b=tePUXh77SwH5CJQhPZ8mU6EQU1mhCKc49SEx6zA0kre6Ssg1quPcUCs5k3w+NyQTQd
         Ts+X5nmSM15v/fJwbUKNyZI9N/z2Zv+pr8chhd6ZFdefcsDZILGy0oZbYs4e4ytXnT0V
         jk3lNW5scwtpwZCZlXs2IpWLNMda9QbX4fQbzJy2L4/CyrGtaH3+MPW74LZNvWSuDc5Z
         cCId/didMfL5dfe4wa9e1JR6mGV+4qCzAlozPxO959dZvk4qQF6iZfGWNAgLRCNZN0vv
         AQGn42WThM1Zrtl8dxw35LofyX/ufthCqXLEVv5AAfnSgVy+HkzmPJnXiYttOq/gM6qE
         1eSw==
X-Gm-Message-State: AOAM533IXXV/w3d0ilQ1BPt4fAkUl9NnyTv1FIPoR1Wfstb57EAhwo/v
        K0wJzV6Z0WkAECYQMOgEYpRRFiMtTE35IA==
X-Google-Smtp-Source: ABdhPJxryDHJbSsBepS9yx0BE6JePCoz/Th227Qgvrk1Mvi39zJO57Tx+U2d8uv/LyU1DB6zq0DT5w==
X-Received: by 2002:a17:906:350e:: with SMTP id r14mr4403722eja.365.1618300949625;
        Tue, 13 Apr 2021 01:02:29 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id s20sm8564378edu.93.2021.04.13.01.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 01:02:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v6 04/20] reftable: utility functions
References: <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
 <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
 <df8003cb9a7d9e017d358251a2d22c0e72454e03.1618255552.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <df8003cb9a7d9e017d358251a2d22c0e72454e03.1618255552.git.gitgitgadget@gmail.com>
Date:   Tue, 13 Apr 2021 10:02:28 +0200
Message-ID: <87czuyehnv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 12 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> +int strbuf_add_void(void *b, const void *data, size_t sz)
> +{
> +	strbuf_add((struct strbuf *)b, data, sz);
> +	return sz;
> +}

Is that cast needed on your compiler? This compiles without warnings for
me without that.

Also, maybe this is the sort of thing that makes sense to split into
general "APIs needed for reftable" patches. E.g. something like the
below (just the strbuf.h change):

diff --git a/reftable/merged_test.c b/reftable/merged_test.c
index 0c301cecced..e49029eed34 100644
--- a/reftable/merged_test.c
+++ b/reftable/merged_test.c
@@ -43,7 +43,7 @@ static void write_test_table(struct strbuf *buf,
 		}
 	}
 
-	w = reftable_new_writer(&strbuf_add_void, buf, &opts);
+	w = reftable_new_writer(&strbuf_add_write, buf, &opts);
 	reftable_writer_set_limits(w, min, max);
 
 	for (i = 0; i < n; i++) {
@@ -241,7 +241,7 @@ static void test_default_write_opts(void)
 	struct reftable_write_options opts = { 0 };
 	struct strbuf buf = STRBUF_INIT;
 	struct reftable_writer *w =
-		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+		reftable_new_writer(&strbuf_add_write, &buf, &opts);
 
 	struct reftable_ref_record rec = {
 		.refname = "master",
diff --git a/reftable/refname_test.c b/reftable/refname_test.c
index 5e005d6af31..e8ecba1fad9 100644
--- a/reftable/refname_test.c
+++ b/reftable/refname_test.c
@@ -31,7 +31,7 @@ static void test_conflict(void)
 	struct reftable_write_options opts = { 0 };
 	struct strbuf buf = STRBUF_INIT;
 	struct reftable_writer *w =
-		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+		reftable_new_writer(&strbuf_add_write, &buf, &opts);
 	struct reftable_ref_record rec = {
 		.refname = "a/b",
 		.value_type = REFTABLE_REF_SYMREF,
diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index 9d2f8d60555..bdef4813f4c 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -83,7 +83,7 @@ struct reftable_stats {
 
 /* reftable_new_writer creates a new writer */
 struct reftable_writer *
-reftable_new_writer(int (*writer_func)(void *, const void *, size_t),
+reftable_new_writer(ssize_t (*writer_func)(void *, const void *, size_t),
 		    void *writer_arg, struct reftable_write_options *opts);
 
 /* Set the range of update indices for the records we will add. When writing a
diff --git a/reftable/reftable_test.c b/reftable/reftable_test.c
index 69dbfb09fff..1685b9a07bc 100644
--- a/reftable/reftable_test.c
+++ b/reftable/reftable_test.c
@@ -52,7 +52,7 @@ static void write_table(char ***names, struct strbuf *buf, int N,
 		.hash_id = hash_id,
 	};
 	struct reftable_writer *w =
-		reftable_new_writer(&strbuf_add_void, buf, &opts);
+		reftable_new_writer(&strbuf_add_write, buf, &opts);
 	struct reftable_ref_record ref = { NULL };
 	int i = 0, n;
 	struct reftable_log_record log = { NULL };
@@ -131,7 +131,7 @@ static void test_log_buffer_size(void)
 						   .message = "commit: 9\n",
 					   } };
 	struct reftable_writer *w =
-		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+		reftable_new_writer(&strbuf_add_write, &buf, &opts);
 
 	/* This tests buffer extension for log compression. Must use a random
 	   hash, to ensure that the compressed part is larger than the original.
@@ -169,7 +169,7 @@ static void test_log_write_read(void)
 	struct reftable_block_source source = { NULL };
 	struct strbuf buf = STRBUF_INIT;
 	struct reftable_writer *w =
-		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+		reftable_new_writer(&strbuf_add_write, &buf, &opts);
 	const struct reftable_stats *stats = NULL;
 	reftable_writer_set_limits(w, 0, N);
 	for (i = 0; i < N; i++) {
@@ -437,7 +437,7 @@ static void test_table_refs_for(int indexed)
 
 	struct strbuf buf = STRBUF_INIT;
 	struct reftable_writer *w =
-		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+		reftable_new_writer(&strbuf_add_write, &buf, &opts);
 
 	struct reftable_iterator it = { NULL };
 	int j;
@@ -534,7 +534,7 @@ static void test_table_empty(void)
 	struct reftable_write_options opts = { 0 };
 	struct strbuf buf = STRBUF_INIT;
 	struct reftable_writer *w =
-		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+		reftable_new_writer(&strbuf_add_write, &buf, &opts);
 	struct reftable_block_source source = { NULL };
 	struct reftable_reader *rd = NULL;
 	struct reftable_ref_record rec = { NULL };
diff --git a/reftable/stack.c b/reftable/stack.c
index 3cdb6e8ed33..2e3fd8db1dd 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -39,7 +39,7 @@ static void stack_filename(struct strbuf *dest, struct reftable_stack *st,
 	strbuf_addstr(dest, name);
 }
 
-static int reftable_fd_write(void *arg, const void *data, size_t sz)
+static ssize_t reftable_fd_write(void *arg, const void *data, size_t sz)
 {
 	int *fdp = (int *)arg;
 	return write(*fdp, data, sz);
diff --git a/reftable/test_framework.c b/reftable/test_framework.c
index a5ff4e2a2d2..e5e39fe8b13 100644
--- a/reftable/test_framework.c
+++ b/reftable/test_framework.c
@@ -15,9 +15,3 @@ void set_test_hash(uint8_t *p, int i)
 {
 	memset(p, (uint8_t)i, hash_size(SHA1_ID));
 }
-
-int strbuf_add_void(void *b, const void *data, size_t sz)
-{
-	strbuf_add((struct strbuf *)b, data, sz);
-	return sz;
-}
diff --git a/reftable/test_framework.h b/reftable/test_framework.h
index 5fdc9519a5a..c04925ea11d 100644
--- a/reftable/test_framework.h
+++ b/reftable/test_framework.h
@@ -46,8 +46,4 @@ license that can be found in the LICENSE file or at
 
 void set_test_hash(uint8_t *p, int i);
 
-/* Like strbuf_add, but suitable for passing to reftable_new_writer
- */
-int strbuf_add_void(void *b, const void *data, size_t sz);
-
 #endif
diff --git a/reftable/writer.c b/reftable/writer.c
index d42ca8afac1..ca3b127f83d 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -118,7 +118,7 @@ static void writer_reinit_block_writer(struct reftable_writer *w, uint8_t typ)
 static struct strbuf reftable_empty_strbuf = STRBUF_INIT;
 
 struct reftable_writer *
-reftable_new_writer(int (*writer_func)(void *, const void *, size_t),
+reftable_new_writer(ssize_t (*writer_func)(void *, const void *, size_t),
 		    void *writer_arg, struct reftable_write_options *opts)
 {
 	struct reftable_writer *wp =
diff --git a/reftable/writer.h b/reftable/writer.h
index 4921c249d06..09b88673d97 100644
--- a/reftable/writer.h
+++ b/reftable/writer.h
@@ -15,7 +15,7 @@ license that can be found in the LICENSE file or at
 #include "reftable-writer.h"
 
 struct reftable_writer {
-	int (*write)(void *, const void *, size_t);
+	ssize_t (*write)(void *, const void *, size_t);
 	void *write_arg;
 	int pending_padding;
 	struct strbuf last_key;
diff --git a/strbuf.h b/strbuf.h
index 223ee2094af..e3ae5b8a9d3 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -290,6 +290,18 @@ void strbuf_add_commented_lines(struct strbuf *out,
  */
 void strbuf_add(struct strbuf *sb, const void *data, size_t len);
 
+/**
+ * Like strbuf_add() but emulates write() for APIs that need
+ * it. Returns the passed-in `len` as-is. The `void *` is really a
+ * `struct strbuf *`.
+ */
+static inline ssize_t strbuf_add_write(void *sb, const void *data,
+				       size_t len)
+{
+	strbuf_add(sb, data, len);
+	return len;
+}
+
 /**
  * Add a NUL-terminated string to the buffer.
  *
