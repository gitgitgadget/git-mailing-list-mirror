Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCBCECAAA1
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 08:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237695AbiIEI2L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237649AbiIEI1h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 04:27:37 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AFF252AF
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 01:27:13 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id f15so5525146wrw.3
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 01:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=k0Kx5hEfJaNXhIG6r5nwD8RoliH0ncXHdYdbPcXmGdg=;
        b=e2Tw53qNZ8UaD/FPiFCSoRcX6nSqt2to7YOC6Rwk+jOXQT+6NYpy0OkwNpIartbCBI
         KT5sjc3CK9fbosSRDNU6vBj3C1V2GMQ0/3t59BXTh+SZHLgfoxVyVFs4m65OmdtfuQgc
         pqa/NCmtm76ULUl5CL/E08HToJ3mPaJEYFq6A50o7ThyuDVzVpLoIKr7cQwfCcl6Rcci
         b+lzm6MGx/2pWZVKdPeQYaF0xsSYTAtzuLoQMgfTC4ojVpHLTr/LX1nFxLZBC85ZBYhN
         I5n7Zuf9Hh9ftX9zrkNB+1Fvk7oxBdP4z/ENwa6OIgmgX1gCYXM201EQad1A7M4pYga+
         vLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=k0Kx5hEfJaNXhIG6r5nwD8RoliH0ncXHdYdbPcXmGdg=;
        b=umAjAQTegWrk+6ayP3faJxLnKQJYyX6Uf9ca5HWGi2SPymCRxxvAL4PvVi4d27FEqU
         OW9GYiqiOZ60VsT1LjbplZAv+6NvhUazJ6R70Mi82GKDvZfEVkDbDN0H9gZBPNyk9hvx
         iZbXLpZuf32p7nC9HjtsHjnF2FV+p4yAgHScdjy5+D7NS1zBYg55D9kftLTWeBvs83xa
         +n6YmWU8oYz0YFoOLuHxO1kvdnPlSma/2sAmFRS34qpwhgOud2YeB2bluc3pYb6QxUOH
         iwWG9MCmEPMSZe1AZAT+Brw1rCV5xa3m9MyfJS7vFaQqXYhooNHI9D4juyIRrMeysA0r
         Pdlg==
X-Gm-Message-State: ACgBeo2cDbmwkr/P97WeKW3va/TO1NzzhV+35ddSNKbR4jXgw29umCtg
        kEiaF83DpfQnyexjs0O6uTPle3K3bedMtQ==
X-Google-Smtp-Source: AA6agR6XpGEUAyTRWdde2JKXNv09lBP70czV/mUlOD6jGvbGm6DG6apkc7msZz5VATdVf751SWgoAw==
X-Received: by 2002:a05:6000:1a86:b0:226:fd9b:7357 with SMTP id f6-20020a0560001a8600b00226fd9b7357mr9708287wry.458.1662366432500;
        Mon, 05 Sep 2022 01:27:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm10564258wmq.48.2022.09.05.01.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:27:11 -0700 (PDT)
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
Subject: [PATCH 21/34] doc txt & -h consistency: make "rerere" consistent
Date:   Mon,  5 Sep 2022 10:26:32 +0200
Message-Id: <patch-21.34-50e1a8c2b1e-20220902T092734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1425.g73df845bcb2
In-Reply-To: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
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
2.37.3.1425.g73df845bcb2

