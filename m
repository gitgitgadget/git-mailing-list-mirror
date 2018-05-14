Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 615E91F406
	for <e@80x24.org>; Mon, 14 May 2018 21:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752479AbeENV5K (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 17:57:10 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:56717 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752341AbeENV5H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 17:57:07 -0400
Received: by mail-yw0-f202.google.com with SMTP id w205-v6so5755149ywd.23
        for <git@vger.kernel.org>; Mon, 14 May 2018 14:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=3tCE2yiZmv5emjz5+xODrEsYmFN5QtPOIq5C/8MRY/g=;
        b=JADruaUL1n7aDoDGka/8nZkGgm/o1XJk9f/hiVT6Gd0gYlAO5vdFn4LgCwMVX1Tl3v
         ByUP57wHZrFT7rPARoWN/aMz77++np/Ti0sHHeMsNjARfy2LyYu6oIcmFp9G9puKlUgc
         H2oFFiskwHmfAFJgMU809Bl1nPW8HFF7a/GjFMQddEYObKfOGY3LTlpnIB+B9G6o5seJ
         66odL0q8HXFMQjQ/JOBPiLCDrXrreZbyJ8rkTNdrNm8EE0KkKRG8jqQQpZ8fb0RWD2Uj
         NE8dNcon5UNtuzCjLrFFYnEJ/mFjDeUIBc4q42fl/OqDKRb3DCrJ6+VCDdEYwAlj2Rk0
         1DbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=3tCE2yiZmv5emjz5+xODrEsYmFN5QtPOIq5C/8MRY/g=;
        b=OIRxUcQL5Ep1/24l9fbBh835ug0jFU0dMIopB0ep3s5W1rVncQ7WOYWPt1iE9cpQpN
         wMo9hL5VNTahU7ufMydAJ3WsvWlcqiePFUo8DAIMfCJkPWGdWvnC5rPbE7h/Bdn9hOnw
         v0H/QOGoLJzuaJtXmS9bI3I6scbwN7d3S25QqHVaRgILl5M5zMkb5s8m/bp9TZ0RiJi+
         jxFVIuaNEpc1we6OeZG5wmK/fe2BBaHzK39Z4t5FHgMScTyykjyoB8xzeeL17WziY7vo
         N+rktmUnoB53iqLNXhmxLBTdYdt6pgbSF32tk3EEgnFZLQtLR6WZYTOXoFFYP9UWw8Cq
         W5tg==
X-Gm-Message-State: ALKqPwfiWhdeMSQty7Cg3aZN158VED1DUM6VfoPsGwkH2fa0Cy5YyN6a
        DVrwMqBUyMqOAs4t8RRusptndM0iC4bEUiGMlZZl43pm4mT0Vh2/HzU1t6/VUQ+0euyyUJwxhkH
        LxrumeG3zJ4APVZR1igvKcK5PPc6f8M4L+DFuP1KsuIcsWSG/j1yWHiQ8QA==
X-Google-Smtp-Source: AB8JxZpDOXJxL+PiAQpsial+cZg8nZ0naBXe92BPr4oBqTRiFKN9n1ZWfRZv7zoLucvJ2AsRr6s05+2IoCY=
MIME-Version: 1.0
X-Received: by 2002:a81:63c5:: with SMTP id x188-v6mr3392215ywb.91.1526335027229;
 Mon, 14 May 2018 14:57:07 -0700 (PDT)
Date:   Mon, 14 May 2018 14:56:03 -0700
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
Message-Id: <20180514215626.164960-13-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 12/35] fast-export: convert to use struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
X-ccpol: medium
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert fast-export to use 'struct refspec' instead of using a list of
refspec_item's.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fast-export.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 6f105dc79..143999738 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -36,8 +36,7 @@ static int use_done_feature;
 static int no_data;
 static int full_tree;
 static struct string_list extra_refs = STRING_LIST_INIT_NODUP;
-static struct refspec_item *refspecs;
-static int refspecs_nr;
+static struct refspec refspecs = REFSPEC_INIT_FETCH;
 static int anonymize;
 
 static int parse_opt_signed_tag_mode(const struct option *opt,
@@ -830,9 +829,9 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 		if (dwim_ref(e->name, strlen(e->name), &oid, &full_name) != 1)
 			continue;
 
-		if (refspecs) {
+		if (refspecs.nr) {
 			char *private;
-			private = apply_refspecs(refspecs, refspecs_nr, full_name);
+			private = apply_refspecs(refspecs.items, refspecs.nr, full_name);
 			if (private) {
 				free(full_name);
 				full_name = private;
@@ -978,8 +977,8 @@ static void import_marks(char *input_file)
 static void handle_deletes(void)
 {
 	int i;
-	for (i = 0; i < refspecs_nr; i++) {
-		struct refspec_item *refspec = &refspecs[i];
+	for (i = 0; i < refspecs.nr; i++) {
+		struct refspec_item *refspec = &refspecs.items[i];
 		if (*refspec->src)
 			continue;
 
@@ -1040,18 +1039,12 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		usage_with_options (fast_export_usage, options);
 
 	if (refspecs_list.nr) {
-		const char **refspecs_str;
 		int i;
 
-		ALLOC_ARRAY(refspecs_str, refspecs_list.nr);
 		for (i = 0; i < refspecs_list.nr; i++)
-			refspecs_str[i] = refspecs_list.items[i].string;
-
-		refspecs_nr = refspecs_list.nr;
-		refspecs = parse_fetch_refspec(refspecs_nr, refspecs_str);
+			refspec_append(&refspecs, refspecs_list.items[i].string);
 
 		string_list_clear(&refspecs_list, 1);
-		free(refspecs_str);
 	}
 
 	if (use_done_feature)
@@ -1090,7 +1083,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	if (use_done_feature)
 		printf("done\n");
 
-	free_refspec(refspecs_nr, refspecs);
+	refspec_clear(&refspecs);
 
 	return 0;
 }
-- 
2.17.0.441.gb46fe60e1d-goog

