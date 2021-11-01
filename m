Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD11BC433FE
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 870F96113D
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbhKATVr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbhKATVp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 15:21:45 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F78CC061764
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 12:19:11 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d3so29546783wrh.8
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 12:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hiTMTd7aKya/QZDawCwA5bsz1MQKNdjnAQJmzww427Q=;
        b=WHpvaEbJYYdfuFxtcwyfntGo0Qjo5i1o6PWCY0/zDCUUWUu42CxyCDIneThkwt50fG
         44+IjeEo2yjONs9vJupADueOz+uixW4N3g71R4FVdHhsLwD62Z+AxmO3ErNbXzkKKy/o
         8rHYkjdlwDZqQzg1U6txcqb37GlhnGsC2IvLVIp1BFcXItSMitUkxKhaiQPGPkPYVCjf
         jkOIQ9sQFBVVNySmYk+LJQkI7mLhFjiKKwCRJ5z5L8migCEgCMZgMGfZRkQSgUGiIuwF
         xcIGVqfm6NrrY+0Au+wp3P9gXP/8Daa+1ScZ29iuNrr6ffu19ghNFzzQU/B953o9asdn
         B//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hiTMTd7aKya/QZDawCwA5bsz1MQKNdjnAQJmzww427Q=;
        b=yyfYiXHazfgs5Yfv1Js4axbnKhTjKEYHfS8XI0tZ94gUnjBr+dzMA5TGsftJ5YhL+n
         IjeLHBEkoV98qQLgg/M0lOeJcKlYbllPZuCpV/+0azQF4sKPHwir09Kd3BXMgcMYmpl0
         qsrY3y5Yh2nI9N0A+SoBNNNKx01LGjvCIlTm8blhAKvD1jrNo5VbKV2oJPJbM6WLBuN+
         +5/wWE08Eqol7ye1+2dFYRQUSedO8+R2Cz+e+9A0WQRlVSwCDM1NWUaUQbPXo7+9gUn9
         vnyaSxhV/VFGXBDBzoq4jg343cNICo1chPA+w9EJvwqD3XGGi7R5TnFPdpUTYq+f4GHx
         K5ug==
X-Gm-Message-State: AOAM533u/BnFfOorfdSqe2A4MBFt9WGyhrRzYnc/FRFz+erJGHMWD2eo
        1CB/YIyV7/t+cH7IPGibAffjpbPzWp92uIki
X-Google-Smtp-Source: ABdhPJy+5avkBaLMa7Yl9A83Diy+6KigREbqKjKYrIlVUSgZvKWocGB3ACOh8BtQc4twHPboOT2IxA==
X-Received: by 2002:adf:f489:: with SMTP id l9mr11940067wro.268.1635794349547;
        Mon, 01 Nov 2021 12:19:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v185sm339437wme.35.2021.11.01.12.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 12:19:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Paul Smith <paul@mad-scientist.net>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/3] Makefile: rename $(SCRIPT_LIB) to $(SCRIPT_LIB_GEN)
Date:   Mon,  1 Nov 2021 20:19:02 +0100
Message-Id: <patch-v2-1.3-0b23b8395ec-20211101T191231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v2-0.3-00000000000-20211101T191231Z-avarab@gmail.com>
References: <patch-1.1-bbacbed5c95-20211030T223011Z-avarab@gmail.com> <cover-v2-0.3-00000000000-20211101T191231Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the $(SCRIPT_LIB) variable like the rest of its siblings, where
we have an extension-less $(*_GEN) variable, but the main one has the
full file name. This will be used in subsequent commits to emit the
filenames in $(SCRIPT_LIB), $(SCRIPT_PERL) etc.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 12be39ac497..100658dfa43 100644
--- a/Makefile
+++ b/Makefile
@@ -608,9 +608,9 @@ SCRIPT_SH += git-request-pull.sh
 SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
 
-SCRIPT_LIB += git-mergetool--lib
-SCRIPT_LIB += git-sh-i18n
-SCRIPT_LIB += git-sh-setup
+SCRIPT_LIB += git-mergetool--lib.sh
+SCRIPT_LIB += git-sh-i18n.sh
+SCRIPT_LIB += git-sh-setup.sh
 
 SCRIPT_PERL += git-add--interactive.perl
 SCRIPT_PERL += git-archimport.perl
@@ -624,6 +624,7 @@ SCRIPT_PYTHON += git-p4.py
 
 # Generated files for scripts
 SCRIPT_SH_GEN = $(patsubst %.sh,%,$(SCRIPT_SH))
+SCRIPT_LIB_GEN = $(patsubst %.sh,%,$(SCRIPT_LIB))
 SCRIPT_PERL_GEN = $(patsubst %.perl,%,$(SCRIPT_PERL))
 SCRIPT_PYTHON_GEN = $(patsubst %.py,%,$(SCRIPT_PYTHON))
 
@@ -2141,7 +2142,7 @@ profile-fast: profile-clean
 	$(MAKE) PROFILE=USE all
 
 
-all:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS
+all:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB_GEN) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS
 ifneq (,$X)
 	$(QUIET_BUILT_IN)$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_COMMANDS_TO_INSTALL) git$X)), test -d '$p' -o '$p' -ef '$p$X' || $(RM) '$p';)
 endif
@@ -2284,7 +2285,7 @@ $(SCRIPT_SH_GEN) : % : %.sh GIT-SCRIPT-DEFINES
 	chmod +x $@+ && \
 	mv $@+ $@
 
-$(SCRIPT_LIB) : % : %.sh GIT-SCRIPT-DEFINES
+$(SCRIPT_LIB_GEN) : % : %.sh GIT-SCRIPT-DEFINES
 	$(QUIET_GEN)$(cmd_munge_script) && \
 	mv $@+ $@
 
@@ -3013,7 +3014,7 @@ install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) $(INSTALL_STRIP) $(PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) $(SCRIPTS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) -m 644 $(SCRIPT_LIB) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) -m 644 $(SCRIPT_LIB_GEN) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) $(INSTALL_STRIP) $(install_bindir_xprograms) '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) $(BINDIR_PROGRAMS_NO_X) '$(DESTDIR_SQ)$(bindir_SQ)'
 
@@ -3174,7 +3175,7 @@ ifneq ($(INCLUDE_DLLS_IN_ARTIFACTS),)
 OTHER_PROGRAMS += $(shell echo *.dll t/helper/*.dll)
 endif
 
-artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) \
+artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB_GEN) $(OTHER_PROGRAMS) \
 		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(test_bindir_programs) \
 		$(MOFILES)
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) \
@@ -3232,7 +3233,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) *.res
 	$(RM) $(OBJECTS)
 	$(RM) $(LIB_FILE) $(XDIFF_LIB)
-	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
+	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB_GEN) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) $(FUZZ_PROGRAMS)
 	$(RM) $(SP_OBJ)
-- 
2.33.1.1570.g069344fdd45

