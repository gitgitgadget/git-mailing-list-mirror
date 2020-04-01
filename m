Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72E1C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 04:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE18E20772
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 04:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaNhaKQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731729AbgDAER4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 00:17:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40405 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgDAER4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 00:17:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id a81so5567639wmf.5
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 21:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GEY9TL7lTJrR/Du82wrLRvpKVZBjDrenRLjdBqlYW3k=;
        b=eaNhaKQxyXOdhH5Ac1sSdYETBbkekXLU8QeL2oXzwvIpCkF+0ohv9U+6LteHvfTioD
         KzuyISzo/OQyly+lpQfutsBvMSI/QwxFq1WFhbKZ9ESw6L2JEn5wjyn10IJcgPY2cnzz
         dAq3ZwFYe/v7UarHOE5u8p1bYD7uSERQuHZ1oItz9+LNCmNzN53kZVrU9UUBzI0MR0D8
         tpt6qTrRmv0nTK7+D5Rnpvt92IujwNFvGgpSVTGRcgzU0HlwU2IZYF9yLIRFuw5RI8UX
         Te6wqI4dlNTl/71N0N4tQeFdfI2GpKtHm9dq7WG8h0uYkEXKJr0OTmkYELttU5HEbu//
         8kkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GEY9TL7lTJrR/Du82wrLRvpKVZBjDrenRLjdBqlYW3k=;
        b=OCL8aIJL9FI7fA3dF9PlpN3HxNkhJM/g7Ryd3QKKzHkyMnylv+erxr8iJqU00X3Sq2
         QxbU1zWTcvxgTIZ9lmyE25N+CwJm4bvoyvj7L8rhA3mMc++YbRpz6i5TB+iybIZax/sb
         4OHQFfOe9aM8rgd9a72OwO3FbnD2QYPD63U1Oc0eU3ac37H8p/smzv3FGYr/D/jj8OFO
         PJH4/A5zWAkmKbt2uzNjEXFY5tPSM+uarIfSxr9u845kXve8SMA5Q40xFeWc1EW19POC
         543HwtbPz3xM68Gawi2IkYsyn1n5xYCxh/0f/v3Vn1oRhRmxVRExmaiKrj5j/c69nXKJ
         7JGg==
X-Gm-Message-State: AGi0PuaQW6hLUfHHtruFgbY4qJK7cayitlBPHt9NisxeHLc2crjwP9R0
        AtzCnRcf5kELA6wXsisI9Xvb8rSF
X-Google-Smtp-Source: APiQypJMD34nPw0EDXY+Jc2HRdJOIfQp35rxms1Ky2U/CuUV8pTrkDNAfKXolgrZ3fsXYmCIJn17ng==
X-Received: by 2002:a05:600c:220f:: with SMTP id z15mr2226344wml.185.1585714673310;
        Tue, 31 Mar 2020 21:17:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o16sm1215148wrs.44.2020.03.31.21.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 21:17:52 -0700 (PDT)
Message-Id: <62dae938c8f21bc01c2e79052827920d99189422.1585714667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.v5.git.git.1585714667.gitgitgadget@gmail.com>
References: <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com>
        <pull.700.v5.git.git.1585714667.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Apr 2020 04:17:40 +0000
Subject: [PATCH v5 06/12] dir: fix confusion based on variable tense
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Martin Melka <martin.melka@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Despite having contributed several fixes in this area, I have for months
(years?) assumed that the "exclude" variable was a directive; this
caused me to think of it as a different mode we operate in and left me
confused as I tried to build up a mental model around why we'd need such
a directive.  I mostly tried to ignore it while focusing on the pieces I
was trying to understand.

