Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4CFECAAD3
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 09:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbiHaJTN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 05:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiHaJTH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 05:19:07 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C239C32EA
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 02:18:52 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id c7so10737270wrp.11
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 02:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=PWaShJJi/MSNZNohIiZzeSaaqMdeV3dG9XnzZc3hqbA=;
        b=k7g0xlvhXxE/g+CLv6EYvIiruq/USisNgIm7Cp2Ou5HMRa6dzGI7O77zc77ee3Xuda
         DpGBpW4GyEv1NZhQTP9ZPtBeru35nXDSUH1FQwkIcsK3H1iZTWurMc+Hy1sDQN249qjm
         p7Mfo0XPWg4+mFRLhh+TUE8gsUGw8Rvs3FrXxa5Lw5DKZXobzk0pKxwiuLKuQSB86+bW
         dlVCi1YfuiuPMtxzEeczjB4kanGJHc5+YL7BDbBvbryweww1inn7Ei43/fenqGQruzlm
         G1hcEsIemjdXNBVWn4p9WIwII6UG65qW7ocxL3sk2FTHcsN5H87ULZSz9J+aJqRNYDfk
         JmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=PWaShJJi/MSNZNohIiZzeSaaqMdeV3dG9XnzZc3hqbA=;
        b=MBdV3U1uJtFly/yhEQhtHkJXyg+kFALF1zo6SRgKFxR6mkDNrs/QMse7t1e0SF6EbA
         c9ydkZ+eMYHliZaU3IKCrjbQGocu8i0faE4KrTg7Ck6ckuqs/UBWXB5nvmELHVkGkl7W
         unSpzqzKciLJGJW4x3KKHbdiqXQjNJG9uCsWVkHxsdhWGk9CG/Oc4pKWHGvtaL55ZY2f
         FJMy8OKDz8LIJ5pg35ReiuQx//DVCg8h4EXfbGb4Rym1n8DqXhJdVu/n23F+j5JFuxkR
         hw+uNR8R6Kw8e21KVSKxsfIBGGJ5DZwOcmfHiEpXc0D42KoXIMNjGu6w+wk14UV9zxsk
         Q9sg==
X-Gm-Message-State: ACgBeo1I0yHxsq0BSdGYrE4m4dmqr5L4icFpY2/6WkpidNCL6IiA9U1G
        JrVGPrzowKl4vqKENmfRx/YRiPFijiYLfA==
X-Google-Smtp-Source: AA6agR5qStzUAiSXhhPSo9OGT93qb0wgMYu0ev4lg2UsZWmru3lzbfKWj8LSi2ALf2VpSJX8o+XiIg==
X-Received: by 2002:a5d:47c5:0:b0:226:e8d1:f2d6 with SMTP id o5-20020a5d47c5000000b00226e8d1f2d6mr2223831wrc.650.1661937529695;
        Wed, 31 Aug 2022 02:18:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600c198c00b003a2e92edeccsm1558740wmq.46.2022.08.31.02.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 02:18:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/2] Makefile: use $(OBJECTS) instead of $(C_OBJ)
Date:   Wed, 31 Aug 2022 11:18:44 +0200
Message-Id: <patch-v3-2.2-cb3bc8b5029-20220831T090744Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1406.g184357183a6
In-Reply-To: <cover-v3-0.2-00000000000-20220831T090744Z-avarab@gmail.com>
References: <patch-v2-1.1-e77fd23a824-20220321T170412Z-avarab@gmail.com> <cover-v3-0.2-00000000000-20220831T090744Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the preceding commit $(C_OBJ) added in c373991375a (Makefile: list
generated object files in OBJECTS, 2010-01-26) became synonymous with
$(OBJECTS). Let's avoid the indirection and use the $(OBJECTS)
variable directly instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 7feda7e79be..8956cace8eb 100644
--- a/Makefile
+++ b/Makefile
@@ -2590,9 +2590,7 @@ missing_compdb_dir =
 compdb_args =
 endif
 
-C_OBJ := $(OBJECTS)
-
-$(C_OBJ): %.o: %.c GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
+$(OBJECTS): %.o: %.c GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
 	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
 
 %.s: %.c GIT-CFLAGS FORCE
@@ -3084,7 +3082,7 @@ t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS) $(REFTABLE_TEST_LIB)
 check-sha1:: t/helper/test-tool$X
 	t/helper/test-sha1.sh
 
-SP_OBJ = $(patsubst %.o,%.sp,$(C_OBJ))
+SP_OBJ = $(patsubst %.o,%.sp,$(OBJECTS))
 
 $(SP_OBJ): %.sp: %.c %.o
 	$(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
-- 
2.37.3.1406.g184357183a6

