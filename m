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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524DAC432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 16:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35E1760E98
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 16:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344430AbhIAQxX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 12:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344459AbhIAQxV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 12:53:21 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7B9C061575
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 09:52:23 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x27so310750lfu.5
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 09:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=46xr8D2LsjsNwwsRXNF4aQpWjy5MEX0LohcjWy3vgf4=;
        b=MYJt4+RjniYZE3n1favyy42dR1BrynnIhREVnXF9ZEREu2lZSp4rQe7fjSVEGVgQwL
         xTBV58EPYs5tsdd5E13X/15YksvWzxGgtKfBToTJPoSw+UMi7o52XzjjFMlMKLKpZvKR
         Bexmw5sNq6VP7+CC4Up5ai8VPLKBdqnamf4e77Tsz3RCMUmupkIwhYYXGesjpDOGNC2U
         7i1lQVB2/PfdfqsLFAiUKsb0td4L+4kR9jiQR5kUgF/9iVNQ4VJ5FnD20U0k1uCozOTH
         3KtdR3Q4AqFQP9zJ1jgFGoqXLIPtIJtE81aolCFwE1ak7cHo8AI3QydnMAfSbblCIriw
         8o8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=46xr8D2LsjsNwwsRXNF4aQpWjy5MEX0LohcjWy3vgf4=;
        b=KHVSN2O0970bfkbshjJU3yuavG/Q2NEGhsYgMLqjFXpEWw78+IKdcD+AyWjoDDWD1V
         DLbyLAHfuWku2Ma1+81z8pSjgFGxIlrevy97M2Z/YvaykWoJcYLq9kYLwyZj/L/4YLqo
         pZFZ1DuXYh9NCLSxQOJrxf0LLyAcBLuMZwlnLiHUe7/eAdWeEJjUvK/Xt7baLXeFfWPE
         VdZxhhS3ph7fHCPgyLP6OPAIXRxEU2tL0z96npVSdf7VcUJfbw7aUmHRXJqhie+IHP/u
         g55O+89czQ45XBFczq9W7g2hCvexuW5B9pFx0foVktxs2FU+yhb5u4q0Gh8iYVLVdqIF
         iPGQ==
X-Gm-Message-State: AOAM533LTm4uy2d/IcA0X3zYc8mESnMsCB4of4tWYShbRBD3dVNm6LuH
        rBMiAYS3rbECGHCLotvR1RFqIXh108w=
X-Google-Smtp-Source: ABdhPJyHEv2sEjNleHa4irwGqg5hsPL77iFxAfj/tI4UlhIvVM6J5wHls17a2MqUxqMh4vkVeJzLyg==
X-Received: by 2002:a05:6512:3b27:: with SMTP id f39mr269388lfv.303.1630515141854;
        Wed, 01 Sep 2021 09:52:21 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id d7sm21715ljc.129.2021.09.01.09.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 09:52:21 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: diff-index --cc no longer permitted, gitk is now broken (slightly)
References: <e6bd4cf7-ec8b-5d22-70f6-07089794df0c@kdbg.org>
Date:   Wed, 01 Sep 2021 19:52:20 +0300
In-Reply-To: <e6bd4cf7-ec8b-5d22-70f6-07089794df0c@kdbg.org> (Johannes Sixt's
        message of "Mon, 30 Aug 2021 10:03:18 +0200")
Message-ID: <87h7f4tf0b.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Since 19b2517f95a0 (diff-merges: move specific diff-index "-m" handling
> to diff-index, 2021-05-21) git diff-index no longer accepts --cc. This
> breaks gitk: it invokes
>
>    git diff-index --cached -p -C --cc --no-commit-id -U3 HEAD
>
> to show the staged changes (when the line "Local changes checked in to
> index but not committed" is selected).
>
> The man page of git diff-index does not mention --cc as an option. I
> haven't fully grokked the meaning of --cc, so I cannot tell whether this
> absence has any significance (is deliberate or an omission).
>
> Is gitk wrong to add --cc unconditionally? Should it do so only when
> there are conflicts? Or not at all?
>

Here is a patch that fixes diff-index to accept --cc again:

Subject: [PATCH] diff-index: restore -c/--cc options handling

This fixes git:19b2517f95a0a908a8ada7417cf0717299e7e1aa
"diff-merges: move specific diff-index "-m" handling to diff-index"

That commit disabled handling of all diff for merges options in
diff-index on an assumption that they are unused. However, it later
appeared that -c and --cc, even though undocumented and not being
covered by tests, happen to have had particular effect on diff-index
output.

Restore original -c/--cc options handling by diff-index.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 builtin/diff-index.c |  6 +++---
 diff-merges.c        | 14 ++++----------
 diff-merges.h        |  2 +-
 3 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index cf09559e422d..5fd23ab5b6c5 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -29,10 +29,10 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 	prefix = precompose_argv_prefix(argc, argv, prefix);
 
 	/*
-	 * We need no diff for merges options, and we need to avoid conflict
-	 * with our own meaning of "-m".
+	 * We need (some of) diff for merges options (e.g., --cc), and we need
+	 * to avoid conflict with our own meaning of "-m".
 	 */
-	diff_merges_suppress_options_parsing();
+	diff_merges_suppress_m_parsing();
 
 	argc = setup_revisions(argc, argv, &rev, NULL);
 	for (i = 1; i < argc; i++) {
diff --git a/diff-merges.c b/diff-merges.c
index d897fd8a2933..5060ccd890bd 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -6,7 +6,7 @@ typedef void (*diff_merges_setup_func_t)(struct rev_info *);
 static void set_separate(struct rev_info *revs);
 
 static diff_merges_setup_func_t set_to_default = set_separate;
-static int suppress_parsing;
+static int suppress_m_parsing;
 
 static void suppress(struct rev_info *revs)
 {
@@ -91,9 +91,9 @@ int diff_merges_config(const char *value)
 	return 0;
 }
 
-void diff_merges_suppress_options_parsing(void)
+void diff_merges_suppress_m_parsing(void)
 {
-	suppress_parsing = 1;
+	suppress_m_parsing = 1;
 }
 
 int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
@@ -102,10 +102,7 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 	const char *optarg;
 	const char *arg = argv[0];
 
-	if (suppress_parsing)
-		return 0;
-
-	if (!strcmp(arg, "-m")) {
+	if (!suppress_m_parsing && !strcmp(arg, "-m")) {
 		set_to_default(revs);
 	} else if (!strcmp(arg, "-c")) {
 		set_combined(revs);
@@ -153,9 +150,6 @@ void diff_merges_set_dense_combined_if_unset(struct rev_info *revs)
 
 void diff_merges_setup_revs(struct rev_info *revs)
 {
-	if (suppress_parsing)
-		return;
-
 	if (revs->combine_merges == 0)
 		revs->dense_combined_merges = 0;
 	if (revs->separate_merges == 0)
diff --git a/diff-merges.h b/diff-merges.h
index b5d57f6563e3..19639689bb05 100644
--- a/diff-merges.h
+++ b/diff-merges.h
@@ -11,7 +11,7 @@ struct rev_info;
 
 int diff_merges_config(const char *value);
 
-void diff_merges_suppress_options_parsing(void);
+void diff_merges_suppress_m_parsing(void);
 
 int diff_merges_parse_opts(struct rev_info *revs, const char **argv);
 
-- 
2.33.0.114.g9123bcff51bf

