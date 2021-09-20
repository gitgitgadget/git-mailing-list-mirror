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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CB7C433FE
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 23:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B86D261019
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 23:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbhITXio (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 19:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239108AbhITXgi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 19:36:38 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7710DC0EDAF5
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:45:42 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q26so31993617wrc.7
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2zkseZDCrX5eQCOfTAj1pziuYCUVx8n+RzgjO8cPYiw=;
        b=Pssoo3ciHqM41b3nZ13VGtWUScsdC6+w1gU3nbaYAKqtMQBzUzlTrE6x6k7139AkmO
         2oIPVFEMpMA/1TkdL4pndKNQkJfiSwbeHrwzZ90U9vU5qEBXd+oGQ8oVFKshBl/5kHHp
         J5QA0dT4YKuH1nD8uCa4jUJfYx70isy9LNZ/tkpfiuSrQYGixUGNKOtUCsttu2ZINCYQ
         pbEJ04d++vtvUh9qC4ImRTDiwu0Sq+ov+H2gApcxybU7Nups97w0+CPc6vgdKmlxSJVr
         21gGeg+PTitqpqFy5wga7qFKhxN3qo3YuL8D/7V6vbq5OklTpxCNperpsbR4EpMSNzdK
         ZOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2zkseZDCrX5eQCOfTAj1pziuYCUVx8n+RzgjO8cPYiw=;
        b=OW6YZgm0re3Ix4sd9/UMH5VSWXhWztFKBtdk4bKFJC2DXw5InKB2rPWqEidL1BLh1c
         ChMtx2ctz8P8bMfRwhOjtDK+/CokG+MXVIOaO2GoZVFWpQS3gv11WeyvubfkziFKI3qi
         isqfmJT28FHS8OA/aj3/l2cPT+P2jtWE4j7tCVF8n17+ivODpMvare35EUjmVI1E1RhA
         TtbMJDpZZLIFSKfkRmOgVkr2GkKkDpPCbzJ3GPuHApyKsJmaEw+GmwfdDcvQEUnp7aqB
         XR0DYmfOkok0BX4ixoweQOG2oCnlUMUDWRzHmZes06dX0ORYuEAiVEZu0EVRzvyt8Xk7
         91FQ==
X-Gm-Message-State: AOAM5318eOeB/bQUtSDkHPHZ+N6M+j/CaHt+O+juCuD6W/miyB+qYHV6
        jOJnBx+2lDmfOk9IMXbcS678aEtO328=
X-Google-Smtp-Source: ABdhPJxolkYQfZeIlSNkw7ZesZKk84JvC0SbMoU207QtOv8/cMRgqVutq80IRHk99cbJtGKyyQznxA==
X-Received: by 2002:a05:600c:21c2:: with SMTP id x2mr239778wmj.103.1632159941097;
        Mon, 20 Sep 2021 10:45:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a72sm216555wme.5.2021.09.20.10.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 10:45:40 -0700 (PDT)
Message-Id: <b1f6468f9cdb7d16f6317c71b21f4459af158e87.1632159937.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
References: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
        <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 17:45:26 +0000
Subject: [PATCH v3 03/14] dir: extract directory-matching logic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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

