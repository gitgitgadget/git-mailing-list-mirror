Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C14DF200B9
	for <e@80x24.org>; Mon, 21 May 2018 14:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752666AbeEUOzI (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 10:55:08 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53694 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbeEUOzI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 10:55:08 -0400
Received: by mail-wm0-f67.google.com with SMTP id a67-v6so25682381wmf.3
        for <git@vger.kernel.org>; Mon, 21 May 2018 07:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0+4EykAdALYiYNPxzmXdCYJ9OoMiR8RFtOpgYbVPeo0=;
        b=gWw2owbEg/XCT4x4OL4bTbA1VWrp9lo2ZJY07RwQz5HeKQTA9XMysc458dvRhiLHnQ
         w+Bdqle3X99zNB7Fd23DzkhP7/H0yWQyLQnQrlixEaDKNfsYd+nSCbCEKaMAb/Xkyeqd
         T+IIGFbaBaneFz2V0nld9w+UQqVvuWJ+AmcJxiz7gfdP0AUsViVAdI4j6vwISsx74Xrv
         y2gB3IyIxWoPYYDB6aUeBS7glIzpecP9Bq0vxFwLbG6Ph2r5YBklfDm7VXBNzktukh2A
         6yozNIU2OiAiSeD5Poz4g81AFRlvOywCqnUMLVS7PEangHz25mT+yD1asQni7F2qczcL
         0quQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0+4EykAdALYiYNPxzmXdCYJ9OoMiR8RFtOpgYbVPeo0=;
        b=BR5mDCF7dI6X/BzDAFFqTbJZFYhUIwjt4ElJnZGtIjVCIJlwKZBFFatH+RB96WOjKv
         DKWaeq4q2k67JL0Gv8AYZkGeR4SclkawN6zO/5AxyjVm2ByGItuzQIDZFlED8/CqOirF
         /BerdhX3eBZqNsTNeBcv248vJCSc70R8xI+1x4ZxygdqI6LUtRVghYhga0izBPr+zk+j
         kOSM9zTMI2Yl5hTpLffcMBmXMmo5S+npgl8reo+DPeF+sdWsEI54GyXUOa74f75KlIXg
         iLSI0D0Y1YkHlZnB0a+8LyWslcczh8GFkEvSeFX7rp0Vds1oWGZYzda6ZhfRBhGSoXFm
         Gg2g==
X-Gm-Message-State: ALKqPwdfUYcPCMIU+fbJKwO0SXevezB6ZhaBEmcluLeM99PfJY0epTxo
        P5L/yS6ryJpnhUDhkX3LMQg=
X-Google-Smtp-Source: AB8JxZrDPcU9sb6zq/YweNVaP8RgaE3LfnRgcanZ+qD3YYJscPTyIKMQP+zkkyNFV1pABnR/zRQirw==
X-Received: by 2002:a1c:16ca:: with SMTP id 193-v6mr10517989wmw.37.1526914506791;
        Mon, 21 May 2018 07:55:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id b10-v6sm37627460wrn.42.2018.05.21.07.55.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 May 2018 07:55:05 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v5 2/4] merge-recursive: provide pair of `unpack_trees_{start,finish}()`
Date:   Mon, 21 May 2018 16:54:26 +0200
Message-Id: <3f1c1c360080114fcc9492211601f41d56112e3c.1526913784.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.840.g5d83f92caf
In-Reply-To: <cover.1526913784.git.martin.agren@gmail.com>
References: <xmqqr2m53leq.fsf@gitster-ct.c.googlers.com> <cover.1526913784.git.martin.agren@gmail.com>
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
making the resource handling clearer. A later commit will expand on
that, teaching `..._finish()` to free more memory. (So rather than
moving the FIXME-comment, just drop it, since it will be addressed soon
enough.)

Also call `..._finish()` when `merge_trees()` returns early.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.17.0.840.g5d83f92caf

