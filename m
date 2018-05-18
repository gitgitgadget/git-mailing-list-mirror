Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04F3F1F51C
	for <e@80x24.org>; Fri, 18 May 2018 21:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751846AbeERVYR (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 17:24:17 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44315 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751768AbeERVYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 17:24:16 -0400
Received: by mail-wr0-f195.google.com with SMTP id y15-v6so10485482wrg.11
        for <git@vger.kernel.org>; Fri, 18 May 2018 14:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iN+M0WkfQ0dP6GM6J58Hts7FuA2XqRRlayZs69euiW8=;
        b=VsvCYM9MQnBiBitFB3I5qUNi5B/q6VFFYSeB9puAl6hz3pAR/pEJZsvJwrYu86RLWs
         X416I8+wlSMnVkpocWJ9ndp7YHH+ec8cK+Ca2Fsw27QVAiVhKrBNt8FwYNmYyiFbQEAc
         +i2dPc1fqhgPNdN6rJDgOcPdUui1RKQOwtGROzQWW20ec2VYoy2TMT93JNM35eHiTXxL
         gSSBKno+P1RPMuh31dsoXsjepiUJHLFixnkwNDaIG+6T6HpheQkugAVsptkmG54Kpd3E
         cOSQDKqiof2ug0daGt8N8mYrQ3Pp2kwvCOvJaOBmMSpSGXEQ7l5gBm4txs33IJ5t5glK
         hoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iN+M0WkfQ0dP6GM6J58Hts7FuA2XqRRlayZs69euiW8=;
        b=gDh2kqHgwWsEdNn18Vo5Zc3y4Na9sfOYc7u6iAr4/Gf93xOM6aHd+5CULd8Kxyypt1
         Bm6oxDubzlteBDtSyFS5ulD15ZJiiPG8+Z7x6soz+rjSnAsIwvgj3aPy3+rmQ9wRdFOr
         bfWXPrgMTLHspvS0fxYgK8mVETc1f60crNwWcGhbG3m9y6G3MBF7AzEOMnpJ0P4XZCSb
         izBOzGUUHw/G2jmWt1EzRiZp1BcXnQZFJrISARQ1tvcfawBusJJOtR1RD6r+inxz9DKy
         YZYbv46uRd6bOxwWV8RLQN8qplaoIT7Xrlls3fSf4w1KO12i2ltbxECBNQgCVTOSTgps
         CL4g==
X-Gm-Message-State: ALKqPwd0cxnCRMZ+ScTBbiOmPkB+TOogZbVnOnpWRvPEPtoUwhwQ6zE+
        gq90zFHmO8VOfM1L12an6wzkfYGpfWc=
X-Google-Smtp-Source: AB8JxZofeso3ga5zDudSaa6RHPxcXxflqQaFkssxBPlHWLsJJyRf63SazSgtRGVgGhIlT46KTGl/1A==
X-Received: by 2002:adf:eb12:: with SMTP id s18-v6mr4490510wrn.174.1526678654830;
        Fri, 18 May 2018 14:24:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id u35-v6sm10969192wrc.29.2018.05.18.14.24.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 May 2018 14:24:13 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/3] merge-recursive: provide pair of `unpack_trees_{start,finish}()`
Date:   Fri, 18 May 2018 23:23:26 +0200
Message-Id: <2fae1279567cedf3f6672ce5e4b59d794641f7d0.1526677881.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.840.g5d83f92caf
In-Reply-To: <cover.1526677881.git.martin.agren@gmail.com>
References: <CAN0heSo80SjjGtC2x9s-TmNY0=W=YWTYxyjeuAQ3utEAEynXeA@mail.gmail.com> <cover.1526677881.git.martin.agren@gmail.com>
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

