Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E27C2D0E7
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026DB206E6
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOF6exrq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgC0AtK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 20:49:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43433 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbgC0AtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 20:49:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id m11so3573673wrx.10
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 17:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cSY3A29VDuvvW7D6Nnb0e/FmTcYIDqSKYtNcN0V6bgA=;
        b=KOF6exrq3DivLx413UQB/XvRJ6KNjM1/tbxzYFMtADSVpc0Ia2MgwOpgNh3q75USup
         ew4QuBmHZb3lrWqRIqL6QdmqYuJrSEdXS9oZwNAtehqSA7gRT6sWmmfGhieBUTwNyzuc
         yfFltEHh7Q0iv/lNqAZe6amiqBTw2qyfIHkq3v03cBowICBf94DMaH+7KKWwXx2NTqag
         sbkP3fALBFmLbkX+drfQQvfYP5/zfOtxZshNbYHEw/JghL6va1o1vuDj9CQe06o405AK
         InpFUMvcKGLaa3bLmQHlnAGKkcZVdonaSNRilyBjzFlvHfQ0tobs1dneniQ49n20Uihx
         WY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cSY3A29VDuvvW7D6Nnb0e/FmTcYIDqSKYtNcN0V6bgA=;
        b=iPmMwD4OuotFwzhntWT5W0R9NneaUgYWU5w2BOpyR+OgjnpamoRkb1Q6xg/1muN8tZ
         vatL874Ji2LlE/XoUulxWAzpdMObhYUj1Oak1WsaEx6VIGFZSPz0ucRY8VtP2G1DIjoO
         IbaEgd7WIjLXZ+b4VxetkqY2buTlPHt+FMCI/OMV7RvuZHCUaiXvvgK6xLGme1zBW1C+
         PiNXWbmvkBA1+2PYB3CgeJFaV/ew/xHMPvtB38Kc+cDK16utapDeHzYb+ES9YQBXs4U3
         GE3s1AdOZhb1m5a2UBz1qIitqsnzQJq0G2S9o4lDVGW9dMONYEgQA+tdzg2WsU8mF6ia
         snFg==
X-Gm-Message-State: ANhLgQ1JakT0hQlGwNq3elnBj7Wd1f3Yb25bItkMgTI60rQVemCnL4ta
        PwTa7uu5mScsGAYpjwYOQypmnWXx
X-Google-Smtp-Source: ADFU+vta3O2Hozw87DzcaVUQ71inpfyrpXLUevCZtpIoK1+3UxdxQcABImhD8zaBiv25dOgL1PYW5A==
X-Received: by 2002:adf:eb51:: with SMTP id u17mr12895894wrn.29.1585270146376;
        Thu, 26 Mar 2020 17:49:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n2sm5516102wrr.62.2020.03.26.17.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 17:49:06 -0700 (PDT)
Message-Id: <1ce5dbe9c68c6a5377bab22297b3c8d684d2b16c.1585270142.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
References: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
        <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Mar 2020 00:48:47 +0000
Subject: [PATCH v3 04/18] unpack-trees: simplify pattern_list freeing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

commit e091228e17 ("sparse-checkout: update working directory
in-process", 2019-11-21) allowed passing a pre-defined set of patterns
to unpack_trees().  However, if o->pl was NULL, it would still read the
existing patterns and use those.  If those patterns were read into a
data structure that was allocated, naturally they needed to be free'd.
However, despite the same function being responsible for knowing about
both the allocation and the free'ing, the logic for tracking whether to
free the pattern_list was hoisted to an outer function with an
additional flag in unpack_trees_options.  Put the logic back in the
relevant function and discard the now unnecessary flag.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c | 1 -
 unpack-trees.c            | 6 ++++--
 unpack-trees.h            | 3 +--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 740da4b6d54..d102a9697fd 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -122,7 +122,6 @@ static int update_working_directory(struct pattern_list *pl)
 	o.dst_index = r->index;
 	o.skip_sparse_checkout = 0;
 	o.pl = pl;
-	o.keep_pattern_list = !!pl;
 
 	resolve_undo_clear_index(r->index);
 	setup_work_tree();
diff --git a/unpack-trees.c b/unpack-trees.c
index 3af2e126abf..d2863fa0310 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1503,6 +1503,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	int i, ret;
 	static struct cache_entry *dfc;
 	struct pattern_list pl;
+	int free_pattern_list = 0;
 
 	if (len > MAX_UNPACK_TREES)
 		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
@@ -1519,6 +1520,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		else
 			o->pl = &pl;
 		free(sparse);
+		free_pattern_list = 1;
 	}
 
 	memset(&o->result, 0, sizeof(o->result));
@@ -1686,9 +1688,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	o->src_index = NULL;
 
 done:
-	trace_performance_leave("unpack_trees");
-	if (!o->keep_pattern_list)
+	if (free_pattern_list)
 		clear_pattern_list(&pl);
+	trace_performance_leave("unpack_trees");
 	return ret;
 
 return_failed:
diff --git a/unpack-trees.h b/unpack-trees.h
index 6d7c7b6c2e0..d3516267f36 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -58,8 +58,7 @@ struct unpack_trees_options {
 		     quiet,
 		     exiting_early,
 		     show_all_errors,
-		     dry_run,
-		     keep_pattern_list;
+		     dry_run;
 	const char *prefix;
 	int cache_bottom;
 	struct dir_struct *dir;
-- 
gitgitgadget

