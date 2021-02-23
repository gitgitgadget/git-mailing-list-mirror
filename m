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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05FCC433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 17:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9795A64E85
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 17:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbhBWRge (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 12:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbhBWRg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 12:36:28 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9429BC06174A
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 09:35:48 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o10so1988496wmc.1
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 09:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=RgorzWJ9/4oDBzFclC5yuUIMXvY+lYvNOzBadkb+h+4=;
        b=ThOFA+f77gWrso4KvI+Dq0sqfTjoivPdTviLO7mD5f/jD09G/Iv1zivhdXOu8etf6J
         VKus1mTk9hbHtHRtMK3vef/T4ghm7XC45phQ6cV9Eq6+g8hxV8tAZtM2hrag8aTUwZhi
         /2A4CtqEDZ+IXA+ytxeKa8IrJax/cFASDnR6Is8MImeQdmLL6rrCwJAgO2AkwefTuyMZ
         6r53+Rbh3RBjHSZt92Ooi2GwBD+MgLSf365pWp/5BvXubwa4EpuAzax3DI8OMWq8EbPE
         H+tIhWZ4DRnf6zmizJu2KA3Jc4CdCc5cegZSLVTjnbx/k8rTfPy0y5o4SfyDlbFKCpGw
         PnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RgorzWJ9/4oDBzFclC5yuUIMXvY+lYvNOzBadkb+h+4=;
        b=VzFeYnEcqokhJJGsUhfpegkkAaHeGQKp5uoHLG5kc1b2Wkp643QWGCJoTIBSRyLp86
         8Zbn5bzD3bHUzsqzwiOTseNvoqjd/IzkMDfLYRWm9VqqKu1DSS0LZmyKjcM65HXFszzt
         MIvOGvugcSUXM1fq+/dY8iaeN9/Kwu/IGkie8b2ElgmaWAP7EmzNjYba2JpNo9pcD+Db
         H4hmwwMZkyxljIl9vBpBPH1HHft68P5esPduhMQ+VHUWwXym0CFplJuwdO4fWMVtqjgY
         ixPp+bVapkE8S6TpwTEiECefOICZ45kKiIXj8eIh+qgwkmx4+maiOBnGeg+V2oC49UNn
         Hc3g==
X-Gm-Message-State: AOAM531OEaRmlMeJAePxKCYW/dfonV8v9LjbOmj6ol0/Vp2UFPr0z43K
        npMA9vWeuqvoi72BS3Wt240j6v6u4Lg=
X-Google-Smtp-Source: ABdhPJxNodvf7thXH7o1doGYFJggTsbWUg1KTJxKkBn+OJ95/z2H7R5in73sLRjP21kcoyD8iEDmjA==
X-Received: by 2002:a7b:c2aa:: with SMTP id c10mr26108454wmk.101.1614101747353;
        Tue, 23 Feb 2021 09:35:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v6sm33982237wrx.32.2021.02.23.09.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 09:35:46 -0800 (PST)
Message-Id: <pull.969.git.git.1614101746491.gitgitgadget@gmail.com>
From:   "Utku Gultopu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Feb 2021 17:35:46 +0000
Subject: [PATCH] doc: `--date` in `git-commit` accepts approxidates
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Utku Gultopu <ugultopu@gmail.com>,
        Utku Gultopu <ugultopu@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Utku Gultopu <ugultopu@gmail.com>

Document the fact that the `--date` option in `git-commit` accepts any
date format that is accepted by the `approxidate_careful` function,
which is located in `date.c`.

Signed-off-by: Utku Gultopu <ugultopu@gmail.com>
---
    doc: --date in git-commit accepts approxidates
    
    Without the documentation, it is kind of a "hidden feature", which I was
    able to discover only through online forums.
    
    I guess this patch is not ideal, because instead of properly
    documenting, it refers the user to the code. However I wasn't able to
    find documentation about the "approxidates" which I can link to. Please
    let me know how I can improve it.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-969%2Fugultopu%2Fdocument-approxidates-for-date-argument-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-969/ugultopu/document-approxidates-for-date-argument-v1
Pull-Request: https://github.com/git/git/pull/969

 Documentation/date-formats.txt | 9 +++------
 Documentation/git-commit.txt   | 4 +++-
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/date-formats.txt b/Documentation/date-formats.txt
index f1097fac69a6..8332f592e252 100644
--- a/Documentation/date-formats.txt
+++ b/Documentation/date-formats.txt
@@ -1,10 +1,7 @@
-DATE FORMATS
-------------
+DATE FORMATS[[DATES]]
+---------------------
 
-The `GIT_AUTHOR_DATE`, `GIT_COMMITTER_DATE` environment variables
-ifdef::git-commit[]
-and the `--date` option
-endif::git-commit[]
+The `GIT_AUTHOR_DATE` and `GIT_COMMITTER_DATE` environment variables
 support the following date formats:
 
 Git internal format::
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 17150fa7eabe..b96b7715a0a8 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -143,7 +143,9 @@ OPTIONS
 	the commit author is then copied from the first such commit found.
 
 --date=<date>::
-	Override the author date used in the commit.
+	Override the author date used in the commit. The '<date>' can be in
+	any format that is accepted by the `approxidate_careful` function
+	in `date.c` or the <<DATES, DATE FORMATS>> section below.
 
 -m <msg>::
 --message=<msg>::

base-commit: 966e671106b2fd38301e7c344c754fd118d0bb07
-- 
gitgitgadget
