Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D522C2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C2D241A7
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBqFAHDB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgKQVut (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgKQVut (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:50:49 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10015C0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:50:49 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 23so2889187wmg.1
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=XxXfj32Ecv2frXptIVP/lnWrnu5gzk4nnJ631zN7c8s=;
        b=mBqFAHDBeGqnbaThs+Yv/TS4lCJGxRqI+/d1+XvEAuu+HPANZ1owJqGKcgMx/KhOED
         U6i9ZDIrzeC9qectylNJX14YmKumKd+R4x4WY9yWCQh2EUdN1/ozseE++KLBh0OxKEZz
         naIzeblHu+Cmkwvns1AbfUinnbrDVB7T9WBk9Rrh9jQKlHt8MAtf0ubQ0kGB19ls7qk8
         IJDX21JYA6X1RosyfBOAtqIX0QFpy5QxTH9fKb4ksdaroPeRbqv9uUUC065qiGSz3RNx
         fd5Nw65Yf4k12b+s0pd+9dq1wngfG0p/2B7rcDOvmoEPyoFAAwyopFcIrBl9ngcz/aiM
         XzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XxXfj32Ecv2frXptIVP/lnWrnu5gzk4nnJ631zN7c8s=;
        b=bSNj4X1/oZzGguUVN8pe0opS5P+OE87O6R2ExEbSVB1HhUgxkpJMIzTX+53idLjT4r
         rCBLZAvL4WSFLHI9FIijMXtawiEy3/k6EYSUGzmmqoq2HJvz1WQjtczCE2yky17N9yZb
         /jqW2MXSvEzIPZ9tb0Cg+narnQ54m8Ol4Uf1eaoIDvnnpuc95LZqQA+/FHYZIX7Aj2Ub
         a9Xt6+jbarcZOY1388KDVoeoo4ltYZ1h+WSP7Jil9dfZGgnQ2hwKScQTc8UVGGEgy+ci
         i3AOnv83377IeebscrX0Vs5jhl+i8rSI5GsySLe34EFKmUVNqEg8e9oo0b+eMENDiKdQ
         F9wQ==
X-Gm-Message-State: AOAM533aYun6folpDn2/oe5EWtGfNhMmTeyS2tlWSiW0PpqWFCpnY1vY
        jO4otj+dJpNyyKKHvEhw5GaYQUB5HeY=
X-Google-Smtp-Source: ABdhPJxaszoFojR3eXGHalLlx+gNp9Zp4YCnMoKpy52qOB0CjY0bjn0BDbveyEC2SUOTjJ/CXBmTLw==
X-Received: by 2002:a1c:e1c6:: with SMTP id y189mr1077852wmg.94.1605649847705;
        Tue, 17 Nov 2020 13:50:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d16sm29396176wrw.17.2020.11.17.13.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:50:47 -0800 (PST)
Message-Id: <pull.916.git.git.1605649846824.gitgitgadget@gmail.com>
From:   "Seija K. via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Nov 2020 21:50:46 +0000
Subject: [PATCH] Make dir_init inline
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Seija K <pi1024e@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija K <pi1024e@github.com>

commit: A void that simply calls another function would be better off as inline.
Plus, dir_init being originally a memset call makes this change more fitting.
Finally, even if a stack trace is made, a memset call will be in said trace anyway.

Signed-off-by: Seija K. <pi1024e@github.com>
---
    Make dir_init inline
    
    commit: A void that simply calls another function would be better off as
    inline. Plus, dir_init being originally a memset call makes this change
    more fitting. Finally, even if a stack trace is made, a memset call will
    be in said trace anyway.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-916%2Fpi1024e%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-916/pi1024e/patch-1-v1
Pull-Request: https://github.com/git/git/pull/916

 dir.c | 11 +++--------
 dir.h |  5 ++++-
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/dir.c b/dir.c
index ebea5f1f91..c9c890785d 100644
--- a/dir.c
+++ b/dir.c
@@ -54,11 +54,6 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 static int resolve_dtype(int dtype, struct index_state *istate,
 			 const char *path, int len);
 
-void dir_init(struct dir_struct *dir)
-{
-	memset(dir, 0, sizeof(*dir));
-}
-
 int count_slashes(const char *s)
 {
 	int cnt = 0;
@@ -167,14 +162,14 @@ static size_t common_prefix_len(const struct pathspec *pathspec)
 			char c = pathspec->items[n].match[i];
 			if (c != pathspec->items[0].match[i])
 				break;
-			if (c == '/')
-				len = i + 1;
 			i++;
+			if (c == '/')
+				len = i;
 		}
 		if (n == 0 || len < max) {
 			max = len;
 			if (!max)
-				break;
+				return 0;
 		}
 	}
 	return max;
diff --git a/dir.h b/dir.h
index a3c40dec51..8da509f42c 100644
--- a/dir.h
+++ b/dir.h
@@ -361,7 +361,10 @@ int match_pathspec(const struct index_state *istate,
 int report_path_error(const char *ps_matched, const struct pathspec *pathspec);
 int within_depth(const char *name, int namelen, int depth, int max_depth);
 
-void dir_init(struct dir_struct *dir);
+static inline void dir_init(struct dir_struct *dir)
+{
+	memset(dir, 0, sizeof(*dir));
+}
 
 int fill_directory(struct dir_struct *dir,
 		   struct index_state *istate,

base-commit: e31aba42fb12bdeb0f850829e008e1e3f43af500
-- 
gitgitgadget
