Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC69C433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 12:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC8B7613AA
	for <git@archiver.kernel.org>; Wed,  5 May 2021 12:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbhEEMeo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 08:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbhEEMej (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 08:34:39 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41DAC06174A
        for <git@vger.kernel.org>; Wed,  5 May 2021 05:33:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a4so1658025wrr.2
        for <git@vger.kernel.org>; Wed, 05 May 2021 05:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZfGO7RIJIAYOuLDD8giuOt3vjmla9SsBk2AKjeg9+CQ=;
        b=vR+h+lknHXetk/XTE5Whh5U+AG8iKWzx8jULqe9eqg09DNMlr682IvBJLyqilDGeSi
         JkViOgN5YcarpwNR4ePQ5SuYxrmQ1sgQD1hiEpo6GE9DOh0Vwgaj6Tca8EfCpqV1kF2W
         7lijs7rvsuYtDHy2DqGK5VOEfb/JfFxb13krp6tKpmHAvF5BfrhluWXcHsB0KeTzd7jO
         GlFHBrZ4QARsPSV+TpiDnECaXU6rfH31OQtNEQAhwsnubLMswq6P/Mh0ncdfBgFtGWsz
         J/aics37CakGeo68HY91qydJLVzyiOpMEiVo/LRzgX8jl2JEFdbM+zfLlJBv1DLsFshi
         JQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZfGO7RIJIAYOuLDD8giuOt3vjmla9SsBk2AKjeg9+CQ=;
        b=CDafI8FEYBX5tAl7Ac70NOhSgxDKlaNBta1uu6PaHSTC6RbX2ebqFq0rJ8+siNWod3
         RLI2gkgTGjCV9oAvU3Bs1gEKEBRrqjntsYThiyuYZySKlGNl5fcBJsKFpMWZkmpWxTxe
         DrchLobXOd9hNuSbp+vClhSwv9kgUjK0j/b3mURijx/0eXIPH38VH/xbUmocLmfcsEtM
         Zz4W3qlbgG9QF5EwxxiVa/E/UGkpesiI27fZ0qxercH3XIftDN+2oqkuCrqw4pUKG/k3
         K/PFyY33F7xgllBf//QtZHKL8OFTKGFrwdvDkq9XZHye2fS2yQlPiYH172HVceOgMmUP
         xmTA==
X-Gm-Message-State: AOAM533PLMC0tfs2x8Qfr4uXJsfdw0sLv1iL8ClBkJgqMTSOhf+8CrzK
        T+m4B1vVgygO+nGHCVq79pET1GvXsEJnzw==
X-Google-Smtp-Source: ABdhPJxwYr9wGZXZbXZsg9oIbJzGgkTE5udjei7mfTesAEupGg51ja8m3RWgl45GKi8adZm1snkLbA==
X-Received: by 2002:a5d:58d8:: with SMTP id o24mr38785141wrf.288.1620218020364;
        Wed, 05 May 2021 05:33:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q16sm5858755wmj.24.2021.05.05.05.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 05:33:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/5] streaming.c: stop passing around "object_info *" to open()
Date:   Wed,  5 May 2021 14:33:31 +0200
Message-Id: <patch-4.5-44e79d6cb66-20210505T122816Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.838.g7ac6e98bb53
In-Reply-To: <cover-0.5-00000000000-20210505T122816Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210505T122816Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the streaming interface to stop passing around the "struct
object_info" the open() functions.

As seen in 7ef2d9a2604 (streaming: read non-delta incrementally from a
pack, 2011-05-13) which introduced the "st->u.in_pack" assignments
being changed here only the open_istream_pack_non_delta() path need
these.

So let's instead do this when preparing the selected callback in the
istream_source() function. This might also allow the compiler to
reduce the lifetime of the "oi" variable, as we've moved it from
"git_istream()" to "istream_source()".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 streaming.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/streaming.c b/streaming.c
index 7e039df388b..f6059ee828e 100644
--- a/streaming.c
+++ b/streaming.c
@@ -10,7 +10,6 @@
 
 typedef int (*open_istream_fn)(struct git_istream *,
 			       struct repository *,
-			       struct object_info *,
 			       const struct object_id *,
 			       enum object_type *);
 typedef int (*close_istream_fn)(struct git_istream *);
