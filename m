Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9D4C433FE
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 19:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0221A610D0
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 19:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbhJVTij (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 15:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbhJVTih (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 15:38:37 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6004BC061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 12:36:19 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d3so2499254wrh.8
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 12:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HrZ+zqdE1GX1iIrF4KkIIEJOETMJ/JwZjy212N/Xyno=;
        b=NLD7ODBePJV9wlb5zdE7FVATn63hwCsjB4VofUwepqnZDI8DqlYT4R7xmNu8Ud6lYf
         2o7v15Pp5nlKcsUXj2mXJyAODEpCZXTnD+vc/Uq8mg5RXIjWUO2hQJK3K7Qlaaxh0HaL
         svu4AexoyQg3o81w8F+69OlbfsK14ukKr2CK8H4C7DF+ZGrbpppkyKNLJlZkUbGTXNsh
         eVme0wVdLT+DBfBySv83zzDRKLiGgyRxeFcWE6vYDN64NZIObKcUpHE/FF4KHk8UXLWh
         kTYxiNeia1L2xkz5mvtafGdDAmv6Fi0IRHcYm/ZqOhUPVv1U2DHeIGfPSsYXGv4tAzif
         8MsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HrZ+zqdE1GX1iIrF4KkIIEJOETMJ/JwZjy212N/Xyno=;
        b=1ss7FES6uniX6r7Hystezeopr3z4qNeA5dMp9M4Q6xJngbsmovrwDlCJeI2ls3oYwm
         ynGnqwRTf3x9PeA5fy/1tAGc4TlwjITWTXEYrxIAY4/qTY61a5Q5N8KZk515l8KRwC7n
         klyEL6Kp4ga7nxlL2GP0y1QGk40PAs5d7SxdW9gkpiBDPM8IpN4KVBLtl05Svkjondqo
         eSQA4896tne0nJeq/HDb6XJEWaXU8kFaxnl3kbmebOtufSw1SXBsVzjL7mevkV+kaej4
         zFGVFNplx768vL1r8WhpzQHYrNfTUBwDW/tZ/EtkWnTs2FtY6tKGbH2/LAr+o8LZAd7n
         wEcQ==
X-Gm-Message-State: AOAM530XV1qqjXehs9WYw+2zXl1YqWjn2V59pwTX3T3lChpc1hw6l3+j
        p+aGOz384WgxL66o/VFV+tHmLm+W/rZP6g==
X-Google-Smtp-Source: ABdhPJyutyAC+6v8JDWIAQfUH8/TU3twNhAttAv5be1/DFsDgY6MSLw6CmFw8o4OQ30z+69C5AaZ9w==
X-Received: by 2002:a5d:67cd:: with SMTP id n13mr2271991wrw.86.1634931377673;
        Fri, 22 Oct 2021 12:36:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7sm8871814wrs.73.2021.10.22.12.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 12:36:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/10] command-list.txt: sort with "LC_ALL=C sort"
Date:   Fri, 22 Oct 2021 21:36:05 +0200
Message-Id: <patch-v2-01.10-96885282988-20211022T193027Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1505.g075a284c562
In-Reply-To: <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
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
2.33.1.1505.g075a284c562

