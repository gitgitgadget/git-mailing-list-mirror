Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 396AA1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 23:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbeJQH3U (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 03:29:20 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:56008 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeJQH3U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 03:29:20 -0400
Received: by mail-qt1-f201.google.com with SMTP id 4-v6so25533046qtt.22
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 16:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mf0127A88T9D12csagKn0A3wu6HACc8QzwWc1taLNPk=;
        b=P3A8S1o4cIFu7J1Gw0dYJmTpkreDwC5NAzzQ6QuBoI4WWMY6p2g8IFbFPOgfFEzDHf
         4gfSQeblMPpW/inVXxKXh3Vf0MPjKBHuTK86rH9a4u/Jk0BKQNXta3Sh+G/kv45yqQVQ
         i6epcLdDCAgsrejz1eeNAiOtQlSjs6gcXPO5dck2HVO/yeyZbyooItgSJWO6kPQjip/x
         IgFMVVPtSrpV5ZxIJlnB9gvk46tVAo0LaXjRDz+M3nzQkDkygh+NR4qbbTaKeFfXcKxY
         BGwLP8/YCXLwkkdfNqVAzCSKgLnv+9QQpnAqGZL7NtXKbwk4Kdo90lZWWiwaWRFDeIRU
         x0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mf0127A88T9D12csagKn0A3wu6HACc8QzwWc1taLNPk=;
        b=MQ4lleJT5np6x/3Os4XUoAz4DEIxh1Xa2PJqEDH+0kJTBNxPgtO4xqWwi+GiBmrOix
         WKmm1RFCVm4UmRujWGP67kuCAgCtNlR9je04zbMeCJgy0q8+pObBzRDn6LpGWFnCgv66
         IAaEOVAyu0DEuM8WXRGqfKtUD2WJ4UtHG7rf3jDKfMIimtcHz97DpaxHRVtg3/AwitZC
         sjdHrw3yeU0Woss6XUygdx/NGU0yTeqQp+6T3TGCItwHAh0ary7EMSCdcxiukyWVeVb4
         nvtu9gDkuZduYImlbAwFHXt9sRVVN9zlw0jSsGxgFrLx7E8m5/1ooi+JejOal2ms0Eo9
         VJLw==
X-Gm-Message-State: ABuFfohN2C4r4pxF+FFLQmTcIe6XSXKs4qbppCtV90gFpck7jptUjTOK
        Pxawezo1MBF9CrEdux+Ehw/9zjl1LpqzK3rr1TBaBs4wzkO7L+Bw6je+FI+iKGRY+LbHDdzl5XF
        ZBXFAnglHY/EB6XkmrUDWgZoxirRaTD9PAfsJMFb4m5H0tYEZEzLL+L4/LMNr
X-Google-Smtp-Source: ACcGV61of95dTBxubxDlDqOVanLUB8IlLKLgDoBI5DsjaxbEzz9BrsUj/ZfEIITm+rknjmuq6t7Cva3weKkN
X-Received: by 2002:aed:3805:: with SMTP id j5-v6mr19915659qte.48.1539732994851;
 Tue, 16 Oct 2018 16:36:34 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:35:48 -0700
In-Reply-To: <20181016233550.251311-1-sbeller@google.com>
Message-Id: <20181016233550.251311-18-sbeller@google.com>
Mime-Version: 1.0
References: <20181016233550.251311-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 17/19] pretty: prepare format_commit_message to handle
 arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/coccinelle/the_repository.cocci | 10 ++++++++++
 pretty.c                                | 15 ++++++++-------
 pretty.h                                |  7 ++++++-
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
index f5b42cfc62..2ee702ecf7 100644
--- a/contrib/coccinelle/the_repository.cocci
+++ b/contrib/coccinelle/the_repository.cocci
@@ -132,3 +132,13 @@ expression G;
 - logmsg_reencode(
 + repo_logmsg_reencode(the_repository,
   E, F, G);
+
+@@
+expression E;
+expression F;
+expression G;
+expression H;
+@@
+- format_commit_message(
++ repo_format_commit_message(the_repository,
+  E, F, G, H);
diff --git a/pretty.c b/pretty.c
index 26e44472bb..948f5346cf 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1505,9 +1505,10 @@ void userformat_find_requirements(const char *fmt, struct userformat_want *w)
 	strbuf_release(&dummy);
 }
 
-void format_commit_message(const struct commit *commit,
-			   const char *format, struct strbuf *sb,
-			   const struct pretty_print_context *pretty_ctx)
+void repo_format_commit_message(struct repository *r,
+				const struct commit *commit,
+				const char *format, struct strbuf *sb,
+				const struct pretty_print_context *pretty_ctx)
 {
 	struct format_commit_context context;
 	const char *output_enc = pretty_ctx->output_encoding;
@@ -1521,9 +1522,9 @@ void format_commit_message(const struct commit *commit,
 	 * convert a commit message to UTF-8 first
 	 * as far as 'format_commit_item' assumes it in UTF-8
 	 */
-	context.message = logmsg_reencode(commit,
-					  &context.commit_encoding,
-					  utf8);
+	context.message = repo_logmsg_reencode(r, commit,
+					       &context.commit_encoding,
+					       utf8);
 
 	strbuf_expand(sb, format, format_commit_item, &context);
 	rewrap_message_tail(sb, &context, 0, 0, 0);
@@ -1547,7 +1548,7 @@ void format_commit_message(const struct commit *commit,
 	}
 
 	free(context.commit_encoding);
-	unuse_commit_buffer(commit, context.message);
+	repo_unuse_commit_buffer(r, commit, context.message);
 }
 
 static void pp_header(struct pretty_print_context *pp,
diff --git a/pretty.h b/pretty.h
index 7359d318a9..e6625269cf 100644
--- a/pretty.h
+++ b/pretty.h
@@ -103,9 +103,14 @@ void pp_remainder(struct pretty_print_context *pp, const char **msg_p,
  * Put the result to "sb".
  * Please use this function for custom formats.
  */
-void format_commit_message(const struct commit *commit,
+void repo_format_commit_message(struct repository *r,
+			const struct commit *commit,
 			const char *format, struct strbuf *sb,
 			const struct pretty_print_context *context);
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#define format_commit_message(c, f, s, con) \
+	repo_format_commit_message(the_repository, c, f, s, con)
+#endif
 
 /*
  * Parse given arguments from "arg", check it for correctness and
-- 
2.19.0

