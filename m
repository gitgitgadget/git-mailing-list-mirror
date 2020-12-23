Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFC6C433E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 14:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BFDA22482
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 14:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgLWOiL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 09:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgLWOiL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 09:38:11 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA8AC0613D3
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 06:37:30 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d13so18784939wrc.13
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 06:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bwzHKyXAzS9cUzH4qvzugmYgkP2eOh8oN1xo+0rll5w=;
        b=MH7b8hoehcfVR/QMQEMWIoEXQCxarNZbtm4jpqH25ALgtc6elH6S3BkJv+k5iQfcXW
         XwveJxSSjMT1t0/XtskwB8imG1Aop5E+zOb6TrR/aNnJV/mpeaEoiKrhjPcXUZLOnqg0
         dMUcuQzFrN5e7O7aVt0AtWNWEiQvQF7K15v0780i9sr2Ca7F7UqEqZpqvnZdYGSkRBba
         JV7N/eWtkLXhbpopTQxHsbZK5Xj9ilvd0KmX723O6XUtUeinlEA5Pr1UJZBu7q4JpqY7
         bHvcOG/FsCoj8bmqoT3If1GsEYXKSfuvghdN6GdpLv3GPh6Q7JCFQe6LasIs3LdjRHyL
         yBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bwzHKyXAzS9cUzH4qvzugmYgkP2eOh8oN1xo+0rll5w=;
        b=JmlLonutEnQElTGJdBbkTIfj9ETrLAY6Ua+b0iNM9IYtfPODAWtrgr2jZAaG8SlVvb
         lw3NoTXSfvtmCu2rC0WM0JOxDa8wl9/wVp/BqN4iwJbuGc5Dz5KoAh8IqEG5xTvCeZ4v
         Tmjc3b77Q0J9Y+fWvrWXntga614F9fM+84ZdYfOxpgOJC5K+BPSBgPc1wkWkFomRPls1
         oTBZuOmPJQ4IMtJ0UN1KiGS7RR9ZBY6SeVHlE+ZJLvouCqqCUGj4/3I/qzr5FIg/cDcJ
         bDDMezUCBktAmWLNau6ADPQ133rt4vCxtKyhTLQuvnrGapn0Ku6s0h49KnKooBRRlh5K
         AB+A==
X-Gm-Message-State: AOAM533//GY6s9E/kI8db7zYMmLAQGsEKFu1OBY48UOsr6cLXe52qxLE
        bCdNzv053hIkaP9X86nqksMJdGcYws4=
X-Google-Smtp-Source: ABdhPJxGH1TYAarIseVYsVvYWlu0ZW5IYMK9z6uPxwMBzrh7oDTVXQszxjxNXHMY9vNctlXHzVP47Q==
X-Received: by 2002:adf:ba47:: with SMTP id t7mr29291284wrg.285.1608734249117;
        Wed, 23 Dec 2020 06:37:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u13sm35208301wrw.11.2020.12.23.06.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 06:37:28 -0800 (PST)
Message-Id: <pull.823.v2.git.1608734248194.gitgitgadget@gmail.com>
In-Reply-To: <pull.823.git.1608727731733.gitgitgadget@gmail.com>
References: <pull.823.git.1608727731733.gitgitgadget@gmail.com>
From:   "Daniel Levin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Dec 2020 14:37:27 +0000
Subject: [PATCH v2] git-p4: fix syncing file types with pattern
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Daniel Levin <dendy.ua@gmail.com>

Example of pattern file type: text+k

Text filtered through the p4 pattern regexp must be converted from
string back to bytes, otherwise 'data' command for the fast-import
will receive extra invalid characters, followed by the fast-import
process error.

CC: Yang Zhao <yang.zhao@skyboxlabs.com>
Signed-off-by: Daniel Levin <dendy.ua@gmail.com>
---
    git-p4: fix syncing file types with pattern
    
    Example of pattern file type: text+k
    
    Text filtered through the p4 pattern regexp must be converted from
    string back to bytes, otherwise 'data' command for the fast-import will
    receive extra invalid characters, followed by the fast-import process
    error.
    
    Signed-off-by: Daniel Levin dendy.ua@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-823%2Fdendy%2Fp4-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-823/dendy/p4-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/823

Range-diff vs v1:

 1:  109fdb6df91 ! 1:  78729f51f3b git-p4: fix syncing file types with pattern
     @@
       ## Metadata ##
     -Author: Daniel Levin <dlevin@roku.com>
     +Author: Daniel Levin <dendy.ua@gmail.com>
      
       ## Commit message ##
          git-p4: fix syncing file types with pattern


 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 4433ca53de7..90b02f6b22c 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3031,7 +3031,7 @@ def streamOneP4File(self, file, contents):
             regexp = re.compile(pattern, re.VERBOSE)
             text = ''.join(decode_text_stream(c) for c in contents)
             text = regexp.sub(r'$\1$', text)
-            contents = [ text ]
+            contents = [ encode_text_stream(text) ]
 
         if self.largeFileSystem:
             (git_mode, contents) = self.largeFileSystem.processContent(git_mode, relPath, contents)

base-commit: 898f80736c75878acc02dc55672317fcc0e0a5a6
-- 
gitgitgadget
