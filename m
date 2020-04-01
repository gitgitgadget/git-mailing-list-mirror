Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC333C2BA13
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 04:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C3B20772
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 04:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTbybZS/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731753AbgDAESB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 00:18:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35124 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731736AbgDAER7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 00:17:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id d5so28953376wrn.2
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 21:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0PzgJJZPOGG6lyAtxyIAItGuCZ7jBfDOmHMPoDaMBAo=;
        b=hTbybZS/9izxRU3PB0WFYczQGN0TVnJgmxLFmkNa1HhEThen36tzQwF98YGTjtoZgb
         w3S6bygLb8KM4NvssAYLY0HulYSudv43iVqF57SdTsV3yJjjfijopD31qaj7X3cj7zmp
         0buA8Oe1Ydw/EeJRzuVMN+s45YdR8oSx3ZsOKYrVOhjVuaHl43l2QXjzikPLQScw7gTZ
         gHqWu6fGNqkIsyep+1jyndi3pUU9qdwVnfAOgrQ8G1iSWQ+5lEdTugnH/kpSR0Ht9czF
         2eEeRwC6qFwKS2AC50SOI24u4GuD7g2iyVNAEhaf+yj9mLCbMafgYsPDXywn1CEiRpaf
         RFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0PzgJJZPOGG6lyAtxyIAItGuCZ7jBfDOmHMPoDaMBAo=;
        b=Ehzbhbgt+A2ajTo89z94FMTXxMw9Hug6EHbwzNxV2tKMqWj+MPu4oHjPrSslxwdbdh
         PPoI3KWZbPPV0qRz3Nl5tdCMQ3WA8/wnmug+OIc86gmEdaNUK2MmLf7hq0T84Elvamgz
         i662YHgZDdQPKsCX1IKW3wWKx83FzFL8YZUGHalRLvyMUHx0Y3qwkBM/SZE6FKdFR9zH
         gA4geJKmob2m26Tx5UfXa/zLFdiFsH6sIMkbMzc3tD3leWqhXlLRUUDOTzMM0PpPqHZF
         /zVAxtjeCGk7aDi91++U1lsfnMDcxxZlb2JM7cDYocgAEKZkoZAwBKRbeJP9mG07sPvr
         Cjog==
X-Gm-Message-State: ANhLgQ320Rr0u5TDhOfZjEIARjHEC/2h5XVwxdog5MyYKGXlP+CVEzZ4
        ADBrvPE8qS8w7kWg5b0GzZSeJMcA
X-Google-Smtp-Source: ADFU+vsd8hCQzPmCxUlO6Uw2g1Xf+eKhbhTIcjGHTclJkdTWD5eiNaa/9EcgjDiY4lnEqBbNeylzHA==
X-Received: by 2002:a5d:55c4:: with SMTP id i4mr24822244wrw.170.1585714676979;
        Tue, 31 Mar 2020 21:17:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w204sm991277wma.1.2020.03.31.21.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 21:17:56 -0700 (PDT)
Message-Id: <61d9c9d758e90c6afdaa1605b191f367650d18f0.1585714667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.v5.git.git.1585714667.gitgitgadget@gmail.com>
References: <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com>
        <pull.700.v5.git.git.1585714667.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Apr 2020 04:17:45 +0000
Subject: [PATCH v5 11/12] Fix error-prone fill_directory() API; make it only
 return matches
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

Traditionally, the expected calling convention for the dir.c API was:

    fill_directory(&dir, ..., pathspec)
    foreach entry in dir->entries:
        if (dir_path_match(entry, pathspec))
            process_or_display(entry)

This may have made sense once upon a time, because the fill_directory() call
could use cheap checks to avoid doing full pathspec matching, and an external
caller may have wanted to do other post-processing of the results anyway.
However:

    * this structure makes it easy for users of the API to get it wrong

    * this structure actually makes it harder to understand
      fill_directory() and the functions it uses internally.  It has
      tripped me up several times while trying to fix bugs and
      restructure things.

    * relying on post-filtering was already found to produce wrong
      results; pathspec matching had to be added internally for multiple
      cases in order to get the right results (see commits 404ebceda01c
      (dir: also check directories for matching pathspecs, 2019-09-17)
      and 89a1f4aaf765 (dir: if our pathspec might match files under a
      dir, recurse into it, 2019-09-17))

    * it's bad for performance: fill_directory() already has to do lots
      of checks and knows the subset of cases where it still needs to do
      more checks.  Forcing external callers to do full pathspec
      matching means they must re-check _every_ path.

So, add the pathspec matching within the fill_directory() internals, and
remove it from external callers.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/clean.c    |  6 ------
 builtin/grep.c     |  2 --
 builtin/ls-files.c |  5 +++--
 builtin/stash.c    | 17 +++++------------
 dir.c              |  9 ++++++++-
 wt-status.c        |  6 ++----
 6 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 5abf087e7c4..b189b7b4ea0 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -989,12 +989,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		if (!cache_name_is_other(ent->name, ent->len))
 			continue;
 
