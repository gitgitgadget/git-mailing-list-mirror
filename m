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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A81C433DB
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 00:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D1FD6197D
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 00:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhCTAEi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 20:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhCTAEB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 20:04:01 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AA7C061760
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 17:04:00 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k8so10733194wrc.3
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 17:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cnf/QEJ8oejThB9c252suJGw0HPP+Uh2G/Edw1V71cM=;
        b=SLA4gPLBc5622bd+EYNT7ghldV3GTatO5tfPpzi1+xdy02p0ojrBqiMlZkREbdBrz6
         025M8vOPSZ3cMK8E5srgkArXlh8Pohvsdj9LWT4XqpT4X6SkP8qSVmU1iB6f15BHVH8L
         b0n0CMLPnF71p4LkVfKKNdOEd3Ed3XyZWWm7viwOjq1FJIYJqAROCwq9Jw1b8dlWNWaj
         ZCmWPd0nE8LIIcgQITWGz/ErKjSvcGdcz/sIJK9EE0Zzw76Y3zxX/qqlcCU4U5jjsqT7
         pxLcQyjuN/okAQ5WjtPi4G0fDCdS/AuhJbvSdEpJMH2k/y8Fg9a39ZRR5QrO2aGaEq2+
         4biQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cnf/QEJ8oejThB9c252suJGw0HPP+Uh2G/Edw1V71cM=;
        b=KcOKN1rv+7zO94i2UAjylcacEzXwhb0B9NiMi9MPZe4ZBXE7fLE9XX8NU3t7J8qxsV
         uwQQ93RZhRTnwGeOEgSL7iQMna47tsXkLwsK8dhecqMIK6Pid9RG5jpqN+0bA+DBmfrR
         F3+AbSA8p463mLmtDHZwW04eNINK/9aEXR499s99Jsauk0/GrCeD0iLZ8EfmtYFcESc1
         wN1MwAs3w4vGoWpqP8c0ompfT94Q8zAj6avTdNz2SYiE+RftK1GGh4srBS6Bvjm2ieTO
         E15xi3BQ0PNT84TP8lEdE07Rxir7EqzhGayWLZX/IYkVCvBUxD2nGwk+/ztIxW0dfV7u
         JSJg==
X-Gm-Message-State: AOAM532zHBWeVqIzbjPOfm8LoQEApNyHFyS5l8aeSXc6190XlgvU5RU1
        uaPCOZVFpra++How45Zqk17z9gsJSnQ=
X-Google-Smtp-Source: ABdhPJwyf8rTvnzoeiKwRhFMTLNWipUWWiju4U8YwkFtYlyTD1WET1Rv+5r8dca2Mz3422+hcCACew==
X-Received: by 2002:adf:e809:: with SMTP id o9mr7138605wrm.110.1616198639692;
        Fri, 19 Mar 2021 17:03:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s83sm8141956wmf.26.2021.03.19.17.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 17:03:59 -0700 (PDT)
Message-Id: <4ff23d2f52a0abd41d81076f9dfa3a93319deca5.1616198636.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.905.v3.git.1616198636.gitgitgadget@gmail.com>
References: <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
        <pull.905.v3.git.1616198636.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 20 Mar 2021 00:03:46 +0000
Subject: [PATCH v3 03/13] merge-ort: have ll_merge() use a special attr_index
 for renormalization
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

ll_merge() needs an index when renormalization is requested.  Create one
specifically for just this purpose with just the one needed entry.  This
fixes t6418.4 and t6418.5 under GIT_TEST_MERGE_ALGORITHM=ort.

NOTE 1: Even if the user has a working copy or a real index (which is
not a given as merge-ort can be used in bare repositories), we
explicitly ignore any .gitattributes file from either of these
locations.  merge-ort can be used to merge two branches that are
unrelated to HEAD, so .gitattributes from the working copy and current
index should not be considered relevant.