@@ -232,7 +231,6 @@ static struct stream_vtbl loose_vtbl = {
 };
 
 static int open_istream_loose(struct git_istream *st, struct repository *r,
-			      struct object_info *oi,
 			      const struct object_id *oid,
 			      enum object_type *type)
 {
@@ -337,15 +335,12 @@ static struct stream_vtbl pack_non_delta_vtbl = {
 
 static int open_istream_pack_non_delta(struct git_istream *st,
 				       struct repository *r,
-				       struct object_info *oi,
 				       const struct object_id *oid,
 				       enum object_type *type)
 {
 	struct pack_window *window;
 	enum object_type in_pack_type;
 
-	st->u.in_pack.pack = oi->u.packed.pack;
-	st->u.in_pack.pos = oi->u.packed.offset;
 	window = NULL;
 
 	in_pack_type = unpack_object_header(st->u.in_pack.pack,
@@ -400,8 +395,7 @@ static struct stream_vtbl incore_vtbl = {
 };
 
 static int open_istream_incore(struct git_istream *st, struct repository *r,
-			   struct object_info *oi, const struct object_id *oid,
-			   enum object_type *type)
+			       const struct object_id *oid, enum object_type *type)
 {
 	st->u.incore.buf = read_object_file_extended(r, oid, type, &st->size, 0);
 	st->u.incore.read_ptr = 0;
@@ -414,26 +408,30 @@ static int open_istream_incore(struct git_istream *st, struct repository *r,
  * static helpers variables and functions for users of streaming interface
  *****************************************************************************/
 
-static open_istream_fn istream_source(struct repository *r,
+static open_istream_fn istream_source(struct git_istream *st,
+				      struct repository *r,
 				      const struct object_id *oid,
-				      enum object_type *type,
-				      struct object_info *oi)
+				      enum object_type *type)
 {
 	unsigned long size;
 	int status;
+	struct object_info oi = OBJECT_INFO_INIT;
 
-	oi->typep = type;
-	oi->sizep = &size;
-	status = oid_object_info_extended(r, oid, oi, 0);
+	oi.typep = type;
+	oi.sizep = &size;
+	status = oid_object_info_extended(r, oid, &oi, 0);
 	if (status < 0)
 		return NULL;
 
-	switch (oi->whence) {
+	switch (oi.whence) {
 	case OI_LOOSE:
 		return open_istream_loose;
 	case OI_PACKED:
-		if (!oi->u.packed.is_delta && big_file_threshold < size)
+		if (!oi.u.packed.is_delta && big_file_threshold < size) {
+			st->u.in_pack.pack = oi.u.packed.pack;
+			st->u.in_pack.pos = oi.u.packed.offset;
 			return open_istream_pack_non_delta;
+		}
 		/* fallthru */
 	default:
 		return open_istream_incore;
@@ -462,17 +460,17 @@ struct git_istream *open_istream(struct repository *r,
 				 unsigned long *size,
 				 struct stream_filter *filter)
 {
-	struct git_istream *st;
-	struct object_info oi = OBJECT_INFO_INIT;
+	struct git_istream *st = xmalloc(sizeof(*st));
 	const struct object_id *real = lookup_replace_object(r, oid);
-	open_istream_fn open_fn = istream_source(r, real, type, &oi);
+	open_istream_fn open_fn = istream_source(st, r, real, type);
 
-	if (!open_fn)
+	if (!open_fn) {
+		free(st);
 		return NULL;
+	}
 
-	st = xmalloc(sizeof(*st));
-	if (open_fn(st, r, &oi, real, type)) {
-		if (open_istream_incore(st, r, &oi, real, type)) {
+	if (open_fn(st, r, real, type)) {
+		if (open_istream_incore(st, r, real, type)) {
 			free(st);
 			return NULL;
 		}
-- 
2.31.1.838.g7ac6e98bb53

