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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B14FC433DB
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 07:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B41664F81
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 07:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhCLHsL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 02:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhCLHry (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 02:47:54 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5BBC061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 23:47:53 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id o16so1219965wrn.0
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 23:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=zjIynX7gJnxb+l3CC3rq7T9vbk+Erj89WRBGmJMNWC4=;
        b=mxxFvz0NJNPBV+w/343jd/oNZRw2LTjoJo2ftmY/LGYihXHqI4+KhRSK+MnXx2rjee
         rDQOwwy91i1tughIeUwQCospUKq14+pW3Y0xudbCgFojyFTpW+zgub0gaFVtzbyRS269
         5IuwsDu84G3uHn4gWwjmbpD21rGCm+0s623tG5C+5uXW7e0swvSExu6daEfbt6Qz5BWC
         Hgm3DiJhHbzsAaRw9TOMW7DWCTQN2gYmr8FQVYJT5KjmOTapfLyFNwm5t0XuAYUNMC9k
         GY4BMNHSNSXMqilXuR8dM87O0Ro4gQuFmuFxKfbTNpDTSKvFy6Jq20aAfomGlm1zXun4
         LVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zjIynX7gJnxb+l3CC3rq7T9vbk+Erj89WRBGmJMNWC4=;
        b=Uj7WPu8P6j51+cy0Z9IjkvvJLa4JtUdd1QuTc2Nul6+iJ3KlwAU/ZLIkrSA6Ws4pn/
         JrCebPkXYgwrvbzLvZwu2e2JZrl9+aWz0WG7kpcbq6Ts7AKwLPHCkQ++8+4pepsGDiSX
         U6dWsLwvwPlYd5+KQ0OSp/v5HDiQxistsr2vx1GW1nS9qejLbCst8hMuV5a5XDQtY7Nt
         Y6+tssAiMaDToRE9C9+Jglv0InxhAYiBPRKO1CwgCE/eU5Ep5SeMxb8TdFqVT3XeqqhC
         RFkahI+sQkw8XHhZYyApJ+a0IBx6/y+2lCbKWqf7egvG7G3pp4r1JD+kTl2mccShE7m7
         zhBA==
X-Gm-Message-State: AOAM530v6guje7d1/Tj0FsiMBtppfDTd8MRswQBZsnzLj/ngoVZyMr3O
        4/1OYr/gDtSzjm0sBkoEiTQuVHAfKFI=
X-Google-Smtp-Source: ABdhPJz5+AgrRovkP2SucBMuJOO4subpFFt1xtJFJ57mfHEkswGLTB0C/LnNz/crZ66R2ZvZ8MR6Gw==
X-Received: by 2002:adf:f9d0:: with SMTP id w16mr12918580wrr.336.1615535271193;
        Thu, 11 Mar 2021 23:47:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j11sm6865303wro.55.2021.03.11.23.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 23:47:50 -0800 (PST)
Message-Id: <pull.977.git.git.1615535270135.gitgitgadget@gmail.com>
From:   "dorgon chang via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Mar 2021 07:47:49 +0000
Subject: [PATCH] git-p4: fix failed submit by skip non-text data files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     dorgon chang <dorgonman@hotmail.com>,
        "dorgon.chang" <dorgonman@hotmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "dorgon.chang" <dorgonman@hotmail.com>

If the submit contain binary files, it will throw exception and stop submit when try to append diff line description.

This commit will skip non-text data files when exception UnicodeDecodeError thrown.

Signed-off-by: dorgon.chang <dorgonman@hotmail.com>
---
    git-p4: fix failed submit by skip non-text data files
    
    git-p4: fix failed submit by skip non-text data files
    
    If the submit contain binary files, it will throw exception and stop
    submit when try to append diff line description.
    
    This commit will skip non-text data files when exception
    UnicodeDecodeError thrown.
    
    I am using git-p4 with UnrealEngine game projects and this fix works for
    me.
    
    Signed-off-by: dorgon.chang dorgonman@hotmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-977%2Fdorgonman%2Fdorgon%2Ffix_gitp4_get_diff_description-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-977/dorgonman/dorgon/fix_gitp4_get_diff_description-v1
Pull-Request: https://github.com/git/git/pull/977

 git-p4.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 4433ca53de7e..29a8c202399a 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1977,8 +1977,11 @@ def get_diff_description(self, editedFiles, filesToAdd, symlinks):
                 newdiff += "+%s\n" % os.readlink(newFile)
             else:
                 f = open(newFile, "r")
-                for line in f.readlines():
-                    newdiff += "+" + line
+                try:
+                    for line in f.readlines():
+                        newdiff += "+" + line
+                except UnicodeDecodeError:
+                    pass # Fond non-text data
                 f.close()
 
         return (diff + newdiff).replace('\r\n', '\n')

base-commit: d4a392452e292ff924e79ec8458611c0f679d6d4
-- 
gitgitgadget
