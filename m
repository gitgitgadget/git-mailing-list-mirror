Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79B2A20A1E
	for <e@80x24.org>; Sat, 15 Dec 2018 00:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbeLOAK1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 19:10:27 -0500
Received: from mail-io1-f74.google.com ([209.85.166.74]:50534 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730078AbeLOAK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 19:10:26 -0500
Received: by mail-io1-f74.google.com with SMTP id p4so6090255iod.17
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 16:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=L0KhuO4VvSFHDmNc68K7b4oXzaLRvmpO4XuJPz3NT0Y=;
        b=qj7nmDcIhUmYWuGuw42/XM8hvT2BA0DoDpY9CMFapHcTpJsMum9av9Wb9JGaf0FL4E
         SjbOHzM97RFC03DrDP6zJSiaDOyUC3/osst+PHHyxueX+cF6GvnUdmAQk7tIqcpVL9n9
         GzHVYQFBADXGX9TC8WhcOG6kAYb9jpU/2D677t2OllZ6fXn9tF6H49rfvQXbz5AC5E5g
         2Nuf90WoBFUEJeheCb+4wPkDbJuJbu2xQbkqPZtdhQPT0DaRFzrUAfvZI/LlMcwan/GW
         iAlsR+Xny8biIeflMpFlWfTggttZacSdo1CERPz5m/eU9gnJ8tXDBu1FFnwLBm7cEqhd
         MaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=L0KhuO4VvSFHDmNc68K7b4oXzaLRvmpO4XuJPz3NT0Y=;
        b=h4UwqReM8xAiBD7fU8HkHLx8A6FcRL1538xEev1frOR0nR1Oo4itObms9sUwQ+x5xp
         okGhSGYkPwoL1K0P897rDj7zIECRy2Ed7ygKabUKDgNIiMxkG2ui+F723ehPky27yTOQ
         CUc+E1WASMvXwhVylmv7JCMQUM4gnYmPTjax8dO3KSdSqXKjevS3RSH7JRQOaKuCqYFJ
         vQDTwZJc05bWeFLt6Eol1N+ix0A6Fo79XRie1iw84MXuUrq8kKpyJuhve+v09ZFoTnhT
         v8tpRcGnAZmwt3tJBvYXiH5JlGOWZSnN/pnta3q5IuzUE0r5VDq7L6W/P1H9Q0LTzSXI
         YF/g==
X-Gm-Message-State: AA+aEWY6NnVAeXro6T0Uisvg5uMVUv0todoYDbSaqR27ikTeSbB0qP0y
        kzPsKuDsa7EupMjzW/NFn3NAGmfPUbmV7BqAGtfQLCFdAxjqmvVE1mvdU718sOGYIZ4+cJfKfwu
        aT4do5sFaltELRAGJs6FPkY9h7jZMUht6hFHifcHUfW6iX5cIi2NcY2yuxzxg
X-Google-Smtp-Source: AFSGD/UdxDabIieItqJdjVDPQKZ1ihHDE95dbulBqB6EAHTUSLYMBl17zXCxQB2GjTj8q4o1e1nC0+gHeAym
X-Received: by 2002:a24:5755:: with SMTP id u82mr4791315ita.16.1544832625784;
 Fri, 14 Dec 2018 16:10:25 -0800 (PST)
Date:   Fri, 14 Dec 2018 16:09:36 -0800
In-Reply-To: <20181215000942.46033-1-sbeller@google.com>
Message-Id: <20181215000942.46033-18-sbeller@google.com>
Mime-Version: 1.0
References: <20181215000942.46033-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [PATCH 17/23] pretty: prepare format_commit_message to handle
 arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
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
2.20.0.405.gbc1bbc6f85-goog

