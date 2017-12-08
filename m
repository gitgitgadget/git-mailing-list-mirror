Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4430220C31
	for <e@80x24.org>; Fri,  8 Dec 2017 13:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753470AbdLHNV7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 08:21:59 -0500
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:57464
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753457AbdLHNV6 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2017 08:21:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1512739316;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=evyGG2CZPB07KHKjW777zcrTord/cIjZnD+9xYhC+aA=;
        b=aKWX7NtuXBlDrSOyLy4MrGpAB3OFj71mLSsJ8FqlUfp9B0Jjs/OlARKU5sysfSQw
        VowTFsVrpij6O4pRieMAAi3ELZ91V/QKohErxMtaOLaCYlU9IAl99A7zQvOXf6v5eAJ
        QcufWlqZI+X4xgO1+LITY2lpkqHkXWIEDI2cKRUA=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020160364a2471-0e40e237-80b4-485c-a987-9c83206a2ee5-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020160364a23d5-471a2fd0-9fff-4599-86f8-b2f37a4a0a84-000000@eu-west-1.amazonses.com>
References: <01020160364a23d5-471a2fd0-9fff-4599-86f8-b2f37a4a0a84-000000@eu-west-1.amazonses.com>
Subject: [PATCH Outreachy 2/2] format: create docs for pretty.h
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 8 Dec 2017 13:21:56 +0000
X-SES-Outgoing: 2017.12.08-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Write some docs for functions in pretty.h.
Take it as a first draft, they would be changed later.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 pretty.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/pretty.h b/pretty.h
index ef5167484fb64..5c85d94e332d7 100644
--- a/pretty.h
+++ b/pretty.h
@@ -48,6 +48,7 @@ struct pretty_print_context {
 	int graph_width;
 };
 
+/* Check whether commit format is mail. */
 static inline int cmit_fmt_is_mail(enum cmit_fmt fmt)
 {
 	return (fmt == CMIT_FMT_EMAIL || fmt == CMIT_FMT_MBOXRD);
@@ -57,31 +58,74 @@ struct userformat_want {
 	unsigned notes:1;
 };
 
+/* Set the flag "w->notes" if there is placeholder %N in "fmt". */
 void userformat_find_requirements(const char *fmt, struct userformat_want *w);
+
+/*
+ * Shortcut for invoking pretty_print_commit if we do not have any context.
+ * Context would be set empty except "fmt".
+ */
 void pp_commit_easy(enum cmit_fmt fmt, const struct commit *commit,
 			struct strbuf *sb);
+
+/*
+ * Get information about user and date from "line", format it and
+ * put it into "sb".
+ * Format of "line" must be readable for split_ident_line function.
+ * The resulting format is "what: name <email> date".
+ */
 void pp_user_info(struct pretty_print_context *pp, const char *what,
 			struct strbuf *sb, const char *line,
 			const char *encoding);
+
+/*
+ * Format title line of commit message taken from "msg_p" and
+ * put it into "sb".
+ * First line of "msg_p" is also affected.
+ */
 void pp_title_line(struct pretty_print_context *pp, const char **msg_p,
 			struct strbuf *sb, const char *encoding,
 			int need_8bit_cte);
+
+/*
+ * Get current state of commit message from "msg_p" and continue formatting
+ * by adding indentation and '>' signs. Put result into "sb".
+ */
 void pp_remainder(struct pretty_print_context *pp, const char **msg_p,
 			struct strbuf *sb, int indent);
 
+/*
+ * Create a text message about commit using given "format" and "context".
+ * Put the result to "sb".
+ * Please use this function for custom formats.
+ */
 void format_commit_message(const struct commit *commit,
 			const char *format, struct strbuf *sb,
 			const struct pretty_print_context *context);
 
+/*
+ * Parse given arguments from "arg", check it for correctness and
+ * fill struct rev_info.
+ */
 void get_commit_format(const char *arg, struct rev_info *);
 
+/*
+ * Make a commit message with all rules from given "pp"
+ * and put it into "sb".
+ * Please use this function if you have a context (candidate for "pp").
+ */
 void pretty_print_commit(struct pretty_print_context *pp,
 			const struct commit *commit,
 			struct strbuf *sb);
 
+/*
+ * Change line breaks in "msg" to "line_separator" and put it into "sb".
+ * Return "msg" itself.
+ */
 const char *format_subject(struct strbuf *sb, const char *msg,
 			const char *line_separator);
 
+/* Check if "cmit_fmt" will produce an empty output. */
 int commit_format_is_empty(enum cmit_fmt);
 
 #endif /* PRETTY_H */

--
https://github.com/git/git/pull/439
