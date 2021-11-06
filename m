Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAE3C433FE
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8526A60F5A
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbhKFVGc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235149AbhKFVGT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:06:19 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10FCC061220
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:03:29 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d5so19540787wrc.1
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Apt9TufHmLE2IWIO6wr0yVzlw/fUVTEvSsIOvziBoEY=;
        b=nGC0K3BrLEhyh0zyS0J6JNqZIlnxReSM6OtcxqV0tAXVPYVCbN7TLGpXhg6SPFDB8k
         P4kZAa0C6elY6zZC5JBJnrBRyq8Uc4w+/OBEFXqDb76QF5+Zk5j+YUnOp68U92PvVqgv
         4wQjKnj3laEMi4h6ZyuxjmoSAYxgAAI6lCCPIGGYv7djdaMOn5puMD/I1HmUBj54GOER
         7sFV1vG3rulILstnZ1NRZOWdTGbgNKkne4YtsdQ3ntGrrCfT+eNzjSrpDYZjkTZ/Lc9f
         81dH2S4yPr4nGKMitjyi+ln1LQZlhprq3ILX9MUvGR9Mni4HYELY+hCKMev8BtovQtXc
         /uiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Apt9TufHmLE2IWIO6wr0yVzlw/fUVTEvSsIOvziBoEY=;
        b=wHNKBTeiaTRA47+SZ6GB/tCHLvwG+VWXDJsoKyiUH/NB/MSeclZaqabiJqUs2rduJO
         ULA1byOZvyIRsBn062KiFrsl5mJxpS0ma2cUahQs1wqYPYKzmHL9IBHvXgTdydpdtrrT
         tLJhAg4Q0FGC4SN/yiJ4yUUPQ+E16vVMfqEBQDcSmyK5I/zaikorTePsd4Y6E9M96rBW
         0y+fkdJRNKv4lKmYR11gg2Kpe08XSJ259Lh2FgyNw73u6YHRpDV6sYQprp+HgM7KZVHV
         otBdnktA4BBMZ4K6y/8Kf28mDv9OoATg2cKwGg6x639Zpb4xpuKfGAuIFsQ2iINeST1Q
         +XeA==
X-Gm-Message-State: AOAM532uJmpp3JFalOBValebM+T3gQnYJoVBhcHV6/iZkmj46EWpFwil
        YG4va/VrSGvjkjGiXP7JALsgDijZEn+o+Q==
X-Google-Smtp-Source: ABdhPJy1Fs+0+3wlVhZIYN1lno+HawrLAg/IbjhpFm4pkYlruBGdXZFlT/Vd0I7vPq7vssaQMAsNyQ==
X-Received: by 2002:a05:6000:156a:: with SMTP id 10mr60860436wrz.87.1636232608249;
        Sat, 06 Nov 2021 14:03:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u16sm14108433wmc.21.2021.11.06.14.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:03:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/16] Makefile: move $(comma), $(empty) and $(space) to shared.mak
Date:   Sat,  6 Nov 2021 22:03:11 +0100
Message-Id: <patch-10.16-67ba72dc2e6-20211106T205717Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com>
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
index e65d346e7cd..f3ad497fcb1 100644
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
2.34.0.rc1.741.gab7bfd97031

