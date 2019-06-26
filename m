Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2B911F461
	for <e@80x24.org>; Wed, 26 Jun 2019 23:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfFZXvW (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 19:51:22 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:49335 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfFZXvV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 19:51:21 -0400
Received: by mail-qk1-f201.google.com with SMTP id c4so353222qkd.16
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 16:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hIrjpvXEVCqGrgTCRs/osqnLry6hQVdAGYSiOqihXwc=;
        b=LkDL2NFgmANqhjRXOHRM5tNxD6RyhrQMayt5Ggz7tv1NW57vfRd92oR1zxCT6ryaTN
         NbqUmkA0Hdby2XvRVIcEIPy7cI6Y54DNDN59cccPca7Frbl3qqMpboiXab5ghnfa6OcG
         qhOaZWp2fKKqlaU2PWLAnk6VO4wXQwNy+t3+/C+ynQXTMijWlrUT5T0rABdxEc5IA5gM
         updmOug9LaqLZtTm3LaY0FVHmvFPzHnCuvb49wHU3QbdMm38g7kib3X3DQf5NjBj/rsb
         1GbtEthbarscUcJ1IuovAVGpRGijS4QywZoZHFXN4AMy1aPfEoTF8LOg0Cka3kLgfDHd
         fYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hIrjpvXEVCqGrgTCRs/osqnLry6hQVdAGYSiOqihXwc=;
        b=eNEYLmqVpc7i+7xvhQAzP2tavALh9aP1OTHiEqsH4DsQyelcB9+y3NUfvq2rv2+srP
         jnXRmoPwyK5WaKGLlKFqRyWLSjkD26esoLJxrg38EioiOZNogmDi0NnW11RwdyOGLHor
         /38kGyFpkJpWuTyRTofJIaoFp9Y0jsSFVxctyzjTKTcTWbSI0Pxj9fNiDqLleJHPquxL
         Z8hQ1xQdzWlyBwONEFkSZBVdPfRxV7oz/gnZ8+GrlnzFjwlfRf65VcS8BSTSwVbh97VS
         2Dshqcl1pv5GUN0fdvXcMeQhESsoJFpy0kS5+35YANIJZkeTbmlrKKJXmhObuvaGfpZF
         7xaQ==
X-Gm-Message-State: APjAAAX3Pjjpf147WAEs2/T5Cj+lBPgdbtTE65XPk0m8qGLdxUlv+J8W
        gc5hu2rwmc0wAXImAThK6KGsKnnjw/gk3Q1kE5sSa8/JaxGNlVcAxkiZPdSvF/H4rgdDwbvbg8c
        pFo07CzM9YSLpM1/xB7RY8s+Oo7rFJnfiFyhQuTrpzFD+2foQFueaRxHO+8+3NUwe9G/xc0WdIA
        ==
X-Google-Smtp-Source: APXvYqxmwev56qfmr+Q/Rb83JpRyLcEcZVrbGP50bx0PIk+M8VZtaFYlCRgfAs0k9Gxrn2A0ye6p7lOLMdEIZAKW2JA=
X-Received: by 2002:a37:a9c9:: with SMTP id s192mr640158qke.335.1561593080335;
 Wed, 26 Jun 2019 16:51:20 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:50:29 -0700
In-Reply-To: <20190626235032.177551-1-emilyshaffer@google.com>
Message-Id: <20190626235032.177551-11-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190626235032.177551-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH v2 10/13] walken: add unfiltered object walk from HEAD
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Provide a demonstration of a revision walk which traverses all types of
object, not just commits. This type of revision walk is used for
operations such as creating packfiles and performing fetches or clones,
so it's useful to teach new developers how it works. For starters, only
demonstrate the unfiltered version, as this will make the tutorial
easier to follow.

This commit is part of a tutorial on revision walking.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Change-Id: If3b11652ba011b28d29b1c3984dac4a3f80a5f53
---
 builtin/walken.c | 88 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 79 insertions(+), 9 deletions(-)

diff --git a/builtin/walken.c b/builtin/walken.c
index 958923c172..42b23ba1ec 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -11,6 +11,7 @@
 #include "parse-options.h"
 #include "pretty.h"
 #include "line-log.h"
