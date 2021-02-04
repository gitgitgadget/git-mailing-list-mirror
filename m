Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C674C433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 20:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50B7A64E0A
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 20:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239425AbhBDUXS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 15:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240073AbhBDUWu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 15:22:50 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15477C061793
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 12:08:02 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id j11so4200031wmi.3
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 12:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rIxCTtB9/Md2rqt/hbOd/IIVWbiw5yX9sz1mfi7cMYs=;
        b=An+e8smDgvUBXd9F/Ya+5pm5Sz91KwC5qasynsgDuSLoV16v8LNzCp4Xz+vKcIXHQw
         3xDYcbX1aV1XUk+UV9lg8wGnQQJ4b6MzTe1hYgfAzVDtTfXo6to31c7Hhz+yALPrtMnH
         0GeLAYFjdJOsbwo+Dv6QHuoV/i6uFsQIv8+hEZyxdKZedSW19sW5N5IkmTJgTZuOjWU9
         gHIdhwpKP6RWTU07bczUzz/8EKmdsKPw12XtHgTzIYzvMUV8IdRyn2GT4zaiGYztfDzV
         qAhBg0XsHjHdcRIw3oBDF68w1uPoL2D5pzCUjwlZTHLM3ja2pLJVA22JW736bsiiFg7B
         7zuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rIxCTtB9/Md2rqt/hbOd/IIVWbiw5yX9sz1mfi7cMYs=;
        b=im4I5XQ3V7Tb956g+m6w1MK9MPzyqQ3xI3AiQhtxqFMkRj2+X1jd49IrRThcju8uC+
         A3JxSaQ/a7yBPzv6sZLo/4Vit5YJb6idyz31VoIBNsjhxzTUArTTQ/vI+ZvTurhwY54p
         nDZRrecyYHFNwulspJ6BokRHlGtOXU52jfDUN5d+Oz1QPJ6KK/uMxowk0Dx1v62Qyy5Q
         y+9xogwjNRqs32jKXeuFGHeM9IflOfg6Q8V9SvacqGEtZ8JPXQeUQ/VcyvpZFnurMkMD
         ah5W6WBOefhMlmsFWd99R3jhldI+6oUwuyXfLa2tNTkSZJM2AIdO8xcG6YrrqomUq6fl
         IEeg==
X-Gm-Message-State: AOAM530DLZl7+YD9My0eZuDyAgzOM8B0KDNDRKFelT5FruLNyNmuX3AB
        r+iPjlP5QK0KDpgbZ3oH/Lld9npwj6s=
X-Google-Smtp-Source: ABdhPJwH5slN+o4wW/I82yp8LHokfEJv8co3Kv0xtDRA3iRLpOYakvtkgprJ7AUf0h4bqXGttx8Oww==
X-Received: by 2002:a7b:c355:: with SMTP id l21mr730246wmj.61.1612469280524;
        Thu, 04 Feb 2021 12:08:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm10326113wrw.76.2021.02.04.12.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 12:08:00 -0800 (PST)
Message-Id: <9fa945db5f135d3b829aef70da490184f898e276.1612469275.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.869.git.1612469275.gitgitgadget@gmail.com>
References: <pull.869.git.1612469275.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Feb 2021 20:07:53 +0000
Subject: [PATCH 5/6] range-diff: move the diffopt initialization down one
 layer
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It is actually only the `output()` function that uses those diffopts. By
moving the diffopt initialization down into that function, it is
encapsulated better.

Incidentally, it will also make it easier to implement the `--left-only`
and `--right-only` options in `git range-diff` because the `output()`
function is now receiving all range-diff options as a parameter, not
just the diffopts.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 range-diff.c | 64 +++++++++++++++++++++++++---------------------------
 1 file changed, 31 insertions(+), 33 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 58528c43a3e8..5455cbb9521b 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -464,12 +464,35 @@ static void patch_diff(const char *a, const char *b,
 	diff_flush(diffopt);
 }
 
