Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFD8C433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 18:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B5D9610D0
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 18:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhJTSmT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 14:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbhJTSmT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 14:42:19 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64555C06161C
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 11:40:04 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so11910799wmz.2
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 11:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/+NlfgSggbTOh4a6IVt8gFJfdmgwqFT/2H0t+yDDwu4=;
        b=TwOSjWTFv8rN3EATIGttZM6J0idAhvdyeSf2yPYc/AMX+MUTZPnkXHrf8WbDSn+IZR
         0l+wTccvn74bPWdi0+x0afT+K3KL9q3CLkOs56dXzBNDpW1j+PMNzJMwfAymg1KFu7Pn
         dMCeQMQi8MxrSXNvlAI+UyZxgvI3zkr5oJQhhOuSuD1L8J5Fg6NgM+u/c/fIM/5xjOPT
         cW7X6gGU5Lo2FDjyNsVHPCF+PtGCfZ4MkLnh3Ngm7ng2AVeN86Gvc0+vHxqpVGbIwBIB
         6t4P3X3t/7mJUpNgBYyl1394kXeLcaqn72ZJdVtm6KGlAOmlsqToNyFbjb5EEIubRYnN
         VjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/+NlfgSggbTOh4a6IVt8gFJfdmgwqFT/2H0t+yDDwu4=;
        b=GxU7NZXZdJJaMLizWIDYT72IPjHb/kAR2CQIEjaznHIdWk2GtvkI+ZB+EZ31bWGbIW
         09mgOTh8BiJ8s09oKQ90nExzuDJkhzaf6anCzQ9x/1+lgxOVMNuMeEeXbJPtmxpQjaLu
         AAPzzk3GCyhDU94D9QGwZuvH28+bwZ7VaUlRhxDatXzabTPrFRJG3+MZcKpjTxNnOmdp
         RwsgsjlFD6gjZYdjnuRo4QTORS/UTeCFXnLS/6ep9u85kPOaSZVFTU2DTkBMWryUzzi6
         P3MrqenT8RxckiNZEoyoeYmGg+TB7TfPTWK0b1kE89nNyqiV4QHd9HUoguriNVe2D7GX
         gkAw==
X-Gm-Message-State: AOAM533hVLsJJedB1+F+UCId59kKGK8RCMqFNhHtpD4uNwvnpFSUSmkl
        VyzZ7aeQICNCcBTen/M52AgGBkrXzLCewQ==
X-Google-Smtp-Source: ABdhPJy/XX4No9mm2UQpdKtbsEmf5CvXRjHRrGtWxjspSdKFzR4g4D1ZY7lQVlV5vN0Fp4GOjZD8TQ==
X-Received: by 2002:a05:600c:218d:: with SMTP id e13mr1070586wme.130.1634755202702;
        Wed, 20 Oct 2021 11:40:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d8sm2813835wrv.80.2021.10.20.11.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 11:40:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/8] command-list.txt: sort with "LC_ALL=C sort"
Date:   Wed, 20 Oct 2021 20:39:52 +0200
Message-Id: <patch-1.8-96885282988-20211020T183533Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
References: <YNqBtrXzUlJiuc7y@coredump.intra.peff.net> <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We should keep these files sorted in the C locale, e.g. in the C
locale the order is:

    git-check-mailmap
    git-check-ref-format
    git-checkout

But under en_US.UTF-8 it's:

    git-check-mailmap
    git-checkout
    git-check-ref-format

In a subsequent commit I'll change generate-cmdlist.sh to use C sort
order, and without this change we'd be led to believe that that change
caused a meaningful change in the output, so let's do this as a
separate step, right now the generate-cmdlist.sh script just uses the
order found in this file.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 command-list.txt | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/command-list.txt b/command-list.txt
index a289f09ed6f..02fc7ddde68 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -60,9 +60,9 @@ git-cat-file                            plumbinginterrogators
 git-check-attr                          purehelpers
 git-check-ignore                        purehelpers
 git-check-mailmap                       purehelpers
+git-check-ref-format                    purehelpers
 git-checkout                            mainporcelain
 git-checkout-index                      plumbingmanipulators
-git-check-ref-format                    purehelpers
 git-cherry                              plumbinginterrogators          complete
 git-cherry-pick                         mainporcelain
 git-citool                              mainporcelain
@@ -111,7 +111,6 @@ git-index-pack                          plumbingmanipulators
 git-init                                mainporcelain           init
 git-instaweb                            ancillaryinterrogators          complete
 git-interpret-trailers                  purehelpers
-gitk                                    mainporcelain
 git-log                                 mainporcelain           info
 git-ls-files                            plumbinginterrogators
 git-ls-remote                           plumbinginterrogators
@@ -124,11 +123,11 @@ git-merge-base                          plumbinginterrogators
 git-merge-file                          plumbingmanipulators
 git-merge-index                         plumbingmanipulators
 git-merge-one-file                      purehelpers
-git-mergetool                           ancillarymanipulators           complete
 git-merge-tree                          ancillaryinterrogators
-git-multi-pack-index                    plumbingmanipulators
+git-mergetool                           ancillarymanipulators           complete
 git-mktag                               plumbingmanipulators
 git-mktree                              plumbingmanipulators
+git-multi-pack-index                    plumbingmanipulators
 git-mv                                  mainporcelain           worktree
 git-name-rev                            plumbinginterrogators
 git-notes                               mainporcelain
@@ -154,23 +153,23 @@ git-request-pull                        foreignscminterface             complete
 git-rerere                              ancillaryinterrogators
 git-reset                               mainporcelain           history
 git-restore                             mainporcelain           worktree
-git-revert                              mainporcelain
 git-rev-list                            plumbinginterrogators
 git-rev-parse                           plumbinginterrogators
+git-revert                              mainporcelain
 git-rm                                  mainporcelain           worktree
 git-send-email                          foreignscminterface             complete
 git-send-pack                           synchingrepositories
+git-sh-i18n                             purehelpers
+git-sh-setup                            purehelpers
 git-shell                               synchelpers
 git-shortlog                            mainporcelain
 git-show                                mainporcelain           info
 git-show-branch                         ancillaryinterrogators          complete
 git-show-index                          plumbinginterrogators
 git-show-ref                            plumbinginterrogators
-git-sh-i18n                             purehelpers
-git-sh-setup                            purehelpers
 git-sparse-checkout                     mainporcelain           worktree
-git-stash                               mainporcelain
 git-stage                                                               complete
+git-stash                               mainporcelain
 git-status                              mainporcelain           info
 git-stripspace                          purehelpers
 git-submodule                           mainporcelain
@@ -189,10 +188,11 @@ git-var                                 plumbinginterrogators
 git-verify-commit                       ancillaryinterrogators
 git-verify-pack                         plumbinginterrogators
 git-verify-tag                          ancillaryinterrogators
-gitweb                                  ancillaryinterrogators
 git-whatchanged                         ancillaryinterrogators          complete
 git-worktree                            mainporcelain
 git-write-tree                          plumbingmanipulators
+gitk                                    mainporcelain
+gitweb                                  ancillaryinterrogators
 gitattributes                           guide
 gitcli                                  guide
 gitcore-tutorial                        guide
@@ -211,6 +211,6 @@ gitremote-helpers                       guide
 gitrepository-layout                    guide
 gitrevisions                            guide
 gitsubmodules                           guide
-gittutorial-2                           guide
 gittutorial                             guide
+gittutorial-2                           guide
 gitworkflows                            guide
-- 
2.33.1.1338.g20da966911a

