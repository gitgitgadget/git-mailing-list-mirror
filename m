Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BE021F462
	for <e@80x24.org>; Fri,  7 Jun 2019 01:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfFGBJU (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 21:09:20 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:33014 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfFGBJU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 21:09:20 -0400
Received: by mail-ot1-f74.google.com with SMTP id b1so208628otk.0
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 18:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UhDe3AGtW0aj/mfMGFFr8w5xdqAujEsjGoZk3eHf7a0=;
        b=BqzX6hGUQ3LWeoI2pFpYWDfmCHgdZYhg5F19X9TA1jaFbaZ35L36FTWSf54T3fT+LE
         RNvvDvPXiPAFCUGPtESdBFNjqmKPGjBIFhA/wthdLpofthbzzimI2FZoV88pnsbgbeVk
         3USvt424kSAzPBadnza4TeQ/w1aMtLcYa122A6aYGFHQBvEOyAUXoA0lEJ9FeP3brmQR
         7r8ozJMMqjBZyUBZgqC4RZbI0d2tkPo1XaddALLIjEpccbqgYu1PvD+n9DZ1qbAusn6/
         XLjzjm0pQuW2O8Hdshm6xu0eXyphojr3+d5QF9C8Tsich0jvf/kv/EFvCciyC8DJhCKY
         1Weg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UhDe3AGtW0aj/mfMGFFr8w5xdqAujEsjGoZk3eHf7a0=;
        b=kJ6HzsetnAtnQ4l6Pd+Fd1YpkPwN88F7pI7bAkvCuqBHAjSNSglLQUux4UYrCFl/t3
         c7s0J4L+tX7naIIZdEUMX0PT2qKI8ffF0wrJqzvadxtBKwlFDVSHuswwBmQjv0sS58Fb
         aXymNgjs3jIPulrmxHa6jDedzi/aMYh8JLH4guJZChuwGvq3veng8W1gWfycCx558Nzx
         zQrpahYFhTfkz0+qgcd4cCNMteGBRc8Zg63ZHGK3/W6NRAWmiwHCbZT5Ra60R4NIf4gY
         2WZXf9HhE0u/TnoyBtMIWPd0uga0R8AOdFIBfIiN36wamDd+s00PtChcDdHNpdRI3ocK
         NFMw==
X-Gm-Message-State: APjAAAV+Bo3o345Fu0QQTblSDxG2nafEZ3yI9gupvCP/4x29ezUDRLyN
        cajTVvq3ekT8CVjQhvWFzPcw5hu0syEk/IDvu2Iu5YTu1QQSTdBL62Ff3PZojv+3KTySoIOkibT
        HhaeWn1WZBpgnUJWUZRmhPOWim6B3n9AXBXj1wKNE23XUZvUcOpe+NmpBbfoU0aDR/tarw5vt0A
        ==
X-Google-Smtp-Source: APXvYqzAfMsJrD+RZDnPgpyVUeKs5FQxfbHbg4FB3OkrmsNcTv3jATnMhLOcPg8ZUtgIj0V170xqwJkNF79496UGG7M=
X-Received: by 2002:aca:3404:: with SMTP id b4mr2146422oia.11.1559869759607;
 Thu, 06 Jun 2019 18:09:19 -0700 (PDT)
Date:   Thu,  6 Jun 2019 18:08:08 -0700
In-Reply-To: <20190607010811.52944-1-emilyshaffer@google.com>
Message-Id: <20190607010811.52944-11-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190607010708.46654-1-emilyshaffer@google.com> <20190607010811.52944-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [RFC PATCH 10/13] walken: add unfiltered object walk from HEAD
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
---
 builtin/walken.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 2 deletions(-)

diff --git a/builtin/walken.c b/builtin/walken.c
index 86c8d29c48..408af6c841 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -12,6 +12,7 @@
 #include "parse-options.h"
 #include "pretty.h"
 #include "line-log.h"
+#include "list-objects.h"
 #include "grep.h"
 
 static const char * const walken_usage[] = {
@@ -19,6 +20,11 @@ static const char * const walken_usage[] = {
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
@@ -93,6 +99,70 @@ static int git_walken_config(const char *var, const char *value, void *cb)
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
+		printf(_("Unexpectedly encountered a commit in "
+			 "walken_show_object!\n"));
+		commit_count++;
+		break;
+	default:
+		printf(_("Unexpected object type %s!\n"),
+		       type_name(obj->type));
+		break;
+	}
+}
+
+/*
+ * walken_object_walk() is invoked by cmd_walken() after initialization. It does
+ * a walk of all object types.
+ */
+static int walken_object_walk(struct rev_info *rev)
+{
+	struct list_objects_filter_options filter_options = {};
+	struct oidset omitted;
+	oidset_init(&omitted, 0);
+
+	printf("walken_object_walk beginning...\n");
+
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
+	printf(_("Object walk completed. Found %d commits, %d blobs, %d tags, "
+	       "and %d trees.\n"), commit_count, blob_count, tag_count,
+	       tree_count);
+
+	return 0;
+}
+
 /*
  * walken_commit_walk() is invoked by cmd_walken() after initialization. It
  * does the commit walk only.
@@ -151,9 +221,14 @@ int cmd_walken(int argc, const char **argv, const char *prefix)
 
 	/* Before we do the walk, we need to set a starting point. It's not
 	 * coming from opt. */
-	final_rev_info_setup(argc, argv, prefix, &rev);
 
-	walken_commit_walk(&rev);
+	if (1) {
+		add_head_to_pending(&rev);
+		walken_object_walk(&rev);
+	} else {
+		final_rev_info_setup(argc, argv, prefix, &rev);
+		walken_commit_walk(&rev);
+	}
 
 	printf(_("cmd_walken incoming...\n"));
 	return 0;
-- 
2.22.0.rc1.311.g5d7573a151-goog

