Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC5CC433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 04:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14AB82251F
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 04:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbhAEEoi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 23:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbhAEEoa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 23:44:30 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECC4C0617A6
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 20:43:17 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id t30so34910294wrb.0
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 20:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y8LiKrnf+O++nvf7DjK19abFAOnRB5WPkCBFP+JWfRg=;
        b=V0nKyCsTOIzCQRYJp3d9rOWm93uTA0MC8bMZHPACgoaWAYqmkYG7G/G94pLMR7SZdg
         XdrmvMuqP3zWAeYTzyODgiI6qVWA9oZHAPvYwVX+tkSShSGxlIdoYloOJKJJF09LteEt
         LCcDZ0+boA0nOaBoJDy9Ksy4aaDgl1WAG3vh3YiupSxQEQPqrkMLWKSu69ET6weccKPi
         m2mcrxGPnx9VbdezVg7R6qf5/wfJFC8wI8pkRF3Rc2h6mv6z09T7SxZl/MNdFywto9SN
         kvHTfiR53NomCYE2NMc8wFaaSQrZkiJB6MKULa9QJesB5YZk+wEEfpbNdDHsKFLFwKKM
         tpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=y8LiKrnf+O++nvf7DjK19abFAOnRB5WPkCBFP+JWfRg=;
        b=ndHkvrns1AaMxPkJBF87Tpy3WinCV9qASZp1m95RWj9nrJCsr9PfqnS80DkuRkYgcS
         BGstZdTdC9PmPbA2wROjkyeF9Dsebw74FWSU+e+vrdNohylNHHgJ7r4X73lu1sBBjGAP
         XoO6/AC5GPKW2lsyVR+jX4wkM/I4/HYYpM+u6pzICR3imCUF2WgGQOOjF0TypAAeAPhr
         /TPpIosJjxT3rxuA4IJfIwc7Lempb7ZF24rwiYtt2cWUs33Gs/hThbCVaXU4mU+050ma
         V5RDILSnd9h/ajamgRq9iiUIdoKQhJI7esyYYFekslOO/qkJK7gxjRQJxvywnvfdJc+l
         BYxg==
X-Gm-Message-State: AOAM532bKQVfcmIpZ9xuqv7MXagZPAcAX1ldplpjZ5D4ky4N67sXCmif
        XoiTbeIKP74LN626wXOY14KlrS5372s=
X-Google-Smtp-Source: ABdhPJyDFZJlj3ZuDXbX6whNB5kYcSTV8foivSc6jditHVTMiqYb9xDN0SE/8wKP9UcPlvkCIURmAw==
X-Received: by 2002:a5d:6209:: with SMTP id y9mr82254063wru.197.1609821796278;
        Mon, 04 Jan 2021 20:43:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m11sm2271596wmi.16.2021.01.04.20.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 20:43:15 -0800 (PST)
Message-Id: <457402b4fdcab4b2d390733d1d5cc9174a318e89.1609821783.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
        <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Jan 2021 04:43:02 +0000
Subject: [PATCH v2 13/14] update-index: reduce static globals, part 2
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In order to remove index compatibility macros cleanly, we relied upon
static globals 'repo' and 'istate' to be pointers to the_repository and
the_index, respectively. We can continue reducing the need for these
static globals by modifying method prototypes to use them when
necessary.

Move these static globals further down the file so we can identify which
methods need both 'struct repository *repo' and 'struct index_state
*istate' parameters. The only changes included here adjust method
prototypes and their call locations.

