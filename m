Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF9491F453
	for <e@80x24.org>; Tue, 30 Oct 2018 22:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbeJaHEc (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 03:04:32 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:47231 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728491AbeJaHEc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 03:04:32 -0400
Received: by mail-qt1-f201.google.com with SMTP id u2-v6so15088077qtg.14
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 15:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MnFi4vDa1i8EwOn6Hm6HfdZKWR7jua7aVdTf7uKmqO0=;
        b=GH2WxTlDO4ub17Yve1H4wj/HINJcALBvs717NwmSiUGMJtGIwqEfVrnfJd0cWDwbwc
         9dhZxnmbdt1OPseII1kSPTEeCqGetPrpJexTPoGkMmBdt1dGGD38VK7a2zK8HcP0CtMw
         brxGK0TpcVrJMGCVKLivMBCWBEUDLqwlLEb4lDjPYqwk2nKPtk8iyKSss0eBehnS7ERH
         oMGbqudKM30cFBpiKStkWH1D86EGfp8YZaLRzVJUe3Efcz9HlImY1mjmQSSY5FOqQiJ0
         q3SowfOUO3L0QhNRFJUIVXtvsp5KQgCx1VlI3frJiXiLZvCk2XwqhLP0mml4MhYPMYdM
         K5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MnFi4vDa1i8EwOn6Hm6HfdZKWR7jua7aVdTf7uKmqO0=;
        b=iTaWvOvKI6ceSlXVDBphOKS/IafQRvbQ212Qe9Djt5xGjkIo1Q9xWtMa6zngR260Dc
         Rx+VJnZ528NVGuH3a+pH8RkVYCjUqOQ+SeBRY2pg/AJ2GRsafhumY08nCoCmqSI3NTXS
         rXSsGi2CvlJ5OM2WuNcCfgINaYq297FveuNpmw/XYen+yk6QhXyV3jt8Vo8K0Y11anbM
         A91U226pVjE/CljoqoXJJ7it7wNzzCqgeWK8YUxCUL05HLysQLx0w1IXP/u6PLelDQjy
         j6rnQONUlUAk1C7pEIZeZ/QA16F4pR2k4Yq2C0+WcxNgBTLk3lQRL8Ow3I0gaXiavXR/
         TwAA==
X-Gm-Message-State: AGRZ1gI8p6W9S+8yl1E+kInnhZmQ0xTkRNdMFnP7tYwhjmO9Bt+hAoIM
        SmqoRKesgfn+511Ff0YWup74GOsHzq32+5sT2UNFnsWAh1+56XeHozQh40dKeIGlK0NGMgqeZrd
        S53ZbqBGRG/2ePhdN5sxXrM2oUsaif3QJt3DD0bviwOEIpToOYwxYoLqreG3d
X-Google-Smtp-Source: AJdET5dZfXmxjO8YpRvOmiIgxJgJSn/yHkaGkviSCMA0O9o2cV5Sf6TpX5dc6mX0L+esgcYLvP6cX3qSREfx
X-Received: by 2002:a37:3508:: with SMTP id c8-v6mr431504qka.62.1540937356493;
 Tue, 30 Oct 2018 15:09:16 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:08:11 -0700
In-Reply-To: <20181030220817.61691-1-sbeller@google.com>
Message-Id: <20181030220817.61691-19-sbeller@google.com>
Mime-Version: 1.0
References: <20181030220817.61691-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH 18/24] pretty: prepare format_commit_message to handle
 arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, jonathantanmy@google.com,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/coccinelle/the_repository.pending.cocci | 10 ++++++++++
 pretty.c                                        | 15 ++++++++-------
 pretty.h                                        |  7 ++++++-
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index f5b42cfc62..2ee702ecf7 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
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
index b359b68750..3240495308 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1508,9 +1508,10 @@ void userformat_find_requirements(const char *fmt, struct userformat_want *w)
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
@@ -1524,9 +1525,9 @@ void format_commit_message(const struct commit *commit,
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
@@ -1550,7 +1551,7 @@ void format_commit_message(const struct commit *commit,
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
2.19.1.930.g4563a0d9d0-goog

