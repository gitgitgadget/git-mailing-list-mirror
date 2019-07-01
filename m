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
	by dcvr.yhbt.net (Postfix) with ESMTP id 87DBE1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 20:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfGAUUu (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 16:20:50 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:36321 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfGAUUu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 16:20:50 -0400
Received: by mail-qt1-f202.google.com with SMTP id q26so14470672qtr.3
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 13:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iggI4uXbtuezPewTv42o/1zrQdC/TfeIzWrcWRx3Pc4=;
        b=mw/EMohk4NZ74lSNX9K2UoXhVI+sgUkwrYElV3g63IYjz56ovEUtDlfHd0gra7GKUG
         VbdLssGuGnX6MxrXXsYRD3n56qH+W++QKNi22RcgLgQjubJ3lBrUMf6ROLWYEhTwZLJN
         1ueormaNWc4Sn0SGsCHj1/9RmekaYE9itwhUrUGqFTs/fEG6ARMVFsiiNIU+1I1MdSH6
         /SJz7DkSh5UUltw+EFjPpEyYdx8tvkQR+ladpaKWkdvNlO8fkbR7Vsqq4nTs5FEubznQ
         4nwH5PgMkI8utavNjpoWzH/CyuUWvFHlpr99hpHIEyz5M/gSXMMrP5xutglb4+DYufxM
         mG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iggI4uXbtuezPewTv42o/1zrQdC/TfeIzWrcWRx3Pc4=;
        b=NEPTOIC6VoalHrlOOCC6HiRPbzA0l5jZEkN5oPpsejQYB/RVIv3uzMM14DlVIuMhhk
         Dcy0Ueb0yE9n8oRBp30/ZO4MkoJYfHzg31yurT9asl/Paigj8bp52B+TDpLNmDc0DPVj
         //Zp14LH/+BnCEbzqvflVkSlFu4hOUwcuRw11Q98uVLwO+5DHMXYAgQWoTD65eL8zu89
         b90j+Aiz+disHlEwn20tLCuEgUf0fqxIOTTHvwtoX6w7IPDlVNk2cPjFnJDeWY914Gad
         S6lv3cOSJBaYcU7fkRYEhWZw+5VsyPLcrUr3r6Mt3xPzBC1nMI14wW3OVuSbqddZy8kH
         zrlw==
X-Gm-Message-State: APjAAAUSMvhGSChHz1JFN1mgYjbuD89/+EcoaB4t+1D1URb3aO/QuLlp
        /3n9ABqBQ7ox5IuM/rsE+d46EynOgHB7aXKcyOFTpwXeoEL3R/6JuaighgeUbPtUdkVoYWiDL3r
        skEGXhmaI/olORl5e49wi81+Hac35/xXZ3pO7m3TLSCdfVxEi9tF+LWWUf1lS9NaBB44/8IsIKA
        ==
X-Google-Smtp-Source: APXvYqyUkBHkyipN8mpZSkwZ488l+lNwnylYK6m8HPtsqwyTuLPiu/nFUKyf7HFPnOoSURx5SXWVZkI+G07Hm8mXQ7I=
X-Received: by 2002:ac8:2f96:: with SMTP id l22mr22284659qta.188.1562012449401;
 Mon, 01 Jul 2019 13:20:49 -0700 (PDT)
Date:   Mon,  1 Jul 2019 13:20:12 -0700
In-Reply-To: <20190701202014.34480-1-emilyshaffer@google.com>
Message-Id: <20190701202014.34480-12-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190701201934.30321-1-emilyshaffer@google.com> <20190701202014.34480-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH v3 11/13] walken: add filtered object walk
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Demonstrate how filter specs can be used when performing a revision walk
of all object types. In this case, tree depth is used. Contributors who
are following the revision walking tutorial will be encouraged to run
the revision walk with and without the filter in order to compare the
number of objects seen in each case.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Change-Id: I6d22ba153c1afbc780c261c47f1fa03ea478b5ed
---
 builtin/walken.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/builtin/walken.c b/builtin/walken.c
index b613102cfb..7b46377a2e 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -12,6 +12,7 @@
 #include "pretty.h"
 #include "line-log.h"
 #include "list-objects.h"
+#include "list-objects-filter-options.h"
 #include "grep.h"
 
 
@@ -144,6 +145,8 @@ static void walken_show_object(struct object *obj, const char *str, void *buf)
  */
 static void walken_object_walk(struct rev_info *rev)
 {
+	struct list_objects_filter_options filter_options = {};
+
 	rev->tree_objects = 1;
 	rev->blob_objects = 1;
 	rev->tag_objects = 1;
@@ -158,7 +161,24 @@ static void walken_object_walk(struct rev_info *rev)
 	blob_count = 0;
 	tree_count = 0;
 
-	traverse_commit_list(rev, walken_show_commit, walken_show_object, NULL);
+	if (0) {
+		/* Unfiltered: */
+		trace_printf(_("Unfiltered object walk.\n"));
+		traverse_commit_list(rev, walken_show_commit,
+				walken_show_object, NULL);
+	} else {
+		trace_printf(_("Filtered object walk with filterspec "
+				"'tree:1'.\n"));
+		/*
+		 * We can parse a tree depth of 1 to demonstrate the kind of
+		 * filtering that could occur during various operations (see
+		 * `git help rev-list` and read the entry on `--filter`).
+		 */
+		parse_list_objects_filter(&filter_options, "tree:1");
+
+		traverse_commit_list_filtered(&filter_options, rev,
+			walken_show_commit, walken_show_object, NULL, NULL);
+	}
 
 	/*
 	 * This print statement is designed to be script-parseable. Script
-- 
2.22.0.410.gd8fdbe21b5-goog

