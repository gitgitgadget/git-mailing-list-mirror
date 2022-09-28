Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6E4C32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 08:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbiI1IlQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbiI1IkF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 04:40:05 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1E57DF6C
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:40:00 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bk15so10872358wrb.13
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=DzdByMJaRee6JGxwM+aKTxKYsrYmKzjUL3zWlOyMhCk=;
        b=H1o4MfoNJ07jPYJT+ZyjrxTcsj88hx8hwOgoTJqVIGyzKS/tVZ7Dgyi+wA+R8HGsA9
         N+ObataMyX9mRUfagzN7Ij4CgeNVIdx5Q5CF+SwpFLuB/BVyf6MLQiy40u86ayyvS8Gl
         OzMvyyDnyJxyuC+zQJJYEnvrRYPakwAYD7Ne5KbcyyHo90TW+3Vmaz06B74aWcxORAh+
         7C+YBluHbfHz925g5dihNB3fF2feiDY2L4ILK4sC8lLr0tIlLKku7paAPnGq4oO8mios
         v6n3lau6o2TPsCE5zW1shAHH04Fp/trpNwNhhEw8Zuf4k2UC+ToTR5EBAh3Zya5uplK+
         EmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DzdByMJaRee6JGxwM+aKTxKYsrYmKzjUL3zWlOyMhCk=;
        b=snrjwDw2OH3+2HzDQSVwfhqjbYN/oSQ5i3yFSGT37jach58t0jRjY9um+Rl5z9Z/NE
         6t+5Zb4SyB0HVVhii3glF0JBDPoFMoQzm4kjgNspVpCUoNuhcTfvVpcGwlwXgHBb3msc
         diE+rad0kBw8/rdIgPUimW8jUBngdy3tISm6SmqKtZzu4L3ASjnkVwWXKBV7WTB5y800
         GfgRr3mohFtZJpatzOADV21bSSxxk59JYEnW3rFyUV8w3ZQg0CyJ8pgR9RAHmtlczYpl
         /YdtIoVolFGP6u+k0Ut0h1ZBB9F2ZvYe4ky14b1/hvjHAUaBlGF8juK5RUWHQ8ynVO96
         WyEQ==
X-Gm-Message-State: ACrzQf3g8W/BUWtLAzTMRo7PFUyq1jC5moDfm0dry6yrh5430SzR+Z6p
        dgcUc0vzIzLmPxASUEm2Y3n9ypWTRK480w==
X-Google-Smtp-Source: AMsMyM4DJ6r25GhdKYoY6mEoC7OrwQrCO0sTHi6wVIJsx+v9voA5llRRNslasrRi8hRn3yj6GzPd5w==
X-Received: by 2002:adf:db03:0:b0:22a:dd80:4b45 with SMTP id s3-20020adfdb03000000b0022add804b45mr19188133wri.111.1664354398159;
        Wed, 28 Sep 2022 01:39:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003b31fc77407sm1075026wmf.30.2022.09.28.01.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:39:57 -0700 (PDT)
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
Subject: [PATCH v2 21/35] doc txt & -h consistency: make "rerere" consistent
Date:   Wed, 28 Sep 2022 10:39:16 +0200
Message-Id: <patch-v2-21.35-5785ed1d667-20220928T082458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.925.gb61c5ccd7da
In-Reply-To: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com> <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
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
2.38.0.rc1.925.gb61c5ccd7da

