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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846A2C2BB40
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 462D923BC6
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387911AbgLITnG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 14:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387861AbgLITm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 14:42:56 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA5FC0617A6
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 11:41:35 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id e25so2946641wme.0
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 11:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=B52IU9V4ss2EkKr2r35b5RX2v2fmhnZiFbREOn0Pscw=;
        b=Qb39KNG1whyOThI/K71SLv6uqObG8ku9gb8v2Sx7zehFpLw4CR60+rg9G198HAF/no
         3I/pTh6PhiDm0PwNV4YcKbaYk/ISMTtavg+M8fSnsNdycqPCYVWVtKvsiqGYE4isUuFl
         R8KvLM2FSUKWesC6XcsIpX82NCFpmRCxnN1evodYy5HjkKraON2x1nnVYwANBISKCpwK
         7W2d3u/aHiT+qyWrOmKqxOagK6nJf2k2PHVuTGF7gOmfRw3jNg4wEW3C8fD8IumPLKPm
         zCy+1U3xTFbgFxQtpT/pPFWjWOPrMtUcnSH4y3hUdcHkHf5m56GGm7fiJKjd7iGQbVtu
         iy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=B52IU9V4ss2EkKr2r35b5RX2v2fmhnZiFbREOn0Pscw=;
        b=kPehJKbH34L2gTSW2dEOVGUPW0sR3xBbpKkk3be/PwJB5S94AjNx7W0susRIaGNj10
         DfRKbXrkFx5dORa06Pi+LYc9A0IDsPLlpTjPlDTP7sQtcauO3FwZoj8106f4p3Vg4vy4
         qwSVhkBiKFySbUz6jlb2jPpakkR8f4gSHON88Qx53lc23e4SnCEjApKc8e6pufpDqfqh
         ta6CmP2EZzAZorpLmd9bkYxPABBFnH6h98A8sFVEw/22Ti91I/QnMUrHTxoxg2vAw4R5
         hcHIaeLi1BrsxTLjx3Fjt0NxFaOa4rmLbRvDAjXbIIe1LvsGx2P0FJRQ2hgYgUzBVyVT
         HtBA==
X-Gm-Message-State: AOAM5332AV8f15DWEbaUtzXASMfYRBZLGHJMIjiSlGA6+qzzvGz93BHu
        GLJHohy7wqc17343Yoz5fQs7v4/lNC0=
X-Google-Smtp-Source: ABdhPJyegOdSGz+sy8ry7LkjKXXp+rF/u5yg7PRD40CF04Fv6p6q+o8xIMtKK6+laELuWJuzGA2vrw==
X-Received: by 2002:a1c:de41:: with SMTP id v62mr4501500wmg.135.1607542893908;
        Wed, 09 Dec 2020 11:41:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m81sm5569307wmf.29.2020.12.09.11.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 11:41:33 -0800 (PST)
Message-Id: <35b070b9b7c495caed758362dcdaa61b724c1644.1607542887.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.812.git.1607542887.gitgitgadget@gmail.com>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Dec 2020 19:41:21 +0000
Subject: [PATCH 05/11] merge-ort: add basic outline for process_renames()
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
index 3cdf8124b85..faec29db955 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -620,7 +620,103 @@ static int handle_content_merge(struct merge_options *opt,
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
+		if (i+1 < renames->nr &&
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
+		target_index = pair->score; /* from append_rename_pairs() */
+		assert(target_index == 1 || target_index == 2);
+		other_source_index = 3-target_index;
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

