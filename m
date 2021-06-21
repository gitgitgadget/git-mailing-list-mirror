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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354A4C48BE5
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 05:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1654B61003
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 05:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhFUFSc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 01:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhFUFSc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 01:18:32 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF766C061574
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 22:16:17 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id t11-20020a1cc30b0000b02901cec841b6a0so8400712wmf.0
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 22:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8syrkII6T56kzh6qFHxeA7ElWT7yn1LcuOOlz4MBAC0=;
        b=uSPt91RGkq27THZjmbhXBuoWQy93dd+jUXLK8rTaxzzec3zGy3mt64AYF1S9Makycn
         BoViTJoWjsSBNXNffz6djJcR9DZdZz8PJy+NBjceoEJ/NtM7c3BTvg2T4A9+2Ga3IGj4
         C4fuDdpfOULdk3Qy7HWGC4xqCe93NOMO4vyyUZlpHfXRIDTzcmzL4i23KP4M+DOio8IA
         AyYSuqco94/J7owYtT6Tq/EvpQs8vqyr8wFw5JtHP+IQylmv9AktucbWHu6VAhmsIX3b
         iLb37go1KJnCa2ZsW5HQmM+8H4FDkbfuBh6bgQiHszTCnHZKLukxOfawfiR41snEAIzh
         QA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8syrkII6T56kzh6qFHxeA7ElWT7yn1LcuOOlz4MBAC0=;
        b=X42ZNas6VVY+eLKW4q8rU0ELcH41a/qwjX1mPtYOkSD0kUIClIy4VLJzuAan59R6X1
         Qh4F9/SZABL3PBCAGIfvlLxRSTmHKue1V6uow58F7txr5X+hZYhcg9HVa9gcAP1pNcO9
         SdwoZNZ2Ol32a7hj7hJiu9ztYOtuQ46E5iByd1N+00h3wfx3gqJpQmGMkNyJjJbC91X5
         3/4PJ0VYxBN0a4sQTEzN2d4inEjvkXrMeUmLcm9cAraobBdOWgM58dQ6Ay7Ih/3bZ3pB
         Rk9gW/KYMKqLCflp6X5Ii7ZYqMS72dgxNausspGy7FBX7ShR+lUIkTKhJtU1H0SOExfO
         R2Ww==
X-Gm-Message-State: AOAM533ONz1mYUKE8dFB2xtCmPBcXY0IzigdYSAeztgUTX0umXdByqIX
        YSpG+mLUJcLwCJDLOfOwggEI1oQgOn8=
X-Google-Smtp-Source: ABdhPJywLkmMCi79S9scV9gYhFvb65gTzAUal5mDXEpuS8DoUV/rOF/uSbJsRFQ5cJIuXB7BFxGABQ==
X-Received: by 2002:a1c:6503:: with SMTP id z3mr24878606wmb.72.1624252576397;
        Sun, 20 Jun 2021 22:16:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f13sm17287535wmg.7.2021.06.20.22.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 22:16:15 -0700 (PDT)
Message-Id: <pull.977.v2.git.git.1624252574779.gitgitgadget@gmail.com>
In-Reply-To: <pull.977.git.git.1615535270135.gitgitgadget@gmail.com>
References: <pull.977.git.git.1615535270135.gitgitgadget@gmail.com>
From:   "dorgon chang via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Jun 2021 05:16:13 +0000
Subject: [PATCH v2] git-p4: fix failed submit by skip non-text data files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Simon Hausmann <simon@lst.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "dorgon.chang" <dorgon.chang@gmail.com>,
        dorgon chang <dorgonman@hotmail.com>,
        "dorgon.chang" <dorgonman@hotmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "dorgon.chang" <dorgonman@hotmail.com>

If the submit contain binary files, it will throw exception and stop submit when try to append diff line description.

This commit will skip non-text data files when exception UnicodeDecodeError thrown.

The skip will not affect actual submit files in the resulting cl,
the diff line description will only appear in submit template,
so you can review what changed before actully submit to p4.

I don't know if add any message here will be helpful for users,
so I choose to just skip binary content, since it already append filename previously.

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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-977%2Fdorgonman%2Fdorgon%2Ffix_gitp4_get_diff_description-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-977/dorgonman/dorgon/fix_gitp4_get_diff_description-v2
Pull-Request: https://github.com/git/git/pull/977

Range-diff vs v1:

 1:  19b59f40b183 ! 1:  606729bda112 git-p4: fix failed submit by skip non-text data files
     @@ Commit message
      
          This commit will skip non-text data files when exception UnicodeDecodeError thrown.
      
     +    The skip will not affect actual submit files in the resulting cl,
     +    the diff line description will only appear in submit template,
     +    so you can review what changed before actully submit to p4.
     +
     +    I don't know if add any message here will be helpful for users,
     +    so I choose to just skip binary content, since it already append filename previously.
     +
          Signed-off-by: dorgon.chang <dorgonman@hotmail.com>
      
       ## git-p4.py ##
     @@ git-p4.py: def get_diff_description(self, editedFiles, filesToAdd, symlinks):
      +                    for line in f.readlines():
      +                        newdiff += "+" + line
      +                except UnicodeDecodeError:
     -+                    pass # Fond non-text data
     ++                    pass # Found non-text data and skip, since diff description should only include text
                       f.close()
       
               return (diff + newdiff).replace('\r\n', '\n')


 git-p4.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 4433ca53de7e..dc1f46351845 100755
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
+                    pass # Found non-text data and skip, since diff description should only include text
                 f.close()
 
         return (diff + newdiff).replace('\r\n', '\n')

base-commit: d4a392452e292ff924e79ec8458611c0f679d6d4
-- 
gitgitgadget
