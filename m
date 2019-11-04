Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 531631F454
	for <e@80x24.org>; Mon,  4 Nov 2019 20:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbfKDUED (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 15:04:03 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47052 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729091AbfKDUED (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 15:04:03 -0500
Received: by mail-pg1-f195.google.com with SMTP id f19so12112422pgn.13
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 12:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ogf9U6bXxjS7eoP2MYn2/FzoYyB0bsV/jjc0VrS5wfc=;
        b=DBLM2GHpAizPMnpu6InylDa5oJqJJR1p3FGSiIGXBq16suhl7dusogiBssgEjhdSw4
         pz7cL27qncKpHTDPblCzJHHk1RVG2Ctb3AVb2II4QxU4xrKCWBIMd9yun8f4CeQjj2xv
         EIFFD+OEQ6ALCDkKp3hYEPD0wLWTPAmV/8v5fiybDtVHaEdXRmwJCLIAP30ULlN0hkF8
         /Ja84NOiQbCITZYxSjge2CUXoi3yGT0KaP1X56AvyYTrRoEiIZs6G6DM5g+W+lIncEIL
         BR5HmySGII84QUsRQwmqJBlJ3uYpZc0KBbscVseXFxUjUeK4VWJ5liNG1gk/rwqiBjUw
         0MIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ogf9U6bXxjS7eoP2MYn2/FzoYyB0bsV/jjc0VrS5wfc=;
        b=IjyzGHgJqrFLFk0OdRu8JDyAazTDqqG6yPrmGzTYmmXhxGYXyh6KaOCnGKmEUO3yOB
         nt4I9utgAcMJrxmjYFyvmpjYUlwJq+/YWx+A2lB3UAJYwoyUoL7GuPNwDu54LhIt34Lg
         mYcDQvSGypiptPf4c91SzrfZMxOVsU35FIB8SgfzVjDuPo5mOmcWL5J1RlRQ9sLIdzr3
         XRaYVxGzSbzp0wOfhUGkIMdG+hj46MvE2wMPxkTm9ZBI6Z5JK5VkdZ6ZqZcW4Rkpeo4A
         oTDc7wGfWUS1f5iDSN8FnkWBy1w+u/BQSHuZpYNaqg+8mPWewYzlacpwq1Umt6D4OcJ+
         ZAww==
X-Gm-Message-State: APjAAAWcvm+xxOstFyym0TrwZH7OLuiriPQlhTasaS9NGbpaQlBgS1Aj
        MH+/cCsH8BYVVScnaY4snxSFRlmC
X-Google-Smtp-Source: APXvYqzoHIR2KE2p1FQo/5JJBkaemFRM0Jj/JrgiJimQh4/aRiKka7IvkhdsWVe83IdP5MwDMMhp9g==
X-Received: by 2002:a63:ae02:: with SMTP id q2mr32688338pgf.210.1572897841003;
        Mon, 04 Nov 2019 12:04:01 -0800 (PST)
Received: from generichostname ([204.14.236.210])
        by smtp.gmail.com with ESMTPSA id s24sm5828884pfh.108.2019.11.04.12.04.00
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 12:04:00 -0800 (PST)
Date:   Mon, 4 Nov 2019 15:03:58 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 5/8] pretty.c: extract functionality to
 repo_format_commit_generic()
Message-ID: <e54b8ef8779b2cafd2aba45074f1b6680f4d7221.1572897736.git.liu.denton@gmail.com>
References: <cover.1572897736.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572897736.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future commit, we will be reusing common functionality from
repo_format_commit_message(). Extract this common functionality into
repo_format_commit_generic() so that it can be reused in the future.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 pretty.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/pretty.c b/pretty.c
index 6f2b0ad917..a6e5fc115a 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1605,10 +1605,14 @@ void userformat_find_requirements(const char *fmt, struct userformat_want *w)
 	strbuf_release(&dummy);
 }
 
-void repo_format_commit_message(struct repository *r,
-				const struct commit *commit,
-				const char *format, struct strbuf *sb,
-				const struct pretty_print_context *pretty_ctx)
+static void repo_format_commit_generic(struct repository *r,
+				       const struct commit *commit,
+				       struct strbuf *sb,
+				       const struct pretty_print_context *pretty_ctx,
+				       void (*fn)(struct strbuf *,
+						  struct format_commit_context *,
+						  void *),
+				       void *data)
 {
 	struct format_commit_context context = {
 		.commit = commit,
@@ -1625,9 +1629,7 @@ void repo_format_commit_message(struct repository *r,
 					       &context.commit_encoding,
 					       utf8);
 
-	context.wrap_start = sb->len;
-	strbuf_expand(sb, format, format_commit_item, &context);
-	rewrap_message_tail(sb, &context, 0, 0, 0);
+	fn(sb, &context, data);
 
 	/* then convert a commit message to an actual output encoding */
 	if (output_enc) {
@@ -1651,6 +1653,25 @@ void repo_format_commit_message(struct repository *r,
 	repo_unuse_commit_buffer(r, commit, context.message);
 }
 
+static void do_repo_format_commit_message(struct strbuf *sb,
+					  struct format_commit_context *context,
+					  void *data)
+{
+	const char *format = data;
+	context->wrap_start = sb->len;
+	strbuf_expand(sb, format, format_commit_item, context);
+	rewrap_message_tail(sb, context, 0, 0, 0);
+}
+
+void repo_format_commit_message(struct repository *r,
+				const struct commit *commit,
+				const char *format, struct strbuf *sb,
+				const struct pretty_print_context *pretty_ctx)
+{
+	repo_format_commit_generic(r, commit, sb, pretty_ctx,
+				   do_repo_format_commit_message, (void *)format);
+}
+
 static void pp_header(struct pretty_print_context *pp,
 		      const char *encoding,
 		      const struct commit *commit,
-- 
2.24.0.rc2.262.g2d07a97ef5

