Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FFBC433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 16:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbiCCQF2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 11:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiCCQF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 11:05:28 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B53197B47
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 08:04:42 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id r10so8574507wrp.3
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 08:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B5zXqhA9bTn/F6sYFAbG+nzimX/d7yNvejfWtMI5ZkM=;
        b=aHMXAxMtjzCIi3GYvUUrtdPeSYxRi7UH3Cgsa7fCXaAckcqvsBbOvc6/aSJ1aPVCQY
         lh7zVbQPYm6b720ajM7Ks1vOAXtXplzfClU8H/F/iXFOq9hinCasjKN2DOVIIPEfqGjs
         idutvssX+ZaBMiEu31eBg9W3VgLfBfNvxMf4YUknilDQIwVnM/q4YM1zdNWlY43ifiRT
         vcpMwbVcQQFUZOAGjXndK3maAqkZNzYUzdp9+IfE3108mlBNZt9liioTfVV/+ZQVpBIu
         LJduLu38ldcGhBONudM5JxsMkDfWawSxykJ4rNrN+Vuip6Vu5dVf6j25c7dvACugaERj
         7CMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B5zXqhA9bTn/F6sYFAbG+nzimX/d7yNvejfWtMI5ZkM=;
        b=OtPy9Hk0SlLnKyQ8I0oxk66ADmfTWvq/rWLBapJAMV5b09QkYTT9NKM5x0qtzF2438
         79dzR6EO7MlTV/H91ihieV5ldxav3IfOvQy/dhQT8QkHOSOx+n8jWC3GgzOC8G8qy+KZ
         rRCWWiZ/TNU9QRuoF3I9gg52fr9OjJdND7JQKYhWQy0AGIBSeTANpd65MOAw8lvQf5+t
         VXqAStKhsiSQeS6cSJVa7JykfHf2hoTnTcfDUq2g7aS/q8Cjym61fiaO4OndOrDZYe9s
         lPgA1Uqm3tFAAnscS4NBvCml1y1/pmMm3vx4YUWal/QbDMlxm71+lBSLj26oihzDuaQX
         XlaA==
X-Gm-Message-State: AOAM531itKEwDPwX2Xhynhw/+sTYQvT/rN71IMKjfzGMHUP17U5tw4+c
        lorSfK0x32wrs1UI+qeL+L1zvDqoSVg7XA==
X-Google-Smtp-Source: ABdhPJyElhK8Dcqfo9SrK/GlRssVHDe0F9EKmSSLYpAuC/DfO7zy2L6kj/Nz1aDzoa8emFdsvpiZ4w==
X-Received: by 2002:adf:b1da:0:b0:1f0:1205:89c1 with SMTP id r26-20020adfb1da000000b001f0120589c1mr9697246wra.27.1646323480420;
        Thu, 03 Mar 2022 08:04:40 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c4f4d00b00386744cb31bsm4040667wmq.35.2022.03.03.08.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 08:04:39 -0800 (PST)
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
Subject: [PATCH v5 1/8] scalar Makefile: use "The default target of..." pattern
Date:   Thu,  3 Mar 2022 17:04:12 +0100
Message-Id: <patch-v5-1.8-7547bf3e481-20220303T160155Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1230.ga6e6579e98c
In-Reply-To: <cover-v5-0.8-00000000000-20220303T160155Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com> <cover-v5-0.8-00000000000-20220303T160155Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the "contrib/scalar/Makefile" be stylistically consistent with
the top-level "Makefile" in first declaring "all" to be the default
rule, followed by including other Makefile snippets.

This adjusts code added in 0a43fb22026 (scalar: create a rudimentary
executable, 2021-12-03), it further ensures that when we add another
"include" file in a subsequent commit that the included file won't be
the one to define our default target.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/scalar/Makefile | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/contrib/scalar/Makefile b/contrib/scalar/Makefile
index 231b1ee1796..1e9b969f3df 100644
--- a/contrib/scalar/Makefile
+++ b/contrib/scalar/Makefile
@@ -1,3 +1,10 @@
+# The default target of this Makefile is...
+all::
+
+include ../../config.mak.uname
+-include ../../config.mak.autogen
+-include ../../config.mak
+
 QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
 QUIET_SUBDIR1  =
 
@@ -12,12 +19,6 @@ else
 endif
 endif
 
-all:
-
-include ../../config.mak.uname
--include ../../config.mak.autogen
--include ../../config.mak
-
 TARGETS = scalar$(X) scalar.o
 GITLIBS = ../../common-main.o ../../libgit.a ../../xdiff/lib.a
 
-- 
2.35.1.1230.ga6e6579e98c

