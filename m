Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED0EC4332F
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 17:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243595AbiBWRzw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 12:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243583AbiBWRzt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 12:55:49 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D8F62F7
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 09:55:19 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c192so14248729wma.4
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 09:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FheJfNt4rgBk9mCbt6/7lxWi/jD4IcqMQZxKGewAEyY=;
        b=ZDZZ4QoFRy50Nbw9eEpFwKehGiW72vRC/VvXBg7nkEkYeT0+4uQkSoatbnJYE5opJO
         ut/cyt6/eh7i1RvQZiUblFcByw83q25oP1gM8cq/JzAw8n7vuUqqkhqdtrTdqREh/oGe
         JAOtlYfVKNK+8/oLCj8ZEbrFWU7MTP8CBLcsyXzMF4arVC4shb8b+MGtC1IPcEDGrrNy
         BEIc5YyHpPNoSkXPH2HtWn/Qw0HvUrQnuIbhq/9H4+zPaxzm+mwMqbaJT7m7OHMNtFQC
         p1euw4j6Dd3VNOy7pn6zGeMwZQJabCbXP2m9HZGS0jo3oXgUF/qtkUL6eLEvEbaiN35B
         Vl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FheJfNt4rgBk9mCbt6/7lxWi/jD4IcqMQZxKGewAEyY=;
        b=VbwpnnMI0RNO3/lxO4vcCKbEAGtbJo/cC/gEpAVmHzPAvr4VRj0ZYA5XM4QfwiPOVN
         4wUu1+0Gacx99gm+uMBiiT7koB2eG/QdE18OqV1XK9ggjTmc5xS9rY+W6Xa7f73fbGrC
         t1dSGkC/M76yEQNxS3EmK75/g1FIC8uMh/Yn2CveciNI6Bqh2EE1W2T+BRqv1FN5tMql
         6nvroK0QvzD2ttddFbsf+/Qwh8bxrfJrjzYOvIqFcKK0kZQlTga+30kE6JVb84gQA1Bm
         XXmJVIbtgmkgOEU0kNMAr7iJJf1dhskTGvlCsPVes3d3ce8lNAhKeyEMXRzFvzpi2+u4
         cneg==
X-Gm-Message-State: AOAM530264tZZF0GEX310BbRyGm29b6P21MmGdOPFM9e851nIpctPFhQ
        jqVrmeXee0XWezMHt4b21WqCFOQIYGg=
X-Google-Smtp-Source: ABdhPJxpmQS9BGCctTSfRJtBUqSVfKNOZ//bfj/FEZlXf4sy+UlxBMGiI6CXOVW3qZVUeTXd9mvJZA==
X-Received: by 2002:a7b:cd87:0:b0:37b:b8a8:2d28 with SMTP id y7-20020a7bcd87000000b0037bb8a82d28mr645947wmj.176.1645638918004;
        Wed, 23 Feb 2022 09:55:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c4f5500b0037d342db78asm387534wmq.35.2022.02.23.09.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 09:55:17 -0800 (PST)
Message-Id: <ec57ed5c37fdcb9fe31a16a09178642a5c219115.1645638911.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 17:55:05 +0000
Subject: [PATCH 05/11] list-objects: consolidate
 traverse_commit_list[_filtered]
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Now that all consumers of traverse_commit_list_filtered() populate the
'filter' member of 'struct rev_info', we can drop that parameter from
the method prototype to simplify things. In addition, the only thing
different now between traverse_commit_list_filtered() and
traverse_commit_list() is the presence of the 'omitted' parameter, which
is only non-NULL for one caller. We can consolidate these two methods by
having one call the other and use the simpler form everywhere the
'omitted' paramter would be NULL.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/pack-objects.c |  6 +++---
 builtin/rev-list.c     |  2 +-
 list-objects.c         | 25 ++++++++-----------------
 list-objects.h         | 12 ++++++++++--
 pack-bitmap.c          |  6 +++---
 5 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 57f2cf49696..0432ae1e499 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3778,9 +3778,9 @@ static void get_object_list(int ac, const char **av)
 
 	if (!fn_show_object)
 		fn_show_object = show_object;