The only remaining change is to remove the static globals entirely, but
that requires updating the parse-opt callbacks, which need a different
solution.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/update-index.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 6b585fb8ede..fb8d7879783 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -594,10 +594,9 @@ static const char * const update_index_usage[] = {
 static struct object_id head_oid;
 static struct object_id merge_head_oid;
 
-static struct repository *repo;
-static struct index_state *istate;
-
-static struct cache_entry *read_one_ent(const char *which,
+static struct cache_entry *read_one_ent(struct repository *repo,
+					struct index_state *istate,
+					const char *which,
 					struct object_id *ent, const char *path,
 					int namelen, int stage)
 {
@@ -625,7 +624,9 @@ static struct cache_entry *read_one_ent(const char *which,
 	return ce;
 }
 
-static int unresolve_one(const char *path)
+static int unresolve_one(struct repository *repo,
+			 struct index_state *istate,
+			 const char *path)
 {
 	int namelen = strlen(path);
 	int pos;
@@ -667,8 +668,8 @@ static int unresolve_one(const char *path)
 	 * stuff HEAD version in stage #2,
 	 * stuff MERGE_HEAD version in stage #3.
 	 */
-	ce_2 = read_one_ent("our", &head_oid, path, namelen, 2);
-	ce_3 = read_one_ent("their", &merge_head_oid, path, namelen, 3);
+	ce_2 = read_one_ent(repo, istate, "our", &head_oid, path, namelen, 2);
+	ce_3 = read_one_ent(repo, istate, "their", &merge_head_oid, path, namelen, 3);
 
 	if (!ce_2 || !ce_3) {
 		ret = -1;
@@ -707,7 +708,9 @@ static void read_head_pointers(void)
 	}
 }
 
-static int do_unresolve(int ac, const char **av,
+static int do_unresolve(struct repository *repo,
+			struct index_state *istate,
+			int ac, const char **av,
 			const char *prefix, int prefix_length)
 {
 	int i;
@@ -721,13 +724,15 @@ static int do_unresolve(int ac, const char **av,
 	for (i = 1; i < ac; i++) {
 		const char *arg = av[i];
 		char *p = prefix_path(prefix, prefix_length, arg);
-		err |= unresolve_one(p);
+		err |= unresolve_one(repo, istate, p);
 		free(p);
 	}
 	return err;
 }
 
-static int do_reupdate(int ac, const char **av,
+static int do_reupdate(struct repository *repo,
+		       struct index_state *istate,
+		       int ac, const char **av,
 		       const char *prefix)
 {
 	/* Read HEAD and run update-index on paths that are
@@ -756,7 +761,7 @@ static int do_reupdate(int ac, const char **av,
 		if (ce_stage(ce) || !ce_path_match(istate, ce, &pathspec, NULL))
 			continue;
 		if (has_head)
-			old = read_one_ent(NULL, &head_oid,
+			old = read_one_ent(repo, istate, NULL, &head_oid,
 					   ce->name, ce_namelen(ce), 0);
 		if (old && ce->ce_mode == old->ce_mode &&
 		    oideq(&ce->oid, &old->oid)) {
@@ -784,6 +789,9 @@ struct refresh_params {
 	int *has_errors;
 };
 
+static struct repository *repo;
+static struct index_state *istate;
+
 static int refresh(struct refresh_params *o, unsigned int flag)
 {
 	setup_work_tree();
@@ -923,8 +931,8 @@ static enum parse_opt_result unresolve_callback(
 	BUG_ON_OPT_ARG(arg);
 
 	/* consume remaining arguments. */
-	*has_errors = do_unresolve(ctx->argc, ctx->argv,
-				prefix, prefix ? strlen(prefix) : 0);
+	*has_errors = do_unresolve(repo, istate, ctx->argc, ctx->argv,
+				   prefix, prefix ? strlen(prefix) : 0);
 	if (*has_errors)
 		istate->cache_changed = 0;
 
@@ -945,7 +953,7 @@ static enum parse_opt_result reupdate_callback(
 
 	/* consume remaining arguments. */
 	setup_work_tree();
-	*has_errors = do_reupdate(ctx->argc, ctx->argv, prefix);
+	*has_errors = do_reupdate(repo, istate, ctx->argc, ctx->argv, prefix);
 	if (*has_errors)
 		istate->cache_changed = 0;
 
-- 
gitgitgadget

