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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D3FC2BBD4
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 103CA23A57
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731747AbgLRFwO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 00:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgLRFwO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 00:52:14 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EE6C061282
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 21:51:33 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t16so822805wra.3
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 21:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=b/lQQhK8bSffDw3/2icwtSxNT2UhUhNVLirkuVtqw5E=;
        b=IjtTPoHWFQ5WopaSUmaAz5G4usug9Tv1AhEp50ADR8LlKobNFttmNXNV7IDrDKbGhR
         MY8rx4qqwF/TFTKJ9aOAHofXqMMJXs2RBugjcP1qv0CYSs/5rXtuRwJWaYdia+JnbQD/
         KHwiv1L8thv+0fIiuClnP6DYrlfmV2hub8LJHpz3+bNVwHfplxsf5uuonHn46aNVGxyk
         K+h8l9WOVCToIyRtfSNnwS4agPJjBBYihT23O6Ngqe0wKdHW+s3GbYZyfdWqd00q853/
         ocKVyjW4TyoEd+UmD5gjqVhR5vEJEEjt7sbits2Ao9HSP3i196Xx9VZYYg8+CZ9U0FwC
         NVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=b/lQQhK8bSffDw3/2icwtSxNT2UhUhNVLirkuVtqw5E=;
        b=eAwAoWQ2TftZ9FPdqMmWpmQ+kpXwGiEqnLUqTuwpKxP9HL6YCvH5DgXl3YWxt1+Q/g
         iaM8RhqdIXihCVIBC//F1mb3/QCPlLCR1BY98VKiJrQ50v8IpD3YqZ+N19oJOqaPb4A5
         9UZXPcmModCr5NUCWk4jjUjtUPJQQa0EDpzI1gPV2UdNt3GqLKb3Z8kw6z26fYbaDjn0
         vzOvgUbqqRS1puJuI5aifwM95XP8Cy2XydwySj6O956AkSqBnIrNK7Xt20cXoBZLdLJw
         VLeY4lDa/kkYKQEbc+NGQarZLAdi5nIFOUnGB+Sj6IoeSRuPup7iLN1tp+tKHiOdssjl
         weUw==
X-Gm-Message-State: AOAM532SGiRzrA9UT8VGMS7c2QaYFzE+YGYZYcPas1jeaoWPMVljIqmM
        +vQct+PoIW1txZh5519BubwOG11l7uo=
X-Google-Smtp-Source: ABdhPJwXbvFMQ1BgjTbN1E940cD6r/O14CMw94FZQOd1D0/D2ZCtcuxtNZp03cTXyMvggA+ca+FuTQ==
X-Received: by 2002:adf:b74d:: with SMTP id n13mr2393191wre.101.1608270690707;
        Thu, 17 Dec 2020 21:51:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i4sm13242181wri.88.2020.12.17.21.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 21:51:30 -0800 (PST)
Message-Id: <46953226ba86fa159180262adb068b3218c74a9b.1608270687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.815.git.1608270687.gitgitgadget@gmail.com>
References: <pull.815.git.1608270687.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 18 Dec 2020 05:51:19 +0000
Subject: [PATCH 02/10] merge-ort: handle directory/file conflicts that remain
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

When a directory/file conflict remains, we can leave the directory where
it is, but need to move the information about the file to a different
pathname.  After moving the file to a different pathname, we allow
subsequent process_entry() logic to handle any additional details that
might be relevant.

This depends on a new helper function, unique_path(), that dies with an
unimplemented error currently but will be implemented in a subsequent
commit.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index f9a79eb25e6..d300a02810e 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -343,6 +343,13 @@ static void path_msg(struct merge_options *opt,
 	strbuf_addch(sb, '\n');
 }
 
+static char *unique_path(struct strmap *existing_paths,
+			 const char *path,
+			 const char *branch)
+{
+	die("Not yet implemented.");
+}
+
 /*** Function Grouping: functions related to collect_merge_info() ***/
 
 static void setup_path_info(struct merge_options *opt,
@@ -962,6 +969,8 @@ static void process_entry(struct merge_options *opt,
 			  struct conflict_info *ci,
 			  struct directory_versions *dir_metadata)
 {
+	int df_file_index = 0;
+
 	VERIFY_CI(ci);
 	assert(ci->filemask >= 0 && ci->filemask <= 7);
 	/* ci->match_mask == 7 was handled in collect_merge_info_callback() */
@@ -998,7 +1007,80 @@ static void process_entry(struct merge_options *opt,
 			oidcpy(&ci->stages[i].oid, &null_oid);
 		}
 	} else if (ci->df_conflict && ci->merged.result.mode != 0) {
-		die("Not yet implemented.");
+		/*
+		 * This started out as a D/F conflict, and the entries in
+		 * the competing directory were not removed by the merge as
+		 * evidenced by write_completed_directory() writing a value
+		 * to ci->merged.result.mode.
+		 */
+		struct conflict_info *new_ci;
+		const char *branch;
+		const char *old_path = path;
+		int i;
+
+		assert(ci->merged.result.mode == S_IFDIR);
+
+		/*
+		 * If filemask is 1, we can just ignore the file as having
+		 * been deleted on both sides.  We do not want to overwrite
+		 * ci->merged.result, since it stores the tree for all the
+		 * files under it.
+		 */
+		if (ci->filemask == 1) {
+			ci->filemask = 0;
+			return;
+		}
+
+		/*
+		 * This file still exists on at least one side, and we want
+		 * the directory to remain here, so we need to move this
+		 * path to some new location.
+		 */
+		new_ci = xcalloc(1, sizeof(*new_ci));
+		/* We don't really want new_ci->merged.result copied, but it'll
+		 * be overwritten below so it doesn't matter.  We also don't
+		 * want any directory mode/oid values copied, but we'll zero
+		 * those out immediately.  We do want the rest of ci copied.
+		 */
+		memcpy(new_ci, ci, sizeof(*ci));
+		new_ci->match_mask = (new_ci->match_mask & ~new_ci->dirmask);
+		new_ci->dirmask = 0;
+		for (i = MERGE_BASE; i <= MERGE_SIDE2; i++) {
+			if (new_ci->filemask & (1 << i))
+				continue;
+			/* zero out any entries related to directories */
+			new_ci->stages[i].mode = 0;
+			oidcpy(&new_ci->stages[i].oid, &null_oid);
+		}
+
+		/*
+		 * Find out which side this file came from; note that we
+		 * cannot just use ci->filemask, because renames could cause
+		 * the filemask to go back to 7.  So we use dirmask, then
+		 * pick the opposite side's index.
+		 */
+		df_file_index = (ci->dirmask & (1 << 1)) ? 2 : 1;
+		branch = (df_file_index == 1) ? opt->branch1 : opt->branch2;
+		path = unique_path(&opt->priv->paths, path, branch);
+		strmap_put(&opt->priv->paths, path, new_ci);
+
+		path_msg(opt, path, 0,
+			 _("CONFLICT (file/directory): directory in the way "
+			   "of %s from %s; moving it to %s instead."),
+			 old_path, branch, path);
+
+		/*
+		 * Zero out the filemask for the old ci.  At this point, ci
+		 * was just an entry for a directory, so we don't need to
+		 * do anything more with it.
+		 */
+		ci->filemask = 0;
+
+		/*
+		 * Now note that we're working on the new entry (path was
+		 * updated above.
+		 */
+		ci = new_ci;
 	}
 
 	/*
-- 
gitgitgadget

