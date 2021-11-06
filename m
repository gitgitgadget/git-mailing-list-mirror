Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D7FC433FE
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 967D36103B
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbhKFVGU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235117AbhKFVGI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:06:08 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97AFC061714
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:03:26 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b12so19511357wrh.4
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=91ugjDCIm9yG7fdEB9X4OX54v9eYlt0Gqq7Mfh+2T8g=;
        b=pHcODpyojYypOeo4ZqXgy9Dxfp404JOzhP83Unx28DCVH0qAPsBUkpjexqrbnLPoOH
         +civQsQUtdxsaEtoeeY03I2KNBnk8CSFslHulDNLXdmV2NwNyNJdrj8WkEPTJXqBQG1X
         jDGnp3rci3HJoNAMiNoT5QnyImCJUgV3U1iKR5dpZxCpa0MHoKRRe0RwarTm0CCVrCKX
         pLtZqnHAT2ZLWHs8m2J2aQC19sJ6k09hVExqxnf3xrtMWxK+7CBxSrXw1P8f+ya+H50t
         lzC8Qt5TJpX9ESN2EYZpplHhSDWolitvfKVpJL3OY4T+Yj816XBDEBE/FEQEqAyINurW
         sO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=91ugjDCIm9yG7fdEB9X4OX54v9eYlt0Gqq7Mfh+2T8g=;
        b=38IoRJdLdfEmq4cR6pkgfcnLTaV3NV0JomhpLpXIFwDiCghL/DsY5SeMbZMn44FH8A
         Dfjp9sQrJqZMJJhLBzZl1AAaQAEJKyYqllb+YJyxvMpa5vCWZePP+LKM/g1gd4LFD9eI
         iN9AZm0nj3BxKV5zuyaoTvDun4zb1njq/GWwbYjZpjdp6JA/wfxN2Qf8Yg7X09m41lQq
         vekdFM3AB/rTAkihlxm75edwXUHQpQ5k5srBnHvFRHSwzAcZk/HTrZeWYo2jFxm8/9/m
         oGVGvmBdbxpN8wjXuAFi02Ilau15PheTaooDLZX+k9GZvhivbpMVUwGvEEn6kqTZ25JL
         54KQ==
X-Gm-Message-State: AOAM531sXuL4h6UCWhY/cFzOAV2QlRLvoJzXEYQHjwUc0VRX4m2WrH8y
        tkKP/cblZiMlU0rO+KW4ijOEqLEQFQjJdw==
X-Google-Smtp-Source: ABdhPJx2zXe0RIRxxaPL8wcBRJHaabkvts2W7k0zJ80pG0YGZgAgX5Bi42Ug12aB5qKQ5GDuUaAyPA==
X-Received: by 2002:adf:eac8:: with SMTP id o8mr56524395wrn.337.1636232605073;
        Sat, 06 Nov 2021 14:03:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u16sm14108433wmc.21.2021.11.06.14.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:03:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/16] Makefile: don't have Perl over-depend on GIT-BUILD-OPTIONS
Date:   Sat,  6 Nov 2021 22:03:07 +0100
Message-Id: <patch-06.16-03290125c45-20211106T205717Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the dependency on "GIT-BUILD-OPTIONS" used by
e.g. "git-send-email" to be on "GIT-PERL-DEFINES instead.

The reason for depending on "GIT-BUILD-OPTIONS" was to trigger a
re-build if NO_PERL=Y was defined, we can instead add that variable to
"PERL_DEFINES", and have "GIT-PERL-DEFINES" created and updated if
"NO_PERL=Y" is defined.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/Makefile b/Makefile
index 181dc52f152..354136e30d1 100644
--- a/Makefile
+++ b/Makefile
@@ -2288,11 +2288,21 @@ git.res: git.rc GIT-VERSION-FILE GIT-PREFIX
 	    $(shell echo $(GIT_VERSION) 0 0 0 0 | tr '.a-zA-Z-' ' '))) \
 	  -DGIT_VERSION="\\\"$(GIT_VERSION)\\\"" -i $< -o $@
 
-# This makes sure we depend on the NO_PERL setting itself.
-$(SCRIPT_PERL_GEN): GIT-BUILD-OPTIONS
-
-ifndef NO_PERL
+# Under NO_PERL=Y we'll still make GIT-PERL-DEFINES. We need to depend
+# on NO_PERL=Y itself for creating "unimplemented.sh" scripts.
 PERL_DEFINES =
+$(SCRIPT_PERL_GEN): GIT-PERL-DEFINES
+ifdef NO_PERL
+PERL_DEFINES += $(NO_PERL)
+
+$(SCRIPT_PERL_GEN) git-instaweb: % : unimplemented.sh
+	$(QUIET_GEN) \
+	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
+	    -e 's|@@REASON@@|NO_PERL=$(NO_PERL)|g' \
+	    unimplemented.sh >$@+ && \
+	chmod +x $@+ && \
+	mv $@+ $@
+else
 PERL_DEFINES += $(gitexecdir_relative_SQ)
 PERL_DEFINES += $(perllibdir_relative_SQ)
 PERL_DEFINES += $(localedir_relative_SQ)
@@ -2326,13 +2336,6 @@ $(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
 	chmod +x $@+ && \
 	mv $@+ $@
 
-GIT-PERL-DEFINES: FORCE
-	@FLAGS='$(PERL_DEFINES)'; \
-	    if test x"$$FLAGS" != x"`cat $@ 2>/dev/null`" ; then \
-		echo >&2 "    * new perl-specific parameters"; \
-		echo "$$FLAGS" >$@; \
-	    fi
-
 GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES
 	$(QUIET_GEN) \
 	INSTLIBDIR='$(perllibdir_SQ)' && \
@@ -2357,16 +2360,15 @@ git-instaweb: git-instaweb.sh GIT-SCRIPT-DEFINES
 	$(QUIET_GEN)$(cmd_munge_script) && \
 	chmod +x $@+ && \
 	mv $@+ $@
-else # NO_PERL
-$(SCRIPT_PERL_GEN) git-instaweb: % : unimplemented.sh
-	$(QUIET_GEN) \
-	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
-	    -e 's|@@REASON@@|NO_PERL=$(NO_PERL)|g' \
-	    unimplemented.sh >$@+ && \
-	chmod +x $@+ && \
-	mv $@+ $@
 endif # NO_PERL
 
+GIT-PERL-DEFINES: FORCE
+	@FLAGS='$(PERL_DEFINES)'; \
+	    if test x"$$FLAGS" != x"`cat $@ 2>/dev/null`" ; then \
+		echo >&2 "    * new perl-specific parameters"; \
+		echo "$$FLAGS" >$@; \
+	    fi
+
 # This makes sure we depend on the NO_PYTHON setting itself.
 $(SCRIPT_PYTHON_GEN): GIT-BUILD-OPTIONS
 
-- 
2.34.0.rc1.741.gab7bfd97031

