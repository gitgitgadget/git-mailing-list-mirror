Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797EBC2BB40
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 16:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 439CC225AB
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 16:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440272AbgLNQX1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 11:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440248AbgLNQXG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 11:23:06 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CEEC0617B0
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 08:21:48 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id a6so14283167wmc.2
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 08:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZmaFFlhRcNBXHdv7esqe3Jf3vYqKLnuvVwTH5JzTLmk=;
        b=jGq9WWQ4ug+jTNzMdiy6rNmSS7QBfZwV+46Skhw0Ela9fpXnxD2tbLpSSPZP9iAd3w
         ZQR44zgkZivlw0ieB3e4pHwP0U3DWD4mYrsJVXW/tGBM6svSvapnzkSTF4RvNz92OTYo
         aPeegslEzaU5IFw8AexSP5nzz3hEsg+jIehvtm56L6+oa+AU+iTacYs6Zf5Pei2isbvx
         lKNm7I5ZV4kFopV/ebYxm0Y01Cf8ULLtKAsAU053sRUlc8uYC1ORE1JUx+HnAnZ8qH6Y
         admUbP5pVJw+4RJkLFrSNhYih7snaW79/sBEedyDqvp1wOZAVUiJvT79nzEG2k2S9KYf
         bO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZmaFFlhRcNBXHdv7esqe3Jf3vYqKLnuvVwTH5JzTLmk=;
        b=aOOyncsoBYQjFwQT+xq4+E7Z8rW44x4YVaJqswBU3HTM4DZsj7iRgcjI9joi82S2XG
         g2q5YwjeehKeNJ2pKwXUfQ0nRfOxdlsWjv6vypGUn0g3MgUiINOatTjBMbTbu73k5GuZ
         inlES6bJWaRtrnYo1vEVZFruilQRGPlJ1L39bJlFKIcQXryghw6r3b0bHEeQrwFAiPmH
         bxncxuuMzRkBTBgD8it+gdnJ4FA0Xo/X4qAzkCEB3wxI70rG+PTd4YVmN5Q02B6sPWxx
         mAVOC55yD4/vB1diCjtQBP3GefuLYOxuvB1dXHFtIm7eLS1AqmWMumc9CX68QdaQPjb9
         JqQg==
X-Gm-Message-State: AOAM5322VDFuWCdckfWJb0BlWJyBcBTCSt7sSvVK7JLq8gkgg1ZfCTvd
        ze+dW2DqFvfNzfCcokfxv5Dzt9WkLhM=
X-Google-Smtp-Source: ABdhPJz+jfM/rYAY9zXv3NSB9vYIF25V22oaquAo4H4Wx4wPyojyX/N6BOzgpgp2rlzz9JXj8BaiWg==
X-Received: by 2002:a05:600c:2246:: with SMTP id a6mr28699292wmm.80.1607962906865;
        Mon, 14 Dec 2020 08:21:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t1sm33856791wro.27.2020.12.14.08.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 08:21:46 -0800 (PST)
Message-Id: <d20fab8d403851ff9247d8b6bb950927f72b2729.1607962900.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
        <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Dec 2020 16:21:34 +0000
Subject: [PATCH v2 05/11] merge-ort: add basic outline for process_renames()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Add code which determines which kind of special rename case each rename
corresponds to, but leave the handling of each type unimplemented for
now.  Future commits will implement each one.

There is some tenuous resemblance to merge-recursive's
process_renames(), but comparing the two is very unlikely to yield any
insights.  merge-ort's process_renames() is a bit complex and I would
prefer if I could simplify it more, but it is far easier to grok than
merge-recursive's function of the same name in my opinion.  Plus,
merge-ort handles more rename conflict types than merge-recursive does.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 10550c542b8..ebe275ef73c 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -647,7 +647,103 @@ static int handle_content_merge(struct merge_options *opt,
 static int process_renames(struct merge_options *opt,
 			   struct diff_queue_struct *renames)
 {
-	die("Not yet implemented.");
+	int clean_merge = 1, i;
+
+	for (i = 0; i < renames->nr; ++i) {
+		const char *oldpath = NULL, *newpath;
+		struct diff_filepair *pair = renames->queue[i];
+		struct conflict_info *oldinfo = NULL, *newinfo = NULL;
+		struct strmap_entry *old_ent, *new_ent;
+		unsigned int old_sidemask;
+		int target_index, other_source_index;
+		int source_deleted, collision, type_changed;
+
+		old_ent = strmap_get_entry(&opt->priv->paths, pair->one->path);
+		oldpath = old_ent->key;
+		oldinfo = old_ent->value;
+
+		new_ent = strmap_get_entry(&opt->priv->paths, pair->two->path);
+		newpath = new_ent->key;
+		newinfo = new_ent->value;
+
+		/*
+		 * diff_filepairs have copies of pathnames, thus we have to
+		 * use standard 'strcmp()' (negated) instead of '=='.
+		 */
+		if (i + 1 < renames->nr &&
+		    !strcmp(oldpath, renames->queue[i+1]->one->path)) {
+			/* Handle rename/rename(1to2) or rename/rename(1to1) */
+			const char *pathnames[3];
+
+			pathnames[0] = oldpath;
+			pathnames[1] = newpath;
+			pathnames[2] = renames->queue[i+1]->two->path;
+
+			if (!strcmp(pathnames[1], pathnames[2])) {
+				/* Both sides renamed the same way. */
+				die("Not yet implemented");
+
+				/* We handled both renames, i.e. i+1 handled */
+				i++;
+				/* Move to next rename */
+				continue;
+			}
+
+			/* This is a rename/rename(1to2) */
+			die("Not yet implemented");
+
+			i++; /* We handled both renames, i.e. i+1 handled */
+			continue;
+		}
+
+		VERIFY_CI(oldinfo);
+		VERIFY_CI(newinfo);
+		target_index = pair->score; /* from collect_renames() */
+		assert(target_index == 1 || target_index == 2);
+		other_source_index = 3 - target_index;
+		old_sidemask = (1 << other_source_index); /* 2 or 4 */
+		source_deleted = (oldinfo->filemask == 1);
+		collision = ((newinfo->filemask & old_sidemask) != 0);
+		type_changed = !source_deleted &&
+			(S_ISREG(oldinfo->stages[other_source_index].mode) !=
+			 S_ISREG(newinfo->stages[target_index].mode));
+		if (type_changed && collision) {
+			/* special handling so later blocks can handle this */
+			die("Not yet implemented");
+		}
+
+		assert(source_deleted || oldinfo->filemask & old_sidemask);
+
+		/* Need to check for special types of rename conflicts... */
+		if (collision && !source_deleted) {
+			/* collision: rename/add or rename/rename(2to1) */
+			die("Not yet implemented");
+		} else if (collision && source_deleted) {
+			/* rename/add/delete or rename/rename(2to1)/delete */
+			die("Not yet implemented");
+		} else {
+			/* a few different cases... */
+			if (type_changed) {
+				/* rename vs. typechange */
+				die("Not yet implemented");
+			} else if (source_deleted) {
+				/* rename/delete */
+				die("Not yet implemented");
+			} else {
+				/* normal rename */
+				die("Not yet implemented");
+			}
+		}
+
+		if (!type_changed) {
+			/* Mark the original as resolved by removal */
+			oldinfo->merged.is_null = 1;
+			oldinfo->merged.clean = 1;
+		}
+
+	}
+
+	return clean_merge;
 }
 
 static int compare_pairs(const void *a_, const void *b_)
-- 
gitgitgadget

