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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14199C43331
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0037A6516B
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhCHSgc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 13:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbhCHSg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 13:36:26 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18F2C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 10:36:25 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id b18so12537652wrn.6
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 10:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GagUwiP0HL+zZ0S6XbUDvsJLMDayoR/u1iElHCEGZxE=;
        b=QEiEWBjsXqvgakHGqV98gZubf0fXyPMHq0YhheXwSUQ+aNwwetShhp3ybC466IgLrH
         r8kKJIG8DTmaDPxoMST75bpqTajGBH0kPiHj7SUNLZf2QwVWFO6lLA2RQrs2Gs4RTvcM
         HtOsESSm1IJfqWrLaQ4cSZzAWKdK/Kg1GHs6ppM2qP0lfAtYdxzBZfrkEtBm/83eG9JJ
         AbYn6cLI+ybV1hFtiGYbmhJV+0cEFX/F8+TzBx3MoJcK6ReeksvrQtW08YYfZvPJoTI3
         yTUF74e7rbbYyHJb7Gkp1sCtuVpUsMFvMwwVIBsOip18mzHpFOJXF2NskKiDXgMtR+uF
         Ol4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GagUwiP0HL+zZ0S6XbUDvsJLMDayoR/u1iElHCEGZxE=;
        b=BeVTSvn/t+18nUxRdpeqzZiWaPiLOH6NX5GS3h+HdIdoHvrUFBMOhpt/+JHQLYGITR
         +CxAXWi/fQIFvZTK77GjveswwyPzPSyZHOt1odeWRJ+CvCAQ/e4u7Aq9OF37EUzqjaGo
         k6YDCMUF8FNZQlIbKF5h7/jV1JkNLFCCtb9PL6mmBi/a2wQQbQhFnUgSJEwSmrTjK+dG
         Ia+vrQKQ1LE0mk4cv3W63rLG9dlNVHxWF0YdpIhNch12qg7QLg6YOahGyPw0HvW+p6wT
         PDYSiC4BCT5/trWjVKx7uK0V+zi+xPOGw9WZUcA2Iy+Zqaem1uIird1+2quLdOFLCbdc
         dYyA==
X-Gm-Message-State: AOAM532q7bHjQx7SmyMwIOn7sNsArPo9/FUh6fZ1yf0+w0OBILAn7n6o
        8gzHOsqjO7xVZsxWz9pWzaSPtkNDg8w=
X-Google-Smtp-Source: ABdhPJxFmLswsjAdadyY40bca1N0ykjyrHs5Ash9x+Gcw1bHlhKO4HfN1BpP5ffRLCwTDG5xGqCz7A==
X-Received: by 2002:a5d:5047:: with SMTP id h7mr25101689wrt.111.1615228584687;
        Mon, 08 Mar 2021 10:36:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v13sm22914823wrt.45.2021.03.08.10.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 10:36:24 -0800 (PST)
Message-Id: <6f81f3b2ab285f424c687072d4aef811a2471c24.1615228580.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.899.git.1615228580.gitgitgadget@gmail.com>
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 Mar 2021 18:36:19 +0000
Subject: [PATCH 6/7] init-db: silence template_dir leak when converting to
 absolute path
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andrzej Hunt <andrzej@ahunt.org>, Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

template_dir starts off pointing to either argv or nothing. However if
the value supplied in argv is a relative path, absolute_pathdup() is
used to turn it into an absolute path. absolute_pathdup() allocates
a new string, and we then "leak" it when cmd_init_db() completes.

We don't bother to actually free the return value (instead we UNLEAK
it), because there's no significant advantage to doing so here.
Correctly freeing it would require more significant changes to code flow
which would be more noisy than beneficial.

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
 builtin/init-db.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index d31dbc883746..efc66523e22c 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -561,8 +561,10 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	if (real_git_dir && !is_absolute_path(real_git_dir))
 		real_git_dir = real_pathdup(real_git_dir, 1);
 
-	if (template_dir && *template_dir && !is_absolute_path(template_dir))
+	if (template_dir && *template_dir && !is_absolute_path(template_dir)) {
 		template_dir = absolute_pathdup(template_dir);
+		UNLEAK(template_dir);
+	}
 
 	if (argc == 1) {
 		int mkdir_tried = 0;
-- 
gitgitgadget

