Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C8FD1F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751160AbeACAqo (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:46:44 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:40666 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbeACAqe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:46:34 -0500
Received: by mail-it0-f68.google.com with SMTP id f190so86435ita.5
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KzMaCU/J10q6SsAnuYUmZVeJ8U0RtalNQlkalhBxU3g=;
        b=m4g3p3WPR7ZEUXIX6Vyle8qYn2WdM6upOnfGvPTINfueF3mYUFPEHH1UGLlfCKONL5
         pLwICT5Fb81xvjEI5nWa7Ju2zf3RYE/HXq+cIgxi90UF+z5cw0QrDVGLVJvihcMPydrp
         tBZYJjRsdGyQIJfZpjocO8mZF3JnzMKJARoS+46P4oWYQK0Q5ghr5ILa0+O48gC5rBBb
         uztq0wGtGanUuRZxfoVhUN86qYz+tzNdBxJvBaKkzzKTBsBMlv/ElFbCH1n4aOrbtiS/
         r0gX23AQCrDRicxLjxyv5M3oahuup8MG0DqEf/oDJRoLNPmCpJOuck9dkjBtJZ1fyygA
         tvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KzMaCU/J10q6SsAnuYUmZVeJ8U0RtalNQlkalhBxU3g=;
        b=fS5GuQNkwv/4DkwMFM0HJjqcYOvONh1+J629sv+kQn55+cdKN7qJV0nUcB6k058/Rm
         lPA+BJyvyC6B6bmDw1gDstUCkWu0cB6HHy3rgxMaTnZSsmPbX4ljYvC6lXudnnqaI5j8
         P3DpiMR1OKdqr7ypUFheQO+qc1k1+fLk0+EJlChURol/KtNk5/z0E7qpOvg2Mjdlbrqa
         SvDiln/WhF8D5mfnR+UwEdCCzy1xHTg2rQiukeJMWQYIXd9lhIzW1iQxBm/zBsJecrAC
         WBBB3X+y7RfL20uwG7CqFivtn1gqEcwX55X2IfRBLW+Vg2dOGmecTJlVx1bmPLkW6It+
         txWQ==
X-Gm-Message-State: AKGB3mLKIPjftLd8VaMeZ0pG0t7FtPNsF5GVifM2RyCPfml0Arja4nn4
        orTln4JbmmWXedNuOqHSRtqO11RjAcU=
X-Google-Smtp-Source: ACJfBovlwyi76sF/EeT47Ze8ux2wELhFWoBNtXJ+inJK7w+o07CClxvT0lbJhxXzyiW/6oEE2dOA+g==
X-Received: by 10.36.253.137 with SMTP id m131mr76627ith.16.1514940393167;
        Tue, 02 Jan 2018 16:46:33 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id l28sm15639791iod.32.2018.01.02.16.46.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jan 2018 16:46:32 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/5] diff: introduce DIFF_PICKAXE_KINDS_MASK
Date:   Tue,  2 Jan 2018 16:46:22 -0800
Message-Id: <20180103004624.222528-4-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103004624.222528-1-sbeller@google.com>
References: <20180103004624.222528-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently the check whether to perform pickaxing is done via checking
`diffopt->pickaxe`, which contains the command line argument that we
want to pickaxe for. Soon we'll introduce a new type of pickaxing, that
will not store anything in the `.pickaxe` field, so let's migrate the
check to be dependent on pickaxe_opts.

It is not enough to just replace the check for pickaxe by pickaxe_opts,
because flags might be set, but pickaxing was not requested ('-i').
To cope with that, introduce a mask to check only for the bits indicating
the modes of operation.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/log.c  | 4 ++--
 combine-diff.c | 2 +-
 diff.c         | 4 ++--
 diff.h         | 2 ++
 revision.c     | 2 +-
 5 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 6c1fa896ad..bd6f2d1efb 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -180,8 +180,8 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	if (rev->show_notes)
 		init_display_notes(&rev->notes_opt);
 
-	if (rev->diffopt.pickaxe || rev->diffopt.filter ||
-	    rev->diffopt.flags.follow_renames)
+	if ((rev->diffopt.pickaxe_opts & DIFF_PICKAXE_KINDS_MASK) ||
+	    rev->diffopt.filter || rev->diffopt.flags.follow_renames)
 		rev->always_show_header = 0;
 
 	if (source)
diff --git a/combine-diff.c b/combine-diff.c
index 2505de119a..bc08c4c5b1 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1438,7 +1438,7 @@ void diff_tree_combined(const struct object_id *oid,
 			opt->flags.follow_renames	||
 			opt->break_opt != -1	||
 			opt->detect_rename	||
-			opt->pickaxe		||
+			(opt->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK)	||
 			opt->filter;
 
 
diff --git a/diff.c b/diff.c
index 0763e89263..5508745dc8 100644
--- a/diff.c
+++ b/diff.c
@@ -4173,7 +4173,7 @@ void diff_setup_done(struct diff_options *options)
 	/*
 	 * Also pickaxe would not work very well if you do not say recursive
 	 */
-	if (options->pickaxe)
+	if (options->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK)
 		options->flags.recursive = 1;
 	/*
 	 * When patches are generated, submodules diffed against the work tree
@@ -5777,7 +5777,7 @@ void diffcore_std(struct diff_options *options)
 		if (options->break_opt != -1)
 			diffcore_merge_broken();
 	}
-	if (options->pickaxe)
+	if (options->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK)
 		diffcore_pickaxe(options);
 	if (options->orderfile)
 		diffcore_order(options->orderfile);
diff --git a/diff.h b/diff.h
index 8af1213684..9ec4f824fe 100644
--- a/diff.h
+++ b/diff.h
@@ -326,6 +326,8 @@ extern void diff_setup_done(struct diff_options *);
 #define DIFF_PICKAXE_KIND_S	4 /* traditional plumbing counter */
 #define DIFF_PICKAXE_KIND_G	8 /* grep in the patch */
 
+#define DIFF_PICKAXE_KINDS_MASK (DIFF_PICKAXE_KIND_S | DIFF_PICKAXE_KIND_G)
+
 #define DIFF_PICKAXE_IGNORE_CASE	32
 
 extern void diffcore_std(struct diff_options *);
diff --git a/revision.c b/revision.c
index ccf1d212ce..5d11ecaf27 100644
--- a/revision.c
+++ b/revision.c
@@ -2407,7 +2407,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		revs->diff = 1;
 
 	/* Pickaxe, diff-filter and rename following need diffs */
-	if (revs->diffopt.pickaxe ||
+	if ((revs->diffopt.pickaxe_opts & DIFF_PICKAXE_KINDS_MASK) ||
 	    revs->diffopt.filter ||
 	    revs->diffopt.flags.follow_renames)
 		revs->diff = 1;
-- 
2.15.1.620.gb9897f4670-goog

