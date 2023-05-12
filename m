Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868E8C77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 08:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240205AbjELIDx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 04:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240164AbjELIDs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 04:03:48 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5F62133
        for <git@vger.kernel.org>; Fri, 12 May 2023 01:03:45 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1929818d7faso56105684fac.0
        for <git@vger.kernel.org>; Fri, 12 May 2023 01:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683878624; x=1686470624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9MVM5hMWjav3OgczHiblWNEY2ACazmMHVpb/tauHi0=;
        b=fSX11ajR8kGjAyVyQRoDbs4fZo0/Yo6XMvy0zjjKFyDuIN9lLkwfwQ1ISoZecvTXEv
         cdiFpDzhZrAZPHYCHwt9HO+KEqZk2AEAWn/XCq7XE9ORQTM8drkpJi7UFKFODN8HW+aH
         WimQCwuqnz6gnIFcI3lQ4J4A5y4SUaenIM+ZMJRxu2YjPwOyzawgseVY5rmqODtgpZe5
         kwBfojq14j1A5rgDeK8eDulOFyDr0W1exlfg5fs10MRbgzJdD/YySHKFsFGkJ/7qRqR5
         zUTgCmXBbpzI0hQz0wG0ObUWYJdDUzCetPuzC8KYexWPqfWl7Q3g4s5FxdKUuZwF9Wvd
         VWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683878624; x=1686470624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9MVM5hMWjav3OgczHiblWNEY2ACazmMHVpb/tauHi0=;
        b=FI6Ip0Wce1LVZwW7bXsrU0s/ZniPoGA5YTV/ttbUrGh6IsXulc8OYIa9FNxtZeU9Vh
         krbpP0pczxfGWEOavAYgpdRQoUohu2xmZcJXpcEnxUQ2U2HujnP057mvLHBusJuUqRvZ
         SlCCOIH8jo1MltrDpIRJvpNvM/xIB6jIxbrpKtGSj7AgSAILpsx0GbMhzBa8ffzcFxi1
         ti1qgUI+nnnioJH3R24HwZt5goUErjfdlCDGNe+pgTJizDImpXm9TFf1wxmcBhOgrz6r
         5VloEvKxFirRpZy10cQTb7SUEmwuBwbydVKW9UVooh1sj7GjrDIGs7bL7Mmsu9FgFo9l
         6sZg==
X-Gm-Message-State: AC+VfDz/K4kz9OQGKoy9AobZIJ5sZqh3HcCqjYOV2JUYee8uCK4QzX9T
        noCiNfpeKaKlkdoxu99REpXJrbPXP2E=
X-Google-Smtp-Source: ACHHUZ4oY4H2Pzqk8PCZ5fs0cD8WOFqRfsxsP7SL81Lh4NKpeFPkappzYI/+6DJDHMW787sOZBXubA==
X-Received: by 2002:a05:6830:135a:b0:6ac:9b94:10a8 with SMTP id r26-20020a056830135a00b006ac9b9410a8mr53654otq.16.1683878624208;
        Fri, 12 May 2023 01:03:44 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id i7-20020a9d6247000000b006aaff32ac36sm5393978otk.66.2023.05.12.01.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 01:03:43 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 3/7] diff: make DIFF_FORMAT_NO_OUTPUT 0
Date:   Fri, 12 May 2023 02:03:35 -0600
Message-Id: <20230512080339.2186324-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230512080339.2186324-1-felipe.contreras@gmail.com>
References: <20230512080339.2186324-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`-s` is considered a format, but if we change the meaning to absence of
a format it now becomes possible to distinguish `git diff` from
`git diff --no-patch`, although that isn't done in this commit.

This also fixes a bug in which specifying an output format did not clear
the NO_OUTPUT flag.

For example this now works correctly:

  git show -s --raw

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 diff.c       | 13 ++++++-------
 diff.h       |  6 +-----
 range-diff.c |  2 +-
 revision.c   |  4 ++--
 4 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/diff.c b/diff.c
