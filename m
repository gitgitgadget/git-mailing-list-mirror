Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF68C38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 14:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbiJZOm7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 10:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbiJZOmo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 10:42:44 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D81FF8F4
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:42:42 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j15so16198728wrq.3
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aVpwlWcyMR68gPLacnzzKILaBVUZKmEWikwJZsA0Eg=;
        b=lZuGup/6925jPR4F/8GE2M4+6D0ne/bp7ILOU6vB/jUUMLK9BB3l4iVEXI3b35phwf
         93umBKbln+/WyB3us1fvROxXWch3s7y7Jm5crJTSWWxEQO7vjCWwpXypECBpOZlI/uAT
         aoCbVdNGWEWE7H9pP67P7GDsWQoiV3mJtuDbeQUR9+W/28H8v58cjOyB6FII/mvK4KrX
         jKvIfbIjMDLP+ju6iGNVw1ra8zHxXPzX+kGqj4wRrUZiaiXphOIgZ7ALKUpythod7WiF
         0R9dteHuiP+jQEoz9f0kHSh8PAWJ3C59vUqAKK3PrXNDwD7Abw2HPJXPNpivvlDbID4j
         h97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8aVpwlWcyMR68gPLacnzzKILaBVUZKmEWikwJZsA0Eg=;
        b=R8qRZLL4aM5+DnXwnM3dmWA9uu53HXwgBeprCQgHD7w90SIjPfst0xG1ni7CmVxNZy
         f4v1fRAuwsFiEoj2alrUQITW43qkXokYA+JtECDFrex2wxH/lDzypfJaD1mDc7kRmyei
         Xka7wizwPfRUe68RuccL3QUnbrhptcrnXpmwCZfHeIJiS/g72LtaOzQzc2wHOsj39jNc
         OnphXSJjbu7kHbqtSuo4XuBPpCXepxVPiqNr6MwVvCrFCrlEJrSIJWUEvJNxX6BkTNiY
         pSzsv6L2c4fJwDpeh4po6Q2Ul6QCUAE0sKW0YrdOFNe2c+0bzp/3cGQdDSNp9qDRn/UE
         A9Ow==
X-Gm-Message-State: ACrzQf0NdgAhImy+XcYQKOFOgNo1F/aNE8ph6MR2/Tl9eP+Q6YqC1y+K
        Lo1pT/C2TBgmHfu7x900/fsvIsaPgvgOuQ==
X-Google-Smtp-Source: AMsMyM6sup8d5xbZdsWMlTS4F8ekX/TpUkbzocnqmG9Pd3l13mZZL4GN58az1sUOEOm9qix1Tw/IFQ==
X-Received: by 2002:a5d:6485:0:b0:236:4ed2:409c with SMTP id o5-20020a5d6485000000b002364ed2409cmr20452691wri.110.1666795360858;
        Wed, 26 Oct 2022 07:42:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c304500b003a84375d0d1sm1934367wmh.44.2022.10.26.07.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 07:42:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/3] Makefile: factor sed-powered '#!/bin/sh' munging into a variable
Date:   Wed, 26 Oct 2022 16:42:35 +0200
Message-Id: <patch-v2-1.3-fc6c5a6a8df-20221026T143534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1251.g3eefdfb5e7a
In-Reply-To: <cover-v2-0.3-00000000000-20221026T143533Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220901T130817Z-avarab@gmail.com> <cover-v2-0.3-00000000000-20221026T143533Z-avarab@gmail.com>
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
index 85f03c6aed1..45b22d33513 100644
--- a/Makefile
+++ b/Makefile
@@ -2344,8 +2344,12 @@ GIT-SCRIPT-DEFINES: FORCE
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
@@ -2447,7 +2451,7 @@ git-instaweb: git-instaweb.sh GIT-SCRIPT-DEFINES
 else # NO_PERL
 $(SCRIPT_PERL_GEN) git-instaweb: % : unimplemented.sh
 	$(QUIET_GEN) \
-	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
+	sed -e $(call cmd_munge_script_sed_shell_path_arg) \
 	    -e 's|@@REASON@@|NO_PERL=$(NO_PERL)|g' \
 	    unimplemented.sh >$@+ && \
 	chmod +x $@+ && \
@@ -2468,7 +2472,7 @@ $(SCRIPT_PYTHON_GEN): % : %.py
 else # NO_PYTHON
 $(SCRIPT_PYTHON_GEN): % : unimplemented.sh
 	$(QUIET_GEN) \
-	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
+	sed -e $(call cmd_munge_script_sed_shell_path_arg) \
 	    -e 's|@@REASON@@|NO_PYTHON=$(NO_PYTHON)|g' \
 	    unimplemented.sh >$@+ && \
 	chmod +x $@+ && \
@@ -3061,7 +3065,7 @@ all:: $(TEST_PROGRAMS) $(test_bindir_programs)
 
 bin-wrappers/%: wrap-for-bin.sh
 	$(call mkdir_p_parent_template)
-	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
+	$(QUIET_GEN)sed -e $(call cmd_munge_script_sed_shell_path_arg) \
 	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
 	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%,$(@F))$(if $(filter-out $(BINDIR_PROGRAMS_NO_X),$(@F)),$(X),)|' < $< > $@ && \
 	chmod +x $@
-- 
2.38.0.1251.g3eefdfb5e7a

