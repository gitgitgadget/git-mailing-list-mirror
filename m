Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B61C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 02:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbiF3CiF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 22:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbiF3Ch6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 22:37:58 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E95321825
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 19:37:57 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id s206so8127453pgs.3
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 19:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BKY8VKeomF5uLQE+A3hpO0zka/Olvjbl7ArzwaV0FSw=;
        b=Pa9TkrEYspi5RXuYWMWOOx4P2aYaqpCZXV4VjqORLMoO1szG2q317sCfkHV1T4t2NM
         ZBL0zXuwi4eIa9CnPge1NTbDoVtAc5YVtA0RtGjnTsMZzRZlcHjETUy23kRbNDQky9md
         j8SrDeifqALHyIrZGDGYM7dN9UTDKf+dDuRIVsZzblX5llo6dN/VyuG6YmTUu5YCuIlx
         TOybgomHMYRDjnTb+vJ6859CQmKcxFKAUfkRxW4Rr2usV3Vt2cGx65JUngzHEGKVX3Qa
         z7y3FtHzA1kJrsHgDQTu9NfOc4dLIL+/DF7lj3j/fv/DG7n+ClyOwDIpOYo1XMM6R043
         YfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BKY8VKeomF5uLQE+A3hpO0zka/Olvjbl7ArzwaV0FSw=;
        b=maRr7GeH3+7idAp9DOw4FxdlrFiqaOu0BCaxoTOZ1oZIqhJQBUNTnYldiN5o9+jGsx
         kD/AqRiyFComS0AmmxoGukiHy/W36/9dD82kvGboUTi+7aVePXOl1HBpNnKpjUDffYKP
         558KDKWAegLmIqWMQFtZo3RkkgNCPEqqxa1Xt6+alnu9eYNN9/habmiuDX9QYXLecHig
         4DOOtpyb37AFQ2VAkBK7SkuTJYJYs0CkCNT+9F1PAbSk2sSZ356lWifRH1KffuGjOGbQ
         2gQgAFWdAJwZgfRDTZmXSpfC77mAj0f6Us+7CsJeJT0BrWSwyHuTIRGrdgTlbuzjxLIN
         n2Jw==
X-Gm-Message-State: AJIora+1rrAwsn+MC6MqHej2oaiWusrPSzaqrNp/BuRPZDK2cBg9fS9s
        1WVLP+4T7tCrefmGlfUGy745IgLEzTY=
X-Google-Smtp-Source: AGRyM1swPw12qxAHo0IesUJ3fvG89vWDQnvql6plwuG19MvC1reJnUACGVk7LI8IA4Tbi2B+vR1hmw==
X-Received: by 2002:a63:de43:0:b0:40d:a0f0:441 with SMTP id y3-20020a63de43000000b0040da0f00441mr5493668pgi.121.1656556677042;
        Wed, 29 Jun 2022 19:37:57 -0700 (PDT)
Received: from ffyuanda.localdomain ([101.206.226.29])
        by smtp.gmail.com with ESMTPSA id c16-20020a170902b69000b001678dcb4c5asm12157509pls.100.2022.06.29.19.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 19:37:56 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, vdye@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v5 3/8] mv: update sparsity after moving from out-of-cone to in-cone
Date:   Thu, 30 Jun 2022 10:37:32 +0800
Message-Id: <20220630023737.473690-4-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220630023737.473690-1-shaoxuan.yuan02@gmail.com>
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220630023737.473690-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Originally, "git mv" a sparse file from out-of-cone to
in-cone does not update the moved file's sparsity (remove its
SKIP_WORKTREE bit). And the corresponding cache entry is, unexpectedly,
not checked out in the working tree.

Update the behavior so that:
1. Moving from out-of-cone to in-cone removes the SKIP_WORKTREE bit from
   corresponding cache entry.
2. The moved cache entry is checked out in the working tree to reflect
   the updated sparsity.

Helped-by: Victoria Dye <vdye@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/mv.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/builtin/mv.c b/builtin/mv.c
index 83a465ba83..5f4eeadd5d 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -13,6 +13,7 @@
 #include "string-list.h"
 #include "parse-options.h"
 #include "submodule.h"
+#include "entry.h"
 
 static const char * const builtin_mv_usage[] = {
 	N_("git mv [<options>] <source>... <destination>"),
@@ -304,6 +305,11 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		const char *src = source[i], *dst = destination[i];
 		enum update_mode mode = modes[i];
 		int pos;
+		struct checkout state = CHECKOUT_INIT;
+		state.istate = &the_index;
+
+		if (force)
+			state.force = 1;
 		if (show_only || verbose)
 			printf(_("Renaming %s to %s\n"), src, dst);
 		if (show_only)
@@ -328,6 +334,17 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		pos = cache_name_pos(src, strlen(src));
 		assert(pos >= 0);
 		rename_cache_entry_at(pos, dst);
+
+		if ((mode & SPARSE) &&
+		    (path_in_sparse_checkout(dst, &the_index))) {
+			int dst_pos;
+
+			dst_pos = cache_name_pos(dst, strlen(dst));
+			active_cache[dst_pos]->ce_flags &= ~CE_SKIP_WORKTREE;
+
+			if (checkout_entry(active_cache[dst_pos], &state, NULL, NULL))
+				die(_("cannot checkout %s"), active_cache[dst_pos]->name);
+		}
 	}
 
 	if (gitmodules_modified)
-- 
2.35.1

