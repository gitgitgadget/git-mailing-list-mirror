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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AFBC12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 05:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7DD4613E8
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 05:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbhGPFZm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 01:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbhGPFZi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 01:25:38 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBAAC061760
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 22:22:43 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d12so10544324wre.13
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 22:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=O18rVwHaBqtlPLP6Pdo7VhX7/XvD51eODUz8g95rd0o=;
        b=U9H/PHpoijDKwzqdarCKuNni/gxtVcv8VSQfnb4C5F73yEYoM78u9rhISPPF1UBX1J
         Ebetzket0y0iv/ELOLluuuDAZUVq47gd/5c/xbEDfEZI9QC9jDOFQf5xltmZSunMEphm
         b4EvhjzbKemkyjk8vY++qrD2Bx+mgmNwKxYqyblwo3xW7S8a7pEYNos38MsSAscHl/Wf
         BZg1Ctlcie0TL8BHGD+FirCnoF6uROMoF5Tky3oIk0NHMjc+HEM0JnKR+I9L4y6UAN32
         qrtFqQUwv0ehiqe+/obX803KoCmtCxcOsDk9rsJORRnCKK1QwE7+Bj9Asj1YxQCh/nJw
         gLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=O18rVwHaBqtlPLP6Pdo7VhX7/XvD51eODUz8g95rd0o=;
        b=A6eoOUVpKiUHsItx+KFi67RABfmMZVTjmbzATNZfvkgh1NxheaKUf+/OfaFsNjgDEg
         nUagQsBtGYjTuj9ltRswXtLPSJJwtR5JysdlkyppqOSGMaJTwaiUzD4YhXABOc7FywWw
         ZwEMYlZ4JRT/2MEzNu8vhlsu+TZg4k3EUZ9EvHVhqMUehyzlRWO6ocEgWv4Rv85UHqfv
         q08L8uhnvKbPMs5lZkVHKMWJJLI8pj+u/ZbaUEvOtawgoyQbSqH/UO2Lz+LxLjur/H9B
         ldkA7GCPsCRb0gTS3eqrLMRfmkiNGM7LKmI7uDUYvgEhjEWzLsO88nkJiB1Wvtdc1vfr
         7MyQ==
X-Gm-Message-State: AOAM533Yr6P7qAUV3RyOTiLVlTa0Sy/+7gQ1FK0OhgMNhL2fQOapo65o
        vS9lHKVJ+S/dhVeEB0Uor9ajGCsrRS0=
X-Google-Smtp-Source: ABdhPJylZG22UjOaJRZYAX7Jg8nRRyZJNQd5UCL0QWOVzI5lR5vPB2d66NJHnTIdMhiqV3PXNbtolQ==
X-Received: by 2002:a5d:52d0:: with SMTP id r16mr9801911wrv.323.1626412962506;
        Thu, 15 Jul 2021 22:22:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s24sm9767345wra.33.2021.07.15.22.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 22:22:42 -0700 (PDT)
Message-Id: <79c5153682980f8657b3fdc7bb85cbe5ea816398.1626412958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.988.v3.git.1626412958.gitgitgadget@gmail.com>
References: <pull.988.v2.git.1626204784.gitgitgadget@gmail.com>
        <pull.988.v3.git.1626412958.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Jul 2021 05:22:35 +0000
Subject: [PATCH v3 5/7] merge-ort: defer recursing into directories when merge
 base is matched
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When one side of history matches the merge base (including when the
merge base has no entry for the given directory), have
collect_merge_info_callback() defer recursing into the directory.  To
ensure those entries are eventually handled, add a call to
handled_deferred_entries() in collect_merge_info() after
traverse_trees() returns.

Note that the condition in collect_merge_info_callback() may look more
complicated than necessary at first glance;
renames->trivial_merges_okay[side] is always true until
handle_deferred_entries() is called, and possible_trivial_merges[side]
is always empty right now (and in the future won't be filled until
handle_deferred_entries() is called).  However, when
handle_deferred_entries() calls traverse_trees() for the relevant
deferred directories, those traverse_trees() calls will once again end
up in collect_merge_info_callback() for all the entries under those
subdirectories.  The extra conditions are there for such deferred cases
and will be used more as we do more with those variables.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index f0a07684df6..dbccf8c62e2 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1147,8 +1147,36 @@ static int collect_merge_info_callback(int n,
 		struct tree_desc t[3];
 		void *buf[3] = {NULL, NULL, NULL};
 		const char *original_dir_name;
-		int i, ret;
+		int i, ret, side;
 
+		/*
+		 * Check for whether we can avoid recursing due to one side
+		 * matching the merge base.  The side that does NOT match is
+		 * the one that might have a rename destination we need.
+		 */
+		assert(!side1_matches_mbase || !side2_matches_mbase);
+		side = side1_matches_mbase ? MERGE_SIDE2 :
+			side2_matches_mbase ? MERGE_SIDE1 : MERGE_BASE;
+		if (filemask == 0 && (dirmask == 2 || dirmask == 4)) {
+			/*
+			 * Also defer recursing into new directories; set up a
+			 * few variables to let us do so.
+			 */
+			ci->match_mask = (7 - dirmask);
+			side = dirmask / 2;
+		}
+		if (renames->dir_rename_mask != 0x07 &&
+		    side != MERGE_BASE &&
+		    renames->deferred[side].trivial_merges_okay &&
+		    !strset_contains(&renames->deferred[side].target_dirs,
+				     pi.string)) {
+			strintmap_set(&renames->deferred[side].possible_trivial_merges,
+				      pi.string, renames->dir_rename_mask);
+			renames->dir_rename_mask = prev_dir_rename_mask;
+			return mask;
+		}
+
+		/* We need to recurse */
 		ci->match_mask &= filemask;
 		newinfo = *info;
 		newinfo.prev = info;
@@ -1202,7 +1230,6 @@ static int collect_merge_info_callback(int n,
 	return mask;
 }
 
-MAYBE_UNUSED
 static int handle_deferred_entries(struct merge_options *opt,
 				   struct traverse_info *info)
 {
@@ -1291,6 +1318,8 @@ static int collect_merge_info(struct merge_options *opt,
 
 	trace2_region_enter("merge", "traverse_trees", opt->repo);
 	ret = traverse_trees(NULL, 3, t, &info);
+	if (ret == 0)
+		ret = handle_deferred_entries(opt, &info);
 	trace2_region_leave("merge", "traverse_trees", opt->repo);
 
 	return ret;
-- 
gitgitgadget

