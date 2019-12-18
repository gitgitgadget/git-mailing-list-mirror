Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CD8C2D0D1
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8794320674
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5l1JcIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfLRT3z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:29:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41560 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbfLRT3y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 14:29:54 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so3535135wrw.8
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 11:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+CgvyKrM09apU1qkOsJft1P4o4wqjmDRS+ywvTmG7xU=;
        b=O5l1JcIknAlwSFUbXPiasoHyuf5xCOTOOkqi6bIGieIEOxeWfKfdv8oxviDfs+pbim
         hQkzZLA48k2bqvFh2R4+KCyIr70W2g5Nqpb/gESc45BDHDPImeJEuD5m/qexBi4voyvb
         QCjtrjGA+WIwi5RVUV05CGwUzFEGCqGE07LquAtGb2JiPWYQvv7yIDYAqsMfegTTr9MD
         Xb2u+cORtqJH3E4AtyYY6GWI/76BQNaLMuZZXZq/pgC3hscl5B9TlpmruEZd+QpFFJnl
         fSQ8IvXE3Qps7c6JkyUIcCRfYNJJ+VlxxS0GKSXHvxWF2lfhj3OzL47AGl1NG2ykdQQ4
         vKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+CgvyKrM09apU1qkOsJft1P4o4wqjmDRS+ywvTmG7xU=;
        b=fp7FVG8S4DvpwZt2UHAGpt+bJy2L4eqrhbGxTYXVLKpLt146oqkD4Xgkfhov4YEze/
         NfnuSOpFdAUEsTR32Wq0gZ4Q3miHn5yCLq3lmqGjrwemZUSvcjMQxavFzDpUnDZqOa5x
         Sty7J04sebdY7BNnlvFsq02lf7NbJPPDAlpHV8j+fS8xzSPFc2vx0jW6ZKGyEHL3rn9m
         mYU4AcgKWG+oYm28D6LyFlsG79n5kpZCy8Z2g5D1MVrdBq7GaQxIhHNJQOdMxbC+HIV6
         7ecdKChV9YdlfzpR4kr2hQLne9UcyEKzlO47dpg1OvjkCmfBH5TFPbPHb5tKbs0SFBTX
         mhew==
X-Gm-Message-State: APjAAAV4TR+hsyfrrQoKnlztjKjmI+yfzWED6Qqm5fuFtcXq6GTLerRb
        OBVQQK3XPjAmLbR7WR964qKy5tfl
X-Google-Smtp-Source: APXvYqzqu2HOIYo0bVthV1sRQfnN8oZQnklfKXMAe7Nt9LA1pMy2ibHh65svbtkDV4j8ysu7mfw82A==
X-Received: by 2002:adf:d0c1:: with SMTP id z1mr4838247wrh.371.1576697392175;
        Wed, 18 Dec 2019 11:29:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z18sm3421984wmf.21.2019.12.18.11.29.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 11:29:51 -0800 (PST)
Message-Id: <d2f5623bd71352f3adbf12f211dbae5820b33666.1576697386.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v4.git.git.1576697386.gitgitgadget@gmail.com>
References: <pull.676.v3.git.git.1576571586.gitgitgadget@gmail.com>
        <pull.676.v4.git.git.1576697386.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Dec 2019 19:29:43 +0000
Subject: [PATCH v4 5/8] dir: break part of read_directory_recursive() out for
 reuse
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     blees@dcon.de, gitster@pobox.com, kyle@kyleam.com,
        sxlijin@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Create an add_path_to_appropriate_result_list() function from the code
at the end of read_directory_recursive() so we can use it elsewhere.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 60 ++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/dir.c b/dir.c
index 517a569e10..645b44ea64 100644
--- a/dir.c
+++ b/dir.c
@@ -1932,6 +1932,40 @@ static void close_cached_dir(struct cached_dir *cdir)
 	}
 }
 
+static void add_path_to_appropriate_result_list(struct dir_struct *dir,
+	struct untracked_cache_dir *untracked,
+	struct cached_dir *cdir,
+	struct index_state *istate,
+	struct strbuf *path,
+	int baselen,
+	const struct pathspec *pathspec,
+	enum path_treatment state)
+{
+	/* add the path to the appropriate result list */
+	switch (state) {
+	case path_excluded:
+		if (dir->flags & DIR_SHOW_IGNORED)
+			dir_add_name(dir, istate, path->buf, path->len);
+		else if ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
+			((dir->flags & DIR_COLLECT_IGNORED) &&
+			exclude_matches_pathspec(path->buf, path->len,
+						 pathspec)))
+			dir_add_ignored(dir, istate, path->buf, path->len);
+		break;
+
+	case path_untracked:
+		if (dir->flags & DIR_SHOW_IGNORED)
+			break;
+		dir_add_name(dir, istate, path->buf, path->len);
+		if (cdir->fdir)
+			add_untracked(untracked, path->buf + baselen);
+		break;
+
+	default:
+		break;
+	}
+}
+
 /*
  * Read a directory tree. We currently ignore anything but
  * directories, regular files and symlinks. That's because git
@@ -2035,29 +2069,9 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 			continue;
 		}
 
-		/* add the path to the appropriate result list */
-		switch (state) {
-		case path_excluded:
-			if (dir->flags & DIR_SHOW_IGNORED)
-				dir_add_name(dir, istate, path.buf, path.len);
-			else if ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
-				((dir->flags & DIR_COLLECT_IGNORED) &&
-				exclude_matches_pathspec(path.buf, path.len,
-							 pathspec)))
-				dir_add_ignored(dir, istate, path.buf, path.len);
-			break;
-
-		case path_untracked:
-			if (dir->flags & DIR_SHOW_IGNORED)
-				break;
-			dir_add_name(dir, istate, path.buf, path.len);
-			if (cdir.fdir)
-				add_untracked(untracked, path.buf + baselen);
-			break;
-
-		default:
-			break;
-		}
+		add_path_to_appropriate_result_list(dir, untracked, &cdir,
+						    istate, &path, baselen,
+						    pathspec, state);
 	}
 	close_cached_dir(&cdir);
  out:
-- 
gitgitgadget

