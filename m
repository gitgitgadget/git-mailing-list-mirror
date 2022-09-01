Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E55ECAAD3
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 13:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbiIANUI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 09:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbiIANTo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 09:19:44 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C9EB7C
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 06:17:33 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id s23so9000255wmj.4
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 06:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=I56KPWtKzp1dN8xAG7MjPAAVK47iE2jJrrCOB+y84Zk=;
        b=QGgj+ILWFjvlk3+OW11iFo/T+iSJTfj9ydHCb0oqXxYZLbU9SD7KJHWlBsSHpUYGlQ
         e63+P/113r44oJ3mlPaCO14JV3+Goc8LWWDYzzaX9qAa9rnF2yde2ltQi5prl1CjiErA
         iqTp/OeaIYX2q9REzkix+ebj3EwifoWprtr0gKvGCF9crcn+ihCBbfmJp6y3M4ljl0EX
         dp5fKRTc0J4zsrNBSQ+lmoi5dzuBy/72NaI70GDNWC6kM6OmEszId2XY0CL/Dr3JvpRd
         Uu8L1aO36gacqqvx/OZOda3nECK4cQbZPbEozwpZu37MSp4g2rJ0dTbd40DCRdDOSpds
         dJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=I56KPWtKzp1dN8xAG7MjPAAVK47iE2jJrrCOB+y84Zk=;
        b=PcyXxpEMnI1Wz1O/qGjGNEH7vx7oPYM1cJOrxVpOsabgaQbY99EICd4UqmyRsLij5+
         ft1XnEjNXzYTZqaAu7HrVGmIO2Aa9D5sagaipajhXmf9rp8MWr/kcsp5zBm50lwx6Uq5
         nfKU/s7EzVjnfw76xTlWjEiI0VSQLFEDLCsaMxqbpOc3YGiIqxKyYkutmZUxLnHf3/Ia
         zJb+8l45CUs79VdjBGec1v/BHjjhKyJj904NKi3GA9kL/0BILOjIMOmILMT2CTtZsGar
         swrdoo6MlwsUwWJytbjIgO5ggHUIzrUGzjbOsxXO06y/Z2oby/+IBBGQdtXjtyDD/UA5
         rqdw==
X-Gm-Message-State: ACgBeo2xopDBQXQVMeXyn0nckvaquibFprGqxicAhkLr7eZzPUOl82uM
        g4Kn6LPvuIluVzp7F3G5q/MeXT4xtu3LWQ==
X-Google-Smtp-Source: AA6agR4pSx95c491uhLUUtsWV7cbOk3xoeqmN7qJYaTHHj/msXVGC8qxQxxUw6LTercZUd25Y+iXhw==
X-Received: by 2002:a05:600c:4e8c:b0:3a6:11e:cc08 with SMTP id f12-20020a05600c4e8c00b003a6011ecc08mr5195140wmq.198.1662038251749;
        Thu, 01 Sep 2022 06:17:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c18-20020adffb52000000b00225239d9265sm14816089wrs.74.2022.09.01.06.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 06:17:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/5] Makefile: factor sed-powered '#!/bin/sh' munging into a variable
Date:   Thu,  1 Sep 2022 15:17:24 +0200
Message-Id: <patch-1.5-df150656e72-20220901T130817Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1426.g360dd7cf8ca
In-Reply-To: <cover-0.5-00000000000-20220901T130817Z-avarab@gmail.com>
References: <sso99so6-n28s-rq86-8q20-4456r3pn869r@tzk.qr> <cover-0.5-00000000000-20220901T130817Z-avarab@gmail.com>
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
index eac30126e29..b2304aa93a3 100644
--- a/Makefile
+++ b/Makefile
@@ -2338,8 +2338,12 @@ GIT-SCRIPT-DEFINES: FORCE
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
@@ -2441,7 +2445,7 @@ git-instaweb: git-instaweb.sh GIT-SCRIPT-DEFINES
 else # NO_PERL
 $(SCRIPT_PERL_GEN) git-instaweb: % : unimplemented.sh
 	$(QUIET_GEN) \
-	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
+	sed -e $(call cmd_munge_script_sed_shell_path_arg) \
 	    -e 's|@@REASON@@|NO_PERL=$(NO_PERL)|g' \
 	    unimplemented.sh >$@+ && \
 	chmod +x $@+ && \
@@ -2462,7 +2466,7 @@ $(SCRIPT_PYTHON_GEN): % : %.py
 else # NO_PYTHON
 $(SCRIPT_PYTHON_GEN): % : unimplemented.sh
 	$(QUIET_GEN) \
-	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
+	sed -e $(call cmd_munge_script_sed_shell_path_arg) \
 	    -e 's|@@REASON@@|NO_PYTHON=$(NO_PYTHON)|g' \
 	    unimplemented.sh >$@+ && \
 	chmod +x $@+ && \
@@ -3060,7 +3064,7 @@ all:: $(TEST_PROGRAMS) $(test_bindir_programs)
 
 bin-wrappers/%: wrap-for-bin.sh
 	$(call mkdir_p_parent_template)
-	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
+	$(QUIET_GEN)sed -e $(call cmd_munge_script_sed_shell_path_arg) \
 	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
 	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%$(X),$(@F))$(patsubst git%,$(X),$(filter $(@F),$(BINDIR_PROGRAMS_NEED_X)))|' < $< > $@ && \
 	chmod +x $@
-- 
2.37.3.1426.g360dd7cf8ca

