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
	by dcvr.yhbt.net (Postfix) with ESMTP id D6F591F461
	for <e@80x24.org>; Wed, 26 Jun 2019 23:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfFZXvY (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 19:51:24 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:34923 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfFZXvX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 19:51:23 -0400
Received: by mail-pl1-f202.google.com with SMTP id bb9so300579plb.2
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 16:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cKWKp3L3U9lIrobE75FJbHgfNhnw0ZLswX0FAfyEbqc=;
        b=ebXr3DMRZZS3mXDilw7I69JP8O07fgjI29E8EPDtEp6zpWAqmSbrbvHaWE3+sXwYtb
         /BdrI27SQUvgY4KT21Gto4clJOd/mUQ77Y97rBoAKuz/vASSwJfLf+RA1EVMNrOIXmTC
         L/KdkAwTQIupaGG0Da0PjQmswEyEYIFGg1ZO0bEeB56JWx9EvHkBK1Orebw3fl5VvUgk
         1zAfCEMEQd0z4ZGv+bLZ3wb9SH5pFgdIdYW4E6gf4hmHQ9vXSl8nbWftO5+mdhZ4AhFi
         J4/thvJdsMfaCa3Vhui1BuKajthqc2VnEcIok1bCRgR3zuMv42hPmj4boFZN7k7NjYoJ
         zPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cKWKp3L3U9lIrobE75FJbHgfNhnw0ZLswX0FAfyEbqc=;
        b=HtEJX8POLAvoczzbX3opFqPuUsXw9/3jwPFQULaFOZUJq/L3GStlMHF+R8mkkMnVOo
         czgtqhGE/cw2OjBmX5WCir0f9ux0wpSuXltuFhB2D5Jk1H1ega6fVNQJblzDwLs9qAG4
         PBjvfuIUnUd7TflzUuzS3kw5IhzGLZkhoL4+0PgyHYaUDGroIT0aoMmo9nW9F1cqNOn1
         Op0r9HCbhYOXUH0F67cLetZMXcm4IlqBKUv4ffyEODzHjbeTaZjEadbYGd9xZR/3k7ro
         qKogwgfdDEtuMl8NGT3vAWFeYD/IZl4JKbl/KqjRTrGAqFDZUYRB/91Oxr5RzfNjP0PC
         flLg==
X-Gm-Message-State: APjAAAUctyDYKVHvQDBfUKFFfAO8v3vz8Reaoep6OzKsGEYOSWppKjCt
        sLB+tliBZ7FwuDahw8zWqh1WfC1LVQfUIpUt51BdLGf5pO1krvtNQKGrKA3hP1rw/LX9OslAO3i
        5nZbWJZLpp8PZ+ovUQt7ToMZ+NLDUIF3tcZ4svCizPvToDrkH/15enNi6kN65aVmLqGFxB4jMdw
        ==
X-Google-Smtp-Source: APXvYqzHoGRRLvr8fHhp1Q/E30J2E8OtNYpATIv0i148sN7meGD9NvcrS1LcnoAWvzVbHZLqzKmXTJ35xFRXG4GjkUY=
X-Received: by 2002:a65:534b:: with SMTP id w11mr653042pgr.210.1561593082753;
 Wed, 26 Jun 2019 16:51:22 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:50:30 -0700
In-Reply-To: <20190626235032.177551-1-emilyshaffer@google.com>
Message-Id: <20190626235032.177551-12-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190626235032.177551-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH v2 11/13] walken: add filtered object walk
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
 builtin/walken.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/builtin/walken.c b/builtin/walken.c
index 42b23ba1ec..a744d042d8 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -12,6 +12,7 @@
 #include "pretty.h"
 #include "line-log.h"
 #include "list-objects.h"
+#include "list-objects-filter-options.h"
 #include "grep.h"
 
 /*
@@ -143,6 +144,10 @@ static void walken_show_object(struct object *obj, const char *str, void *buf)
  */
 static void walken_object_walk(struct rev_info *rev)
 {
+	struct list_objects_filter_options filter_options = {};
+
+	printf("walken_object_walk beginning...\n");
+
 	rev->tree_objects = 1;
 	rev->blob_objects = 1;
 	rev->tag_objects = 1;
@@ -157,7 +162,24 @@ static void walken_object_walk(struct rev_info *rev)
 	blob_count = 0;
 	tree_count = 0;
 
-	traverse_commit_list(rev, walken_show_commit, walken_show_object, NULL);
+	if (1) {
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

