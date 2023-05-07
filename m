Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E9CC77B75
	for <git@archiver.kernel.org>; Sun,  7 May 2023 03:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjEGDJ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 23:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjEGDJx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 23:09:53 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3FA17DF4
        for <git@vger.kernel.org>; Sat,  6 May 2023 20:09:51 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3078aa0b152so448329f8f.3
        for <git@vger.kernel.org>; Sat, 06 May 2023 20:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683428990; x=1686020990;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tP7wioibr+CXY6EsD7Y/jgy3oklLViDcJyCItkvItyM=;
        b=OADrhGYBqVr/vL/9pPSTCEOXPbivSfQmgJ9VKW9QOf2FPzg3WJgVUnZaqMKaZ8HsIV
         JnLMs9pBU2obdqm30XJeR5iBZWHt+8gJgWNE16nGLHGgaiUin9B8LSkuGgqPW6vaF7ls
         iJl+fhtwuYO5bN9Ebm27gkg6g1ikx7lLnsnBh8cPWMvxQHECb+J9cFbbWderDqKbSjGs
         ZKK5zUiyOZhnhkrvT92Wl+0WtUkQiN0Zktc0Cj7DlAuGRYXGWHA8XXIJoptM6VsqojsO
         qfzV5u1jlsrwL28W/9y5RxN1EuLR95RzykuUofdOU5/MvQCcRCmPrJIpdVLWUHoSsiSu
         O96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683428990; x=1686020990;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tP7wioibr+CXY6EsD7Y/jgy3oklLViDcJyCItkvItyM=;
        b=YZMFTcWERgUN6VKYTBYTqPMnTyzYBaNdYNM5GFGAZtSNQTO48iB2XBhfehsMek1T13
         MRRRtRULgySf5aPu/JRoX/z37yyrU+Ro2JgsdpBEeBKVLveOIcpzmYpIajkOLRVRVTKr
         QmcRwhnNBiHGlKWd+kLcaj6rO+tlWcYnkyP0/tSTAvO3IswCKqJv/JeIZI3YtoYrxUIq
         jVIibb8HYJRUPdbPgJwD9TBrhR8g4o2ifxuHjimy5JCK/P/l97LCdajTZH1I0Dwk1QxO
         KfvjHCOWpjuDaUdDnHFuY9PRJzTFCy1pbtj+QIzCFPz0C+gIgPQi5UGq6RPszqPGOQyb
         jXEQ==
X-Gm-Message-State: AC+VfDzkKnIXX27BWFOCqDP1sckseZHg8RpKdsF6OPxp8RbmmC22zVGH
        QuYLSUJqWWQa5a2RwgMKokXxPHZk4qQ=
X-Google-Smtp-Source: ACHHUZ5P/kV5gyMwVVCqNkB3IZPeNXdVWfe5n35Oa1Ks1ixQksRFkc6Z0P8YYsjqEEs6Vq+Ms0vC2Q==
X-Received: by 2002:adf:fb0b:0:b0:2cf:e3d0:2a43 with SMTP id c11-20020adffb0b000000b002cfe3d02a43mr4424810wrr.4.1683428989790;
        Sat, 06 May 2023 20:09:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l11-20020a7bc34b000000b003f195d2f1a9sm12386218wmj.15.2023.05.06.20.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 20:09:49 -0700 (PDT)
Message-Id: <pull.1514.git.1683428988693.gitgitgadget@gmail.com>
From:   "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 07 May 2023 03:09:48 +0000
Subject: [PATCH] subtree: support long global flags
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Josh Soref <jsoref@gmail.com>, Josh Soref <jsoref@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Josh Soref <jsoref@gmail.com>

The documentation at e75d1da38a claimed support, but it was never present

Signed-off-by: Josh Soref <jsoref@gmail.com>
---
    subtree: support long global flags
    
    The documentation at e75d1da38a claimed support, but it was never
    present

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1514%2Fjsoref%2Fsubtree-global-flags-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1514/jsoref/subtree-global-flags-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1514

 contrib/subtree/git-subtree.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 10c9c87839a..7db4c45676d 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -34,8 +34,8 @@ git subtree pull  --prefix=<prefix> <repository> <ref>
 git subtree push  --prefix=<prefix> <repository> <refspec>
 --
 h,help        show the help
-q             quiet
-d             show debug messages
+q,quiet       quiet
+d,debug       show debug messages
 P,prefix=     the name of the subdir to split out
  options for 'split' (also: 'push')
 annotate=     add a prefix to commit message of new commits

base-commit: 9857273be005833c71e2d16ba48e193113e12276
-- 
gitgitgadget
