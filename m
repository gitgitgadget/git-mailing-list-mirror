Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000F6C2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 18:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB634206F0
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 18:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwX9axg4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgAaSbb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:31:31 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53668 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgAaSba (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 13:31:30 -0500
Received: by mail-wm1-f66.google.com with SMTP id s10so9028537wmh.3
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 10:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kZr6bRchdKE3uJo7GDfpg3MFt0eukyWBsmuwQflY8MA=;
        b=qwX9axg4XhBT9+h2UHd1qON4uwJkZILq3pwMZIIkduo6XWZyNnP3DB6tQrJQa7XfxC
         BbALOFaTYrPUti+ccEJTpLiFB3N0nvXEhLl+8ZtoQn0LItEwj1AZ/JycfA+TYAYmQLt6
         MPVLvLQqrFReN6uoMzhzZ4yBc3Ef4RDUPtwgqK8uG32rSJO1OPBImJjGy3XnV4tJub1Q
         4bBzKuvANNWBsP6AxhOSqnkB4jUZokE9CztwcJ6F0lHj1KCG6E00Uo42RVWcfR/G8E62
         Ha4iz3dfI6bJUSnjkBu28nYpxZ/5tclD6pPBBUnZR3F/URCq7lTlsIXBiy+OKkQYxXuX
         MsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kZr6bRchdKE3uJo7GDfpg3MFt0eukyWBsmuwQflY8MA=;
        b=VSAb1lcHunmESbd6zRss7nCeBGTM2Nyxoi3DtyA1sQ1l2ibC9iqTQeS/fKq7AMncoD
         WF7sGjD06PTmIZ/Wcg7T8OxFqGEX8CmBUcgKKO4QRWJwpHd9xLfNWmBVU7oUQzPEGOYo
         T3uazZEECqJSzt+VmuCRapCXTZlaQYblKdPJDusA/8dzyLEFSGh1T3DrKGn6y8/kX8hH
         pIKv7MjhMPA5KaUYuBoyWtcKRzuMekJF3llr1RlvmhAPNdMpsd3h5Wjd3P1astln0XPB
         hJr0EZRkTXCG4zpC8eAA9NIanM9LrZqPWo/kYPXDaZ1FnGwmKUDHKuxVETogu20HM14U
         uKcw==
X-Gm-Message-State: APjAAAUYGgEL5eBOUAQ9ZxRoaYwUioqb3M9fvo5+wXrCYbsQASJdM8fD
        pQuWClqPOK8I52LCxDTme1LePugd
X-Google-Smtp-Source: APXvYqwUlyc3SMtqjvdU1mYto1no356M/l3Q2V2R+tBfXNB3kDGfmXu6dp3agLT+EkbFO7wkjkVjIw==
X-Received: by 2002:a1c:7406:: with SMTP id p6mr14088887wmc.82.1580495488536;
        Fri, 31 Jan 2020 10:31:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o189sm3824182wme.1.2020.01.31.10.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 10:31:28 -0800 (PST)
Message-Id: <27bc1357964662faeeb1f4cadd31772ed6caf109.1580495486.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.v2.git.git.1580495486.gitgitgadget@gmail.com>
References: <pull.700.git.git.1580335424.gitgitgadget@gmail.com>
        <pull.700.v2.git.git.1580495486.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jan 2020 18:31:21 +0000
Subject: [PATCH v2 1/6] dir: consolidate treat_path() and treat_one_path()
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

Commit 16e2cfa90993 ("read_directory(): further split treat_path()",
2010-01-08) split treat_one_path() out of treat_path(), because
treat_leading_path() would not have access to a dirent but wanted to
re-use as much of treat_path() as possible.  Not re-using all of
treat_path() caused other bugs, as noted in commit b9670c1f5e6b ("dir:
fix checks on common prefix directory", 2019-12-19).  Finally, in commit
ad6f2157f951 ("dir: restructure in a way to avoid passing around a
struct dirent", 2020-01-16), dirents were removed from treat_path() and
other functions entirely.

Since the only reason for splitting these functions was the lack of a
dirent -- which no longer applies to either function -- and since the
split caused problems in the past resulting in us not using
treat_one_path() separately anymore, just undo the split.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 121 ++++++++++++++++++++++++++--------------------------------
 1 file changed, 55 insertions(+), 66 deletions(-)

diff --git a/dir.c b/dir.c
index b460211e61..68c56aeddb 100644
--- a/dir.c
+++ b/dir.c
@@ -1863,21 +1863,65 @@ static int resolve_dtype(int dtype, struct index_state *istate,
 	return dtype;
 }
 
-static enum path_treatment treat_one_path(struct dir_struct *dir,
-					  struct untracked_cache_dir *untracked,
-					  struct index_state *istate,
-					  struct strbuf *path,
-					  int baselen,
-					  const struct pathspec *pathspec,
-					  int dtype)
-{
-	int exclude;
-	int has_path_in_index = !!index_file_exists(istate, path->buf, path->len, ignore_case);
+static enum path_treatment treat_path_fast(struct dir_struct *dir,
+					   struct untracked_cache_dir *untracked,
+					   struct cached_dir *cdir,
+					   struct index_state *istate,
+					   struct strbuf *path,
+					   int baselen,
+					   const struct pathspec *pathspec)
+{
+	strbuf_setlen(path, baselen);
+	if (!cdir->ucd) {
+		strbuf_addstr(path, cdir->file);
+		return path_untracked;
+	}
+	strbuf_addstr(path, cdir->ucd->name);
+	/* treat_one_path() does this before it calls treat_directory() */
+	strbuf_complete(path, '/');
+	if (cdir->ucd->check_only)
+		/*
+		 * check_only is set as a result of treat_directory() getting
+		 * to its bottom. Verify again the same set of directories
+		 * with check_only set.
+		 */
+		return read_directory_recursive(dir, istate, path->buf, path->len,
+						cdir->ucd, 1, 0, pathspec);
+	/*
+	 * We get path_recurse in the first run when
+	 * directory_exists_in_index() returns index_nonexistent. We
+	 * are sure that new changes in the index does not impact the
+	 * outcome. Return now.
+	 */
+	return path_recurse;
+}
+
+static enum path_treatment treat_path(struct dir_struct *dir,
+				      struct untracked_cache_dir *untracked,
+				      struct cached_dir *cdir,
+				      struct index_state *istate,
+				      struct strbuf *path,
+				      int baselen,
+				      const struct pathspec *pathspec)
+{
+	int has_path_in_index, dtype, exclude;
 	enum path_treatment path_treatment;
 
-	dtype = resolve_dtype(dtype, istate, path->buf, path->len);
+	if (!cdir->d_name)
+		return treat_path_fast(dir, untracked, cdir, istate, path,
+				       baselen, pathspec);
+	if (is_dot_or_dotdot(cdir->d_name) || !fspathcmp(cdir->d_name, ".git"))
+		return path_none;
+	strbuf_setlen(path, baselen);
+	strbuf_addstr(path, cdir->d_name);
+	if (simplify_away(path->buf, path->len, pathspec))
+		return path_none;
+
+	dtype = resolve_dtype(cdir->d_type, istate, path->buf, path->len);
 
 	/* Always exclude indexed files */
+	has_path_in_index = !!index_file_exists(istate, path->buf, path->len,
+						ignore_case);
 	if (dtype != DT_DIR && has_path_in_index)
 		return path_none;
 
@@ -1942,61 +1986,6 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 	}
 }
 
-static enum path_treatment treat_path_fast(struct dir_struct *dir,
-					   struct untracked_cache_dir *untracked,
-					   struct cached_dir *cdir,
-					   struct index_state *istate,
-					   struct strbuf *path,
-					   int baselen,
-					   const struct pathspec *pathspec)
-{
-	strbuf_setlen(path, baselen);
-	if (!cdir->ucd) {
-		strbuf_addstr(path, cdir->file);
-		return path_untracked;
-	}
-	strbuf_addstr(path, cdir->ucd->name);
-	/* treat_one_path() does this before it calls treat_directory() */
-	strbuf_complete(path, '/');
-	if (cdir->ucd->check_only)
-		/*
-		 * check_only is set as a result of treat_directory() getting
-		 * to its bottom. Verify again the same set of directories
-		 * with check_only set.
-		 */
-		return read_directory_recursive(dir, istate, path->buf, path->len,
-						cdir->ucd, 1, 0, pathspec);
-	/*
-	 * We get path_recurse in the first run when
-	 * directory_exists_in_index() returns index_nonexistent. We
-	 * are sure that new changes in the index does not impact the
-	 * outcome. Return now.
-	 */
-	return path_recurse;
-}
-
-static enum path_treatment treat_path(struct dir_struct *dir,
-				      struct untracked_cache_dir *untracked,
-				      struct cached_dir *cdir,
-				      struct index_state *istate,
-				      struct strbuf *path,
-				      int baselen,
-				      const struct pathspec *pathspec)
-{
-	if (!cdir->d_name)
-		return treat_path_fast(dir, untracked, cdir, istate, path,
-				       baselen, pathspec);
-	if (is_dot_or_dotdot(cdir->d_name) || !fspathcmp(cdir->d_name, ".git"))
-		return path_none;
-	strbuf_setlen(path, baselen);
-	strbuf_addstr(path, cdir->d_name);
-	if (simplify_away(path->buf, path->len, pathspec))
-		return path_none;
-
-	return treat_one_path(dir, untracked, istate, path, baselen, pathspec,
-			      cdir->d_type);
-}
-
 static void add_untracked(struct untracked_cache_dir *dir, const char *name)
 {
 	if (!dir)
-- 
gitgitgadget

