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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962C8C2BB9A
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 16:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6448122795
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 16:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439900AbgLNQXV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 11:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440195AbgLNQXG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 11:23:06 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35775C06138C
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 08:21:49 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id v14so14284193wml.1
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 08:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7v3XyS7wFDYvaHnBwPBHVVEgN/vtjPftIMXATY8yNR8=;
        b=k/hGyWAhFZ4IKshh43z4wTLqkLgS+EykMm9Cv9UurfaQ3U/rRWvgznNjASjDB6BpfZ
         gm5Ft959hTnKRjNV9CvGffEW5jJaZwgKg0dmuU5rLTHlAjaZ9W0j97vLtOihaNGF3haI
         BkBMZqrs3vtyxNCHda9DrNxE3MdqSQYgUJIYMdhJ4erht7I6q25NjJlaIHRXeJ7rWfQ6
         EULCLFZp6+E66OHLSY0gYgEJQiXZgIEI+AhghyNQWrqfjSRCf0CoKutNuV6GoeH2mMQH
         ymKmoczGOpxvFzvFxzrRT8rTC2S6S26PF+2voxzFzchj4M2jehS8TT7SzfrrDH/cM0Zi
         Eaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7v3XyS7wFDYvaHnBwPBHVVEgN/vtjPftIMXATY8yNR8=;
        b=shkx66Ur1oZzjpWu+lPyDHewKhJqtO95G3ViezPdwEDjnN2tg0oDQzyFYL7jTXVG3Q
         RMtzJj8PlrwvSCnn/OqXMqhGx6BcxzDRs5OT1Lc9NYpCYI6NuIytU4Qr4O365RZyHRtJ
         OdX3gtp9wqFonMlIfpU0CjjZZF7XorAseu/hpBNSMbbprKAe50CvrcND4K9FUntOEcvE
         yFaqJwZHYu8Rq2Q7VsOPJVDQ8G9ePSVmLhDaR7Oe//8DmTyYpTHL9ZpABxto8R327Fwz
         GmGwzKJvGTct72fK1UpYCOLjlEv1YHXiN/MkJAaETr1a4kSFe8iWJckPPCZDIQ2vdgxA
         4w6w==
X-Gm-Message-State: AOAM532e7DMdoZps+RLuxtHLs7N1lBLkYhwiWgH8EtRw+Dx2faxj2vD9
        aCpY4U8UmixL5S4+SEJNGum6gsbCOb4=
X-Google-Smtp-Source: ABdhPJyWMakOkCPgDdHyyiWNJctZi2ZIlMaOwmirsVQeJKtoNbYgQthINF9sT2RGvU4RY6kEYk+QZg==
X-Received: by 2002:a1c:4c0a:: with SMTP id z10mr133730wmf.95.1607962907750;
        Mon, 14 Dec 2020 08:21:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w189sm20214115wmg.31.2020.12.14.08.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 08:21:47 -0800 (PST)
Message-Id: <15fff3dd0c48c301bfcb7fe335fa02fad1c686ab.1607962900.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
        <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Dec 2020 16:21:35 +0000
Subject: [PATCH v2 06/11] merge-ort: add implementation of both sides renaming
 identically
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

Implement rename/rename(1to1) handling, i.e. both sides of history
renaming a file but renaming the same way.  This code replaces the
following from merge-recurisve.c:

  * all the 1to1 code in process_renames()
  * the RENAME_ONE_FILE_TO_ONE case of process_entry()

Also, there is some shared code from merge-recursive.c for multiple
different rename cases which we will no longer need for this case (or
other rename cases):

  * handle_rename_normal()
  * setup_rename_conflict_info()

The consolidation of four separate codepaths into one is made possible
by a change in design: process_renames() tweaks the conflict_info
entries within opt->priv->paths such that process_entry() can then
handle all the non-rename conflict types (directory/file, modify/delete,
etc.) orthogonally.  This means we're much less likely to miss special
implementation of some kind of combination of conflict types (see
commits brought in by 66c62eaec6 ("Merge branch 'en/merge-tests'",
2020-11-18), especially commit ef52778708 ("merge tests: expect improved
directory/file conflict handling in ort", 2020-10-26) for more details).
That, together with letting worktree/index updating be handled
orthogonally in the merge_switch_to_result() function, dramatically
simplifies the code for various special rename cases.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index ebe275ef73c..4034ffcf501 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -674,14 +674,31 @@ static int process_renames(struct merge_options *opt,
 		    !strcmp(oldpath, renames->queue[i+1]->one->path)) {
 			/* Handle rename/rename(1to2) or rename/rename(1to1) */
 			const char *pathnames[3];
+			struct version_info merged;
+			struct conflict_info *base, *side1, *side2;
+			unsigned was_binary_blob = 0;
 
 			pathnames[0] = oldpath;
 			pathnames[1] = newpath;
 			pathnames[2] = renames->queue[i+1]->two->path;
 
+			base = strmap_get(&opt->priv->paths, pathnames[0]);
+			side1 = strmap_get(&opt->priv->paths, pathnames[1]);
+			side2 = strmap_get(&opt->priv->paths, pathnames[2]);
+
+			VERIFY_CI(base);
+			VERIFY_CI(side1);
+			VERIFY_CI(side2);
+
 			if (!strcmp(pathnames[1], pathnames[2])) {
-				/* Both sides renamed the same way. */
-				die("Not yet implemented");
+				/* Both sides renamed the same way */
+				assert(side1 == side2);
+				memcpy(&side1->stages[0], &base->stages[0],
+				       sizeof(merged));
+				side1->filemask |= (1 << MERGE_BASE);
+				/* Mark base as resolved by removal */
+				base->merged.is_null = 1;
+				base->merged.clean = 1;
 
 				/* We handled both renames, i.e. i+1 handled */
 				i++;
-- 
gitgitgadget

