Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81611CA100D
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 20:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243827AbjIEUg4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 16:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243807AbjIEUgy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 16:36:54 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56A5E6
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 13:36:50 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-57359e85e9bso1612561eaf.2
        for <git@vger.kernel.org>; Tue, 05 Sep 2023 13:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1693946210; x=1694551010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FqSUCweIV5Zb8kL18Y6iJm3DZkvivOofgc4CKrPN9Ho=;
        b=Wjmp0XvMvNnjDVrbma7ttprd/5/93XDzPgcSd79dv9qhKFKQR+FyTd6mGXFjqExn9X
         2hdRkFFMLl+eMyqNbMyQzlCwxoFxr0zdmCJyUhN/4U1NkdwcWpdTdpCUuX7YI5AGyEne
         gUcdQltDvXQ0qptNj1ykMhUeJpQcxVLDme5E4Sh+WiOc2V7E68wzva2QAeObQi0WEfhR
         zMXrGZ1A9h+pZ6Vyss/HFabR149dh09EFpSqYWGUq1LQ6XkOCD7Zo6swABtFzr/K2Ebp
         uqWcW727vgrnTW6TBNENacxmYGKClVA0xC3TX50FeA+waMBsM8SxYNoLUFMLuKALDDBp
         64iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693946210; x=1694551010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqSUCweIV5Zb8kL18Y6iJm3DZkvivOofgc4CKrPN9Ho=;
        b=X7+mJoFn+C30NwhhfiXcMMHWL1irN+WSm05gUrT6Md8TLfQ4mfhmlzZqey1GGdb/8F
         80+9mlZk+W3UTEyA442ReQ2uODAiLKkaYoWjR+FvEMBltRiWNp1f2FzFiAjrvG3EYcpj
         YKfmWMk8VhauqDC2HEL8VnSZt4KSm7J4+BOBXgf344MKPggTLJzTNz7oEXLdMtYHP9sl
         oSWkw74ZF28qSInTIlCVsbQ6H3/RjIaTNWBoaTIDsTRHyFwXoU/WLv2HFQc0cxSnjgN0
         /t0vboRtfjBp4DInGCmZ5g9p8WlZwXuKVJidXNR8CjkKv92VYE6DChRrzcxIGS7A58c6
         6Vpw==
X-Gm-Message-State: AOJu0YyJ/rucL0Ou5CbtoxhUOaqwxtDXeUAjdMz7ojMcqMA0XtcHaTJr
        KP+MWZfxpYhdG+VHNtYHXnDV+AZvwwdBXaSo7rvOwg==
X-Google-Smtp-Source: AGHT+IF0VTypAE/liRH8hlDa+yxGjp/ab2gVC32SK+sMQ7O999J4idA9ccHc5SR0OiUYsD3XGRkerg==
X-Received: by 2002:a05:6358:590d:b0:135:4c43:f4df with SMTP id g13-20020a056358590d00b001354c43f4dfmr983234rwf.3.1693946209837;
        Tue, 05 Sep 2023 13:36:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s6-20020a0dd006000000b005924fb1be44sm3367958ywd.139.2023.09.05.13.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 13:36:49 -0700 (PDT)
Date:   Tue, 5 Sep 2023 16:36:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 4/8] builtin/repack.c: extract redundant pack cleanup for
 existing packs
Message-ID: <7bb543fef8b140726b6b3efc2bb2cb1a6384fcd9.1693946195.git.me@ttaylorr.com>
References: <cover.1693946195.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1693946195.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To remove redundant packs at the end of a repacking operation, Git uses
its `remove_redundant_pack()` function in a loop over the set of
pre-existing, non-kept packs.

In a later commit, we will split this list into two, one for
pre-existing cruft pack(s), and another for non-cruft pack(s). Prepare
for this by factoring out the routine to loop over and delete redundant
packs into its own function.

Instead of calling `remove_redundant_pack()` directly, we now will call
`remove_redundant_existing_packs()`, which itself dispatches a call to
`remove_redundant_packs_1()`. Note that the geometric repacking code
will still call `remove_redundant_pack()` directly, but see the previous
commit for more details.

Having `remove_redundant_packs_1()` exist as a separate function may
seem like overkill in this patch. However, a later patch will call
`remove_redundant_packs_1()` once over two separate lists, so this
refactoring sets us up for that.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 45 ++++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index d3e6326bb9..f6717e334c 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -135,6 +135,33 @@ static void mark_packs_for_deletion(struct existing_packs *existing,
 	mark_packs_for_deletion_1(names, &existing->non_kept_packs);
 }
 
+static void remove_redundant_pack(const char *dir_name, const char *base_name)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct multi_pack_index *m = get_local_multi_pack_index(the_repository);
+	strbuf_addf(&buf, "%s.pack", base_name);
+	if (m && midx_contains_pack(m, buf.buf))
+		clear_midx_file(the_repository);
+	strbuf_insertf(&buf, 0, "%s/", dir_name);
+	unlink_pack_path(buf.buf, 1);
+	strbuf_release(&buf);
+}
+
+static void remove_redundant_packs_1(struct string_list *packs)
+{
+	struct string_list_item *item;
+	for_each_string_list_item(item, packs) {
+		if (!((uintptr_t)item->util & DELETE_PACK))
+			continue;
+		remove_redundant_pack(packdir, item->string);
+	}
+}
+
+static void remove_redundant_existing_packs(struct existing_packs *existing)
+{
+	remove_redundant_packs_1(&existing->non_kept_packs);
+}
+
 static void existing_packs_release(struct existing_packs *existing)
 {
 	string_list_clear(&existing->kept_packs, 0);
@@ -184,18 +211,6 @@ static void collect_pack_filenames(struct existing_packs *existing,
 	strbuf_release(&buf);
 }
 
-static void remove_redundant_pack(const char *dir_name, const char *base_name)
-{
-	struct strbuf buf = STRBUF_INIT;
-	struct multi_pack_index *m = get_local_multi_pack_index(the_repository);
-	strbuf_addf(&buf, "%s.pack", base_name);
-	if (m && midx_contains_pack(m, buf.buf))
-		clear_midx_file(the_repository);
-	strbuf_insertf(&buf, 0, "%s/", dir_name);
-	unlink_pack_path(buf.buf, 1);
-	strbuf_release(&buf);
-}
-
 static void prepare_pack_objects(struct child_process *cmd,
 				 const struct pack_objects_args *args,
 				 const char *out)
@@ -1221,11 +1236,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	if (delete_redundant) {
 		int opts = 0;
-		for_each_string_list_item(item, &existing.non_kept_packs) {
-			if (!((uintptr_t)item->util & DELETE_PACK))
-				continue;
-			remove_redundant_pack(packdir, item->string);
-		}
+		remove_redundant_existing_packs(&existing);
 
 		if (geometry.split_factor)
 			geometry_remove_redundant_packs(&geometry, &names,
-- 
2.42.0.119.gca7d13e7bf

