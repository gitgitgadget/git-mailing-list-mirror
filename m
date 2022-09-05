Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAD2ECAAA1
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 08:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237869AbiIEI3d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237822AbiIEI2s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 04:28:48 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221FE4D4FE
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 01:27:29 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso7369268wmc.0
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 01:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=IdUy3+kZe4DFrQgXE6IqVhIyiNFZjiUVuT2YejjzYl4=;
        b=gIynVatqXSmXncPCbGVX5WKzU6Vko0y2wU8xzzjPeYi2SEEG9g4tsiILo2HYOTT4Jd
         vJ229qUaxH2c2iLvWB7SCcovTfQiGTPyGfMNRIGMlplVP4O2OLYZRj6EdxRXtYp+cn7f
         yzUfFhpkTUbFV+fMpd0ET95W/Ekk1kZbSG7ezEqx+iLtp7gR0tPa6gbY+otQHGPonJuX
         mra4kqCWqY3bshgP9KFQr2PuPdttQWAOGS/LeKbRxsHf1ldMUuYYFXxAKcX+/jwzI9qL
         Du1gj1BMxGJ4nxDru/CpizaUpo61u0ID8eE0FwRuu3XSG20tH1Pn4k1aYGYrfMHRtwXH
         RT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IdUy3+kZe4DFrQgXE6IqVhIyiNFZjiUVuT2YejjzYl4=;
        b=tY59UYtQnKdB9ICcKbrZ/LwMviQj/9W9QRobgF4s7+f9Utp4bLaC4B8Z8IIuFPUm20
         DcVOn8Q5lL03LjNx+wPJjCHuF1L/AoyC0fwQX3LUQQHeDDHxQPKPumm3NzwKspsz95ay
         qFISUCbuQwJQvT/VSBY5Y67idDlLvsvJPVx4rFDrZ5Rnys8pbfn14tFoKRHrG6ULWpqZ
         pTOqNpFB2S11NFikB1LF/KVubJagm7xYYqJ4kgziexOOXlmyl0Ix53MXypvc76TN70sY
         KxjqabRmjPltZa0GS2D3/b1i7kOhWCVKZRH5Q3ggKNPqmNebrTC+Aw1V1vX99TPv6tGQ
         1j2Q==
X-Gm-Message-State: ACgBeo22toxKTqXQLhCMYgLKq0JCvkqkUQ3M9IvKFnNpIIPuiJc5ueBC
        3kaNxr9+exxz40eOfMAB/hnaCdJIEtsiCA==
X-Google-Smtp-Source: AA6agR7621J7qXq84rZGfCQt1Es+AG2vV/MAprncF/Vujvyj3M8IzTKb0Fj0XvaxMNHIof/Q/xmlqA==
X-Received: by 2002:a05:600c:4f10:b0:3a5:f8c8:a5b5 with SMTP id l16-20020a05600c4f1000b003a5f8c8a5b5mr10083364wmq.34.1662366444112;
        Mon, 05 Sep 2022 01:27:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm10564258wmq.48.2022.09.05.01.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:27:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 33/34] doc txt & -h consistency: make "worktree" consistent
Date:   Mon,  5 Sep 2022 10:26:44 +0200
Message-Id: <patch-33.34-280c3b56d97-20220902T092734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1425.g73df845bcb2
In-Reply-To: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
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
2.37.3.1425.g73df845bcb2

