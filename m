Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B8BC4332F
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 09:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiJUJpI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 05:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiJUJox (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 05:44:53 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B31F53D3B
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:44:50 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id t4so1797314wmj.5
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7rTc9afT8kKVrl1GEBHFdGlVFf9240J6lL2o5/MyKE=;
        b=dy+1dB9SsVYkOOy7Qpv83qXCf3dc5599rEArqf5UDU8QuavKyPChWuc/SWy3xF0YSr
         0W2XMOIGhWr3hZYU6dL/+jB9Cr3SF4ArCL79VPG0gd5cG+KNSxKwTn0uYPzbM1CAC23w
         1aHhMN31sKpm3Ayb/qVvI2TOwab7zDLW0u4hFQ6w2PSVDR+zVQvZ8pXk1A+XQfHLN35D
         FLVyld0TNx/T0Jarr77gNU784VlDEhBeUwDYuazt7RyXP6x86P0lmB3dyz7Znyf1Fo+T
         mZeSTcjTW8byRV41TB2JGKc9uBHhmDV9ITWDibebyixBL45b3MG35RYGgYl2NV/rdR5p
         nQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7rTc9afT8kKVrl1GEBHFdGlVFf9240J6lL2o5/MyKE=;
        b=cyQKahG9wI0vlYZNvK/kCScFFkPfZ4e3tIK+vXYGtfGjTQ4CUX1Mh8An0dQ1vxtd1H
         hhmuijFaVI6jNoxuuZ/gwkeih3dIZoXBdJjUU8Olb4HIYraN4BRkh8CnCKbv1beB8QKz
         82UKWpH6LReD9PiOL93bwnio2aQsI1AANCyW603nxR/nAz0QmkvyuqnzAsHLgMPjJpDq
         ZcgP7y15FEMacLuz5Zn9dsV31j+jZEv198E//lmBdiKJMK4Wme0ufjDShTmZiUTgX/v3
         bsitC/jjUSl/FyLelEuylhSf8QsbmL3vBDP0ek62r1Eo6km0oabRBa7m6W+wMx8E91XR
         0paw==
X-Gm-Message-State: ACrzQf10o3GGTEhLtdWUfpfbKYpe+fDvOqwNraz8+qNXRwCiNlIKtv7J
        ZkIXRZjmRJOdCvU23BrpH4Z5u9LqNkHL1g==
X-Google-Smtp-Source: AMsMyM6Aedu/BpVjtL8UBxz4WJ8TUvCiOFSIinFCVQmE009/kNMl9SzFyjoUJT6DnENez4zBmy9zgQ==
X-Received: by 2002:a05:600c:5122:b0:3c6:fcce:e4e2 with SMTP id o34-20020a05600c512200b003c6fccee4e2mr13247703wms.65.1666345488979;
        Fri, 21 Oct 2022 02:44:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u6-20020adfeb46000000b002258235bda3sm18277768wrn.61.2022.10.21.02.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 02:44:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/9] test-lib.sh: support a "GIT_TEST_BUILD_DIR"
Date:   Fri, 21 Oct 2022 11:44:18 +0200
Message-Id: <patch-5.9-6199a913c0a-20221021T091013Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1205.gcea0601d673
In-Reply-To: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compliment the existing GIT_TEST_INSTALLED variable added in [1] with
one that allows for testing a git built in a directory that's not
"../".

Instead of "test this installed git" ("GIT_TEST_INSTALLED"), this new
"GIT_TEST_BUILD_DIR" is a "test this built directory over
there". E.g. this will pass all tests:

	git clone --depth=1 https://github.com/git/git.git git1
	cp -R git1 git2
	make -C git1
	[apply this change to git2]
	(cd git2 && GIT_TEST_BUILD_DIR="$PWD/../git1" make -C t prove)

1. 6720721e152 (test-lib.sh: Allow running the test suite against
   installed git, 2009-03-16)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README      | 3 +++
 t/test-lib.sh | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/t/README b/t/README
index 979b2d4833d..fc0daef2e41 100644
--- a/t/README
+++ b/t/README
@@ -231,6 +231,9 @@ override the location of the dashed-form subcommands (what
 GIT_EXEC_PATH would be used for during normal operation).
 GIT_TEST_EXEC_PATH defaults to `$GIT_TEST_INSTALLED/git --exec-path`.
 
+Similar to GIT_TEST_INSTALLED, GIT_TEST_BUILD_DIR can be pointed to
+another git.git checkout's build directory, to test its built binaries
+against the tests in this checkout.
 
 Skipping Tests
 --------------
diff --git a/t/test-lib.sh b/t/test-lib.sh
index d2e5dee6c89..41b1ddc96ff 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -47,6 +47,10 @@ fi
 # its build directory.
 GIT_SOURCE_DIR="${TEST_DIRECTORY%/t}"
 GIT_BUILD_DIR="$GIT_SOURCE_DIR"
+if test -n "$GIT_TEST_BUILD_DIR"
+then
+	GIT_BUILD_DIR="$GIT_TEST_BUILD_DIR"
+fi
 
 if test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
 then
-- 
2.38.0.1205.gcea0601d673

