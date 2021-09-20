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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2111CC433F5
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 23:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06CCC60F48
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 23:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238479AbhITXio (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 19:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239187AbhITXgi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 19:36:38 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B3EC0EDAF6
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:45:43 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q26so31993743wrc.7
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=R+LX9AbeuyjGHg5FPLO2qXiWDcepHFB/ttRN06hA7cg=;
        b=VnivroiR+yh6q8kfta8AmpWn7w6CyHQyZj8rBmyg9giuSUA+QkzgSOZRzqPwh/RSzS
         bY0fCT+ToLHDOBoe+uAfrE6VYCtWeX/mOnKxVJXzA2OQzvj9h/MjE9alA4gOwNuzze4s
         jL1Vf0wtZuxZ4r24YT/xwAkoatf7/oUID2tefuzCPutSEr2ckJ16F5FUob9tsbEVc3F0
         EAjd02SoJTuiQJbydBBJNayL7K4zxU/RGoKI79FX8oyyk0AaU3TgYarm9kKkanKgekp+
         2YR482z9IQSd4idzXPqjRyhzN1kkfK9NSGsELLrcbeEh8Pr16/CwHsQScenkITxadMr2
         sRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=R+LX9AbeuyjGHg5FPLO2qXiWDcepHFB/ttRN06hA7cg=;
        b=E4/oa8dBGmiwJli8FKEYTgkvAnDk+NEohX3TTqNz1iD37zwAhHxyuildoKno8o0ha3
         jYt2UB3iXX+ZAWh8zwMkTT0H97g0s6o1cXkZp11QoORryuNd5heWDLNGXEx5/6UOTfox
         J+xjOTmda9K2wEwojQy68/kyY3ROPtYrqncHgT2xCailYpkHYQ1QxPqXfV/+bMdUJFYb
         Mf0tkUL5vFUxctrnz040rc5wMecDoAGH6Wkc8P/V2f+a7CdICW80c1HVYo0xpW0IIW80
         DFVYuNHVmF3E8cEXtAyhDvLucRgJ0BCTGktkT70i0nXuRs/iiLl9kEGyme/dGgeN6+05
         6Alw==
X-Gm-Message-State: AOAM533T+InuGprwHf+VPFDnyka8B1A+crut0HG+JEYJGYE/bsYA4TBl
        whq+GkoxaVXZf0Toq1n0drFZIUne1Ps=
X-Google-Smtp-Source: ABdhPJyxLqtNjIq43Doze9qBqN2EBfG0PA38dClMgFJMzQY1GK9JiXzZ465rji4Xnnu24uXJ9c1TDA==
X-Received: by 2002:a5d:590a:: with SMTP id v10mr31035825wrd.87.1632159941680;
        Mon, 20 Sep 2021 10:45:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m29sm17776281wrb.89.2021.09.20.10.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 10:45:41 -0700 (PDT)
Message-Id: <0252c7ee15c3cb364a7610b63d74c193cbda0728.1632159937.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
References: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
        <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 17:45:27 +0000
Subject: [PATCH v3 04/14] dir: select directories correctly
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
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

We modify path_matches_dir_pattern() to take a strbuf pointer
'path_parent' that is used to store the parent directory of 'pathname'
between multiple pattern matching tests. This is loaded lazily, only on
the first pattern it finds that has the PATTERN_FLAG_MUSTBEDIR flag.

If we find that a path has a parent directory, we start by checking to
see if that parent directory matches the pattern. If so, then we do not
need to query the index for the type (which can be expensive). If we
find that the parent does not match, then we still must check the type
from the index for the given pathname.

Note that this does not affect cone mode pattern matching, but instead
the more general -- and slower -- full pattern set. Thus, this does not
affect the sparse index.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 652135df896..9ea6cfe61cb 100644
--- a/dir.c
+++ b/dir.c
@@ -1305,10 +1305,35 @@ int match_pathname(const char *pathname, int pathlen,
 
 static int path_matches_dir_pattern(const char *pathname,
 				    int pathlen,
+				    struct strbuf **path_parent,
 				    int *dtype,
 				    struct path_pattern *pattern,
 				    struct index_state *istate)
 {
+	if (!*path_parent) {
+		char *slash;
+		CALLOC_ARRAY(*path_parent, 1);
+		strbuf_add(*path_parent, pathname, pathlen);
+		slash = find_last_dir_sep((*path_parent)->buf);
+
+		if (slash)
+			strbuf_setlen(*path_parent, slash - (*path_parent)->buf);
+		else
+			strbuf_setlen(*path_parent, 0);
+	}
+
+	/*
+	 * If the parent directory matches the pattern, then we do not
+	 * need to check for dtype.
+	 */
+	if ((*path_parent)->len &&
+	    match_pathname((*path_parent)->buf, (*path_parent)->len,
+			   pattern->base,
+			   pattern->baselen ? pattern->baselen - 1 : 0,
+			   pattern->pattern, pattern->nowildcardlen,
+			   pattern->patternlen, pattern->flags))
+		return 1;
+
 	*dtype = resolve_dtype(*dtype, istate, pathname, pathlen);
 	if (*dtype != DT_DIR)
 		return 0;
@@ -1331,6 +1356,7 @@ static struct path_pattern *last_matching_pattern_from_list(const char *pathname
 {
 	struct path_pattern *res = NULL; /* undecided */
 	int i;
+	struct strbuf *path_parent = NULL;
 
 	if (!pl->nr)
 		return NULL;	/* undefined */
@@ -1340,8 +1366,8 @@ static struct path_pattern *last_matching_pattern_from_list(const char *pathname
 		const char *exclude = pattern->pattern;
 		int prefix = pattern->nowildcardlen;
 
-		if ((pattern->flags & PATTERN_FLAG_MUSTBEDIR) &&
-		    !path_matches_dir_pattern(pathname, pathlen,
+		if (pattern->flags & PATTERN_FLAG_MUSTBEDIR &&
+		    !path_matches_dir_pattern(pathname, pathlen, &path_parent,
 					      dtype, pattern, istate))
 			continue;
 
@@ -1367,6 +1393,12 @@ static struct path_pattern *last_matching_pattern_from_list(const char *pathname
 			break;
 		}
 	}
+
+	if (path_parent) {
+		strbuf_release(path_parent);
+		free(path_parent);
+	}
+
 	return res;
 }
 
-- 
gitgitgadget

