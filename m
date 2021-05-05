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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77503C433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 12:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44AE7613C1
	for <git@archiver.kernel.org>; Wed,  5 May 2021 12:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbhEEMek (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 08:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbhEEMef (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 08:34:35 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346E6C061763
        for <git@vger.kernel.org>; Wed,  5 May 2021 05:33:39 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id s8so1638362wrw.10
        for <git@vger.kernel.org>; Wed, 05 May 2021 05:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Iq1rBCQ8oR2AJbExXwjG9+20T8p6nYThXxil8xmDcoU=;
        b=JefSNKxVD+SGNZvlvqxFGHoxhks2jpXxrucsLcuKpGayafalE4LLWrg507AX83E77R
         8+3iJftKt2ATD6SrrSuB68K33xwduviY7BJVTin7xd8ASZNfD8lIDR0amulWtgu3Fjvt
         wQrig0jzjwu5Ii0Gv5CrOMGSxQbOfKziqQ0o7QH9FEk7EBx89nSEgkwGu/2fSnWU6tSz
         bLMN5X+o6WQKWQIzSyuG9P8L1T76T9WHjbIDpA+oZb1f+k6oPR/cLwTl/HEgnViguURu
         giuk72dMvc+rno38dz9xZrTsqTXaZoVuda7ap9UoHwAHF8DhOojM5cfvuhw/S8dg7MDj
         wsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iq1rBCQ8oR2AJbExXwjG9+20T8p6nYThXxil8xmDcoU=;
        b=B8X4278yLwrbSEXbFnVcCqYf4C+MTTIEO0cC6N3O9+yLlEtfpCyWepCejBD/ktc3gZ
         adX96isv8tFxdkcbxMYTXzi3iiKlonfgRbzXvfaHU+L12vyk/ARIWUhdJIELUvNy/izS
         nysY+tBS90/jYIGqadxBpCBoQU1D1j8amUsCHyYuZhPmgDVw91Np6982m722nGEzOIH7
         n7IzMvybDmeYPRe1SJH3UQ+Ey6s8whVa7JKQa9HF8RjflE7xbxfmOwCxm73zyfGgAm6Z
         +ZIzy6NdCsH4wBTBvhc3Gw/BEvZrLT7Q8M+9n1FKUx02g0lcBdWxyyvDgs5rdFEKtJHG
         +Mbg==
X-Gm-Message-State: AOAM531PByaqzSzmuyiyxyaZVWuzI2ulhnGPMbLRDtqD5ncf3gyjpqlM
        qdYLGK5S+aSO9VYIUvMo5Nu8afQEmRSWow==
X-Google-Smtp-Source: ABdhPJzIEQ2p04FK5bRozyX9maC/+PMPjmhIbli3LoXei7DOePVVf0EF+G8ufpa6cTlavS/a6RzhPw==
X-Received: by 2002:a5d:6b88:: with SMTP id n8mr34845157wrx.274.1620218017634;
        Wed, 05 May 2021 05:33:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q16sm5858755wmj.24.2021.05.05.05.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 05:33:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/5] streaming.c: avoid forward declarations
Date:   Wed,  5 May 2021 14:33:28 +0200
Message-Id: <patch-1.5-7f8c4b8698b-20210505T122816Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.838.g7ac6e98bb53
In-Reply-To: <cover-0.5-00000000000-20210505T122816Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210505T122816Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code added in 46bf043807c (streaming: a new API to read from
the object store, 2011-05-11) to avoid forward declarations of the
functions it uses. We can instead move this code to the bottom of the
file, and thus avoid the open_method_decl() calls.

Aside from the addition of the "static helpers[...]" comment being
added here, and the removal of the forward declarations this is a
move-only change.

The style of the added "static helpers[...]"  comment isn't in line
with our usual coding style, but is consistent with several other
comments used in this file, so let's use that style consistently here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 streaming.c | 171 +++++++++++++++++++++++++---------------------------
 1 file changed, 83 insertions(+), 88 deletions(-)

diff --git a/streaming.c b/streaming.c
index 800f07a52cc..b0d439e47a7 100644
--- a/streaming.c
+++ b/streaming.c
@@ -42,20 +42,6 @@ struct stream_vtbl {
 	ssize_t read_istream_ ##name \
 	(struct git_istream *st, char *buf, size_t sz)
 
-/* forward declaration */
-static open_method_decl(incore);
-static open_method_decl(loose);
-static open_method_decl(pack_non_delta);
-static struct git_istream *attach_stream_filter(struct git_istream *st,
-						struct stream_filter *filter);
-
-
-static open_istream_fn open_istream_tbl[] = {
-	open_istream_incore,
-	open_istream_loose,
-	open_istream_pack_non_delta,
-};
-
 #define FILTER_BUFFER (1024*16)
 
 struct filtered_istream {
@@ -97,80 +83,6 @@ struct git_istream {
 	} u;
 };
 
-int close_istream(struct git_istream *st)
-{
-	int r = st->vtbl->close(st);
-	free(st);
-	return r;
-}
-
-ssize_t read_istream(struct git_istream *st, void *buf, size_t sz)
-{
-	return st->vtbl->read(st, buf, sz);
-}
-
-static enum input_source istream_source(struct repository *r,
-					const struct object_id *oid,
-					enum object_type *type,
-					struct object_info *oi)
-{
-	unsigned long size;
-	int status;
-
-	oi->typep = type;
-	oi->sizep = &size;
-	status = oid_object_info_extended(r, oid, oi, 0);
-	if (status < 0)
-		return stream_error;
-
-	switch (oi->whence) {
-	case OI_LOOSE:
-		return loose;
-	case OI_PACKED:
-		if (!oi->u.packed.is_delta && big_file_threshold < size)
-			return pack_non_delta;
-		/* fallthru */
-	default:
-		return incore;
-	}
-}
-
-struct git_istream *open_istream(struct repository *r,
-				 const struct object_id *oid,
-				 enum object_type *type,
-				 unsigned long *size,
-				 struct stream_filter *filter)
-{
-	struct git_istream *st;
-	struct object_info oi = OBJECT_INFO_INIT;
-	const struct object_id *real = lookup_replace_object(r, oid);
-	enum input_source src = istream_source(r, real, type, &oi);
-
-	if (src < 0)
-		return NULL;
-
-	st = xmalloc(sizeof(*st));
-	if (open_istream_tbl[src](st, r, &oi, real, type)) {
-		if (open_istream_incore(st, r, &oi, real, type)) {
-			free(st);
-			return NULL;
-		}
-	}
-	if (filter) {
-		/* Add "&& !is_null_stream_filter(filter)" for performance */
-		struct git_istream *nst = attach_stream_filter(st, filter);
-		if (!nst) {
-			close_istream(st);
-			return NULL;
-		}
-		st = nst;
-	}
-
-	*size = st->size;
-	return st;
-}
-
-
 /*****************************************************************
  *
  * Common helpers
@@ -508,11 +420,94 @@ static open_method_decl(incore)
 	return st->u.incore.buf ? 0 : -1;
 }
 
+/*****************************************************************************
+ * static helpers variables and functions for users of streaming interface
+ *****************************************************************************/
+
+static open_istream_fn open_istream_tbl[] = {
+	open_istream_incore,
+	open_istream_loose,
+	open_istream_pack_non_delta,
+};
+
+static enum input_source istream_source(struct repository *r,
+					const struct object_id *oid,
+					enum object_type *type,
+					struct object_info *oi)
+{
+	unsigned long size;
+	int status;
+
+	oi->typep = type;
+	oi->sizep = &size;
+	status = oid_object_info_extended(r, oid, oi, 0);
+	if (status < 0)
+		return stream_error;
+
+	switch (oi->whence) {
+	case OI_LOOSE:
+		return loose;
+	case OI_PACKED:
+		if (!oi->u.packed.is_delta && big_file_threshold < size)
+			return pack_non_delta;
+		/* fallthru */
+	default:
+		return incore;
+	}
+}
+
 
 /****************************************************************
  * Users of streaming interface
  ****************************************************************/
 
+int close_istream(struct git_istream *st)
+{
+	int r = st->vtbl->close(st);
+	free(st);
+	return r;
+}
+
+ssize_t read_istream(struct git_istream *st, void *buf, size_t sz)
+{
+	return st->vtbl->read(st, buf, sz);
+}
+
+struct git_istream *open_istream(struct repository *r,
+				 const struct object_id *oid,
+				 enum object_type *type,
+				 unsigned long *size,
+				 struct stream_filter *filter)
+{
+	struct git_istream *st;
+	struct object_info oi = OBJECT_INFO_INIT;
+	const struct object_id *real = lookup_replace_object(r, oid);
+	enum input_source src = istream_source(r, real, type, &oi);
+
+	if (src < 0)
+		return NULL;
+
+	st = xmalloc(sizeof(*st));
+	if (open_istream_tbl[src](st, r, &oi, real, type)) {
+		if (open_istream_incore(st, r, &oi, real, type)) {
+			free(st);
+			return NULL;
+		}
+	}
+	if (filter) {
+		/* Add "&& !is_null_stream_filter(filter)" for performance */
+		struct git_istream *nst = attach_stream_filter(st, filter);
+		if (!nst) {
+			close_istream(st);
+			return NULL;
+		}
+		st = nst;
+	}
+
+	*size = st->size;
+	return st;
+}
+
 int stream_blob_to_fd(int fd, const struct object_id *oid, struct stream_filter *filter,
 		      int can_seek)
 {
-- 
2.31.1.838.g7ac6e98bb53

