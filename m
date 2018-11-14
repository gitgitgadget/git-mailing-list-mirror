Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3023D1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731359AbeKNKO6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:14:58 -0500
Received: from mail-it1-f201.google.com ([209.85.166.201]:53584 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731191AbeKNKO6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 05:14:58 -0500
Received: by mail-it1-f201.google.com with SMTP id l200-v6so18007642ita.3
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 16:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/M0cdu6WCZ+2pkx59FGxTEKlnilI57MH75dOTIlVSq0=;
        b=lNYwvd6l/WSK6wAaX5prHkCkQcjNOJCAP9n6yMnPrBhk3dhKO3KzlvCMRd5BGgYWJ9
         WfMNAT0mHeU/kHgqI0KGEhD9fPzIxdbSi7IUNjCMhDsqzN1kWxkP1/6KCU6eFYt0IsEx
         gAVncHcXiEb5/NDq5si+OYyH24xJ5pKEMuuzy9AroLItG/hGYvMf/PaL/jDwZjrYrPXy
         T0KFXct9PSqTlTHFEZWhZm7AwPxOOrV88dhvA2Ssa+g/NYG6pVmfQlGLPz1fmA6RdcXv
         pHbgaxH9SnqawVu1YsWfKCV8yLsTSECxCnbOaLo1rRiyHYHC02t/Q/66bSlu5z20rDV4
         p24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/M0cdu6WCZ+2pkx59FGxTEKlnilI57MH75dOTIlVSq0=;
        b=mGINLh3M5+J+21sEbZzN9n0rgMsmEg8XNVUSrQnDwKvzOW+HhIzuc8Smu6zUx61L27
         JkW5TWx2Ko5Ge+EmBYP5c5vHZE+INEd8nqK2FUAi4wvhpKsBpwYqMtg90bkwRxPDE6Bx
         2BliU6sCUefgWUdflBc7pgg2ahtwMBcd5cAFUfe3TJxy0qLEqWvKxuRXg10XG56lnjeH
         v+0jcJU9DziHZFmaNIlC9mBblOdkTvSQjrOOjhTJ4HuokWbkLDy2SXo7gEygTD/rx9Zt
         9vrBPWSEZ5pcJhSPREE4J3a6+oXm/pRBvQYH8+tKtA3h2rS4vxCZw7pnKHNgeBPe/23p
         poBg==
X-Gm-Message-State: AGRZ1gLK7bCZaNZql00tw5siX+bHjm8itRb3LuLif6+He2o8yolbUyP+
        KySDN/MmAnjDPxR5MJfcdcRZfTVomDzQ
X-Google-Smtp-Source: AJdET5dx0VhHfJIHu5qYKoVzDuJKdmcwNBNP0l+VLLJrLp+bwEw7sQmuosXZb/v/9dyVBSKAEPGDG5BYx89F
X-Received: by 2002:a24:59d1:: with SMTP id p200-v6mr84467itb.10.1542154455319;
 Tue, 13 Nov 2018 16:14:15 -0800 (PST)
Date:   Tue, 13 Nov 2018 16:13:00 -0800
In-Reply-To: <20181114001306.138053-1-sbeller@google.com>
Message-Id: <20181114001306.138053-18-sbeller@google.com>
Mime-Version: 1.0
References: <20181114001306.138053-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH 17/23] pretty: prepare format_commit_message to handle
 arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
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
2.19.1.1215.g8438c0b245-goog

