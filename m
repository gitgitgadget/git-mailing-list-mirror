Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A20CE1F461
	for <e@80x24.org>; Thu, 18 Jul 2019 22:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391683AbfGRW5q (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 18:57:46 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:49205 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbfGRW5q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 18:57:46 -0400
Received: by mail-pl1-f202.google.com with SMTP id 65so14704303plf.16
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 15:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DIajGHrNK3Npd7GQVfTeYgeCH1+xoCJxtXGvMriPIBM=;
        b=cRrDF24FMWEUpe5N9jneB/YGjXjDWW3P+7OpWVrkFt6thgdQBF76mAidjlC+crCLEw
         4UzjmAT57W9IrQxCG1Vba7ktsCpSaPOTTilQ9RRIxFEO7dND90KgOohVt4v4BRIpibg8
         TuIHheYloKB1BYNCx+q5eQi/QJl4ZTDTz5W69XEldNOGcncVnR8WzeMQX0fLKpCxxeqo
         jL6Jmfx33yVJzbPO6jZc7NatPRrI8y/HFQdX02d85Apx6J3WjV/8pjZck77uU6QqCWNf
         SKnOXJHtIE7/d4ZKSHG+470MKxRCYN9vD+9T5/p4qcQEshx+a7GD+Z7VRmZk1vUpvB5C
         55WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DIajGHrNK3Npd7GQVfTeYgeCH1+xoCJxtXGvMriPIBM=;
        b=IiWRweE0N5sjGmBep298C89NK7zmjDE4ruBmA1fdh9VjyRexNxvPv8+80h7MLHjh6x
         00HJrOd+RbaJor7MjiB1UFfmXuk6c1tdlYDy8gA5uGk6jHKMytSWU3cPeh0D41Nnum3i
         te3OeQHB/g+ipKeuvfQcEEZogmaosqz7Rndqv8zwg+T7sX8e3/ahPdR6n5bhhhooKEyD
         Fw7BKpt+OzwpRccuBntNKb/GZjHO67JZ2MWs76ml0BOfS0eFwh/GJ91SdqPZ4bqeraaI
         fh+G7SUz8iCmpNZSxxvLr8epKgm6JkEdMF0uMa2z3wwrSSujptAGEN232uKv+N6s++9R
         ijjg==
X-Gm-Message-State: APjAAAXsUU5u8cVlXKoQWSv7sge720kVafj4qTRAeUx6Dp8Aq222WJjc
        xKOKaDW1wZ01VXd9VsEMsZ8Rh+2hR0/hQ/onDqOjuwmC7y8X1/Yhrjjr7PbwGZ8lqTSOQRpjx9j
        8N3T2lbgttqQFZ9jMjDnCA2DayupBzLoIMx+UVrhg3BY77sLBxbhEwLPeJWp9uHE=
X-Google-Smtp-Source: APXvYqweFIGnGFJ4KAV9hNshZ2a2H1diYZs53rX0ILRv6ix52rtV3eYLPu1HAoj6dJxw1DY0t0jBm/8jCQND+A==
X-Received: by 2002:a63:9a41:: with SMTP id e1mr51161811pgo.210.1563490665443;
 Thu, 18 Jul 2019 15:57:45 -0700 (PDT)
Date:   Thu, 18 Jul 2019 15:57:37 -0700
In-Reply-To: <cover.1563490164.git.steadmon@google.com>
Message-Id: <e8b3fd8a5bf8f77795454a901fecaa585701eeb2.1563490164.git.steadmon@google.com>
Mime-Version: 1.0
References: <xmqqbml6pgfm.fsf@gitster.mtv.corp.google.com> <cover.1563490164.git.steadmon@google.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH v2 1/4] git-merge: Honor pre-merge hook
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@grubix.eu, stefanbeller@gmail.com,
        martin.agren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Michael J Gruber <git@grubix.eu>

git-merge does not honor the pre-commit hook when doing automatic merge
commits, and for compatibility reasons this is going to stay.

Introduce a pre-merge hook which is called for an automatic merge commit
just like pre-commit is called for a non-automatic merge commit (or any
other commit).

[js: addressed review comments:
     * clarified that hook should write messages to stderr
     * only discard the index if the hook is actually present
]

Signed-off-by: Michael J Gruber <git@grubix.eu>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/githooks.txt        |  7 +++++++
 builtin/merge.c                   | 12 ++++++++++++
 templates/hooks--pre-merge.sample | 13 +++++++++++++
 3 files changed, 32 insertions(+)
 create mode 100755 templates/hooks--pre-merge.sample

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 786e778ab8..dcc6606d44 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -103,6 +103,13 @@ The default 'pre-commit' hook, when enabled--and with the
 `hooks.allownonascii` config option unset or set to false--prevents
 the use of non-ASCII filenames.
 
+pre-merge
+~~~~~~~~~
+
+This hook is invoked by 'git merge' when doing an automatic merge
+commit; it is equivalent to 'pre-commit' for a non-automatic commit
+for a merge.
+
 prepare-commit-msg
 ~~~~~~~~~~~~~~~~~~
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 6e99aead46..5cd7752191 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -816,6 +816,18 @@ static void write_merge_heads(struct commit_list *);
 static void prepare_to_commit(struct commit_list *remoteheads)
 {
 	struct strbuf msg = STRBUF_INIT;
+	const char *index_file = get_index_file();
+
+	if (run_commit_hook(0 < option_edit, index_file, "pre-merge", NULL))
+		abort_commit(remoteheads, NULL);
+	/*
+	 * Re-read the index as pre-merge hook could have updated it,
+	 * and write it out as a tree.  We must do this before we invoke
+	 * the editor and after we invoke run_status above.
+	 */
+	if (find_hook("pre-merge"))
+		discard_cache();
+	read_cache_from(index_file);
 	strbuf_addbuf(&msg, &merge_msg);
 	if (squash)
 		BUG("the control must not reach here under --squash");
diff --git a/templates/hooks--pre-merge.sample b/templates/hooks--pre-merge.sample
new file mode 100755
index 0000000000..f459b3db44
--- /dev/null
+++ b/templates/hooks--pre-merge.sample
@@ -0,0 +1,13 @@
+#!/bin/sh
+#
+# An example hook script to verify what is about to be committed.
+# Called by "git merge" with no arguments.  The hook should
+# exit with non-zero status after issuing an appropriate message to
+# stderr if it wants to stop the merge commit.
+#
+# To enable this hook, rename this file to "pre-merge".
+
+. git-sh-setup
+test -x "$GIT_DIR/hooks/pre-commit" &&
+        exec "$GIT_DIR/hooks/pre-commit"
+:
-- 
2.22.0.657.g960e92d24f-goog

