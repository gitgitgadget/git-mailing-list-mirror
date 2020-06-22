Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762EFC433E0
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 00:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46968252ED
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 00:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvE2AmG9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730946AbgFVAN6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Jun 2020 20:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730916AbgFVAN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jun 2020 20:13:58 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219A6C061794
        for <git@vger.kernel.org>; Sun, 21 Jun 2020 17:13:58 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k6so2426971wrn.3
        for <git@vger.kernel.org>; Sun, 21 Jun 2020 17:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=j13BdilYGlj89ujZ/VVpTSMlIsUu5VI1TVZ/uMo6r7U=;
        b=RvE2AmG9MBcZHYgh8YP2g7FNS5gguAwPK88GofND5sDupUpoKOe6Ohp2buBApyW4RM
         QAMCeAZeXBfOp38L3OWA89d0rMoeALI4///IbXwS/3ybfXkAVkURjmJmnV0YltgccNR2
         UDG9J8swJYXY+yxFc+Q7Zh/T85dcJwoxp3c3psjUCfZHEjAzZOWtUVxSVctdLN6KAdxV
         DSKlqrto75k8Udu4hlB5wmWG9yZFWgYDflK6KhT/im5ZZBGIt8IO1sL2sdBVAuTq8r/z
         5dPI7ukXh4P5jugphu1M/eWr4b5HWfMve5euEp4DAtM4BM/0k2CiCyQqS9rMEmbQtLCl
         BKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=j13BdilYGlj89ujZ/VVpTSMlIsUu5VI1TVZ/uMo6r7U=;
        b=okkdLrXPT03aH2QjzC/T2Fmgw38tbTLnf6Fim6HJPCgrWSf4OeFOiTKgZM9RDUsg5s
         NwcIQHHqPgwJWAM6cIg2LRvbR1F33lr4TNyR+GImRm2fYNetP8FrtP0g0RU7OZbNRbgz
         pPGa6CQot/TXfDRHHBW+Q9Fy066CR27qpK1kCqDOYTtMV9xSzELIH/95vAewg4jQ1fFa
         quDHxNRPwQa2ZCr0Y6AU5j2Vgfm/fC8L87t3uwKq/13HcaTqv/MguByDy/XE2Mg4gr0+
         WviuC43CQTTm6sHKI06qhfBZcJhNUTeJKOxjMQ7gzVr+286a7+6nrld2kb4W/twEu/Vc
         T7BA==
X-Gm-Message-State: AOAM5311q+KKlkyylvFEZnlrGX6D4M6LpVU8KPKeePHwfDrsjCI9z1Zu
        T3/HqULYhS42DmI9vGAUNt7nQ03D
X-Google-Smtp-Source: ABdhPJwuK80PF9ggBZhXG0iNAvGmvVAxtOzKfxFAKazwcQUy+WL12j1erVE6iYqa8Cq2PBcvVgaKmA==
X-Received: by 2002:adf:f608:: with SMTP id t8mr923496wrp.308.1592784836634;
        Sun, 21 Jun 2020 17:13:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u12sm16054284wrq.90.2020.06.21.17.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 17:13:56 -0700 (PDT)
Message-Id: <pull.667.git.1592784835441.gitgitgadget@gmail.com>
From:   "John Lin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Jun 2020 00:13:55 +0000
Subject: [PATCH] bash-completion: add git-prune into bash completion
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

Sometimes git would suggest the user to run `git prune` when there are
too many unreachable loose objects. It's more user-friendly if we add
git-prune into bash completion.

Signed-off-by: John Lin <johnlinp@gmail.com>
---
    bash-completion: add git-prune into bash completion
    
    Sometimes git would suggest the user to run git prune when there are too
    many unreachable loose objects. It's more user-friendly if we add
    git-prune into bash completion.
    
    Signed-off-by: John Lin johnlinp@gmail.com [johnlinp@gmail.com]
    
    Fixes #642.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-667%2Fjohnlinp%2Fadd-git-prune-bash-completion-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-667/johnlinp/add-git-prune-bash-completion-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/667

 command-list.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/command-list.txt b/command-list.txt
index cbb960c8436..89aa60cde7e 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -136,7 +136,7 @@ git-pack-redundant                      plumbinginterrogators
 git-pack-refs                           ancillarymanipulators
 git-parse-remote                        synchelpers
 git-patch-id                            purehelpers
-git-prune                               ancillarymanipulators
+git-prune                               ancillarymanipulators   complete
 git-prune-packed                        plumbingmanipulators
 git-pull                                mainporcelain           remote
 git-push                                mainporcelain           remote

base-commit: 101b3204f37606972b40fc17dec84560c22f69f6
-- 
gitgitgadget