-		if (pathspec.nr)
-			matches = dir_path_match(&the_index, ent, &pathspec, 0, NULL);
-
-		if (pathspec.nr && !matches)
-			continue;
-
 		if (lstat(ent->name, &st))
 			die_errno("Cannot lstat '%s'", ent->name);
 
diff --git a/builtin/grep.c b/builtin/grep.c
index 50ce8d94612..f3425102999 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -691,8 +691,6 @@ static int grep_directory(struct grep_opt *opt, const struct pathspec *pathspec,
 
 	fill_directory(&dir, opt->repo->index, pathspec);
 	for (i = 0; i < dir.nr; i++) {
-		if (!dir_path_match(opt->repo->index, dir.entries[i], pathspec, 0, NULL))
-			continue;
 		hit |= grep_file(opt, dir.entries[i]->name);
 		if (hit && opt->status_only)
 			break;
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index f069a028cea..b87c22ac240 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -128,8 +128,9 @@ static void show_dir_entry(const struct index_state *istate,
 	if (len > ent->len)
 		die("git ls-files: internal error - directory entry not superset of prefix");
 
-	if (!dir_path_match(istate, ent, &pathspec, len, ps_matched))
-		return;
+	/* If ps_matches is non-NULL, figure out which pathspec(s) match. */
+	if (ps_matched)
+		dir_path_match(istate, ent, &pathspec, len, ps_matched);
 
 	fputs(tag, stdout);
 	write_eolinfo(istate, NULL, ent->name);
diff --git a/builtin/stash.c b/builtin/stash.c
index 4ad3adf4ba5..704740b245c 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -856,30 +856,23 @@ static int get_untracked_files(const struct pathspec *ps, int include_untracked,
 			       struct strbuf *untracked_files)
 {
 	int i;
-	int max_len;
 	int found = 0;
-	char *seen;
 	struct dir_struct dir;
 
 	memset(&dir, 0, sizeof(dir));
 	if (include_untracked != INCLUDE_ALL_FILES)
 		setup_standard_excludes(&dir);
 
-	seen = xcalloc(ps->nr, 1);
-
-	max_len = fill_directory(&dir, the_repository->index, ps);
+	fill_directory(&dir, the_repository->index, ps);
 	for (i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
-		if (dir_path_match(&the_index, ent, ps, max_len, seen)) {
-			found++;
-			strbuf_addstr(untracked_files, ent->name);
-			/* NUL-terminate: will be fed to update-index -z */
-			strbuf_addch(untracked_files, '\0');
-		}
+		found++;
+		strbuf_addstr(untracked_files, ent->name);
+		/* NUL-terminate: will be fed to update-index -z */
+		strbuf_addch(untracked_files, '\0');
 		free(ent);
 	}
 
-	free(seen);
 	free(dir.entries);
 	free(dir.ignored);
 	clear_directory(&dir);
diff --git a/dir.c b/dir.c
index a67930dcff6..2de64910401 100644
--- a/dir.c
+++ b/dir.c
@@ -2117,7 +2117,14 @@ static enum path_treatment treat_path(struct dir_struct *dir,
 				       baselen, excluded, pathspec);
 	case DT_REG:
 	case DT_LNK:
-		return excluded ? path_excluded : path_untracked;
+		if (excluded)
+			return path_excluded;
+		if (pathspec &&
+		    !do_match_pathspec(istate, pathspec, path->buf, path->len,
+				       0 /* prefix */, NULL /* seen */,
+				       0 /* flags */))
+			return path_none;
+		return path_untracked;
 	}
 }
 
diff --git a/wt-status.c b/wt-status.c
index cc6f94504d9..98dfa6f73f9 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -722,16 +722,14 @@ static void wt_status_collect_untracked(struct wt_status *s)
 
 	for (i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
-		if (index_name_is_other(istate, ent->name, ent->len) &&
-		    dir_path_match(istate, ent, &s->pathspec, 0, NULL))
+		if (index_name_is_other(istate, ent->name, ent->len))
 			string_list_insert(&s->untracked, ent->name);
 		free(ent);
 	}
 
 	for (i = 0; i < dir.ignored_nr; i++) {
 		struct dir_entry *ent = dir.ignored[i];
-		if (index_name_is_other(istate, ent->name, ent->len) &&
-		    dir_path_match(istate, ent, &s->pathspec, 0, NULL))
+		if (index_name_is_other(istate, ent->name, ent->len))
 			string_list_insert(&s->ignored, ent->name);
 		free(ent);
 	}
-- 
gitgitgadget

