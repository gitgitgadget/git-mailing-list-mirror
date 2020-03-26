Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D78C2D0ED
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 21:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916C420714
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 21:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxWj3fFP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgCZV1v (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:27:51 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39626 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgCZV1t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 17:27:49 -0400
Received: by mail-ed1-f65.google.com with SMTP id a43so8699002edf.6
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 14:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GEY9TL7lTJrR/Du82wrLRvpKVZBjDrenRLjdBqlYW3k=;
        b=lxWj3fFPWsBGZDw8cEZTBoxVH7B3TpOc6l0js9CBV77dpMjDn66z4iyvaL7MqrMP/1
         s6s8ffdISOI+MLmnACYs16VeRWW9JB9ZxlDWofoeveXr2NSmkDUu3MaA8wKG6rHAFZZJ
         95Gk2AvI7Et/ccnDwh7+J5eSBZ1ts9v08WZ4VclayiCeIbpyGXyb+i1vZXjEM6W7MwbF
         W5rU7b7UzItnSuv14WYzZHYeJJgPw39X5OqfjR5NmgU3M10T5AQ4u2n6vpDfXi9vhGkW
         sFWQXjNrcEVEi6fb1987b2UzT5JHk8tHxw4CzI0d4otqKIhrDWCsI55y8Nm46ZM6KaT9
         TzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GEY9TL7lTJrR/Du82wrLRvpKVZBjDrenRLjdBqlYW3k=;
        b=nhYlE/0KNsluGQyjces493fJai7IO8sV4To4IrVOqij7MaWcRyK//9DKre0z9Y2GUo
         QEj4upJwtgkXm9D3YMD9FvVb9Qibk4Ui1AFO90Qs+iRRxfKK6pKhX1X8gIUMfdv6w/fM
         Czpm/PQ2K20xukxQZ4UXxrGg4N7R+YaJs5df8R28WTPjgmT6AemDMd6LENDDWTOlia8d
         2pzEwJF5UQ7kJjVEOJPRxCfPeAOjIdjjXzHQ9OQK3y611R6bJLmZXiqtvumo0SoNIc8Q
         IKmKPZLGVwqFmpo+OrSAitPzVnM9+dzCyHldzINZdE+/fJTd8KASFez4rVaBnbJEl/vT
         KMJg==
X-Gm-Message-State: ANhLgQ1SQKoZcLabqfHl6UZWZSnKIK5GGhXPDNqX2WfEcFT2gYzpwtMm
        Glgj8r3mPTEfVoseugD5uXV+z/9V
X-Google-Smtp-Source: ADFU+vsSBNkUkH98xuxGUCL4gAY3ex/Zl2OmN9sOjoYlL5zuM77C3SdQsEQ8QIq5AYaC5czBNTNwkg==
X-Received: by 2002:a17:906:7d02:: with SMTP id u2mr4918408ejo.71.1585258066838;
        Thu, 26 Mar 2020 14:27:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m21sm520319edb.90.2020.03.26.14.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 14:27:46 -0700 (PDT)
Message-Id: <2603c1a9d13a2ff8c6d719a0f5858211116ef007.1585258061.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com>
References: <pull.700.v3.git.git.1585164718.gitgitgadget@gmail.com>
        <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 Mar 2020 21:27:38 +0000
Subject: [PATCH v4 5/7] dir: fix confusion based on variable tense
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

