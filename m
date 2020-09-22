Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4046DC2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 08:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C664D23A1E
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 08:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQsgbUFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgIVIbj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 04:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgIVIbj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 04:31:39 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FDCC0613CF
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 01:31:39 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e16so16078219wrm.2
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 01:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=YVSKQBNYwZsOQHeO/3E15irJklmvlVyz7PXx0usHo5g=;
        b=mQsgbUFyF6J4Grx4AxCD5PJ/NlKbVID2BC1/gAgljlk60lJDIFWXlhohUSFUBYDkU6
         +Eus8YxNP22r80ORzR29wgAIKLzF9VcktSE1Dfky8X9UAq7ziqTpnyZoy5AbGrVP4qoy
         8KWT3mt569tii8RawdldfpJcoMni6498arlPC08Tzf4RKRxEmBhXDJ7mn3wWGTxT2iac
         z+MASVJqutAee3JdI6RKOSUDt3ZAHw0HJZ91ajpVberBYaWh9QzrnJbToTkp6K0Abzu2
         SPwD7sTjmLXZ4VloUSwVA6+yjOh2yXimn2D3Z0QC/JQwfR3K/33kYoE+CYoje3Gh5oXo
         db5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YVSKQBNYwZsOQHeO/3E15irJklmvlVyz7PXx0usHo5g=;
        b=WB4EmodaPzBGR3wvWnHDDJaL+cgCX0G7OuWDvi5auLpatfD6lURn14WgrPB2L/wsX7
         1S3c/z/+viOurlG0P7LP76fPFPL5Q7ja80XwvtkxeTQVQglSjj73eIJQKfOoX2tYRHQm
         3KZmLIYg6/kHlP6ghYVf/Xz4p3IjtQoCZb8ebTccT2XVylmab4sX2Qni3cSof5OJEh7r
         GJSI+jKQZ+uSGGm5x3Vp8oqYB1vvFH8LfGMcoCkI1bDufrJA5FeVT6Qib8Osu+jDPxoX
         Ot7baQQDEWIAV6vh2Db6FlynSgqQYyXmm25r36v3oDC09DXhhToU/duAcn8VZrLK244e
         yIKQ==
X-Gm-Message-State: AOAM5310enWjAvgQ0WAA0XJL4eVfhyzyXUH/R7Gk3WdgEEOas6bgPHZQ
        MPU17MhlHWFtN1VW6ZJbR/u4MBme5go=
X-Google-Smtp-Source: ABdhPJw1/tLg0D8lPCCM3fK2jkKUv7tUCwTF0ilcxskvwKeNYvVi46JRTtg8/epYImywDHGeH2kGCw==
X-Received: by 2002:adf:8544:: with SMTP id 62mr3999728wrh.262.1600763497751;
        Tue, 22 Sep 2020 01:31:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h76sm3807986wme.10.2020.09.22.01.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 01:31:37 -0700 (PDT)
Message-Id: <pull.833.git.git.1600763496510.gitgitgadget@gmail.com>
From:   "Berislav Lopac via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Sep 2020 08:31:36 +0000
Subject: [PATCH] git-p4: ignore binary file diffs in git-p4 commit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Berislav Lopac <berislav@lopac.net>,
        Berislav Lopac <berislav@lopac.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Berislav Lopac <berislav@lopac.net>

Currently, when submitting commits, `git p4 submit` helpfully builds a
diff of changes, and then displays them in a text editor before
continuing (mimicking standard git commit behaviour). For changed files
it asks p4 for the diff, but if a file is added it dumps all of its
lines; to do so it opens a file, but as a text -- which obviously fails
if a file is binary, raising `UnicodeDecodeError`.
Signed-off-by: Berislav Lopac <berislav@lopac.net>
---
    ignore binary file diffs in git-p4 commit
    
    Currently, when submitting commits, git p4 submit helpfully builds a
    diff of changes, and then displays them in a text editor before
    continuing (mimicking standard git commit behaviour). For changed files
    it asks git for the diff, but if a file is added it dumps all of its
    lines; to do so it opens a file, but as a text -- which obviously fails
    if a file is binary, raising UnicodeDecodeError.
    
    This simple patch catches that exception and stops building the diff, so
    only the name of the added file is included.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-833%2Fberislavlopac%2Fignore-binary-file-diffs-in-git-p4-commit-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-833/berislavlopac/ignore-binary-file-diffs-in-git-p4-commit-v1
Pull-Request: https://github.com/git/git/pull/833

 git-p4.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 9a71a6690d..3d72a0dbdb 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1847,9 +1847,13 @@ def get_diff_description(self, editedFiles, filesToAdd, symlinks):
                 newdiff += "+%s\n" % os.readlink(newFile)
             else:
                 f = open(newFile, "r")
-                for line in f.readlines():
-                    newdiff += "+" + line
-                f.close()
+                try:
+                    for line in f.readlines():
+                        newdiff += "+" + line
+                except UnicodeDecodeError:
+                    pass
+                finally:
+                    f.close()
 
         return (diff + newdiff).replace('\r\n', '\n')
 

base-commit: af6b65d45ef179ed52087e80cb089f6b2349f4ec
-- 
gitgitgadget
