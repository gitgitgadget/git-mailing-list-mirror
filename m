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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36507C64E7C
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDC9B207CD
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RU2d/Sd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgK2Hot (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Nov 2020 02:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgK2Hos (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Nov 2020 02:44:48 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AC3C061A48
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:43:32 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id g185so7315344wmf.3
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RfavVJtLDh39220rcxisgawxzE2vD7vnVIF+bM9WzMY=;
        b=RU2d/Sd+DzepSLY8oYMrIk5VyTiFoRJ9KQ3f4HZxq6CmUAlRZ1tzND/yk9tCQxkPJa
         6hxp33EyUOsai3xNrAGO9txRClt0pyH20nxH9LaPN5H/Ko7Nluw3S3H4DeTNG9VTszPc
         mu5RNk6PQdPmriLS4AkZCakCS3GEYZpgErL1lOUQE7wqbDJ0uhx2I3ueAVqPeIP/2mHt
         fcNy7umPLpnTr61vpomzGljVETTA2MSWgelahDmrjnfS1HKbDDAYzhCvSshTqKjqSALM
         0dZKs6k//nH8o5bRaMGC9uU4uRyxq89Pi8Bjj28s8VCrpXl246rgh36Tqvp7hrjRpzSY
         DTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RfavVJtLDh39220rcxisgawxzE2vD7vnVIF+bM9WzMY=;
        b=p7YtNB13WRnHsXdejqHiMQKyqdqNuvN1AfK0fGAmOc9gcB1PAW+lqjTC+I8n4fMs17
         ue6Ay3LmgvDeZhiYxhSws6/1EghPlkxKGTnnhNStq9Hb1wfsO+b5TGuoxvfoSPZtFj6g
         pHsi5VDJGapxgp/egd+SDNePN7yga5HN6nBGjpgV0GJrZOIH4VTZJc4VNIn9e/uiwIJ8
         WkUB2UtJX30YdS/GZP7m28lLlso3WJopZTy3QaZ+twlgpCC4vfzQvPVQjjIXLMT1a5A2
         G/UDc46OsIfPkPIluKWKBm2TXAPnj7MmZ7UxNHbGIYqcyhbP6Za+XZk7dIeHeKqHqyZB
         rh/w==
X-Gm-Message-State: AOAM533AG4pIeTZ/5SdylNcJwuuTGrP8Pr0xh+rC/aILCme4T2AQgEHh
        gDfkXoyBgoVNO/GuKln+TsEcgVVuCRQ=
X-Google-Smtp-Source: ABdhPJx/ZMwp9cE3mZdXlfhi+MdPlzgIBmoDG/UwEzb0WYnZKbA3iMUNDh6E/bMR8SkEpBXHvxkFDA==
X-Received: by 2002:a1c:9c53:: with SMTP id f80mr17045321wme.19.1606635810294;
        Sat, 28 Nov 2020 23:43:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m9sm22610931wrx.59.2020.11.28.23.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 23:43:29 -0800 (PST)
Message-Id: <ab743967aa226c5369286ce7f1da6e66b5b7f25e.1606635803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 29 Nov 2020 07:43:09 +0000
Subject: [PATCH 06/20] merge-ort: implement a very basic collect_merge_info()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This does not actually collect any necessary info other than the
pathnames involved, since it just allocates an all-zero conflict_info
and stuffs that into paths.  However, it invokes the traverse_trees()
machinery to walk over all the paths and sets up the basic
infrastructure we need.

I have left out a few obvious optimizations to try to make this patch as
short and obvious as possible.  A subsequent patch will add some of
those back in with some more useful data fields before we introduce a
patch that actually sets up the conflict_info fields.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 119 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 117 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index baf31bcc28..a3096876d4 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -174,13 +174,128 @@ static int err(struct merge_options *opt, const char *err, ...)
 	return -1;
 }
 
+static int collect_merge_info_callback(int n,
+				       unsigned long mask,
+				       unsigned long dirmask,
+				       struct name_entry *names,
+				       struct traverse_info *info)
+{
+	/*
+	 * n is 3.  Always.
+	 * common ancestor (mbase) has mask 1, and stored in index 0 of names
+	 * head of side 1  (side1) has mask 2, and stored in index 1 of names
+	 * head of side 2  (side2) has mask 4, and stored in index 2 of names
+	 */
+	struct merge_options *opt = info->data;
+	struct merge_options_internal *opti = opt->priv;
+	struct conflict_info *ci;
+	struct name_entry *p;
+	size_t len;
+	char *fullpath;
+	unsigned filemask = mask & ~dirmask;
+	unsigned mbase_null = !(mask & 1);
+	unsigned side1_null = !(mask & 2);
+	unsigned side2_null = !(mask & 4);
+
+	/* n = 3 is a fundamental assumption. */
+	if (n != 3)
+		BUG("Called collect_merge_info_callback wrong");
+
+	/*
+	 * A bunch of sanity checks verifying that traverse_trees() calls
+	 * us the way I expect.  Could just remove these at some point,
+	 * though maybe they are helpful to future code readers.
+	 */
+	assert(mbase_null == is_null_oid(&names[0].oid));
+	assert(side1_null == is_null_oid(&names[1].oid));
+	assert(side2_null == is_null_oid(&names[2].oid));
+	assert(!mbase_null || !side1_null || !side2_null);
+	assert(mask > 0 && mask < 8);
+
+	/*
+	 * Get the name of the relevant filepath, which we'll pass to
+	 * setup_path_info() for tracking.
+	 */
+	p = names;
+	while (!p->mode)
+		p++;
+	len = traverse_path_len(info, p->pathlen);
+
+	/* +1 in both of the following lines to include the NUL byte */
+	fullpath = xmalloc(len + 1);
+	make_traverse_path(fullpath, len + 1, info, p->path, p->pathlen);
+
+	/*
+	 * TODO: record information about the path other than all zeros,
+	 * so we can resolve later in process_entries.
+	 */
+	ci = xcalloc(1, sizeof(struct conflict_info));
+	strmap_put(&opti->paths, fullpath, ci);
+
+	/* If dirmask, recurse into subdirectories */
+	if (dirmask) {
+		struct traverse_info newinfo;
+		struct tree_desc t[3];
+		void *buf[3] = {NULL, NULL, NULL};
+		const char *original_dir_name;
+		int i, ret;
+
+		ci->match_mask &= filemask;
+		newinfo = *info;
+		newinfo.prev = info;
+		newinfo.name = p->path;
+		newinfo.namelen = p->pathlen;
+		newinfo.pathlen = st_add3(newinfo.pathlen, p->pathlen, 1);
+
+		for (i = 0; i < 3; i++) {
+			const struct object_id *oid = NULL;
+			if (dirmask & 1)
+				oid = &names[i].oid;
+			buf[i] = fill_tree_descriptor(opt->repo, t + i, oid);
+			dirmask >>= 1;
+		}
+
+		original_dir_name = opti->current_dir_name;
+		opti->current_dir_name = fullpath;
+		ret = traverse_trees(NULL, 3, t, &newinfo);
+		opti->current_dir_name = original_dir_name;
+
+		for (i = 0; i < 3; i++)
+			free(buf[i]);
+
+		if (ret < 0)
+			return -1;
+	}
+
+	return mask;
+}
+
 static int collect_merge_info(struct merge_options *opt,
 			      struct tree *merge_base,
 			      struct tree *side1,
 			      struct tree *side2)
 {
-	/* TODO: Implement this using traverse_trees() */
-	die("Not yet implemented.");
+	int ret;
+	struct tree_desc t[3];
+	struct traverse_info info;
+	const char *toplevel_dir_placeholder = "";
+
+	opt->priv->current_dir_name = toplevel_dir_placeholder;
+	setup_traverse_info(&info, toplevel_dir_placeholder);
+	info.fn = collect_merge_info_callback;
+	info.data = opt;
+	info.show_all_errors = 1;
+
+	parse_tree(merge_base);
+	parse_tree(side1);
+	parse_tree(side2);
+	init_tree_desc(t + 0, merge_base->buffer, merge_base->size);
+	init_tree_desc(t + 1, side1->buffer, side1->size);
+	init_tree_desc(t + 2, side2->buffer, side2->size);
+
+	ret = traverse_trees(NULL, 3, t, &info);
+
+	return ret;
 }
 
 static int detect_and_process_renames(struct merge_options *opt,
-- 
gitgitgadget

