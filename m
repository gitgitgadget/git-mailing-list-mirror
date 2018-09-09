Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D27B1F404
	for <e@80x24.org>; Sun,  9 Sep 2018 08:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbeIINno (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 09:43:44 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:38312 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbeIINnm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 09:43:42 -0400
Received: by mail-lj1-f181.google.com with SMTP id p6-v6so15420682ljc.5
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 01:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Af/vWjDBpRFyaq/Iq7GbRk6cEiaX7klDznVyxZ8bQww=;
        b=TJwbDjnwedqwe49P3I+5+uYG9jlQx2T5XcHGfbVLqNpcvs998nL1hDmdazxH0GgC75
         IfpbQSNpaPmyzeJTncztE2/91EKxb1p1ZngKWHqHTfJqZ0nSEpPGlcFTkgK7jFTRD1Vm
         f5ODgn9Kd7cjqh/iO9PBkuXZd2zPPgriM8wye0Zdr0eKMP/VYj6Hfn3Q/t8xvAYwOZDq
         7rx04WijP/0jGEAzaugN2C5+BiI3lasOPCrUT0BbfMvncZ3rPw7LWMrHhYxaHRe+wxNN
         dVxYkyxZIhohCNXzehtp3B2LrSdR6AXS/+JU4TAihEukhmzHZTgLbJHc5aqoAZwfICKE
         m6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Af/vWjDBpRFyaq/Iq7GbRk6cEiaX7klDznVyxZ8bQww=;
        b=YL/WSsdXf01xH8ZjAwXWOgE2epa2LkbE45HXoXwSP9xFPrFC/0WjZzVJ6FSFnIyRFm
         82LTE0znOzYvae0Mjj+jJeRbJmqnEXdb5pzH5VsPMQTqFwDxy0FCS6KYnWPGJ8VYOLKh
         Q8TpFFqoDfaemIyqyzJiMGAaSkGc3jam30Yyh5JXPQn099BZgB0DiZgrDXDW3jQAJ2ci
         1yOy0jRJZ1JRKaiVDMrby7pHAvx3r/g8lH4R9Q4So7q4wTkgxePGcV4lm8jJBktr49Po
         QratfrvXXDL9bGUwl7JWPb6Z7T/ZGO7rlfIPqN/vikjUYS+Q9iO2ceqkZlSTm21uFGRR
         R2Jg==
X-Gm-Message-State: APzg51C6ErmM7HoO9DCibVIbApHjhMwauyyB10cbNuAXAnqlUKLrJt9N
        0it2YrycgxJId0X15W8V6Yo=
X-Google-Smtp-Source: ANB0VdaIw62PDC2RBF48dEJ5DVWg+O6yQA7b19AzEp9WTL5VoBektAl2dnDH2u1kwt+MZQoFZI4jYw==
X-Received: by 2002:a2e:6e04:: with SMTP id j4-v6mr9673199ljc.61.1536483283317;
        Sun, 09 Sep 2018 01:54:43 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g16-v6sm2102525lfb.5.2018.09.09.01.54.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 01:54:42 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 10/23] diff-lib.c: remove implicit dependency on the_index
Date:   Sun,  9 Sep 2018 10:54:05 +0200
Message-Id: <20180909085418.31531-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180909085418.31531-1-pclouds@gmail.com>
References: <20180903180932.32260-1-pclouds@gmail.com>
 <20180909085418.31531-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 diff-lib.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 88a98b1c06..c54773fe12 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -70,7 +70,7 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
 				     struct stat *st, unsigned ce_option,
 				     unsigned *dirty_submodule)
 {
-	int changed = ce_match_stat(ce, st, ce_option);
+	int changed = ie_match_stat(diffopt->repo->index, ce, st, ce_option);
 	if (S_ISGITLINK(ce->ce_mode)) {
 		struct diff_flags orig_flags = diffopt->flags;
 		if (!diffopt->flags.override_submodule_config)
@@ -93,15 +93,16 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 	unsigned ce_option = ((option & DIFF_RACY_IS_MODIFIED)
 			      ? CE_MATCH_RACY_IS_DIRTY : 0);
 	uint64_t start = getnanotime();
+	struct index_state *istate = revs->diffopt.repo->index;
 
 	diff_set_mnemonic_prefix(&revs->diffopt, "i/", "w/");
 
 	if (diff_unmerged_stage < 0)
 		diff_unmerged_stage = 2;
-	entries = active_nr;
+	entries = istate->cache_nr;
 	for (i = 0; i < entries; i++) {
 		unsigned int oldmode, newmode;
-		struct cache_entry *ce = active_cache[i];
+		struct cache_entry *ce = istate->cache[i];
 		int changed;
 		unsigned dirty_submodule = 0;
 		const struct object_id *old_oid, *new_oid;
@@ -109,7 +110,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		if (diff_can_quit_early(&revs->diffopt))
 			break;
 
-		if (!ce_path_match(&the_index, ce, &revs->prune_data, NULL))
+		if (!ce_path_match(istate, ce, &revs->prune_data, NULL))
 			continue;
 
 		if (ce_stage(ce)) {
@@ -145,7 +146,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			dpath->mode = wt_mode;
 
 			while (i < entries) {
-				struct cache_entry *nce = active_cache[i];
+				struct cache_entry *nce = istate->cache[i];
 				int stage;
 
 				if (strcmp(ce->name, nce->name))
@@ -474,7 +475,9 @@ static int oneway_diff(const struct cache_entry * const *src,
 	if (tree == o->df_conflict_entry)
 		tree = NULL;
 
-	if (ce_path_match(&the_index, idx ? idx : tree, &revs->prune_data, NULL)) {
+	if (ce_path_match(revs->diffopt.repo->index,
+			  idx ? idx : tree,
+			  &revs->prune_data, NULL)) {
 		do_oneway_diff(o, idx, tree);
 		if (diff_can_quit_early(&revs->diffopt)) {
 			o->exiting_early = 1;
@@ -506,7 +509,7 @@ static int diff_cache(struct rev_info *revs,
 	opts.merge = 1;
 	opts.fn = oneway_diff;
 	opts.unpack_data = revs;
-	opts.src_index = &the_index;
+	opts.src_index = revs->diffopt.repo->index;
 	opts.dst_index = NULL;
 	opts.pathspec = &revs->diffopt.pathspec;
 	opts.pathspec->recursive = 1;
-- 
2.19.0.rc0.337.ge906d732e7

