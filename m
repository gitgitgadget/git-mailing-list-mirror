Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA6DC433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 09:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbiCaJWJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 05:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbiCaJWG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 05:22:06 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF87139AEB
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 02:20:19 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id y6so20304607plg.2
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 02:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xP6C+sGbg8Dc3rgp+9z2VVOK/GX4PRLPMazgX+zPKlY=;
        b=O5SdTMgdA8/tflP3iqLK0gBzBldlGRnA4DhnnXDG++ZpbkxPR+V3jR5HXeqDuGF/ys
         GeYGEq9rEiyBbpolNjNPHjRlTakwMojmc/L+TbdsowWkCSAfV5nSRcsdjYu3DqG+IzM9
         FZaHfCM6zfujFNCnr7eZN+DKpZCg9HnUKubmayBA1aKk8sz/w5cuzIXDfq6JWo0MhlA6
         KSKUBWAHR2AtXTgmTknZNxGpJiii3YNYlgf6sCVk0+KAf2IxoPoGQG5txrzJcEQDjSww
         eqyMk36zYPaPnqYmLQ1icsjfiztuFeIY8yMpVhlHGK0S2orshQMyXqP59yV8wt3ljX4y
         iKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xP6C+sGbg8Dc3rgp+9z2VVOK/GX4PRLPMazgX+zPKlY=;
        b=IpuTKYtELB6F5cusbcZG2Qy3e4zhdAxzQxGHx+QZUp1Q9GphNrDJB1he8zrONqBvB4
         Xp6V76ux7apblUvb6EXC2n1UjP/vJMgqgM7Tnuf/kdi74oyL4OOeGBa3Oxv/88xHz36X
         zGMh2YOr7swIajG6cOH5lQp/SVtf0J2Q0uY9EntVpxzzXj3DQgkXmIh5ylmjBHHiYsjh
         QNXd1Esu6fD9d/1sEjCBIpz3n8oRQzm8p3gHv92MGHJ8Eq4Smc8rdwY/KtB0DoQYwz3b
         +K3Un2thl8MXWvm4ndpNYQjduLn96ncVB+OqtFUqWaM+zGjWHt8KYmxYc0t0CnDrSQQM
         OuOA==
X-Gm-Message-State: AOAM533I90aInegs6VUciwd9KMPFA2KhvuPFj9Uapxvlpn5G5kIa+K2J
        NJVbmaq0YBh6fSecwgoPOXRVAu2x8hQ=
X-Google-Smtp-Source: ABdhPJxYoPqt8dpGfWrUY92cYLTOtgCEx+/2GJqnxzD8FkZ8RPzaVwoqghpDi6vN1nbOvD1TrMCp6g==
X-Received: by 2002:a17:902:a981:b0:156:229d:6834 with SMTP id bh1-20020a170902a98100b00156229d6834mr14853826plb.128.1648718419101;
        Thu, 31 Mar 2022 02:20:19 -0700 (PDT)
Received: from ffyuanda.localdomain ([119.131.153.75])
        by smtp.gmail.com with ESMTPSA id s3-20020a056a00194300b004f6664d26eesm27225931pfk.88.2022.03.31.02.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 02:20:18 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [WIP v1 1/4] mv: check if out-of-cone file exists in index with SKIP_WORKTREE bit
Date:   Thu, 31 Mar 2022 17:17:52 +0800
Message-Id: <20220331091755.385961-2-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Originally, moving a <source> file which is not on-disk but exists in
index as a SKIP_WORKTREE enabled cache entry, "giv mv" command errors
out with "bad source".

Change the checking logic, so that such <source>
file makes "giv mv" command warns with "advise_on_updating_sparse_paths()"
instead of "bad source"; also user now can supply a "--sparse" flag so
this operation can be carried out successfully.

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
I found a new problem introduced by this patch, it is written in the TODO.
I still haven't found a better way to reconcile this conflict. Please enlighten
me on this :-)

 builtin/mv.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 83a465ba83..32ad4d5682 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -185,8 +185,32 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 
 		length = strlen(src);
 		if (lstat(src, &st) < 0) {
+			/*
+			 * TODO: for now, when you try to overwrite a <destination>
+			 * with your <source> as a sparse file, if you supply a "--sparse"
+			 * flag, then the action will be done without providing "--force"
+			 * and no warning.
+			 *
+			 * This is mainly because the sparse <source>
+			 * is not on-disk, and this if-else chain will be cut off early in
+			 * this check, thus the "--force" check is ignored. Need fix.
+			 */
+
+			int pos = cache_name_pos(src, length);
+			if (pos >= 0) {
+				const struct cache_entry *ce = active_cache[pos];
+
+				if (ce_skip_worktree(ce)) {
+					if (!ignore_sparse)
+						string_list_append(&only_match_skip_worktree, src);
+					else
+						modes[i] = SPARSE;
+				}
+				else
+					bad = _("bad source");
+			}
 			/* only error if existence is expected. */
-			if (modes[i] != SPARSE)
+			else if (modes[i] != SPARSE)
 				bad = _("bad source");
 		} else if (!strncmp(src, dst, length) &&
 				(dst[length] == 0 || dst[length] == '/')) {
-- 
2.35.1

