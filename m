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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EDE11F462
	for <e@80x24.org>; Fri,  7 Jun 2019 01:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfFGBJK (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 21:09:10 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:40814 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfFGBJK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 21:09:10 -0400
Received: by mail-pl1-f201.google.com with SMTP id 91so325922pla.7
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 18:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HPZL2HajTadRCgsrgYLXQhUvAinm7A/OFGdXxpVbbCA=;
        b=QqIo5wbpCOG9Hnakq74sOhvWmFEataqncBrAJn8Y8BFId7i+IqiByUclG40rzKpYzF
         JlvfSChg/ArzVd//KveZZnO/DNJUcKokdwI4xEyUNGVPL1sqP224bawKxU5zLpxFMvE+
         4LOgmtqRQz/u2Fwa7bEQgMVId4iClhSltYeJr/wsfP0MAvrAUSjK4TuBDCgkMQrIu6Nu
         3TgFfhbS+gNKcEG0Bk7LVNz77F2VyfEOLUZJp1MAuCr9F1jldPwXQX+pLiPJg5wXECkE
         gMfaVXZJI6P4dAnJzJscH7BLJzLv1eRdRCZoD4WU+ew/7ufExjy3gQa34izJHu6gNcwX
         fNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HPZL2HajTadRCgsrgYLXQhUvAinm7A/OFGdXxpVbbCA=;
        b=F5qD8bwLiUnWgnk1iZZodGb9E0NPsFBL9qnLWyaIO26eZL/iEmZ8J6j0Mavj/0vuu0
         5Dok3tSus4JCn2caC1Zr1geA4Ym9wyYynUDrBlpZv284BbmvhGDN3Kna1RJQL+UHVxUE
         Uh2WUez3G5qPNgBpBQpEdRIZiupbZxyXIkTwkHKbLxiXDK1yqD1jVzuH+KJ85BDaFGcT
         lKhom/74F3qSnVD/AA96cd4C27jTFcwsbTTqRDgiQSDUxVnzJIG6Ys+uNvVIlXlmg7Ii
         zHhEY5bC1qo5ssm5xCXvd9MUdB+NMWIRDKYV/T6okEXGjENXu5hTXZil/x/peCAcsI6i
         275w==
X-Gm-Message-State: APjAAAUioI88j+eifQ74zKL+qtFfw2/h3Tr0oHQkQ7Zavz6Zj7xUus2A
        7KQMRcYJ6LZo9ttAoh0fG2WPUhiQRJnamFhEVQHGMe5fJgNRwRGVS765nfJymnkMNNGbSg58kw+
        UhEriCId7nFBNlHIzyz5RgG64+Qvbyz8VIPdVn6hr4bdDvxXTc6n+uUkWt/ZqxiQHkl54T8WoUA
        ==
X-Google-Smtp-Source: APXvYqyEerY/P6atEjClIotsg7s6vvhj3AVRcAi/hz7apXwBErR1aUWzbzIdWB9PAsajzH/AsBVwTTbsW2pAv2tRyBQ=
X-Received: by 2002:a63:e54d:: with SMTP id z13mr581094pgj.132.1559869748929;
 Thu, 06 Jun 2019 18:09:08 -0700 (PDT)
Date:   Thu,  6 Jun 2019 18:08:04 -0700
In-Reply-To: <20190607010811.52944-1-emilyshaffer@google.com>
Message-Id: <20190607010811.52944-7-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190607010708.46654-1-emilyshaffer@google.com> <20190607010811.52944-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [RFC PATCH 06/13] walken: perform our basic revision walk
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the final steps needed and implement the walk loop itself. We add a
method walken_commit_walk() which performs the final setup to revision.c
and then iterates over commits from get_revision().

This basic walk only prints the subject line of each commit in the
history. It is nearly equivalent to `git log --oneline`.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 builtin/walken.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/builtin/walken.c b/builtin/walken.c
index c101db38c7..9cf19a24ab 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -7,8 +7,11 @@
 #include <stdio.h>
 #include "builtin.h"
 #include "revision.h"
+#include "commit.h"
 #include "config.h"
 #include "parse-options.h"
+#include "pretty.h"
+#include "line-log.h"
 
 static const char * const walken_usage[] = {
 	N_("git walken"),
@@ -78,6 +81,39 @@ static int git_walken_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
+/*
+ * walken_commit_walk() is invoked by cmd_walken() after initialization. It
+ * does the commit walk only.
+ */
+static int walken_commit_walk(struct rev_info *rev)
+{
+	struct commit *commit;
+	struct strbuf prettybuf;
+
+	strbuf_init(&prettybuf, 0);
+
+
+	/* prepare_revision_walk() gets the final steps ready for a revision
+	 * walk. We check the return value for errors. */
+	if (prepare_revision_walk(rev)) {
+		die(_("revision walk setup failed"));
+	}
+
+	/* Now we can start the real commit walk. get_revision grabs the next
+	 * revision based on the contents of rev.
+	 */
+	rev->diffopt.close_file = 0;
+	while ((commit = get_revision(rev)) != NULL) {
+		if (commit == NULL)
+			continue;
+		strbuf_reset(&prettybuf);
+		pp_commit_easy(CMIT_FMT_ONELINE, commit, &prettybuf);
+		printf(_("%s\n"), prettybuf.buf);
+
+	}
+	return 0;
+}
+
 int cmd_walken(int argc, const char **argv, const char *prefix)
 {
 	struct option options[] = {
@@ -98,10 +134,15 @@ int cmd_walken(int argc, const char **argv, const char *prefix)
 	 */
 	repo_init_revisions(the_repository, &rev, prefix);
 
+	/* We can set our traversal flags here. */
+	rev.always_show_header = 1;
+
 	/* Before we do the walk, we need to set a starting point. It's not
 	 * coming from opt. */
 	final_rev_info_setup(argc, argv, prefix, &rev);
 
+	walken_commit_walk(&rev);
+
 	printf(_("cmd_walken incoming...\n"));
 	return 0;
 }
-- 
2.22.0.rc1.311.g5d7573a151-goog

