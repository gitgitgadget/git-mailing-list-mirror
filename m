Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC06C4724C
	for <git@archiver.kernel.org>; Fri,  1 May 2020 17:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A77772137B
	for <git@archiver.kernel.org>; Fri,  1 May 2020 17:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5EubkoQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbgEARJS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 13:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728970AbgEARJS (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 1 May 2020 13:09:18 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A27C061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 10:09:16 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g12so359777wmh.3
        for <git@vger.kernel.org>; Fri, 01 May 2020 10:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=eqPIU12N8xyhu2ZWS62PqlGQ1qqBOeP3kOHZtW62qnY=;
        b=L5EubkoQrI1exPv2m7rW5Bl4HbnT1uOBPEVb4iT4fkE8Ri9mm8cd6OX6PUtlcavCG/
         MuuGBTCDsqqlQRqyO9XUKn/RYnU07V89hi/NuPheCfTC2/ChxGBKmr2vDV5IJxxOZMcN
         Dura0qR9QSOkHem2MjodX8IMZlxgf4cGwj2MZEeL6ni7y0sxZGafIzzjNTqCN/SMiQ1X
         KpkW+LG7N5c0lYJHU7n6n0ZoDweMCNUpzAKeJdcYGslE10GmyhzBhBmK9n55xpbIZcel
         etepnQIsYNEYZ3l1fs4SljAXsaB/JKzPmF2kYVcOTTOi9oLaxmUD6maTlhFe6hj3AA+W
         PdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eqPIU12N8xyhu2ZWS62PqlGQ1qqBOeP3kOHZtW62qnY=;
        b=h4x9pjPAEQBaQjIT8I7n97MYINPsp79/8feYQFVmml3edk7b+T19Ts3u0vesf0Lgcm
         c8CvyBPeIolFajc2kJ72E0DzO0AB0tVeucV3p30TVnKenzEGwiYckup0PNjc5OWWsMDH
         aXhgn0WU4bDKW/AwBYrymM6cXsU9rR2Pn/gFiDETl7efsxbp8NEeQTeoDXTA1ao2N1Fd
         YfCos+rGd2SkbKRV59ZeDKLcPG7oEXb2x8dR9aQ1To7XfUp3P3aRpiDokmtgV4MtU6BA
         MOqQ84zDBdDxadRoe6gNh6xChXaxvz2fqb6sFQfbIMFQzeRnNQbZ+PS+oNF62SV0KC8Z
         r/mw==
X-Gm-Message-State: AGi0PuZMNWfDX6rr5GDUAmkYq+XWlROLbNvRfIDSr5i9DAfzB4Jva5qj
        0JW+J5EP+cjQf4SPunqfh6wO3m97
X-Google-Smtp-Source: APiQypIXTf6hOth+W0rZggU5oymKJQerNDsxCtC/CjbodyHDzbdKJqO1CJ2XC403VK2jQiQ9yyY/tA==
X-Received: by 2002:a1c:abc3:: with SMTP id u186mr494390wme.42.1588352954058;
        Fri, 01 May 2020 10:09:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 36sm5411350wrc.35.2020.05.01.10.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 10:09:13 -0700 (PDT)
Message-Id: <pull.775.git.git.1588352952840.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 May 2020 17:09:12 +0000
Subject: [PATCH] git-p4.py: fix --prepare-p4-only error with multiple commits
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>, Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <seraphire@gmail.com>

When using git p4 submit with the --prepare-p4-only option, the program
should prepare a single p4 changelist and notify the user that more
commits are pending and then stop processing.

A bug has been introduced by the p4-changelist hook feature that
causes the program to continue to try and process all pending
changelists at the same time.

The function applyCommit should return True when applying the commit
was successful and the program should continue. In the case of the
--prepare-p4-only flag, the function should return False, alerting the
caller that the program should not proceed with additional commits.

Change the return value from True to False in the applyCommit function
when git-p4 is executed with --prepare-p4-only flag.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
    git-p4.py: fix --prepare-p4-only error with multiple commits
    
    When using git p4 submit with the --prepare-p4-only option, the program
    should prepare a single p4 changelist and notify the user that more
    commits are pending and then stop processing.
    
    A bug has been introduced by the p4-changelist hook feature that causes
    the program to continue to try and process all pending changelists at
    the same time.
    
    The function applyCommit should return True when applying the commit was
    successful and the program should continue. In the case of the
    --prepare-p4-only flag, the function should return False, alerting the
    caller that the program should not proceed with additional commits.
    
    Change the return value from True to False in the applyCommit function
    when git-p4 is executed with --prepare-p4-only flag.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-775%2Fseraphire%2Fseraphire%2Fp4-hook-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-775/seraphire/seraphire/p4-hook-v1
Pull-Request: https://github.com/git/git/pull/775

 git-p4.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index b8b2a1679e7..d9ced1bf552 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1984,7 +1984,7 @@ def get_diff_description(self, editedFiles, filesToAdd, symlinks):
         return (diff + newdiff).replace('\r\n', '\n')
 
     def applyCommit(self, id):
-        """Apply one commit, return True if it succeeded."""
+        """Apply one commit, return True if it should continue processing."""
 
         print("Applying", read_pipe(["git", "show", "-s",
                                      "--format=format:%h %s", id]))
@@ -2222,7 +2222,7 @@ def applyCommit(self, id):
                         print("  " + f)
                 print("")
                 sys.stdout.flush()
-                return True
+                return False
 
             if self.edit_template(fileName):
                 if not self.no_verify:

base-commit: d61d20c9b413225793f8a0b491bbbec61c184e26
-- 
gitgitgadget
