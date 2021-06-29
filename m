Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7417C11F68
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 11:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C5F161DC7
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 11:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbhF2LPx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 07:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbhF2LPw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 07:15:52 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD37CC061766
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 04:13:23 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u11so25282836wrw.11
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 04:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f+pIA2t+AcuzQpGiwWUT7GAGhrk4eePpyfiPaHS9bJw=;
        b=BL7T0aSzDRTX1pcuR0/dfK/xvEfygM811KdKA3R2HfNcsRxhxlOBvfXIh0E/XwGcwJ
         3BrTZtYYHzbtRikaLZh8z4FYbt/PyPsWkAMfo8X21KplNRyPTlDq4Eav+GYwwhk5Tpyd
         u7pfgTJYdTLkvOlQ6pzcTxNDoiO//IJzLuc2wHYM8PRQIgKMakN3W6o13qhcCakdmKIL
         r9POS+5zU587DV0oGf6+D7WNbUzTqb/rWrpUMr2c83FrbvbrTphRXDlluqCw3hU4vRjM
         b5KeGcGBbc2xyMs174V6AJQR4zjpHML1V7qwa63NoR1L0JJAMDaZdd2rUApDJ5c7+upt
         NOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f+pIA2t+AcuzQpGiwWUT7GAGhrk4eePpyfiPaHS9bJw=;
        b=WHKXAEOElAy6ldUQ3O9dPI+cfMw1KHoH+ImSAexyDNM2+yelJzh9tQvbSj0UfVecys
         7+wKMGY4aWd65+RNaVNgQuvxFa+VrBN+ENYw3mqCxWDtXu+9pzfOLXQpa5JBkPM8i6qU
         uUFPdKl+r/QlPpAmUza0cjoRkhQB7URQhJ0vY/1U5MEfRQwOTz8Ip/Lg7YkQpq+lVBi9
         Zcl2w/ryyz1XtmHks7FvRss6/iFSMNArJUrIxbe2tf31ZcIllf/y8KCLsfJJJc/wRUTN
         Ze+S4RW0YT6i8c4fBgsvVVb3Nkb1DFFL8NSiZT4jpVk+gUuKv/neCJkjMp+DXIVeLIOA
         IJtA==
X-Gm-Message-State: AOAM530KBPIFPMIO1PRcafqB0qmAT+GcPS9NM3cIAw716oTYuEuL4WH+
        rn3rk+O9brbhNvD62bo0sE7Q/kqLuk3RhQ==
X-Google-Smtp-Source: ABdhPJx1uWEJNtyvFt1J4L1FGRCSA0nSQ0xKkRmKlzNJJfnPhwYSizlbAFrDp+kUMC5gV9uQBgG3Uw==
X-Received: by 2002:a05:6000:1361:: with SMTP id q1mr10032686wrz.179.1624965202151;
        Tue, 29 Jun 2021 04:13:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r1sm2499370wmn.10.2021.06.29.04.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 04:13:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/5] Makefile: fix "cscope" target to refer to cscope.out
Date:   Tue, 29 Jun 2021 13:12:57 +0200
Message-Id: <patch-3.5-35c8b83904-20210629T110837Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.613.g20d5ce26552
In-Reply-To: <cover-0.5-0000000000-20210629T110837Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210622T141844Z-avarab@gmail.com> <cover-0.5-0000000000-20210629T110837Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The cscope target added in a2a9150bf06 (makefile: Add a cscope target,
2007-10-06) has for some reason been referring to cscope* instead of
cscope.out.

Let's generate the cscope.out file directly so we don't need to
speculate. The "-fcscope.out" (note, no whitespace) argument is
enabled by default on my system's cscope 15.9, but let's provide it
explicitly for good measure.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .gitignore |  2 +-
 Makefile   | 10 ++++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/.gitignore b/.gitignore
index 311841f9be..d74029c1ca 100644
--- a/.gitignore
+++ b/.gitignore
@@ -217,7 +217,7 @@
 /.vscode/
 /tags
 /TAGS
-/cscope*
+/cscope.out
 /compile_commands.json
 *.hcc
 *.obj
diff --git a/Makefile b/Makefile
index faa8900097..2e3b257164 100644
--- a/Makefile
+++ b/Makefile
@@ -2737,10 +2737,12 @@ tags: FORCE
 	$(FIND_SOURCE_FILES) | xargs ctags -a -o tags+ && \
 	mv tags+ tags
 
+cscope.out:
+	$(QUIET_GEN)$(RM) cscope.out && \
+	$(FIND_SOURCE_FILES) | xargs cscope -f$@ -b
+
 .PHONY: cscope
-cscope:
-	$(QUIET_GEN)$(RM) cscope* && \
-	$(FIND_SOURCE_FILES) | xargs cscope -b
+cscope: cscope.out
 
 ### Detect prefix changes
 TRACK_PREFIX = $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix_SQ):\
@@ -3211,7 +3213,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(HCC)
 	$(RM) -r bin-wrappers $(dep_dirs) $(compdb_dir) compile_commands.json
 	$(RM) -r po/build/
-	$(RM) *.pyc *.pyo */*.pyc */*.pyo $(GENERATED_H) $(ETAGS_TARGET) tags cscope*
+	$(RM) *.pyc *.pyo */*.pyc */*.pyo $(GENERATED_H) $(ETAGS_TARGET) tags cscope.out
 	$(RM) -r .dist-tmp-dir .doc-tmp-dir
 	$(RM) $(GIT_TARNAME).tar.gz
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
-- 
2.32.0.613.g20d5ce26552

