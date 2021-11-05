Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3185FC433EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 14:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04D0061076
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 14:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbhKEOKx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 10:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbhKEOKw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 10:10:52 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151A5C061714
        for <git@vger.kernel.org>; Fri,  5 Nov 2021 07:08:13 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d3so13928288wrh.8
        for <git@vger.kernel.org>; Fri, 05 Nov 2021 07:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EE9TjhQXGzSZqFY+lGR31cLkENc3lw8yQgsjfSvAV5I=;
        b=L+AFRnS9sp/hsboqzji3cYSrt8SBsBxKcNOZ3j5dXWw+d/woKfTEdwNVzU6ds8HPtq
         6VvmNiN4bA8wGJpqGeL4wGwW7x1rKJ7OYsr5xrdNEXll0UrEoSQSryqTKwRVWraew5u3
         iTTzM80LwoxRJYyZ6NMBWb+tZbce3PIdUFgUnKWHoQ28N0YqWiMft0X3bn3zc28V6Bl/
         364/tRMrseX79D9OTLUcYeNfDQ656V8qVjee9OIl6vbUu47oQTiXDjeIgUUWCzg3hqOA
         +3hkMcTiMGE35PcKcvERzeaDEyJUhGtAxQOmTf6yxxSX1WTEubOd9t5hFY0ptRy5fcfz
         Od9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EE9TjhQXGzSZqFY+lGR31cLkENc3lw8yQgsjfSvAV5I=;
        b=EOr/72PUTye5qJ+HDHq+WcC9ZGTjg6UKLHS8d666hmHl/LEyY6nLlrIeW/Fc5//1Jg
         bYnQPRYTK7TZlnl37vOQMNAOZKYkyUrMh1SXbLhA7tJlOCthlLCHnn172TqUPZe8lyEu
         XIyKMFVXjnUbGb9aH49yck+DhKCQEHUY04k5xdk0eNvxPLskCrhLJz+IjNLelFsSfz1T
         15WWf3y9nJVo0E9SlzbCbrP4ggcr3XecTnY/7SP6aomsNh27O7JAvl/2NSlwOxGQzrzl
         qN+hw5wwu370sbBcENh28ExAJsHn8Yz+ZukE+bG5y4GM4LOnSKzJPBMEQKUdzmNvQrbW
         ngYg==
X-Gm-Message-State: AOAM5311SSgYR/JavEqbjwZUEdm6FrR3NBNnFk5+2Z2uDhvOa5Ldi7Ei
        RcCQpFQ1SjdCq/c/kqvevpEVlSBGfPXpvQ==
X-Google-Smtp-Source: ABdhPJy8x42mj7k6Y+DT3gi54cfA1g9Zm9VVWyIDvdw8HuCsqRwUO6iAwFqREF9bCHoiGPC2nDnMUg==
X-Received: by 2002:adf:c40f:: with SMTP id v15mr64826537wrf.302.1636121291410;
        Fri, 05 Nov 2021 07:08:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7821556wrs.19.2021.11.05.07.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 07:08:11 -0700 (PDT)
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
Subject: [PATCH v3 01/10] command-list.txt: sort with "LC_ALL=C sort"
Date:   Fri,  5 Nov 2021 15:07:59 +0100
Message-Id: <patch-v3-01.10-c385e84c04c-20211105T135058Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-v3-00.10-00000000000-20211105T135058Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211105T135058Z-avarab@gmail.com>
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

Note that this refers to the sort order of the lines in
command-list.txt, a subsequent commit will also change how we treat
the sort order of the "category" fields, but that's unrelated to this
change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 command-list.txt | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/command-list.txt b/command-list.txt
index eb9cee8dee9..04cde20c3da 100644
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
 git-sparse-checkout                     mainporcelain
-git-stash                               mainporcelain
 git-stage                                                               complete
+git-stash                               mainporcelain
 git-status                              mainporcelain           info
 git-stripspace                          purehelpers
 git-submodule                           mainporcelain
@@ -189,7 +188,6 @@ git-var                                 plumbinginterrogators
 git-verify-commit                       ancillaryinterrogators
 git-verify-pack                         plumbinginterrogators
 git-verify-tag                          ancillaryinterrogators
-gitweb                                  ancillaryinterrogators
 git-whatchanged                         ancillaryinterrogators          complete
 git-worktree                            mainporcelain
 git-write-tree                          plumbingmanipulators
@@ -204,6 +202,7 @@ gitfaq                                  guide
 gitglossary                             guide
 githooks                                guide
 gitignore                               guide
+gitk                                    mainporcelain
 gitmailmap                              guide
 gitmodules                              guide
 gitnamespaces                           guide
@@ -211,6 +210,7 @@ gitremote-helpers                       guide
 gitrepository-layout                    guide
 gitrevisions                            guide
 gitsubmodules                           guide
-gittutorial-2                           guide
 gittutorial                             guide
+gittutorial-2                           guide
+gitweb                                  ancillaryinterrogators
 gitworkflows                            guide
-- 
2.34.0.rc1.721.ga0c1db665bc

