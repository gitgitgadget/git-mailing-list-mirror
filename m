Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 300571F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752411AbeBFAdA (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:33:00 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41880 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752331AbeBFAc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:32:56 -0500
Received: by mail-pl0-f67.google.com with SMTP id k8so136754pli.8
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KkTipXxket9djzyjS2dfr6bbHdzxeZU+CVu13KEMQ04=;
        b=p4f6LwcGzICDEnm8yfeTN5F8KBDBMyNBu9nVdNr7biEOcOCju+8Q/xqFiRvj60eylm
         oAzxBLnkCnw/JO8VKsovBMxfY1Gfzib+0dBMeBEJqmO3HXxev+JFo7sSGPPuYfj3RQW4
         6XZgleLPWYDPzeS/tvDihNrt3wNyCJ60HmjQHB06B8fg0NLf4MsT1lBMO3w43EJyZc1R
         WneZ0IGXNTTruHaAMy3Pg5Uxh8JUKMtXkkw2BejsEDROzdMLTAHfeBtJtu5lgkaXkUuL
         VMmGkfbkmeGahBgmzMOaPugjbtKHncSRPWNLnbO+6XnChiN4k84nA8Wdn6YJtVrtHGLD
         IXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KkTipXxket9djzyjS2dfr6bbHdzxeZU+CVu13KEMQ04=;
        b=GkooKPNrzK/U/sHI9jSkdXrd1fzB95z80bZvjnh2kGfHTpDm+BT7MW724ObBTvL4pT
         +mguqtIU8r5u8SLM0oVN/tf38a31HikNrCVxFmnhKyk0B+sm1dJ0myEuRxh2325S58gg
         fUzmgT9934NZ9OVe3IO4dLdWHTU/DAIo2DbKng5SE6xKz/2Dt2KaJAyplc8FqETAR7Nu
         ft4DGUl3RRrrVnyQK5lcRTV0wYDQQuSAGtMmOVkkRKEon2FyZpr1WkLFUmDMTqRxq0KO
         Ba9wghwnTLW6jNyr7aNPq/EOKwPTvgI30YD7NsLe76iUXYC2Aj204oipzB0+bnYVMce2
         yuOQ==
X-Gm-Message-State: APf1xPCeNazu737QH3ZshP8J66/5wVqCbd6MxfmiG9gpo+WwMFcTVDt6
        mBng7e7v9NcEVsOlRW9wW0rqegHE4lI=
X-Google-Smtp-Source: AH8x225Q6AdMQs5Te7gbAEy5FKfIQ9N8ywlaArNa8LF2/cEq0wRQV3aa1fwwhBdhHIM2yc2ls9PopA==
X-Received: by 2002:a17:902:7892:: with SMTP id q18-v6mr593750pll.232.1517877175746;
        Mon, 05 Feb 2018 16:32:55 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id q65sm23178785pfj.148.2018.02.05.16.32.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:32:55 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 194/194] submodule: use submodule repos for object lookup
Date:   Mon,  5 Feb 2018 16:17:49 -0800
Message-Id: <20180206001749.218943-96-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This converts the 'show_submodule_header' function to use
the repository API properly, such that the submodule objects
are not added to the main object store.

When using the inline diff of submodules, the object store is not
polluted with objects from the submodules. When using the "log"
summary, we still have to pollute the object store, as the
revision walking is not converted yet.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/submodule.c b/submodule.c
index 6b6c5a6710..9bd337ce99 100644
--- a/submodule.c
+++ b/submodule.c
@@ -441,19 +441,19 @@ static int prepare_submodule_summary(struct rev_info *rev, const char *path,
 	return prepare_revision_walk(rev);
 }
 
-#define print_submodule_summary(r, rev, o) print_submodule_summary_##r(rev, o)
-static void print_submodule_summary_the_repository(struct rev_info *rev, struct diff_options *o)
+static void print_submodule_summary(struct repository *r, struct rev_info *rev, struct diff_options *o)
 {
 	static const char format[] = "  %m %s";
 	struct strbuf sb = STRBUF_INIT;
 	struct commit *commit;
 
+	/* NEEDSWORK: get_revision is not adapted to repository handling? */
 	while ((commit = get_revision(rev))) {
 		struct pretty_print_context ctx = {0};
 		ctx.date_mode = rev->date_mode;
 		ctx.output_encoding = get_log_output_encoding();
 		strbuf_setlen(&sb, 0);
-		format_commit_message(the_repository, commit, format, &sb,
+		format_commit_message(r, commit, format, &sb,
 				      &ctx);
 		strbuf_addch(&sb, '\n');
 		if (commit->object.flags & SYMMETRIC_LEFT)
@@ -513,7 +513,8 @@ static int open_submodule(struct repository *out, const char *path)
  * attempt to lookup both the left and right commits and put them into the
  * left and right pointers.
  */
-static void show_submodule_header(struct diff_options *o, const char *path,
+static void show_submodule_header(struct diff_options *o, struct repository *sub,
+		const char *path,
 		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule,
 		struct commit **left, struct commit **right,
@@ -534,7 +535,7 @@ static void show_submodule_header(struct diff_options *o, const char *path,
 	else if (is_null_oid(two))
 		message = "(submodule deleted)";
 
-	if (add_submodule_odb(path)) {
+	if (open_submodule(sub, path) < 0) {
 		if (!message)
 			message = "(commits not present)";
 		goto output_header;
@@ -544,8 +545,8 @@ static void show_submodule_header(struct diff_options *o, const char *path,
 	 * Attempt to lookup the commit references, and determine if this is
 	 * a fast forward or fast backwards update.
 	 */
-	*left = lookup_commit_reference(the_repository, one);
-	*right = lookup_commit_reference(the_repository, two);
+	*left = lookup_commit_reference(sub, one);
+	*right = lookup_commit_reference(sub, two);
 
 	/*
 	 * Warn about missing commits in the submodule project, but only if
@@ -555,7 +556,7 @@ static void show_submodule_header(struct diff_options *o, const char *path,
 	     (!is_null_oid(two) && !*right))
 		message = "(commits not present)";
 
-	*merge_bases = get_merge_bases(the_repository, *left, *right);
+	*merge_bases = get_merge_bases(sub, *left, *right);
 	if (*merge_bases) {
 		if ((*merge_bases)->item == *left)
 			fast_forward = 1;
@@ -589,8 +590,9 @@ void show_submodule_summary(struct diff_options *o, const char *path,
 	struct rev_info rev;
 	struct commit *left = NULL, *right = NULL;
 	struct commit_list *merge_bases = NULL;
+	struct repository sub;
 
-	show_submodule_header(o, path, one, two, dirty_submodule,
+	show_submodule_header(o, &sub, path, one, two, dirty_submodule,
 			      &left, &right, &merge_bases);
 
 	/*
@@ -607,7 +609,7 @@ void show_submodule_summary(struct diff_options *o, const char *path,
 		goto out;
 	}
 
-	print_submodule_summary(the_repository, &rev, o);
+	print_submodule_summary(&sub, &rev, o);
 
 out:
 	if (merge_bases)
@@ -625,8 +627,9 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
 	struct commit_list *merge_bases = NULL;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf sb = STRBUF_INIT;
+	struct repository sub;
 
-	show_submodule_header(o, path, one, two, dirty_submodule,
+	show_submodule_header(o, &sub, path, one, two, dirty_submodule,
 			      &left, &right, &merge_bases);
 
 	/* We need a valid left and right commit to display a difference */
-- 
2.15.1.433.g936d1b9894.dirty

