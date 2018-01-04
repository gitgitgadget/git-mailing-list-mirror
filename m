Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 392DE1F404
	for <e@80x24.org>; Thu,  4 Jan 2018 22:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753658AbeADWwy (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 17:52:54 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44541 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753650AbeADWww (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 17:52:52 -0500
Received: by mail-pg0-f67.google.com with SMTP id i5so1272917pgq.11
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 14:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=++Rj9DVIStHzXqrq/ZvId9jGkHm5CWkDb6F5VYsf0lQ=;
        b=f+A3zkX9Lc4CcW6D7hCMnp6OhemcosO+U/j7nOqGWeMNS/0ce1hltt+7GYbeVB53lQ
         Ca9j9PBmOTxJQB1OuGDE78VRZowkjuBPh+oGPqLmUgznh0AlToN1N7Z9I/WwH+fAjN6J
         zU8m8lLSIWkr1mlGrWiJpU3a+0Q5gNd6g8yFRCgFJP/GZGTb69vQEb2QOEtfNxaU/NJx
         xM/5eOEArfXAqd2brY/HFUCaLeGpwt2i9uF7X2dW9WbcArPEjPIqBCJRn3zPx+gQjz+v
         wBinGn+SsZpuxycsuRKpWOHK0+2iEALQPZ+POwjVkv1v9Se7vR3RoOApMWJGh807YhCB
         cOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=++Rj9DVIStHzXqrq/ZvId9jGkHm5CWkDb6F5VYsf0lQ=;
        b=HxpzdZe7x6mR0iWiPpufGRkdSX6Z5EmwKsCqCq9aCzMLcan219y7OJRolw+Cqh2egn
         zmBrIpUWMUEz9WRlWo8boCRLC/7i45F9ChM0u+Ye6mwCLmZdKX5d6CqBww8S5HmOHztw
         xzxXGa+HqYs74Fg8FtwADCRYack/UrHIfzMxroe6ZkyeU1UIxPWBRN2AvTFg4/OSnEtF
         o51yasc+l/4awnJsL5s+Enhrd/ovX1VUp3BnNTqdMgZYdq4YbiqH6WUb722QmwiujRnr
         Hzu2diHw++5Le8buzBt/5NWm5DAlh+c+fcAzp0jKJmCi9a3JWPkDryMBgpJIFxG8q+Dl
         Zh0g==
X-Gm-Message-State: AKGB3mLFm4CL51bT2N5z57OSKsR3ZUbyzVVoqa0fh8e9V9mJ0FzN4s/Z
        qVlnxgK69cYw11p8ONeBTmWTxA==
X-Google-Smtp-Source: ACJfBot2EBn1jYiW/Pl+gLhTjTozyPhpNa0Jfei1eBOTBRZP3nPCG3JOqN6BXb6bngDg/tFo8na+IA==
X-Received: by 10.98.200.130 with SMTP id i2mr983437pfk.57.1515106371640;
        Thu, 04 Jan 2018 14:52:51 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id r62sm10101975pfi.184.2018.01.04.14.52.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jan 2018 14:52:51 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jacob.keller@gmail.com
Subject: [PATCHv2 2/6] diff: migrate diff_flags.pickaxe_ignore_case to a pickaxe_opts bit
Date:   Thu,  4 Jan 2018 14:50:40 -0800
Message-Id: <20180104225044.191220-3-sbeller@google.com>
X-Mailer: git-send-email 2.16.0.rc0.223.g4a4ac83678-goog
In-Reply-To: <20180104225044.191220-1-sbeller@google.com>
References: <20180103004624.222528-1-sbeller@google.com>
 <20180104225044.191220-1-sbeller@google.com>
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
2.16.0.rc0.223.g4a4ac83678-goog

