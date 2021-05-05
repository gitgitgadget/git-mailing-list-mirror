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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07D8C43461
	for <git@archiver.kernel.org>; Wed,  5 May 2021 12:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 766E8613AA
	for <git@archiver.kernel.org>; Wed,  5 May 2021 12:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbhEEMen (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 08:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhEEMei (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 08:34:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABDDC0613ED
        for <git@vger.kernel.org>; Wed,  5 May 2021 05:33:39 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i128so1317061wma.5
        for <git@vger.kernel.org>; Wed, 05 May 2021 05:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D5HaJcf0F22eGItLU1MmLWIMVGvb/JwDIgHHC+WO49U=;
        b=HQ7Lryb3ex541HH1l7sQJwkJwfPIjn4LMqDMwc1Iu0FE7dLiWt9G4aOAmyMoYPcBNE
         fKIwBSx4/RZByjOhNERcb4zJg8P0jHoMT83KtC0NijqhW4Z0Sd0hFKigdujoamqyLuRv
         0NiJJEyTq8JfWQU3KOqFb92ZHPsx1ktP5/s+43Jj1z7tyVSCN5DpHVWNvxoe7eWin2KE
         bzZOZawp/Y03EpWNdHJps1mkcruxl2UF4FY9sAyeCPqfW8N7tb4IqC+jQB1XUG3ryYgy
         0x2vNiV/6hcsuM3goj1bPkcl0tXOdTeHNT+z1HINphokyHstO7pe0zqIT7omHpaeK77X
         I60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D5HaJcf0F22eGItLU1MmLWIMVGvb/JwDIgHHC+WO49U=;
        b=oozjU1uNGM3eiriKPZ+kDi56RQ/jknq08Tq9pL5l68zJhVjA5betPzHlw7nuIU6f6u
         rlkbrpVRktwDaevvuFTqOE1ehdl3+Uv1GPKKFAVdMVUgeQOQToq4A7epSWb9xNfCpk3I
         ceYZuzNSuzjyS3iBMTuFbJM5i95oIuvjQtibhLVCnO0UZFMnEVyKpBfDYAsFdEsshuqm
         gQpYdYspYq/zN0q3ZGm/xFsePUsxLn1eq2gkUjxMekla5cPXmI5mNN8L9I84ifpwnHLg
         6staOAmBmBuXtxZFWnhsQPFZHWyAEQ4YHv9bbh5V+l1YP3bfV8ZBG7wqQr/z0Puwev8R
         8HWA==
X-Gm-Message-State: AOAM530GOr1SM6nlw0TuUWlGFXLP72PCx+QR/1bc5Rch+9DMdLkHGiM8
        f04jTCH4vl7LQjtkMWztZJdw0jvI0K7dgg==
X-Google-Smtp-Source: ABdhPJzWsQnwkI2/fjpNuGzAqKMTNEnY2tJjAWpDcGTiaC2UGl3K1BXvmsYfiirsI+Ap5c06DrO3aw==
X-Received: by 2002:a7b:c217:: with SMTP id x23mr9530170wmi.26.1620218018388;
        Wed, 05 May 2021 05:33:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q16sm5858755wmj.24.2021.05.05.05.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 05:33:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/5] streaming.c: remove enum/function/vtbl indirection
Date:   Wed,  5 May 2021 14:33:29 +0200
Message-Id: <patch-2.5-13061f01212-20210505T122816Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.838.g7ac6e98bb53
In-Reply-To: <cover-0.5-00000000000-20210505T122816Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210505T122816Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the indirection of discovering a function pointer to use via an
enum and virtual table. This refactors code added in
46bf043807c (streaming: a new API to read from the object store,
2011-05-11).

We can instead simply return an "open_istream_fn" for use from the
"istream_source()" selector function directly. This allows us to get
rid of the "incore", "loose" and "pack_non_delta" enum
variables. We'll return the functions instead.

The "stream_error" variable in that enum can likewise go in favor of
returning NULL, which is what the open_istream() was doing when it got
that value anyway.

We can thus remove the entire enum, and the "open_istream_tbl" virtual
table that (indirectly) referenced it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 streaming.c | 36 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/streaming.c b/streaming.c
index b0d439e47a7..628369519b9 100644
--- a/streaming.c
+++ b/streaming.c
@@ -8,13 +8,6 @@
 #include "replace-object.h"
 #include "packfile.h"
 
-enum input_source {
-	stream_error = -1,
-	incore = 0,
-	loose = 1,
-	pack_non_delta = 2
-};
-
 typedef int (*open_istream_fn)(struct git_istream *,
 			       struct repository *,
 			       struct object_info *,
@@ -424,16 +417,10 @@ static open_method_decl(incore)
  * static helpers variables and functions for users of streaming interface
  *****************************************************************************/
 
-static open_istream_fn open_istream_tbl[] = {
-	open_istream_incore,
-	open_istream_loose,
-	open_istream_pack_non_delta,
-};
-
-static enum input_source istream_source(struct repository *r,
-					const struct object_id *oid,
-					enum object_type *type,
-					struct object_info *oi)
+static open_istream_fn istream_source(struct repository *r,
+				      const struct object_id *oid,
+				      enum object_type *type,
+				      struct object_info *oi)
 {
 	unsigned long size;
 	int status;
@@ -442,21 +429,20 @@ static enum input_source istream_source(struct repository *r,
 	oi->sizep = &size;
 	status = oid_object_info_extended(r, oid, oi, 0);
 	if (status < 0)
-		return stream_error;
+		return NULL;
 
 	switch (oi->whence) {
 	case OI_LOOSE:
-		return loose;
+		return open_istream_loose;
 	case OI_PACKED:
 		if (!oi->u.packed.is_delta && big_file_threshold < size)
-			return pack_non_delta;
+			return open_istream_pack_non_delta;
 		/* fallthru */
 	default:
-		return incore;
+		return open_istream_incore;
 	}
 }
 
-
 /****************************************************************
  * Users of streaming interface
  ****************************************************************/
@@ -482,13 +468,13 @@ struct git_istream *open_istream(struct repository *r,
 	struct git_istream *st;
 	struct object_info oi = OBJECT_INFO_INIT;
 	const struct object_id *real = lookup_replace_object(r, oid);
-	enum input_source src = istream_source(r, real, type, &oi);
+	open_istream_fn open_fn = istream_source(r, real, type, &oi);
 
-	if (src < 0)
+	if (!open_fn)
 		return NULL;
 
 	st = xmalloc(sizeof(*st));
-	if (open_istream_tbl[src](st, r, &oi, real, type)) {
+	if (open_fn(st, r, &oi, real, type)) {
 		if (open_istream_incore(st, r, &oi, real, type)) {
 			free(st);
 			return NULL;
-- 
2.31.1.838.g7ac6e98bb53

