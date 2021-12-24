Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5EFC433EF
	for <git@archiver.kernel.org>; Fri, 24 Dec 2021 17:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353337AbhLXRiF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 12:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353335AbhLXRiB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 12:38:01 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BD0C061759
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 09:38:00 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id a203-20020a1c7fd4000000b003457874263aso7638923wmd.2
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 09:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rs72ms9IzDlEqY92zTfEpXM/0NrbRKkb5GkkOjrCI1U=;
        b=eWptDf9ZJ1zokS8TfnyNCYmEhllKMsh6gigi/z2SzdX1sp1M1Kz6gnd3xD/6nWffbw
         XpTzSubwWEnRKmIdzp0qjLc1zxvb9NuUqc5p5uYKLQVcI350/1aSbbBuiy+zaxfU8ngJ
         1GJ9f0apFd35CNCwKDAIzsHNKvZtpY7pHDiynFDG18qMzeSnFdT2VgNqXLRpFTjn63st
         axyaMA//Z4C+N2GFI4l5W3AwOEga4Q0unkh+42oSk65prbAYFVvWoHiiD97uzYnKjLCb
         bzev65sQur+pClj9AZxG64tp/7uc01Lm0qmCmUKIc8oNHNGdSKLrTUoEIBrgT2GkFHdL
         FZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rs72ms9IzDlEqY92zTfEpXM/0NrbRKkb5GkkOjrCI1U=;
        b=0uyKe7gD07UqIHzjwb5yNuO1lw3n1cxD3esjCr7E4YzIHH6Pb5piMZ/6amPNZNGWJ7
         cpTRAm4nvNYUz6Yd4fyJr6nolWm9hMzuDqQmcfX2nYnyrikr6Lx6oxv49XcMn7/1F32N
         djLnz27x+jzzMf8LXB/rq0roOgWpuizHrW4ISeE6dD5Zeypk/nH/tyeEA+HCnY1pMbe5
         /rTl8MTeAIvrjthcC5sdUGfUnALJG3DxsXCKSaZi3gKIcNC77ro0suiHs+YFXaTE9Jv4
         w0eL3F7A5UyIdxkXUiy5h1FtTwfJab3JS7i1QuV+74QFK3CQru8/NDIIUIpUbT2cJGqi
         6chg==
X-Gm-Message-State: AOAM533pz04uu64UT9AeZsOIKOhAkICgzvrekgtDVmoNk0ZIw0B8RAyr
        GrFzhb/vXAElcpwYaF2wCHQhTv/PxVPZlywx
X-Google-Smtp-Source: ABdhPJzRZk0UwDFc/4zGtOcAT6+f0i34h8RVfbFvQuLuL/v0o3WGcDDjprqi4GfrsV6hDBwu1BymZA==
X-Received: by 2002:a7b:c7d0:: with SMTP id z16mr5590525wmk.76.1640367478730;
        Fri, 24 Dec 2021 09:37:58 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j3sm8033518wro.22.2021.12.24.09.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 09:37:58 -0800 (PST)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/8] Makefile: move $(comma), $(empty) and $(space) to shared.mak
Date:   Fri, 24 Dec 2021 18:37:44 +0100
Message-Id: <patch-v2-5.8-f1f02c71dbc-20211224T173558Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1215.g6e154b84c77
In-Reply-To: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
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
index e30093b83d3..85f99e66b07 100644
--- a/Makefile
+++ b/Makefile
@@ -1279,10 +1279,6 @@ endif
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
2.34.1.1215.g6e154b84c77

