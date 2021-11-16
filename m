Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A618C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BA506140D
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbhKPMGz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 07:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbhKPMEi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 07:04:38 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9BDC06122C
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:46 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso1724808wmr.4
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=393N/MjNX6iCyNl/tl80+jAwpO4YdgKQAG272TLbAXs=;
        b=Nukp/7Y0I4Y1pBSg2PqnlQS+b5geNYBMmeHvG+eZt+WORADh2Nb73bZ7H75KtpykDB
         vseiCImKpW7SqAkGcXl6NRygXglYN6m3L5v1TPISr71q234VYHeCi7Q+qi2M1xMjs4N7
         ByrTt6gxH2wVLHoNmqDTo54v3DGP/kMTDf1aRbliopQlff/38RqSIxIeTrHLJmE21tJ/
         oQQkQ4uty/YMOQhlloWdn3WPX+Of7neA3c7vF5XKtdQKDNY7inGK8pz/2v3KM9akhw/E
         cl52h9i9jx2C+XpVGrEprB4Igy/czfW8sT5D8AIzvadpjMKynBUs4vpZZFUyGMjMyz3m
         ocMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=393N/MjNX6iCyNl/tl80+jAwpO4YdgKQAG272TLbAXs=;
        b=vuH+fApQkkMJ10tU2BYvWIJVezvkrzCf+E4EWDxkNTY4BGpSnlN0badjFFyFLbfaAd
         9sVTEREcD/VonvZfhk7axaAYb7BDaa/LSYhJc0JkBr4TcLPWbOrTnsXTEufOK7eohDHw
         YKCPJKo0N/zZx+TgscWdigy6tWEEKRzBoVSlyuD8x1+IDEj1Fx/pWMccW7GXM/Vv9p9U
         iAhXWH+6gXQeQubSl+4qjvbzjRIq9Cv/meV3nE/BoHsB3OVMlA+jzssbmMwKxpLI+fdh
         QzBjKTFkH990FvfTNzy8AREfAeVsoMSFb/UQl9rFGePR+31OsjtMpEFnbqxMwLdJsNMp
         hhyA==
X-Gm-Message-State: AOAM532uTJgYuZvQfCUQJQcSZ+ORCitZp/wCpQvWze75RTPNUWvGfgYb
        wfpCXkd2YLBN6uFv22wPFWsy8PT/FhNlCA==
X-Google-Smtp-Source: ABdhPJz6rPAKQsYtyPuWzXnwBzNzI+ca4zljoSQSL3iY0t8/pJp6h0s5EOXty+tfYolZKPDxRRQIqQ==
X-Received: by 2002:a05:600c:a08:: with SMTP id z8mr69218124wmp.165.1637064045251;
        Tue, 16 Nov 2021 04:00:45 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k37sm2427922wms.21.2021.11.16.04.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:00:44 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 13/23] Makefile: move $(comma), $(empty) and $(space) to shared.mak
Date:   Tue, 16 Nov 2021 13:00:13 +0100
Message-Id: <patch-v3-13.23-6c9291c2c9f-20211116T114334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.795.g1e9501ab396
In-Reply-To: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com> <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move these variables over to the shared.max, we'll make use of them in
a subsequent commit. There was no reason for these to be "simply
expanded variables", so let's use the normal lazy "=" assignment here.

See 425ca6710b2 (Makefile: allow combining UBSan with other
sanitizers, 2017-07-15) for the commit that introduced these.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile   | 4 ----
 shared.mak | 8 ++++++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 5ae7d012cfb..7130e32a251 100644
--- a/Makefile
+++ b/Makefile
@@ -1252,10 +1252,6 @@ endif
 ALL_CFLAGS = $(DEVELOPER_CFLAGS) $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
 
-comma := ,
-empty :=
-space := $(empty) $(empty)
-
 ifdef SANITIZE
 SANITIZERS := $(foreach flag,$(subst $(comma),$(space),$(SANITIZE)),$(flag))
 BASIC_CFLAGS += -fsanitize=$(SANITIZE) -fno-sanitize-recover=$(SANITIZE)
diff --git a/shared.mak b/shared.mak
index 0170bb397ae..2d597ef7603 100644
--- a/shared.mak
+++ b/shared.mak
@@ -7,3 +7,11 @@
 #
 #    info make --index-search=.DELETE_ON_ERROR
 .DELETE_ON_ERROR:
+
+### Global variables
+
+## comma, empty, space: handy variables as these tokens are either
+## special or can be hard to spot among other Makefile syntax.
+comma = ,
+empty =
+space = $(empty) $(empty)
-- 
2.34.0.795.g1e9501ab396

