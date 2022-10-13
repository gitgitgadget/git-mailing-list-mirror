Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B223C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 15:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiJMPlh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiJMPkr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 11:40:47 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F1160CAD
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:40:10 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n12so3428151wrp.10
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwJt8r++wvqYyCPQ8c2F31v+2wvnbfgh9oel/MItbVA=;
        b=RyBxTubrXGH9dyDL1V6dwt6UlmB+h9Wx78+31+O92CvAabMPXl/IJ1lNw3PJ7nDcK4
         UqScqLfaEbv7ef9nDmtUFluxaxl+lLmlgbGk4Y3a6YUnD6B2oBzPPXTWmrS0I0wEkc4r
         guSZB4WRBKilhQtccPlixz5oq25ri6Vu+zFtMegqAOp1xCO6bi3NZ8pYGJzFj5/2aFiX
         MdrEmXLW4vsX9dG2OLYTexYONpgbswogcWaOTdjvh17iPPm/crNa2yIJvExo/R/vuysc
         v8jwaukXH65nhpmDHCQwVnrwkChT7wxxAR0mZqOTeZaL4b1FgtG5hlT8p1uKni1Bu9zE
         LAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwJt8r++wvqYyCPQ8c2F31v+2wvnbfgh9oel/MItbVA=;
        b=HKxWE0MjExso6dqdL7q8k4jO8giNqTk7xmdIu1jg5h049ZRkSWS6Yfyv0qpCpzBVll
         fyQdwGdpbsVAS7xj1UNJ4JszV37fedSSgRvkZvD05gnD1OTHrdH1mNOfvas9fTZW3w4G
         HSxbWvDMoLgQp5a+gOGTcoYWuXx8c5Y+toZi8va+hR907ePMY1d4+zLoVj8ddB6lrwUa
         9Akc3VERe5Ld29DaKAa38pPpiMGm2GsJ4jbz2mskiAha2kpXnrqH2gecmrSyvYCp9o4k
         VLR/k8QPLq8cFRZhNylWoOEBvkz7YcoCcqXcCtGh0C4MJo3YeWFtsKxznHIueF9zqiCj
         Ybvg==
X-Gm-Message-State: ACrzQf1Y9hFA3u3LjtdBK0qFIeUXs/AQm/+PmkjMTNEJIScqqGoBKtAq
        OZZXA9GVtTYydZhlJfdl6+Inrw3gS1jtnQ==
X-Google-Smtp-Source: AMsMyM6h5R+3h3ZaRwMf21aSnoc9DTXGiwzcuZaePiFaaU9GF0WuFgjGCwq4aj94LXB/EyqSyG418A==
X-Received: by 2002:a5d:4cc2:0:b0:22e:372d:9c9 with SMTP id c2-20020a5d4cc2000000b0022e372d09c9mr408736wrt.576.1665675609324;
        Thu, 13 Oct 2022 08:40:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id da12-20020a056000408c00b0022a3a887ceasm2258130wrb.49.2022.10.13.08.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:40:08 -0700 (PDT)
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
Subject: [PATCH v5 32/34] doc txt & -h consistency: make "worktree" consistent
Date:   Thu, 13 Oct 2022 17:39:26 +0200
Message-Id: <patch-v5-32.34-48c1bb97a91-20221013T153626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1085.gb7e61c3016c
In-Reply-To: <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
References: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com> <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
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
2.38.0.1085.gb7e61c3016c

