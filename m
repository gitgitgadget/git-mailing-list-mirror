Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62D8C43219
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC22461BAA
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbhKQKYC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 05:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236267AbhKQKXg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 05:23:36 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254E5C061225
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:38 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso4328475wml.1
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jb8je/FoaWUCxv+AiTlIVfJkvF668xYYfN68CxBmxJw=;
        b=allnHQjaHVhiYGnqxuba/mKeBGIQGCdXf0AxBdstFB+ValHq4EVhcsPqJpofos+0U7
         mj0Rc+FBfCZzdGgjMW4qt+NfAZzMYakXy418r6JgqVIeA1xsI9AN+uHtBTPzpuZlk3jG
         oGqgXPMyPtJioRL6crV1MPZUTZPk7kBHuJf5vOmXIr8e9u/A86z/cCF4zcdutXaNXooV
         9o7nffWX5Tjt6zG/PKQ5tSiD5Up/xoyW/0G3/9JFhflAHP2nJCuCpVXxKTn0mG4+IU1g
         3Bc9I/BvR3vOsck4JhedT6C1Q5zdVporesugnNpqjJrXNqNI49fABXRWGwHDkgdjgCio
         TGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jb8je/FoaWUCxv+AiTlIVfJkvF668xYYfN68CxBmxJw=;
        b=oMruIGuURbXphoLtk3CllwEAZzt3cbnouHrTsY8bZDg60U9epFgQ4cZhVxnfjdFKiK
         6G1m1H7FRZlFsV5xXhPWDkqw1ikP3lh+vRIxBbLWiE8SYVoUGvwENYjdr+q4JZq+H85T
         XyzVPgb7hzsXzKFvzqKqGqnKseTIRUiiytyWNqchPRw/BTcQ8617JH8txYOVLj798bu8
         RPSRebYpikYquNu7HrRqYLggJA7GCwjohR9gJgkYOEL9ShDiGQSJXXv+1LEN45jZ/kOI
         53mBGwPx8uANURkAEBIelpFpJRoevR/t4dVAvnVs3qgrfWqlFKgFtqKdF7JlcR6KVY39
         QGEw==
X-Gm-Message-State: AOAM532rUGXB4xlo1F1kHQb8EvV9xrhadb760brJXjn6ucaxxnEZRJEO
        5MUsJG3j2jnNRGFZ2EPiqR+yZCQsa1fmeA==
X-Google-Smtp-Source: ABdhPJxQlHQLkLAZClsXibHdedOEIEmyKT2kM6/BsrrQkBsjRSjsI7RMwo6x+jsmr9Ye3t1UmCIjVw==
X-Received: by 2002:a1c:4681:: with SMTP id t123mr77350263wma.83.1637144436511;
        Wed, 17 Nov 2021 02:20:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n32sm6456256wms.1.2021.11.17.02.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 02:20:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 13/23] Makefile: move $(comma), $(empty) and $(space) to shared.mak
Date:   Wed, 17 Nov 2021 11:20:12 +0100
Message-Id: <patch-v4-13.23-f378a7dc35e-20211117T101807Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.796.g2c87ed6146a
In-Reply-To: <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
References: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com> <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
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
2.34.0.796.g2c87ed6146a

