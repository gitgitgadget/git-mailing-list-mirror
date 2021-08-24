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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E76C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1748613B1
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238467AbhHXVzi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237940AbhHXVzd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:55:33 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD431C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:54:48 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z4so17725884wrr.6
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2zkseZDCrX5eQCOfTAj1pziuYCUVx8n+RzgjO8cPYiw=;
        b=XKUxZZ3boSP7/jEAM+CghcKg56NKPV5nW0JhdHpMakUjlO3dH7GUrg6SrrxTdoSMmi
         MdxFJb3Go1rhDywe+frjHoE4ysL19DffrhTN11Gg/zKUsAzy4W16hF1M/wo+vRT+G5MF
         EJsjLi6/W0E7b1ghQHKYavO3c5z2c8+kws2j84DIkzrbvNxkBoCWXlDRMBwu24MK+3N0
         OqgU8MIQePH2y5zvtAkV57PaqKynqsgL7b/WcYFedo2J6K035Fj/G4e+qmiw5EzeAt0/
         s3ezhJofQio+EcnjGSbtMQ1f0TymkSBNrtRR43R+tVWkgz8sNgQY8EfjrTVq51OE3KO1
         tf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2zkseZDCrX5eQCOfTAj1pziuYCUVx8n+RzgjO8cPYiw=;
        b=WHeXs+c+eU1nBxXP7KqstsdhOzo39iiOMop2Krd0cwhB/DMkFBr5bmi+Z/HRknLYPY
         VImF3UE0WhAfAVh1Y3WvFT1h4pyj90zrLR2u/wNfhYhK6HwfQHThDm+B1mnxwOFgwxE9
         g3DwWODPI8vQuEj4zHEwd6EOjDpRFSOgcj10V9CrSu3gQth0tsobEdyKs/B+3WRBh/cR
         4F7clePXtIz7qBvlw/WJEJZYti/d3+hN6Hi4SY0J21MKn+jr778QgGfa6GUxQjQ/dNpr
         jD8Bt99hscioOIjZEf2rJVDO4M39X7MtZMZNPtY5KqgnmiXR2sCyI6ix1TpDoHUH265a
         A4IQ==
X-Gm-Message-State: AOAM533bW2woSkgTqnaUnDKKJ81P8zjR5/f7ajnRiVni2TE63uJNKf5z
        L0vfs9lSNIixzQQr4B8Z3iTnPZsPflw=
X-Google-Smtp-Source: ABdhPJyDH7iW0WDMEABL3GOIQAfwyrmQ/LFITuOoI5hVu04Sz35jNfzTEgOCDTmIqmlacnQBYAoXag==
X-Received: by 2002:a5d:460a:: with SMTP id t10mr16685919wrq.147.1629842087570;
        Tue, 24 Aug 2021 14:54:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m4sm3512530wml.28.2021.08.24.14.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:54:47 -0700 (PDT)
Message-Id: <8cca5bcf405f220ef899ec44d01fee4d588c7a38.1629842085.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 21:54:34 +0000
Subject: [PATCH 02/13] dir: extract directory-matching logic
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

