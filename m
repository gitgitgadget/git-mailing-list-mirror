Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53DBC433EF
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 11:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiFWLl5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 07:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiFWLls (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 07:41:48 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8914BFF3
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 04:41:47 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id i64so18851757pfc.8
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 04:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9iaetEQDKHbfqnoZNuD5o6iw6SbIV5GTRxdHSt2XRlA=;
        b=RMzxk2s3BJ75qeHBdduQkfX6/9X9E3PRaN3RCQwn7VM6sPv0Mjv91wgKnhg7Pb8DGL
         IiPO1aZEibVRjpfuL4dOzvrEd1En4PlZw1TNnLhLsr6NL0zjqmLcpffrUdANdm962dGK
         Sa/ZgYC21EiSeR9oe2B6tbHz3tnJd+gT08ZygyDzH8+eRPr5fnLCwPTps6ADaX/0CyM7
         y8HJuDh0DniLYBiFqBg11vdamMRxpr0XKXDdDnjReQ1qlkpvbLVJpS2S6Fr1e2WhNIly
         Eyg7Ff9EEIfGFtJgsipDwO2MJ5L/6/iXiwvC65xbZqhU1J6WvveDLoj5SF5AKoT0Imtt
         eCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9iaetEQDKHbfqnoZNuD5o6iw6SbIV5GTRxdHSt2XRlA=;
        b=zUXzfJwk3Tp6JLl8ISp0W6/nk5Px709s5WQ5wk+PvgJINdiOztL5SkUHdY7N2hwgoT
         fHCG9xOTgW3oq/J9zKlSOC+U/7Pxf5xsug6urYHXrdP9Q80/AJk0+a3rCe16h2zoduge
         Tn8mEtHeuvo5Qr23B4a+IC5x5Lj4ta84tgSWwPp2fI5LwRl9VW3geWsSzh9M67sdD7DY
         cGy4UNm07WMbUJfTWvfolkpdlO+jSJRatMnZtRZ7sxANS78VCGQ4grKxuMnh906OvePv
         qUGuRpYrV3882erKUcFQqKc0P0p/LPU/TMDl3w+ku9121090ZenMmOiY2fHOc7oof0o/
         XqdA==
X-Gm-Message-State: AJIora9TsuSs/PA2mkRvrrJntiwHGdvqkDN/S7v+lUmxkpGBiBvTOgBg
        kfRjB6VuYjx/7ww6vlZADdc=
X-Google-Smtp-Source: AGRyM1u2qOp4AieNlE69/qQxI2S601YlCtkLYM/VOUtd4bDyW+ZLIOyjE6UEz0gf9WlS3lfhcqvIsg==
X-Received: by 2002:a63:4c1d:0:b0:3fd:9833:cdd9 with SMTP id z29-20020a634c1d000000b003fd9833cdd9mr7385244pga.103.1655984507552;
        Thu, 23 Jun 2022 04:41:47 -0700 (PDT)
Received: from ffyuanda.localdomain ([112.195.146.236])
        by smtp.gmail.com with ESMTPSA id j7-20020a17090a7e8700b001ec4f258028sm1629299pjl.55.2022.06.23.04.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 04:41:47 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     shaoxuan.yuan02@gmail.com
Cc:     derrickstolee@github.com, git@vger.kernel.org, gitster@pobox.com,
        vdye@github.com
Subject: [PATCH v4 2/7] mv: update sparsity after moving from out-of-cone to in-cone
Date:   Thu, 23 Jun 2022 19:41:15 +0800
Message-Id: <20220623114120.12768-3-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220623114120.12768-1-shaoxuan.yuan02@gmail.com>
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220623114120.12768-1-shaoxuan.yuan02@gmail.com>
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
index 83a465ba83..0c0c2b4914 100644
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
+				die(_("cannot checkout %s"), ce->name);
+		}
 	}
 
 	if (gitmodules_modified)
-- 
2.35.1

