Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A622C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 10:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F642082E
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 10:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdFTLyqd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfLQKlN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 05:41:13 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39091 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbfLQKlL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 05:41:11 -0500
Received: by mail-wm1-f68.google.com with SMTP id b72so2522250wme.4
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 02:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=29+HNaPjh/ujoDPjCFFrHwStMkfYBo9x+NVi95MwpCE=;
        b=GdFTLyqd3dAWs3OzSBMUKlfeuUSFygfx4n/oDHbfqHcvm8k0GM4VHPyUNmJv1zQkzK
         Pkr+bXEE/5K+0HlJ7jgSCd66OcuNwMr2vJefdK3Gf6kZuhWAxtvoQ+XVEr6uSQ9xXz7Q
         FNWuTb+u4Plkj2nkKehiRi4Kxg3N6RbNSVuLeWnzb6n6gwWQeE0feoeDNMcxJrJWCb8P
         G1if/xVxUEV0w1hKviYreAmwuKz1OkZVkpRwxxF/v9wRJST0+6iaXcLxrKlf1RNk+glh
         JoDX4R53fp5g+mMYgRu1Wn3grNDvAD9e5XXZ5Rb1IAnJmMw3Cxayd3pvBN2SOzIiGGkS
         LtTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=29+HNaPjh/ujoDPjCFFrHwStMkfYBo9x+NVi95MwpCE=;
        b=AlfOna+lPS1IsW2hlcWPHpeP8G3qtL8MzSMoKuF7y3cGVlt2lp0A2TH76HeMN56wMJ
         4dsa790OEtPlqbOn4cvpasYH/y/xu0PwSyLjT2vxbS2QWmcx2LZUmte6hFBzE/dWnUac
         ha9/xr2NmR7oCKosVHIlYkzu737OJgv0+7JLx6kXWccidXZ8F6vowWRI70MvgFnSIEpi
         njLxnttN/uJfkyTdVbkZ0CTWlm5gg7i14yrdmL0rwCN97mAQghTcP/eSoOVhdwGroaK6
         giqvORCB88zjWNTtspUPhMYM6FrGvw4vYUyxVqRZTRPgOGHCvlb/nji/K4cPNj7G6jiz
         4a0Q==
X-Gm-Message-State: APjAAAXk25rHpcvbwETRdCudXuf2z+zwJGSb4m5i0DAuNn5MOkNoE5oR
        h+eNv/rckHgzWnoED/T6Ia6cLPA2
X-Google-Smtp-Source: APXvYqyLFSxqPn4pUNBmNVO5PtRvxIndvFtzFsmBdxXQtjmT7LX0WXMOLbgnxu/i9wSpwL2Bkqixbw==
X-Received: by 2002:a1c:ded6:: with SMTP id v205mr4645542wmg.86.1576579269696;
        Tue, 17 Dec 2019 02:41:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p15sm2401745wma.40.2019.12.17.02.41.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 02:41:09 -0800 (PST)
Message-Id: <40c00302f67ed927317fb5955e13690328e2f4e8.1576579264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.174.git.1576579264.gitgitgadget@gmail.com>
References: <pull.174.git.1576579264.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Dec 2019 10:41:01 +0000
Subject: [PATCH 4/7] built-in stash: use the built-in `git add -p` if so
 configured
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The scripted version of `git stash` called directly into the Perl script
`git-add--interactive.perl`, and this was faithfully converted to C.

However, we have a much better way to do this now: call the internal API
directly, which will now incidentally also respect the
`add.interactive.useBuiltin` setting. Let's just do this.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/stash.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 4e806176b0..2dafd97766 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -999,9 +999,9 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
 {
 	int ret = 0;
 	struct child_process cp_read_tree = CHILD_PROCESS_INIT;
-	struct child_process cp_add_i = CHILD_PROCESS_INIT;
 	struct child_process cp_diff_tree = CHILD_PROCESS_INIT;
 	struct index_state istate = { NULL };
+	char *old_index_env = NULL, *old_repo_index_file;
 
 	remove_path(stash_index_path.buf);
 
@@ -1015,16 +1015,19 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
 	}
 
 	/* Find out what the user wants. */
-	cp_add_i.git_cmd = 1;
-	argv_array_pushl(&cp_add_i.args, "add--interactive", "--patch=stash",
-			 "--", NULL);
-	add_pathspecs(&cp_add_i.args, ps);
-	argv_array_pushf(&cp_add_i.env_array, "GIT_INDEX_FILE=%s",
-			 stash_index_path.buf);
-	if (run_command(&cp_add_i)) {
-		ret = -1;
-		goto done;
-	}
+	old_repo_index_file = the_repository->index_file;
+	the_repository->index_file = stash_index_path.buf;
+	old_index_env = xstrdup_or_null(getenv(INDEX_ENVIRONMENT));
+	setenv(INDEX_ENVIRONMENT, the_repository->index_file, 1);
+
+	ret = run_add_interactive(NULL, "--patch=stash", ps);
+
+	the_repository->index_file = old_repo_index_file;
+	if (old_index_env && *old_index_env)
+		setenv(INDEX_ENVIRONMENT, old_index_env, 1);
+	else
+		unsetenv(INDEX_ENVIRONMENT);
+	FREE_AND_NULL(old_index_env);
 
 	/* State of the working tree. */
 	if (write_index_as_tree(&info->w_tree, &istate, stash_index_path.buf, 0,
-- 
gitgitgadget

