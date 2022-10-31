Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F14FFA3744
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 22:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiJaW2r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 18:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiJaW2l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 18:28:41 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768701038
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 15:28:40 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ud5so32990940ejc.4
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 15:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SE9K1apIxuPKquinciAjWSnjiKcu3E01uUAQ91GKJ4A=;
        b=kMgh32jFJ/u6dhCR0695VCLyhT1fHo9DZh7QvJlI7L4/sR+YVdyT6rWvKMrZqj2qJ6
         f1SK53YNMlE3X+8H1LtJS5SI838MNl08LxDJ8K2rpcc3qy4qURIu/fn/qd+FEyiJuCIX
         H5k6635dz45gQyVGr25uxgmVSWaqd/W39avHSsK32+vFVS5XY0mGhfmp8kSDchG+dMJO
         CZ/UrLMtrlpj5h0ncASaJyA4EnlIECn8AKOj3m3/vWLyVRQ2/F8qZjHfMHwbEUHMH/PJ
         hzLuVy8VXj0/Md58+qIX86Ph5jp6ktjGdGA/EdQV5C4bhsbCReZCT3huYCQTu4UJwf8q
         vKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SE9K1apIxuPKquinciAjWSnjiKcu3E01uUAQ91GKJ4A=;
        b=54BgrJ8KJFw5X3qxaaW8+KNJecfrXNTpa/MqNlNCRcNeuNvMK5VAfCsYXC2hDqObkF
         fb8ZvaTaYakEUPWymHiukolBqZv0+FcBlEqgfKwqbt8a2TuEIC+Y+cuV/1fXlZSvXNPk
         gEO64SHdnp0nZcwTCAdcc/uBl1Ig/QFOhJK2czP1aQ3RR9zqNWqPuxG+AWBtklLrv6DQ
         K2TsFeormL+7+v6h0B/ZvBS99HCu7TgtQGNvRaZu6NZ984IcRAxoA5Ir/qGx8ElaUGl3
         SgzrHGOUpy3OHSsxGFS66UbdFR5ER24tmIKDIfEzuLKT+1TzC2fdbRV/n34WsjwAfFod
         gjsQ==
X-Gm-Message-State: ACrzQf3g/A/hf+R9c3n0VIX2brd2MmX5sSnAfNNhWLBXqpEb+McCRGXh
        k4Mt6bSmyk5nqp798SnYLF7E58Z59c5REA==
X-Google-Smtp-Source: AMsMyM7azrMBWkka4wZQlEK+qKkhdozGdzUeVDIuljDE726m98i6zFEDkGuRhWsKZ21Xwi1L1Bl4Fg==
X-Received: by 2002:a17:907:980e:b0:78d:b6d8:f53c with SMTP id ji14-20020a170907980e00b0078db6d8f53cmr15400224ejc.70.1667255318711;
        Mon, 31 Oct 2022 15:28:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a14-20020a1709066d4e00b00781e7d364ebsm3503668ejt.144.2022.10.31.15.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 15:28:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/4] Makefile: factor sed-powered '#!/bin/sh' munging into a variable
Date:   Mon, 31 Oct 2022 23:28:06 +0100
Message-Id: <patch-v3-1.4-c9ce5b78a3a-20221031T222249Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v3-0.4-00000000000-20221031T222249Z-avarab@gmail.com>
References: <cover-v2-0.3-00000000000-20221026T143533Z-avarab@gmail.com> <cover-v3-0.4-00000000000-20221031T222249Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reduce the amount of magical copy/pasting in the Makefile by factoring
the munging of "#!/bin/sh" on the first line of a shellscript into a
variable we can re-use in the various rules that need to do so.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 4927379184c..679c24377f4 100644
--- a/Makefile
+++ b/Makefile
@@ -2347,8 +2347,12 @@ GIT-SCRIPT-DEFINES: FORCE
 		echo "$$FLAGS" >$@; \
             fi
 
+define cmd_munge_script_sed_shell_path_arg
+'1s|#!.*/sh|#!$(SHELL_PATH_SQ)|'
+endef
+
 define cmd_munge_script
-sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
+sed -e $(call cmd_munge_script_sed_shell_path_arg) \
     -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
     -e 's|@@DIFF@@|$(DIFF_SQ)|' \
     -e 's|@@LOCALEDIR@@|$(localedir_SQ)|g' \
@@ -2450,7 +2454,7 @@ git-instaweb: git-instaweb.sh GIT-SCRIPT-DEFINES
 else # NO_PERL
 $(SCRIPT_PERL_GEN) git-instaweb: % : unimplemented.sh
 	$(QUIET_GEN) \
-	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
+	sed -e $(call cmd_munge_script_sed_shell_path_arg) \
 	    -e 's|@@REASON@@|NO_PERL=$(NO_PERL)|g' \
 	    unimplemented.sh >$@+ && \
 	chmod +x $@+ && \
@@ -2471,7 +2475,7 @@ $(SCRIPT_PYTHON_GEN): % : %.py
 else # NO_PYTHON
 $(SCRIPT_PYTHON_GEN): % : unimplemented.sh
 	$(QUIET_GEN) \
-	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
+	sed -e $(call cmd_munge_script_sed_shell_path_arg) \
 	    -e 's|@@REASON@@|NO_PYTHON=$(NO_PYTHON)|g' \
 	    unimplemented.sh >$@+ && \
 	chmod +x $@+ && \
@@ -3065,7 +3069,7 @@ all:: $(TEST_PROGRAMS) $(test_bindir_programs)
 
 bin-wrappers/%: wrap-for-bin.sh
 	$(call mkdir_p_parent_template)
-	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
+	$(QUIET_GEN)sed -e $(call cmd_munge_script_sed_shell_path_arg) \
 	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
 	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%,$(@F))$(if $(filter-out $(BINDIR_PROGRAMS_NO_X),$(@F)),$(X),)|' < $< > $@ && \
 	chmod +x $@
-- 
2.38.0.1280.g8136eb6fab2