index 387944f289..4f4b1d7e13 100644
--- a/diff.c
+++ b/diff.c
@@ -4750,8 +4750,7 @@ void diff_setup_done(struct diff_options *options)
 {
 	unsigned check_mask = DIFF_FORMAT_NAME |
 			      DIFF_FORMAT_NAME_STATUS |
-			      DIFF_FORMAT_CHECKDIFF |
-			      DIFF_FORMAT_NO_OUTPUT;
+			      DIFF_FORMAT_CHECKDIFF;
 	/*
 	 * This must be signed because we're comparing against a potentially
 	 * negative value.
@@ -4762,8 +4761,8 @@ void diff_setup_done(struct diff_options *options)
 		options->set_default(options);
 
 	if (HAS_MULTI_BITS(options->output_format & check_mask))
-		die(_("options '%s', '%s', '%s', and '%s' cannot be used together"),
-			"--name-only", "--name-status", "--check", "-s");
+		die(_("options '%s', '%s', and '%s' cannot be used together"),
+			"--name-only", "--name-status", "--check");
 
 	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK))
 		die(_("options '%s', '%s', and '%s' cannot be used together"),
@@ -5494,9 +5493,9 @@ struct option *add_diff_options(const struct option *opts,
 		OPT_BITOP('p', "patch", &options->output_format,
 			  N_("generate patch"),
 			  DIFF_FORMAT_PATCH, DIFF_FORMAT_DEFAULT | DIFF_FORMAT_NO_OUTPUT),
-		OPT_BITOP('s', "no-patch", &options->output_format,
+		OPT_SET_INT_F('s', "no-patch", &options->output_format,
 			  N_("suppress diff output"),
-			  DIFF_FORMAT_NO_OUTPUT, DIFF_FORMAT_DEFAULT | DIFF_FORMAT_PATCH),
+			  DIFF_FORMAT_NO_OUTPUT, PARSE_OPT_NONEG),
 		OPT_BITOP('u', NULL, &options->output_format,
 			  N_("generate patch"),
 			  DIFF_FORMAT_PATCH, DIFF_FORMAT_DEFAULT | DIFF_FORMAT_NO_OUTPUT),
@@ -6646,7 +6645,7 @@ void diff_flush(struct diff_options *options)
 		separator++;
 	}
 
-	if (output_format & DIFF_FORMAT_NO_OUTPUT &&
+	if (output_format == DIFF_FORMAT_NO_OUTPUT &&
 	    options->flags.exit_with_status &&
 	    options->flags.diff_from_contents) {
 		/*
diff --git a/diff.h b/diff.h
index 15a7bf2c9f..44da1a4ca7 100644
--- a/diff.h
+++ b/diff.h
@@ -94,6 +94,7 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 
 typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data);
 
+#define DIFF_FORMAT_NO_OUTPUT	0x0000
 #define DIFF_FORMAT_RAW		0x0001
 #define DIFF_FORMAT_DIFFSTAT	0x0002
 #define DIFF_FORMAT_NUMSTAT	0x0004
@@ -108,11 +109,6 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_FORMAT_NAME_STATUS	0x0200
 #define DIFF_FORMAT_CHECKDIFF	0x0400
 
-/* Same as output_format = 0 but we know that -s flag was given
- * and we should not give default value to output_format.
- */
-#define DIFF_FORMAT_NO_OUTPUT	0x0800
-
 #define DIFF_FORMAT_CALLBACK	0x1000
 
 #define DIFF_FLAGS_INIT { 0 }
diff --git a/range-diff.c b/range-diff.c
index 6c1ae9dd34..00ff5dc160 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -542,7 +542,7 @@ static void output(struct string_list *a, struct string_list *b,
 			a_util = a->items[b_util->matching].util;
 			output_pair_header(&opts, patch_no_width,
 					   &buf, &dashes, a_util, b_util);
-			if (!(opts.output_format & DIFF_FORMAT_NO_OUTPUT))
+			if (opts.output_format)
 				patch_diff(a->items[b_util->matching].string,
 					   b->items[j].string, &opts);
 			a_util->shown = 1;
diff --git a/revision.c b/revision.c
index cf68b533fd..07d653c197 100644
--- a/revision.c
+++ b/revision.c
@@ -3030,8 +3030,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		die(_("the option '%s' requires '%s'"), "--grep-reflog", "--walk-reflogs");
 
 	if (revs->line_level_traverse &&
-	    (revs->diffopt.output_format & ~(DIFF_FORMAT_DEFAULT | DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT)))
-		die(_("-L does not yet support diff formats besides -p and -s"));
+	    (revs->diffopt.output_format & ~(DIFF_FORMAT_DEFAULT | DIFF_FORMAT_PATCH)))
+		die(_("-L does not yet support diff formats besides -p"));
 
 	if (revs->expand_tabs_in_log < 0)
 		revs->expand_tabs_in_log = revs->expand_tabs_in_log_default;
-- 
2.40.0+fc1

