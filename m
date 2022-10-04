Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E99C433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiJDNZP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiJDNYn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:24:43 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFFB52E7F
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:24:18 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so7530931wmq.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krtQETkdULqfzobaKUitiyT82CSVBc/hoCY+9WxZ6sw=;
        b=IUOawlFpVfSETrjiw9drsH0HlFSfTFiJpY59yvEtRMhF8qleri7xeo28cF8TgP8nmy
         c2Ff66U87Q5Vavyv9AuQxjQHPBRLEvLKJMasE9VSkLvucuw4aztpHGOtCHHMhNo0NMAv
         pmg8wu/XeDsGivm4fAuwsySLNORCh5ntBkHozYQgr4SYl6We0sxoS0uVXPAOCSsgA94p
         5rbrQFiRxrnZJRY5u4Aiq5ozdbS1+qy/Hn5gXBYL+YtMNVsGrLx5zEZxABoyItUmmuj5
         o7YSFcvMMntP6+Uyz/ALI+d23E4mqlOgOJKbMTK2uvui70RX2pCqbjIMghAzPRdz+1om
         Le9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krtQETkdULqfzobaKUitiyT82CSVBc/hoCY+9WxZ6sw=;
        b=vercOIF90yvGpmpDSrYjLM3VhgHAZJMOQKE2+y5SySjBZAkGJTN3Ar2cPr4ybDk1Ah
         MxfufVQCjxwpRhha7A9Kyrvr4L4VBZRdKGODqKdUBN4PRU2dm2+M9FvOHRvwUQXjliVN
         k0pMKoItmBWK9NPchUDaKNrdmk+95a5nXbHybwlq9s7sHiGJH9TTubaWGYFy3s041RAt
         /aw9+bO8v3iWNZL/EdlBBQems39LiBg64r3GioEP2WySy0aT1PbJnxj4mV9MTRdRR3pW
         1x9hxhF99qd2ASsyEDCJj936DgGuSqIiD0DqIlvAhwFzXV653Nc6dQdjlbl7AG1Onmmt
         g7VA==
X-Gm-Message-State: ACrzQf1l4BMMgtddHwlWNwqpt0vRPIUc1yV6XYiWo02ziDMoNCTsuKya
        3NhUGwpVjO5rlbyJtfMGvGbRGGZvTF+2zA==
X-Google-Smtp-Source: AMsMyM7aD/9R3DQIMXQirj6lY24TMzpFAzqkzQJp6TLjdOR5XN5ivsUfOi4be0h896ZykK/8OR9Aiw==
X-Received: by 2002:a05:600c:43d3:b0:3b3:2f1c:f01c with SMTP id f19-20020a05600c43d300b003b32f1cf01cmr10158491wmn.152.1664889856577;
        Tue, 04 Oct 2022 06:24:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm19666022wma.6.2022.10.04.06.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:24:15 -0700 (PDT)
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
Subject: [PATCH v4 20/34] doc txt & -h consistency: make "rerere" consistent
Date:   Tue,  4 Oct 2022 15:23:34 +0200
Message-Id: <patch-v4-20.34-729029f49c3-20221004T132211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For "rerere" say "pathspec" consistently, and list the subcommands in
the order that they're discussed in the "COMMANDS" section of the
documentation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-rerere.txt | 2 +-
 builtin/rerere.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index 9d0e6f53e7e..992b469270c 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -8,7 +8,7 @@ git-rerere - Reuse recorded resolution of conflicted merges
 SYNOPSIS
 --------
 [verse]
-'git rerere' [clear | forget <pathspec> | diff | remaining | status | gc]
+'git rerere' [clear | forget <pathspec>... | diff | status | remaining | gc]
 
 DESCRIPTION
 -----------
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 12570537d37..8b7392d5b44 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -10,7 +10,7 @@
 #include "pathspec.h"
 
 static const char * const rerere_usage[] = {
-	N_("git rerere [clear | forget <pathspec>... | status | remaining | diff | gc]"),
+	N_("git rerere [clear | forget <pathspec>... | diff | status | remaining | gc]"),
 	NULL,
 };
 
-- 
2.38.0.rc2.935.g6b421ae1592

