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
	by dcvr.yhbt.net (Postfix) with ESMTP id A0DE01F461
	for <e@80x24.org>; Wed, 26 Jun 2019 23:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfFZXvI (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 19:51:08 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:47837 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfFZXvI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 19:51:08 -0400
Received: by mail-qt1-f201.google.com with SMTP id s9so496551qtn.14
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 16:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=e3c+xhemaCfuUw/R0zRC2kKv1su/aN127wWoDjPGEo0=;
        b=lP/owuCImy4lOX0XAdXDZ9T5TX6fUUiKUjDQg3C1VYNgz8I5RoRmhrW2jx9iHZLeMB
         LrG3OljGkFeaXxsl90klOY1QXxAS+Frt0xE0HAWYxlSnh+V4PZh8WADICuu2YtlUox70
         J8bbPZYovOhjowiXeb/PdQC0A9587LzqYsRcZmTyRJBAd9YZ0NZoyVwsycZ18j0QMflv
         D+d2Jv6/dEQGHeqGR3egDiTZI1tvq3unntHbCirV6WIl+0VhglNz6f3VLGf154bH7nXh
         bPymBhB7HysUrXOMdXrrjC1XwFeFQRA7KRjXO/wUGNjBXDaJy0IgItVK9VNOWwzuJ7Xo
         h30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e3c+xhemaCfuUw/R0zRC2kKv1su/aN127wWoDjPGEo0=;
        b=K9Lx6LF+paQumuUKQKJb+4RZo8R295YpN//bFZeO0Wy1MWn5IAiUGR0Rvx/llk+J8x
         pF88mF5yP4IhIQHWD16TFgbnjOYS562aVRXlJ64mxGScn78HW6Hdc1UFm5uf1VJIUJL7
         GBXJ6DEupll5eg7kZ7Ot/Pwb79BEGqzDT+2Y5NWTAO4oPVx8fqmeEDW92+fpvr/o4ui9
         K9Vqfmr7iUs8WRU9I2gx66TqNgycEPnu8Whroil8HC9VSjJ6b7OaadTmG2hFshs/jj41
         kNQteeFMTEIeHN6+kXrpwE80L3/uf6dLiJ9DYffikTJj3h7YgE9ceQalzaAs/g9zAJM7
         f/cQ==
X-Gm-Message-State: APjAAAV2iCR5gu/UFIdfOr/UP2BSXBGf8Devb7JD37bm2tF4Vs3mqG8U
        fFxfUP7U1Hbnp47BRI0Hru9euhrhdOI2bQRCR72Tyuu+vL74MXaXI2xGhzLZevBNEJ8J0LaHwru
        SzLpfoCyBc9eXJLfQ/TPPZCk2mQBpS8xGbcaIC6YRaJvREJIIUi6x6jh+9S5Wf2AntiZ2H7ON6A
        ==
X-Google-Smtp-Source: APXvYqztD7TWrbrsb9MgRCrsariHawcMTGLRXmIy0Xl6+5YYbeKxUume9O7Crdn3PWP5WSi7TAqCRkOK5m/cZNB6R/s=
X-Received: by 2002:a37:a988:: with SMTP id s130mr721096qke.390.1561593067284;
 Wed, 26 Jun 2019 16:51:07 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:50:24 -0700
In-Reply-To: <20190626235032.177551-1-emilyshaffer@google.com>
Message-Id: <20190626235032.177551-6-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190626235032.177551-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH v2 05/13] walken: configure rev_info and prepare for walk
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`struct rev_info` is what's used by the struct itself.
`repo_init_revisions()` initializes the struct; then we need to set it
up for the walk we want to perform, which is done in
`final_rev_info_setup()`.

The most important step here is adding the first object we want to walk
to the pending array. Here, we take the easy road and use
`add_head_to_pending()`; there is also a way to do it with
`setup_revision_opt()` and `setup_revisions()` which we demonstrate but
do not use. If we were to forget this step, the walk would do nothing -
the pending queue would be checked, determined to be empty, and the walk
would terminate immediately.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Change-Id: I76754b740227cf17a449f3f536dbbe37031e6f9a
---
 builtin/walken.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/builtin/walken.c b/builtin/walken.c
index 2474a0d7b2..c463eca843 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -5,6 +5,7 @@
  */
 
 #include "builtin.h"
+#include "revision.h"
 #include "config.h"
 #include "parse-options.h"
 
@@ -30,6 +31,40 @@ static void init_walken_defaults(void)
 	 */
 }
 
+/*
+ * cmd_log calls a second set of init after the repo_init_revisions call. We'll
+ * mirror those settings in post_repo_init_init.
+ */
+static void final_rev_info_setup(int argc, const char **argv, const char *prefix,
+		struct rev_info *rev)
+{
+	/*
+	 * Optional:
+	 * setup_revision_opt is used to pass options to the setup_revisions()
+	 * call. It's got some special items for submodules and other types of
+	 * optimizations, but for now, we'll just point it to HEAD and call it
+	 * good. First we should make sure to reset it. This is useful for more
+	 * complicated stuff but a decent shortcut for the first pass is
+	 * add_head_to_pending().
+	 */
+
+	/*
+	 * struct setup_revision_opt opt;
+
+	 * memset(&opt, 0, sizeof(opt));
+	 * opt.def = "HEAD";
+	 * opt.revarg_opt = REVARG_COMMITTISH;
+	 * setup_revisions(argc, argv, rev, &opt);
+	 */
+
+	/* Let's force oneline format. */
+	get_commit_format("oneline", rev);
+	rev->verbose_header = 1;
+
+	/* add the HEAD to pending so we can start */
+	add_head_to_pending(rev);
+}
+
 /*
  * This method will be called back by git_config(). It is used to gather values
  * from the configuration files available to Git.
@@ -61,6 +96,8 @@ int cmd_walken(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	struct rev_info rev;
+
 	/*
 	 * parse_options() handles showing usage if incorrect options are
 	 * provided, or if '-h' is passed.
@@ -71,6 +108,19 @@ int cmd_walken(int argc, const char **argv, const char *prefix)
 
 	git_config(git_walken_config, NULL);
 
+	/*
+	 * Time to set up the walk. repo_init_revisions sets up rev_info with
+	 * the defaults, but then you need to make some configuration settings
+	 * to make it do what's special about your walk.
+	 */
+	repo_init_revisions(the_repository, &rev, prefix);
+
+	/*
+	 * Before we do the walk, we need to set a starting point by giving it
+	 * something to go in `pending` - that happens in here
+	 */
+	final_rev_info_setup(argc, argv, prefix, &rev);
+
 	/*
 	 * This line is "human-readable" and we are writing a plumbing command,
 	 * so we localize it and use the trace library to print only when
-- 
2.22.0.410.gd8fdbe21b5-goog

