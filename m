Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC4211F406
	for <e@80x24.org>; Wed, 16 May 2018 16:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeEPQb4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 12:31:56 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37134 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbeEPQbz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 12:31:55 -0400
Received: by mail-wr0-f196.google.com with SMTP id h5-v6so2101091wrm.4
        for <git@vger.kernel.org>; Wed, 16 May 2018 09:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n8MIzP5r5l3Hlk4u8Mm+AsMY5YdqVTkALqajo6SpdyU=;
        b=Zt/UsSXHAolbsVKov1V0NNzG1x6fJuvAoN+lNzcxPGiS2DB7DIMgEwbU0Rnwk4YKWJ
         YAxLmQu/fka3QunjKQhXUCM8sW0895pPYiLnNmEem1aDW9vPKAikXtfGlplTZDZde5pq
         fyiwZK7Qa6V6WjF93SfVHLwM1auhQzF/jA93ih31RKxvZ3PYxdG0grP1ZUuCP1cR+/Co
         dFehydyZ9qfeUYFp/fV+py3JR1R/tdnUr4QCc9wJvTnGSpxj4uKQwEKMMZxFIabU9ISl
         4DY93NWtCfaDG73/ePYP1hJ3eJY5il6cx2zCn7AUhluAjYRDquP8cnOZToI5k51oRE1b
         sP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n8MIzP5r5l3Hlk4u8Mm+AsMY5YdqVTkALqajo6SpdyU=;
        b=pXCQtHNRBVxEaDKvR/ZyeLoJtUQNk2syd6xnnAyhAr/qIXTFQqJ/j2jYk0oBq5q+4C
         ujUQ/XUAGwlxfGTGtT0sg2vr1kJXlD340mrrMZonYspComoRKN5QcgGJyiyMJ9GTRAKi
         f/4SkT4GHyqT3jHmNNrxH9SnRm6/XrLCBAyeylLFXXNy5TYayIrfthjwYm6/clUOKMcv
         ZnZYHD9Qa2PKVHmYU9OEre4Gb4cjYEYo9LgFhWF8SRq+Ybd6qWgwXsOlZU+ap1KBTrx6
         MIFiN50+ObAxCOGc1a7V8JhjXNjFCxljrCM8F7seIYoN8e6GtQ/qmUQfVIIVN02gShuQ
         9PEQ==
X-Gm-Message-State: ALKqPweXA0qpp1+gZPkbKYwE594Cb9raUu9SakgYD2l91Pjz34eu+XSp
        Wy1CjsLhrm07B7TQG04+GqE=
X-Google-Smtp-Source: AB8JxZq9RpGSfdRb8+4rddR+MeoH8uexVYo0id5SFXipkoCqwNpJhoKzGdqc6xubbCS08NsljUArcg==
X-Received: by 2002:adf:91a2:: with SMTP id 31-v6mr1447812wri.124.1526488313978;
        Wed, 16 May 2018 09:31:53 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id s14-v6sm3931772wmb.5.2018.05.16.09.31.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 May 2018 09:31:53 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Ben Peart <Ben.Peart@microsoft.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 2/3] merge-recursive: provide pair of `unpack_trees_{start,finish}()`
Date:   Wed, 16 May 2018 18:30:59 +0200
Message-Id: <f38f5e7467ad1a916cb6ff10638c70587f83d831.1526488122.git.martin.agren@gmail.com>
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

From: Elijah Newren <newren@gmail.com>

Rename `git_merge_trees()` to `unpack_trees_start()` and extract the
call to `discard_index()` into a new function `unpack_trees_finish()`.
As a result, these are called early resp. late in `merge_trees()`,
making the resource handling clearer. The next commit will expand on
that, teaching `..._finish()` to free more memory. (So rather than
moving the FIXME-comment, just drop it, since it will be addressed soon
enough.)

Also call `..._finish()` when `merge_trees()` returns early.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 merge-recursive.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 680e01226b..ddb0fa7369 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -337,10 +337,10 @@ static void init_tree_desc_from_tree(struct tree_desc *desc, struct tree *tree)
 	init_tree_desc(desc, tree->buffer, tree->size);
 }
 
-static int git_merge_trees(struct merge_options *o,
-			   struct tree *common,
-			   struct tree *head,
-			   struct tree *merge)
+static int unpack_trees_start(struct merge_options *o,
+			      struct tree *common,
+			      struct tree *head,
+			      struct tree *merge)
 {
 	int rc;
 	struct tree_desc t[3];
@@ -379,6 +379,11 @@ static int git_merge_trees(struct merge_options *o,
 	return rc;
 }
 
+static void unpack_trees_finish(struct merge_options *o)
+{
+	discard_index(&o->orig_index);
+}
+
 struct tree *write_tree_from_memory(struct merge_options *o)
 {
 	struct tree *result = NULL;
@@ -3088,13 +3093,14 @@ int merge_trees(struct merge_options *o,
 		return 1;
 	}
 
-	code = git_merge_trees(o, common, head, merge);
+	code = unpack_trees_start(o, common, head, merge);
 
 	if (code != 0) {
 		if (show(o, 4) || o->call_depth)
 			err(o, _("merging of trees %s and %s failed"),
 			    oid_to_hex(&head->object.oid),
 			    oid_to_hex(&merge->object.oid));
+		unpack_trees_finish(o);
 		return -1;
 	}
 
@@ -3147,20 +3153,15 @@ int merge_trees(struct merge_options *o,
 
 		hashmap_free(&o->current_file_dir_set, 1);
 
-		if (clean < 0)
+		if (clean < 0) {
+			unpack_trees_finish(o);
 			return clean;
+		}
 	}
 	else
 		clean = 1;
 
-	/* Free the extra index left from git_merge_trees() */
-	/*
-	 * FIXME: Need to also free data allocated by
-	 * setup_unpack_trees_porcelain() tucked away in o->unpack_opts.msgs,
-	 * but the problem is that only half of it refers to dynamically
-	 * allocated data, while the other half points at static strings.
-	 */
-	discard_index(&o->orig_index);
+	unpack_trees_finish(o);
 
 	if (o->call_depth && !(*result = write_tree_from_memory(o)))
 		return -1;
-- 
2.17.0.583.g9a75a153ac

