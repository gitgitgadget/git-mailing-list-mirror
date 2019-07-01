Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC91C1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 20:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfGAUUj (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 16:20:39 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:52016 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfGAUUi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 16:20:38 -0400
Received: by mail-qt1-f201.google.com with SMTP id x1so14360720qtj.18
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 13:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3jiY5HwMMNkeEqYlQkZcQlwTdu0r39u5zLFFfkdRJJI=;
        b=m1DQnq7T6E12E65kUFJct7aCy8z1qlCCBfIdhVX4ImgjzOXQYy1Ps0z+if+wqX3cMc
         3UinyJL6OGStRJrOunASyh3CVXw18shp7QuDFH1CqkXzib5JXVq4+XE/SQwd6jJ0PWjE
         1QLWcqRHZI/dw0GGSmCjNcMlDM+NdoMk6JnMHrBMlKFzvz41ZADnXQ/rlGAbirWskA88
         X8ArmZg9zJhjhRe0Kx3Pw/jmARmPcXWYEt0G++qe1odIu3PxmKWLB1yOm1MqcgpjajbE
         dhADGIGcrWBhoImYHTdtVAceG7mhMfUcsO1/bvSJvTU+cdEJoROQKq3Ds7kBXB31AuB6
         SgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3jiY5HwMMNkeEqYlQkZcQlwTdu0r39u5zLFFfkdRJJI=;
        b=DSh43GVy0FBatyZqRqsvoQKQai9Ph6jz+F2N1ptBnZM3pfICZB5gH0t9iXjQ2RtdUu
         YJ9uOWZ0IepM8DtqjvLvuhYopwWG7cOzfGox8KTlJgsKMKBqvEXbaoHJjTA5gvHrTHjz
         lBGOBcWTyCr2Tkh98UV9ULiDa+fNqITF+GGuL5pA2AkIBDetucyKXqArw2KV5COOBz8V
         APZkecKs/c1GelugXSU2wG2LS40EtPWRmOge7X4WthsFl79rFPa/sARZuY/BJCaCM9JR
         1+6JvVuRbz0aA2SJsq2VdW0OCybBf6S1/Ivz07WT/hERwy+ATuNKAWZFNRUv/t7y6Da7
         6hXA==
X-Gm-Message-State: APjAAAXj9RfP2RM6ExdDWor4/vuolYQGazWrkaEz2xioA9FozTGMgZ6K
        NX0OWNWPs4oZ+y6xvfCYjc2viqCDn2usO+Bu1Iod320BfScR1IhHRN3UjsrzyAZgQs0hHtlD4m0
        1c1VE3Xam2kOC65t8nxa60UU7wOdops85DE1mzDb/09MeSxjSwiPk5U0lvmAT7C8H5hiwGi8S9Q
        ==
X-Google-Smtp-Source: APXvYqzgTlQMHn5wqtIHVT030a7UoFRj2NopnBziD/80ajMfX/E1CmHdFz5URdna3kRcUongTrXZBLUb3iE8HLCsMok=
X-Received: by 2002:a37:9f12:: with SMTP id i18mr21906876qke.111.1562012437193;
 Mon, 01 Jul 2019 13:20:37 -0700 (PDT)
Date:   Mon,  1 Jul 2019 13:20:07 -0700
In-Reply-To: <20190701202014.34480-1-emilyshaffer@google.com>
Message-Id: <20190701202014.34480-7-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190701201934.30321-1-emilyshaffer@google.com> <20190701202014.34480-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH v3 06/13] walken: perform our basic revision walk
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
Change-Id: If6dc5f3c9d14df077b99e42806cf790c96191582
---
 builtin/walken.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/builtin/walken.c b/builtin/walken.c
index 333d9ecc5e..f116bb6fca 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -6,8 +6,11 @@
 
 #include "builtin.h"
 #include "revision.h"
+#include "commit.h"
 #include "config.h"
 #include "parse-options.h"
+#include "pretty.h"
+#include "line-log.h"
 
 
 /*
@@ -82,6 +85,40 @@ static int git_walken_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
+/*
+ * walken_commit_walk() is invoked by cmd_walken() after initialization. It
+ * performs the actual commit walk.
+ */
+static void walken_commit_walk(struct rev_info *rev)
+{
+	struct commit *commit;
+	struct strbuf prettybuf = STRBUF_INIT;
+
+	/*
+	 * prepare_revision_walk() gets the final steps ready for a revision
+	 * walk. We check the return value for errors.
+	 */
+	if (prepare_revision_walk(rev)) {
+		die(_("revision walk setup failed"));
+	}
+
+	/*
+	 * Now we can start the real commit walk. get_revision() grabs the next
+	 * revision based on the contents of rev.
+	 */
+	while ((commit = get_revision(rev))) {
+		strbuf_reset(&prettybuf);
+		pp_commit_easy(CMIT_FMT_ONELINE, commit, &prettybuf);
+		/*
+		 * We expect this part of the output to be machine-parseable -
+		 * one commit message per line - so we send it to stdout.
+		 */
+		puts(prettybuf.buf);
+	}
+
+	strbuf_release(&prettybuf);
+}
+
 int cmd_walken(int argc, const char **argv, const char *prefix)
 {
 	/*
@@ -116,12 +153,17 @@ int cmd_walken(int argc, const char **argv, const char *prefix)
 	 */
 	repo_init_revisions(the_repository, &rev, prefix);
 
+	/* We can set our traversal flags here. */
+	rev.always_show_header = 1;
+
 	/*
 	 * Before we do the walk, we need to set a starting point by giving it
 	 * something to go in `pending` - that happens in here
 	 */
 	final_rev_info_setup(argc, argv, prefix, &rev);
 
+	walken_commit_walk(&rev);
+
 	/*
 	 * This line is "human-readable" and we are writing a plumbing command,
 	 * so we localize it and use the trace library to print only when
-- 
2.22.0.410.gd8fdbe21b5-goog

