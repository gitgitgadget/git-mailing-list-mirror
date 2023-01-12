Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE49DC54EBD
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 12:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjALMzv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 07:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjALMzh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 07:55:37 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CC44D707
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:55:35 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m3so13139777wmq.0
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zK57SPwE6ICJ6DhEECGgSFWClqbZSAkKzXuz8ZxPP0=;
        b=VUrLJBiSFuYZutpjDoO0qZ+t7BKgxWXlTDpfxTeAjSWz7ZUQws48+iRN5QYRgr2yWM
         I7NJhRIaCE+25+P0kth03mH3NWXFpnQLkZdlXkqMMubY6G5il2PJ6N9SNgvepMUZPN8+
         Er6BkV8AYzsoFHfCHlORc1qpJFl+lyoBEgTtbeIRvMvTceMNDtFIOAXtcz4DYcLFIMzQ
         cqyStkcdhvoPTlfsh1Uo+YtM5ca6frThEs2hDF95/rBaxvJeDjJGeSNivoluINEXdUKT
         S1QXMlzPuMTKq+cZ5eywrN+XV+tapRzU1Vv5oTekMBJHarIJRoLQhJzl60BX7+PLTbS7
         J2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zK57SPwE6ICJ6DhEECGgSFWClqbZSAkKzXuz8ZxPP0=;
        b=HgxYc3L16Jk6n/GtGQs/A+MWH2/BOQ8bQewtJTSlt+kEEyq6/S4rCTdYBb432toCY+
         TaPevELk5cQGSp98NLRZFwVjuV4bmX5lzqEP1RXNr3OSDje6GkrQWJ8zJgNErWip9Bj6
         mvYaP4tI8zYXVmgoi1SoTthfostoek0uBbd30JAaCmho7iFd23BwJj0j+z7bW/RfXPto
         LqU9n7iWpqae8sF89UWrYYOeVRtwjtI4ir/LMrJdTRCS3EOUiaXc5ZCdMnftB6c87spQ
         vg98TDz8UlwcNfqZ4/lDJqCZMpFV4tKumx4ypbJI1DAIDTLYt/vQzX60ym1PYbZpKzId
         Q1jw==
X-Gm-Message-State: AFqh2kresNgBemnqc155T28Nzdk0R8PJbwGRuVxMe5C+8aRQvR5n5N6a
        EQhab+pRMfn0jSLSGfR14ZHPxgXjBmQeTg==
X-Google-Smtp-Source: AMrXdXtgWTijYbds3LMfjNe4aON/tABirhlFf/IpvmBUR6W3I3XbAM96wcKXu++VVJiopWtkwFhCWQ==
X-Received: by 2002:a05:600c:a0f:b0:3cf:7704:50ce with SMTP id z15-20020a05600c0a0f00b003cf770450cemr56368726wmp.38.1673528134031;
        Thu, 12 Jan 2023 04:55:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c154c00b003d9fba3c7a4sm8462473wmg.16.2023.01.12.04.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 04:55:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/6] sparse-index API: BUG() out on NULL ensure_full_index()
Date:   Thu, 12 Jan 2023 13:55:25 +0100
Message-Id: <patch-v2-3.6-25e9cff0e97-20230112T124842Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1205.g2ca064edc27
In-Reply-To: <cover-v2-0.6-00000000000-20230112T124842Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20230112T124842Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the ensure_full_index() function stricter, and have it only
accept a non-NULL "struct index_state". This function (and this
behavior) was added in [1].

The only reason it needed to be this lax was due to interaction with
repo_index_has_changes(). See the addition of that code in [2].

The other reason for why this was needed dates back to interaction
with code added in [3]. In [4] we started calling ensure_full_index()
in unpack_trees(), but the caller added in 34110cd4e39 wants to pass
us a NULL "dst_index". Let's instead do the NULL check in
unpack_trees() itself.

1. 4300f8442a2 (sparse-index: implement ensure_full_index(), 2021-03-30)
2. 0c18c059a15 (read-cache: ensure full index, 2021-04-01)
3. 34110cd4e39 (Make 'unpack_trees()' have a separate source and
   destination index, 2008-03-06)
4. 6863df35503 (unpack-trees: ensure full index, 2021-03-30)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sparse-index.c | 4 +++-
 unpack-trees.c | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index 65a08d33c73..86e3b99870b 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -299,7 +299,7 @@ void expand_index(struct index_state *istate, struct pattern_list *pl)
 	 * If the index is already full, then keep it full. We will convert
 	 * it to a sparse index on write, if possible.
 	 */
-	if (!istate || istate->sparse_index == INDEX_EXPANDED)
+	if (istate->sparse_index == INDEX_EXPANDED)
 		return;
 
 	/*
@@ -424,6 +424,8 @@ void expand_index(struct index_state *istate, struct pattern_list *pl)
 
 void ensure_full_index(struct index_state *istate)
 {
+	if (!istate)
+		BUG("ensure_full_index() must get an index!");
 	expand_index(istate, NULL);
 }
 
diff --git a/unpack-trees.c b/unpack-trees.c
index ea09023b015..2381cd7cac4 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1880,7 +1880,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	prepare_repo_settings(repo);
 	if (repo->settings.command_requires_full_index) {
 		ensure_full_index(o->src_index);
-		ensure_full_index(o->dst_index);
+		if (o->dst_index)
+			ensure_full_index(o->dst_index);
 	}
 
 	if (o->reset == UNPACK_RESET_OVERWRITE_UNTRACKED &&
-- 
2.39.0.1205.g2ca064edc27