Then I finally traced this variable all back to a call to is_excluded(),
meaning it was actually functioning as an adjective.  In particular, it
was a checked property ("Does this path match a rule in .gitignore?"),
rather than a mode passed in from the caller.  Change the variable name
to match the part of speech used by the function called to define it,
which will hopefully make these bits of code slightly clearer to the
next reader.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/dir.c b/dir.c
index 3a367683661..8074e651e6f 100644
--- a/dir.c
+++ b/dir.c
@@ -1656,7 +1656,7 @@ static enum exist_status directory_exists_in_index(struct index_state *istate,
 static enum path_treatment treat_directory(struct dir_struct *dir,
 	struct index_state *istate,
 	struct untracked_cache_dir *untracked,
-	const char *dirname, int len, int baselen, int exclude,
+	const char *dirname, int len, int baselen, int excluded,
 	const struct pathspec *pathspec)
 {
 	int nested_repo = 0;
@@ -1679,13 +1679,13 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 		}
 		if (nested_repo)
 			return ((dir->flags & DIR_SKIP_NESTED_GIT) ? path_none :
-				(exclude ? path_excluded : path_untracked));
+				(excluded ? path_excluded : path_untracked));
 
 		if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
 			break;
-		if (exclude &&
-			(dir->flags & DIR_SHOW_IGNORED_TOO) &&
-			(dir->flags & DIR_SHOW_IGNORED_TOO_MODE_MATCHING)) {
+		if (excluded &&
+		    (dir->flags & DIR_SHOW_IGNORED_TOO) &&
+		    (dir->flags & DIR_SHOW_IGNORED_TOO_MODE_MATCHING)) {
 
 			/*
 			 * This is an excluded directory and we are
@@ -1713,7 +1713,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	/* This is the "show_other_directories" case */
 
 	if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
-		return exclude ? path_excluded : path_untracked;
+		return excluded ? path_excluded : path_untracked;
 
 	untracked = lookup_untracked(dir->untracked, untracked,
 				     dirname + baselen, len - baselen);
@@ -1723,7 +1723,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	 * the directory contains any files.
 	 */
 	return read_directory_recursive(dir, istate, dirname, len,
-					untracked, 1, exclude, pathspec);
+					untracked, 1, excluded, pathspec);
 }
 
 /*
@@ -1904,7 +1904,7 @@ static enum path_treatment treat_path(struct dir_struct *dir,
 				      int baselen,
 				      const struct pathspec *pathspec)
 {
-	int has_path_in_index, dtype, exclude;
+	int has_path_in_index, dtype, excluded;
 	enum path_treatment path_treatment;
 
 	if (!cdir->d_name)
@@ -1949,13 +1949,13 @@ static enum path_treatment treat_path(struct dir_struct *dir,
 	    (directory_exists_in_index(istate, path->buf, path->len) == index_nonexistent))
 		return path_none;
 
-	exclude = is_excluded(dir, istate, path->buf, &dtype);
+	excluded = is_excluded(dir, istate, path->buf, &dtype);
 
 	/*
 	 * Excluded? If we don't explicitly want to show
 	 * ignored files, ignore it
 	 */
-	if (exclude && !(dir->flags & (DIR_SHOW_IGNORED|DIR_SHOW_IGNORED_TOO)))
+	if (excluded && !(dir->flags & (DIR_SHOW_IGNORED|DIR_SHOW_IGNORED_TOO)))
 		return path_excluded;
 
 	switch (dtype) {
@@ -1965,7 +1965,7 @@ static enum path_treatment treat_path(struct dir_struct *dir,
 		strbuf_addch(path, '/');
 		path_treatment = treat_directory(dir, istate, untracked,
 						 path->buf, path->len,
-						 baselen, exclude, pathspec);
+						 baselen, excluded, pathspec);
 		/*
 		 * If 1) we only want to return directories that
 		 * match an exclude pattern and 2) this directory does
@@ -1974,7 +1974,7 @@ static enum path_treatment treat_path(struct dir_struct *dir,
 		 * recurse into this directory (instead of marking the
 		 * directory itself as an ignored path).
 		 */
-		if (!exclude &&
+		if (!excluded &&
 		    path_treatment == path_excluded &&
 		    (dir->flags & DIR_SHOW_IGNORED_TOO) &&
 		    (dir->flags & DIR_SHOW_IGNORED_TOO_MODE_MATCHING))
@@ -1982,7 +1982,7 @@ static enum path_treatment treat_path(struct dir_struct *dir,
 		return path_treatment;
 	case DT_REG:
 	case DT_LNK:
-		return exclude ? path_excluded : path_untracked;
+		return excluded ? path_excluded : path_untracked;
 	}
 }
 
-- 
gitgitgadget