-	traverse_commit_list_filtered(revs.filter, &revs,
-				      show_commit, fn_show_object, NULL,
-				      NULL);
+	traverse_commit_list(&revs,
+			     show_commit, fn_show_object,
+			     NULL);
 
 	if (unpack_unreachable_expiration) {
 		revs.ignore_missing_links = 1;
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 556e78aebb9..3ab727817fd 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -733,7 +733,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		oidset_init(&missing_objects, DEFAULT_OIDSET_SIZE);
 
 	traverse_commit_list_filtered(
-		revs.filter, &revs, show_commit, show_object, &info,
+		&revs, show_commit, show_object, &info,
 		(arg_print_omitted ? &omitted_objects : NULL));
 
 	if (arg_print_omitted) {
diff --git a/list-objects.c b/list-objects.c
index 2f623f82115..9422625b39e 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -416,22 +416,7 @@ static void do_traverse(struct traversal_context *ctx)
 	strbuf_release(&csp);
 }
 
-void traverse_commit_list(struct rev_info *revs,
-			  show_commit_fn show_commit,
-			  show_object_fn show_object,
-			  void *show_data)
-{
-	struct traversal_context ctx;
-	ctx.revs = revs;
-	ctx.show_commit = show_commit;
-	ctx.show_object = show_object;
-	ctx.show_data = show_data;
-	ctx.filter = NULL;
-	do_traverse(&ctx);
-}
-
 void traverse_commit_list_filtered(
-	struct list_objects_filter_options *filter_options,
 	struct rev_info *revs,
 	show_commit_fn show_commit,
 	show_object_fn show_object,
@@ -444,7 +429,13 @@ void traverse_commit_list_filtered(
 	ctx.show_object = show_object;
 	ctx.show_commit = show_commit;
 	ctx.show_data = show_data;
-	ctx.filter = list_objects_filter__init(omitted, filter_options);
+	if (revs->filter)
+		ctx.filter = list_objects_filter__init(omitted, revs->filter);
+	else
+		ctx.filter = NULL;
+
 	do_traverse(&ctx);
-	list_objects_filter__free(ctx.filter);
+
+	if (ctx.filter)
+		list_objects_filter__free(ctx.filter);
 }
diff --git a/list-objects.h b/list-objects.h
index a952680e466..9eaf4de8449 100644
--- a/list-objects.h
+++ b/list-objects.h
@@ -7,7 +7,6 @@ struct rev_info;
 
 typedef void (*show_commit_fn)(struct commit *, void *);
 typedef void (*show_object_fn)(struct object *, const char *, void *);
-void traverse_commit_list(struct rev_info *, show_commit_fn, show_object_fn, void *);
 
 typedef void (*show_edge_fn)(struct commit *);
 void mark_edges_uninteresting(struct rev_info *revs,
@@ -18,11 +17,20 @@ struct oidset;
 struct list_objects_filter_options;
 
 void traverse_commit_list_filtered(
-	struct list_objects_filter_options *filter_options,
 	struct rev_info *revs,
 	show_commit_fn show_commit,
 	show_object_fn show_object,
 	void *show_data,
 	struct oidset *omitted);
 
+static inline void traverse_commit_list(
+	struct rev_info *revs,
+	show_commit_fn show_commit,
+	show_object_fn show_object,
+	void *show_data)
+{
+	traverse_commit_list_filtered(revs, show_commit,
+				      show_object, show_data, NULL);
+}
+
 #endif /* LIST_OBJECTS_H */
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 613f2797cdf..cbefaedbf43 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -822,9 +822,9 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 		show_data.bitmap_git = bitmap_git;
 		show_data.base = base;
 
-		traverse_commit_list_filtered(revs->filter, revs,
-					      show_commit, show_object,
-					      &show_data, NULL);
+		traverse_commit_list(revs,
+				     show_commit, show_object,
+				     &show_data);
 
 		revs->include_check = NULL;
 		revs->include_check_obj = NULL;
-- 
gitgitgadget

