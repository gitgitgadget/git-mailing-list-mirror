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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61554C433FE
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 13:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DE8561209
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 13:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235483AbhILNYx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 09:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbhILNYu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 09:24:50 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71571C061574
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 06:23:35 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id w29so9502165wra.8
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 06:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2zkseZDCrX5eQCOfTAj1pziuYCUVx8n+RzgjO8cPYiw=;
        b=pXJValooYvPuHvgxr2cF2+J6hmqw6variJGni7LBLXuRY+Emr60Wf/V8o9MrQeeQDb
         Qs4iVbPgh87/IjKg1ncNeiBAI5ovPCh6SD2r9rBwAlWhy85cvhW3ZqLUjKS7doyyvzD7
         HPQH1PneEa4OLWUNloA1Y9VSXDfwQyf98eG/0lnxo8IwieOiQtnFGYne6FgFTERG3rlz
         Mn2DmPv3w7N3bt+4Ke1+OhSlwc56+KwR1Y1UKmaKivraSh8Wpp9vJPitfyrvLtCTtoKr
         nYg5/1C+ec2DAaTlIlI2ZzMV6UKL0SE/PiwLTpyfjzrFQG6Y2VE5BZug8qkpfrw/0jex
         SpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2zkseZDCrX5eQCOfTAj1pziuYCUVx8n+RzgjO8cPYiw=;
        b=Hx8y/U22PATgTqNoKLZPQqaovj809XjIICgbRjfnoGJTnrY8UEDLHVjPPxXl/wfo9+
         YhOQBV5ZRWPRy/KRsRp+9Eq/pmslbvJ7rVdDKUDGovoTKMFoppNI6+jBWaN/aCilVzBA
         qsSpxR/iPHRLUYR3zOVjm2n6ZHgnn3mQWjsB9fZB47XWOuqDmWlIercQF/J0C1rqwI2x
         wXbROX7JQNSqdC4/3nva+FRaq/07cRmpuSb64+YYcaqLGoAD7FlMi91Eh6peT4Y7HYOy
         0giO0QzvBJMF8jUqACY927v8AE7sCB62fAOp4qaxgyr0n2LNaU6mSCn29dWUZReXVjMQ
         2kEg==
X-Gm-Message-State: AOAM531Imut8yMT/huFXB4nZrdevW14SmGBIuOt4+YKnlAhR8QYegyz/
        +PlIWzlAG1gPDowQp+Jqc41Tp+ZnP90=
X-Google-Smtp-Source: ABdhPJzXldl0ahwzV0kS+V5R4gp9EgPol3aFVBeRMtfHyM3vkKR+6L+kBqFG011U5w15O7DT92ScCw==
X-Received: by 2002:adf:f911:: with SMTP id b17mr7656703wrr.412.1631453014010;
        Sun, 12 Sep 2021 06:23:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o24sm760912wmm.11.2021.09.12.06.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 06:23:33 -0700 (PDT)
Message-Id: <747b52e7bde1a33953849de233a47a063337548a.1631453010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
        <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 12 Sep 2021 13:23:19 +0000
Subject: [PATCH v2 03/14] dir: extract directory-matching logic
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

The last_matching_pattern_from_list() logic performs some checks on the
filetype of a path within the index when the PATTERN_FLAG_MUSTBEDIR flag
is set. This works great when setting SKIP_WORKTREE bits within
unpack_trees(), but doesn't work well when passing an arbitrary path
such as a file within a matching directory.

This change only rearranges the logic but does not change its
functionality.

We will expand the path_matches_dir_pattern() method in a following
change.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/dir.c b/dir.c
index 86afa2eae00..652135df896 100644
--- a/dir.c
+++ b/dir.c
@@ -1303,6 +1303,19 @@ int match_pathname(const char *pathname, int pathlen,
 				 WM_PATHNAME) == 0;
 }
 
+static int path_matches_dir_pattern(const char *pathname,
+				    int pathlen,
+				    int *dtype,
+				    struct path_pattern *pattern,
+				    struct index_state *istate)
+{
+	*dtype = resolve_dtype(*dtype, istate, pathname, pathlen);
+	if (*dtype != DT_DIR)
+		return 0;
+
+	return 1;
+}
+
 /*
  * Scan the given exclude list in reverse to see whether pathname
  * should be ignored.  The first match (i.e. the last on the list), if
@@ -1327,11 +1340,10 @@ static struct path_pattern *last_matching_pattern_from_list(const char *pathname
 		const char *exclude = pattern->pattern;
 		int prefix = pattern->nowildcardlen;
 
-		if (pattern->flags & PATTERN_FLAG_MUSTBEDIR) {
-			*dtype = resolve_dtype(*dtype, istate, pathname, pathlen);
-			if (*dtype != DT_DIR)
-				continue;
-		}
+		if ((pattern->flags & PATTERN_FLAG_MUSTBEDIR) &&
+		    !path_matches_dir_pattern(pathname, pathlen,
+					      dtype, pattern, istate))
+			continue;
 
 		if (pattern->flags & PATTERN_FLAG_NODIR) {
 			if (match_basename(basename,
-- 
gitgitgadget

