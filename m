Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07DFC20899
	for <e@80x24.org>; Wed, 23 Aug 2017 12:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754040AbdHWMiM (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 08:38:12 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35335 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753834AbdHWMiL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 08:38:11 -0400
Received: by mail-pg0-f65.google.com with SMTP id m133so1399116pga.2
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 05:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GqyQhwVSc51XGAP2v5t9N1Z6SSU15nWGVHz2anNwakI=;
        b=rZ1FBc1Ra54VwYct5Fokj2HlejZfUXQX0oifw27HSLjjt8o5FQQ+WdgcenH83tuREB
         dHInKnZsN3Dczu8Qr0xvseKJ2VBjh7u3xlVn/CHPhtwDGvUdPqQ/ibAJMVG5H43gU2Z8
         ddARJ0XWABdk4JuaBUk0j2Ot4QS2BMkSTtWmy4cBUYI6J9yZ+TBswEVY4YUOBuc4snZE
         1JX1HJLXIlwjze2X9ussJw3HSMtKN7dmJloPAwqtkPqzZeeqgG8jWLbucq8fXXQ/mMj7
         4089YA5olZ59/VqACpGos5qxTHprVcQ8IbpsbhpcQKqHbIm7Xky+XFR7/0nBKkpUUTXa
         Ph6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GqyQhwVSc51XGAP2v5t9N1Z6SSU15nWGVHz2anNwakI=;
        b=TuEQkv2j1/FQYI9a4E9fm3Pdc0n985rIl1kr2+dT+uBVw3ANfz05eiMO5CgTe2ED5C
         xiWGFaPw5tS3yDZh/PLRNwJYz1hQuRkiWJHHC0xYx9Z/qMrHDVI3gxh3d6lX52tLJlyI
         62hSALrSBZFcJ5B9HzwxSEZUPr1nwBJ6vUQehMqjITj5AQGTEZEv+5B8ua/638vAQTin
         VsYg4qkFmBcuhwp03OQMVJ4SLgTjIT4XOR4sR+uIuNePhq4VCV23Q+WMblbzy/qH2LJ+
         Qh7G59IeKUPZrnyzcu0X9U5HfwXpi08hUSNiMkhYqvhy7U/J3XfuBzc1CLBWW8j6sUQv
         O1HQ==
X-Gm-Message-State: AHYfb5guL2X7OoxvfnG8wbc7sQTsGNZH/aJnDX3+TZJCmZZuPxrNJxs7
        kXzK0++92R/KR+/0
X-Received: by 10.84.209.165 with SMTP id y34mr2850788plh.396.1503491890436;
        Wed, 23 Aug 2017 05:38:10 -0700 (PDT)
Received: from ash ([115.72.183.215])
        by smtp.gmail.com with ESMTPSA id p10sm3454269pfk.103.2017.08.23.05.38.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Aug 2017 05:38:09 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 23 Aug 2017 19:38:04 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 08/16] revision.c: use refs_for_each*() instead of for_each_*_submodule()
Date:   Wed, 23 Aug 2017 19:36:56 +0700
Message-Id: <20170823123704.16518-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170823123704.16518-1-pclouds@gmail.com>
References: <20170823123704.16518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c     |  9 ++++-----
 refs.h     |  6 +++---
 revision.c | 48 ++++++++++++++++++++++++++++++++----------------
 3 files changed, 39 insertions(+), 24 deletions(-)

diff --git a/refs.c b/refs.c
index b3a0a24469..cd61509bc8 100644
--- a/refs.c
+++ b/refs.c
@@ -1362,16 +1362,15 @@ int for_each_ref_in_submodule(const char *submodule, const char *prefix,
 				    prefix, fn, cb_data);
 }
 
-int for_each_fullref_in_submodule(const char *submodule, const char *prefix,
-				  each_ref_fn fn, void *cb_data,
-				  unsigned int broken)
+int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
+			     each_ref_fn fn, void *cb_data,
+			     unsigned int broken)
 {
 	unsigned int flag = 0;
 
 	if (broken)
 		flag = DO_FOR_EACH_INCLUDE_BROKEN;
-	return do_for_each_ref(get_submodule_ref_store(submodule),
-			       prefix, fn, 0, flag, cb_data);
+	return do_for_each_ref(refs, prefix, fn, 0, flag, cb_data);
 }
 
 int for_each_replace_ref(each_ref_fn fn, void *cb_data)
diff --git a/refs.h b/refs.h
index 8073f8ab56..a8d6f33703 100644
--- a/refs.h
+++ b/refs.h
@@ -291,6 +291,9 @@ int refs_for_each_remote_ref(struct ref_store *refs,
 int head_ref(each_ref_fn fn, void *cb_data);
 int for_each_ref(each_ref_fn fn, void *cb_data);
 int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data);
+int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
+			     each_ref_fn fn, void *cb_data,
+			     unsigned int broken);
 int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
 			unsigned int broken);
 int for_each_tag_ref(each_ref_fn fn, void *cb_data);
@@ -306,9 +309,6 @@ int for_each_ref_submodule(const char *submodule,
 			   each_ref_fn fn, void *cb_data);
 int for_each_ref_in_submodule(const char *submodule, const char *prefix,
 			      each_ref_fn fn, void *cb_data);
-int for_each_fullref_in_submodule(const char *submodule, const char *prefix,
-				  each_ref_fn fn, void *cb_data,
-				  unsigned int broken);
 int for_each_tag_ref_submodule(const char *submodule,
 			       each_ref_fn fn, void *cb_data);
 int for_each_branch_ref_submodule(const char *submodule,
diff --git a/revision.c b/revision.c
index f35cb49af5..8d04516266 100644
--- a/revision.c
+++ b/revision.c
@@ -1188,12 +1188,19 @@ void add_ref_exclusion(struct string_list **ref_excludes_p, const char *exclude)
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
 
 static void handle_one_reflog_commit(struct object_id *oid, void *cb_data)
@@ -2095,23 +2102,25 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 	ctx->argc -= n;
 }
 
-static int for_each_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data, const char *term) {
+static int for_each_bisect_ref(struct ref_store *refs, each_ref_fn fn,
+			       void *cb_data, const char *term)
+{
 	struct strbuf bisect_refs = STRBUF_INIT;
 	int status;
 	strbuf_addf(&bisect_refs, "refs/bisect/%s", term);
-	status = for_each_fullref_in_submodule(submodule, bisect_refs.buf, fn, cb_data, 0);
+	status = refs_for_each_fullref_in(refs, bisect_refs.buf, fn, cb_data, 0);
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
@@ -2120,8 +2129,14 @@ static int handle_revision_pseudo_opt(const char *submodule,
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
@@ -2133,22 +2148,23 @@ static int handle_revision_pseudo_opt(const char *submodule,
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

