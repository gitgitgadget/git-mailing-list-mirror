Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A62C001DB
	for <git@archiver.kernel.org>; Sat,  5 Aug 2023 14:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjHEOYr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Aug 2023 10:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHEOYq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2023 10:24:46 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512E13C16
        for <git@vger.kernel.org>; Sat,  5 Aug 2023 07:24:45 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe32016bc8so26500545e9.1
        for <git@vger.kernel.org>; Sat, 05 Aug 2023 07:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691245483; x=1691850283;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fJ1eoHFUrw/vo3ws3rY0WM/Lc2XBOSTjATG9tWaUL6U=;
        b=pbKrwzzcfMNYxRfAOymjcfIb1Q642r1hlZoE4oPmOnP6ToQQ1iWOMhYoXZaqgg/sVL
         jEg2yehA6ya+nT+uAprwtgvU8vy+PDenJJ2AxWLA2hfWeLFTnW9iLo7VFXZ0WU0cGEBa
         D7QyqcqkhwK73JOhcGEHSld/qxzLK/sGeYEoyfP/3MzUPzGjvC5jyNx/Zpap0wbqClfp
         ZryWisC68X1gpoR6aXvfzRMQG+C2qM6GydQdXOn0W5buSOXOggTmFoKZEQRfzIseINQg
         N8fiFCzGbFbqznBvJN24r5/WeZsOy1DPCDY3B2OL0LGDzIE2fxC16rDpcr+FwA524eC8
         1NPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691245483; x=1691850283;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJ1eoHFUrw/vo3ws3rY0WM/Lc2XBOSTjATG9tWaUL6U=;
        b=hBZ0S/BnVNiJKfvvOfz/cNU3fMSjNi5yTTxTBOERjHWhAwyQ47Xdr60SRJsDqKFsjm
         Rs889ZW2iMFcAZobAsp2CcI7Grwf6YO1IrMZfT6b1U5oNd4YqcGvO8AEJOYibqb0FcZS
         DTfkFBAJ5ofLmohlk8x18K+wdGdWyqFNKBKyTSFvzNuw6tiiLga1d5Re9p4Y0QHYyr59
         AOT9lEMUk366yUuKAfVtvssIyDD7k6JZvltLVvq+69LlX86Y/poaw+9lhtfo3Cujdxl/
         QI1VY9RoDN/h5Ai8fWYtgZtLnBcFzFK7QPX5D9Yiu57KdpaCeJj5J8gZeH+FsD1RsHH9
         k+MA==
X-Gm-Message-State: AOJu0YxMdeOyRsoIFEPle6m7Ux4fsyfxi9n7pq+6TfIlOjynf/91uJhX
        tjdEPaYUourlrCVI97uluCZ4Yk6TvaI=
X-Google-Smtp-Source: AGHT+IHsmKr/PUKlFg8GAG491PrCpRVHAixLRNGkGHf9oqpUcrEl7NI7lJlZcmFI6RPCdfpIyHpgrQ==
X-Received: by 2002:a7b:cd10:0:b0:3fb:fca1:1965 with SMTP id f16-20020a7bcd10000000b003fbfca11965mr3180627wmj.18.1691245483338;
        Sat, 05 Aug 2023 07:24:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c294400b003fbe4cecc3bsm9489791wmd.16.2023.08.05.07.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 07:24:43 -0700 (PDT)
Message-ID: <pull.1565.git.1691245481977.gitgitgadget@gmail.com>
From:   "Izzy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 05 Aug 2023 14:24:41 +0000
Subject: [PATCH] merge-tree: add -X strategy option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Izzy <winglovet@gmail.com>, winglovet <winglovet@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: winglovet <winglovet@gmail.com>

Add merge strategy option to produce more customizable merge result such
as automatically solve conflicts.

Signed-off-by: winglovet <winglovet@gmail.com>
---
    merge-tree: add -X strategy option
    
    Change-Id: I16be592262d13cebcff8726eb043f7ecdb313b76

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1565%2FWingT%2Fmerge_tree_allow_strategy_option-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1565/WingT/merge_tree_allow_strategy_option-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1565

 builtin/merge-tree.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 0de42aecf4b..2ec6ec0d39a 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -19,6 +19,8 @@
 #include "tree.h"
 #include "config.h"
 
+static const char **xopts;
+static size_t xopts_nr, xopts_alloc;
 static int line_termination = '\n';
 
 struct merge_list {
@@ -414,6 +416,7 @@ struct merge_tree_options {
 	int show_messages;
 	int name_only;
 	int use_stdin;
+	struct merge_options merge_options;
 };
 
 static int real_merge(struct merge_tree_options *o,
@@ -439,6 +442,8 @@ static int real_merge(struct merge_tree_options *o,
 
 	init_merge_options(&opt, the_repository);
 
+	opt.recursive_variant = o->merge_options.recursive_variant;
+
 	opt.show_rename_progress = 0;
 
 	opt.branch1 = branch1;
@@ -510,6 +515,17 @@ static int real_merge(struct merge_tree_options *o,
 	return !result.clean; /* result.clean < 0 handled above */
 }
 
+static int option_parse_x(const struct option *opt,
+			  const char *arg, int unset)
+{
+	if (unset)
+		return 0;
+
+	ALLOC_GROW(xopts, xopts_nr + 1, xopts_alloc);
+	xopts[xopts_nr++] = xstrdup(arg);
+	return 0;
+}
+
 int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 {
 	struct merge_tree_options o = { .show_messages = -1 };
@@ -548,6 +564,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			   &merge_base,
 			   N_("commit"),
 			   N_("specify a merge-base for the merge")),
+		OPT_CALLBACK('X', "strategy-option", &xopts,
+			N_("option=value"),
+			N_("option for selected merge strategy"),
+			option_parse_x),
 		OPT_END()
 	};
 
@@ -556,6 +576,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, mt_options,
 			     merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTION);
 
+	for (int x = 0; x < xopts_nr; x++)
+		if (parse_merge_opt(&o.merge_options, xopts[x]))
+			die(_("unknown strategy option: -X%s"), xopts[x]);
+
 	/* Handle --stdin */
 	if (o.use_stdin) {
 		struct strbuf buf = STRBUF_INIT;

base-commit: ac83bc5054c2ac489166072334b4147ce6d0fccb
-- 
gitgitgadget
