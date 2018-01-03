Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BA291F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751146AbeACAqf (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:46:35 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:43040 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbeACAqc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:46:32 -0500
Received: by mail-io0-f193.google.com with SMTP id w188so505469iod.10
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jm8HAIUmwcAH4P8UjcieuU8LHjYMMU/6BWghfp3INWg=;
        b=elfH71YyaWOn+QVcZoB5dFAfaDt9dMoFl4mY+77o4S2RULtzqZdFR8lpzTWLckYZp3
         QDmEhB0t2RYuUX2fXCnAAPIDEC49eMXc5l4KdRZY5QxldEoUGJayZ8py0h1APsKiN2qu
         ZkVZA3fSjGj8JnK5pYUUAvkWZQCOFPV2/L6ZjEJexAzmmbvNrDGO5Z7MzM45M/Xel/Gl
         cjx2yxC0dgyj/rCAsvBRutN8WnCOB0CIM3tJ6BSNow6XYoyNed+FRZdtppa3v7tiS7Ou
         cbjAEY9NAEC3bVArihbFAOOJf2t/R7AlyaRYeaW38Zdo/wi3gyruPo+vFW6/4A+FOlWN
         bMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jm8HAIUmwcAH4P8UjcieuU8LHjYMMU/6BWghfp3INWg=;
        b=c65OeP9RiZepvBZujdPBb9VIeKdNUdopJmkwZR/72pG/rG4Nm3Fl73YVNgo/oT8LFo
         xUFh2mGg8ahhjzbiMghnCE+IA9x4DprMo8FT63rkoZiTtnwHw5j/nBFp9zb85ppJXusq
         IRYikzSU5aOvjyTTlj/R52PaVrsiNQ4QgyIfID1JQEPHkzbvfI85c+kFKe5z2zkAEDvT
         BoSHTRLb8R/4xEcUSs7ay5uGZLmOZ8rmOWKVDfh8iNSAsFreWFScJHe+3p4NW+WMHEIq
         NOoTKJOuyyxAQ9sbpVRrIwEJC63VqN2pbDqz5d6DMFy0I6C5SzuFMdpFARzwmSeoj51c
         JBFQ==
X-Gm-Message-State: AKGB3mJWU3V+QrKnXi28CxsX2NzM+WyRlxqxv8vVtKKGruqyZ3xMSi6j
        lQtfcaUsMyF9H6V6+tqeeT4KC85HRP8=
X-Google-Smtp-Source: ACJfBosO0a3NP5Q2OkL16ihw/xb1GCzf1ovFTCIczq1sgW/635nvg3s3jGtEt75AnePxPvmUmQET+g==
X-Received: by 10.107.154.138 with SMTP id c132mr19624738ioe.79.1514940391655;
        Tue, 02 Jan 2018 16:46:31 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id n79sm15941944ion.23.2018.01.02.16.46.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jan 2018 16:46:31 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/5] diff: migrate diff_flags.pickaxe_ignore_case to a pickaxe_opts bit
Date:   Tue,  2 Jan 2018 16:46:21 -0800
Message-Id: <20180103004624.222528-3-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103004624.222528-1-sbeller@google.com>
References: <20180103004624.222528-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently flags for pickaxing are found in different places. Unify the
flags into the `pickaxe_opts` field, which will contain any pickaxe related
flags.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.h             | 3 ++-
 diffcore-pickaxe.c | 6 +++---
 revision.c         | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/diff.h b/diff.h
index ea310f76fd..8af1213684 100644
--- a/diff.h
+++ b/diff.h
@@ -91,7 +91,6 @@ struct diff_flags {
 	unsigned override_submodule_config:1;
 	unsigned dirstat_by_line:1;
 	unsigned funccontext:1;
-	unsigned pickaxe_ignore_case:1;
 	unsigned default_follow_renames:1;
 };
 
@@ -327,6 +326,8 @@ extern void diff_setup_done(struct diff_options *);
 #define DIFF_PICKAXE_KIND_S	4 /* traditional plumbing counter */
 #define DIFF_PICKAXE_KIND_G	8 /* grep in the patch */
 
+#define DIFF_PICKAXE_IGNORE_CASE	32
+
 extern void diffcore_std(struct diff_options *);
 extern void diffcore_fix_diff_index(struct diff_options *);
 
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 9476bd2108..4b5d88ea46 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -222,11 +222,11 @@ void diffcore_pickaxe(struct diff_options *o)
 
 	if (opts & (DIFF_PICKAXE_REGEX | DIFF_PICKAXE_KIND_G)) {
 		int cflags = REG_EXTENDED | REG_NEWLINE;
-		if (o->flags.pickaxe_ignore_case)
+		if (o->pickaxe_opts & DIFF_PICKAXE_IGNORE_CASE)
 			cflags |= REG_ICASE;
 		regcomp_or_die(&regex, needle, cflags);
 		regexp = &regex;
-	} else if (o->flags.pickaxe_ignore_case &&
+	} else if (o->pickaxe_opts & DIFF_PICKAXE_IGNORE_CASE &&
 		   has_non_ascii(needle)) {
 		struct strbuf sb = STRBUF_INIT;
 		int cflags = REG_NEWLINE | REG_ICASE;
@@ -236,7 +236,7 @@ void diffcore_pickaxe(struct diff_options *o)
 		strbuf_release(&sb);
 		regexp = &regex;
 	} else {
-		kws = kwsalloc(o->flags.pickaxe_ignore_case
+		kws = kwsalloc(o->pickaxe_opts & DIFF_PICKAXE_IGNORE_CASE
 			       ? tolower_trans_tbl : NULL);
 		kwsincr(kws, needle, strlen(needle));
 		kwsprep(kws);
diff --git a/revision.c b/revision.c
index e2e691dd5a..ccf1d212ce 100644
--- a/revision.c
+++ b/revision.c
@@ -2076,7 +2076,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->grep_filter.pattern_type_option = GREP_PATTERN_TYPE_ERE;
 	} else if (!strcmp(arg, "--regexp-ignore-case") || !strcmp(arg, "-i")) {
 		revs->grep_filter.ignore_case = 1;
-		revs->diffopt.flags.pickaxe_ignore_case = 1;
+		revs->diffopt.pickaxe_opts |= DIFF_PICKAXE_IGNORE_CASE;
 	} else if (!strcmp(arg, "--fixed-strings") || !strcmp(arg, "-F")) {
 		revs->grep_filter.pattern_type_option = GREP_PATTERN_TYPE_FIXED;
 	} else if (!strcmp(arg, "--perl-regexp") || !strcmp(arg, "-P")) {
-- 
2.15.1.620.gb9897f4670-goog

