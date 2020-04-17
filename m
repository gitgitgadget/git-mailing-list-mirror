Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642C7C2BB1D
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 07:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38AE7206D5
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 07:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+NBQtsY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgDQHLJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbgDQHLI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Apr 2020 03:11:08 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3E1C061A0C
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 00:11:07 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id i7so710288edq.3
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 00:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ioJ4gluKOr74pNPXDDE0konbB9teMAnz5uacdjfOlys=;
        b=W+NBQtsYhGQIefgIatemGwoEaU32iytR+usW4PInvkRTnrVDvnprFt/HuTXsMh7TUI
         +HHesFsuEhezOmG8M5tMyhjvuTckqQUlVOecJoe3psKGK+BgoeZcJ+W60xt+xuz89jD/
         NyBXxBgH8IUVhi99f5xeAacW9+hsnNqqn2MiHppLivXYsjz+b9y80jFMVUHWXVpUOkAX
         JMuMtk0bEbBbXDbFoFxNrpPGcJROf+YmyktXM7VECqKk4zMCCLi2E0zswJRoVomR/Zdo
         AnojAQpJlLUPA94YlN4AFel2AO6r7q5WPfJhz/ViRbR1ORJdRKwyDD2tI0qM92oLHasn
         C6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ioJ4gluKOr74pNPXDDE0konbB9teMAnz5uacdjfOlys=;
        b=kjgatClZNcAH30VPN2HeUtEWmg2NYrTnyhmiSFPMAE7ZBhno9P8C9RQZSNxTC4Pmsf
         NSx2Y5GdM1shTwXQkCN14UT3hAq3I0Dys+/ViyXD0fVeDAZUCMNIXe0o2Pvf6K/v54pn
         JC02qqPiw/Y3m0rh2y8XiGTCSq+n2n3Z0zkrxYfbMQCMOX6VVtyhG5mVtRJG9CiJk6Mr
         lh+5t6UKTFCLfrku+QcR18oG3aSEc4enjAEI0AGIJoVe+HBdR7mVKvvhpzbBUmL+qXRd
         XGVzE+5Lz9YPbq+mgMZ9MMT4A690tumBHUtICIUJTphec8wNVe1mQx+UjrbuogG6izHu
         5PEg==
X-Gm-Message-State: AGi0PuYeHseUPZ/pKUbntuEvfTWRGeoKt+WrOMc5SG542hRC5oLYau3T
        zYueJsuPkvTuoZMDwZQChsSt+T65
X-Google-Smtp-Source: APiQypJK+wi52AVFRCNrMhVLKxDq9m8BsJKheUFiFowyopMRqvGCLJwUfSRD8f9CaNJEdqEerCo7GA==
X-Received: by 2002:a50:d942:: with SMTP id u2mr1702757edj.116.1587107465628;
        Fri, 17 Apr 2020 00:11:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ce16sm3323199ejc.74.2020.04.17.00.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 00:11:04 -0700 (PDT)
Message-Id: <pull.613.git.1587107464322.gitgitgadget@gmail.com>
From:   "Terry via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 17 Apr 2020 07:11:04 +0000
Subject: [PATCH] complete: zsh: add missing sub cmd completion candidates
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Terry <tmoschou@gmail.com>, Terry Moschou <tmoschou@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Terry Moschou <tmoschou@gmail.com>

Add missing 'restore' and 'switch' sub commands to zsh completion
candidate output. E.g.

  $ git re<tab>
  rebase    -- forward-port local commits to the updated upstream head
  reset     -- reset current HEAD to the specified state
  restore   -- restore working tree files

  $ git s<tab>
  show      -- show various types of objects
  status    -- show the working tree status
  switch    -- switch branches

Signed-off-by: Terry Moschou <tmoschou@gmail.com>
---
    complete: zsh: add missing sub cmd completion candidates
    
    Add missing 'restore' and 'switch' sub commands to zsh completion
    candidate output. E.g.
    
    $ git re<tab>
    rebase    -- forward-port local commits to the updated upstream head
    reset     -- reset current HEAD to the specified state
    restore   -- restore working tree files
    
    $ git s<tab>
    show      -- show various types of objects
    status    -- show the working tree status
    switch    -- switch branches
    
    Signed-off-by: Terry Moschou tmoschou@gmail.com [tmoschou@gmail.com]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-613%2Ftmoschou%2Fupdate-zsh-completion-script-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-613/tmoschou/update-zsh-completion-script-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/613

 contrib/completion/git-completion.zsh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index eef4eff53df..ce47e86b60c 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -150,9 +150,11 @@ __git_zsh_cmd_common ()
 	push:'update remote refs along with associated objects'
 	rebase:'forward-port local commits to the updated upstream head'
 	reset:'reset current HEAD to the specified state'
+	restore:'restore working tree files'
 	rm:'remove files from the working tree and from the index'
 	show:'show various types of objects'
 	status:'show the working tree status'
+	switch:'switch branches'
 	tag:'create, list, delete or verify a tag object signed with GPG')
 	_describe -t common-commands 'common commands' list && _ret=0
 }

base-commit: de49261b050d9cd8ec73842356077bc5b606640f
-- 
gitgitgadget
