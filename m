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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCEDC432BE
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6368A613BD
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237954AbhHXVzj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237295AbhHXVze (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:55:34 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766CDC061764
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:54:49 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id g135so4389395wme.5
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IFLBnCb01UTxiG6mjxXgFtXahLMWXCrHCCNfFoecSsw=;
        b=XS0Rvta8ka8cmh1XPbGnlrTfI+jx75ZibeWg9fM/oToaHZecdFN5pd6YV95NIEDJuM
         M3jTdvn1dCPEhn4EeqKjkXOmN0sI0qLmqj6J7xxtd0f10W/VhfLnDkB9lIj5G+/vqWqC
         J2WWMdqsSMtEugj8waoKHXRokwuSfhMRHigiVIgPbLymmijZRxugKi0EWVSU9gqCRzax
         blei2QblqLIQ1GWl7WySSzDUuiop4XLnKvRtxVInkTzpwWdUHilh1PoHCf6CUOPnavrd
         P3bV7Codsjuel/TQSjyhJ+BCScc7d4sdIMfL7WfOIQhioiUrBQnZE65pFOlEmFQ0/Nc5
         OStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IFLBnCb01UTxiG6mjxXgFtXahLMWXCrHCCNfFoecSsw=;
        b=oL7egimQ/pCs4Gx21/DsZxgaYD4cKytWDyAnYHKIkCNBODAlqUOnYFDQEdM3I8AfQg
         mKMm+gC6ABpRpfftQjecTywmYOkXXKSsMMb6RZYMlI2SfmZjikW55BxhMeBVce5HD47J
         5Ay+QHvVJS6oXjWh8I/A8KQ3wRhP7d+hXY38JPXbV3UucIkHNKMsc6N21lBvxM6G3d8E
         zDEt74CQnqoEpmGNk/BWr6RS3lmj5LAOhtxSaU89ZM2EwTpMPlh8L1AlCOzzw5LL9P0q
         SH8dKGmZu8cT8TR/NrCRLe4Et4kzsnQn4PE8KQxRb0Gb4c+dHbGZBoNWmMkV8UYXR7S1
         pDbQ==
X-Gm-Message-State: AOAM530Ml9LBENFgyMopX5oDxlqzGx1sZwJrEBMHJ06Db9SsxrIMBq7o
        SuWKyh2pddkK96hWOY/bFikkEE8rupY=
X-Google-Smtp-Source: ABdhPJzj4HjIhc4jDKkZOY/pWMbvE4JmhjEeW6/+HqvPpqFEKiwQ4oWyO6iX0aecjIfnC9WHcuVDBQ==
X-Received: by 2002:a7b:c756:: with SMTP id w22mr6006896wmk.169.1629842088153;
        Tue, 24 Aug 2021 14:54:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n10sm18960265wrw.76.2021.08.24.14.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:54:47 -0700 (PDT)
Message-Id: <d47c7a1cf2a3fa8cfdcfc6be1ac800af123e7efc.1629842085.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 21:54:35 +0000
Subject: [PATCH 03/13] dir: select directories correctly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When matching a path against a list of patterns, the ones that require a
directory match previously did not work when a filename is specified.
This was fine when all pattern-matching was done within methods such as
unpack_trees() that check a directory before recursing into the
contained files. However, other commands will start matching individual
files against pattern lists without that recursive approach.

We modify path_matches_dir_pattern() to take a strbuf 'path_parent' that
is used to store the parent directory of 'pathname' between multiple
pattern matching tests. This is loaded lazily, only on the first pattern
it finds that has the PATTERN_FLAG_MUSTBEDIR flag.

If we find that a path has a parent directory, we start by checking to
see if that parent directory matches the pattern. If so, then we do not
need to query the index for the type (which can be expensive). If we
find that the parent does not match, then we still must check the type
from the index for the given pathname.

Note that this does not affect cone mode pattern matching, but instead
the more general -- and slower -- full pattern set. Thus, this does not
affect the sparse index.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 652135df896..fe5ee87bb5f 100644
--- a/dir.c
+++ b/dir.c
@@ -1305,10 +1305,38 @@ int match_pathname(const char *pathname, int pathlen,
 
 static int path_matches_dir_pattern(const char *pathname,
 				    int pathlen,
+				    struct strbuf *path_parent,
 				    int *dtype,
 				    struct path_pattern *pattern,
 				    struct index_state *istate)
 {
+	/*
+	 * Use 'alloc' as an indicator that the string has not been
+	 * initialized, in case the parent is the root directory.
+	 */
+	if (!path_parent->alloc) {
+		char *slash;
+		strbuf_addstr(path_parent, pathname);
+		slash = find_last_dir_sep(path_parent->buf);
+
+		if (slash)
+			*slash = '\0';
+		else
+			strbuf_setlen(path_parent, 0);
+	}
+
+	/*
+	 * If the parent directory matches the pattern, then we do not
+	 * need to check for dtype.
+	 */
+	if (path_parent->len &&
+	    match_pathname(path_parent->buf, path_parent->len,
+			   pattern->base,
+			   pattern->baselen ? pattern->baselen - 1 : 0,
+			   pattern->pattern, pattern->nowildcardlen,
+			   pattern->patternlen, pattern->flags))
+		return 1;
+
 	*dtype = resolve_dtype(*dtype, istate, pathname, pathlen);
 	if (*dtype != DT_DIR)
 		return 0;
@@ -1331,6 +1359,7 @@ static struct path_pattern *last_matching_pattern_from_list(const char *pathname
 {
 	struct path_pattern *res = NULL; /* undecided */
 	int i;
+	struct strbuf path_parent = STRBUF_INIT;
 
 	if (!pl->nr)
 		return NULL;	/* undefined */
@@ -1340,8 +1369,8 @@ static struct path_pattern *last_matching_pattern_from_list(const char *pathname
 		const char *exclude = pattern->pattern;
 		int prefix = pattern->nowildcardlen;
 
-		if ((pattern->flags & PATTERN_FLAG_MUSTBEDIR) &&
-		    !path_matches_dir_pattern(pathname, pathlen,
+		if (pattern->flags & PATTERN_FLAG_MUSTBEDIR &&
+		    !path_matches_dir_pattern(pathname, pathlen, &path_parent,
 					      dtype, pattern, istate))
 			continue;
 
@@ -1367,6 +1396,7 @@ static struct path_pattern *last_matching_pattern_from_list(const char *pathname
 			break;
 		}
 	}
+	strbuf_release(&path_parent);
 	return res;
 }
 
-- 
gitgitgadget

