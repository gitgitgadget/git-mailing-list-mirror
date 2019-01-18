Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 272531F453
	for <e@80x24.org>; Fri, 18 Jan 2019 21:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbfARVzZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 16:55:25 -0500
Received: from mail-io1-f74.google.com ([209.85.166.74]:57041 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbfARVzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 16:55:25 -0500
Received: by mail-io1-f74.google.com with SMTP id x2so11268268ioa.23
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 13:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=6Vb/5vy9S3oNOeFJHFDwZqVz4Cth3NMsbajWcCfPVe8=;
        b=NnHyoGCAWFjmI8Owkvy8r1ipdtqNyBvEcZoejRydeVZWRZBXDt6TeT8h/U3r5Ug+bI
         2NMj7lYL4Hx8fRytBfmJx3iwNszmBYJcQINtGydTaQUI5YsF97a4r97MzFfNsDxmK/Zq
         e3uQZizUx5xUzV17orflGyVFeITL8pwJH9dqTLAMok8k59/WtAtMvlVVSOz7Da5GVMvI
         PC+ra+7Ag5CNrWN6SYHcYbmSxr2lJoYMDrhvOXyGQat8ntc6rjqe/9s0HMB1i/zArK+i
         JjMnr63aac9s1vj8YtgPFpAbZzelE7zT5dHU2rEQ6OOlLRJLbX+6LkMv+3/oDKWDvNTE
         4PiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=6Vb/5vy9S3oNOeFJHFDwZqVz4Cth3NMsbajWcCfPVe8=;
        b=HJ9k4nM1PClAQId/Puxpw3R70Jtea321fZFISM76/3O38l07ekmEn5AnKZkp1mJvif
         fOHcSyGZozalmUXVGKw205b1nHtl4YNdb890bDyTUzubfq/hKUsmiC0uI2tPs6kTtP60
         GGSn1Kg+4Wg5pm+VfBnGVLbJPBznoBg04Io1wcHYrrGc/BhBknHYmDy6Gt8YpcjD+k/x
         WjM/wRZ3XQeutIl5PgNzcy+XsVkk9RD9b/7srIQzW64n057l0vxAlL3fOj5NNdvUf5K7
         oPQuPYHAiOT486tTuXcAANuhSeD/oq88eXDV2RiyuYkJIXkMb+6FKim/gdXVUZHVxZhv
         xz8A==
X-Gm-Message-State: AJcUukfZijQErckOWFXDBn5KlVsdV0Q99zLvkLY8CtqdzxsB4L951MYn
        gAU3WhZtuK88fulKzHKxW7USKMYXMFb54Rsx7E3UnjSnd9czHskSIgciCB8HcY2o2t/uxBkWNbu
        3PDsoSE31IMdkvIR0ybtmL05I8nOuTRakoNSRzIS9ZfwYM7XzzWLx7aQzM1t3
X-Google-Smtp-Source: ALg8bN5HKD50g4WO649xLgBKbyA6CuoXfkRkpb/FI9GYO9fGDneJQMC3XINnURPsdYDyV53VfLjvR6PVYspS
X-Received: by 2002:a24:15:: with SMTP id 21mr13611213ita.27.1547848524726;
 Fri, 18 Jan 2019 13:55:24 -0800 (PST)
Date:   Fri, 18 Jan 2019 13:55:19 -0800
Message-Id: <20190118215519.107700-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.101.g27c53b536e7.dirty
Subject: [PATCH] git-submodule: abort if core.worktree could not be set correctly
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

74d4731da1f (submodule--helper: replace connect-gitdir-workingtree by
ensure-core-worktree, 2018-08-13) forgot to exit the submodule operation
if the helper could not ensure that core.worktree is set correctly.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 5e608f8bad3..02a0d728174 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -548,7 +548,7 @@ cmd_update()
 	do
 		die_if_unmatched "$quickabort" "$sha1"
 
-		git submodule--helper ensure-core-worktree "$sm_path"
+		git submodule--helper ensure-core-worktree "$sm_path" || exit 1
 
 		update_module=$(git submodule--helper update-module-mode $just_cloned "$sm_path" $update)
 
-- 
2.20.1.101.g27c53b536e7.dirty

