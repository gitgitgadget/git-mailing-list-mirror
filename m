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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5789EC433E6
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 21:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D29864FB2
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 21:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhBEVnT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 16:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbhBEO76 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 09:59:58 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10114C061756
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 08:38:12 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id hs11so12949275ejc.1
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 08:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WT8+PdZXgx+ouFFnMyR0znv7pFSnh4A0ykDacXA77Pw=;
        b=bhW19WnaBp0tEGDEdvYR7tlTz0qE99EZWxuOvGSVqGLe4eZCHUAik0MspsgdWAYxuU
         LJwD2VD423KuHE1efV4F5moj5ERgFKl7zFSz3xfVVg94szCXiXY65+DJuV7SFB/Z3KqA
         aH3+E6LjHvbInEV+TS+daJU7WxpycXhGAz1+/w4gcIZmoAwAQMLkBh9RJ0DIMHNxMhft
         ImElv8rXY2V6Qe0oLzhvKJQ0bUJfeYrBq5JVq83FULAx3CW5cKAqx5Ni3Y/bqJK0waze
         THKOPST782+HV0cNuNeXMu3lE/tA15qUV3YB664yeDnzHyoMbebjmqR0ZxiDI/Ya+Ps4
         JDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WT8+PdZXgx+ouFFnMyR0znv7pFSnh4A0ykDacXA77Pw=;
        b=acXML+//7GKc760NDZdUIwQYLFKMQSvefF10LEvF7LGuVeat9OTMlQtNjpaSMJDgFb
         zUrL+fGygWDh0+p3nnFcsXrUctvedqEos60JUZK7Xm8O/vuA81mxaVern6aAP6wTVmM0
         yxha/ow2hm+xYP6iI1nAKmzwJV53eZuJVjv7Hk3OJjmL6MjaK/mPJp2DYpyqsZ5MfKVp
         5rnFKf2hK39LEEC9mKwpVfuROHsAe4mWVloxhr6OlBfc16p+wpLhHU8/Vt3/CxiN78t1
         XYX+oKjqMx3L+E6nJPKCqKnqkf5HOF4AMjzPsia5kVQtjr296A3DWODEnmP5N8Ik2UGK
         Kcdw==
X-Gm-Message-State: AOAM530ktyqVuYTSPKLHEBhL3a5718QgwjvCUc7CTt1ZcKI1WT54IRLx
        fiGYBm5B7In6pI8kasWGWYbUFv2Yx+4=
X-Google-Smtp-Source: ABdhPJze0toOP5WDvxSMb79bFDeQFu/UV8eyMlpDO9Nc4R8yFqBQbt2SAuvgBtDB60lNAE2heVB48w==
X-Received: by 2002:adf:fb49:: with SMTP id c9mr5556074wrs.72.1612536379527;
        Fri, 05 Feb 2021 06:46:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k4sm13357620wrm.53.2021.02.05.06.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:46:19 -0800 (PST)
Message-Id: <a6285292b4f12bf3e57aed115595bc254a63dabf.1612536373.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.869.v2.git.1612536373.gitgitgadget@gmail.com>
References: <pull.869.git.1612469275.gitgitgadget@gmail.com>
        <pull.869.v2.git.1612536373.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Feb 2021 14:46:12 +0000
Subject: [PATCH v2 5/6] range-diff: move the diffopt initialization down one
 layer
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
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
index 25d4c244799c..001b6e174079 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -465,12 +465,35 @@ static void patch_diff(const char *a, const char *b,
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
@@ -491,7 +514,7 @@ static void output(struct string_list *a, struct string_list *b,
 
 		/* Show unmatched LHS commit whose predecessors were shown. */
 		if (i < a->nr && a_util->matching < 0) {
-			output_pair_header(diffopt, patch_no_width,
+			output_pair_header(&opts, patch_no_width,
 					   &buf, &dashes, a_util, NULL);
 			i++;
 			continue;
@@ -499,7 +522,7 @@ static void output(struct string_list *a, struct string_list *b,
 
 		/* Show unmatched RHS commits. */
 		while (j < b->nr && b_util->matching < 0) {
-			output_pair_header(diffopt, patch_no_width,
+			output_pair_header(&opts, patch_no_width,
 					   &buf, &dashes, NULL, b_util);
 			b_util = ++j < b->nr ? b->items[j].util : NULL;
 		}
@@ -507,22 +530,18 @@ static void output(struct string_list *a, struct string_list *b,
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
@@ -539,31 +558,10 @@ int show_range_diff(const char *range1, const char *range2,
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

