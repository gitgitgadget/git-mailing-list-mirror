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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB9FC4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 16:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C260227C3
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 16:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501907AbgLNQXb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 11:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440260AbgLNQXL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 11:23:11 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980C3C061257
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 08:21:53 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id m5so17004093wrx.9
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 08:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xM7IreNxcob2fMrsIvxPnMHYtLgjhQjp5pSGZ4CVHAI=;
        b=tSi9wEPdP6lrj+J3aQIo1pTjfjfZ2X/GXaVGV5up1X6sYxBrMj4uptj/k3A9KG2O6a
         QRAMjcghmin5nAXj+xgWhmYMvgBkDO/2YLBYLr9HdlJI1yZkWFlf+S8TqE978P0ONjuE
         wrKib14o+yvxR6RnyDgzeqm9JiyjqrBtT6GIh9ky+KHRMR+2qrzcRPkYQt2Kzqmqk6Ax
         OLfNceT7cCir8puc8ZLOqPRBvKY36Cat3A2KpCcsMW0qdE2wZ1KQzqBjGyMXHiD11QW+
         LeWhVJYn0aCsM2NXI4QMEXiFO5j0O/TfDzNpyqI0VtaDUhbJWFU1Cl9fAO4hDkKo2UbY
         3UxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xM7IreNxcob2fMrsIvxPnMHYtLgjhQjp5pSGZ4CVHAI=;
        b=pibEcZPgPqs2owoJxsktWZyxr3VCSBkCU61U8XIMPeP1Kng+FAHKT6IZzT3AKAf72q
         AfJ6QX07PJxTme8oZmgf4hqEZEFqJfEOnX5WhTTiCnxBlAjfz/0ULiUoHwd73ei01SoV
         zMKkHto75gve6RF9DWO4dqNuHuhvnnfSOylbUUVtjIBB+MhS9LaNA00prjDh8iJsY6Pd
         jBEU36QU/BTo9B089P7W0o9LMzVu3hdQl9IgyTbGNxTL0eBYt/SNCrKGvwn6NbrmZMxe
         s9jtwdfqJZYWke6mZzHXit2Q1FUaVRFNbbid1lhQ2PAi++zakTZFHU53tzxHZEbAxzDK
         NTfg==
X-Gm-Message-State: AOAM531ApCn5Dh0g+ckYFMYTGVk3mTjJ+D522vcoCCzbKJj17pK0SJ8M
        Lm3rA+Ow5a/VudAeSdLpD73rYohawPY=
X-Google-Smtp-Source: ABdhPJycRGOsebt9YcoGKQnRXEo1urth5AtfYlrbRmubChJ43CmHvOVoMsYy3wQdsnma9J2fgxzS+w==
X-Received: by 2002:adf:8184:: with SMTP id 4mr30776075wra.63.1607962912199;
        Mon, 14 Dec 2020 08:21:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c4sm32387659wmf.19.2020.12.14.08.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 08:21:51 -0800 (PST)
Message-Id: <22cb71102614f9d1fdd41a4b9524f11e08afa241.1607962900.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
        <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Dec 2020 16:21:39 +0000
Subject: [PATCH v2 10/11] merge-ort: add implementation of normal rename
 handling
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

Implement handling of normal renames.  This code replaces the following
from merge-recurisve.c:

  * the code relevant to RENAME_NORMAL in process_renames()
  * the RENAME_NORMAL case of process_entry()

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

(To be fair, the code for handling normal renames wasn't all that
complicated beforehand, but it's still much simpler now.)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 4150ccc35e1..9aac33c8e31 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -869,7 +869,11 @@ static int process_renames(struct merge_options *opt,
 					 rename_branch, delete_branch);
 			} else {
 				/* normal rename */
-				die("Not yet implemented");
+				memcpy(&newinfo->stages[other_source_index],
+				       &oldinfo->stages[other_source_index],
+				       sizeof(newinfo->stages[0]));
+				newinfo->filemask |= (1 << other_source_index);
+				newinfo->pathnames[other_source_index] = oldpath;
 			}
 		}
 
-- 
gitgitgadget

