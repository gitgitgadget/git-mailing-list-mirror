Return-Path: <SRS0=8Spe=7U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8BAC433DF
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 16:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 978D820663
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 16:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s9f/cU1W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgFGQSj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Jun 2020 12:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgFGQSi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jun 2020 12:18:38 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBF9C08C5C3
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 09:18:38 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y20so6301251wmi.2
        for <git@vger.kernel.org>; Sun, 07 Jun 2020 09:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=vYkfg5aAAuluIAwGdtjdiPgSV0EbVbyNaBO3CIqxgLA=;
        b=s9f/cU1WI/gfU42OzvARcor6UlMaAhVkEqhGDjrxWAucqYYpB34IpQmhG4TqyNQBKo
         8hbFBECxCueK8oc1SMRRMoOIE0lgrzT6yaTfQcVpWEDJHSiDzjZ5EDaKSWPARgO7R+x6
         hjWVYYH6dTwzMBkUd1mc4kT1fRIXSUg62PU5B7g9SMeUSq/X+XVT4UQqStXeRmnsINdC
         jnJgx7GTzq2CpvGmyvWPyf16GCi4wrrX4thtGeYJGMnnJHUqhgGDo9Arkv2ITYXSURPE
         PSWoyODwa5R28dAWo4FfrqG+avwEgaxPPDAHKf9NQEOOE1oM/j9oPRcKtEFSsxpNK5uB
         vPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vYkfg5aAAuluIAwGdtjdiPgSV0EbVbyNaBO3CIqxgLA=;
        b=HLld4MnqsAh8pUhM8l19ntejQE1ZYqObwitibZqjQW9W5Qp8PMfXmu2v3XUQIZ+wdE
         AWAKoPe6MMS2Un5o68vTtQA+hRpe7eoj9FHacF8/S3f9Qgz16vh4/meqDDkst1ClUYen
         x/VZgAzfbIbHml2IHxjioCrhX5+1c0BUs1IGxXsx1xaB8g3T7dTOjCvmfnf82xLuWbjb
         oH8eVzhvTOmPfRXM2fNIiN9ZzH3V9sXxRPiqobwFnMIqrXF5KgDC0/BR39ikrD+d9GE1
         Z6JCT8Uk3VRL0oOKyjUOyq2odC/Ja69TrPn7iZB0M9a/HblhccX3ai/QuqqTC3/pxvzZ
         SzBg==
X-Gm-Message-State: AOAM5315+2YNI6NxHsOAZr3YUzkyRaIek6RnIv71mEBLbP3vwtkGkK7h
        42kC7WdvOIBVTJSeqKyqjLOwld6R
X-Google-Smtp-Source: ABdhPJymjOuJNLGTqgXMhLr5H+CN0eTnhx2ftNM81WsTq/CndWek0IPEQu6uHXYAc9Arc/8/V1GDwg==
X-Received: by 2002:a1c:544d:: with SMTP id p13mr13138242wmi.25.1591546716856;
        Sun, 07 Jun 2020 09:18:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u12sm21043692wrq.90.2020.06.07.09.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 09:18:36 -0700 (PDT)
Message-Id: <pull.651.git.1591546715913.gitgitgadget@gmail.com>
From:   "John Lin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 07 Jun 2020 16:18:35 +0000
Subject: [PATCH] Recommend "git gc --auto" instead of "git prune"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Lin <johnlinp@gmail.com>, John Lin <johnlinp@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Lin <johnlinp@gmail.com>

Signed-off-by: John Lin <johnlinp@gmail.com>
---
    Recommend "git gc --auto" instead of "git prune"
    
    Fix according to #642.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-651%2Fjohnlinp%2Ffix-git-gc-warning-message-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-651/johnlinp/fix-git-gc-warning-message-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/651

 builtin/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 8e0b9cf41b3..3833a3de332 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -692,7 +692,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 
 	if (auto_gc && too_many_loose_objects())
 		warning(_("There are too many unreachable loose objects; "
-			"run 'git prune' to remove them."));
+			"run 'git gc --auto' to remove them."));
 
 	if (!daemonized)
 		unlink(git_path("gc.log"));

base-commit: 20514004ddf1a3528de8933bc32f284e175e1012
-- 
gitgitgadget
