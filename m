Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D62DD1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 21:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbeJLErj (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 00:47:39 -0400
Received: from mail-it1-f201.google.com ([209.85.166.201]:43201 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeJLErj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 00:47:39 -0400
Received: by mail-it1-f201.google.com with SMTP id w137-v6so11240981itc.8
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 14:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0NzGU7Eh3pz6deiN1D8iqAyLoQSeY8LiS6PVmKcunfw=;
        b=e6VkJUs6tw03onNoIkg4RQB6/zlTzavTVmUxnqCsF635DEFZoiY/A0qBk9qDVPcvmf
         wGryeZJrqQEIBWlQQlUPW0LRP2ICXT0G+AljAK8ieuxF3HVZkR0GavbIRQscZQabFNTh
         eUIreqz9KpWs0k5TcHnHwuz/IgZZrv35dC+JUSe+kztckhI2pMY9llgowU2VAsa3+6yK
         wclFutjDjAsQHSFTa4Be74YEu663hdPgTI9KlVaWB6H2M1I5MFu6DYeJl49wa2MX35/n
         b2XzBNP8IlwgF1hchx417eP5uWwLlP2oPqxHz+z08j8+0GWGtam1PWidTVpGa5c+qLLy
         YWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0NzGU7Eh3pz6deiN1D8iqAyLoQSeY8LiS6PVmKcunfw=;
        b=N/i9wm181PgbTUH62gL0gNB7pN+08wPe+UfKDbii60dAVHVFiKcTh4xBLcgEeYX3ZU
         Mh0BfkK3foQVbU6tRlLmSQVK2ItkWvV3TjlzPIn3fVKMtj5IuNq21N25cXMEKerZN/xD
         osHeOsnlAKNqtDsAzxqapI32/fOOTGt/oR/Vk5QBgtHMjar8DT1Xpra4KjtWe+FbJb52
         LTXEKn3qUVmbiDOPpLHs1rcA8vINm2y8/NVO8SsoI1Vwipp8nEIiM4QFtalshw+2b9vX
         gf4VjmUesKCgNHoWv+sDhkafm7spQQjWKozQ8wfrArH0WhKZ9pCBnSIAmcDxRdJsVz65
         YSEA==
X-Gm-Message-State: ABuFfoj24mH3355rGxkrzborqAAhUJHF12Wg63blF4wdeURAEYV0KzwV
        y4vQwkCjxEl2Jh8+J6smrPsRYe41wVdScA8T6o+wmoPU07F394Fgmm8c652zEiHZv0Q5QrWY8hM
        8B4cvPYtTdloHaCei86wg5A3N0IdPG6aU4ANz67sGl/jwfLUt9uQmkL7A/uIv
X-Google-Smtp-Source: ACcGV61qfaUhBtHHFzD9n26ma3LcY3wLp8odCdd9H0+7IjjbFQak8n4M0/4CwzwKFx6avrYtJBDcQGgVJ+KU
X-Received: by 2002:a24:e48b:: with SMTP id o133-v6mr5825205ith.0.1539292714901;
 Thu, 11 Oct 2018 14:18:34 -0700 (PDT)
Date:   Thu, 11 Oct 2018 14:17:51 -0700
In-Reply-To: <20181011211754.31369-1-sbeller@google.com>
Message-Id: <20181011211754.31369-17-sbeller@google.com>
Mime-Version: 1.0
References: <20181011211754.31369-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 16/19] pretty: prepare format_commit_message to handle
 arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 contrib/coccinelle/the_repository.cocci | 10 ++++++++++
 pretty.c                                | 15 ++++++++-------
 pretty.h                                |  7 ++++++-
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
index c81708bb73..c86decd418 100644
--- a/contrib/coccinelle/the_repository.cocci
+++ b/contrib/coccinelle/the_repository.cocci
@@ -102,3 +102,13 @@ expression G;
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

