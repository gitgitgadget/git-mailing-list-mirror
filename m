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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5137C4332E
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 06:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75A07652A8
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 06:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhCIGZH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 01:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhCIGYv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 01:24:51 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A960EC06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 22:24:50 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo5214979wmq.4
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 22:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=63ABnt1pd0tUFQNpbOmtJDiWQczlWk6NQR2+eI776cs=;
        b=mjpfjb9v4CHu737ca+9qZHIEVYokHWN3PPYBtRIsZiRzEHKv7va3Voyis8bC9f+XeT
         mcnSu/mOKYG9Cc2SH7vwYSxOcEs922wLGuXYngwrL4Rp1ntvia/CrdWioA7zH6Q9rhgS
         KAx5XTum66euaz95DQmy4sRmo6KethohOmpzJi0Y7CDbkJbYnwNZ02z77Xbh4OefXG6t
         NAO0B3zV8MihPUOeicDjNipNRbswlRAQ9YA98uKNqlkbABI1Sh4018vvYfNVhn7+qDcd
         N8+Kbg6Vblpc3PPIZxVBPUxC7BQgtwghbvj0ZrNtdMGoNtLAVbYuDqWl3peSJM2zXnr8
         CnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=63ABnt1pd0tUFQNpbOmtJDiWQczlWk6NQR2+eI776cs=;
        b=hI2//Qvj5w8urf+xsOcO0LqavKflaPBp05UkuxQUUk3ilGPt3FYr43IayNb287M1j+
         HWQZ8blafu2Z2OiKyRKsOyB23HvIg+zdSDnv/dGEnA+MSPong1xPgGQlzz/nRwHbRZ/V
         vDjeIENQx8tRnby1XrfXYwfpqAubixjvAStPsVw8yLx7+VS8oT/A4OjEzZWCaZTAYEtg
         sF/twEc86d6MThWGt2cAetVF5a5pnYQVq+H+oKNSx6q1jr/QnvBhJ9vgTkkwl+Nfcz09
         1k3hAVdYIorXPGdmdK2Bspf2mQM3RZkzHbIYu+Gc+vwXF/ROu5K2ZboLy354TCn96A9t
         4QGg==
X-Gm-Message-State: AOAM532o5FBf78dwO87OcI+Mp3P3W+du+ZCZzGQCOUEtwlaP72QeLnaO
        P/f1KI4Du+WpFPN6XMSAPQDK0Hj79Us=
X-Google-Smtp-Source: ABdhPJy9n0fojNvoJ/VTU0LOLMYsMUOxKzukPEJ9eaTjnrx/AUVs0ZuPPnpXID5MoSlHJBSj93crJw==
X-Received: by 2002:a1c:f404:: with SMTP id z4mr2247123wma.39.1615271089486;
        Mon, 08 Mar 2021 22:24:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i4sm2170091wmq.12.2021.03.08.22.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 22:24:49 -0800 (PST)
Message-Id: <386cb3230b6780817120d83457796ccf6f64c84b.1615271086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.v2.git.git.1615271086.gitgitgadget@gmail.com>
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
        <pull.973.v2.git.git.1615271086.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Mar 2021 06:24:38 +0000
Subject: [PATCH v2 03/10] merge-ort: have ll_merge() use a special attr_index
 for renormalization
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
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
index d91b66a052b6..ea720eb51971 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -360,7 +360,7 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 	string_list_clear(&opti->paths_to_free, 0);
 	opti->paths_to_free.strdup_strings = 0;
 
-	if (opti->attr_index.cache_nr)
+	if (opti->attr_index.cache_nr) /* true iff opt->renormalize */
 		discard_index(&opti->attr_index);
 
 	/* Free memory used by various renames maps */
@@ -988,6 +988,63 @@ static int merge_submodule(struct merge_options *opt,
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
@@ -1002,6 +1059,9 @@ static int merge_3way(struct merge_options *opt,
 	char *base, *name1, *name2;
 	int merge_status;
 
+	if (!opt->priv->attr_index.initialized)
+		initialize_attr_index(opt);
+
 	ll_opts.renormalize = opt->renormalize;
 	ll_opts.extra_marker_size = extra_marker_size;
 	ll_opts.xdl_opts = opt->xdl_opts;
@@ -1040,7 +1100,7 @@ static int merge_3way(struct merge_options *opt,
 
 	merge_status = ll_merge(result_buf, path, &orig, base,
 				&src1, name1, &src2, name2,
-				opt->repo->index, &ll_opts);
+				&opt->priv->attr_index, &ll_opts);
 
 	free(base);
 	free(name1);
-- 
gitgitgadget

