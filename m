Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B95C433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 09:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238896AbiBYJF1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 04:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238880AbiBYJFT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 04:05:19 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC4B23531B
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 01:04:47 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id b5so3433130wrr.2
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 01:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gF+SDyi14BXswyjd7YDa/Nj5zwDUAcBJ4i++AJaHaDM=;
        b=H+FIpntuYZIVbFzsmbQgLBmTrc4XiDvNtwdA6X4h1gqUTV5zPv5XVqBF+qEINePsZy
         0ZZVwMpdKITwQ6LdnRcAZdhQzFJX41YLXLsRTFym8M/+jyGVUuw1B/KpP9UgFToR5Q81
         mcX09l77hhb1Do/ozAfonmdSKrP5oq3IJIhiGLzyNLpLsStvGgn1M4ceauWFKUXxD354
         T5pA8PAtEhwEk0e7gpens3CQ5LeOapwnfo7BT//9zZlT+gcuhntq7IKslSpdI2tGQzP0
         Ya2kWG3txzcfM8ySVaDeSmKM4zbKj9xdZHsFfA9gc2YUXItXMZmCsCzNCylu2axKSvF3
         chzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gF+SDyi14BXswyjd7YDa/Nj5zwDUAcBJ4i++AJaHaDM=;
        b=pSUmICO+qqVaH45yaBxX3uR7gF4GoNpg09mMVsj0Scej80bKS1Xt/nJteOk0M/KoIK
         L/teEfz1tBUSBLU6abzda+dQAaI7/iWs14vxRDcG7vfPOiJrIyVeppaiK6uHzWPn24wX
         JE806h7Tjxq1EW0XTCU/v7h7HeJr15n/YXxbIVLfxsIl9hHd/JO+i+tbgl5yZovJQBDZ
         J46G5PbXYGLQ/BldYNuDCSutrMgMvSblFGzCyTL/Bsvrlel+x/Le+etOBmSwe+wRZYXI
         13WqRYnNwOIHMUGXpTjVdhBJJdSYIbU5SAHI5z6yOL4rEBJfL4nWCnD88qAzQ/5a0e65
         uPkQ==
X-Gm-Message-State: AOAM530dYlRTFNy/44mO64xpogKs6r4lNx1xDPfhCpUi2CV0Wi+TVKxr
        FhvxubLpj/tGODJdmCgWorLMq3pCL+FqPg==
X-Google-Smtp-Source: ABdhPJwf4hx1t2HL/xWjTM9a5bTp5FyhDfJpn4OODI1yVl1w+xWkrYBoof0ehNjLy6OXioa8dcD9Fw==
X-Received: by 2002:adf:e804:0:b0:1ea:9c3b:8f41 with SMTP id o4-20020adfe804000000b001ea9c3b8f41mr5413741wrm.53.1645779885655;
        Fri, 25 Feb 2022 01:04:45 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l38-20020a05600c1d2600b0037e9090fb1esm5636657wms.24.2022.02.25.01.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 01:04:45 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 6/9] Makefile: move $(comma), $(empty) and $(space) to shared.mak
Date:   Fri, 25 Feb 2022 10:04:32 +0100
Message-Id: <patch-v3-6.9-1b6ecb27f02-20220225T090127Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1175.gf9e1b23ea35
In-Reply-To: <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com>
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
index 1462016a3f4..81b2eaa0355 100644
--- a/Makefile
+++ b/Makefile
@@ -1289,10 +1289,6 @@ endif
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
index 1dda948df09..f6b589ffd8f 100644
--- a/shared.mak
+++ b/shared.mak
@@ -23,3 +23,11 @@
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
2.35.1.1175.gf9e1b23ea35