NOTE 2: Since we are in the middle of merging, there is a risk that
.gitattributes itself is conflicted...leaving us with an ill-defined
situation about how to perform the rest of the merge.  It could be that
the .gitattributes file does not even exist on one of the sides of the
merge, or that it has been modified on both sides.  If it's been
modified on both sides, it's possible that it could itself be merged
cleanly, though it's also possible that it only merges cleanly if you
use the right version of the .gitattributes file to drive the merge.  It
gets kind of complicated.  The only test we ever had that attempted to
test behavior in this area was seemingly unaware of the undefined
behavior, but knew the test wouldn't work for lack of attribute handling
support, marked it as test_expect_failure from the beginning, but
managed to fail for several reasons unrelated to attribute handling.
See commit 6f6e7cfb52 ("t6038: remove problematic test", 2020-08-03) for
details.  So there are probably various ways to improve what
initialize_attr_index() picks in the case of a conflicted .gitattributes
but for now I just implemented something simple -- look for whatever
.gitattributes file we can find in any of the higher order stages and
use it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 3c606fa7e4b3..cdc1e2fe7a24 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -410,7 +410,7 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 	string_list_clear(&opti->paths_to_free, 0);
 	opti->paths_to_free.strdup_strings = 0;
 
-	if (opti->attr_index.cache_nr)
+	if (opti->attr_index.cache_nr) /* true iff opt->renormalize */
 		discard_index(&opti->attr_index);
 
 	/* Free memory used by various renames maps */
@@ -1201,6 +1201,63 @@ static int merge_submodule(struct merge_options *opt,
 	return 0;
 }
 
+static void initialize_attr_index(struct merge_options *opt)
+{
+	/*
+	 * The renormalize_buffer() functions require attributes, and
+	 * annoyingly those can only be read from the working tree or from
+	 * an index_state.  merge-ort doesn't have an index_state, so we
+	 * generate a fake one containing only attribute information.
+	 */
+	struct merged_info *mi;
+	struct index_state *attr_index = &opt->priv->attr_index;
+	struct cache_entry *ce;
+
+	attr_index->initialized = 1;
+
+	if (!opt->renormalize)
+		return;
+
+	mi = strmap_get(&opt->priv->paths, GITATTRIBUTES_FILE);
+	if (!mi)
+		return;
+
+	if (mi->clean) {
+		int len = strlen(GITATTRIBUTES_FILE);
+		ce = make_empty_cache_entry(attr_index, len);
+		ce->ce_mode = create_ce_mode(mi->result.mode);
+		ce->ce_flags = create_ce_flags(0);
+		ce->ce_namelen = len;
+		oidcpy(&ce->oid, &mi->result.oid);
+		memcpy(ce->name, GITATTRIBUTES_FILE, len);
+		add_index_entry(attr_index, ce,
+				ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
+		get_stream_filter(attr_index, GITATTRIBUTES_FILE, &ce->oid);
+	} else {
+		int stage, len;
+		struct conflict_info *ci;
+
+		ASSIGN_AND_VERIFY_CI(ci, mi);
+		for (stage = 0; stage < 3; stage++) {
+			unsigned stage_mask = (1 << stage);
+
+			if (!(ci->filemask & stage_mask))
+				continue;
+			len = strlen(GITATTRIBUTES_FILE);
+			ce = make_empty_cache_entry(attr_index, len);
+			ce->ce_mode = create_ce_mode(ci->stages[stage].mode);
+			ce->ce_flags = create_ce_flags(stage);
+			ce->ce_namelen = len;
+			oidcpy(&ce->oid, &ci->stages[stage].oid);
+			memcpy(ce->name, GITATTRIBUTES_FILE, len);
+			add_index_entry(attr_index, ce,
+					ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
+			get_stream_filter(attr_index, GITATTRIBUTES_FILE,
+					  &ce->oid);
+		}
+	}
+}
+
 static int merge_3way(struct merge_options *opt,
 		      const char *path,
 		      const struct object_id *o,
@@ -1215,6 +1272,9 @@ static int merge_3way(struct merge_options *opt,
 	char *base, *name1, *name2;
 	int merge_status;
 
+	if (!opt->priv->attr_index.initialized)
+		initialize_attr_index(opt);
+
 	ll_opts.renormalize = opt->renormalize;
 	ll_opts.extra_marker_size = extra_marker_size;
 	ll_opts.xdl_opts = opt->xdl_opts;
@@ -1253,7 +1313,7 @@ static int merge_3way(struct merge_options *opt,
 
 	merge_status = ll_merge(result_buf, path, &orig, base,
 				&src1, name1, &src2, name2,
-				opt->repo->index, &ll_opts);
+				&opt->priv->attr_index, &ll_opts);
 
 	free(base);
 	free(name1);
-- 
gitgitgadget