+#include "list-objects.h"
 #include "grep.h"
 
 /*
@@ -22,6 +23,11 @@ const char * const walken_usage[] = {
 	NULL,
 };
 
+static int commit_count;
+static int tag_count;
+static int blob_count;
+static int tree_count;
+
 /*
  * Within init_walken_defaults() we can call into other useful defaults to set
  * in the global scope or on the_repository. It's okay to borrow from other
@@ -103,6 +109,65 @@ static int git_walken_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
+static void walken_show_commit(struct commit *cmt, void *buf)
+{
+	commit_count++;
+}
+
+static void walken_show_object(struct object *obj, const char *str, void *buf)
+{
+	switch (obj->type) {
+	case OBJ_TREE:
+		tree_count++;
+		break;
+	case OBJ_BLOB:
+		blob_count++;
+		break;
+	case OBJ_TAG:
+		tag_count++;
+		break;
+	case OBJ_COMMIT:
+		die(_("unexpectedly encountered a commit in "
+		      "walken_show_object\n"));
+		commit_count++;
+		break;
+	default:
+		die(_("unexpected object type %s\n"), type_name(obj->type));
+		break;
+	}
+}
+
+/*
+ * walken_object_walk() is invoked by cmd_walken() after initialization. It does
+ * a walk of all object types.
+ */
+static void walken_object_walk(struct rev_info *rev)
+{
+	rev->tree_objects = 1;
+	rev->blob_objects = 1;
+	rev->tag_objects = 1;
+	rev->tree_blobs_in_commit_order = 1;
+	rev->exclude_promisor_objects = 1;
+
+	if (prepare_revision_walk(rev))
+		die(_("revision walk setup failed"));
+
+	commit_count = 0;
+	tag_count = 0;
+	blob_count = 0;
+	tree_count = 0;
+
+	traverse_commit_list(rev, walken_show_commit, walken_show_object, NULL);
+
+	/*
+	 * This print statement is designed to be script-parseable. Script
+	 * authors will rely on the output not to change, so we will not
+	 * localize this string. It will go to stdout directly.
+	 */
+	printf("commits %d\n blobs %d\n tags %d\n trees %d\n", commit_count,
+	       blob_count, tag_count, tree_count);
+}
+
 /*
  * walken_commit_walk() is invoked by cmd_walken() after initialization. It
  * does the commit walk only.
@@ -113,15 +178,15 @@ static void walken_commit_walk(struct rev_info *rev)
 	struct strbuf prettybuf = STRBUF_INIT;
 
 	/*
-         * prepare_revision_walk() gets the final steps ready for a revision
+	 * prepare_revision_walk() gets the final steps ready for a revision
 	 * walk. We check the return value for errors.
-         */
+	 */
 	if (prepare_revision_walk(rev)) {
 		die(_("revision walk setup failed"));
 	}
 
 	/*
-         * Now we can start the real commit walk. get_revision grabs the next
+	 * Now we can start the real commit walk. get_revision grabs the next
 	 * revision based on the contents of rev.
 	 */
 	rev->diffopt.close_file = 0;
@@ -166,13 +231,18 @@ int cmd_walken(int argc, const char **argv, const char *prefix)
 	/* We can set our traversal flags here. */
 	rev.always_show_header = 1;
 
-	/*
-	 * Before we do the walk, we need to set a starting point by giving it
-	 * something to go in `pending` - that happens in here
-	 */
-	final_rev_info_setup(argc, argv, prefix, &rev);
 
-	walken_commit_walk(&rev);
+	if (1) {
+		add_head_to_pending(&rev);
+		walken_object_walk(&rev);
+	} else {
+		/*
+		 * Before we do the walk, we need to set a starting point by giving it
+		 * something to go in `pending` - that happens in here
+		 */
+		final_rev_info_setup(argc, argv, prefix, &rev);
+		walken_commit_walk(&rev);
+	}
 
 	/*
 	 * This line is "human-readable" and we are writing a plumbing command,
-- 
2.22.0.410.gd8fdbe21b5-goog

