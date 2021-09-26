Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEE3C433EF
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 19:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8B2C60EE5
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 19:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhIZTFS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 15:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhIZTFN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 15:05:13 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEA2C061570
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 12:03:36 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i23so45508411wrb.2
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 12:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q/XInnjGS8dWPoo6MBuw9o7czB/X+NGrNH22i+GMByw=;
        b=NUBjzmcv/OuatvvISKTTn6OsmUKwejidNfknhXRUTGvKViSmwqH2wcfYN3VhX7bvmN
         f39K56eZmSmPRRG7wnkMdmo/4ZATCQ11N88zZmSID4N7h3cxm7ZM1oYynhhb1vtENk5B
         Bq9BHdAXcqZy39MGhxLnAblUGzCtdtIcK1r17KGPFUjF/5c7EZFx+KQ9Y+RXpbGb6XzQ
         yeG0/P9t9qxIClMmXDvU/1vI+Xn3rMUejHQTZ8YfzpbH8ac8kEz+ahcF6vVdjXNu2UCa
         25EWKn52CMGldvoc4uurD3/s5ZY4McFSqhkN8p7rWl63b6jAnMqC6aYKomSn+/8r4+r4
         Dl3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q/XInnjGS8dWPoo6MBuw9o7czB/X+NGrNH22i+GMByw=;
        b=u/28VyUw05uxRV2G1PhzGtg5maU/l+j4pceAlCu09rEkDMtmgFtz1DUzKzhcYxV1fc
         i3Sogi2hSoDZMuqO8ZP5yYL0jO8lMLQY9uNUTdB7WEAUv2kXRlBaBQf2PkvaHkyJbsTg
         3OFg2ls66p00iwy6/Qj9CGvElvVLQcn66f+9RO/qZCaG0FQSznHc0+Gp4QgOJ5fT1k7H
         Tm6N02Mypgyj3fz94kxrn9NL0DSheXAy7o9r1BtqTc7TdTtEZSaINngtUeW19Jrfq1Vf
         lhst9ksvQxL0uTD0f6aoLKEmXySNtAuesA/rpSLFiFQ5REH2NqwRjysDYxaZx2/w/hRi
         eRSA==
X-Gm-Message-State: AOAM531ErPBLMqL/bZ9Li0JoKT/m+imSqll4UOwXehix26KyPfEWmcXI
        iHECUJTKVjaqKQ3aCLmmuDn8hKjYIdpL/A==
X-Google-Smtp-Source: ABdhPJwqA40psUjpdaAVar48MNZo3vfQjll9os0UuS4P0ZnzkC9optRqWrpCXbNWv1WzhFlzAVmKSg==
X-Received: by 2002:a5d:59ae:: with SMTP id p14mr24202969wrr.278.1632683014639;
        Sun, 26 Sep 2021 12:03:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v20sm14691523wra.73.2021.09.26.12.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 12:03:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/8] Makefile: don't perform "mv $@+ $@" dance for $(GENERATED_H)
Date:   Sun, 26 Sep 2021 21:03:24 +0200
Message-Id: <patch-v2-3.8-312b353c651-20210926T185800Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1291.g8857a6a91ac
In-Reply-To: <cover-v2-0.8-00000000000-20210926T185800Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20210926T185800Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "cmd.sh > $@+ && mv $@+ $@" pattern used for generating the
config-list.h and command-list.h to just "cmd.sh >$@". This was needed
as a guard to ensure that we don't have an empty file if the script
failed, but since 7b76d6bf221 (Makefile: add and use the
".DELETE_ON_ERROR" flag, 2021-06-29) GNU make ensures that doesn't
happen.

There's still a lot of other places in the Makefile where we
needlessly use this pattern, but I'm just changing these because I'm
about to add a new $(GENERATED_H) target, let's have them all look and
act the same way.

Even with ".DELETE_ON_ERROR" there is still a point to using the "mv
$@+ $@" pattern in some cases, e.g. to ensure that you have a working
binary during recompilation (see [1] for the start of a long
discussion about that), but that doesn't apply here. Nothing external
uses $(GENERATED_H) directly, it's only ever used in the context of
the Makefile's own dependency (re-)generation.

1. https://lore.kernel.org/git/8735t93h0u.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 47e79a6252a..e6b8d00f221 100644
--- a/Makefile
+++ b/Makefile
@@ -2231,15 +2231,14 @@ $(BUILT_INS): git$X
 config-list.h: generate-configlist.sh
 
 config-list.h: Documentation/*config.txt Documentation/config/*.txt
-	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh \
-		>$@+ && mv $@+ $@
+	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh >$@
 
 command-list.h: generate-cmdlist.sh command-list.txt
 
 command-list.h: $(wildcard Documentation/git*.txt)
 	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh \
 		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \
-		command-list.txt >$@+ && mv $@+ $@
+		command-list.txt >$@
 
 SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
 	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
-- 
2.33.0.1291.g8857a6a91ac

