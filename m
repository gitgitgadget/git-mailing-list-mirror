Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2496C43460
	for <git@archiver.kernel.org>; Wed,  5 May 2021 12:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6988613BE
	for <git@archiver.kernel.org>; Wed,  5 May 2021 12:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbhEEMel (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 08:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbhEEMeh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 08:34:37 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9ADC06138A
        for <git@vger.kernel.org>; Wed,  5 May 2021 05:33:40 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id y124-20020a1c32820000b029010c93864955so3318050wmy.5
        for <git@vger.kernel.org>; Wed, 05 May 2021 05:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Snpc7WZvEIiWB8Tl7eSrsd6dzVa7zl1ilnakmrGxZtw=;
        b=dxu61NGKZpeJ2TIE8dH47T2w83nUk6ah4T/seDxw2BRagjPAC3I9BH1j6VJtn0Y6G0
         d0XiK4y2pfEjAE7dJ1SWwUJjaju/xo57M1pgL8Zc3xcwFTdNMBIuSk19pkS9B2WqZ/Oz
         hpoGyhDJmmcIP5hPdcKuOIcICRjGwlzuah648WfRcXfvyYhLg4Bv18QMCShIEiYxJE8G
         IsjESRqEqgcypkGQsxQOnPFfO8+rp0BpT36tFhRDXxO9g0iFWmdrccOw0wTmksbDFhf0
         fKKZWbejURS+5GZj5UVebgIjOHvj6lGrpidLbyRXnqvaIABnuh+pCygZziRFGXGM6sNb
         Jo9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Snpc7WZvEIiWB8Tl7eSrsd6dzVa7zl1ilnakmrGxZtw=;
        b=AanEte4MfKKqa+wXnapECoWFuBhwjApvw7u6Ja4yJHQDaDTe9L+smR3SgwJ6fVMoc7
         4EsykeFSqQoLzhrEVY1Pa9hKHp9Y48lUzTwfSbCAtqi5S6pi2k7t5Wmz4wtHBQboNn+l
         g6T0TubKjADaq5z94bzdBhYMRf+gFWgX3zo4XbZQV19Y60dbaNz57H0gcZkuKKOjWcTW
         YkAi9IVo1I+Ua20zgavCibKRDK84deY8RhKEm/yk8Zz3svjUKr48dqp+nDVu6gFsLGaM
         CbtCao+b6/NX1HQpekOdi548tyiyX3O9mYHBKQ3Ka11HF6wSwl14R8y8za/pEzH0KBXv
         bziQ==
X-Gm-Message-State: AOAM532rnAoPWoZ0cQ/HzXc/ic5IWa69N5/9XTUA9hPPsIn4I6FJm3Fr
        pN/fGhAcAU8P0Z2OifnlqeNrmeIxYcRPYg==
X-Google-Smtp-Source: ABdhPJyBNyGF3TWVG36UrPRrtS0Sxfq6bTB6EHagUosg8Exy/TZmmspeKFvdemwufa2773HDXhaApg==
X-Received: by 2002:a05:600c:22c9:: with SMTP id 9mr33335538wmg.85.1620218019230;
        Wed, 05 May 2021 05:33:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q16sm5858755wmj.24.2021.05.05.05.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 05:33:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/5] streaming.c: remove {open,close,read}_method_decl() macros
Date:   Wed,  5 May 2021 14:33:30 +0200
Message-Id: <patch-3.5-06961ee52bb-20210505T122816Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.838.g7ac6e98bb53
In-Reply-To: <cover-0.5-00000000000-20210505T122816Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210505T122816Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the {open,close,read}_method_decl() macros added in
46bf043807c (streaming: a new API to read from the object store,
2011-05-11) in favor of inlining the definition of the arguments of
these functions.

Since we'll end up using them via the "{open,close,read}_istream_fn"
types we don't gain anything in the way of compiler checking by using
these macros, and as of preceding commits we no longer need to declare
these argument lists twice. So declaring them at a distance just
serves to make the code less readable.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 streaming.c | 47 ++++++++++++++++++++++-------------------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/streaming.c b/streaming.c
index 628369519b9..7e039df388b 100644
--- a/streaming.c
+++ b/streaming.c
@@ -21,20 +21,6 @@ struct stream_vtbl {
 	read_istream_fn read;
 };
 
