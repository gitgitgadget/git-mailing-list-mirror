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
	by dcvr.yhbt.net (Postfix) with ESMTP id F081D1F461
	for <e@80x24.org>; Wed, 26 Jun 2019 23:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfFZXvL (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 19:51:11 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:43040 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfFZXvK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 19:51:10 -0400
Received: by mail-pl1-f201.google.com with SMTP id t2so288747plo.10
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 16:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4TaIo5JITih+BTUObpSO0GNEJ6wW9gJ5AjFC0810znE=;
        b=cmqbjkfAc4T3BLMpZ7ESvDhyEvjxuJ1gIcZcS6V0lZLUfKLq/LscIytjWLI7TY1Bcu
         0Wz9VrHYYP3irzqkM/5ib/9vUXqTeerJF2Xx+Zrfn1biMMB+SrjKtYIIwu9mc+iOYwIn
         I5r/FAM390wxqaLShRM+F+mjTPh1Zgf3/UtFPkmgcV7SkYbgaehLVm4b9pSfO34MZTXJ
         TG/af34RFndzQrIwQvSgKZKP12b0ZzttcjgoAHuzEHwqf1rqclpDd5fqGVi/el314Paz
         y4GUKfooJ1gTjLrxUp6ctDI5eGq73tuiegtSWk9+/Pj2fT5TAHX4Wt3FdBDHT3tnapQD
         X36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4TaIo5JITih+BTUObpSO0GNEJ6wW9gJ5AjFC0810znE=;
        b=SYubNDKrmqIJwPBFSUMAw2TGehBVEY8UObEDqyXGFClk0HZq0ka8jWNvY3D4q4lMRH
         OyBUgqvgZtq+HEKUjcSEjtltpenl3OAZ7lWZ1YXwgSQDac/dcDxm3zOhmA2iHNhdI8lm
         FTlN5wAPFgmbHVM/LnZvFtlYpGGBse0kwEpxT6C/poGslClk82nXpgttRboySpPeQFcu
         ETkbZpvnBsKOcNVs80e1IoqFMe7xbkFv6soagirvXNoaKKAhzSo7LDetcG+ueE+F4Uzp
         p3Bzyqp+8j3Jv9FIr1nfwhe+3oeN8DXEGxrWT6gXdxis9RNzCZZgbajSlH0rh5ZAZAOi
         D3FA==
X-Gm-Message-State: APjAAAUMqiNtbFIlk+XKE0lJnD7NO1Fhj/gMPk8pjTMb1GLvzZaZuQLI
        gcNJ3YWiDEtChlZyXT6hxz+ETHC4gvY2Hft/XwkOS9H97Tzd07nfYJiP0Mh19wf0+em1/tFOOXf
        e/U6kV6HtcEBVUX4I07YETYJ1yOJkR4isaKvuJa5LOa/8JX9qHjh/5nwE3nAaR7ReIv2XYmO3vA
        ==
X-Google-Smtp-Source: APXvYqwkZ0Gq2HDC1h6ZJU29BZOqJJNeSN+OsX8ucI15ZJs540TGQQuidDSLNNxFmQu9gfCQ3xx6My17NTIKqaquSAA=
X-Received: by 2002:a65:530c:: with SMTP id m12mr598151pgq.363.1561593069772;
 Wed, 26 Jun 2019 16:51:09 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:50:25 -0700
In-Reply-To: <20190626235032.177551-1-emilyshaffer@google.com>
Message-Id: <20190626235032.177551-7-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190626235032.177551-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH v2 06/13] walken: perform our basic revision walk
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
 builtin/walken.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/builtin/walken.c b/builtin/walken.c
index c463eca843..335dcb6b21 100644
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
  * All builtins are expected to provide a usage to provide a consistent user
@@ -90,6 +93,41 @@ static int git_walken_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
+/*
+ * walken_commit_walk() is invoked by cmd_walken() after initialization. It
+ * does the commit walk only.
+ */
+static void walken_commit_walk(struct rev_info *rev)
+{
+	struct commit *commit;
+	struct strbuf prettybuf = STRBUF_INIT;
+
+	/*
+         * prepare_revision_walk() gets the final steps ready for a revision
+	 * walk. We check the return value for errors.
+         */
+	if (prepare_revision_walk(rev)) {
+		die(_("revision walk setup failed"));
+	}
+
+	/*
+         * Now we can start the real commit walk. get_revision grabs the next
+	 * revision based on the contents of rev.
+	 */
+	rev->diffopt.close_file = 0;
+	while ((commit = get_revision(rev))) {
+		if (!commit)
+			continue;
+		strbuf_reset(&prettybuf);
+		pp_commit_easy(CMIT_FMT_ONELINE, commit, &prettybuf);
+		/*
+		 * We expect this part of the output to be machine-parseable -
+		 * one commit message per line - so we must not localize it.
+		 */
+		puts(prettybuf.buf);
+	}
+}
+
 int cmd_walken(int argc, const char **argv, const char *prefix)
 {
 	struct option options[] = {
@@ -115,12 +153,17 @@ int cmd_walken(int argc, const char **argv, const char *prefix)
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

