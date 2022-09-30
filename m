Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389A8C433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbiI3SMT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiI3SLO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:11:14 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6109597EFE
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:10:03 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 130-20020a1c0288000000b003b494ffc00bso4970820wmc.0
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+kCcuz/mmx8LGhkDD+YkP+/Mz0j4n8ic46mgCI2seW8=;
        b=aFuPKcxE2Z+0tKcMmYv1KbrraOYwNekLV9fzZ2s9a5sKr/tuKgdKsx3SDQE076fxsO
         dCLAmK0jYchXbMxywB5sBrqkvz5LQVgaE1cS0iWBpQJZKsB5vfmJ04060/ROpGWCTbmH
         wWvVOncn5c2JwbGJxszG09JZzYeEqoihN6w2UTQkLORppWE21mGzl6SZmTp/sq+uGJcN
         xWUMworIeTV1/j61xoz/phlQ9eMoknvRVmYRbfe5gf94yQfS5cdFmX7B/M1T/p1KVJRM
         guYAyBduaM9sugTe6YruOrApH8gOA+owglnGQ+VwY1pHlybyKJ04MquCac5SkXzY3Pgl
         2W1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+kCcuz/mmx8LGhkDD+YkP+/Mz0j4n8ic46mgCI2seW8=;
        b=WpnfUUdmdLdQFwBtD5yTUYnlhlDe6QLQypDFxZyIeEa/8+GYdrXC0tEOfmSZUABzVY
         zzWMc1OpnyeTClOz5lWlBpaW0SetVZvQ2myWmJlERZO+Z6l09hN8g1n3087R/qMOztXt
         GLNBoKWGk9aCG5IqckcJolKPu5x/dD8hr9JUdsVHSKnVGvcUomudqED+U0Qq0/lJ5QlX
         /xqao0ZMTyCmOff+15/NP7MTZ0w2UiakQCLiP7+BxHRxbOmo68WXBSOViwMCoN/KidU2
         cwwrfx4sWWtNLUaoT1R3gS+4zuGhLemeU9NZ4QAMvfRZhDn6vSXxeqJSVQdr5y46b81m
         aGWA==
X-Gm-Message-State: ACrzQf34GWUapAHufTTiPPxU48LODxl6D6C74f52Hzj7LejmRnYh7z1d
        pdikf7vgYCe8KPX2xC6HUk3OAekJmINr3w==
X-Google-Smtp-Source: AMsMyM5KJMDs2t7ZfM2mTUqpPhhdqVo+CrJ+bghTfpHpvuqScpNZAZYhfnbDYPfBemqO3WB0loG+Mg==
X-Received: by 2002:a05:600c:1694:b0:3b4:6205:1f95 with SMTP id k20-20020a05600c169400b003b462051f95mr15604891wmn.151.1664561401471;
        Fri, 30 Sep 2022 11:10:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:10:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 34/36] doc txt & -h consistency: make "worktree" consistent
Date:   Fri, 30 Sep 2022 20:07:57 +0200
Message-Id: <patch-v3-34.36-efd0c2c634d-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the "worktree" -h output consistent with the *.txt version.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/worktree.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index ba6846c3788..4a24d53be15 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -16,17 +16,18 @@
 #include "quote.h"
 
 #define BUILTIN_WORKTREE_ADD_USAGE \
-	N_("git worktree add [<options>] <path> [<commit-ish>]")
+	N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reason <string>]]\n" \
+	   "                 [-b <new-branch>] <path> [<commit-ish>]")
 #define BUILTIN_WORKTREE_LIST_USAGE \
-	N_("git worktree list [<options>]")
+	N_("git worktree list [-v | --porcelain [-z]]")
 #define BUILTIN_WORKTREE_LOCK_USAGE \
-	N_("git worktree lock [<options>] <path>")
+	N_("git worktree lock [--reason <string>] <worktree>")
 #define BUILTIN_WORKTREE_MOVE_USAGE \
 	N_("git worktree move <worktree> <new-path>")
 #define BUILTIN_WORKTREE_PRUNE_USAGE \
-	N_("git worktree prune [<options>]")
+	N_("git worktree prune [-n] [-v] [--expire <expire>]")
 #define BUILTIN_WORKTREE_REMOVE_USAGE \
-	N_("git worktree remove [<options>] <worktree>")
+	N_("git worktree remove [-f] <worktree>")
 #define BUILTIN_WORKTREE_REPAIR_USAGE \
 	N_("git worktree repair [<path>...]")
 #define BUILTIN_WORKTREE_UNLOCK_USAGE \
-- 
2.38.0.rc2.935.g6b421ae1592

