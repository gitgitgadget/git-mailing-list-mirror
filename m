Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61645C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 09:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiLOJL2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 04:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiLOJLW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 04:11:22 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92222AE2F
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:11:20 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id w15so2329979wrl.9
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEM3FoOczQjc+wy/BvQDfEildMyd0yaFHUJLtP1qUis=;
        b=YKjPZ3vu2jxo+X5LlRljwZbAzK2CCBNf//GWOyy86rV+r5ViDtStLO9R+09PRgVSd/
         nllCMI+aalXlC0Rk0W2sCtKv3mDEo4tMuBXLv6PrP7aNs5+dlAjJZx6htVXIPToqTPPX
         /+mvlzBJRfRB06L8c59QqDIMlDn5qbBljYA6a164li73Hij5GZ4Qq6fUfTvzRcId0HDM
         0UV9TE/POeHaFu31+lzYyTBVijsMToLFfx8pCwT1Ei5qVSiZsYFthsX3ERp1bIa0ZT9M
         BSbPd9XJ2n4o+Mwv/kBpbEaHzLnMhnyymGVwEC+u94RW67rjc/7ud2POdf/R3EPrzFTS
         kMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YEM3FoOczQjc+wy/BvQDfEildMyd0yaFHUJLtP1qUis=;
        b=yaByu43wZ3aANXzMD1ek5pVS2sC7Q0wMPKzkmiXqEeFJb3cNRjBMxFpAjAfLSmqDv5
         4IcI8cAwIiZzEid2Qbe3WY4y9isO38X1DYok/OgO4wcaeQXdTZn62lXquW1J3KeZLiA2
         iEFCbM1+Tr/BEnL4osDd+e0pmbF7k8eSSduS7igCI+Da8K+ajoXFQ+AWgKK071k4v8Tl
         HFZY6wLff954Q+z58ipLblO9jbT87sKzeO8/x9e/quqUR3MOJvIttNfRVLr0uscixojr
         yEhN8aAIkGas73Yv5bQeHVTlauCaeyfky/2aCQgL+o2MwcH41AWTRp4ERZiXcPJRT9Rl
         ZUrQ==
X-Gm-Message-State: ANoB5pkTiKtSpFTNSDu+OUxcr4861yH4+z8GAw3Ja0AivRHIEwOruwB2
        sFH6BG8veguJDnsDBjha0FQOCvekzY7vqg==
X-Google-Smtp-Source: AA0mqf7jIwpL6Sjan0dvZXf9b+0/LFuBPC4lmJiAaNLj72q4SjdYzeGbu5SGc8G9g9xdXiwZOFeZ4w==
X-Received: by 2002:a5d:4745:0:b0:242:2fa:fa49 with SMTP id o5-20020a5d4745000000b0024202fafa49mr17786885wrs.18.1671095478919;
        Thu, 15 Dec 2022 01:11:18 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m7-20020a056000024700b002366f9bd717sm6193835wrz.45.2022.12.15.01.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:11:18 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 1/5] builtin/annotate.c: simplify for strvec API
Date:   Thu, 15 Dec 2022 10:11:07 +0100
Message-Id: <RFC-patch-1.5-cde038825d0-20221215T090226Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <RFC-cover-0.5-00000000000-20221215T090226Z-avarab@gmail.com>
References: <221214.86ilie48cv.gmgdl@evledraar.gmail.com> <RFC-cover-0.5-00000000000-20221215T090226Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When this code was migrated to "struct strvec" (or rather, its
predecessor API) in 8c2cfa55446 (annotate: use argv_array, 2014-07-16)
it didn't take full advantage of what we were given:

* We are always passed the name "annotate" as argv[0] here, so we
  don't need to re-hardcode it. We've already declared it in "struct
  cmd_struct commands" in git.c.

* We are guaranteed to get at least one argument, so rather than
  looping here ourselves let's have strvec_pushv() handle that. If we
  only have one argument we'll pass the terminating NULL to it, making
  it a NOOP.

This change helps to make the subsequent commit smaller, and as a
bonus removes the type discrepancy between "int" and "size_t".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/annotate.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/builtin/annotate.c b/builtin/annotate.c
index 58ff977a231..e37b269196f 100644
--- a/builtin/annotate.c
+++ b/builtin/annotate.c
@@ -7,16 +7,12 @@
 #include "builtin.h"
 #include "strvec.h"
 
-int cmd_annotate(int argc, const char **argv, const char *prefix)
+int cmd_annotate(int argc UNUSED, const char **argv, const char *prefix)
 {
 	struct strvec args = STRVEC_INIT;
-	int i;
 
-	strvec_pushl(&args, "annotate", "-c", NULL);
-
-	for (i = 1; i < argc; i++) {
-		strvec_push(&args, argv[i]);
-	}
+	strvec_pushl(&args, argv[0], "-c", NULL);
+	strvec_pushv(&args, &argv[1]);
 
 	return cmd_blame(args.nr, args.v, prefix);
 }
-- 
2.39.0.rc2.1048.g0e5493b8d5b

