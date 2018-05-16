Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 616AF1F406
	for <e@80x24.org>; Wed, 16 May 2018 16:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeEPQb7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 12:31:59 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:41946 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbeEPQb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 12:31:57 -0400
Received: by mail-wr0-f182.google.com with SMTP id g21-v6so2102032wrb.8
        for <git@vger.kernel.org>; Wed, 16 May 2018 09:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lFKhoRBWMIx/wjaUaZwbLnHVECxEJgafxR7Bj3essnE=;
        b=k6azkYpq64f6/HnrckmQrdhgYGuDI30JomaG+GXd+odLR+GtLfpzFyTWDhcmUwDHdZ
         H2H69DhGMWY/iBxXfljKw3Lcie2MdmRsXpLBWj2LPHjHutHrnAVK01kd6P+izgA+5uJ9
         ToKl5G9CZP3fzeQesbzEKXhbE2ctS7YVPf9md2qBJIgK44sddUejZVfUmWvHeozBrCtx
         z4hG+gWPma1/PdKw5r96w6hwQXlKVQbcxj1iSBykJaAk+7RvClJDL5WxQWvYuF/iGSya
         u7ey6rls9hQvXWgspUCBtl/YtSQ6r7A1lU9cA0tloJEOgnqxlGxIWtE1nIrl3T7+3onQ
         HPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lFKhoRBWMIx/wjaUaZwbLnHVECxEJgafxR7Bj3essnE=;
        b=OoXiPY+sUPnL2oFX7ZAopD+iBHwmj0v8EvVz9TN9t491ez4ngIi0JQhPOt4Ur2kiBl
         itc56XPk5bjv9W+KLcYGuo4yjB4h1ldSv0M4X9jgP4iPhn8o6nNqvdkcPThAtdfdj2JS
         n+c4bo+W0j+P+m0Gs1rucooR4opszKFw6qc0XehImxY3sAIkwivdI8X0NItOH8ms+PtH
         YAFEeAxO5yf2RgIsEzysHba+C34l3T4aLM3q+tbGDEYncmAk5ka4ILXbYcY33qGcDybX
         JObh050+wTa6/ixHlGJJSft6QFrANemsXCoNxu8qGhRCVqY5wL/7HHp3fvx2J2OWA3HO
         fSOA==
X-Gm-Message-State: ALKqPwe2M2/tkUvnfOpxca7XnRo81b4IUMiDX1JPUBfxHur/wFwLWjE7
        8WWFThlMDaCVM5F84cacJmE=
X-Google-Smtp-Source: AB8JxZrAa8KgPWOSK/y86ROcslsg4qX257B4+KqaYl6JjW1oUJOFXsqskNxKuhGCrRsuJpd3ecfpXg==
X-Received: by 2002:adf:87d4:: with SMTP id c20-v6mr1407481wrc.197.1526488315837;
        Wed, 16 May 2018 09:31:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id s14-v6sm3931772wmb.5.2018.05.16.09.31.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 May 2018 09:31:54 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Ben Peart <Ben.Peart@microsoft.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 3/3] unpack_trees_options: free messages when done
Date:   Wed, 16 May 2018 18:31:00 +0200
Message-Id: <abc39c9991d6df627b40fd8b4fe9812e7ef78d77.1526488122.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.583.g9a75a153ac
In-Reply-To: <cover.1526488122.git.martin.agren@gmail.com>
References: <CABPp-BHm4B5vXZGHn_i6Aycvc_PDNWSFxLFo9s-ijb511VY9RA@mail.gmail.com> <cover.1526488122.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The strings allocated in `setup_unpack_trees_porcelain()` are never
freed. Provide a function `clear_unpack_trees_porcelain()` to do so and
call it where we use `setup_unpack_trees_porcelain()`. The only
non-trivial user is `unpack_trees_start()`, where we should place the
new call in `unpack_trees_finish()`.

The `opts` string array contains multiple copies of the same pointers.
Be careful to only free each pointer once, then zeroize the whole array
so that we do not leave any dangling pointers.

Note that we only take responsibility for the memory allocated in
`setup_unpack_trees_porcelain()` and not any other members of the
`struct unpack_trees_options`.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 unpack-trees.h     |  5 +++++
 builtin/checkout.c |  1 +
 merge-recursive.c  |  1 +
 merge.c            |  3 +++
 unpack-trees.c     | 11 +++++++++++
 5 files changed, 21 insertions(+)

diff --git a/unpack-trees.h b/unpack-trees.h
index 41178ada94..70053cb3ff 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -33,6 +33,11 @@ enum unpack_trees_error_types {
 void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 				  const char *cmd);
 
+/*
+ * Frees resources allocated by setup_unpack_trees_porcelain().
+ */
+extern void clear_unpack_trees_porcelain(struct unpack_trees_options *opts);
+
 struct unpack_trees_options {
 	unsigned int reset,
 		     merge,
diff --git a/builtin/checkout.c b/builtin/checkout.c
index b49b582071..5cebe170fc 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -526,6 +526,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		init_tree_desc(&trees[1], tree->buffer, tree->size);
 
 		ret = unpack_trees(2, trees, &topts);
+		clear_unpack_trees_porcelain(&topts);
 		if (ret == -1) {
 			/*
 			 * Unpack couldn't do a trivial merge; either
diff --git a/merge-recursive.c b/merge-recursive.c
index ddb0fa7369..338f63a952 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -382,6 +382,7 @@ static int unpack_trees_start(struct merge_options *o,
 static void unpack_trees_finish(struct merge_options *o)
 {
 	discard_index(&o->orig_index);
+	clear_unpack_trees_porcelain(&o->unpack_opts);
 }
 
 struct tree *write_tree_from_memory(struct merge_options *o)
diff --git a/merge.c b/merge.c
index f123658e58..b433291d0c 100644
--- a/merge.c
+++ b/merge.c
@@ -130,8 +130,11 @@ int checkout_fast_forward(const struct object_id *head,
 
 	if (unpack_trees(nr_trees, t, &opts)) {
 		rollback_lock_file(&lock_file);
+		clear_unpack_trees_porcelain(&opts);
 		return -1;
 	}
+	clear_unpack_trees_porcelain(&opts);
+
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		return error(_("unable to write new index file"));
 	return 0;
diff --git a/unpack-trees.c b/unpack-trees.c
index 79fd97074e..25e766d30e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -179,6 +179,17 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 		opts->unpack_rejects[i].strdup_strings = 1;
 }
 
+void clear_unpack_trees_porcelain(struct unpack_trees_options *opts)
+{
+	char **msgs = (char **)opts->msgs;
+
+	free(msgs[ERROR_WOULD_OVERWRITE]);
+	free(msgs[ERROR_WOULD_LOSE_UNTRACKED_REMOVED]);
+	free(msgs[ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN]);
+
+	memset(opts->msgs, 0, sizeof(opts->msgs));
+}
+
 static int do_add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
 			 unsigned int set, unsigned int clear)
 {
-- 
2.17.0.583.g9a75a153ac

