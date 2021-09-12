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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A94BC433F5
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 13:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 538106113E
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 13:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235512AbhILNYy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 09:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbhILNYu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 09:24:50 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A661C061757
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 06:23:36 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id b21-20020a1c8015000000b003049690d882so2107483wmd.5
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 06:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IFLBnCb01UTxiG6mjxXgFtXahLMWXCrHCCNfFoecSsw=;
        b=YY7fRQlCz/Cs5G0c0zcZauUQTePi7jczQCVgvelGP54C1i6l2vP9AUt1h66gTIusqT
         HPkjhnssWSTkE/0yJFpQvHhIal+fUIhDuQ7QPxrlk6ZLKg9qfpc9iEiilrw4bjjfRh2H
         cFdvLtT9/PrU7PyOdi33en0xm/gnC3ydlJgUbcI9ZyFd9cJOGNcH3RU15OQVRan+zfyd
         vQn3yLIrVHm5Im11fpvVwDNUJGA3crwo34E5U2XCm0ra7S8OXePtTf17d1JGiUcimn9D
         7FLsHqtQFRgC7216tLluFGLjg/abVxF6vIBlEStowCKUnsm3P2vw4NXROkEzNGAFbO3s
         vp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IFLBnCb01UTxiG6mjxXgFtXahLMWXCrHCCNfFoecSsw=;
        b=0Ngreeww0c07KM4+uTQibwxZyJr2nNSNhh9BTCg0UVg4NMXe4cuuYFtfkyJHqdwYAE
         w7vVMh9HFCoITcwu85VmLDruEHt+PvXVP3HwUcMiZxTUlaOomN8DKe6a09Dhx6UTzR/y
         RV3vXJvKZwnx2LR2tOXv8MhncEsV8udPSYDQydp8Z8IpKqauKKQ6iJttOHqBG2voVDdj
         ui002WBhkzHjuE82aKpzhBzN4c8wa4j3UxEEny59AR2ZQ2honIZ+R5Nik6nY7l7qgtiF
         x9mXkCjl3G6UdzM6sOjXl3eFGUN07ebx9Sfd2qV1XWKD33ZCz8lGXZXL4jU4nRCF2nyd
         BCmg==
X-Gm-Message-State: AOAM530LxHkttmt+Dp+or4JurmDMIYT+w2pWoQbJcHAs/DFcr0tIxT7T
        COaF+q0noCrmoL4BtaIP2fkUOTkuv4E=
X-Google-Smtp-Source: ABdhPJxWFwBkS9V2tnR8mF41eMPe8f4RXmoeKxXpyIINOdwzFFN2a6v2Z5aYSgWDIZmx0zQczwfKNg==
X-Received: by 2002:a05:600c:a49:: with SMTP id c9mr6580531wmq.159.1631453014645;
        Sun, 12 Sep 2021 06:23:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l3sm4088299wms.4.2021.09.12.06.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 06:23:34 -0700 (PDT)
Message-Id: <723de4e42582afbe841ed96470fc02db44b24b5e.1631453010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
        <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 12 Sep 2021 13:23:20 +0000
Subject: [PATCH v2 04/14] dir: select directories correctly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
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

