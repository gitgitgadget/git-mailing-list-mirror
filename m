Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF109EE020A
	for <git@archiver.kernel.org>; Wed, 13 Sep 2023 19:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjIMTR7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Sep 2023 15:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbjIMTR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2023 15:17:57 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F3B170F
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 12:17:53 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5925e580f12so1855137b3.3
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 12:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1694632673; x=1695237473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RApe70Ddk4aFbpYXvaraueGlEryEzeF7P3fitACvKPI=;
        b=HiWSmG+/iOWOZjSQb7hX4MeQ2wwpiQIcAFDdS0cA3YUsGO6V/kmxB7Xg9YbFQHwiKq
         uglvXe0euDxgenkO2s2nTGes9fV7HC7u0CR1KzXMnaTCDUbtdAoNBPXWfiywsgZFCPye
         CZoDeBZ0GcxzE4PgA6Ml1J3VMZDnQrHgXvSol5+nrgYIjuNLEPHHyTBRVuzdvS7xhTpq
         EE4z3RK+EujPcZFZOuQtK4zjEutNM1D2Kk4sC3iV1CZqy/zXJ7Ce01OwukKq5X7JHolO
         gSUQ/lXZrG3qIzp6K5oM0rBGaHENvSsNGgYzpGCalRa4DaQ9VgR7BQPXDsF1DXiMh+82
         1gAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694632673; x=1695237473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RApe70Ddk4aFbpYXvaraueGlEryEzeF7P3fitACvKPI=;
        b=fjoQpxbwVHiSjDRRMabUrzGepYAnOOby6mGQKfz9VafoxihNBfPQp0h7BFbLIwyZkj
         hD2PBx61QujVIXlIDJ0xlJOmGVdZN0z6gD06oM+c7rDew4IVea8B7utRWpASt4s/ZMC2
         8XvRFloXDen0+GwITLGrhAVCkf6l/qJFFsHhRmwD2h2kQBep2R99IsMQ99PNZHs0UVcd
         HMF7U5TkOCM43qLbPJk6B+RQfS625z3WkDCufKQigQdSjVPeA/AGuV4le9CXetjCnK+2
         2SI0ksfprJAHRobTPSXKSgBe0DNLVG4Ulql8AKSaVWfoqQ3IT/mr96FWjhspfXi+WUXo
         67uw==
X-Gm-Message-State: AOJu0YwGDsFdamW5EcibR1ZjFXrDzv10pHaTVb8qy7AmdxvunFy7vT53
        BSr0zuqr/n7NAPYjyUO3gXVsD6vBXmOCxYfs0dLdbQ==
X-Google-Smtp-Source: AGHT+IExVRO1+kzMUDoUuFIlx4XcBPDvavcE13W0hqKp7T4w3n6JiufAbMQZ93vA9b4zBgfJHaC3Pw==
X-Received: by 2002:a81:6c50:0:b0:583:af98:6fb3 with SMTP id h77-20020a816c50000000b00583af986fb3mr3182566ywc.15.1694632672797;
        Wed, 13 Sep 2023 12:17:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m128-20020a0de386000000b005837b48d16csm3297712ywe.84.2023.09.13.12.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 12:17:52 -0700 (PDT)
Date:   Wed, 13 Sep 2023 15:17:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 4/8] builtin/repack.c: extract redundant pack cleanup for
 existing packs
Message-ID: <82057de4cf3cbba67eb2cbbd8199909ed2108b82.1694632644.git.me@ttaylorr.com>
References: <cover.1693946195.git.me@ttaylorr.com>
 <cover.1694632644.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1694632644.git.me@ttaylorr.com>
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
index 71366811e9..b5fb14c017 100644
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
@@ -1222,11 +1237,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
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
2.42.0.166.g68748eb9c8

