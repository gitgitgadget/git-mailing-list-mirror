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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2787EC2BB48
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 18:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5C5122B43
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 18:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731656AbgLOScl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 13:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731097AbgLOS3a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 13:29:30 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA01C061248
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 10:28:15 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 91so20834397wrj.7
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 10:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Mh8IztlLSQ78+8Nle71vq0UevQhQMFaqx6Tg45EiziI=;
        b=kIKU8YQbLtlVNcWpqpHUh0KgDsLyNv1Hqxh4pxTWfWNHovEJv5W4xLQGZdYF4VUMKK
         STHxo1eV3CJy80fEM/APnOR2cImQvufHWIN0JPG8BgMhHYfOpN2G8c3FoCl/LnfQGWsr
         wBOOLD9XL67OmEmu+ppoLLUCLJ+hqJNh1/HtZeWbOFukfgbbO8Tl17baAc58G0fMeCND
         iRXJJTgxp7dTbhRGJ2Pa9Hj9Y45M1gVBWMZiK/uB1khZOFlfhRpU+rJtgKzQF4EdO0HI
         iX3xNdfEtQ6RtyKn5AnTZefBapf+hQq4X+trSzQ24DxjQikunKUqJYOgB5Mnj9Y/H9YV
         zCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Mh8IztlLSQ78+8Nle71vq0UevQhQMFaqx6Tg45EiziI=;
        b=rRtztWhhhUFulGJd//ITRhJV19BEh7XHZnJHWrmW7k0jGwmI6lwz6lRKrggkeIM7RX
         OvG0o12Rz0x7CT5smfEwci5LSNXCigDBxnoV1LgWrHMWV0HIuNax2aMe0aB4UBFYQh0l
         L9BD49j1ItN4R0JXkK8LOYAt9hHrGSbZFceRdPVpRwjN16tp6j+tnZmqe6HOhL3yzr0P
         qJHy7injQtOq2c5G9hzUJp30fOpTFcPPaooym984J53sekOLBVuEpyJeeFpnaHaXAKCr
         /qkQqSWKxJwVXaA9e3e6a7DwNOT6dUU8fsfnwKDo1oW89adXP2PcHNV819o3k0RK/FmD
         3PQA==
X-Gm-Message-State: AOAM532nC8+xYBLU4LB0wvOrrtaHDbR3syFoWNZ6NBatsoFz5ogUBQo9
        cV39nYave43LFIs6de1tWhGs9Him2RI=
X-Google-Smtp-Source: ABdhPJylQmn+pAunLEVFbnHUKolQgrZf34ZAMToT+Q0Xpy1pj10XqhfinJggzZcLkZSpx6HxU9oz/g==
X-Received: by 2002:adf:fb49:: with SMTP id c9mr4056285wrs.72.1608056893540;
        Tue, 15 Dec 2020 10:28:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p9sm32320460wmm.17.2020.12.15.10.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 10:28:13 -0800 (PST)
Message-Id: <7ec51feb4189209bab7912d457a2f54fd0a3cc0e.1608056886.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.812.v3.git.1608056886.gitgitgadget@gmail.com>
References: <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
        <pull.812.v3.git.1608056886.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Dec 2020 18:28:01 +0000
Subject: [PATCH v3 06/11] merge-ort: add implementation of both sides renaming
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
 merge-ort.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index ebe275ef73c..da3715baa63 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -674,14 +674,30 @@ static int process_renames(struct merge_options *opt,
 		    !strcmp(oldpath, renames->queue[i+1]->one->path)) {
 			/* Handle rename/rename(1to2) or rename/rename(1to1) */
 			const char *pathnames[3];
+			struct version_info merged;
+			struct conflict_info *base, *side1, *side2;
 
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

