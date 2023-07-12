Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61231EB64DA
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 23:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjGLXnJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 19:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbjGLXht (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 19:37:49 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C97019B4
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:37:46 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5703cb4bcb4so79805057b3.3
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689205065; x=1691797065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bwz1RJ91Ih3YI/nVdUt0UyRdOarlVnHTssLh60EBeNM=;
        b=CaxwZLFckgqIIuS4LdLRanCJd6G1V23R8oJC4zKeANdeXvFt9vdPWREyR5cK+km8AX
         YSIW72+xBBGrWNjy7GToO/Is4svcjcKa6OU6oxx2yXJ9HywHEI+U+G5NgeeQoOMjyCd6
         xlRhXoozqi4JkghvYuPGpfRDze9IS/vjMlaQtVCAIDAm5Kz9yCCXIsGQ2nlZKhaZNwgg
         KaPY+7UDlM0W1Yce+jw6UgXUqk/Z5Kyqx1KDHDBtT36Rf8LNYXNdENvoqwsnoi7EJi/t
         wZDm6A0IrNCI7xyaGsYGDQAA5fD9ZOwx2WaFjJaO5z8DIm65pr6jDqiViYQjKjO7xAbq
         cCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689205065; x=1691797065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwz1RJ91Ih3YI/nVdUt0UyRdOarlVnHTssLh60EBeNM=;
        b=S3SgmRuiQCmImw2BsoMYl4Btd1WzvK4jg8ND/ly2mME2Jfwb6/lAkG0uQrrmXSCuF6
         gwA0eXIEQhNfCqkseSS9F007Ga423NemsCTpN3icM0eENdJc8rI7lbckcSX8pyqwTFpX
         pClvxJZn+2XPZHoLTYRnpWlWjVFzlfrsYxlHzLVC4lbEmnClvPT8vdk++xBIG3mg/q8W
         fipVbBQVMRFgXuvaWb3OD679W5SU+7ZDtaHHGbdlSeaOpDGeDOvH4zwQdtn6pHS/Iy1h
         h3yyIwRCiOXkC9izcFAniP8CRclYDKZ6x8nmP3oi8v/xVn5UJ442nFPFCrH6nrYxrF2d
         5+Ng==
X-Gm-Message-State: ABy/qLZIGWFxdMIGJ33LxnPvNgd6cXDKAgaShZ46h4foTpMjP74bw/tM
        YO/29pLjYVuRfiKTgtEUgvkOKtaf+eBHvhXAPT9Vtg==
X-Google-Smtp-Source: APBJJlGAzaGBMEDEBiA7OKjCw4AFkKuZuWq9mWWgWD/TdYR4ihvQDBe9g12ZhclYSQmS5Y8uZ8frAw==
X-Received: by 2002:a81:67c2:0:b0:56d:502:43d4 with SMTP id b185-20020a8167c2000000b0056d050243d4mr139380ywc.11.1689205065050;
        Wed, 12 Jul 2023 16:37:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u63-20020a816042000000b005706c3e5dfcsm1461869ywb.48.2023.07.12.16.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:37:44 -0700 (PDT)
Date:   Wed, 12 Jul 2023 19:37:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Subject: [PATCH 07/20] midx.c: store `nr`, `alloc` variables as `size_t`'s
Message-ID: <4067ff3f1b422734b79591268644a38f053d2f54.1689205042.git.me@ttaylorr.com>
References: <cover.1689205042.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689205042.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the `write_midx_context` structure, we use two `uint32_t`'s to track
the length and allocated size of the packs, and one `uint32_t` to track
the number of objects in the MIDX.

In practice, having these be 32-bit unsigned values shouldn't cause any
problems since we are unlikely to have that many objects or packs in any
real-world repository. But these values should be `size_t`'s, so change
their type to reflect that.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/midx.c b/midx.c
index a5a4ff4398..b176745df1 100644
--- a/midx.c
+++ b/midx.c
@@ -446,14 +446,14 @@ static int idx_or_pack_name_cmp(const void *_va, const void *_vb)
 
 struct write_midx_context {
 	struct pack_info *info;
-	uint32_t nr;
-	uint32_t alloc;
+	size_t nr;
+	size_t alloc;
 	struct multi_pack_index *m;
 	struct progress *progress;
 	unsigned pack_paths_checked;
 
 	struct pack_midx_entry *entries;
-	uint32_t entries_nr;
+	size_t entries_nr;
 
 	uint32_t *pack_perm;
 	uint32_t *pack_order;
@@ -671,17 +671,18 @@ static void midx_fanout_add_pack_fanout(struct midx_fanout *fanout,
 static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 						  struct pack_info *info,
 						  uint32_t nr_packs,
-						  uint32_t *nr_objects,
+						  size_t *nr_objects,
 						  int preferred_pack)
 {
 	uint32_t cur_fanout, cur_pack, cur_object;
-	uint32_t alloc_objects, total_objects = 0;
+	size_t alloc_objects, total_objects = 0;
 	struct midx_fanout fanout = { 0 };
 	struct pack_midx_entry *deduplicated_entries = NULL;
 	uint32_t start_pack = m ? m->num_packs : 0;
 
 	for (cur_pack = start_pack; cur_pack < nr_packs; cur_pack++)
-		total_objects += info[cur_pack].p->num_objects;
+		total_objects = st_add(total_objects,
+				       info[cur_pack].p->num_objects);
 
 	/*
 	 * As we de-duplicate by fanout value, we expect the fanout
@@ -724,7 +725,8 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 						&fanout.entries[cur_object].oid))
 				continue;
 
-			ALLOC_GROW(deduplicated_entries, *nr_objects + 1, alloc_objects);
+			ALLOC_GROW(deduplicated_entries, st_add(*nr_objects, 1),
+				   alloc_objects);
 			memcpy(&deduplicated_entries[*nr_objects],
 			       &fanout.entries[cur_object],
 			       sizeof(struct pack_midx_entry));
-- 
2.41.0.347.g7b976b8871f

