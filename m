Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC6AC433FE
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 01:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhLQBjl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 20:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbhLQBji (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 20:39:38 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB56C061747
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 17:39:37 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id s1so1208811wrg.1
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 17:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q53gztIOIbajQ61p247fNqRZOJrPIF5t5cHz2vpHcZo=;
        b=SciW1ZrCqSrGxinfaz5dZr9GNQpzi24unQB4Z+hPOHRix2nZ/w5mplcu4OKh/l8ltD
         22d1jYFzJzjWBvsbDYj7M34aO35f7bhwtqpqpuResMWbkPZ3j68cTZQznGubTPoq+OeJ
         Z6SPKQOAtlfETFrOdkydQhMn5rPD3hjqxBbOXV1Rt89ZugwsRN5Q8TEPI24NOQRFlOvX
         pmT9kfab3lTTuf4M5H7FVgQkr1EUoXI7Pxv+ih9vjxMne/B8PpEsp+za/Qb6O99hrtSL
         gBdkhOlNi41C6ItutxGSCNo79F7ieZSYMByffMhwmwGz4fkpmqnGe+wt4/Kr/Cgm7Sc/
         nGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q53gztIOIbajQ61p247fNqRZOJrPIF5t5cHz2vpHcZo=;
        b=TIgPYTx8jC/+n8KJoyWkx7qFmMfAtv2KxB6W1c7/G+vbmVOXzErj3ppptCHhVb+D/Q
         67NH1hq0hiQuKtmb5VSb++YkYrmdOm5XncoQikVWsz8GEWrgzdrr1U7ru9VmzM1ABFAH
         i+rwZocsCIX82ZBzPm8A3NZqr/Y4h2XVf4m90lrxQWYLaoWnItCTVtV76zx0omScodJk
         Do7fSIgMO8PFWSYiNtRXEzyA1MZ61EfR62NdPewP4jGo+CrA0AI4ThNH4ZxIyVKm6wn/
         OQopIWFdjCc8eGeZG345SIQjJoiq2PrbENHRnNizl+vh0YruHGS6vRuOm+t8dQi2Mpfn
         vXAQ==
X-Gm-Message-State: AOAM533WM92XuJbNgv2JKk+RVVhguXjlrU8Ubn0oWx8/L8UMRLviW/aF
        oMP3OMmg4nyTkbInbrTlMoLH3RRPkFHSdA==
X-Google-Smtp-Source: ABdhPJx1ahHiZk0Pn3ipgAvcKqCdHQxgkRoG5KMCqFltjAtGBXTNXv3e2zL5oqZGk7H6BdSDSbla1w==
X-Received: by 2002:a05:6000:188d:: with SMTP id a13mr485438wri.461.1639705176234;
        Thu, 16 Dec 2021 17:39:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c4sm5843869wrr.37.2021.12.16.17.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 17:39:35 -0800 (PST)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/8] Makefile: move $(comma), $(empty) and $(space) to shared.mak
Date:   Fri, 17 Dec 2021 02:39:23 +0100
Message-Id: <patch-5.8-1749085b929-20211217T012902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
In-Reply-To: <cover-0.8-00000000000-20211217T012902Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20211217T012902Z-avarab@gmail.com>
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
index 50359603dbc..4dfb88ccb3f 100644
--- a/Makefile
+++ b/Makefile
@@ -1278,10 +1278,6 @@ endif
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
index 155ac84f867..b34fb948c0f 100644
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
2.34.1.1119.g7a3fc8778ee

