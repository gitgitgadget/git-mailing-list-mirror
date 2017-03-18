Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E44B120323
	for <e@80x24.org>; Sat, 18 Mar 2017 10:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751272AbdCRKnS (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 06:43:18 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33690 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbdCRKnR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 06:43:17 -0400
Received: by mail-pg0-f68.google.com with SMTP id 79so4467131pgf.0
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 03:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nQWRlT9TMtxMuoLvd4v0siq/DXjZY6sSoJTAmPjp5K4=;
        b=TD3x56aywqrKGkxcIUOHHauAqQphYVRRbLKGH0pf7R+ayVFbIRXj6j/zxaji5q0Ljy
         20oiWR7lBmau88V/vR0/b/9esuC1Wsy9JEtoRXjQvtEC7DCNyCxBwxTxdEJxnlhH8ia4
         rn/C+qBUSTRCur6L3i0EiLWvUYcl9zwmzdeRnqd4FlgDtGKj/2SrK1RiK3r6lmCPUrxx
         2CT194ZNS70guYy488BuhEnHXbbRtgTaT9Hy68SFQvGPVx/VwzcSbpYMxPkqUtPawGAk
         yIcd9y7pLO6+bp0fNftlQ9C066yYcqrlGeap/k0ZvNOb3+IZBbjiAqYWi43Jwlkl1rKa
         /4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nQWRlT9TMtxMuoLvd4v0siq/DXjZY6sSoJTAmPjp5K4=;
        b=bjjbAK9uhdgsrhZ5QZqWgbExdUJLa582rwXTxvYgc5U20SuYViyh4pDfhwrOqqalhP
         s7uHNb3q+GtjImtqv0KJiSEA3FgugLmkWIOZLTMGENAUfQ/FtAZ6ojUWegdzWGz2elV5
         4GYL5e6dLlCoF8H8Yh7eCcDmbmIOpm64hrw5FvftNOT9bz1ebQxbwpwXZZD+oYWi3Ni0
         LuTzwqcuqsgCRG+RwqCGpo9HJ9+ntX9K75p1iCrJ65I3/K1/h5GpJnlTmfHXfB3oDesd
         GnqicIlWZ0svoPWicShv2r0U2Wwd0B/bqkoycSlA/YqFUMNfCel0nG4Lu6v3q8ly2vf8
         f8pg==
X-Gm-Message-State: AFeK/H1rYJ16RxWZVZc1rVV+SArjXP9n9QCUyERnAEZDC4nr3tG6DsbXBSFGbKp0btO8sg==
X-Received: by 10.98.91.130 with SMTP id p124mr18939685pfb.165.1489831961054;
        Sat, 18 Mar 2017 03:12:41 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id z19sm6124164pfd.81.2017.03.18.03.12.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Mar 2017 03:12:40 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 17:12:35 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 07/12] revision.c: use refs_for_each*() instead of for_each_*_submodule()
Date:   Sat, 18 Mar 2017 17:11:48 +0700
Message-Id: <20170318101153.6901-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170318101153.6901-1-pclouds@gmail.com>
References: <20170217141908.18012-1-pclouds@gmail.com>
 <20170318101153.6901-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 revision.c | 48 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/revision.c b/revision.c
index db8021ed26..da19071960 100644
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
 
 static void handle_one_reflog_commit(struct object_id *oid, void *cb_data)
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

