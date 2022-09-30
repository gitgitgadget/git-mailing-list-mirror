Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B91EC433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbiI3SLE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbiI3SKa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:10:30 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD741EDF7C
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:09:25 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id c192-20020a1c35c9000000b003b51339d350so5493665wma.3
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=krtQETkdULqfzobaKUitiyT82CSVBc/hoCY+9WxZ6sw=;
        b=oZ2iTIwqoYLHERgdtflbilcJ3WN+TgIgV86QUVBWVNmCMxWxSovG+ooAgXGaRJa95/
         YZil1Lwk/dAQTtQCp9U6DKAAG5vBccoBGPjtV7enl71ktto+eK5OisQz6/SbmvDOw9BF
         hf1SSZCof+01/yenZZlTzX6igcFoFzSYCDBduby5n80CoZPZofdELM18Utrm/C6hJ8dW
         b0zNQ+J/oJcYh9fMyUGlgWYa7kVPAbYBUKam6m1fEZkF7mceGgkORT4HKq7pRCfHehYp
         4f8q6OifttBuP6Gl+GvPRyWklTiEKIe6FSpkS7wtR+VjW5x/z8f3SkZ63iViYSUrBn0u
         5Rqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=krtQETkdULqfzobaKUitiyT82CSVBc/hoCY+9WxZ6sw=;
        b=ymciFM0RTBdaxz2mLRrGErfGa8G2LfoNXdQJAOnwD2i+9iZJe42J4rA/Qr+nWJTCeE
         0+93lub70UHKgryRTFXvY+M3dugTpaqHb0JheflOK86pHuWkB1FV0nPhl7RJxDxC1u9Y
         NQrDsXapCzyuRxycOcTr6uXZg0ThjFtBfg8zZJYwj/JEKEGnVlxqbrpc/AyCGU4Muoc9
         +ctP8C0K/NkLpE+eybhCJ9AInhGdfGBRjxXYLIiG3eK8R3JZztWchr/pC3JsG7ZVbdgS
         edE7oStDCELhS0yJRpnGYZr3q3wVp2EbFiR1cQtOnbyKKyczVIOkObwiftSfuYdXUmhM
         tJMw==
X-Gm-Message-State: ACrzQf2PTHbJRXYKK8CIgaFme19IkRW7gaAlPwJ5C+tmNPVSH4Znb7X0
        iP7MAiOeEGrS9NomWa/i5cNT1Q2GbCda5w==
X-Google-Smtp-Source: AMsMyM5pNQ75PxfpkvmEExn7zpTUBHwnkNJtq1pcgcVz+c+rsqHiyfqvGY8pZtZRO1PUliRpEsCB0w==
X-Received: by 2002:a05:600c:3d93:b0:3b4:c28f:6a2b with SMTP id bi19-20020a05600c3d9300b003b4c28f6a2bmr6685056wmb.121.1664561365148;
        Fri, 30 Sep 2022 11:09:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:09:23 -0700 (PDT)
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
Subject: [PATCH v3 22/36] doc txt & -h consistency: make "rerere" consistent
Date:   Fri, 30 Sep 2022 20:07:45 +0200
Message-Id: <patch-v3-22.36-702eb747c0f-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
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

