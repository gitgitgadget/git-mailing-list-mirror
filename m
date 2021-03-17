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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A720C43381
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3D6764F2A
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbhCQV2a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 17:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbhCQV2K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 17:28:10 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DD1C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:28:09 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so2134728wmj.2
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cnf/QEJ8oejThB9c252suJGw0HPP+Uh2G/Edw1V71cM=;
        b=IUj9oilleaGCKClo9Pic7uBKHXoZVQ2AZ7dj520Iw/aUf4C8n2qve+NVtvsid9cjp8
         s7ncL2savVBQsw9VKq0+X9WkefxafdExhR81sxqcIKk3xOHBuwKTfdv+0ksESXieD/xM
         FCYhy3KLs2kXrDN4kZfAdlrHDXmsfXQgClXRXD4+p/8KjauutrYl3zyJjatI0F9IEjr6
         9YSUO8fnZYSAGZ15qmm1+oek/EajpmyyN2lWTGwaAbb5x0YuvoxoB9HLduDNkp8yJdwK
         JpZtkzGKH6ELk5+UUaU6ydwC/VHck7z71l3akKyOJQVZ+NjKKyHQ9gUHxWKZPBYN/fYU
         cOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cnf/QEJ8oejThB9c252suJGw0HPP+Uh2G/Edw1V71cM=;
        b=q3A7HHk6kR8lFItGdmRHc4D6VU0aoGcjA7G9a3AGaj15PsFYir3d3Yi0bQg+8XsenD
         Mnz6dwVTb6GNz0ljnxnpGUgoPBipEyBSW63B75I6GpZR3bACUAZJWrTBQDz5dN3kvOeJ
         Aw6cVUbkjD6SuudbhTHGFhtlTj64HFmutigxCteByCTcO+dffbf15VZbeV2ItvNcSXI2
         A1BTHfGQXrrZf8Vs+cqqQMchlDxhz4Fk++RyY+sC00mJs06c4zsirsftAqSNYgcB9lo1
         J6OgN2lXDxC2eFByZnB6ya/cmGmVYoYlA400f6WPWjcx8tLnUHnA+3EnKPoe6JS6f0ze
         BAGA==
X-Gm-Message-State: AOAM530eNH0N3fSao5yW0V8fcZuDi4WfwMk+LR7/ix9z7vrUcVebevaC
        F0A0foDaYXVpB7nBUefueudF0TCQCUo=
X-Google-Smtp-Source: ABdhPJxm8a9sQ+/XmqDi/6lzgUvkCq/0b0mitggmRn/QaivWNdpbBJxdc5/Rb8od9J5zxsIG1MEiPg==
X-Received: by 2002:a1c:318b:: with SMTP id x133mr674150wmx.154.1616016488685;
        Wed, 17 Mar 2021 14:28:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i3sm218989wra.66.2021.03.17.14.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 14:28:08 -0700 (PDT)
Message-Id: <4ff23d2f52a0abd41d81076f9dfa3a93319deca5.1616016485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
References: <pull.905.git.1615867503.gitgitgadget@gmail.com>
        <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Mar 2021 21:27:55 +0000
Subject: [PATCH v2 03/13] merge-ort: have ll_merge() use a special attr_index
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