+static struct strbuf *output_prefix_cb(struct diff_options *opt, void *data)
+{
+	return data;
+}
+
 static void output(struct string_list *a, struct string_list *b,
-		   struct diff_options *diffopt)
+		   struct range_diff_options *range_diff_opts)
 {
 	struct strbuf buf = STRBUF_INIT, dashes = STRBUF_INIT;
 	int patch_no_width = decimal_width(1 + (a->nr > b->nr ? a->nr : b->nr));
 	int i = 0, j = 0;
+	struct diff_options opts;
+	struct strbuf indent = STRBUF_INIT;
+
+	if (range_diff_opts->diffopt)
+		memcpy(&opts, range_diff_opts->diffopt, sizeof(opts));
+	else
+		diff_setup(&opts);
+
+	if (!opts.output_format)
+		opts.output_format = DIFF_FORMAT_PATCH;
+	opts.flags.suppress_diff_headers = 1;
+	opts.flags.dual_color_diffed_diffs =
+		range_diff_opts->dual_color;
+	opts.flags.suppress_hunk_header_line_count = 1;
+	opts.output_prefix = output_prefix_cb;
+	strbuf_addstr(&indent, "    ");
+	opts.output_prefix_data = &indent;
+	diff_setup_done(&opts);
 
 	/*
 	 * We assume the user is really more interested in the second argument
@@ -490,7 +513,7 @@ static void output(struct string_list *a, struct string_list *b,
 
 		/* Show unmatched LHS commit whose predecessors were shown. */
 		if (i < a->nr && a_util->matching < 0) {
-			output_pair_header(diffopt, patch_no_width,
+			output_pair_header(&opts, patch_no_width,
 					   &buf, &dashes, a_util, NULL);
 			i++;
 			continue;
@@ -498,7 +521,7 @@ static void output(struct string_list *a, struct string_list *b,
 
 		/* Show unmatched RHS commits. */
 		while (j < b->nr && b_util->matching < 0) {
-			output_pair_header(diffopt, patch_no_width,
+			output_pair_header(&opts, patch_no_width,
 					   &buf, &dashes, NULL, b_util);
 			b_util = ++j < b->nr ? b->items[j].util : NULL;
 		}
@@ -506,22 +529,18 @@ static void output(struct string_list *a, struct string_list *b,
 		/* Show matching LHS/RHS pair. */
 		if (j < b->nr) {
 			a_util = a->items[b_util->matching].util;
-			output_pair_header(diffopt, patch_no_width,
+			output_pair_header(&opts, patch_no_width,
 					   &buf, &dashes, a_util, b_util);
-			if (!(diffopt->output_format & DIFF_FORMAT_NO_OUTPUT))
+			if (!(opts.output_format & DIFF_FORMAT_NO_OUTPUT))
 				patch_diff(a->items[b_util->matching].string,
-					   b->items[j].string, diffopt);
+					   b->items[j].string, &opts);
 			a_util->shown = 1;
 			j++;
 		}
 	}
 	strbuf_release(&buf);
 	strbuf_release(&dashes);
-}
-
-static struct strbuf *output_prefix_cb(struct diff_options *opt, void *data)
-{
-	return data;
+	strbuf_release(&indent);
 }
 
 int show_range_diff(const char *range1, const char *range2,
@@ -538,31 +557,10 @@ int show_range_diff(const char *range1, const char *range2,
 		res = error(_("could not parse log for '%s'"), range2);
 
 	if (!res) {
-		struct diff_options opts;
-		struct strbuf indent = STRBUF_INIT;
-
-		if (range_diff_opts->diffopt)
-			memcpy(&opts, range_diff_opts->diffopt, sizeof(opts));
-		else
-			diff_setup(&opts);
-
-		if (!opts.output_format)
-			opts.output_format = DIFF_FORMAT_PATCH;
-		opts.flags.suppress_diff_headers = 1;
-		opts.flags.dual_color_diffed_diffs =
-			range_diff_opts->dual_color;
-		opts.flags.suppress_hunk_header_line_count = 1;
-		opts.output_prefix = output_prefix_cb;
-		strbuf_addstr(&indent, "    ");
-		opts.output_prefix_data = &indent;
-		diff_setup_done(&opts);
-
 		find_exact_matches(&branch1, &branch2);
 		get_correspondences(&branch1, &branch2,
 				    range_diff_opts->creation_factor);
-		output(&branch1, &branch2, &opts);
-
-		strbuf_release(&indent);
+		output(&branch1, &branch2, range_diff_opts);
 	}
 
 	string_list_clear(&branch1, 1);
-- 
gitgitgadget