-#define open_method_decl(name) \
-	int open_istream_ ##name \
-	(struct git_istream *st, struct repository *r, \
-	 struct object_info *oi, const struct object_id *oid, \
-	 enum object_type *type)
-
-#define close_method_decl(name) \
-	int close_istream_ ##name \
-	(struct git_istream *st)
-
-#define read_method_decl(name) \
-	ssize_t read_istream_ ##name \
-	(struct git_istream *st, char *buf, size_t sz)
-
 #define FILTER_BUFFER (1024*16)
 
 struct filtered_istream {
@@ -95,13 +81,14 @@ static void close_deflated_stream(struct git_istream *st)
  *
  *****************************************************************/
 
-static close_method_decl(filtered)
+static int close_istream_filtered(struct git_istream *st)
 {
 	free_stream_filter(st->u.filtered.filter);
 	return close_istream(st->u.filtered.upstream);
 }
 
-static read_method_decl(filtered)
+static ssize_t read_istream_filtered(struct git_istream *st, char *buf,
+				     size_t sz)
 {
 	struct filtered_istream *fs = &(st->u.filtered);
 	size_t filled = 0;
@@ -187,7 +174,7 @@ static struct git_istream *attach_stream_filter(struct git_istream *st,
  *
  *****************************************************************/
 
-static read_method_decl(loose)
+static ssize_t read_istream_loose(struct git_istream *st, char *buf, size_t sz)
 {
 	size_t total_read = 0;
 
@@ -232,7 +219,7 @@ static read_method_decl(loose)
 	return total_read;
 }
 
-static close_method_decl(loose)
+static int close_istream_loose(struct git_istream *st)
 {
 	close_deflated_stream(st);
 	munmap(st->u.loose.mapped, st->u.loose.mapsize);
@@ -244,7 +231,10 @@ static struct stream_vtbl loose_vtbl = {
 	read_istream_loose,
 };
 
-static open_method_decl(loose)
+static int open_istream_loose(struct git_istream *st, struct repository *r,
+			      struct object_info *oi,
+			      const struct object_id *oid,
+			      enum object_type *type)
 {
 	st->u.loose.mapped = map_loose_object(r, oid, &st->u.loose.mapsize);
 	if (!st->u.loose.mapped)
@@ -275,7 +265,8 @@ static open_method_decl(loose)
  *
  *****************************************************************/
 
-static read_method_decl(pack_non_delta)
+static ssize_t read_istream_pack_non_delta(struct git_istream *st, char *buf,
+					   size_t sz)
 {
 	size_t total_read = 0;
 
@@ -333,7 +324,7 @@ static read_method_decl(pack_non_delta)
 	return total_read;
 }
 
-static close_method_decl(pack_non_delta)
+static int close_istream_pack_non_delta(struct git_istream *st)
 {
 	close_deflated_stream(st);
 	return 0;
@@ -344,7 +335,11 @@ static struct stream_vtbl pack_non_delta_vtbl = {
 	read_istream_pack_non_delta,
 };
 
-static open_method_decl(pack_non_delta)
+static int open_istream_pack_non_delta(struct git_istream *st,
+				       struct repository *r,
+				       struct object_info *oi,
+				       const struct object_id *oid,
+				       enum object_type *type)
 {
 	struct pack_window *window;
 	enum object_type in_pack_type;
@@ -379,13 +374,13 @@ static open_method_decl(pack_non_delta)
  *
  *****************************************************************/
 
-static close_method_decl(incore)
+static int close_istream_incore(struct git_istream *st)
 {
 	free(st->u.incore.buf);
 	return 0;
 }
 
-static read_method_decl(incore)
+static ssize_t read_istream_incore(struct git_istream *st, char *buf, size_t sz)
 {
 	size_t read_size = sz;
 	size_t remainder = st->size - st->u.incore.read_ptr;
@@ -404,7 +399,9 @@ static struct stream_vtbl incore_vtbl = {
 	read_istream_incore,
 };
 
-static open_method_decl(incore)
+static int open_istream_incore(struct git_istream *st, struct repository *r,
+			   struct object_info *oi, const struct object_id *oid,
+			   enum object_type *type)
 {
 	st->u.incore.buf = read_object_file_extended(r, oid, type, &st->size, 0);
 	st->u.incore.read_ptr = 0;
-- 
2.31.1.838.g7ac6e98bb53

