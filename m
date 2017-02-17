Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEBAA20136
	for <e@80x24.org>; Fri, 17 Feb 2017 14:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934423AbdBQOUV (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 09:20:21 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33975 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934098AbdBQOUU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 09:20:20 -0500
Received: by mail-pf0-f193.google.com with SMTP id o64so4213107pfb.1
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 06:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ga+AQFp8B2XxnYk1BYKIh4OyeAwQhhDWoHEbm0tSc1M=;
        b=G2lZ5fejFE6ZCSksVGXI1JzuDkG6dXKEnJKqzQdNpIPpgM9fmu/6aQ3hobPt7h7Cux
         oidL8hX+R7SFU9RVZBtjFZpUUH16t8ZedINV0iboTOosVkk2GZwCHe4WPwMtMaHbeGAN
         txx4nj3MgmTApHyuWpKkqwhW02qK9O25Tap65tzKT5ob2L6Be1AtH6DQErg5WIfxODLa
         iRBsqjLJ/k2FORzNYDsGnvvyCyJlhhkNiUEnorqul0lVyT+kqEHMT6pH0bvsESwAgtfo
         8gaupTkVwNxDTAl1u7K1ZFTaAuY3Bor+1uPSujZvmwbDyOjZ6nkHfv+5I3QY9ysyNOjR
         R7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ga+AQFp8B2XxnYk1BYKIh4OyeAwQhhDWoHEbm0tSc1M=;
        b=WEnxOUW/5fRonymHM9UU9MZHw6q0WRopxDJalRpXs8yVKvbZeoXmDIyr6V/DQr0xYk
         4vNujRZdZTwOycH8er3P30bhSHLMtQuOqy2/IZQj4ldbbBMfT0jaW0bLP0BOGwV+O0Di
         VvscXcj5rDXHE87aH/cedn9quXYamRxh3y4k+RHpwr6R+QUj86/Hj6MqEWDTQ6nId7N5
         ZeZbWJvI5sIAPuAuhno3m6+AhGDJ3n2beCb8fYdo6xg26KnIGeWqCySSJg0MHm/aOWLs
         3jtFSXyea+VBtVdhTLqYm3ez9Z9pYhi+S3AiJzLovuacHFtAnNuCcdqr6Jo5jWu7XjT/
         9I4A==
X-Gm-Message-State: AMke39kJogCoW/1N00V4d4oW90KTw11Vj6aBVCTL3tt5uzNolTb4plnBmVKB/ifpJ8AS9w==
X-Received: by 10.84.137.37 with SMTP id 34mr11639685plm.29.1487341219210;
        Fri, 17 Feb 2017 06:20:19 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id 82sm20212576pge.42.2017.02.17.06.20.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 06:20:18 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 17 Feb 2017 21:20:14 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 09/15] revision.c: use refs_for_each*() instead of for_each_*_submodule()
Date:   Fri, 17 Feb 2017 21:19:02 +0700
Message-Id: <20170217141908.18012-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170217141908.18012-1-pclouds@gmail.com>
References: <20170217141908.18012-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.c | 48 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/revision.c b/revision.c
index d82f72ff3..d82c37b44 100644
--- a/revision.c
+++ b/revision.c
@@ -1189,12 +1189,19 @@ void add_ref_exclusion(struct string_list **ref_excludes_p, const char *exclude)
 	string_list_append(*ref_excludes_p, exclude);
 }
 
-static void handle_refs(const char *submodule, struct rev_info *revs, unsigned flags,
-		int (*for_each)(const char *, each_ref_fn, void *))
+static void handle_refs(struct ref_store *refs,
+			struct rev_info *revs, unsigned flags,
+			int (*for_each)(struct ref_store *, each_ref_fn, void *))
 {
 	struct all_refs_cb cb;
+
+	if (!refs) {
+		/* this could happen with uninitialized submodules */
+		return;
+	}
+
 	init_all_refs_cb(&cb, revs, flags);
-	for_each(submodule, handle_one_ref, &cb);
+	for_each(refs, handle_one_ref, &cb);
 }
 
 static void handle_one_reflog_commit(unsigned char *sha1, void *cb_data)
@@ -2067,23 +2074,25 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 	ctx->argc -= n;
 }
 
-static int for_each_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data, const char *term) {
+static int for_each_bisect_ref(struct ref_store *refs, each_ref_fn fn,
+			       void *cb_data, const char *term)
+{
 	struct strbuf bisect_refs = STRBUF_INIT;
 	int status;
 	strbuf_addf(&bisect_refs, "refs/bisect/%s", term);
-	status = for_each_ref_in_submodule(submodule, bisect_refs.buf, fn, cb_data);
+	status = refs_for_each_ref_in(refs, bisect_refs.buf, fn, cb_data);
 	strbuf_release(&bisect_refs);
 	return status;
 }
 
-static int for_each_bad_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
+static int for_each_bad_bisect_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
-	return for_each_bisect_ref(submodule, fn, cb_data, term_bad);
+	return for_each_bisect_ref(refs, fn, cb_data, term_bad);
 }
 
-static int for_each_good_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
+static int for_each_good_bisect_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
-	return for_each_bisect_ref(submodule, fn, cb_data, term_good);
+	return for_each_bisect_ref(refs, fn, cb_data, term_good);
 }
 
 static int handle_revision_pseudo_opt(const char *submodule,
@@ -2092,8 +2101,14 @@ static int handle_revision_pseudo_opt(const char *submodule,
 {
 	const char *arg = argv[0];
 	const char *optarg;
+	struct ref_store *refs;
 	int argcount;
 
+	if (submodule) {
+		refs = get_submodule_ref_store(submodule);
+	} else
+		refs = get_main_ref_store();
+
 	/*
 	 * NOTE!
 	 *
@@ -2105,22 +2120,23 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	 * register it in the list at the top of handle_revision_opt.
 	 */
 	if (!strcmp(arg, "--all")) {
-		handle_refs(submodule, revs, *flags, for_each_ref_submodule);
-		handle_refs(submodule, revs, *flags, head_ref_submodule);
+		handle_refs(refs, revs, *flags, refs_for_each_ref);
+		handle_refs(refs, revs, *flags, refs_head_ref);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--branches")) {
-		handle_refs(submodule, revs, *flags, for_each_branch_ref_submodule);
+		handle_refs(refs, revs, *flags, refs_for_each_branch_ref);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--bisect")) {
 		read_bisect_terms(&term_bad, &term_good);
-		handle_refs(submodule, revs, *flags, for_each_bad_bisect_ref);
-		handle_refs(submodule, revs, *flags ^ (UNINTERESTING | BOTTOM), for_each_good_bisect_ref);
+		handle_refs(refs, revs, *flags, for_each_bad_bisect_ref);
+		handle_refs(refs, revs, *flags ^ (UNINTERESTING | BOTTOM),
+			    for_each_good_bisect_ref);
 		revs->bisect = 1;
 	} else if (!strcmp(arg, "--tags")) {
-		handle_refs(submodule, revs, *flags, for_each_tag_ref_submodule);
+		handle_refs(refs, revs, *flags, refs_for_each_tag_ref);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--remotes")) {
-		handle_refs(submodule, revs, *flags, for_each_remote_ref_submodule);
+		handle_refs(refs, revs, *flags, refs_for_each_remote_ref);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if ((argcount = parse_long_opt("glob", argv, &optarg))) {
 		struct all_refs_cb cb;
-- 
2.11.0.157.gd943d85

