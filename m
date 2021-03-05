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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E16C433DB
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 00:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06BD264F59
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 00:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhCEAzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 19:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbhCEAzm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 19:55:42 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44321C061574
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 16:55:42 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id l12so252722wry.2
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 16:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1m5gwebwysSqPY8ol6mtnZ1CYvl2KEt25N49Yi1cJKU=;
        b=Ac4uXuRph1kWA84HXvzwfcwrwtT74ZcclSt5DdSfAyDzV9yyr1if8+qdB22jRzA3Q7
         d5zlh5qg2tub1RBAw+Mto0ywIF9PF3I5jgrLf9tFdm8NzQTjKsC+9FbeDL9kIrDHyINj
         B27jfPoLE0UL/uGFLB9ydG/JmJyCZuwPXJCprL3wJ3qlWeHPFzKBlzlyl4PbbmyDg/Qi
         YtBz1XBKvDOLC/GT7x47E9lQKyukZ9aH2CgUJYi6bnz+TBxZJ9//xyoP4RGC/wSX/EeW
         +zFJMAXebThqEeG7Ldpd+Wh2nUvI2rve6u8Dt5Gw7ggvUNKhiWyJkXBnR9qj1ab1ePDU
         uodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1m5gwebwysSqPY8ol6mtnZ1CYvl2KEt25N49Yi1cJKU=;
        b=sUjCo/vPrrGq9ps3TK30xBpngcSHlPvCMXvT8OdX9nyyrVl+JjeBxABZmYT0nilRE7
         A7no9XyUrq761GfOztjDHWO7CbNEEDskNEC0hnbz44DB1iwDNLEDVh7nxeJ4Zk2SZIm5
         JSeQLUQZFAUjxDHeIRmXJub9/DUjuTyRYrSFHqlSUSWkqr1GZOpUApDVoMoXiDT1qc2j
         rplZeyPsZAi7zJbenbuFzO/HP1ZjXGdwsTJhuoqcM4lSmgZ80UYFfQvi6JMb9LdHOko2
         a4mgwtlcbwEEKYs3QfYyfsUYPS58GFq4ljYbVykAtEj7TuCnHD6ulQSyGmvv1dg33diY
         NyiQ==
X-Gm-Message-State: AOAM533D2GxDVU6YMcwLuu8yz1gsbSf5R/E+vXJuMRgknHcUbq78oVuT
        Gbb8/3eqKb1oWdCT5NFPgjgkwd8NTpg=
X-Google-Smtp-Source: ABdhPJyjCDeO36YviyvLpvSHzHOSWGqSyKZvUuDe5gaX3Bez3jVZCtJZ/vbisLqOsZ+PnRUPkZm2Uw==
X-Received: by 2002:adf:d236:: with SMTP id k22mr6653858wrh.144.1614905741042;
        Thu, 04 Mar 2021 16:55:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i10sm1539182wrs.11.2021.03.04.16.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 16:55:40 -0800 (PST)
Message-Id: <815af5d30ebd5e7f80aa42e4a54808af2e3781e0.1614905738.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Mar 2021 00:55:29 +0000
Subject: [PATCH 03/11] merge-ort: add a function for initializing our special
 attr_index
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
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Add a function which can be called to populate the attr_index with the
appropriate .gitattributes contents when necessary.  Make it return
early if the attr_index is already initialized or if we are not
renormalizing files.

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
 merge-ort.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index d91b66a052b6..028d1adcd2c9 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -988,6 +988,67 @@ static int merge_submodule(struct merge_options *opt,
 	return 0;
 }
 
+MAYBE_UNUSED
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
+	if (!opt->renormalize)
+		return;
+
+	if (attr_index->initialized)
+		return;
+	attr_index->initialized = 1;
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
+	}
+	else {
+		int stage, len;
+		struct conflict_info *ci;
+
+		ASSIGN_AND_VERIFY_CI(ci, mi);
+		for (stage=0; stage<3; ++stage) {
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
-- 
gitgitgadget

