Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC2DC43466
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 11:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 851B320EDD
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 11:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uILxKJDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgITLWq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 07:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgITLWm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 07:22:42 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B96C0613D1
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 04:22:42 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id u3so5465225pjr.3
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 04:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HHx/hH4zc/dFFPU7CSqaDXlSFiLE7zmrnQkbrFu3PEM=;
        b=uILxKJDLc9e5xUcLLDIi3kRQYguCbY4owRDKOHAUMsVu9be8VAvPxxJKXMQzO9q5LR
         v68lFPdq43H6/fVoQzswIKfiJ7Hk8x6z6XfDl+uEtjXLyPPyelvzVVdZ5Xkykk8uOdWt
         RtUEDkGD/xG+xeA2TOtByujQI1kpfTesgXzHe0Fyrpza77v+KoYkwyc3kgu7f0R/mIvm
         N1f1OUt2BUkEy/DzZ2TnLSHZlFuYsIcuVqGVJuElcJHrLAAeMoRsw4vDGdJh/wJM0VLh
         26s2BuzqFWS8ixYc84cxVhQ4mCA5KDz2vpv7vX++4Bwro3K8VNkH+y3rnVMhfBLXNnP3
         lwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HHx/hH4zc/dFFPU7CSqaDXlSFiLE7zmrnQkbrFu3PEM=;
        b=qG1O3XODUs00N4KVivlALsnZ21YqzMe30y+eAIiUpYbK9ZpzI6QOmsbxZBcwMT+gcX
         T08D2tdbX9e32TKRl+uCv4nU8Fne5bDNM/ucjXNX4DuFstx8Sz6VO/lp4T0MKgiIT0Ei
         7HnYVurBSTMy65S4xwMkZIO8u6o3OHR8UybqMcMFy+QSQ+Z1xrSD75AeD0imBCNpZHMb
         M17O8OiDZAPfXUYueJcjxgp14AWOV+kWW5RrNXZ1pGa/wKTQDKAegnJwbIouIWqVIjyr
         T9FyOeMtSyfvJokwDzYC2Me/pKmgeRgQMFLGo4OBWG7LbJKZyXFRthhaBsCq7KmmnIN4
         p3kQ==
X-Gm-Message-State: AOAM532MAkDFH/uqyoak0LjpUkb71HXeW5dWYS9MYB4+hw+hB5fn985J
        qD5uTACt8G5ePmGyYXaSkzgSVvhOkvs=
X-Google-Smtp-Source: ABdhPJy5F2S28oF71j0p482RSlIUEXEWCOcgBYolbB+1O6vJp/PXb3GQ2KAkiqU00DP1PqB1lgmC4w==
X-Received: by 2002:a17:90b:4ac2:: with SMTP id mh2mr19137875pjb.210.1600600962129;
        Sun, 20 Sep 2020 04:22:42 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id y79sm9550737pfb.45.2020.09.20.04.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 04:22:41 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 06/10] diff-lib: define diff_get_merge_base()
Date:   Sun, 20 Sep 2020 04:22:23 -0700
Message-Id: <3287e649f15fe8ca2dca924a29f36132bbce96f8.1600600823.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.760.g8d73e04208
In-Reply-To: <cover.1600600823.git.liu.denton@gmail.com>
References: <cover.1600328335.git.liu.denton@gmail.com> <cover.1600600823.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future commit, we will be using this function to implement
--merge-base functionality in various diff commands.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 diff-lib.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 diff.h     |  2 ++
 2 files changed, 47 insertions(+)

diff --git a/diff-lib.c b/diff-lib.c
index d5b2c8af56..fa64e64bbe 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -13,6 +13,7 @@
 #include "submodule.h"
 #include "dir.h"
 #include "fsmonitor.h"
+#include "commit-reach.h"
 
 /*
  * diff-files
@@ -518,6 +519,50 @@ static int diff_cache(struct rev_info *revs,
 	return unpack_trees(1, &t, &opts);
 }
 
+void diff_get_merge_base(const struct rev_info *revs, struct object_id *mb)
+{
+	int i;
+	struct commit *mb_child[2] = {0};
+	struct commit_list *merge_bases;
+
+	for (i = 0; i < revs->pending.nr; i++) {
+		struct object *obj = revs->pending.objects[i].item;
+		if (obj->flags)
+			die(_("--merge-base does not work with ranges"));
+		if (obj->type != OBJ_COMMIT)
+			die(_("--merge-base only works with commits"));
+	}
+
+	/*
+	 * This check must go after the for loop above because A...B
+	 * ranges produce three pending commits, resulting in a
+	 * misleading error message.
+	 */
+	if (revs->pending.nr < 1 || revs->pending.nr > 2)
+		BUG("unexpected revs->pending.nr: %d", revs->pending.nr);
+
+	for (i = 0; i < revs->pending.nr; i++)
+		mb_child[i] = lookup_commit_reference(the_repository, &revs->pending.objects[i].item->oid);
+	if (revs->pending.nr == 1) {
+		struct object_id oid;
+
+		if (get_oid("HEAD", &oid))
+			die(_("unable to get HEAD"));
+
+		mb_child[1] = lookup_commit_reference(the_repository, &oid);
+	}
+
+	merge_bases = repo_get_merge_bases(the_repository, mb_child[0], mb_child[1]);
+	if (!merge_bases)
+		die(_("no merge base found"));
+	if (merge_bases->next)
+		die(_("multiple merge bases found"));
+
+	oidcpy(mb, &merge_bases->item->object.oid);
+
+	free_commit_list(merge_bases);
+}
+
 int run_diff_index(struct rev_info *revs, unsigned int option)
 {
 	struct object_array_entry *ent;
diff --git a/diff.h b/diff.h
index aea0d5b96b..fedfeab7a2 100644
--- a/diff.h
+++ b/diff.h
@@ -580,6 +580,8 @@ void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc);
  */
 const char *diff_aligned_abbrev(const struct object_id *sha1, int);
 
+void diff_get_merge_base(const struct rev_info *revs, struct object_id *mb);
+
 /* do not report anything on removed paths */
 #define DIFF_SILENT_ON_REMOVED 01
 /* report racily-clean paths as modified */
-- 
2.28.0.760.g8d73e04208

